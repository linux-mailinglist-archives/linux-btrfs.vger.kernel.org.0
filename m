Return-Path: <linux-btrfs+bounces-5265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0758CDAF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 21:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229EB281097
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 19:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6532284A34;
	Thu, 23 May 2024 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="pSzVyX/l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61584052
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492889; cv=none; b=GojLsI1gbYxCCCtwm4EUZEpNoKSUXP2YqhrDpWHUZolwmA3nzlqDn97TZV5V9wsI2IeT6sA59SOh+6hASjdSp8O3UT04L1jfCNoZHn44V8voIriMAzKsGOiqQx0mct9fe44tgDedyjQo1tyA1P9L6bcvCNsz0mRkCrYjbzcCMes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492889; c=relaxed/simple;
	bh=HiRA5ItmVPNrpvJ81os1rMxaRTytwEWH0x9x7lMbbBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BvUfldJIB+gwspSuQ7ZZznQZZrImBGKiAfCHjMRarBHuahERZEsiZuS+hUqYRrR1y3BRHoFS5asxYN1sLuawTJpKixugq2WYj8ijZaub/mfw3BZIdGNtOGyL1CO94gXVEgU1lPgudMphFUaooG2hSFCo2S+nYeF1SZ+H09WTb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=pSzVyX/l; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f449f09476so434725ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 12:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1716492886; x=1717097686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNM2Ce+xrlYfa0V0x7k6sQeMpeSiUz3tcosjeKj+fv4=;
        b=pSzVyX/lWgdW64s+Z8551BLEqDkfsaUHtm5rT7b8Sn1Q/Kc2i1GzHAI+df+5WdRTHw
         ZJqE1LSBAxnxT+o6hye+FGnEUCZyzwm+l+eCfovkO3v5BW8gKk8bfJIpCFot6IZ4NDRT
         6SBxGreRwW7JQhU6wkrlJ2fCAUF8JRobcZTG39VeXySrhNF0yMXhoSRYRmrLyVAuRrVZ
         G2oWlVIOaHOW2013dnhCsStr41D49ECls0n06VE6PcBTEpiJ1tdvmFqmVIDFrgh0mUcd
         vjBbpoYXO334Bzx0CthQj06ptGjPciiGt///arbinAsYDVFabDAx2DpGGH02eKpTd4Is
         rebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716492886; x=1717097686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNM2Ce+xrlYfa0V0x7k6sQeMpeSiUz3tcosjeKj+fv4=;
        b=K/3j/q71eOiGDU7t80D0ooQBAj/VpHV1lDVxFqnadrt8avaKkr8BOrnFBG29eq9BF+
         xoXT/6NGY9EBFFkqsdwjKLi2mI0QfRALmSDHb0BVRk9T0wdkzl4GXc+Gw3zf60dptt+J
         EGFNdGkPs3tLcJutghHGTsiGaQjkCiIJtCQrGyWnFYe+QfkwAGBhHrBtb+5VDUtoXVdh
         5VG/YblWQB+YyIg69XCwHGibhSUfa78sluQfApwZsYBhqoOjqh5wYsQHxBv2jw8VeQtF
         CXEQp1+vKzaT3bxEqlfRQsFNvSm3WTO+OXzVmq7IDsxDeIcLsAiXIfHslhznaYR+dU+u
         lQTg==
X-Gm-Message-State: AOJu0Yy5vMJkyxCsyc45/8yXL+FU3HzUgmxlbc5gwtwmSy0yfx/2X7kG
	yZiTtw+2ifgauhdM95sLzvMgAoAPc36hJ6BtO5Y1E02rBx2K0cPl/JK2K0P79kDfbgSFaf1FtXl
	1R5s=
X-Google-Smtp-Source: AGHT+IHm70tI6TXBx3C+eHNHNwgzK/umlNRHVYhp4MV8Ma5R8BPzw37E1W6VwDR8VRmdQFYVl7S1DA==
X-Received: by 2002:a17:903:1cf:b0:1f3:f8c:559b with SMTP id d9443c01a7336-1f4481f09ccmr4727535ad.21.1716492886370;
        Thu, 23 May 2024 12:34:46 -0700 (PDT)
