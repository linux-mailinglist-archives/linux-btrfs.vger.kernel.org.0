Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32486454E7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbhKQUX4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbhKQUXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:25 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBDCC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:26 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id t11so3900243qtw.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PcU2ZkEd3uUFvV7dXtl0a6tDmkqDtGu38MVEhfCz1rE=;
        b=p81x4vszBRH//tRwKACTGy61MA3K+0JGrbI5OuvwrH+uSyhPNEofvnYSR40jHDHRSj
         RJjijBRsyknuleziPF0N6SiSltskqOzx1crmP9f+tlGZDfjs/wdu5J7nwVy8lFDcfn7c
         GZcr9CspzMKpZp0QYLrfatfTGG0SEoM91RnBX+f1Fws26siqOy85+CDNol5E9P4Iz0IS
         L8IHY9+Y+cYYvqhZAteqt+X/7lv5a36PoMuF61/zaghvIY56a3OLt/tqxr7GNG9baHok
         IXtaY2v45WPJ6Nfh2YkIdz1pRzIZGVbhVg33wO6s0qQbORZWy2jGdl4r5TESgJmfjxbS
         LqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PcU2ZkEd3uUFvV7dXtl0a6tDmkqDtGu38MVEhfCz1rE=;
        b=1JhpMrkXLj8JOJVzZdkKsUy7t3V6BhmaXwTYtQrkWpT9lzNSjgw0VCqgNUL7Bh3398
         +C3U5hd5VXrnpbJEKz22RFDtosc4zJl80lVvppxy++ftzFkt2IkdRkVGVjStNWW+SkJC
         XN2r0QR9TSnNlnr0WWHzmaA41840//k5k+bSWaqbCSOWZ6KqMofiEhYIFR/MRVNyJipY
         bh/bB0hclHnfZRObfR1nax/0wmisH9+r6lLaMJXQUXb2zX0GNjOu5x7HWWBtfKA34toi
         PMgZ7O9cvARnFUJ4PoaPpCsZEzgGKUHs2KfQJFQ3prwHGwQFi52SQFAEDsZudHcWaCSa
         MRIQ==
X-Gm-Message-State: AOAM532PTtRhb9cvafGZA3XG6Ekxa2VTD/2UxjrWDeXr4YJkrVnyTtLD
        3TaQk3ix1PwNxOUdIjAcPR9wA5lpBbBjvg==
X-Google-Smtp-Source: ABdhPJwq6ri92IZReu79zv6eVBlqLmwwqwDOT1bjKHpiqzICGwjGhYl0huVKPLdJlBPggZFQGRAsNw==
X-Received: by 2002:ac8:5f07:: with SMTP id x7mr20258517qta.244.1637180425406;
        Wed, 17 Nov 2021 12:20:25 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:25 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 09/10] btrfs-progs: send: stream v2 ioctl flags
Date:   Wed, 17 Nov 2021 12:19:36 -0800
Message-Id: <eda71c17ebf950ec40a236722870da55e501742d.1637180270.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <boris@bur.io>

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
---
 Documentation/btrfs-send.asciidoc | 18 +++++-
 cmds/send.c                       | 92 ++++++++++++++++++++++++++++++-
 ioctl.h                           | 19 ++++++-
 kernel-shared/send.h              |  2 +-
 4 files changed, 125 insertions(+), 6 deletions(-)

diff --git a/Documentation/btrfs-send.asciidoc b/Documentation/btrfs-send.asciidoc
index 2dae6e32..5ca29b4f 100644
--- a/Documentation/btrfs-send.asciidoc
+++ b/Documentation/btrfs-send.asciidoc
@@ -56,7 +56,23 @@ send in 'NO_FILE_DATA' mode
 The output stream does not contain any file
 data and thus cannot be used to transfer changes. This mode is faster and
 is useful to show the differences in metadata.
--q|--quiet::::
+
+--proto N::
+Use the send protocol version N. The default is 0, which means to use the
+highest version supported by the running kernel. Version 1 was the original
+protocol version. Version 2 encodes file data slightly more efficiently; it is
+also required for sending compressed data directly (see '--compressed-data').
+Version 2 requires at least btrfs-progs 5.16 on both the sender and receiver
+and at least Linux 5.16 on the sender.
+
+--compressed-data::
+Send data that is compressed on the filesystem directly without decompressing
+it. If the receiver supports the 'BTRFS_IOC_ENCODED_WRITE' ioctl (in Linux
+5.16), it can also write it directly without decompressing it. Otherwise, the
+receiver will fall back to decompressing it and writing it normally. This
+requires protocol version 2 or higher.
+
+-q|--quiet::
 (deprecated) alias for global '-q' option
 -v|--verbose::
 (deprecated) alias for global '-v' option
diff --git a/cmds/send.c b/cmds/send.c
index 18102331..114dce1b 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -57,6 +57,8 @@ struct btrfs_send {
 	u64 clone_sources_count;
 
 	char *root_path;
+	u32 proto;
+	u32 proto_supported;
 };
 
 static int get_root_id(struct btrfs_send *sctx, const char *path, u64 *root_id)
@@ -257,6 +259,16 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
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
@@ -267,7 +279,6 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 		goto out;
 	}
 
-	io_send.flags = flags;
 	io_send.clone_sources = (__u64*)send->clone_sources;
 	io_send.clone_sources_count = send->clone_sources_count;
 	io_send.parent_root = parent_root_id;
@@ -419,6 +430,36 @@ static void free_send_info(struct btrfs_send *sctx)
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
@@ -447,6 +488,11 @@ static const char * const cmd_send_usage[] = {
 	"                 does not contain any file data and thus cannot be used",
 	"                 to transfer changes. This mode is faster and useful to",
 	"                 show the differences in metadata.",
+	"--proto N        request maximum protocol version N (default: highest",
+	"                 supported by running kernel)",
+	"--compressed-data",
+	"                 send data that is compressed on the filesystem directly",
+	"                 without decompressing it",
 	"-v|--verbose     deprecated, alias for global -v option",
 	"-q|--quiet       deprecated, alias for global -q option",
 	HELPINFO_INSERT_GLOBALS,
@@ -469,6 +515,7 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 	int full_send = 1;
 	int new_end_cmd_semantic = 0;
 	u64 send_flags = 0;
+	u64 proto;
 
 	memset(&send, 0, sizeof(send));
 	send.dump_fd = fileno(stdout);
@@ -487,11 +534,17 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 
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
@@ -580,6 +633,18 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
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
@@ -687,6 +752,29 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
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
index 1458dd29..133eeb5a 100644
--- a/kernel-shared/send.h
+++ b/kernel-shared/send.h
@@ -31,7 +31,7 @@ extern "C" {
 #endif
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
-#define BTRFS_SEND_STREAM_VERSION 1
+#define BTRFS_SEND_STREAM_VERSION 2
 
 #define BTRFS_SEND_BUF_SIZE_V1 (64 * 1024)
 
-- 
2.34.0

