Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6771E4B15F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbiBJTKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343779AbiBJTKz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:55 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5421167
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:55 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c8-20020a17090a674800b001b91184b732so7102948pjm.5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvH9YH3AqTiu/HcE5RzvQWatUscSaTIgtqPCAgFEWSI=;
        b=ofsW+Oolvpt6cLEe00b3a3hMdaVB4M+doskl9Qd7KmOW+/7kyrG1kLBaqSd20kHP+C
         RbI37vjTGVT7kAGNRBlBvaUg8UEnLADla+BfhFCdyvp1QRgABTL33Ex7vey0be91WGtB
         en2W13cSNN0PT26msym443UHNmkKTq3gTCE9WQ5gGCaoVqWBg4yO+U5uFddDbQjJCrWD
         KVOmWIOYyku2+iThQoWGluNry1IDDKW+aQ7fWhcuDiXn2Q3VH5I0b7IIR4jiLbpFAsts
         v+LKtl5eZW24f6sVqVSywVwApAZ+dqaHJeQD1HCfH8WigmcT1aIx13ciZr2n6rGE6zZ9
         YOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvH9YH3AqTiu/HcE5RzvQWatUscSaTIgtqPCAgFEWSI=;
        b=whOyMKsK4ICvfgSd7sQsFYWj+KWnjioRzc4OYr6Ban/q/qv8RxjKTvxitxDrPjuIpr
         RFOF7UD2JFSW9i887gYL/B8a+02GD5XYnoUKr/BWIXRJz7pDxf3Z5gcrp2UMxxMFGSIi
         TqQSwFTS7sCTfrmvNQYe6za1M3glSTzdKB6YWg752NlmQ3wTK16H5qbObf8RrFcq0rM6
         UBtcTHyYJtcYG5y/oKQ7FBz4N2wnkP7Mrh7zcPxyD2TBh+XOcOcQy2beKx8eFiIvLAGJ
         aOzroO7+B+WdbRhaJa/WlXO+LtMRnXoCWHfPNy0Lm7lzOgJFpCqeM/dH1TV/AKDTOPZI
         a/HA==
X-Gm-Message-State: AOAM531JPvmPOvdwMzBL6Kd8jx9OfkjQzqszghGvYfvPGWDXTjqlcIg4
        9PeSCBi3wQ7mCDaiHrym1q/SF4JzOP6CJg==
X-Google-Smtp-Source: ABdhPJzzumw0+ASUgyNNYC4irVIaTE35YFLapkvGBFUHfBff9cf3K+xsy2vBNTo7hyD2HMV9/KZqCg==
X-Received: by 2002:a17:903:32c4:: with SMTP id i4mr8855504plr.78.1644520254796;
        Thu, 10 Feb 2022 11:10:54 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:54 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 09/10] btrfs-progs: send: stream v2 ioctl flags
Date:   Thu, 10 Feb 2022 11:10:16 -0800
Message-Id: <f9e2c5f46f9f2daa195d1e857b3aa8cb7ff23243.1644520114.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

First, add a --proto option to allow specifying the desired send
protocol version. It defaults to zero, which tells the kernel to pick
the latest version. This is based on Dave Sterba's patch.

Also add a --compressed-data flag to instruct the kernel to use
encoded_write commands for compressed extents. This requires an explicit
opt in separate from the protocol version because:

1. The user may not want compression on the receiving side, or may want
   a different compression algorithm/level on the receiving side.
2. It has a soft requirement for kernel support on the receiving side
   (btrfs-progs can fall back to decompressing and writing if the kernel
   doesn't support BTRFS_IOC_ENCODED_WRITE, but the user may not be
   prepared to pay that CPU cost). Going forward, since it's easier to
   update progs than the kernel, I think we'll want to make new send
   features that require kernel support opt-in, whereas anything that
   only requires a progs update can happen automatically.

Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 Documentation/btrfs-send.rst |  22 ++++++++
 cmds/send.c                  | 100 ++++++++++++++++++++++++++++++++++-
 ioctl.h                      |  19 ++++++-
 kernel-shared/send.h         |   2 +-
 4 files changed, 138 insertions(+), 5 deletions(-)

diff --git a/Documentation/btrfs-send.rst b/Documentation/btrfs-send.rst
index 4526532e..291c537e 100644
--- a/Documentation/btrfs-send.rst
+++ b/Documentation/btrfs-send.rst
@@ -60,6 +60,28 @@ please see section *SUBVOLUME FLAGS* in ``btrfs-subvolume(8)``.
         used to transfer changes. This mode is faster and is useful to show the
         differences in metadata.
 
