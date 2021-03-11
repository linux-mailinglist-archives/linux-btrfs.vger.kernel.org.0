Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52D033793B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 17:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbhCKQXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 11:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbhCKQXX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 11:23:23 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65878C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 08:23:23 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id 73so1545572qtg.13
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 08:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7RAOXfmuc+D5cFIlkf6gfP+Yo/PsIgV1lGp5r/bDgUM=;
        b=BsVHiZpLDBhPsJZ50Tmifc5jb9bgdH2o23b6eoRgjKtisSWkTO6xdohxQJToEMeW4B
         5yUWGJy54S6scrlZe8eWMnVhDEWftKaL84psuYxLahWYZ8vlyzy3Y6n7hGK5hu3THyw5
         qVD3Sbjs5+KTb9ZYbWl+1AS85QFy8D+dWvkWiXO8iQ9dLKiRtg2N6c1tDivnNtsoSHSY
         EeXfUF3kmi/84tpz+ts8Rvb82FUUclz8QsPhuUbqpcffawNQrBIbaNYMdngpZpPR6QR2
         OJUDixU4SLZHvxb+dUXoAwizLQQFWCNeA9ES1gB8JrfsAcFfe+C4ctYWeBCzJTbl+t42
         h0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7RAOXfmuc+D5cFIlkf6gfP+Yo/PsIgV1lGp5r/bDgUM=;
        b=bTYSiEMVx84J6lQFYB9jWc9KXhoPemUVbEYhXqBfi4qLeNbuxaBOKzwW8O52hpmuLY
         No9QU5uG6H0VCn0bCzqZ26vogtt6jBfUM+NotdP3M2yK1v1gJjWjuq5z4NlTJmzjYIrh
         Tv4Nrkz1RWISjN465NEaIX0zR2KFfGsbtQDgPKV0ZHn6yHrIyo9+bUH1Wh1tidJCiNR1
         7swHGLFeISqpxBvOMUy8N70VfGCR4lwTxpRJdchwWZdWxCMtYfE9LPJGozH7sD89b/Rg
         1Kje3I9b1s87zbW8x5mTWLXG7AbtbKGawuJm05eEc+rVWaaaoVHSOYwrNsnu6AOJvp05
         MxCg==
X-Gm-Message-State: AOAM533R+n+OdiyQ3xDj31BPEphP5oB+XfNob+nueir43iDm5pdhipj2
        dUD/5v49TVwjY0EKSerwOMLLFsfl0lbLLUqB
X-Google-Smtp-Source: ABdhPJz3sIH5O6cR44Bqobxo8/i2Vhm+HayGvOLM9wasjSaPM2C+kmK+JdqVm3NafjSwjTGAi9uCnw==
X-Received: by 2002:ac8:4508:: with SMTP id q8mr7937677qtn.48.1615479802218;
        Thu, 11 Mar 2021 08:23:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h16sm2008550qto.45.2021.03.11.08.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 08:23:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Neal Gompa <ngompa13@gmail.com>
Subject: [PATCH 2/3] btrfs: do not init dev stats if we have no dev_root
Date:   Thu, 11 Mar 2021 11:23:15 -0500
Message-Id: <af4642aa2c513f65cd41e17ac1be3ceca9cf4815.1615479658.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615479658.git.josef@toxicpanda.com>
References: <cover.1615479658.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Neal reported a panic trying to use -o rescue=all

BUG: kernel NULL pointer dereference, address: 0000000000000030
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 0 PID: 4095 Comm: mount Not tainted 5.11.0-0.rc7.149.fc34.x86_64 #1
RIP: 0010:btrfs_device_init_dev_stats+0x4c/0x1f0
RSP: 0018:ffffa60285fbfb68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88b88f806498 RCX: ffff88b82e7a2a10
RDX: ffffa60285fbfb97 RSI: ffff88b82e7a2a10 RDI: 0000000000000000
RBP: ffff88b88f806b3c R08: 0000000000000000 R09: 0000000000000000
R10: ffff88b82e7a2a10 R11: 0000000000000000 R12: ffff88b88f806a00
R13: ffff88b88f806478 R14: ffff88b88f806a00 R15: ffff88b82e7a2a10
FS:  00007f698be1ec40(0000) GS:ffff88b937e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000030 CR3: 0000000092c9c006 CR4: 00000000003706f0
Call Trace:
? btrfs_init_dev_stats+0x1f/0xf0
btrfs_init_dev_stats+0x62/0xf0
open_ctree+0x1019/0x15ff
btrfs_mount_root.cold+0x13/0xfa
legacy_get_tree+0x27/0x40
vfs_get_tree+0x25/0xb0
vfs_kern_mount.part.0+0x71/0xb0
btrfs_mount+0x131/0x3d0
? legacy_get_tree+0x27/0x40
? btrfs_show_options+0x640/0x640
legacy_get_tree+0x27/0x40
vfs_get_tree+0x25/0xb0
path_mount+0x441/0xa80
__x64_sys_mount+0xf4/0x130
do_syscall_64+0x33/0x40
entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f698c04e52e

This happens because we unconditionally attempt to init device stats on
mount, but we may not have been able to read the device root.  Fix this
by skipping init'ing the device stats if we do not have a device root.

Reported-by: Neal Gompa <ngompa13@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 995920fcce9b..d4ca721c1d91 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7448,6 +7448,9 @@ static int btrfs_device_init_dev_stats(struct btrfs_device *device,
 	int item_size;
 	int i, ret, slot;
 
+	if (!device->fs_info->dev_root)
+		return 0;
+
 	key.objectid = BTRFS_DEV_STATS_OBJECTID;
 	key.type = BTRFS_PERSISTENT_ITEM_KEY;
 	key.offset = device->devid;
-- 
2.26.2

