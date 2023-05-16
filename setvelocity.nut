IncludeScript("dr_gooby_neo/vs_library");
printl(" ______   _______  _______  _______  __   __  ______    __   __  __    _ ");
printl("|      | |       ||   _   ||       ||  | |  ||    _ |  |  | |  ||  |  | |");
printl("|  _    ||    ___||  |_|  ||_     _||  |_|  ||   | ||  |  | |  ||   |_| |");
printl("| | |   ||   |___ |       |  |   |  |       ||   |_||_ |  |_|  ||       |");
printl("| |_|   ||    ___||       |  |   |  |       ||    __  ||       ||  _    |");
printl("|       ||   |___ |   _   |  |   |  |   _   ||   |  | ||       || | |   |");
printl("|______| |_______||__| |__|  |___|  |__| |__||___|  |_||_______||_|  |__|");
printl(" _______  __   __                                                        ");
printl("|  _    ||  | |  |                                                       ");
printl("| |_|   ||  |_|  |                                                       ");
printl("|       ||       |                                                       ");
printl("|  _   | |_     _|                                                       ");
printl("| |_|   |  |   |                                                         ");
printl("|_______|  |___|                                                         ");
printl(" __    _  _______  _______                                               ");
printl("|  |  | ||       ||       |                                              ");
printl("|   |_| ||    ___||   _   |                                              ");
printl("|       ||   |___ |  | |  |                                              ");
printl("|  _    ||    ___||  |_|  |                                              ");
printl("| | |   ||   |___ |       |                                              ");
printl("|_|  |__||_______||_______|                                              ");
printl("SHOUTOUT BRAXI , KEPLYX , SQUINK <3<3");

function boostXYZ( x, y, z ){

    if (x == 0)
        x = activator.GetVelocity().x;
    else
        x = x + activator.GetVelocity().x;
    if (y == 0)
        y = activator.GetVelocity().y;
    else
        y = y + activator.GetVelocity().y;
    if (z == 0)
        z = activator.GetVelocity().z;
    else
        z = z + activator.GetVelocity().z;
        
    activator.SetVelocity(Vector(x, y, z));
}

function bounceXYZ( x, y, z ){

    if (x == 0)
        x = activator.GetVelocity().x;
    if (y == 0)
        y = activator.GetVelocity().y;
    if (z == 0)
        z = activator.GetVelocity().z;
        
    activator.SetVelocity(Vector(x, y, z));
}


function relBounceXYZ( x, y, z){
	co <- caller.GetOrigin();
	if(checkAcceptableAngles()){
		if (x == 0){
			x = activator.GetVelocity().x;
		}
		else{
			x =  -activator.GetVelocity().x;
		}
		if (y == 0){
			y = activator.GetVelocity().y;
		}
		else{
			y = -activator.GetVelocity().y;
		}
		if (z == 0){
			z = activator.GetVelocity().z;
		}
		else{
			z = -activator.GetVelocity().z;
		}
		
		activator.SetVelocity(Vector(x, y, z));
	}
}

function RelBounceXYZ( x, y, z){
	co <- caller.GetOrigin();
	if(checkAcceptableAngles()){
		if (x == 0){
			x = activator.GetVelocity().x;
		}
		else{
			x =  -activator.GetVelocity().x;
		}
		if (y == 0){
			y = activator.GetVelocity().y;
		}
		else{
			y = -activator.GetVelocity().y;
		}
		if (z == 0){
			z = activator.GetVelocity().z;
		}
		else{
			z = -activator.GetVelocity().z;
		}
		
		activator.SetVelocity(Vector(x, y, z));
	}
}


function checkAcceptableAngles(){
	//printl("start");
	local vx = activator.GetVelocity().x;
	local vy = activator.GetVelocity().y;
	local vz = activator.GetVelocity().z;

	
	//printl("X: " + vx + " Y: " + vy + " Z : " + vz);
	local horizontalVelocity = calculateSquareRoot(vx*vx + vy*vy);
	//printl("HV:" + horizontalVelocity);
	local angleInRadians = calculateTangent(vz / horizontalVelocity);
	local angleInDegrees = radiansToDegrees(angleInRadians);
	
	//printl(angleInDegrees + "D");
	
	if(angleInDegrees < 0){
		angleInDegrees = -angleInDegrees;
	}
	
	if(angleInDegrees > 360){
		angleInDegrees = angleInDegrees % 360;
	}
	
	//printl(angleInRadians + "R");
	//printl(angleInDegrees + "D");
	
	
	/*if(checkAcceptableYaw()){
		printl("g yaw");
	}else{
		printl("bad yaw");
	}*/
	
	if(angleInDegrees > 60 && angleInDegrees < 180 && checkAcceptableYaw()){
		//printl("bounce success");
		return true;
	}
	//printl("bounce failed (not within 40 and 140)");
	return false;

}

function checkAcceptableYaw(){
	if(true){
		return true;
	}
    const DEG2RAD = 0.0174532925;

	local ANGLE_RANGE = 70.0;

    // Get the player's viewing angles
    local playerAngles = activator.GetAngles();

    // Calculate the player's forward vector
    local playerForward = Vector(
        sin(playerAngles.y * DEG2RAD),
        cos(playerAngles.y * DEG2RAD),
        0
    );

    // Get the vector from the player's position to the trigger's position
    local triggerVector = co - activator.GetOrigin();

    // Normalize the x and y components of the vectors
    playerForward.z = 0;
    triggerVector.z = 0;
    playerForward.Norm();
    triggerVector.Norm();

    // Calculate the angle between the player's forward vector and the trigger's forward vector
    local angleDiff = abs(VS.AngleDiff(playerAngles.y, caller.GetAngles().y));

    // If the player is looking straight ahead of the ramp and not too far to the left or right
    local angleThreshold = ANGLE_RANGE / 2; // divide by 2 to get half of the range
    if (angleDiff <= angleThreshold)
    {
        return true;
    }
    else // Otherwise, the player is not looking straight ahead of the ramp
    {
		printl(angleDiff + " > " + angleThreshold);
        return false;
    }
}

function calculateSquareRoot(number) {
    if (number <= 0) {
        return 0;
    }

    local x = number / 2;
    local y = 0;
    while (x != y) {
        y = x;
        x = (x + number / x) / 2;
    }
    return x;
}

function calculateTangent(angle) {
    local sine = angle;
    local cosine = 1;
    local term = angle;
    local output = angle;

    for (local i = 3; term != 0; i += 2) {
        term *= (-1 * angle * angle) / ((i - 1) * i);
        output += term;
    }

    return sine / cosine;
}

function radiansToDegrees(radians) {
    local pi = 3.14159;
    local degrees = radians * (180 / pi);
    return degrees;
}