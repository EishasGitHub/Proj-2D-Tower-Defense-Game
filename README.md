# 2D Tower Defense Game

A strategic tower defense game built in Godot 4, where players must defend their castle from waves of enemies using strategically placed towers.

## Gameplay Instructions

### Objective
Defend your castle from incoming enemy waves by strategically placing towers along their path. The game ends when your castle's health reaches zero.

### How to Play

#### **Tower Placement**
1. **Select Tower Type**: Click on the Green Tank ($50) or Red Tank ($100) buttons in the bottom-left inventory panel
2. **Drag & Drop**: Click and drag the selected tower to your desired location
3. **Valid Placement**: Towers can only be placed in open areas (not on enemy paths or blocked zones)
4. **Cost Management**: Ensure you have enough gold before purchasing towers

#### **Resource Management**
- **Starting Gold**: 100 coins
- **Earn Gold**: Destroy enemies to gain additional funds

#### **Defense Strategy**
- **Green Tanks**: Cheaper, good for early waves and chokepoints
- **Red Tanks**: More expensive, slow projectile but higher damage
- **Path Blocking**: Use terrain and tower placement to maximize enemy exposure
- **Castle Protection**: Monitor your castle health in the top HUD

#### **Wave System**
- Enemies spawn in waves
- Each wave contains multiple enemies following the 2D path
- Prepare defenses between waves

### **Win/Lose Conditions**
- **Victory**: Survive all enemy waves
- **Defeat**: Castle health reaches zero

### **Controls**
- **Mouse**: Click and drag for tower placement
- **ESC**: Pause game
- **UI Buttons**: Tower selection and game controls

---

## Team Reflections

### Team Member 1: Enemy Functionality and Tower Systems

**Role**: Implemented core gameplay mechanics including enemy AI, pathfinding, and tower combat systems.

#### **Key Contributions:**
- **Enemy Functionality**: Developed enemy spawning system, AI behavior, and wave management
- **2D Pathfinding**: Implemented Path2D and PathFollow2D for smooth enemy movement along predetermined routes
- **Tower Combat System**: Created tower targeting, shooting mechanics, and damage calculations
- **GameManager Integration**: Built resource management and game state handling

#### **Technical Challenges Overcome:**
1. **Pathfinding Optimization**: Initially faced performance issues with multiple enemies pathfinding simultaneously. Solved by implementing efficient Path2D following with optimized update cycles.

2. **Tower Targeting Logic**: Creating smart tower AI that prioritizes targets effectively. Implemented range detection, closest-enemy targeting, and smooth rotation mechanics.

3. **Wave Spawning Balance**: Balancing enemy spawn rates and difficulty progression required extensive playtesting and parameter tweaking.

#### **Learning Outcomes:**
- Mastered Godot's Path2D system for smooth enemy movement
- Gained experience in game balance and difficulty curve design
- Improved understanding of performance optimization in real-time games
- Learned to implement complex AI behaviors using state machines

#### **Code Architecture Insights:**
The enemy system uses a modular approach where each enemy type inherits from a base Enemy class, making it easy to add new enemy variants. The tower system employs a similar pattern, allowing for diverse tower behaviors while maintaining clean, reusable code.

---

### Team Member 2: UI & Game Management, and Inventory

**Role**: Designed and implemented all user interface elements, game state management, and user experience systems.

#### **Key Contributions:**
- **Tower Inventory System**: Created intuitive drag-and-drop tower placement interface
- **HUD Design**: Developed comprehensive heads-up display showing gold, lives, and wave information
- **Menu Systems**: Built main menu, pause menu, and game over screens
- **Game Management**: Implemented core game state management including pause system, scene transitions, and game flow control
- **Visual Polish**: Applied consistent styling and visual feedback throughout the game

#### **Technical Challenges Overcome:**
1. **Drag-and-Drop Implementation**: Creating smooth, responsive drag-and-drop mechanics that work seamlessly with the game world coordinate system.

2. **Game State Management**: Implementing a robust GameManager that handles all game states, resource management, and scene transitions. Created a centralized system for pause functionality, scene switching, and persistent game data.

3. **UI Layering**: Ensuring UI elements render in correct order while maintaining proper input priority. Implemented using multiple CanvasLayers with appropriate z-indexing.

4. **Collision Detection for Placement**: Integrating UI placement system with game world collision detection to prevent tower placement in invalid areas. Achieved through physics queries and collision mask filtering.

5. **Cross-Scene Communication**: Establishing reliable communication between different game scenes through the GameManager, ensuring smooth transitions and state persistence across menu, gameplay, and game over screens.

#### **Learning Outcomes:**
- Mastered Godot's UI system including Control nodes, CanvasLayers, and anchoring
- Learned Drag & Drop feature that was used in tower inventory
- Gained expertise in singleton pattern implementation for global game state management
- Learned advanced scene management and transition techniques
- Developed skills in signal-based architecture for loose coupling between systems
- Gained expertise in user experience design for real-time strategy games
- Learned advanced styling techniques using StyleBoxFlat and theme overrides
- Developed skills in visual feedback and animation for enhanced user interaction
- Mastered pause system implementation with proper process mode handling