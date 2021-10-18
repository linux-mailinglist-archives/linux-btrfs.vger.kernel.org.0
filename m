Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778AC432027
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhJROt7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 10:49:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43546 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhJROt6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 10:49:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CF4E31FD7F;
        Mon, 18 Oct 2021 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634568466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A2eTaYW2AM6l/uF98shMx/jLXfek5CfQ/IadzoLrYBg=;
        b=EilAAZlniHY4vcivgk9ByAvjmY3czJTliFL9LdA6JPGE0OqLXSoRycqHQVYJnvPBqTRtok
        j1eHSTysaqlUsaJQeEyQSUGotnUy5+KHIY92ovv/K4B279Ji+ptCJeofZc2vAzzW9CHz6R
        qipyALJHBXksAluYStOxQy3Es3lBbn0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C703FA3B89;
        Mon, 18 Oct 2021 14:47:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BC6BFDA7A3; Mon, 18 Oct 2021 16:47:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     nborisov@suse.com, osandov@osandov.com,
        David Sterba <dsterba@suse.com>
Subject: [PATCH RFC] btrfs-progs: send protocol v2 stub, UTIMES2, OTIME
Date:   Mon, 18 Oct 2021 16:47:17 +0200
Message-Id: <20211018144717.20275-1-dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018144109.18442-1-dsterba@suse.com>
References: <20211018144109.18442-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is counterpart for the protocol version update.

- version 2 protocol
- new protocol command UTIMES2, same as utimes with additional otime
  data
- send: add command line options to specify version, compare against
  current running kernel supported version
- receive: parse UTIMES2
- receive: parse OTIME

TODO:

- libbtrfs compatibility is missing, ie. this will break anything that
  uses send stream (snapper), this needs library version update and
  maybe some ifdefs in the headers

Signed-off-by: David Sterba <dsterba@suse.com>
---
 cmds/receive-dump.c  | 31 ++++++++++++++++-
 cmds/receive.c       | 79 ++++++++++++++++++++++++++++++++++++++++++++
 cmds/send.c          | 66 ++++++++++++++++++++++++++++++++++--
 common/send-stream.c | 14 ++++++++
 common/send-stream.h |  5 +++
 ioctl.h              | 12 +++++--
 kernel-shared/send.h | 11 +++++-
 7 files changed, 212 insertions(+), 6 deletions(-)

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index 47a0a30e47db..7250228e6c42 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -312,6 +312,33 @@ static int print_utimes(const char *path, struct timespec *at,
 			  at_str, mt_str, ct_str);
 }
 
