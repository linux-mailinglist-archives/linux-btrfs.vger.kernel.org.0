Return-Path: <linux-btrfs+bounces-7364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D40F959AF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 13:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B754B1F243A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 11:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4309D1B2EF3;
	Wed, 21 Aug 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9uslCvO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F761BA26C;
	Wed, 21 Aug 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240797; cv=none; b=rCJ5TWxt9Tyb6LxPRy3MVpgb7NP6V+z3zWwCm9twGA8ghg0j38p+Low3iYObMeQDSqkf0LaJZH1ZmQS9/4yvn/KD87tElck6SQ2BpXspqWDs3AnhKoSU4kYebyVoFPHwdNNBgSKOaiov8IAal5V7f8h5BbUvGEz9PUUMdnwOtSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240797; c=relaxed/simple;
	bh=TRRFUD0axKH2Dc16kuha505qsbky9IfLxik8ATNrwrY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HC6+NQ/VdzOLLB5wrZaQ6vQgjsvssNMiZawxJ6BJEY0zQbJqb+O3gyzOWstggjTC5YtJNc/OPnzFTJizxM4I7Dj0M5d/0+TCkoBQOCiEmdcEBUwPU823EsMKqnia5JDukFJpjosTp8iKQJXjAwYfJLPdyZAD5715Vh47yLKfXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9uslCvO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201f7fb09f6so47828485ad.2;
        Wed, 21 Aug 2024 04:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724240795; x=1724845595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sK/Ke7C2jpf7KWdx8g1GMOzWj9txiBHskLjIjZ4El28=;
        b=M9uslCvO35DM1w2wzzN0Y1rqdxvIhJbLFDszkDU93zy8gSv5fVMMjwVHbFpGM4RbNc
         659eOkpplsQy0hjnasvr3O3uO5S5f5WK28Xd363y5deXl5phsGcDAgYPkuQXfOyT9dXO
         nJ1RVgIQFXkPArrZlExpFo+KnclUqeKe/JV0lqnNrbDUAzgHxSG3K6canxnCGLzQq3jP
         K21leZ+pQ1HAyhI1CSXJ/H9398puEc4XJqtGsNVmgKODqifF8qGZPv6IUwz8tENDnF8u
         nMS/U78RWc5LkLDyRccKcRfZxZjTN9qzqOc1d+Gm1DZa6zOd/XBrrlG3HHl00anjTjcy
         g6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724240795; x=1724845595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sK/Ke7C2jpf7KWdx8g1GMOzWj9txiBHskLjIjZ4El28=;
        b=tP4TsMtUyYef3GGQ6lp2doE7jB3f0rNGH0PeHozBPV2GY969e0V9c7cgx9rolKwncP
         zJtAWQDkjMUvztlPVCin89jZadmv89njvHHM5hgYpJDldCZQ6mcXZF0JBInuOeVhLhrB
         uFug/G3K6eoAiCFGWGT//kjmkoM8xHgbkRWSH23Rf412Al2TG3fVlJzaczP+RI8YMPxl
         cu1/CjiNKiFHMHnuEGNM6w1eDOXlj5zoxEpv4DdTny1SYPDxxvm2hZfrEa6Xm9Fwko2a
         vhduKmFpqw0HnHcXXi77FJoMDdEGEcEbAEuNllMsnrqROT5aDD0xiHofsGepsdp2wZdc
         LCdg==
X-Forwarded-Encrypted: i=1; AJvYcCV+pEapRkyRIBmH8kxZ7UHdYBGFZl5amDTyqwKV5VN+5K6FJP+Dm2tam+UH0GwnW3hssSb9yws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuQBX1IFSF0FX4vZkiWvy2ajqwJYw9ONY8bgFPEnBD61ar1Ozn
	2vKJPx3P9+OrobJ4dLzgPlhr1VNfAqriDVwFl3aXEaBNI0Hwg2GfGldAwnGG7ag=
X-Google-Smtp-Source: AGHT+IFOFSYgDosIMZaVGIdsunnc0tqd3F3USjkCnUlBYJiEJct/pIPdqKpMyiAm2LS9FJU42XeAEQ==
X-Received: by 2002:a17:902:d2c3:b0:202:2f0:3bb2 with SMTP id d9443c01a7336-20368199f53mr21210435ad.60.1724240794548;
        Wed, 21 Aug 2024 04:46:34 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037526csm91653515ad.122.2024.08.21.04.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:46:33 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	Julian Sun <sunjunchao2870@gmail.com>,
	syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: fix the race between umount and btrfs-cleaner
Date: Wed, 21 Aug 2024 19:46:28 +0800
Message-Id: <20240821114628.645455-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race condition generic_shutdown_super() and
__btrfs_run_defrag_inode().
Consider the following scenario:

umount thread:             btrfs-cleaner thread:
			     btrfs_run_delayed_iputs()
			       ->run_delayed_iput_locked()
				->iput(inode)
				  // Here the inode (ie ino 261) will be cleared and freed
btrfs_kill_super()
  ->generic_shutdown_super()
    			     btrfs_run_defrag_inodes()
			       ->__btrfs_run_defrag_inode()
				->btrfs_iget(ino)
				// The inode 261 was recreated with i_count=1
				// and added to the sb list
    ->evict_inodes(sb)          // After some work
    // inode 261 was added      ->iput(inode)
    // to the dispose list        ->iput_funal()
      ->evict(inode)                ->evict(inode)

Now, we have two threads simultaneously evicting
the same inode, which led to a bug.

The above behavior can be confirmed by the log I added for debugging
and the log printed when BUG was triggered.
Due to space limitations, I cannot paste the full diff and here is a
brief describtion.

First, within __btrfs_run_defrag_inode(), set inode->i_state |= (1<<19)
just before calling iput().
Within the dispose_list(), check the flag, if the flag was set, then
pr_info("bug! double evict! crash will happen! state is 0x%lx\n", inode->i_state);

Here is the printed log when the BUG was triggered:
[  190.686726][ T2336] bug! double evict! crash will happen! state is 0x80020
[  190.687647][ T2336] ------------[ cut here ]------------
[  190.688294][ T2336] kernel BUG at fs/inode.c:626!
[  190.688939][ T2336] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  190.689792][ T2336] CPU: 1 PID: 2336 Comm: a.out Not tainted 6.10.0-rc2-00223-g0c529ab65ef8-dirty #109
[  190.690894][ T2336] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  190.692111][ T2336] RIP: 0010:clear_inode+0x15b/0x190
// some logs...
[  190.704501][ T2336]  btrfs_evict_inode+0x529/0xe80
[  190.706966][ T2336]  evict+0x2ed/0x6c0
[  190.707209][ T2336]  dispose_list+0x62/0x260
[  190.707490][ T2336]  evict_inodes+0x34e/0x450

To prevent this behavior, we need to set BTRFS_FS_CLOSING_START
before kill_anon_super() to ensure that
btrfs_run_defrag_inodes() doesn't continue working after unmount.

Reported-and-tested-by: syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=67ba3c42bcbb4665d3ad
CC: stable@vger.kernel.org
Fixes: c146afad2c7f ("Btrfs: mount ro and remount support")
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/btrfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f05cce7c8b8d..f7e87fe583ab 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2093,6 +2093,7 @@ static int btrfs_get_tree(struct fs_context *fc)
 static void btrfs_kill_super(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	set_bit(BTRFS_FS_CLOSING_START, &fs_info->flags);
 	kill_anon_super(sb);
 	btrfs_free_fs_info(fs_info);
 }
-- 
2.39.2


