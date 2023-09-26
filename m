Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AFF7AE39F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 04:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjIZCSn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 22:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIZCSm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 22:18:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B22FBF;
        Mon, 25 Sep 2023 19:18:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50444e756deso8674331e87.0;
        Mon, 25 Sep 2023 19:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695694714; x=1696299514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4KuS89SBhEXeXzlKRw6X2z13KjFZujBz1QSgTzHEcIY=;
        b=hgK2p8M8Y4cjQvO5YfXK9DUmODnkdaD/V2bBke5VxQUmodjUSMf0jSBEtYL5RpcL5e
         nARIzgn4+Ul9dxwgO3HGLmBC3/XqYO8ptkYAonzm+kmK+p/N7JBK9x2g3VwmMV+euNTO
         RxOW0InrBOJ8eAOlSBYbB2JvI+zDQ1UToUSIn4tpvexJdMeG/2GG94+mO6jHTE8Eixxc
         EHqKlwZMMhb8nPDGB3RrpiR1NtMfOKSb7WkR7ZxMllR+5gi+FoNRaAg/PZPa+OEszMY7
         Lnrl2d4X+0Rzl3Hvf274c6al4498+NrQH4PzGOpiE4/q7STU3BbW4HsOgb9fecqlbdAi
         WmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695694714; x=1696299514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KuS89SBhEXeXzlKRw6X2z13KjFZujBz1QSgTzHEcIY=;
        b=XzZ8vBWBmBfBkXcK2IqQBcCcr9GQ1WH5ucE35OSGbfOfZLksPzHqWaH0PBR36MU333
         bJtjXK3AGpg8qsTi2Z5TGA3ZLIMsQAsQEsErbb/IFZ034r5AgdpETJ/NinIgUXoEP2td
         M5FRlmZPuM9PNzmm+b/B+mT++nC8au9Xa/F639oyv6YZHScpVRuaY5RdTtTszJKIOeuK
         4yBQ7uaZdZd3r2Mksn3zdAR4BeeRxtFpQdXtFJqm6O0IKpvN4rl93KRqsJTyQveiifWw
         FffB9LDUQT4ZT89t/xWEbGKcumw69ubl6DYnz2Ja4RhZ2p4ui1tQc/ci3TnwcmCetLzS
         8d0w==
X-Gm-Message-State: AOJu0YxU1zk1r+0T7NObEKLAvLE+yMKZrPjQTimpcHLCTWrONPktqKDP
        hBkNfPrJ7Z8E5MXoqrhXByzSrMXIGyJgxk6sFjVAtVPW1sAzubFp
X-Google-Smtp-Source: AGHT+IHSp+t9UpOYNLMa0pwCyGliV1Qx/xcE6Nr4KYbQeHWU7QGxkI24IwCRcolAfk+g83n0z4FuSexkPVP8EfMnGeA=
X-Received: by 2002:a2e:9dd4:0:b0:2c0:298d:32df with SMTP id
 x20-20020a2e9dd4000000b002c0298d32dfmr7311986ljj.9.1695694713282; Mon, 25 Sep
 2023 19:18:33 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Tue, 26 Sep 2023 10:18:21 +0800
Message-ID: <CALcu4rb4XP1G=BM9c-Za-p26qN=itbhfU6esn5SfHjuZn8pz-A@mail.gmail.com>
Subject: WARNING in btrfs_space_info_update_bytes_may_use
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

When using Healer to fuzz the Latest Linux-6.6-rc3,  the following crash
was triggered.

HEAD commit: 6465e260f48790807eef06b583b38ca9789b6072 ( Linux 6.6-rc3=EF=BC=
=89
git tree: upstream

console output:
https://drive.google.com/file/d/1JlSPfRbqIlpTkYG9_W2ClYiTOORXlnj4/view?usp=
=3Ddrive_link
kernel config:https://drive.google.com/file/d/1CFQ24OVix2RivZgCj1ie4QPJUoL8=
rtbD/view?usp=3Ddrive_link
C reproducer:https://drive.google.com/file/d/1cqwuczXJYPG6KSJjzB_Er6QrS7iJn=
pVc/view?usp=3Ddrive_link
Syzlang reproducer:
https://drive.google.com/file/d/1-Mp-cztmSoKVGXm_kfNlA_FUgV3zT4f5/view?usp=
=3Ddrive_link


If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8100 at fs/btrfs/space-info.h:198
btrfs_space_info_update_bytes_may_use+0x448/0x590
fs/btrfs/space-info.h:198
Modules linked in:
CPU: 1 PID: 8100 Comm: syz-executor.3 Not tainted 6.6.0-rc3-g6465e260f487 #=
2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:btrfs_space_info_update_bytes_may_use+0x448/0x590
fs/btrfs/space-info.h:198
Code: fd e9 69 fc ff ff e8 a7 8e f7 fd 49 89 ed 4c 89 e6 49 f7 dd 4c
89 ef e8 76 8a f7 fd 4d 39 e5 0f 86 7c fd ff ff e8 88 8e f7 fd <0f> 0b
45 31 e4 e9 75 fd ff ff e8 79 8e f7 fd 48 8d 7b 18 be ff ff
RSP: 0018:ffffc90002f6fad8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802642a800 RCX: 0000000000000000
RDX: ffff8880152c0000 RSI: ffffffff838a4bc8 RDI: 0000000000000006
RBP: ffffffffffa80000 R08: 0000000000000006 R09: 0000000000580000
R10: 000000000057c000 R11: 0000000000000001 R12: 000000000057c000
R13: 0000000000580000 R14: ffff88802642a860 R15: 0000000000000004
FS:  000055555745a480(0000) GS:ffff888135c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2c321000 CR3: 000000001840f000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:230 [inline]
 block_rsv_release_bytes fs/btrfs/block-rsv.c:154 [inline]
 btrfs_block_rsv_release+0x4ab/0x5e0 fs/btrfs/block-rsv.c:293
 btrfs_release_global_block_rsv+0x22/0x2e0 fs/btrfs/block-rsv.c:443
 btrfs_free_block_groups+0xb9d/0x13d0 fs/btrfs/block-group.c:4380
 close_ctree+0x548/0xda0 fs/btrfs/disk-io.c:4413
 generic_shutdown_super+0x15d/0x3c0 fs/super.c:693
 kill_anon_super+0x36/0x60 fs/super.c:1292
 btrfs_kill_super+0x38/0x50 fs/btrfs/super.c:2144
 deactivate_locked_super+0x94/0x170 fs/super.c:481
 deactivate_super+0xad/0xd0 fs/super.c:514
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1254
 task_work_run+0x164/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x215/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:296
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdc5389070b
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 90 f3 0f 1e fa 31 f6
e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 b0 ff ff ff f7 d8
RSP: 002b:00007ffdcf04dcd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fdc5389070b
RDX: 00007fdc53828280 RSI: 000000000000000a RDI: 00007ffdcf04dd90
RBP: 00007ffdcf04dd90 R08: 0000000000000000 R09: 00007ffdcf04db60
R10: 000055555745ba0b R11: 0000000000000246 R12: 00007fdc538ef312
R13: 00007ffdcf04ee70 R14: 000055555745b970 R15: 00007ffdcf04ee60
 </TASK>
