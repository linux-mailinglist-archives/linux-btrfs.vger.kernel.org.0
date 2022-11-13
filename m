Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B4A626F52
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 12:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiKMLjM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 06:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMLjL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 06:39:11 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602B811C34;
        Sun, 13 Nov 2022 03:39:10 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id 13so22186643ejn.3;
        Sun, 13 Nov 2022 03:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nLs2TAH/QuzR93RizayFXReGTRS2ZHOOTjuVGeiE3ZU=;
        b=b0lgGV+stDy1Yn3DUjR+TeGQQslgWTBJK4v19ISg2hQMH4eadmYztCqZLDknM8hwKw
         3wzWBvOaAEiX9Q7ZUOTPUz21Wr1TG0MCM4dJXdwXKl/jzG2Ra89v1FR1jYFtnu3AefLa
         YNtCycDjHnYJbxWleV+s2QmNEBbkAmaP/PORXevExjT0bVxTAAyKDuQLHsvRnUVOTLGH
         4i9zie9VX1aNZZ3cVLu8YG30ALVwIkuWN4khpEkoigccki3T4PRSKqkjyJatcxwf5F4w
         QyNiDufA4rmD/f7+I3IpVVh1Kaea1c22prrp0ngU/Pkqej45pkDkL1ND+eZyHRTAmjgF
         txmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLs2TAH/QuzR93RizayFXReGTRS2ZHOOTjuVGeiE3ZU=;
        b=IGLeIKSjMvmWwHkuB/rViOEXcLFTYm9GNppoMmRxFCcnn6JHbSFOfb9tuhep0R96gl
         7UJ8pNKnLP8+EMbaASBEPMmUz20aC7Y5ruBelhDr37dLYlH3AHUJEQp5zP+miC3Cq7Kd
         TvUynuZYjZ8nzzeow8wvodaZFjIh7DnFjZR86EfEb+0/7PXFY6LceJn0MD4tBtOC3S4E
         KejSiuzlApFi94K72Ccjpt+jGMEKi9LGi2iv9xyotAKi00krQyNHV3n6CSJBcjomf0Rt
         YW5vrruNNQQQWDw8O0jUfW1FI2Q+CoBMeJxDAJmcEvUrNJsohzfQW7eON8WrjcTlPp9S
         c7FQ==
X-Gm-Message-State: ANoB5pnOM1PHv9493ILPpG+kVIaBGqhpdAxL9Znt8meCseBqz1Zru1FU
        Os4wgy2tx9DA0rwq2Ty5QcXPfcV6vxHJ/xGz5hkBtQjNb4Q=
X-Google-Smtp-Source: AA0mqf4GBN5NiBSCinefezWHA2mnLOACbi/xZR2eSfEitPrAjEjgC6YhnTLLZmM5GvmeO40zBHorUx/W1P9VImpNzaM=
X-Received: by 2002:a17:906:9453:b0:78d:88c7:c1bf with SMTP id
 z19-20020a170906945300b0078d88c7c1bfmr7352645ejx.299.1668339548669; Sun, 13
 Nov 2022 03:39:08 -0800 (PST)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 13 Nov 2022 19:38:32 +0800
Message-ID: <CAO4mrfdLsMZT1ytmTCK4m0xXezxskTUbQjqZoGobMVhnZgdfmw@mail.gmail.com>
Subject: WARNING in _btrfs_ioctl_set_received_subvol
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was
triggered. The bug persists in Linux 6.0.

HEAD commit:  4f5365f77018  Linux 5.15.76
git tree: stable
compiler: gcc 7.5.0
console output:
https://drive.google.com/file/d/1wkzu8jz6edriSP6TpsCGYD5AzkLajIEv/view?usp=share_link
kernel config: https://drive.google.com/file/d/1flhc33savDkmYN6PRU5C2vXDX0LAKMvM/view?usp=share_link
C reproducer: https://drive.google.com/file/d/1zKWsWAOcaHfPKewTG6P3pnnVfwH_WXa9/view?usp=share_link
Syz reproducer:
https://drive.google.com/file/d/1jUR8_6Re4xpJhyLdXqPiiV72WT-Tk8A-/view?usp=share_link

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffd3c817900
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 1 PID: 29222 at fs/btrfs/ioctl.c:4521
_btrfs_ioctl_set_received_subvol+0x221/0x430 fs/btrfs/ioctl.c:4521
Modules linked in:
CPU: 1 PID: 29222 Comm: syz-executor.0 Not tainted 5.15.76 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:_btrfs_ioctl_set_received_subvol+0x221/0x430 fs/btrfs/ioctl.c:4521
Code: e8 74 34 44 ff 83 fb fb 0f 84 de 01 00 00 83 fb e2 0f 84 d5 01
00 00 e8 5d 34 44 ff 89 de 48 c7 c7 c0 f8 39 85 e8 9f dc 2e ff <0f> 0b
e8 48 34 44 ff 89 d9 ba a9 11 00 00 e9 45 01 00 00 49 8b 4f
RSP: 0018:ffffc9000aecfd40 EFLAGS: 00010286
RAX: 0000000000000000 RBX: fffffffffffffff4 RCX: ffffc900013ed000
RDX: 0000000000040000 RSI: ffffffff812d935c RDI: 00000000ffffffff
RBP: ffffc9000aecfda0 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc9000aecfbe0 R11: 0000000000000003 R12: ffff888014210400
R13: ffff8880208d2000 R14: ffff88810c4f21c0 R15: ffff88810f37b600
FS:  00007f41ffc27700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fab915f7008 CR3: 000000002096e000 CR4: 00000000003526e0
Call Trace:
 <TASK>
 btrfs_ioctl_set_received_subvol_32 fs/btrfs/ioctl.c:4584 [inline]
 btrfs_ioctl+0x2154/0x3d50 fs/btrfs/ioctl.c:5007
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x4697f9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f41ffc26c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000077bf80 RCX: 00000000004697f9
RDX: 0000000020072c40 RSI: 00000000c0c09425 RDI: 0000000000000005
RBP: 00007f41ffc26c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffd3c817900
 </TASK>

Best,
Wei
