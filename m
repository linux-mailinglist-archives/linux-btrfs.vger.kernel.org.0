Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A473261E2FB
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Nov 2022 16:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiKFP2T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 10:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiKFP2S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 10:28:18 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4642DFE5;
        Sun,  6 Nov 2022 07:28:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v27so14083813eda.1;
        Sun, 06 Nov 2022 07:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7JShn56e1PHIXASd4rc8xupjF13jUPj72i2eiWS0Lxo=;
        b=pJUJoU8ezHBN4ljFlAcQ59AeZ+Ze2Leisji6TXOEQbAt3wN/z77jLNxzQPJWjWxqfQ
         yVwjjJ9pwATzNa0NdQhGO3SCQnOVnHEX4jdm9RYGMHlkF5xBk2SqzH2gcAru1iTvkX4+
         g7LksHi9deWQ2n3A+zHt/r8LZa85TvQa06Jeg9TGVF2WEvRIopF61JswtUaAp09C+tW5
         UOErXOyL+XdIgu/XQFs2obxDvCZb4OscbXMp2hh1It+tjr1IUJDRoy8IBfYRu2isQrZ0
         JQESrgtPKl16vWeySAVkmMaGkpU8RRKchyrr7jZVt+9eGfNAOPV3Oi628LU+OZn+nuSQ
         y4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JShn56e1PHIXASd4rc8xupjF13jUPj72i2eiWS0Lxo=;
        b=1adsb4sCJT3X+m00GfVauDwE5XYiPCYCb37oJPnEuom+J5c2BOS6jnX2TexZTYuKkU
         bXFrKK+XVeXi/PziI2Zr95wANE6UA5h6aUB5oa0PZt//yMc3BlvMJvJQKEdXlaAKOPlq
         oIaB25/tvjrhAaGUfZ4XNIaCC65FZsiRBA/dMiRVFOOdCwMF7Lgjzaz3Kzzy6F6dO+1K
         CeJ1YksH6yzf0rPtTEWRuGJbFfmJPZ/32V58g1xchP1/yb3DXu20oVB+QuRCuNGs1Oil
         43LHRb8cZKCs+KpbQeKXxsNOtwzfq41/Uy2xezDt20qlNRe/dNoP7cd/nlzTK0Jbe9Ev
         E1hA==
X-Gm-Message-State: ANoB5plI9AyXziHs7s75lIgtTQogp0yjB96tP6PQsnAyn6fVOkLKJJ8c
        Ri+MSAfzYSOL5xG1ifuPzgmuKfzdApNeiIuDFtY=
X-Google-Smtp-Source: AA0mqf4Mz7IzzrF5jp/54pL6o+uBhOYvW9fkFO6wk+gQkS6+MlLDSLvwAue2j4w6TD7QazDBMF9/xODOcI+6EXFB1EM=
X-Received: by 2002:a05:6402:5291:b0:45c:3f6a:d4bc with SMTP id
 en17-20020a056402529100b0045c3f6ad4bcmr8392290edb.285.1667748494140; Sun, 06
 Nov 2022 07:28:14 -0800 (PST)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 6 Nov 2022 23:27:38 +0800
Message-ID: <CAO4mrfepng=HR3Pd4Nic8VWuAJR6y0AGWMRozg-GYppBAyD56g@mail.gmail.com>
Subject: WARNING in btrfs_cont_expand
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
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
https://drive.google.com/file/d/1ARWiyJuypC3aAy8NAR9pYcDjetANaSwF/view?usp=share_link
kernel config: https://drive.google.com/file/d/1flhc33savDkmYN6PRU5C2vXDX0LAKMvM/view?usp=share_link
C reproducer: https://drive.google.com/file/d/1N5XpsTkCENoHXZx-NMNJEzvNEJ8UWabd/view?usp=share_link
Syz reproducer:
https://drive.google.com/file/d/1dwunpfWOA1Pj9eyLSewmLegtAxtDhvnx/view?usp=share_link

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001a
R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffcb6c26f30
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 4806 at fs/btrfs/inode.c:5234 maybe_insert_hole
fs/btrfs/inode.c:5234 [inline]
WARNING: CPU: 0 PID: 4806 at fs/btrfs/inode.c:5234
btrfs_cont_expand+0x4fa/0x5e0 fs/btrfs/inode.c:5302
Modules linked in:
CPU: 0 PID: 4806 Comm: syz-executor.0 Not tainted 5.15.76 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:maybe_insert_hole fs/btrfs/inode.c:5234 [inline]
RIP: 0010:btrfs_cont_expand+0x4fa/0x5e0 fs/btrfs/inode.c:5302
Code: e8 4b 17 48 ff 83 fd fb 0f 84 a6 00 00 00 83 fd e2 0f 84 9d 00
00 00 e8 34 17 48 ff 89 ee 48 c7 c7 c0 f8 39 85 e8 76 bf 32 ff <0f> 0b
e8 1f 17 48 ff 4c 89 ef 89 e9 ba 72 14 00 00 48 c7 c6 80 3e
RSP: 0018:ffffc9000cd3fc38 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90002115000
RDX: 0000000000040000 RSI: ffffffff812d935c RDI: 00000000ffffffff
RBP: 00000000fffffff4 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc9000cd3fa18 R11: 0000000000000003 R12: ffff888016d0cac0
R13: ffff888016d30460 R14: 0000000000001000 R15: ffff88801425b870
FS:  00007f4052485700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2c22b000 CR3: 000000011acb2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_setsize fs/btrfs/inode.c:5391 [inline]
 btrfs_setattr+0x221/0x7d0 fs/btrfs/inode.c:5468
 notify_change+0x548/0x750 fs/attr.c:426
 do_truncate+0xa3/0x100 fs/open.c:65
 vfs_truncate+0x1cc/0x1e0 fs/open.c:111
 do_sys_truncate.part.13+0xa4/0xc0 fs/open.c:134
 do_sys_truncate fs/open.c:128 [inline]
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x27/0x40 fs/open.c:144
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x4697f9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4052484c48 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 000000000077bf80 RCX: 00000000004697f9
RDX: 0000000000000000 RSI: 000000000000ffff RDI: 0000000020000080
RBP: 00007f4052484c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001a
R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffcb6c26f30
 </TASK>

Best,
Wei
