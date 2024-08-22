Return-Path: <linux-btrfs+bounces-7404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F8095B40F
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 13:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3551F22E70
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE511C93DE;
	Thu, 22 Aug 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSyI/V2d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF717A584;
	Thu, 22 Aug 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326898; cv=none; b=izCVILMlB4YNcpHf7K57JCz/MAg0zu2ACxWulmiYcixaRnmUxbduSj29QU5J0oA64s343LKkv8rV01HL2Jaa9uNLoOTaAFuZQSuSKA2bjs3GofS+17OJC+3wXk8DCy0yAcz/+p8m1nqUqpvlPaD4RZSNKWUm/DT9v2nxom8rrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326898; c=relaxed/simple;
	bh=58k+EK0uz9VZEQWT5oIuY/GelOZLcOZe1onvQSj93UM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuMmyUVjl/CuxkOHnmVbVbahmNoajw10j6Ekp7vvNG9DlmoRHdfOW0YLxQSOYwe3KFeF4lmX4NcU+XFPUAgf0SLvR09A1z8V0k1TSuLKI/LWszFYjBaPgbyrPNYY5StDOsp3NbBhadrfg9Z7eSiqFn5Ti81Ml7dCG4lerj8GcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSyI/V2d; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3d0b06a2dso550736a91.0;
        Thu, 22 Aug 2024 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724326896; x=1724931696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Be5M2+00B/TcfeJVQOceNm0Gn8MZuRdB3WRZWzpxOwM=;
        b=BSyI/V2dD6p7/vy97G+FUsRVPzQ+6CQhU8zI6y9EVwbge7NCFe3haNF4QrvxBTcUpQ
         zuN+EJLrVzRQaXHPGPLgKvBg/DE0lw0dRhWdNP9ZCtCbVPtkYmADIL8Ylu+CmwYykJvE
         Jl3sjbIXJmp/j3kaZsNDX8QUlW4tx6CYhsQMmjtCJuAPhUyAnuDi+ZX/utfudglF06r8
         Fe7/aPUwte8AtZpcyf7xjpdVEnfo9FXjwO4GiJ0XHw355RIktHKIhiWqGMa+2SpQv+YX
         meYRuP2ssHu9TjQCfzkfMiaVfTy1BqOX17IK6sqKzETtxkH5RW6RKQawwCL2pZn8J+IG
         6+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724326896; x=1724931696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Be5M2+00B/TcfeJVQOceNm0Gn8MZuRdB3WRZWzpxOwM=;
        b=o9XHdl424894QrgyvZ2M7GYfFlF7YutqcESDiTiCcQoOBRutXGQvbcYqGRPwP+pVND
         oTwx5dC+58iDVI4pU9puAxeJy+dO80AAxYbWch9iGT5DFdsJKYmyENJY6gTHQGzRG5I6
         hh0U/oVWPfAdYWL7LzPhiSeTjlfFtoJyg7iEgIvntbZFblcrpv3ssNZku+U0QMYr7C/Z
         9ULazd5kq8DGtsQrFX/Ncqi3ieUH54TbUl2O02fLo1aKS5ccVPKlr4mStoMG/L3lbEMh
         UDO4dHf5P6i9xj+UwWE8t0uTX7trsKof9B95F+sxC0rsVshyw0r0z42qi3VfZkOSwWXi
         4E9w==
X-Forwarded-Encrypted: i=1; AJvYcCUX/FjY86uctCFZcyqVo8PTnM1dMzpolVORq8dC/f6jHOpyIZjbx+giVQHNEKLBWfQQQv3A8ONQzc5GMA==@vger.kernel.org, AJvYcCXJOhGBWXAEQ0Mncavw3/gxi0fy5yNNt7qUBn5UmYpQmQ3e8Tr5kSb1UDnn3UOMxkjk4Iy3+Vg4@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvO5dgxXhzn5D0I0Csfz7KM3nIRIi+jECwV1Af970RMG6SE0y
	ynHTGPh9F1mf9kRRBkha3ZbGPULHwLqZngkukffMEkoCRGohzkkV
X-Google-Smtp-Source: AGHT+IGxs5TD/I41bqPlYEJcDzydF4C5MOASYBdcJ9YOKvQXmfRKtyNDCRJfLlE8m7RclnIi94TLIg==
X-Received: by 2002:a17:90a:ff04:b0:2cd:49c6:e2d7 with SMTP id 98e67ed59e1d1-2d616b242c5mr1608195a91.19.1724326896337;
        Thu, 22 Aug 2024 04:41:36 -0700 (PDT)