+--proto <N>
+        use send protocol version N
+
+        The default is 1, which was the original protocol version. Version 2
+        encodes file data slightly more efficiently; it is also required for
+        sending compressed data directly (see *--compressed-data*). Version 2
+        requires at least btrfs-progs 5.18 on both the sender and receiver and
+        at least Linux 5.18 on the sender. Passing 0 means to use the highest
+        version supported by the running kernel.
+
+--compressed-data
+        send data that is compressed on the filesystem directly without
+        decompressing it
+
+        If the receiver supports the *BTRFS_IOC_ENCODED_WRITE* ioctl (added in
+        Linux 5.18), it can also write it directly without decompressing it.
+        Otherwise, the receiver will fall back to decompressing it and writing
+        it normally.
+
+        This requires protocol version 2 or higher. If *--proto* was not used,
+        then *--compressed-data* implies *--proto 2*.
+
 -q|--quiet
         (deprecated) alias for global *-q* option
 
diff --git a/cmds/send.c b/cmds/send.c
index 087af05c..b1adfeca 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -57,6 +57,8 @@ struct btrfs_send {
 	u64 clone_sources_count;
 
 	char *root_path;
+	u32 proto;
+	u32 proto_supported;
 };
 
 static int get_root_id(struct btrfs_send *sctx, const char *path, u64 *root_id)
@@ -259,6 +261,16 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 	memset(&io_send, 0, sizeof(io_send));
 	io_send.send_fd = pipefd[1];
 	send->send_fd = pipefd[0];
+	io_send.flags = flags;
+
+	if (send->proto_supported > 1) {
+		/*
+		 * Versioned stream supported, requesting default or specific
+		 * number.
+		 */
+		io_send.version = send->proto;
+		io_send.flags |= BTRFS_SEND_FLAG_VERSION;
+	}
 
 	if (!ret)
 		ret = pthread_create(&t_read, NULL, read_sent_data, send);
@@ -269,7 +281,6 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 		goto out;
 	}
 
-	io_send.flags = flags;
 	io_send.clone_sources = (__u64*)send->clone_sources;
 	io_send.clone_sources_count = send->clone_sources_count;
 	io_send.parent_root = parent_root_id;
@@ -421,6 +432,36 @@ static void free_send_info(struct btrfs_send *sctx)
 	sctx->root_path = NULL;
 }
 
