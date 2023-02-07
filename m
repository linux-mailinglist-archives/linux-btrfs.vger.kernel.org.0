Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C454D68DE55
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 17:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjBGQ5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 11:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjBGQ5c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 11:57:32 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B293B667
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 08:57:30 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id d7so4415947qvz.3
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Feb 2023 08:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v63YSZhIQDpIEPGHplK+l0eE5SS7UivVhunGpiRXEXY=;
        b=Czp9nkP5X/3PkK/sUAF/UZegXG6Mmryw33orB9D1dTl9/8l2HXIeAWikiNKxBCjSVF
         qg3ywE+fPT1K745FCw8kVurrK3MlX862lBkz+TOR0qA17VT4SDwmc9bfYMn2A1ex+Xkv
         0WZkRmtDxb9nBqb28o+BXCSoS4IKGj8eM68pByLisR+RmGPZ1dd7IFT4gDTJqxAcL5fX
         6kXnn1vfNtX8MG3WMzKw3Sv32r5DuwRddJuS5IDqAGusAfXjKQ3hFbt6ZomCggfXsMQC
         uPrw4Ch38sKIW41wvEUpJXzROgvlioGtMs0rbxPVvge7spD5u7Ksycv5ta1afeY1D/FI
         8rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v63YSZhIQDpIEPGHplK+l0eE5SS7UivVhunGpiRXEXY=;
        b=WyrGCkVlDa68xszW+B6/hVCVEiuWnq5FRnTsOs8qqOUm8UjhnVrVJKt/0Oc/ryYpIo
         YoBAiET/NqHHEjYZBb/fl5dsbTVDhyusCYqTA6d1rgVlsCowLFCEQA8c9KMV5bvy09h/
         z3yc85KRUAFHqFRcXavjCR3hWiwyDf7Fzq32oDwp9B5nBK5cdSjlDVy7u+V1/vGBdyeg
         mpDZe6HSjiEDywUFIuHM8Ro1vAsCYO6mQQR3Q+UW2JDIRo72VSzCLWvUrE0aiv7Ickhp
         wIcALnCN78fhQbLT/Pkug8eYamhg/0MTRF/Zg0CF9RHF4zgPnplXusixQ49FUvH8rq/Y
         EyJQ==
X-Gm-Message-State: AO0yUKWMxEpMUl8oJ4gkJCeOeiUmxtWNQbtgEDs4RkXnC4CrWg2/0U1O
        fBvww6nV76FhPJvM2yCPuAyYTO8vfSCtHU2W/oo=
X-Google-Smtp-Source: AK7set84uodc52li5f7V7J1XpV6zu4xReubDCh29vWDYwrKqd0MWMVMv9xZ3l4zDIt6X+NySvW303Q==
X-Received: by 2002:a05:6214:ace:b0:539:d8ce:57d5 with SMTP id g14-20020a0562140ace00b00539d8ce57d5mr7168168qvi.9.1675789049096;
        Tue, 07 Feb 2023 08:57:29 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id b19-20020a05620a271300b0071a291f0a4asm9923224qkp.27.2023.02.07.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:57:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/7] btrfs: use btrfs_handle_fs_error in btrfs_fill_super
Date:   Tue,  7 Feb 2023 11:57:19 -0500
Message-Id: <74dfb92d8d80f082f64ddb0e3b3e073f0ae24e9d.1675787102.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1675787102.git.josef@toxicpanda.com>
References: <cover.1675787102.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While trying to track down a lost EIO problem I hit the following
assertion while doing my error injection testing

BTRFS warning (device nvme1n1): transaction 1609 (with 180224 dirty metadata bytes) is not committed
assertion failed: !found, in fs/btrfs/disk-io.c:4456
------------[ cut here ]------------
kernel BUG at fs/btrfs/messages.h:169!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 1445 Comm: mount Tainted: G        W          6.2.0-rc5+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
RIP: 0010:btrfs_assertfail.constprop.0+0x18/0x1a
RSP: 0018:ffffb95fc3b0bc68 EFLAGS: 00010286
RAX: 0000000000000034 RBX: ffff9941c2ac2000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffffb6741f7d RDI: 00000000ffffffff
RBP: ffff9941c2ac2428 R08: 0000000000000000 R09: ffffb95fc3b0bb38
R10: 0000000000000003 R11: ffffffffb71438a8 R12: ffff9941c2ac2428
R13: ffff9941c2ac2450 R14: ffff9941c2ac2450 R15: 000000000002c000
FS:  00007fcea2d07800(0000) GS:ffff9941fbc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f00cc7c83a8 CR3: 000000010c686000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 close_ctree+0x426/0x48f
 btrfs_mount_root.cold+0x7e/0xee
 ? legacy_parse_param+0x2b/0x220
 legacy_get_tree+0x2b/0x50
 vfs_get_tree+0x29/0xc0
 vfs_kern_mount.part.0+0x73/0xb0
 btrfs_mount+0x11d/0x3d0
 ? legacy_parse_param+0x2b/0x220
 legacy_get_tree+0x2b/0x50
 vfs_get_tree+0x29/0xc0
 path_mount+0x438/0xa40
 __x64_sys_mount+0xe9/0x130
 do_syscall_64+0x3e/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

This is because the error injection did an EIO for the root inode lookup
and we simply jumped to closing the ctree.  However because we didn't
mark the file system as having an error we skipped all of the broken
transaction cleanup stuff, and thus triggered this ASSERT().  Fix this
by calling btrfs_handle_fs_error() in this case so we have the error set
on the file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 581845bc206a..d8885966e801 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1158,6 +1158,7 @@ static int btrfs_fill_super(struct super_block *sb,
 	inode = btrfs_iget(sb, BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
+		btrfs_handle_fs_error(fs_info, err, NULL);
 		goto fail_close;
 	}
 
-- 
2.26.3

