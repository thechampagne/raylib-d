import raylib;

enum int MAX_GESTURE_STRINGS = 20;

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
int main()
{
    // Initialization
    //--------------------------------------------------------------------------------------
    const int screenWidth = 800;
    const int screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "raylib [core] example - input gestures");

    Vector2 touchPosition = { 0, 0 };
    Rectangle touchArea = { 220, 10, screenWidth - 230.0f, screenHeight - 20.0f };

    int gesturesCount = 0;
    char[MAX_GESTURE_STRINGS][32] gestureStrings;

    int currentGesture = Gesture.GESTURE_NONE;
    int lastGesture = Gesture.GESTURE_NONE;

    //SetGesturesEnabled(0b0000000000001001);   // Enable only some gestures to be detected

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        lastGesture = currentGesture;
        currentGesture = GetGestureDetected();
        touchPosition = GetTouchPosition(0);

        if (CheckCollisionPointRec(touchPosition, touchArea) && (currentGesture != Gesture.GESTURE_NONE))
        {
            if (currentGesture != lastGesture)
            {
                // Store gesture string
                switch (currentGesture)
                {
                    case Gesture.GESTURE_TAP: TextCopy(gestureStrings[gesturesCount].ptr, "GESTURE TAP"); break;
                    case Gesture.GESTURE_DOUBLETAP: TextCopy(gestureStrings[gesturesCount].ptr, "GESTURE DOUBLETAP"); break;
                    case Gesture.GESTURE_HOLD: TextCopy(gestureStrings[gesturesCount].ptr, "GESTURE HOLD"); break;
                    case Gesture.GESTURE_DRAG: TextCopy(gestureStrings[gesturesCount].ptr, "GESTURE DRAG"); break;
                    case Gesture.GESTURE_SWIPE_RIGHT: TextCopy(gestureStrings[gesturesCount].ptr, "GESTURE SWIPE RIGHT"); break;
                    case Gesture.GESTURE_SWIPE_LEFT: TextCopy(gestureStrings[gesturesCount].ptr, "GESTURE SWIPE LEFT"); break;
                    case Gesture.GESTURE_SWIPE_UP: TextCopy(gestureStrings[gesturesCount].ptr, "GESTURE SWIPE UP"); break;
                    case Gesture.GESTURE_SWIPE_DOWN: TextCopy(gestureStrings[gesturesCount].ptr, "GESTURE SWIPE DOWN"); break;
                    case Gesture.GESTURE_PINCH_IN: TextCopy(gestureStrings[gesturesCount].ptr, "GESTURE PINCH IN"); break;
                    case Gesture.GESTURE_PINCH_OUT: TextCopy(gestureStrings[gesturesCount].ptr, "GESTURE PINCH OUT"); break;
                    default: break;
                }

                gesturesCount++;

                // Reset gestures strings
                if (gesturesCount >= MAX_GESTURE_STRINGS)
                {
                    for (int i = 0; i < MAX_GESTURE_STRINGS; i++) TextCopy(gestureStrings[i].ptr, "\0");

                    gesturesCount = 0;
                }
            }
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(Colors.RAYWHITE);

            DrawRectangleRec(touchArea, Colors.GRAY);
            DrawRectangle(225, 15, screenWidth - 240, screenHeight - 30, Colors.RAYWHITE);

            DrawText("GESTURES TEST AREA", screenWidth - 270, screenHeight - 40, 20, Fade(Colors.GRAY, 0.5f));

            for (int i = 0; i < gesturesCount; i++)
            {
                if (i%2 == 0) DrawRectangle(10, 30 + 20*i, 200, 20, Fade(Colors.LIGHTGRAY, 0.5f));
                else DrawRectangle(10, 30 + 20*i, 200, 20, Fade(Colors.LIGHTGRAY, 0.3f));

                if (i < gesturesCount - 1) DrawText(gestureStrings[i].ptr, 35, 36 + 20*i, 10, Colors.DARKGRAY);
                else DrawText(gestureStrings[i].ptr, 35, 36 + 20*i, 10, Colors.MAROON);
            }

            DrawRectangleLines(10, 29, 200, screenHeight - 50, Colors.GRAY);
            DrawText("DETECTED GESTURES", 50, 15, 10, Colors.GRAY);

            if (currentGesture != Gesture.GESTURE_NONE) DrawCircleV(touchPosition, 30, Colors.MAROON);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

	return 0;
}