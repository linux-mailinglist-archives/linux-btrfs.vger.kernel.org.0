Return-Path: <linux-btrfs+bounces-2052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C92D846530
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 02:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9451C214D7
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 01:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F75B8C08;
	Fri,  2 Feb 2024 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f1QMMblD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f1QMMblD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A963AA
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835586; cv=none; b=Y+OiuDPrG9FXduS3+t5y269ggRWx3gZNC6tT7TtRXSh2uHSdSpd+/dMFvYLj8P/PtTy9eadyGst3v/RSthsPXqFR7whF8xeqAN0hmNRZuvDtafJdyoWgX3voeYHeNWO2T7IYHwtbJXuBi911Iod9dPr+74CNf65q8EBsb9Yj4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835586; c=relaxed/simple;
	bh=rzKY+6hX1N6z2XKKd4uHq/6Gc8J9BKHdYHfc+iXyfIo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egFW2JeUhY62+2VJ3SFNa0U+JN10+8jXWQb7HTG6bTuUboKD1f0yR18rrfp1BRZCoo4LoGebusCqxeLNMxRrvBqLU+PAgw0Vwzpf7wFd4tfm5XBlUzZ6jGdNi9lX7zylA8BTkrwzswapGE7+HFUP+WjLbFw9vcodoaHDideL1zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f1QMMblD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f1QMMblD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 298302213A
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706835583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjaaQWDE3E3+0T8x1M03eDaU8tBjahCaSDZ3JMDETY4=;
	b=f1QMMblDhIUP7AZ2agGviPcXdxzHkXpi9knfSGu7PH1a1QMoYNNCvPYadYFDobbVzgv4F9
	rF34BCNCDiqiFad982sAzsxDzaGObOkH5MxdBY9OEFVGu3C/+BmN1KDpQ+zpLtzSABC+mh
	FoeVCKIU8ipcF/9g+qsut0s5AD1g5jA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706835583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjaaQWDE3E3+0T8x1M03eDaU8tBjahCaSDZ3JMDETY4=;
	b=f1QMMblDhIUP7AZ2agGviPcXdxzHkXpi9knfSGu7PH1a1QMoYNNCvPYadYFDobbVzgv4F9
	rF34BCNCDiqiFad982sAzsxDzaGObOkH5MxdBY9OEFVGu3C/+BmN1KDpQ+zpLtzSABC+mh
	FoeVCKIU8ipcF/9g+qsut0s5AD1g5jA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65FE5139AB
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 00:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gLW/Cn4+vGXABgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 02 Feb 2024 00:59:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: fix the stray fd close in open_ctree_fs_info()
Date: Fri,  2 Feb 2024 11:29:21 +1030
Message-ID: <abf545db2a21d27c02f92b8a3be0e836fbd3cdd5.1706827356.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706827356.git.wqu@suse.com>
References: <cover.1706827356.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

[BUG]
Although commit b2a1be83b85f ("btrfs-progs: mkfs: keep file descriptors
open during whole time") is making sure we're only closing the writeable
fds after the fs is properly created, there is still a missing fd not
following the requirement.

And this explains the issue why sometimes after mkfs.btrfs, lsblk still
doesn't give a valid uuid.

Shown by the strace output (the command is "mkfs.btrfs -f
/dev/test/scratch1"):

 openat(AT_FDCWD, "/dev/test/scratch1", O_RDWR) = 5 <<< Writeable open
 fadvise64(5, 0, 0, POSIX_FADV_DONTNEED) = 0
 sysinfo({uptime=2529, loads=[8704, 6272, 2496], totalram=4104548352, freeram=3376611328, sharedram=9211904, bufferram=43016192, totalswap=3221221376, freeswap=3221221376, procs=190, totalhigh=0, freehigh=0, mem_unit=1}) = 0
 lseek(5, 0, SEEK_END)                   = 10737418240
 lseek(5, 0, SEEK_SET)                   = 0
 ......
 close(5)                                = 0 <<< Closed now
 pwrite64(6, "O\250\22\261\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 16384, 1163264) = 16384
 pwrite64(6, "\201\316\272\342\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 16384, 1179648) = 16384
 pwrite64(6, "K}S\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 16384, 1196032) = 16384
 pwrite64(6, "\207j$\265\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 16384, 1212416) = 16384
 pwrite64(6, "q\267;\336\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 16384, 5242880) = 16384
 fsync(6) <<< But we're still writing into the disk.

[CAUSE]
After more digging, it turns out we have a very obvious escape in
open_ctree_fs_info():

open_ctree_fs_info()
|- fp = open(oca->filename, flags);
|- info = __open_ctree_fd();
|- close(fp);

As later we only do IO using the device fd, this close() seems fine.

But the truth is, for mkfs usage, this fs_info is a temporary one, with
a special magic number for the disk.
And since mkfs is doing writeable operations, this close() would
immediately trigger udev scan.

And since at this stage, the fs is not yet fully created, udev can race
with mkfs, and may get the invalid temporary superblock.

[FIX]
Introduce a new btrfs_fs_info member, initial_fd, for
open_ctree_fs_info() to record the fd.

And on close_ctree(), if we find fs_info::initial_fd is a valid fd, then
close it.

By this, we make sure all writeable fds are only closed after we have
written valid super blocks into the disk.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.h   | 9 +++++++++
 kernel-shared/disk-io.c | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index bcf11d870061..944632226baa 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -404,6 +404,15 @@ struct btrfs_fs_info {
 	u32 sectorsize;
 	u32 stripesize;
 	u32 leaf_data_size;
+
+	/*
+	 * For open_ctree_fs_info() to hold the initial fd until close.
+	 *
+	 * For writeable open_ctree_fs_info() call, we should not close
+	 * the fd until the fs_info is properly closed, or it will trigger
+	 * udev scan while our fs is not properly initialized.
+	 */
+	int initial_fd;
 	u16 csum_type;
 	u16 csum_size;
 
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index c053319200cb..05323b2cd393 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -913,6 +913,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	fs_info->metadata_alloc_profile = (u64)-1;
 	fs_info->system_alloc_profile = fs_info->metadata_alloc_profile;
 	fs_info->nr_global_roots = 1;
+	fs_info->initial_fd = -1;
 
 	return fs_info;
 
@@ -1690,7 +1691,10 @@ struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *oca)
 		return NULL;
 	}
 	info = __open_ctree_fd(fp, oca);
-	close(fp);
+	if (info)
+		info->initial_fd = fp;
+	else
+		close(fp);
 	return info;
 }
 
@@ -2297,6 +2301,8 @@ skip_commit:
 
 	btrfs_release_all_roots(fs_info);
 	ret = btrfs_close_devices(fs_info->fs_devices);
+	if (fs_info->initial_fd >= 0)
+		close(fs_info->initial_fd);
 	btrfs_cleanup_all_caches(fs_info);
 	btrfs_free_fs_info(fs_info);
 	if (!err)
-- 
2.43.0


