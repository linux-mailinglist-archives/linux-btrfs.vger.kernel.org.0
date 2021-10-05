Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA41D421BA0
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 03:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhJEBRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 21:17:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33996 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhJEBRF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 21:17:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 08A9A20260;
        Tue,  5 Oct 2021 01:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633396515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6mTbImT7g0C0xH0q3gPSOYviccl8eSB8JsG3DU0upI=;
        b=aOke7wJXIIB72ymENvAH2SDe1Zul2z3FyyncjrVneJ6vMICsx1PnagyDE6xyHxxRc3a2Or
        hXoHG3wuBXr4kjzPEVeY8lXWDccWRHhwB8C/dVP+iUFr2cqnxCHuVWXxOl/mdqsSCgIPGz
        EWWRDQ0rmxXdr4Bl5WSszIPZy28wO/Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0954413B51;
        Tue,  5 Oct 2021 01:15:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +N8qLyGnW2HEcAAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 05 Oct 2021 01:15:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 1/2] btrfs-progs: receive: fallback to buffered copy if clone failed
Date:   Tue,  5 Oct 2021 09:14:54 +0800
Message-Id: <20211005011455.24121-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005011455.24121-1-wqu@suse.com>
References: <20211005011455.24121-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There are two very basic send streams:
(a/m/ctime and uuid omitted)

  Stream 1: (Parent subvolume)
  subvol   ./parent_subv           transid=8
  chown    ./parent_subv/          gid=0 uid=0
  chmod    ./parent_subv/          mode=755
  utimes   ./parent_subv/
  mkfile   ./parent_subv/o257-7-0
  rename   ./parent_subv/o257-7-0  dest=./parent_subv/source
  utimes   ./parent_subv/
  write    ./parent_subv/source    offset=0 len=16384
  chown    ./parent_subv/source    gid=0 uid=0
  chmod    ./parent_subv/source    mode=600
  utimes   ./parent_subv/source

  Stream 2: (snapshot and clone)
  snapshot ./dest_subv             transid=14 parent_transid=10
  utimes   ./dest_subv/
  mkfile   ./dest_subv/o258-14-0
  rename   ./dest_subv/o258-14-0   dest=./dest_subv/reflink
  utimes   ./dest_subv/
  clone    ./dest_subv/reflink     offset=0 len=16384 from=./dest_subv/source clone_offset=0
  chown    ./dest_subv/reflink     gid=0 uid=0
  chmod    ./dest_subv/reflink     mode=600
  utimes   ./dest_subv/reflink

But if we receive the first stream with default mount, then remount to
nodatasum, and try to receive the second stream, it will fail:

 # mount /mnt/btrfs
 # btrfs receive -f ~/parent_stream /mnt/btrfs/
 At subvol parent_subv
 # mount -o remount,nodatasum /mnt/btrfs
 # btrfs receive -f ~/clone_stream /mnt/btrfs/
 At snapshot dest_subv
 ERROR: failed to clone extents to reflink: Invalid argument
 # echo $?
 1

[CAUSE]
Btrfs doesn't allow clone source and destination files have different
NODATASUM flags.
This is to prevent a data extent to be owned by both NODATASUM inode and
regular DATASUM inode.

For above receive operations, the clone destination is inheriting the
NODATASUM flag from mount option, while the clone source has no
NODATASUM flag, thus preventing us from doing the clone.

[FIX]
Btrfs send/receive doesn't require the underlying inode has the same
flags (thus we can send from compressed extent and receive on a
non-compressed filesystem).

So here we add a new command line option, '--clone-fallback', to allow
btrfs-receive to fall back to buffered write to copy data from the
source file.

Since such behavior can result much less clone operations, which may not
be what the end users really want, and can hide bugs in send stream.
Thus this behavior must be explicitly specified by the new option.

And we will output a warning message each time such fallback is
triggered if the user wants extra debug output.

Finally if we have any failed clone operation when --clone-fallback is
specified, also output a overview at the end of the received process,
showing how many clone opeartions failed and how many bytes are no
longer shared.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-receive.asciidoc | 13 +++++
 cmds/receive.c                       | 80 ++++++++++++++++++++++++++--
 2 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/Documentation/btrfs-receive.asciidoc b/Documentation/btrfs-receive.asciidoc
index e4c4d2c0bf3d..adf73c9cedae 100644
--- a/Documentation/btrfs-receive.asciidoc
+++ b/Documentation/btrfs-receive.asciidoc
@@ -65,6 +65,19 @@ dump the stream metadata, one line per operation
 +
 Does not require the 'path' parameter. The filesystem remains unchanged.
 
+--clone-fallback::
+when clone operations fail, attempt to directly copy the data instead.
++
+When the source and destination filesystems have different sector sizes, or
+when the source and destination files have different 'nodatacow' and/or
+'nodatasum' flags (can be set per file/directory or through mount options),
+clone operations can fail.
++
+This option makes the receive process attempt to manually copy data from the
+source to the destination file when a clone operation fails (for the reasons
+mentioned before). When this happens, extents will end up not being shared
+between the files, thus will take up more space.
+
 -q|--quiet::
 (deprecated) alias for global '-q' option
 
