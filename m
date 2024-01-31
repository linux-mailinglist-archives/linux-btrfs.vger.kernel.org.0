Return-Path: <linux-btrfs+bounces-1974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58533844802
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 20:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27021F25AEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 19:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C633AC16;
	Wed, 31 Jan 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pebuakVd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0103E479
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729644; cv=none; b=P8CtWGDdLBQntopMGsigEEGv7VElTXQRWymR9z6+GNoJvJA3n2qNExfpolafgMLEYh2u50n/m5MMlvimuBgePLvYWDeFDM6mH2G/yqawxVUpO7+BZSWpA9qvOb4vGdTniCKFgBtDuitluv4QEKFEKCGEstTrGJUMsiHUBrQHgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729644; c=relaxed/simple;
	bh=DZk3i+EbDplK1q2qoAb7Uhjuhh8nbQgYqSzNVEynAmk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=O0hu+13r/jky6LTPNfWBkG4D5/BRTMkjx2xBQKY+iYttPDuszNI/l74HddVMR8ikqsViT9yWztUayVjOQsPI92sHlw+eGVHhnAuX/dWeAFfaMEjG5orzgOi05J2q7PIQPPoduif1vyW5GsuXTi8LR55WALZxnEqhOgOVMza6pPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=pebuakVd; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6818a9fe380so817046d6.2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 11:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706729641; x=1707334441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fACU4hHTGcf4mrKhTf9lHvFT5+tsQvST3N0gbZzwfs=;
        b=pebuakVdfYRKz72MJXA0RzWWKaz1IRcUtvEx25IxMbNMHL9gLwEDQJArfkL77ETgks
         in/f1eVl8QuqfZyIe/Ngt5wcvZNnRmU6EJ1I9ouwQaDDhq3cnD77p5cPbYoEd7He8AhJ
         VIpaGHv9gZcCW4bA12NT+zlFYhoLsemuBhfLJQS9GHmWNEFeuBIum1vZVg+iJd3HKpCA
         MGon8p1kQ/sdnN6qZliPnLo/LH44r1oLh0Rb64pFJeuBz5esC3ti8hn+mr01lj0B7/2D
         DDkv8HtbWPR9Wk3YL5LEKfr0Le+SHfWXRIFBklP3IDiy8jVoaYq9wIOxvlJPa3BimxdV
         lyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706729641; x=1707334441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fACU4hHTGcf4mrKhTf9lHvFT5+tsQvST3N0gbZzwfs=;
        b=gHRFGayEfP+KK0Ou3vuoRoVkbFmH+EwecRngr+yRczHOwhP2BaIPoPFEZ0LzRYcvpx
         MCAnfZXtaZnupPSKJT9Siv49x8owWyHkBe6SH3GBOkoDRIV84qeeOSmpp27CpNC0VBiA
         pDYVcJLt65IAQoLzasBAj6dzd4YGUl7KkzGB6Qblorg0A6MLUIEgSkFIs2WFd2SIgMhE
         FT9CrlbHc5DIQOf8pru0NnwonfwH/IWTgHw9u3MgQFIMKYwfCcYZvM2x+AJGNMwTATOE
         ForpK1lql9SHkdKd8gQvZP/3k1aO3ojDlgtaPorY/FeeJZMpoZKD83wKYtF5DrRn7rUH
         7+YQ==
X-Gm-Message-State: AOJu0YxgboWYTiMVfEILzeXYDUvOo/B/arq/w935LbvAI46JURjyjNDz
	YIiGxLBFge1XyP7+AJKfwjdgQ7HCvOkbN506WiGdKNAgKnlYVnXIp2HlP32nPoa/O5Uh37MpAUo
	D