Received: from localhost ([123.113.110.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5c2e1605bsm4235079a91.1.2024.08.22.04.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 04:41:35 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: josef@toxicpanda.com
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org,
	sunjunchao2870@gmail.com,
	syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix the race between umount and btrfs-cleaner
Date: Thu, 22 Aug 2024 19:41:31 +0800
Message-Id: <20240822114131.1350726-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821180804.GF1998418@perftesting>
References: <20240821180804.GF1998418@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Josef.
Thanks for your review and comments.
Yeah, you are correct, sorry for the mistake.

I'm thinking if is there any misunderstanding in the following scenario

umount thread:                     btrfs-cleaner thread:
                                   btrfs_run_delayed_iputs()
                                     ->run_delayed_iput_locked()
                                       ->iput(inode)
                                         ->spin_lock(inode)
 				         // inode->i_count dec to 0
                                         ->iput_final()
                                           ->__inode_add_lru()
                                            // mapping_shrinkable() returned false
                                            // so iput_final() returned with i_count=0
                                            // note here: the inode still
 btrfs_kill_super()                         // in the sb list and I_FREEING
   ->generic_shutdown_super()               // was not set
     ->evict_inodes()                       ->spin_unlock(inode)
      ->spin_lock(inode)
      // i_count is 0 and                // continue running...
      // I_FREEING was not set           ->__btrfs_run_defrag_inode()
      // so the inode was added to         ->btrfs_iget()
      // dispost list                        // note the inode is still
                                             // in the sb list  
                                             // and I_WILL_FREE|I_FREEING
                                             // was not set
  ->spin_unlock()                            ->find_inode()
                                              ->spin_lock(inode)
                                              ->__iget();
                                              ->spin_unlock();
  ->dispose_list()                           
    ->evict()                             ->iput()
     // note: i_lock was not                ->spin_lock(inode)
     // hold here.                          ->iput_final()
                                              ->spin_unlock()
                                              ->evict()

Now, we have two threads simultaneously evicting
the same inode, which led to a bug.

The key points here are:
1. btrfs-cleaner: iput_final() called __inode_add_lru() and then
return because some reason with i_count=0, and I_FREEING was not set, 
and most important, i_lock was unlocked,
which gives evict_inodes() a perfect chance to put the inode into dispose list.
2. umount thread: The inode (which i_count is 0 and I_FREEING was not set) 
was added to dispose list.
3. btrfs-cleaner: Before umount thread set I_FREEING flag, btrfs_iget()
finded the inode and inc i_count
4. umount thread called evict() and btrfs-cleaner called iput(), which leads 
to bug.

The above behavior can be confirmed by the debugging log 
based on commit d30d0e49da71:

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 407ccec3e57e..cc50dd1e8beb 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -278,6 +278,8 @@ static int __btrfs_run_defrag_inode(struct
btrfs_fs_info *fs_info,
 	ret = btrfs_defrag_file(inode, NULL, &range, defrag->transid,
 				       BTRFS_DEFRAG_BATCH);
 	sb_end_write(fs_info->sb);
+	if (inode->i_state & (1<<19))
+		pr_info("bug! double evict! crash will happen\n");
 	iput(inode);
 
 	if (ret < 0)
diff --git a/fs/inode.c b/fs/inode.c
index 3a41f83a4ba5..641a828bc2b7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -461,8 +461,14 @@ static void __inode_add_lru(struct inode *inode,
bool rotate)
 		return;
 	if (!(inode->i_sb->s_flags & SB_ACTIVE))
 		return;
-	if (!mapping_shrinkable(&inode->i_data))
+	if (!mapping_shrinkable(&inode->i_data)) {
+		if (inode->i_ino == 261) {
+			pr_info("set inode 0x%px dbg_flag casue
mapping_shrinkable\n", inode);
+			dump_stack();
+			WRITE_ONCE(inode->i_state, inode-
>i_state|(1<<19));
+		}
 		return;
+	}
 
 	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode-
>i_lru))
 		this_cpu_inc(nr_unused);
@@ -623,7 +629,10 @@ void clear_inode(struct inode *inode)
 	xa_unlock_irq(&inode->i_data.i_pages);
 	BUG_ON(!list_empty(&inode->i_data.i_private_list));
 	BUG_ON(!(inode->i_state & I_FREEING));
-	BUG_ON(inode->i_state & I_CLEAR);
+	if (inode->i_state & I_CLEAR) {
+		pr_info("inode 0x%px state 0x%lx triggered bug\n",
inode, inode->i_state);
+		BUG();
+	}
 	BUG_ON(!list_empty(&inode->i_wb_list));
 	/* don't need i_lock here, no concurrent mods to i_state */
 	inode->i_state = I_FREEING | I_CLEAR;
@@ -1754,7 +1763,10 @@ void iput(struct inode *inode)
 {
 	if (!inode)
 		return;
-	BUG_ON(inode->i_state & I_CLEAR);
+	if (inode->i_state & I_CLEAR) {
+		pr_info("inode 0x%px state 0x%lx triggered a bug\n",
inode, inode->i_state);
+		BUG();
+	}
 retry:
 	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
 		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME))
{
@@ -1764,6 +1776,8 @@ void iput(struct inode *inode)
 			mark_inode_dirty_sync(inode);
 			goto retry;
 		}
+		if (inode->i_ino == 261 && (inode->i_state &(1<<19)))
+			pr_info("state is 0x%lx, bug may be
triggered\n", inode->i_state);
 		iput_final(inode);
 	}
 }

The (1<<19) bit was used to debugging.

