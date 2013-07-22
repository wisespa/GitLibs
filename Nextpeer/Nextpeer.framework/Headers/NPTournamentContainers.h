/* 
 This file contains the tournament containers, you can use them to get extra details on the tournament which about to start, or the one which ended.
   More over, you can use the NPTournamentCustomMessageContainer for your in-tournament custom messages.
 */


#pragma mark -
#pragma mark NPTournamentCustomMessageContainer
#pragma mark -

/**
 The NPTournamentCustomMessageContainer can be used to create custom notifications and events while engaging the other players
 that are currently playing. The container that is passed contains the sending user's name and image as well as the message being sent.
 */
@interface NPTournamentCustomMessageContainer : NSObject

/// The player name.
@property (nonatomic, readonly) NSString* playerName;

/// A unique player identifier for the current game.
@property (nonatomic, readonly) NSString* playerId;

/// The player's profile image URL.
@property (nonatomic, readonly) NSString* playerImageUrl;

/// The player image
/// @note This property can sometimes return nil, this happens if the image for the player that sent the message is unavailable.
@property (nonatomic, readonly) UIImage* playerImage;

/// Boolean value that indicates if this message came form a bot recording or a real-life player.
@property (nonatomic, readonly) BOOL playerIsBot;

/// The custom message (passed as a buffer).
@property (nonatomic, readonly) NSData* message;

@end

#pragma mark -
#pragma mark NPTournamentStartDataContainer
#pragma mark -

/**
 The NPTournamentStartDataContainer used to extract some info about the tournament which is about to be played  
 */
@interface NPTournamentStartDataContainer : NSObject 

/// The tournament UUID is provided so that your game can identify which tournament needs to be loaded.
/// You can find the UUID in the developer dashboard
@property (nonatomic, readonly) NSString* tournamentUuid;

/// The tournament display name
@property (nonatomic, readonly) NSString* tournamentName;

/// The tournament time to play in seconds
@property (nonatomic, readonly) NSUInteger tournamentTimeSeconds; 

/// A random seed generated for this tournament. All players within the same tournament
/// receive the same seed from the tournament. Can be used for level generation, to ensure
/// all players play the same level in a specific game.
@property (nonatomic, readonly) NSUInteger tournamentRandomSeed;

/// A flag that states if the current tournament is game controlled
@property (nonatomic, readonly) BOOL tournamentIsGameControlled;

/// The number of players that started this tournament. Includes the current player.
@property (nonatomic, readonly) NSUInteger numberOfPlayers;

@end

#pragma mark -
#pragma mark NPTournamentEndDataContainer
#pragma mark -

/**
 The NPTournamentEndDataContainer used to extract some info about the tournament which just ended
 */
@interface NPTournamentEndDataContainer : NSObject 

/// The tournament UUID is provided so that your game can identify which tournament needs to be loaded.
/// You can find the UUID in the developer dashboard.
@property (nonatomic, readonly) NSString* tournamentUuid;

/// The player name.
@property (nonatomic, readonly) NSString* playerName;

/// The player total currency amount (after the tournament ended of course).
@property (nonatomic, readonly) NSUInteger currentCurrencyAmount; 

/// The player rank in the tournament (where 1 means first, 1..tournamentTotalPlayers).
@property (nonatomic, readonly) NSUInteger playerRankInTournament; 

/// The amount of players in the tournament.
@property (nonatomic, readonly) NSUInteger tournamentTotalPlayers; 

/// The player's score at the end of the tournament.
@property (nonatomic, readonly) NSUInteger playerScore;

@end
