Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F662E863F
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Jan 2021 04:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbhABDvy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Jan 2021 22:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbhABDvg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Jan 2021 22:51:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D711FC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Jan 2021 19:50:36 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id f14so6772347pju.4
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Jan 2021 19:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtMr8j5ds2cEbyaSkaeiVS7KHyC/i6vLtI3fIrYpBlw=;
        b=dunKMbvCnrbF3I8qBRCGAuNEdprTPUXcrkxTd7gF9T7tXOo96B8Yq5hEx3VSrsDucB
         qi2EOIiwRz5FQLizVjkbT7o4qnPyT8Vj9leejxbfUuyd334FPELqcbfmKW6rAfuNF936
         g4AlxY4knAuR5HL9ERok/D5ymFgl4yZg8nWYCkD7HdE0v1t7rtDcEyIMvGuXXwqduBm4
         mTbO+MsLZsCkQA7W9950aJTLUJCMfeW3AIthr/mXc5zAEmuXhyJkGMDgByJpk6vUvwDl
         A79QaIlINrL9fftRHuqcD+GC4zeRFgFmLrOEtKuXxf14u3/bl4ma8gNApEPvBxlJ3EZO
         MlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CtMr8j5ds2cEbyaSkaeiVS7KHyC/i6vLtI3fIrYpBlw=;
        b=FcCQ8Q3+ornAXyfcUOvCCIi0tnRzP9mrFy4HZ+i4apwzzKolmm6/uvkBqP/LjmYDa3
         u1NXssKP2bhWxOHQPOFBRBC8PFlz+/vyHGtVRUaTFTCL0qrDet5iWFoVTaylXNl5o3vJ
         V145DRVDCmaU89OEod76RFtTEikuUeM14j6jj2J3ZGmydBseKy58O1DmGWa1uTjshD4Y
         N21t74jtcqbkB/MyK4q2l3lp2WQH+ln1qr1W5vNNhVc4jzR2j8BOcEfCD21x+EFb6jvu
         05Ih/vHWg7oTWDrqEB9E7eN2jXZmQwHsxvTRDa+UtgbbmYxxIQ425aFqBaRDrCuFm9uy
         V9iA==
X-Gm-Message-State: AOAM533x8u00ohrfAm1eEg5ufD4C3E+9qnG6yP+Fx7cHQ4xOn6xzGeSx
        cjdv5ojkevZ3ZaVoOUey8/8=
X-Google-Smtp-Source: ABdhPJxdlLAtj1lYkEcSACuV+0/sB/PFGJAGWImbtiO9UbrtYqNKuj0Uo8ujVLUvyhSgcY7VGa/96Q==
X-Received: by 2002:a17:902:bb95:b029:dc:e7b:fd6e with SMTP id m21-20020a170902bb95b02900dc0e7bfd6emr63197474pls.12.1609559436333;
        Fri, 01 Jan 2021 19:50:36 -0800 (PST)
Received: from localhost.localdomain (S010664777d4a88b3.cg.shawcable.net. [70.77.224.58])
        by smtp.gmail.com with ESMTPSA id x15sm49823522pfa.80.2021.01.01.19.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 19:50:35 -0800 (PST)
Sender: Sheng Mao <ks8xntk9mds5i@gmail.com>
From:   shngmao@gmail.com
To:     wangyugui@e16-tech.com
Cc:     linux-btrfs@vger.kernel.org, Sheng Mao <shngmao@gmail.com>
Subject: [PATCH v2 3/3] btrfs-progs: add TLS arguments to send/receive
Date:   Fri,  1 Jan 2021 20:49:57 -0700
Message-Id: <20210102034957.2825531-3-shngmao@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210102034957.2825531-1-shngmao@gmail.com>
References: <20210101135350.AD49.409509F4@e16-tech.com>
 <20210102034957.2825531-1-shngmao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sheng Mao <shngmao@gmail.com>

If TLS is enabled, btrfs send/receive can accept four more
arguments:

- address to connect to/listen on
- port to connect to/listen on
- keyfile name (optional), PEM format is preferred
- TLS mode: none, TLS 1.2/1.3 and 128/256 GCM

In TLS mode, btrfs receive assumes -e and btrfs receive
stops after receiving an end cmd marker in the stream.

Issue: #326
Signed-off-by: Sheng Mao <shngmao@gmail.com>
---
 Documentation/btrfs-receive.asciidoc |  13 +++
 Documentation/btrfs-send.asciidoc    |   9 ++
 cmds/receive.c                       | 153 ++++++++++++++++++++++----
 cmds/send.c                          | 155 +++++++++++++++++++++++----
 4 files changed, 292 insertions(+), 38 deletions(-)

diff --git a/Documentation/btrfs-receive.asciidoc b/Documentation/btrfs-receive.asciidoc
index e4c4d2c0..7d98e41a 100644
--- a/Documentation/btrfs-receive.asciidoc
+++ b/Documentation/btrfs-receive.asciidoc
@@ -38,6 +38,19 @@ A subvolume is made read-only after the receiving process finishes successfully
 -f <FILE>::
 read the stream from <FILE> instead of stdin,
 
+--listen-addr <url>::
+Address to listen on. It can be an IP address or a domain name.
+
+--tcp-port <port>::
+The local port of the TLS connection.
+
+--tls-key <file>::
+Use the key from file; otherwise read key from stdin. Key file is first parsed
+as PEM format; if parsing fails, file content is treated as binary key.
+
+--tls-mode <mode>::
+Use none, tls_12_128_gcm, tls_13_128_gcm, tls_12_256_gcm.
+
 -C|--chroot::
 confine the process to 'path' using `chroot`(1)
 
diff --git a/Documentation/btrfs-send.asciidoc b/Documentation/btrfs-send.asciidoc
index c4a05672..3a270c78 100644
--- a/Documentation/btrfs-send.asciidoc
+++ b/Documentation/btrfs-send.asciidoc
@@ -49,6 +49,15 @@ use this snapshot as a clone source for an incremental send (multiple allowed)
 -f <outfile>::
 output is normally written to standard output so it can be, for example, piped
 to btrfs receive. Use this option to write it to a file instead.
+--conn-addr <url>::
+Address of remote receiver. It can be an IP address or a domain name.
+--tcp-port <port>::
+The remote port of the TLS connection.
+--tls-key <file>::
+Use the key from file; otherwise read key from stdin. Key file is first parsed
+as PEM format; if parsing fails, file content is treated as binary key.
+--tls-mode <mode>::
+Use none, tls_12_128_gcm, tls_13_128_gcm, tls_12_256_gcm.
 --no-data::
 send in 'NO_FILE_DATA' mode
 +
diff --git a/cmds/receive.c b/cmds/receive.c
index 2aaba3ff..eb140b55 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -53,8 +53,11 @@
 #include "common/help.h"
 #include "common/path-utils.h"
 