Here is the log when bug was triggered:

[   33.028024][ T2451] set inode 0xffff88801fb87738 dbg_flag casue
mapping_shrinkable
[   33.028478][ T2451] CPU: 0 PID: 2451 Comm: btrfs-cleaner Not tainted
6.10.0-rc2-00225-gf0deb01d52b3-dirty #132
[   33.029072][ T2451] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   33.029675][ T2451] Call Trace:
[   33.029873][ T2451]  <TASK>
[   33.030046][ T2451]  dump_stack_lvl+0x16c/0x1f0
[   33.030330][ T2451]  __inode_add_lru.part.0+0x1ea/0x280
[   33.030647][ T2451]  iput+0x7c7/0x920
[   33.030876][ T2451]  run_delayed_iput_locked+0x136/0x1e0
[   33.031199][ T2451]  btrfs_run_delayed_iputs+0x8e/0x120
[   33.031516][ T2451]  cleaner_kthread+0x2d3/0x480
[   33.031801][ T2451]  ? __pfx_cleaner_kthread+0x10/0x10
[   33.032113][ T2451]  kthread+0x2c1/0x3a0
[   33.032354][ T2451]  ? _raw_spin_unlock_irq+0x23/0x50
[   33.032659][ T2451]  ? __pfx_kthread+0x10/0x10
[   33.032929][ T2451]  ret_from_fork+0x45/0x80
[   33.033198][ T2451]  ? __pfx_kthread+0x10/0x10
[   33.033469][ T2451]  ret_from_fork_asm+0x1a/0x30
[   33.033756][ T2451]  </TASK>
[   33.033978][ T2451] bug! double evict! crash will happen
[   33.034168][ T2332] BTRFS info (device loop0): last unmount of
filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
[   33.034295][ T2451] inode 0xffff88801fb87738 state 0x60 triggered a
bug
[   33.034332][ T2451] ------------[ cut here ]------------
[   33.035578][ T2451] kernel BUG at fs/inode.c:1768!
[   33.035873][ T2451] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
KASAN NOPTI
[   33.036286][ T2451] CPU: 0 PID: 2451 Comm: btrfs-cleaner Not tainted
6.10.0-rc2-00225-gf0deb01d52b3-dirty #132
[   33.036870][ T2451] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   33.037464][ T2451] RIP: 0010:iput+0x896/0x920
// logs ...
[   33.042882][ T2451] PKRU: 55555554
[   33.043092][ T2451] Call Trace:
[   33.043288][ T2451]  <TASK>
[   33.044190][ T2451]  ? iput+0x896/0x920
[   33.047321][ T2451]  ? btrfs_run_defrag_inodes+0xb49/0xe60
[   33.047653][ T2451]  btrfs_run_defrag_inodes+0xa40/0xe60
[   33.047975][ T2451]  ? __pfx_btrfs_run_defrag_inodes+0x10/0x10
[   33.048327][ T2451]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[   33.048678][ T2451]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   33.048996][ T2451]  ? _raw_spin_unlock+0x28/0x50
[   33.049285][ T2451]  ? btrfs_clean_one_deleted_snapshot+0x2b2/0x420
[   33.049660][ T2451]  cleaner_kthread+0x2ee/0x480
[   33.049941][ T2451]  ? __pfx_cleaner_kthread+0x10/0x10
[   33.050252][ T2451]  kthread+0x2c1/0x3a0
[   33.050492][ T2451]  ? _raw_spin_unlock_irq+0x23/0x50
[   33.050796][ T2451]  ? __pfx_kthread+0x10/0x10
[   33.051067][ T2451]  ret_from_fork+0x45/0x80
[   33.051333][ T2451]  ? __pfx_kthread+0x10/0x10
[   33.051603][ T2451]  ret_from_fork_asm+0x1a/0x30
[   33.051887][ T2451]  </TASK>
[   33.052066][ T2451] Modules linked in:
[   33.052316][ T2451] ---[ end trace 0000000000000000 ]---
[   33.052634][ T2451] RIP: 0010:iput+0x896/0x920

Please note inode 0xffff88801fb87738, which was set debug flag by
__inode_add_lru() in the run_delayed_iput_locked() code path. This 
indicates that the inode was not actually evicted. 
Then, please note the double evict log, which shows that this
inode which was set debug flag and was not be evicted is 
still on the sb list and was successfully acquired by btrfs_iget(). 
Next, take note of the unmount log, indicating that there was 
a concurrent unmount thread which has already called evict_inodes() at that time. 
Finally, observe where the BUG was triggered: the state of inode
0xffff88801fb87738 had been set to 0x60 by the unmount thread calling
inode_clear(), and at the same time, btrfs-cleaner called iput(),
ultimately leading to the BUG at the beginning check of iput(). 
Although the point of trigger differs from the one reported by 
syzbot, there is no doubt that they are the same bug.

You could apply the above diff and try to reproduce the bug using the 
reproducer[1].

If there is anything I'm missing or more info was needed, please let me know.

[1]: https://syzkaller.appspot.com/x/repro.c?x=14c57f16980000

Thanks.