X-Google-Smtp-Source: AGHT+IFF4DPbauNB30t7Fo1qK/wePduwLgJhUMkXSC0s9jdbmkZTeACktIV6OSDRfpJqFQjOWBZqqA==
X-Received: by 2002:ad4:5d42:0:b0:68c:3b04:49f4 with SMTP id jk2-20020ad45d42000000b0068c3b0449f4mr3444477qvb.64.1706729641339;
        Wed, 31 Jan 2024 11:34:01 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id mf15-20020a0562145d8f00b00686a080092bsm5794875qvb.1.2024.01.31.11.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 11:34:01 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: don't drop extent_map for free space inode on write error
Date: Wed, 31 Jan 2024 14:33:56 -0500
Message-ID: <280a4b489f58586b20bd195c84cf396098a784d5.1706729623.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While running the CI for an unrelated change I hit the following panic
with generic/648 on btrfs_holes_spacecache.

assertion failed: block_start != EXTENT_MAP_HOLE, in fs/btrfs/extent_io.c:1385
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent_io.c:1385!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 PID: 2695096 Comm: fsstress Kdump: loaded Tainted: G        W          6.8.0-rc2+ #1
RIP: 0010:__extent_writepage_io.constprop.0+0x4c1/0x5c0
Call Trace:
 <TASK>
 extent_write_cache_pages+0x2ac/0x8f0
 extent_writepages+0x87/0x110
 do_writepages+0xd5/0x1f0
 filemap_fdatawrite_wbc+0x63/0x90
 __filemap_fdatawrite_range+0x5c/0x80
 btrfs_fdatawrite_range+0x1f/0x50
 btrfs_write_out_cache+0x507/0x560
 btrfs_write_dirty_block_groups+0x32a/0x420
 commit_cowonly_roots+0x21b/0x290
 btrfs_commit_transaction+0x813/0x1360
 btrfs_sync_file+0x51a/0x640
 __x64_sys_fdatasync+0x52/0x90
 do_syscall_64+0x9c/0x190
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

This happens because we fail to write out the free space cache in one
instance, come back around and attempt to write it again.  However on
the second pass through we go to call btrfs_get_extent() on the inode to
get the extent mapping.  Because this is a new block group, and with the
free space inode we always search the commit root to avoid deadlocking
with the tree, we find nothing and return a EXTENT_MAP_HOLE for the
requested range.

This happens because the first time we try to write the space cache out
we hit an error, and on an error we drop the extent mapping.  This is
normal for normal files, but the free space cache inode is special.  We
always expect the extent map to be correct.  Thus the second time
through we end up with a bogus extent map.

Since we're deprecating this feature, the most straightforward way to
fix this is to simply skip dropping the extent map range for this failed
range.

I shortened the test by using error injection to stress the area to make
it easier to reproduce.  With this patch in place we no longer panic
with my error injection test.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6734717350e3..ca26e2c267f2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3182,8 +3182,23 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 			unwritten_start += logical_len;
 		clear_extent_uptodate(io_tree, unwritten_start, end, NULL);
 
-		/* Drop extent maps for the part of the extent we didn't write. */
-		btrfs_drop_extent_map_range(inode, unwritten_start, end, false);
+		/*
+		 * Drop extent maps for the part of the extent we didn't write.
+		 *
+		 * We have an exception here for the free_space_inode, this is
+		 * because when we do btrfs_get_extent() on the free space inode
+		 * we will search the commit root.  If this is a new block group
+		 * we won't find anything, and we will trip over the assert in
+		 * writepage where we do ASSERT(em->block_start !=
+		 * EXTENT_MAP_HOLE).
+		 *
+		 * Theoretically we could also skip this for any NOCOW extent as
+		 * we don't mess with the extent map tree in the NOCOW case, but
+		 * for now simply skip this if we are the free space inode.
+		 */
+		if (!btrfs_is_free_space_inode(inode))
+			btrfs_drop_extent_map_range(inode, unwritten_start,
+						    end, false);
 
 		/*
 		 * If the ordered extent had an IOERR or something else went
-- 
2.43.0