+static u32 get_sysfs_proto_supported(void)
+{
+	int fd;
+	int ret;
+	char buf[32] = {};
+	char *end = NULL;
+	u64 version;
+
+	fd = sysfs_open_file("features/send_stream_version");
+	if (fd < 0) {
+		/*
+		 * No file is either no version support or old kernel with just
+		 * v1.
+		 */
+		return 1;
+	}
+	ret = sysfs_read_file(fd, buf, sizeof(buf));
+	close(fd);
+	if (ret <= 0)
+		return 1;
+	version = strtoull(buf, &end, 10);
+	if (version == ULLONG_MAX && errno == ERANGE)
+		return 1;
+	if (version > U32_MAX) {
+		warning("sysfs/send_stream_version too big: %llu", version);
+		version = 1;
+	}
+	return version;
+}
+
 static const char * const cmd_send_usage[] = {
 	"btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]",
 	"Send the subvolume(s) to stdout.",
@@ -449,6 +490,11 @@ static const char * const cmd_send_usage[] = {
 	"                 does not contain any file data and thus cannot be used",
 	"                 to transfer changes. This mode is faster and useful to",
 	"                 show the differences in metadata.",
+	"--proto N        use protocol version N, or 0 to use the highest version",
+	"                 supported by the sending kernel (default: 1)",
+	"--compressed-data",
+	"                 send data that is compressed on the filesystem directly",
+	"                 without decompressing it",
 	"-v|--verbose     deprecated, alias for global -v option",
 	"-q|--quiet       deprecated, alias for global -q option",
 	HELPINFO_INSERT_GLOBALS,
@@ -471,9 +517,11 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 	int full_send = 1;
 	int new_end_cmd_semantic = 0;
 	u64 send_flags = 0;
+	u64 proto = 0;
 
 	memset(&send, 0, sizeof(send));
 	send.dump_fd = fileno(stdout);
+	send.proto = 1;
 	outname[0] = 0;
 
 	/*
@@ -489,11 +537,17 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 
 	optind = 0;
 	while (1) {
-		enum { GETOPT_VAL_SEND_NO_DATA = 256 };
+		enum {
+			GETOPT_VAL_SEND_NO_DATA = 256,
+			GETOPT_VAL_PROTO,
+			GETOPT_VAL_COMPRESSED_DATA,
+		};
 		static const struct option long_options[] = {
 			{ "verbose", no_argument, NULL, 'v' },
 			{ "quiet", no_argument, NULL, 'q' },
 			{ "no-data", no_argument, NULL, GETOPT_VAL_SEND_NO_DATA },
+			{ "proto", required_argument, NULL, GETOPT_VAL_PROTO },
+			{ "compressed-data", no_argument, NULL, GETOPT_VAL_COMPRESSED_DATA },
 			{ NULL, 0, NULL, 0 }
 		};
 		int c = getopt_long(argc, argv, "vqec:f:i:p:", long_options, NULL);
@@ -582,6 +636,18 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 		case GETOPT_VAL_SEND_NO_DATA:
 			send_flags |= BTRFS_SEND_FLAG_NO_FILE_DATA;
 			break;
+		case GETOPT_VAL_PROTO:
+			proto = arg_strtou64(optarg);
+			if (proto > U32_MAX) {
+				error("protocol version number too big %llu", proto);
+				ret = 1;
+				goto out;
+			}
+			send.proto = proto;
+			break;
+		case GETOPT_VAL_COMPRESSED_DATA:
+			send_flags |= BTRFS_SEND_FLAG_COMPRESSED;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -689,6 +755,36 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 	if ((send_flags & BTRFS_SEND_FLAG_NO_FILE_DATA) && bconf.verbose > 1)
 		if (bconf.verbose > 1)
 			fprintf(stderr, "Mode NO_FILE_DATA enabled\n");
+	send.proto_supported = get_sysfs_proto_supported();
+	if (send.proto_supported == 1) {
+		if (send.proto > send.proto_supported) {
+			error("requested version %u but kernel supports only %u",
+			      send.proto, send.proto_supported);
+			ret = -EPROTO;
+			goto out;
+		}
+	}
+	if (send_flags & BTRFS_SEND_FLAG_COMPRESSED) {
+		/*
+		 * If no protocol version was explicitly requested, then
+		 * --compressed-data implies --proto 2.
+		 */
+		if (send.proto == 1 && !proto)
+			send.proto = 2;
+
+		if (send.proto == 1) {
+			error("--compressed-data requires protocol version >= 2 (requested 1)");
+			ret = -EINVAL;
+			goto out;
+		} else if (send.proto == 0 && send.proto_supported < 2) {
+			error("kernel does not support --compressed-data");
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+	if (bconf.verbose > 1)
+		fprintf(stderr, "Protocol version requested: %u (supported %u)\n",
+			send.proto, send.proto_supported);
 
 	for (i = optind; i < argc; i++) {
 		int is_first_subvol;
diff --git a/ioctl.h b/ioctl.h
index dcfe0b6c..2137dd5f 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -655,10 +655,24 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_received_subvol_args_32) == 192);
  */
 #define BTRFS_SEND_FLAG_OMIT_END_CMD		0x4
 
+/*
+ * Read the protocol version in the structure
+ */
+#define BTRFS_SEND_FLAG_VERSION			0x8
+
+/*
+ * Send compressed data using the ENCODED_WRITE command instead of decompressing
+ * the data and sending it with the WRITE command. This requires protocol
+ * version >= 2.
+ */
+#define BTRFS_SEND_FLAG_COMPRESSED		0x10
+
 #define BTRFS_SEND_FLAG_MASK \
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
-	 BTRFS_SEND_FLAG_OMIT_END_CMD)
+	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
+	 BTRFS_SEND_FLAG_VERSION | \
+	 BTRFS_SEND_FLAG_COMPRESSED)
 
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
@@ -666,7 +680,8 @@ struct btrfs_ioctl_send_args {
 	__u64 __user *clone_sources;	/* in */
 	__u64 parent_root;		/* in */
 	__u64 flags;			/* in */
-	__u64 reserved[4];		/* in */
+	__u32 version;			/* in */
+	__u8 reserved[28];		/* in */
 };
 /*
  * Size of structure depends on pointer width, was not caught in the early
diff --git a/kernel-shared/send.h b/kernel-shared/send.h
index b902d054..1f20d01a 100644
--- a/kernel-shared/send.h
+++ b/kernel-shared/send.h
@@ -31,7 +31,7 @@ extern "C" {
 #endif
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
-#define BTRFS_SEND_STREAM_VERSION 1
+#define BTRFS_SEND_STREAM_VERSION 2
 
 /*
  * In send stream v1, no command is larger than 64k. In send stream v2, no limit
-- 
2.35.1

