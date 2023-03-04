<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wordpress' );

/** Database password */
define( 'DB_PASSWORD', 'Vagrant@123' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '+GHrW+HU|z+Z!k7wP|jYgzDp|IH%`MNg8fr=dad[gVFP;yp*`:CLhh6M50vXk-R-');
define('SECURE_AUTH_KEY',  'cj7MpMIinxbbB9E{Gl,<f,YL]-~1jC,@gd{sInxP)bGBIiMC&J =SNzVWI*0|Y!S');
define('LOGGED_IN_KEY',    'uy[7|,t-CfphKAt=U1dSYO!o8H,tmG.IGF3i,3-}%*Sr$>=B2_Fn@<R.QS7K[K_Z');
define('NONCE_KEY',        'F|B+tVt=d%:+s9k:L&K0-KD-<kA1~u9|v?QD{sn/G&+c=R++QV(`B:rB+pR5S;v=');
define('AUTH_SALT',        'MT~KXZ,emdE65,|V4[:gAXx=Mhl[|F=@nFr:F^+46*<-Vq0AalHqKk-Fc@XV72LM');
define('SECURE_AUTH_SALT', 'Thx2sNiP{-1|T mFSdk;i#I#BXm^+BbZ >YK+:,k.Y857YE#}|CfLy|zQk&byJOB');
define('LOGGED_IN_SALT',   'uN|>NJSzQcz0X5d+@-|)#]G+7&K+w.%i<Fk5H>_Z=:o37]9x7D`f?%>Q3iI6EJ~w');
define('NONCE_SALT',       'Kjq>v_$)%y|U)6Y+VLo25kRBY8WixEI,08y=0[FC,F?PJ![~N06bjMHGe>V]&ABD');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
