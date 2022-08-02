import raylib;

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
int main()
{
    // Initialization
    //--------------------------------------------------------------------------------------
    const int screenWidth = 800;
    const int screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "raylib [core] example - mouse input");

    Vector2 ballPosition = { -100.0f, -100.0f };
    Color ballColor = Colors.DARKBLUE;

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //---------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        ballPosition = GetMousePosition();

        if (IsMouseButtonPressed(MouseButton.MOUSE_BUTTON_LEFT)) ballColor = Colors.MAROON;
        else if (IsMouseButtonPressed(MouseButton.MOUSE_BUTTON_MIDDLE)) ballColor = Colors.LIME;
        else if (IsMouseButtonPressed(MouseButton.MOUSE_BUTTON_RIGHT)) ballColor = Colors.DARKBLUE;
        else if (IsMouseButtonPressed(MouseButton.MOUSE_BUTTON_SIDE)) ballColor = Colors.PURPLE;
        else if (IsMouseButtonPressed(MouseButton.MOUSE_BUTTON_EXTRA)) ballColor = Colors.YELLOW;
        else if (IsMouseButtonPressed(MouseButton.MOUSE_BUTTON_FORWARD)) ballColor = Colors.ORANGE;
        else if (IsMouseButtonPressed(MouseButton.MOUSE_BUTTON_BACK)) ballColor = Colors.BEIGE;
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(Colors.RAYWHITE);

            DrawCircleV(ballPosition, 40, ballColor);

            DrawText("move ball with mouse and click mouse button to change color", 10, 10, 20, Colors.DARKGRAY);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

    return 0;
}