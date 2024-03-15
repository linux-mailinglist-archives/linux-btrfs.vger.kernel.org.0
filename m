Return-Path: <linux-btrfs+bounces-3322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7EC87CD7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 13:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9AD1C22208
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 12:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F8D25565;
	Fri, 15 Mar 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCRnxo1u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D5250E2
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507359; cv=none; b=LDL5lNJjT2exLmxEiNNGtKkATzamjY2gOA/yoAs3ak5j4KM2fwmjbtlxOj3kk/mjMtaPvhDg3s2BOWid+30RTgI88wWJRLqn/YEyO8QH3241B+P+SrzukYKHlIXYV5jwKARFhsZRc8ViDr0GkPFqkhtsX8ppX/T0Oo8yA9Aurk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507359; c=relaxed/simple;
	bh=2F96YG1ToDWWPydaoCjNGP5ZVmHJqa70vaDH5vYXocU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+YrYrmTmqPA4JUCvKEYjha4eDXPIzPqi3cWDDbeTUyGYhDy3c/xfp8iUOdxfVddmFE5gMabLcxeIvlOQH4bORjm5czpY5pxh7f8hZUoBtswm0IYfW4h8OyjBQ7wDFS4/A0AyK7RNfwqW9xSZsV1PiLtCAJwDPETJoqH/P8pL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCRnxo1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270E0C433F1
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710507358;
	bh=2F96YG1ToDWWPydaoCjNGP5ZVmHJqa70vaDH5vYXocU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oCRnxo1uE29AzxaEDUaEQR7MVoT27ZjOu0/XVMa57e6a3ghNADkAqJutarmX1wcVL
	 tuH1HoCM6yE40lKsch1GOB9KSycshUtCEQPlQTWcj6kBWi1xRWDN2kBmcN63jIIi3f
	 N3QS3iVjnez7bq57r7VCxDWltQdC34Z2mHYeOJ6ufZaQhS9vVKDEBVbj2T2CjkoRhV
	 bAGeGKFkFodSzHzwmdW+U41r4KoQO0vy+e9D/CuTOBWILvdpxBS/a/F5tRPO9CsUVF
	 Irl8JyUcCvck5eMF9/4mlapBxPB2tyhdgdinoVlu7ALAzBPa3C9fZs1ps9sx6N07wb
	 i634I7nBF2H7w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: inline btrfs_tree_lock() and btrfs_tree_read_lock()
Date: Fri, 15 Mar 2024 12:55:52 +0000
Message-Id: <b281571ee54c81fac0861b7d896497501fa3f278.1710506834.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710506834.git.fdmanana@suse.com>
References: <cover.1710506834.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The functions btrfs_tree_lock() and btrfs_tree_read_lock() are very
trivial so that can be made inline and avoid call overhead, as they
are very often called inside critical sections (when searching a btree
for example, attempting to lock a child node/leaf while holding a lock
on the parent).

So make them static inline, which even reduces the size of the btrfs
module a little bit.

Before this change:

   $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
   1718786	 156276	  16920	1891982	 1cde8e	fs/btrfs/btrfs.ko

After this change:

   $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
   1718650	 156260	  16920	1891830	 1cddf6	fs/btrfs/btrfs.ko

Running fs_mark also showed a tiny improvement with this script:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/nullb0
   MNT=/mnt/nullb0
   FILES=100000
   THREADS=$(nproc --all)

   echo "performance" | \
       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

   umount $DEV &> /dev/null
   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   OPTS="-S 0 -L 5 -n $FILES -s 0 -t $THREADS -k"
   for ((i = 1; i <= $THREADS; i++)); do
        OPTS="$OPTS -d $MNT/d$i"
   done

   fs_mark $OPTS

   umount $MNT

Before this change:

   FSUse%        Count         Size    Files/sec     App Overhead
       10      1200000            0     180894.0         10705410
       16      2400000            0     228211.4         10765738
       23      3600000            0     215969.6         11011072
       30      4800000            0     199077.1         11145587
       46      6000000            0     176624.1         11658470

After this change:

   FSUse%        Count         Size    Files/sec     App Overhead
       10      1200000            0     185312.3         10708377
       16      2400000            0     229320.4         10858013
       23      3600000            0     217958.7         11006167
       30      4800000            0     205122.9         11112899
       46      6000000            0     178039.1         11438852

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/locking.c | 10 ----------
 fs/btrfs/locking.h | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 99ccab86bb86..1f355ca65910 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -147,11 +147,6 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
 	trace_btrfs_tree_read_lock(eb, start_ns);
 }
 
-void btrfs_tree_read_lock(struct extent_buffer *eb)
-{
-	__btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL);
-}
-
 /*
  * Try-lock for read.
  *
@@ -211,11 +206,6 @@ void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
 	trace_btrfs_tree_lock(eb, start_ns);
 }
 
-void btrfs_tree_lock(struct extent_buffer *eb)
-{
-	__btrfs_tree_lock(eb, BTRFS_NESTING_NORMAL);
-}
-
 /*
  * Release the write lock.
  */
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 9576f485a300..c30aff66e86f 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -164,11 +164,21 @@ static_assert(BTRFS_NESTING_MAX <= MAX_LOCKDEP_SUBCLASSES,
 	      "too many lock subclasses defined");
 
 void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest);
-void btrfs_tree_lock(struct extent_buffer *eb);
+
+static inline void btrfs_tree_lock(struct extent_buffer *eb)
+{
+	__btrfs_tree_lock(eb, BTRFS_NESTING_NORMAL);
+}
+
 void btrfs_tree_unlock(struct extent_buffer *eb);
 
 void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest);
-void btrfs_tree_read_lock(struct extent_buffer *eb);
+
+static inline void btrfs_tree_read_lock(struct extent_buffer *eb)
+{
+	__btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL);
+}
+
 void btrfs_tree_read_unlock(struct extent_buffer *eb);
 int btrfs_try_tree_read_lock(struct extent_buffer *eb);
 int btrfs_try_tree_write_lock(struct extent_buffer *eb);
-- 
2.43.0