+static int print_utimes2(const char *path, struct timespec *at,
+			struct timespec *mt, struct timespec *ct,
+			struct timespec *ot, void *user)
+{
+	char at_str[TIME_STRING_MAX];
+	char mt_str[TIME_STRING_MAX];
+	char ct_str[TIME_STRING_MAX];
+	char ot_str[TIME_STRING_MAX];
+
+	if (sprintf_timespec(at, at_str, TIME_STRING_MAX - 1) < 0 ||
+	    sprintf_timespec(mt, mt_str, TIME_STRING_MAX - 1) < 0 ||
+	    sprintf_timespec(ct, ct_str, TIME_STRING_MAX - 1) < 0 ||
+	    sprintf_timespec(ot, ot_str, TIME_STRING_MAX - 1) < 0)
+		return -EINVAL;
+	return PRINT_DUMP(user, path, "utimes2", "atime=%s mtime=%s ctime=%s otime=%s",
+			  at_str, mt_str, ct_str, ot_str);
+}
+
+static int print_otime(const char *path, struct timespec *ot, void *user)
+{
+	char ot_str[TIME_STRING_MAX];
+
+	if (sprintf_timespec(ot, ot_str, TIME_STRING_MAX - 1) < 0)
+		return -EINVAL;
+	return PRINT_DUMP(user, path, "otime", "otime=%s", ot_str);
+}
+
 static int print_update_extent(const char *path, u64 offset, u64 len,
 			       void *user)
 {
@@ -340,5 +367,7 @@ struct btrfs_send_ops btrfs_print_send_ops = {
 	.chmod = print_chmod,
 	.chown = print_chown,
 	.utimes = print_utimes,
-	.update_extent = print_update_extent
+	.update_extent = print_update_extent,
+	.utimes2 = print_utimes2,
+	.otime = print_otime,
 };
diff --git a/cmds/receive.c b/cmds/receive.c
index 4d123a1f8782..dfb37a502598 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -967,6 +967,83 @@ static int process_utimes(const char *path, struct timespec *at,
 	return ret;
 }
 
+static int process_utimes2(const char *path, struct timespec *at,
+			  struct timespec *mt, struct timespec *ct,
+			  struct timespec *ot, void *user)
+{
+	int ret = 0;
+	struct btrfs_receive *rctx = user;
+	char full_path[PATH_MAX];
+	struct timespec tv[2];
+
+	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
+	if (ret < 0) {
+		error("utimes2: path invalid: %s", path);
+		goto out;
+	}
+
+	if (bconf.verbose >= 3)
+		fprintf(stderr, "utimes2 %s\n", path);
+
+	tv[0] = *at;
+	tv[1] = *mt;
+	ret = utimensat(AT_FDCWD, full_path, tv, AT_SYMLINK_NOFOLLOW);
+	if (ret < 0) {
+		ret = -errno;
+		error("utimes2 %s failed: %m", path);
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+/* TODO: Copied from receive-dump.c */
+static int sprintf_timespec(struct timespec *ts, char *dest, int max_size)
+{
+	struct tm tm;
+	int ret;
+
+	if (!localtime_r(&ts->tv_sec, &tm)) {
+		error("failed to convert time %lld.%.9ld to local time",
+		      (long long)ts->tv_sec, ts->tv_nsec);
+		return -EINVAL;
+	}
+	ret = strftime(dest, max_size, "%FT%T%z", &tm);
+	if (ret == 0) {
+		error(
+		"time %lld.%ld is too long to convert into readable string",
+		      (long long)ts->tv_sec, ts->tv_nsec);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+
+static int process_otime(const char *path, struct timespec *ot, void *user)
+{
+	int ret;
+	struct btrfs_receive *rctx = user;
+	char full_path[PATH_MAX];
+
+	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
+	if (ret < 0) {
+		error("otime: path invalid: %s", path);
+		goto out;
+	}
+
+	if (bconf.verbose >= 3) {
+		char ot_str[128];
+
+		if (sprintf_timespec(ot, ot_str, sizeof(ot_str) - 1) < 0)
+			goto out;
+		fprintf(stderr, "otime %s\n", ot_str);
+	}
+
+out:
+	return 0;
+}
+
 static int process_update_extent(const char *path, u64 offset, u64 len,
 		void *user)
 {
@@ -1004,6 +1081,8 @@ static struct btrfs_send_ops send_ops = {
 	.chown = process_chown,
 	.utimes = process_utimes,
 	.update_extent = process_update_extent,
+	.utimes2 = process_utimes2,
+	.otime = process_otime,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/cmds/send.c b/cmds/send.c
index 1810233137aa..f529f0b0a6a0 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -57,6 +57,8 @@ struct btrfs_send {
 	u64 clone_sources_count;
 
 	char *root_path;
+	u32 proto;
+	u32 proto_supported;
 };
 
 static int get_root_id(struct btrfs_send *sctx, const char *path, u64 *root_id)
@@ -257,6 +259,13 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 	memset(&io_send, 0, sizeof(io_send));
 	io_send.send_fd = pipefd[1];
 	send->send_fd = pipefd[0];
+	io_send.flags = flags;
+
+	if (send->proto_supported > 1) {
+		/* Versioned stream supported, requesting default or specific number */
+		io_send.version = send->proto;
+		io_send.flags |= BTRFS_SEND_FLAG_VERSION;
+	}
 
 	if (!ret)
 		ret = pthread_create(&t_read, NULL, read_sent_data, send);
@@ -267,7 +276,6 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 		goto out;
 	}
 
-	io_send.flags = flags;
 	io_send.clone_sources = (__u64*)send->clone_sources;
 	io_send.clone_sources_count = send->clone_sources_count;
 	io_send.parent_root = parent_root_id;
@@ -275,6 +283,7 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 		io_send.flags |= BTRFS_SEND_FLAG_OMIT_STREAM_HEADER;
 	if (!is_last_subvol)
 		io_send.flags |= BTRFS_SEND_FLAG_OMIT_END_CMD;
+
 	ret = ioctl(subvol_fd, BTRFS_IOC_SEND, &io_send);
 	if (ret < 0) {
 		ret = -errno;
@@ -419,6 +428,33 @@ static void free_send_info(struct btrfs_send *sctx)
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
+		/* No file is either no version support or old kernel with just v1 */
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
@@ -447,6 +483,7 @@ static const char * const cmd_send_usage[] = {
 	"                 does not contain any file data and thus cannot be used",
 	"                 to transfer changes. This mode is faster and useful to",
 	"                 show the differences in metadata.",
+	"--proto N        request maximum protocol version N (default: highest supported by running kernel)",
 	"-v|--verbose     deprecated, alias for global -v option",
 	"-q|--quiet       deprecated, alias for global -q option",
 	HELPINFO_INSERT_GLOBALS,
@@ -472,6 +509,7 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 
 	memset(&send, 0, sizeof(send));
 	send.dump_fd = fileno(stdout);
+	send.proto = 0;
 	outname[0] = 0;
 
 	/*
@@ -487,11 +525,12 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 
 	optind = 0;
 	while (1) {
-		enum { GETOPT_VAL_SEND_NO_DATA = 256 };
+		enum { GETOPT_VAL_SEND_NO_DATA = 256, GETOPT_VAL_PROTO };
 		static const struct option long_options[] = {
 			{ "verbose", no_argument, NULL, 'v' },
 			{ "quiet", no_argument, NULL, 'q' },
 			{ "no-data", no_argument, NULL, GETOPT_VAL_SEND_NO_DATA },
+			{ "proto" , required_argument, NULL, GETOPT_VAL_PROTO },
 			{ NULL, 0, NULL, 0 }
 		};
 		int c = getopt_long(argc, argv, "vqec:f:i:p:", long_options, NULL);
@@ -580,6 +619,17 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 		case GETOPT_VAL_SEND_NO_DATA:
 			send_flags |= BTRFS_SEND_FLAG_NO_FILE_DATA;
 			break;
+		case GETOPT_VAL_PROTO: {
+			u64 tmp;
+
+			tmp = arg_strtou64(optarg);
+			if (tmp > U32_MAX) {
+				error("protocol version number too big %llu", tmp);
+				ret = 1;
+				goto out;
+			}
+			send.proto = tmp;
+			break; }
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -687,6 +737,18 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 	if ((send_flags & BTRFS_SEND_FLAG_NO_FILE_DATA) && bconf.verbose > 1)
 		if (bconf.verbose > 1)
 			fprintf(stderr, "Mode NO_FILE_DATA enabled\n");
+	send.proto_supported = get_sysfs_proto_supported();
+	if (send.proto_supported == 1) {
+		if (send.proto > send.proto_supported) {
+			error("requested version %u but kernel supports only %u",
+				send.proto, send.proto_supported);
+			ret = -EPROTO;
+			goto out;
+		}
+	}
+	if (bconf.verbose > 1)
+		fprintf(stderr, "Protocol version requested: %u (supported %u)\n",
+				send.proto, send.proto_supported);
 
 	for (i = optind; i < argc; i++) {
 		int is_first_subvol;
diff --git a/common/send-stream.c b/common/send-stream.c
index d07748ced1fe..0b0558cec671 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -314,6 +314,7 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	struct timespec at;
 	struct timespec ct;
 	struct timespec mt;
+	struct timespec ot;
 	u8 uuid[BTRFS_UUID_SIZE];
 	u8 clone_uuid[BTRFS_UUID_SIZE];
 	u64 tmp;
@@ -451,6 +452,19 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 		TLV_GET_U64(sctx, BTRFS_SEND_A_SIZE, &tmp);
 		ret = sctx->ops->update_extent(path, offset, tmp, sctx->user);
 		break;
+	case BTRFS_SEND_C_UTIMES2:
+		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
+		TLV_GET_TIMESPEC(sctx, BTRFS_SEND_A_ATIME, &at);
+		TLV_GET_TIMESPEC(sctx, BTRFS_SEND_A_MTIME, &mt);
+		TLV_GET_TIMESPEC(sctx, BTRFS_SEND_A_CTIME, &ct);
+		TLV_GET_TIMESPEC(sctx, BTRFS_SEND_A_OTIME, &ot);
+		ret = sctx->ops->utimes2(path, &at, &mt, &ct, &ot, sctx->user);
+		break;
+	case BTRFS_SEND_C_OTIME:
+		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
+		TLV_GET_TIMESPEC(sctx, BTRFS_SEND_A_OTIME, &ot);
+		ret = sctx->ops->otime(path, &ot, sctx->user);
+		break;
 	case BTRFS_SEND_C_END:
 		ret = 1;
 		break;
diff --git a/common/send-stream.h b/common/send-stream.h
index 2de51eac5548..be6c71031db0 100644
--- a/common/send-stream.h
+++ b/common/send-stream.h
@@ -53,6 +53,11 @@ struct btrfs_send_ops {
 		      struct timespec *mt, struct timespec *ct,
 		      void *user);
 	int (*update_extent)(const char *path, u64 offset, u64 len, void *user);
+	/* V2 */
+	int (*utimes2)(const char *path, struct timespec *at,
+		      struct timespec *mt, struct timespec *ct,
+		      struct timespec *ot, void *user);
+	int (*otime)(const char *path, struct timespec *ot, void *user);
 };
 
 int btrfs_read_and_process_send_stream(int fd,
diff --git a/ioctl.h b/ioctl.h
index 368a87b27711..2901d92b64e8 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -655,10 +655,16 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_received_subvol_args_32) == 192);
  */
 #define BTRFS_SEND_FLAG_OMIT_END_CMD		0x4
 
+/*
+ * Read the protocol version in the structure
+ */
+#define BTRFS_SEND_FLAG_VERSION			0x8
+
 #define BTRFS_SEND_FLAG_MASK \
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
-	 BTRFS_SEND_FLAG_OMIT_END_CMD)
+	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
+	 BTRFS_SEND_FLAG_VERSION)
 
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
@@ -666,7 +672,9 @@ struct btrfs_ioctl_send_args {
 	__u64 __user *clone_sources;	/* in */
 	__u64 parent_root;		/* in */
 	__u64 flags;			/* in */
-	__u64 reserved[4];		/* in */
+	__u32 version;			/* in */
+	__u32 reserved32;
+	__u64 reserved[3];		/* in */
 };
 /*
  * Size of structure depends on pointer width, was not caught in the early
diff --git a/kernel-shared/send.h b/kernel-shared/send.h
index e73f09dfe5d7..8b927313ff76 100644
--- a/kernel-shared/send.h
+++ b/kernel-shared/send.h
@@ -31,7 +31,7 @@ extern "C" {
 #endif
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
-#define BTRFS_SEND_STREAM_VERSION 1
+#define BTRFS_SEND_STREAM_VERSION 2
 
 #define BTRFS_SEND_BUF_SIZE  (64 * 1024)
 #define BTRFS_SEND_READ_SIZE (1024 * 48)
@@ -70,6 +70,7 @@ struct btrfs_tlv_header {
 enum btrfs_send_cmd {
 	BTRFS_SEND_C_UNSPEC,
 
+	/* Version 1 */
 	BTRFS_SEND_C_SUBVOL,
 	BTRFS_SEND_C_SNAPSHOT,
 
@@ -98,6 +99,14 @@ enum btrfs_send_cmd {
 
 	BTRFS_SEND_C_END,
 	BTRFS_SEND_C_UPDATE_EXTENT,
+	__BTRFS_SEND_C_MAX_V1,
+
+	/* Version 2 */
+	BTRFS_SEND_C_UTIMES2,
+	BTRFS_SEND_C_OTIME,
+	__BTRFS_SEND_C_MAX_V2,
+
+	/* End */
 	__BTRFS_SEND_C_MAX,
 };
 #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
-- 
2.33.0