Received: from telecaster.tfbnw.net ([2620:10d:c090:400::5:f769])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f3465fdcf4sm13852635ad.60.2024.05.23.12.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:34:45 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH] btrfs: fix crash on racing fsync and size-extending direct I/O into prealloc
Date: Thu, 23 May 2024 12:34:24 -0700
Message-ID: <101430650a35b55b7a32d895fd292226d13346eb.1716486455.git.osandov@fb.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

We have been seeing crashes on duplicate keys in
btrfs_set_item_key_safe():

  BTRFS critical (device vdb): slot 4 key (450 108 8192) new key (450 108 8192)
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/ctree.c:2620!
  invalid opcode: 0000 [#1] PREEMPT SMP PTI
  CPU: 0 PID: 3139 Comm: xfs_io Kdump: loaded Not tainted 6.9.0 #6
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
  RIP: 0010:btrfs_set_item_key_safe+0x11f/0x290 [btrfs]

With the following stack trace:

  #0  btrfs_set_item_key_safe (fs/btrfs/ctree.c:2620:4)
  #1  btrfs_drop_extents (fs/btrfs/file.c:411:4)
  #2  log_one_extent (fs/btrfs/tree-log.c:4732:9)
  #3  btrfs_log_changed_extents (fs/btrfs/tree-log.c:4955:9)
  #4  btrfs_log_inode (fs/btrfs/tree-log.c:6626:9)
  #5  btrfs_log_inode_parent (fs/btrfs/tree-log.c:7070:8)
  #6  btrfs_log_dentry_safe (fs/btrfs/tree-log.c:7171:8)
  #7  btrfs_sync_file (fs/btrfs/file.c:1933:8)
  #8  vfs_fsync_range (fs/sync.c:188:9)
  #9  vfs_fsync (fs/sync.c:202:9)
  #10 do_fsync (fs/sync.c:212:9)
  #11 __do_sys_fdatasync (fs/sync.c:225:9)
  #12 __se_sys_fdatasync (fs/sync.c:223:1)
  #13 __x64_sys_fdatasync (fs/sync.c:223:1)
  #14 do_syscall_x64 (arch/x86/entry/common.c:52:14)
  #15 do_syscall_64 (arch/x86/entry/common.c:83:7)
  #16 entry_SYSCALL_64+0xaf/0x14c (arch/x86/entry/entry_64.S:121)

So we're logging a changed extent from fsync, which is splitting an
extent in the log tree. But this split part already exists in the tree,
triggering the BUG().

This is the state of the log tree at the time of the crash, dumped with
drgn (https://github.com/osandov/drgn/blob/main/contrib/btrfs_tree.py)
to get more details than btrfs_print_leaf() gives us:

  >>> print_extent_buffer(prog.crashed_thread().stack_trace()[0]["eb"])
  leaf 33439744 level 0 items 72 generation 9 owner 18446744073709551610
  leaf 33439744 flags 0x100000000000000
  fs uuid e5bd3946-400c-4223-8923-190ef1f18677
  chunk uuid d58cb17e-6d02-494a-829a-18b7d8a399da
          item 0 key (450 INODE_ITEM 0) itemoff 16123 itemsize 160
                  generation 7 transid 9 size 8192 nbytes 8473563889606862198
                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                  sequence 204 flags 0x10(PREALLOC)
                  atime 1716417703.220000000 (2024-05-22 15:41:43)
                  ctime 1716417704.983333333 (2024-05-22 15:41:44)
                  mtime 1716417704.983333333 (2024-05-22 15:41:44)
                  otime 17592186044416.000000000 (559444-03-08 01:40:16)
          item 1 key (450 INODE_REF 256) itemoff 16110 itemsize 13
                  index 195 namelen 3 name: 193
          item 2 key (450 XATTR_ITEM 1640047104) itemoff 16073 itemsize 37
                  location key (0 UNKNOWN.0 0) type XATTR
                  transid 7 data_len 1 name_len 6
                  name: user.a
                  data a
          item 3 key (450 EXTENT_DATA 0) itemoff 16020 itemsize 53
                  generation 9 type 1 (regular)
                  extent data disk byte 303144960 nr 12288
                  extent data offset 0 nr 4096 ram 12288
                  extent compression 0 (none)
          item 4 key (450 EXTENT_DATA 4096) itemoff 15967 itemsize 53
                  generation 9 type 2 (prealloc)
                  prealloc data disk byte 303144960 nr 12288
                  prealloc data offset 4096 nr 8192
          item 5 key (450 EXTENT_DATA 8192) itemoff 15914 itemsize 53
                  generation 9 type 2 (prealloc)
                  prealloc data disk byte 303144960 nr 12288
                  prealloc data offset 8192 nr 4096
  ...

So the real problem happened earlier: notice that items 4 (4k-12k) and 5
(8k-12k) overlap. Both are prealloc extents. Item 4 straddles i_size and
item 5 starts at i_size.

Here is the state of the filesystem tree at the time of the crash:

  >>> root = prog.crashed_thread().stack_trace()[2]["inode"].root
  >>> ret, nodes, slots = btrfs_search_slot(root, BtrfsKey(450, 0, 0))
  >>> print_extent_buffer(nodes[0])
  leaf 30425088 level 0 items 184 generation 9 owner 5
  leaf 30425088 flags 0x100000000000000
  fs uuid e5bd3946-400c-4223-8923-190ef1f18677
  chunk uuid d58cb17e-6d02-494a-829a-18b7d8a399da
  	...
          item 179 key (450 INODE_ITEM 0) itemoff 4907 itemsize 160
                  generation 7 transid 7 size 4096 nbytes 12288
                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                  sequence 6 flags 0x10(PREALLOC)
                  atime 1716417703.220000000 (2024-05-22 15:41:43)
                  ctime 1716417703.220000000 (2024-05-22 15:41:43)
                  mtime 1716417703.220000000 (2024-05-22 15:41:43)
                  otime 1716417703.220000000 (2024-05-22 15:41:43)
          item 180 key (450 INODE_REF 256) itemoff 4894 itemsize 13
                  index 195 namelen 3 name: 193
          item 181 key (450 XATTR_ITEM 1640047104) itemoff 4857 itemsize 37
                  location key (0 UNKNOWN.0 0) type XATTR
                  transid 7 data_len 1 name_len 6
                  name: user.a
                  data a
          item 182 key (450 EXTENT_DATA 0) itemoff 4804 itemsize 53
                  generation 9 type 1 (regular)
                  extent data disk byte 303144960 nr 12288
                  extent data offset 0 nr 8192 ram 12288
                  extent compression 0 (none)
          item 183 key (450 EXTENT_DATA 8192) itemoff 4751 itemsize 53
                  generation 9 type 2 (prealloc)
                  prealloc data disk byte 303144960 nr 12288
                  prealloc data offset 8192 nr 4096

Item 5 in the log tree corresponds to item 183 in the filesystem tree,
but nothing matches item 4. Furthermore, item 183 is the last item in
the leaf.

btrfs_log_prealloc_extents() is responsible for logging prealloc extents
beyond i_size. It first truncates any previously logged prealloc extents
that start beyond i_size. Then, it walks the filesystem tree and copies
the prealloc extent items to the log tree.

If it hits the end of a leaf, then it calls btrfs_next_leaf(), which
unlocks the tree and does another search. However, while the filesystem
tree is unlocked, an ordered extent completion may modify the tree. In
particular, it may insert an extent item that overlaps with an extent
item that was already copied to the log tree.

This may manifest in several ways depending on the exact scenario,
including an EEXIST error that is silently translated to a full sync,
overlapping items in the log tree, or this crash. This particular crash
is triggered by the following sequence of events:

- Initially, the file has i_size=4k, a regular extent from 0-4k, and a
  prealloc extent beyond i_size from 4k-12k. The prealloc extent item is
  the last item in its B-tree leaf.
- The file is fsync'd, which copies its inode item and both extent items
  to the log tree.
- An xattr is set on the file, which sets the
  BTRFS_INODE_COPY_EVERYTHING flag.
- The range 4k-8k in the file is written using direct I/O. i_size is
  extended to 8k, but the ordered extent is still in flight.
- The file is fsync'd. Since BTRFS_INODE_COPY_EVERYTHING is set, this
  calls copy_inode_items_to_log(), which calls
  btrfs_log_prealloc_extents().
- btrfs_log_prealloc_extents() finds the 4k-12k prealloc extent in the
  filesystem tree. Since it starts before i_size, it skips it. Since it
  is the last item in its B-tree leaf, it calls btrfs_next_leaf().
- btrfs_next_leaf() unlocks the path.
- The ordered extent completion runs, which converts the 4k-8k part of
  the prealloc extent to written and inserts the remaining prealloc part
  from 8k-12k.
- btrfs_next_leaf() does a search and finds the new prealloc extent
  8k-12k.
- btrfs_log_prealloc_extents() copies the 8k-12k prealloc extent into
  the log tree. Note that it overlaps with the 4k-12k prealloc extent
  that was copied to the log tree by the first fsync.
- fsync calls btrfs_log_changed_extents(), which tries to log the 4k-8k
  extent that was written.
- This tries to drop the range 4k-8k in the log tree, which requires
  adjusting the start of the 4k-12k prealloc extent in the log tree to
  8k.
- btrfs_set_item_key_safe() sees that there is already an extent
  starting at 8k in the log tree and calls BUG().

Fix this by detecting when we're about to insert an overlapping file
extent item in the log tree and truncating the part that would overlap.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Hi,

I'm not sure if this is the best way to fix the problem, but hopefully
the commit message has enough detail to brainstorm a better solution if
not. I've also included an fstest that reproduces the issue.

Based on misc-next.

Thanks,
Omar


 fs/btrfs/tree-log.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 51a167559ae8..a7efd23acf50 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4783,6 +4783,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	bool dropped_extents = false;
 	u64 truncate_offset = i_size;
 	struct extent_buffer *leaf;
+	struct btrfs_file_extent_item *ei;
 	int slot;
 	int ins_nr = 0;
 	int start_slot = 0;
@@ -4811,8 +4812,6 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 		goto out;
 
 	if (ret == 0) {
-		struct btrfs_file_extent_item *ei;
-
 		leaf = path->nodes[0];
 		slot = path->slots[0];
 		ei = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
@@ -4863,18 +4862,26 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 			path->slots[0]++;
 			continue;
 		}
-		if (!dropped_extents) {
-			/*
-			 * Avoid logging extent items logged in past fsync calls
-			 * and leading to duplicate keys in the log tree.
-			 */
+		/*
+		 * Avoid overlapping items in the log tree. The first time we
+		 * get here, get rid of everything from a past fsync. After
+		 * that, if the current extent starts before the end of the last
+		 * extent we copied, truncate the last one. This can happen if
+		 * an ordered extent completion modifies the subvolume tree
+		 * while btrfs_next_leaf() has the tree unlocked.
+		 */
+		if (!dropped_extents || key.offset < truncate_offset) {
 			ret = truncate_inode_items(trans, root->log_root, inode,
-						   truncate_offset,
+						   min(key.offset,
+						       truncate_offset),
 						   BTRFS_EXTENT_DATA_KEY);
 			if (ret)
 				goto out;
 			dropped_extents = true;
 		}
+		ei = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
+		truncate_offset = (key.offset +
+				   btrfs_file_extent_num_bytes(leaf, ei));
 		if (ins_nr == 0)
 			start_slot = slot;
 		ins_nr++;
-- 
2.45.1