-struct btrfs_receive
-{
+#if KTLS_SEND_RECV == 1
+#include "common/ktls.h"
+#endif
+
+struct btrfs_receive {
 	int mnt_fd;
 	int dest_dir_fd;
 
@@ -1216,7 +1219,7 @@ out:
 	return ret;
 }
 
-static const char * const cmd_receive_usage[] = {
+static const char *const cmd_receive_usage[] = {
 	"btrfs receive [options] <mount>\n"
 	"btrfs receive --dump [options]",
 	"Receive subvolumes from a stream",
@@ -1229,22 +1232,28 @@ static const char * const cmd_receive_usage[] = {
 	"After receiving a subvolume, it is immediately set to",
 	"read-only.",
 	"",
-	"-q|--quiet       suppress all messages, except errors",
-	"-f FILE          read the stream from FILE instead of stdin",
-	"-e               terminate after receiving an <end cmd> marker in the stream.",
-	"                 Without this option the receiver side terminates only in case",
-	"                 of an error on end of file.",
-	"-C|--chroot      confine the process to <mount> using chroot",
+	"-q|--quiet        suppress all messages, except errors",
+	"-f FILE           read the stream from FILE instead of stdin",
+#if KTLS_SEND_RECV == 1
+	"--listen-addr <url>   Address to listen on for incoming TLS connection.",
+	"--tcp-port <port>     The remote port of the TLS connection",
+	"--tls-key <file>      Use the key from file; otherwise read key from stdin.",
+	"--tls-mode <mode>     Use none, tls_12_128_gcm, tls_13_128_gcm, tls_12_256_gcm."
+#endif
+	"-e                terminate after receiving an <end cmd> marker in the stream.",
+	"                  Without this option the receiver side terminates only in case",
+	"                  of an error on end of file.",
+	"-C|--chroot       confine the process to <mount> using chroot",
 	"-E|--max-errors NERR",
-	"                 terminate as soon as NERR errors occur while",
-	"                 stream processing commands from the stream.",
-	"                 Default value is 1. A value of 0 means no limit.",
-	"-m ROOTMOUNT     the root mount point of the destination filesystem.",
-	"                 If /proc is not accessible, use this to tell us where",
-	"                 this file system is mounted.",
-	"--dump           dump stream metadata, one line per operation,",
-	"                 does not require the MOUNT parameter",
-	"-v               deprecated, alias for global -v option",
+	"                  terminate as soon as NERR errors occur while",
+	"                  stream processing commands from the stream.",
+	"                  Default value is 1. A value of 0 means no limit.",
+	"-m ROOTMOUNT      the root mount point of the destination filesystem.",
+	"                  If /proc is not accessible, use this to tell us where",
+	"                  this file system is mounted.",
+	"--dump            dump stream metadata, one line per operation,",
+	"                  does not require the MOUNT parameter",
+	"-v                deprecated, alias for global -v option",
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
 	HELPINFO_INSERT_QUIET,
@@ -1261,6 +1270,23 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 	u64 max_errors = 1;
 	int dump = 0;
 	int ret = 0;
+#if KTLS_SEND_RECV == 1
+	enum {
+		KTLS_IDX_ADDR = 0,
+		KTLS_IDX_PORT = 1,
+		KTLS_IDX_KEY = 2,
+		KTLS_IDX_TLS_MODE = 3,
+		KTLS_IDX_SIZE
+	};
+	char *ktls_args[KTLS_IDX_SIZE];
+	struct ktls_session *ktls_session = NULL;
+	char ktls_username[LOGIN_NAME_MAX] = "btrfs";
+	u32 i = 0;
+	size_t arg_len = 0;
+	int arg_idx = 0;
+
+	explicit_bzero(ktls_args, sizeof(ktls_args));
+#endif
 
 	memset(&rctx, 0, sizeof(rctx));
 	rctx.mnt_fd = -1;
@@ -1285,10 +1311,25 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 	optind = 0;
 	while (1) {
 		int c;
-		enum { GETOPT_VAL_DUMP = 257 };
+		enum {
+			GETOPT_VAL_DUMP = 257,
+			GETOPT_VAL_ADDR = 300,
+			GETOPT_VAL_PORT = 301,
+			GETOPT_VAL_KEY = 302,
+			GETOPT_VAL_TLS_MODE = 303,
+		};
 		static const struct option long_opts[] = {
 			{ "max-errors", required_argument, NULL, 'E' },
 			{ "chroot", no_argument, NULL, 'C' },
+#if KTLS_SEND_RECV == 1
+			{ "listen-addr", required_argument, NULL,
+			  GETOPT_VAL_ADDR },
+			{ "tcp-port", required_argument, NULL,
+			  GETOPT_VAL_PORT },
+			{ "tls-key", required_argument, NULL, GETOPT_VAL_KEY },
+			{ "tls-mode", required_argument, NULL,
+			  GETOPT_VAL_TLS_MODE },
+#endif
 			{ "dump", no_argument, NULL, GETOPT_VAL_DUMP },
 			{ "quiet", no_argument, NULL, 'q' },
 			{ NULL, 0, NULL, 0 }
@@ -1330,6 +1371,27 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 				goto out;
 			}
 			break;
+#if KTLS_SEND_RECV == 1
+		case GETOPT_VAL_ADDR:
+		case GETOPT_VAL_PORT:
+		case GETOPT_VAL_KEY:
+		case GETOPT_VAL_TLS_MODE:
+			arg_len = strlen(optarg);
+			arg_idx = c - GETOPT_VAL_ADDR;
+			ktls_args[arg_idx] = (char *)malloc(arg_len + 1);
+			if (!ktls_args[arg_idx]) {
+				error("fail to allocate buffer (%zu)", arg_len);
+				ret = 1;
+				goto out;
+			}
+			if (arg_copy_path(ktls_args[arg_idx], optarg,
+					  arg_len + 1)) {
+				error("argument too long (%zu)", arg_len);
+				ret = 1;
+				goto out;
+			}
+			break;
+#endif
 		case GETOPT_VAL_DUMP:
 			dump = 1;
 			break;
@@ -1353,6 +1415,50 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 		}
 	}
 
+#if KTLS_SEND_RECV == 1
+	if (ktls_args[KTLS_IDX_ADDR]) {
+		if (fromfile[0]) {
+			error("cannot send to both ktls and file");
+			ret = 1;
+			goto out;
+		}
+
+		if (!ktls_args[KTLS_IDX_PORT]) {
+			error("no remote ktls port");
+			ret = 1;
+			goto out;
+		}
+
+		ktls_session = ktls_create_session(false);
+
+		if (ktls_args[KTLS_IDX_TLS_MODE]) {
+			if (ktls_set_tls_mode(ktls_session,
+					      ktls_args[KTLS_IDX_TLS_MODE]))
+				goto out;
+		}
+
+		if (ktls_args[KTLS_IDX_KEY]) {
+			if (ktls_set_psk_session_from_keyfile(
+				    ktls_session, ktls_username,
+				    ktls_args[KTLS_IDX_KEY])) {
+				goto out;
+			};
+		} else {
+			if (ktls_set_psk_session_from_password_prompt(
+				    ktls_session, ktls_username)) {
+				goto out;
+			}
+		}
+
+		receive_fd = ktls_create_sock_oneshot(ktls_session,
+						      ktls_args[KTLS_IDX_ADDR],
+						      ktls_args[KTLS_IDX_PORT]);
+
+		/* socket implies honor end cmd*/
+		rctx.honor_end_cmd = 1;
+	}
+#endif
+
 	if (dump) {
 		struct btrfs_dump_send_args dump_args;
 
@@ -1370,9 +1476,16 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 		ret = do_receive(&rctx, tomnt, realmnt, receive_fd, max_errors);
 	}
 
+out:
+#if KTLS_SEND_RECV == 1
+	for (i = KTLS_IDX_ADDR; i < KTLS_IDX_SIZE; i++) {
+		if (ktls_args[i])
+			free(ktls_args[i]);
+	}
+	ktls_destroy_session(ktls_session);
+#endif
 	if (receive_fd != fileno(stdin))
 		close(receive_fd);
-out:
 
 	return !!ret;
 }
diff --git a/cmds/send.c b/cmds/send.c
index b8e3ba12..006eb3cc 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -46,6 +46,10 @@
 #include "common/help.h"
 #include "common/path-utils.h"
 
+#if KTLS_SEND_RECV == 1
+#include "common/ktls.h"
+#endif
+
 #define SEND_BUFFER_SIZE	SZ_64K
 
 
@@ -424,7 +428,7 @@ static void free_send_info(struct btrfs_send *sctx)
 	subvol_uuid_search_finit(&sctx->sus);
 }
 
-static const char * const cmd_send_usage[] = {
+static const char *const cmd_send_usage[] = {
 	"btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]",
 	"Send the subvolume(s) to stdout.",
 	"Sends the subvolume(s) specified by <subvol> to stdout.",
@@ -439,21 +443,27 @@ static const char * const cmd_send_usage[] = {
 	"which case 'btrfs send' will determine a suitable parent among the",
 	"clone sources itself.",
 	"",
-	"-e               If sending multiple subvols at once, use the new",
-	"                 format and omit the end-cmd between the subvols.",
-	"-p <parent>      Send an incremental stream from <parent> to",
-	"                 <subvol>.",
-	"-c <clone-src>   Use this snapshot as a clone source for an ",
-	"                 incremental send (multiple allowed)",
-	"-f <outfile>     Output is normally written to stdout. To write to",
-	"                 a file, use this option. An alternative would be to",
-	"                 use pipes.",
-	"--no-data        send in NO_FILE_DATA mode, Note: the output stream",
-	"                 does not contain any file data and thus cannot be used",
-	"                 to transfer changes. This mode is faster and useful to",
-	"                 show the differences in metadata.",
-	"-v|--verbose     deprecated, alias for global -v option",
-	"-q|--quiet       deprecated, alias for global -q option",
+	"-e                If sending multiple subvols at once, use the new",
+	"                  format and omit the end-cmd between the subvols.",
+	"-p <parent>       Send an incremental stream from <parent> to",
+	"                  <subvol>.",
+	"-c <clone-src>    Use this snapshot as a clone source for an ",
+	"                  incremental send (multiple allowed)",
+	"-f <outfile>      Output is normally written to stdout. To write to",
+	"                  a file, use this option. An alternative would be to",
+	"                  use pipes.",
+#if KTLS_SEND_RECV == 1
+	"--conn-addr <url>     Address of remote receiver.",
+	"--tcp-port <port>     The remote port of the TLS connection",
+	"--tls-key <file>      Use the key from file; otherwise read key from stdin.",
+	"--tls-mode <mode>     Use none, tls_12_128_gcm, tls_13_128_gcm, tls_12_256_gcm."
+#endif
+	"--no-data         send in NO_FILE_DATA mode, Note: the output stream",
+	"                  does not contain any file data and thus cannot be used",
+	"                  to transfer changes. This mode is faster and useful to",
+	"                  show the differences in metadata.",
+	"-v|--verbose      deprecated, alias for global -v option",
+	"-q|--quiet        deprecated, alias for global -q option",
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
 	HELPINFO_INSERT_QUIET,
@@ -474,6 +484,22 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 	int full_send = 1;
 	int new_end_cmd_semantic = 0;
 	u64 send_flags = 0;
+#if KTLS_SEND_RECV == 1
+	enum {
+		KTLS_IDX_ADDR = 0,
+		KTLS_IDX_PORT = 1,
+		KTLS_IDX_KEY = 2,
+		KTLS_IDX_TLS_MODE = 3,
+		KTLS_IDX_SIZE
+	};
+	char *ktls_args[KTLS_IDX_SIZE];
+	struct ktls_session *ktls_session = NULL;
+	char ktls_username[LOGIN_NAME_MAX] = "btrfs";
+	size_t arg_len = 0;
+	int arg_idx = 0;
+
+	explicit_bzero(ktls_args, sizeof(ktls_args));
+#endif
 
 	memset(&send, 0, sizeof(send));
 	send.dump_fd = fileno(stdout);
@@ -492,11 +518,26 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 
 	optind = 0;
 	while (1) {
-		enum { GETOPT_VAL_SEND_NO_DATA = 256 };
+		enum {
+			GETOPT_VAL_SEND_NO_DATA = 256,
+			GETOPT_VAL_ADDR = 300,
+			GETOPT_VAL_PORT = 301,
+			GETOPT_VAL_KEY = 302,
+			GETOPT_VAL_TLS_MODE = 303,
+		};
 		static const struct option long_options[] = {
 			{ "verbose", no_argument, NULL, 'v' },
 			{ "quiet", no_argument, NULL, 'q' },
-			{ "no-data", no_argument, NULL, GETOPT_VAL_SEND_NO_DATA }
+			{ "no-data", no_argument, NULL,
+			  GETOPT_VAL_SEND_NO_DATA },
+			{ "conn-addr", required_argument, NULL,
+			  GETOPT_VAL_ADDR },
+			{ "tcp-port", required_argument, NULL,
+			  GETOPT_VAL_PORT },
+			{ "tls-key", required_argument, NULL, GETOPT_VAL_KEY },
+			{ "tls-mode", required_argument, NULL,
+			  GETOPT_VAL_TLS_MODE },
+			{ NULL, 0, NULL, 0 }
 		};
 		int c = getopt_long(argc, argv, "vqec:f:i:p:", long_options, NULL);
 
@@ -581,6 +622,27 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 			error("option -i was removed, use -c instead");
 			ret = 1;
 			goto out;
+#if KTLS_SEND_RECV == 1
+		case GETOPT_VAL_ADDR:
+		case GETOPT_VAL_PORT:
+		case GETOPT_VAL_KEY:
+		case GETOPT_VAL_TLS_MODE:
+			arg_len = strlen(optarg);
+			arg_idx = c - GETOPT_VAL_ADDR;
+			ktls_args[arg_idx] = (char *)malloc(arg_len + 1);
+			if (!ktls_args[arg_idx]) {
+				error("fail to allocate buffer (%zu)", arg_len);
+				ret = 1;
+				goto out;
+			}
+			if (arg_copy_path(ktls_args[arg_idx], optarg,
+					  arg_len + 1)) {
+				error("argument too long (%zu)", arg_len);
+				ret = 1;
+				goto out;
+			}
+			break;
+#endif
 		case GETOPT_VAL_SEND_NO_DATA:
 			send_flags |= BTRFS_SEND_FLAG_NO_FILE_DATA;
 			break;
@@ -613,6 +675,53 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 			goto out;
 		}
 	}
+#if KTLS_SEND_RECV == 1
+	if (ktls_args[KTLS_IDX_ADDR]) {
+		if (outname[0]) {
+			error("cannot send to both ktls and file");
+			ret = 1;
+			goto out;
+		}
+
+		if (!ktls_args[KTLS_IDX_PORT]) {
+			error("no remote ktls port");
+			ret = 1;
+			goto out;
+		}
+
+		if (!ktls_args[KTLS_IDX_PORT]) {
+			error("fail to create ktls session");
+			ret = 1;
+			goto out;
+		}
+
+		ktls_session = ktls_create_session(true);
+
+		if (ktls_args[KTLS_IDX_TLS_MODE]) {
+			if (ktls_set_tls_mode(ktls_session,
+					      ktls_args[KTLS_IDX_TLS_MODE]))
+				goto out;
+		}
+
+		if (ktls_args[KTLS_IDX_KEY]) {
+			if (ktls_set_psk_session_from_keyfile(
+				    ktls_session, ktls_username,
+				    ktls_args[KTLS_IDX_KEY])) {
+				goto out;
+			};
+		} else {
+			if (ktls_set_psk_session_from_password_prompt(
+				    ktls_session, ktls_username)) {
+				goto out;
+			}
+		}
+
+		send.dump_fd =
+			ktls_create_sock_oneshot(ktls_session,
+						 ktls_args[KTLS_IDX_ADDR],
+						 ktls_args[KTLS_IDX_PORT]);
+	}
+#endif
 
 	if (isatty(send.dump_fd)) {
 		error(
@@ -755,6 +864,16 @@ out:
 	free(snapshot_parent);
 	free(send.clone_sources);
 	free_send_info(&send);
+#if KTLS_SEND_RECV == 1
+	for (i = KTLS_IDX_ADDR; i < KTLS_IDX_SIZE; i++) {
+		if (ktls_args[i])
+			free(ktls_args[i]);
+	}
+	ktls_destroy_session(ktls_session);
+#endif
+	if (send.dump_fd != fileno(stdin))
+		close(send.dump_fd);
+
 	return !!ret;
 }
 DEFINE_SIMPLE_COMMAND(send, "send");
-- 
2.29.2