diff --git a/cmds/receive.c b/cmds/receive.c
index 48c774cea587..20deccfdf1b2 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -76,6 +76,15 @@ struct btrfs_receive
 	struct subvol_uuid_search sus;
 
 	int honor_end_cmd;
+
+	bool clone_fallback;
+
+	/*
+	 * The amount of failed clone opeartions and their bytes.
+	 * Will only be non-zero if above clone_fallback is true.
+	 */
+	u64 bytes_clone_failed;
+	u64 nr_clone_failed;
 };
 
 static int finish_subvol(struct btrfs_receive *rctx)
@@ -705,6 +714,44 @@ out:
 	return ret;
 }
 
+static int buffered_copy(int src_fd, int dst_fd, u64 src_offset, u64 len,
+			 u64 dest_offset)
+{
+	unsigned char buf[SZ_32K];
+	u64 copied = 0;
+	int ret = 0;
+
+	while (copied < len) {
+		u32 copy_len = min_t(u32, ARRAY_SIZE(buf), len - copied);
+		u32 written = 0;
+		ssize_t read_size;
+
+		read_size = pread(src_fd, buf, copy_len, src_offset + copied);
+		if (read < 0) {
+			ret = -errno;
+			error("failed to read source file: %m");
+			return ret;
+		}
+
+		/* Write the buffer to dest file */
+		while (written < read_size) {
+			ssize_t write_size;
+
+			write_size = pwrite(dst_fd, buf + written,
+					read_size - written,
+					dest_offset + copied + written);
+			if (write_size < 0) {
+				ret = -errno;
+				error("failed to write source file: %m");
+				return ret;
+			}
+			written += write_size;
+		}
+		copied += read_size;
+	}
+	return ret;
+}
+
 static int process_clone(const char *path, u64 offset, u64 len,
 			 const u8 *clone_uuid, u64 clone_ctransid,
 			 const char *clone_path, u64 clone_offset,
@@ -788,8 +835,24 @@ static int process_clone(const char *path, u64 offset, u64 len,
 	ret = ioctl(rctx->write_fd, BTRFS_IOC_CLONE_RANGE, &clone_args);
 	if (ret < 0) {
 		ret = -errno;
-		error("failed to clone extents to %s: %m", path);
-		goto out;
+		if (ret != -EINVAL || !rctx->clone_fallback) {
+			error(
+"clone failed, source=%s source offset=%llu destination=%s destination offset=%llu len=%llu: %m",
+			      full_clone_path, clone_offset, path, offset, len);
+			goto out;
+		}
+
+		/*
+		 * Here we don't need extra info about the failed clone
+		 * operation, as for verbose >= 2 such info is already there,
+		 * just one line before.
+		 */
+		if (bconf.verbose >= 2)
+			warning("clone failed, fallback to buffered write");
+		rctx->bytes_clone_failed += len;
+		rctx->nr_clone_failed++;
+		ret = buffered_copy(clone_fd, rctx->write_fd, clone_offset,
+				    len, offset);
 	}
 
 out:
@@ -1165,6 +1228,10 @@ out:
 		close(rctx->dest_dir_fd);
 		rctx->dest_dir_fd = -1;
 	}
+	if (rctx->clone_fallback && rctx->bytes_clone_failed)
+		warning(
+	"%llu clone operations failed, %llu bytes fell back to buffered write",
+			rctx->nr_clone_failed, rctx->bytes_clone_failed);
 
 	return ret;
 }
@@ -1197,6 +1264,8 @@ static const char * const cmd_receive_usage[] = {
 	"                 this file system is mounted.",
 	"--dump           dump stream metadata, one line per operation,",
 	"                 does not require the MOUNT parameter",
+	"--clone-fallback when clone operations fail, attempt to directly copy"
+	"                 the data instead"
 	"-v               deprecated, alias for global -v option",
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
@@ -1238,11 +1307,13 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 	optind = 0;
 	while (1) {
 		int c;
-		enum { GETOPT_VAL_DUMP = 257 };
+		enum { GETOPT_VAL_DUMP = 257, GETOPT_VAL_CLONE_FALLBACK };
 		static const struct option long_opts[] = {
 			{ "max-errors", required_argument, NULL, 'E' },
 			{ "chroot", no_argument, NULL, 'C' },
 			{ "dump", no_argument, NULL, GETOPT_VAL_DUMP },
+			{ "clone-fallback", no_argument, NULL,
+				GETOPT_VAL_CLONE_FALLBACK},
 			{ "quiet", no_argument, NULL, 'q' },
 			{ NULL, 0, NULL, 0 }
 		};
@@ -1286,6 +1357,9 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 		case GETOPT_VAL_DUMP:
 			dump = 1;
 			break;
+		case GETOPT_VAL_CLONE_FALLBACK:
+			rctx.clone_fallback = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
-- 
2.33.0

