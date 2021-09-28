Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832FC41BB1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 01:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbhI1Xx7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 19:53:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42916 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbhI1Xx7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 19:53:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF8A5224D3
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 23:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632873137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0xXLtQKyX0svJ4DVvnrQxxxZpmybajZKyMrC32PZMeU=;
        b=O4hCSUxjPUQ8IcV1184WHtE9K5iU6Rdh0bbsH+VdDgI5PSHYxnDOGzxmxGTtsnFi4H5OVm
        hg8GXdtOg2EU82WSkrU34uW2MafN/wTej8T6Sp59jxBaO6H9kLCWgTxPFj+OZGVV/HU25N
        NHZirzKpW80rKZBJ8V5BXlkrd5Htq5s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4168D13EB6
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 23:52:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fL8QA7GqU2FuQAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 23:52:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs-progs: receive: fallback to buffered copy if clone failed
Date:   Wed, 29 Sep 2021 07:51:59 +0800
Message-Id: <20210928235159.9440-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There are two every basic send streams:
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

But if we receive the first stream with default mount options, then
remount to nodatasum, and try to receive the second stream, it will fail:

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
Btrfs doesn't allow clone source and destination to have different NODATASUM
flags.
This is to prevent a data extent to be owned by both NODATASUM inode and
regular DATASUM inode.

For above receive operations, the clone destination is inheriting the
NODATASUM flag from mount option, while the clone source has no
NODATASUM flag, thus preventing us from doing the clone.

[FIX]
Btrfs send/receive doesn't require the underlying inode has the same
flags (thus we can send from compressed extent and receive on a
non-compressed filesystem).

So here we can just fall back to buffered write to copy the data from
the source file if we got an -EINVAL error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

Such fallback can lead to hidden bugs not being exposed, thus a new
warning is added for such fallback case.

Personally I really want to do more comprehensive check in user space to
ensure it's only mismatching NODATASUM flags causing the problem.
Then we can completely remove the warning message.

But unfortunately that check can go out-of-sync with kernel and due to
the lack of NODATASUM flags interface we're not really able to check
that easily.

So I took the advice from Filipe to just do a simple fall back.

Any feedback on such maybe niche point would help.
(Really hope it's me being paranoid again)
---
 cmds/receive.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index 48c774cea587..4cb857a13cdf 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -705,6 +705,51 @@ out:
 	return ret;
 }
 
+#define BUFFER_SIZE	SZ_32K
+static int buffered_copy(int src_fd, int dst_fd, u64 src_offset, u64 len,
+			 u64 dest_offset)
+{
+	unsigned char *buf;
+	u64 cur_offset = 0;
+	int ret = 0;
+
+	buf = calloc(BUFFER_SIZE, 1);
+	if (!buf)
+		return -ENOMEM;
+
+	while (cur_offset < len) {
+		u32 copy_len = min_t(u32, BUFFER_SIZE, len - cur_offset);
+		u32 write_offset = 0;
+		ssize_t read_size;
+
+		read_size = pread(src_fd, buf, copy_len, src_offset + cur_offset);
+		if (read_size < 0) {
+			ret = -errno;
+			error("failed to read source file: %m");
+			goto out;
+		}
+
+		/* Write the buffer to dest file */
+		while (write_offset < read_size) {
+			ssize_t write_size;
+
+			write_size = pwrite(dst_fd, buf + write_offset,
+					read_size - write_offset,
+					dest_offset + cur_offset + write_offset);
+			if (write_size < 0) {
+				ret = -errno;
+				error("failed to write source file: %m");
+				goto out;
+			}
+			write_offset += write_size;
+		}
+		cur_offset += read_size;
+	}
+out:
+	free(buf);
+	return ret;
+}
+
 static int process_clone(const char *path, u64 offset, u64 len,
 			 const u8 *clone_uuid, u64 clone_ctransid,
 			 const char *clone_path, u64 clone_offset,
@@ -788,8 +833,16 @@ static int process_clone(const char *path, u64 offset, u64 len,
 	ret = ioctl(rctx->write_fd, BTRFS_IOC_CLONE_RANGE, &clone_args);
 	if (ret < 0) {
 		ret = -errno;
-		error("failed to clone extents to %s: %m", path);
-		goto out;
+		if (ret != -EINVAL) {
+			error("failed to clone extents to %s: %m", path);
+			goto out;
+		}
+
+		warning(
+		"failed to clone extents to %s, fallback to buffered write",
+			path);
+		ret = buffered_copy(clone_fd, rctx->write_fd, clone_offset,
+				    len, offset);
 	}
 
 out:
-- 
2.33.0

