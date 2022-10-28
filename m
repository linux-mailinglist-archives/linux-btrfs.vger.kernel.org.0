Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E837261157B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 17:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJ1PGR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Oct 2022 11:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJ1PGN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 11:06:13 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6021D1AA5;
        Fri, 28 Oct 2022 08:06:12 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h185so5058076pgc.10;
        Fri, 28 Oct 2022 08:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Pn++XpjxkHey4dxIJ68gBiqTcOkK8VYxUFou/lwjQA=;
        b=QrqVvHdbii4u+vv2Ej8qAKv/sfnCiVsZfBI9e6unxff5srtAZCjE3CIZpvuuApDKC8
         MVmDSD4spXgM8R93a2AcYipYicF3Yn4whDb4OgJWDeUrykEdHf99cvEQD/kA3Dfz6n4J
         mu47MG9SOXrFqy+hxi2idF9qdXZ3VZNEU2EnBkigEAbwmowrvl5QuoZEDa0WFDOyqCo7
         5VYnQPsYBesRT+j4IoB9lnK1R79+jhBti1H4RlGhdYPkg6zyHbLbXmifaVmJLoyHErJX
         zgdi1p7kLdVAlCTl4BLrrea6W2Fzxx6gVcfr3eEedE0RtkSZNHcZNibdYsXqz8QdRtrG
         OZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Pn++XpjxkHey4dxIJ68gBiqTcOkK8VYxUFou/lwjQA=;
        b=OBACwZpqNYXRGvcZVsn1M+Jj9F/aCRQDQuMg2MeO/ZmQJzN2yCCueiy53YT2s3AnIP
         gVyPZfkep232SqnYtj+oywsTYrpyF+A+96uICI8ShqUlWNwA6QQxfXzTe28hjyT+5gHc
         4Nxh6B/bDiuxICZEI0k4p/8xp3/SZGwOAwdN2I545nUAIOXtXcZ6y2ztI7ra6d1kM2Ub
         LxQQArimF5oj6kOFo7mIpsrF4KbnDrfCey4yxG7Mg6LjkFe0p6tE/mMO4OYrvD2A+37n
         cWzc9kh8VbQNYFsPIeq4I99rNbh9Fk0Ir431gqPEOKhE1HO5BYoLeEbkDcacN7+G5eij
         vDSw==
X-Gm-Message-State: ACrzQf3P/JWL6m48TokXOFp+EfJ7bU2+LwHoN7okpfFZsd6rb/DZVBf2
        EHCxhaPYuc71R8BGjzRnn/o=
X-Google-Smtp-Source: AMsMyM7B55XAKynNnFtFextuwjkOO5jqYBuZsIYo3FwyE89Ln0B28zZ/gZVbRG4KRhC4mdv0NRme7g==
X-Received: by 2002:a63:ff4f:0:b0:439:61d6:197 with SMTP id s15-20020a63ff4f000000b0043961d60197mr46695602pgk.67.1666969572194;
        Fri, 28 Oct 2022 08:06:12 -0700 (PDT)
Received: from localhost ([183.242.254.175])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902eb8c00b0017f5ad327casm3158950plg.103.2022.10.28.08.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:06:11 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     18801353760@163.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Subject: Re: [syzbot] WARNING in btrfs_block_rsv_release
Date:   Fri, 28 Oct 2022 23:05:01 +0800
Message-Id: <20221028150501.5159-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000c5461a05ec18b4e6@google.com>
References: <000000000000c5461a05ec18b4e6@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 28 Oct 2022 at 19:14, Hawkins Jiawei <yin31149@gmail.com> wrote:
>
> Hi,
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1025dd72880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> > dashboard link: https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d16e6e880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1672873c880000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/df89d50ed284/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122 btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:154 [inline]
> > WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122 block_rsv_release_bytes fs/btrfs/block-rsv.c:151 [inline]
> > WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122 btrfs_block_rsv_release+0x5d1/0x730 fs/btrfs/block-rsv.c:295
> > Modules linked in:
> > CPU: 0 PID: 3612 Comm: syz-executor894 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> > RIP: 0010:btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:122 [inline]
> > RIP: 0010:btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:154 [inline]
> > RIP: 0010:block_rsv_release_bytes fs/btrfs/block-rsv.c:151 [inline]
> > RIP: 0010:btrfs_block_rsv_release+0x5d1/0x730 fs/btrfs/block-rsv.c:295
> > Code: 8b 7c 24 10 74 08 4c 89 f7 e8 2b 94 33 fe 49 8b 1e 48 89 df 48 8b 2c 24 48 89 ee e8 a9 2b e0 fd 48 39 eb 73 0b e8 5f 29 e0 fd <0f> 0b 31 db eb 25 e8 54 29 e0 fd 48 b8 00 00 00 00 00 fc ff df 41
> > RSP: 0000:ffffc90003baf9e8 EFLAGS: 00010293
> > RAX: ffffffff83a657f1 RBX: 00000000000d0000 RCX: ffff888020c59d80
> > RDX: 0000000000000000 RSI: 00000000000e0000 RDI: 00000000000d0000
> > RBP: 00000000000e0000 R08: ffffffff83a657e7 R09: fffffbfff1c19fde
> > R10: fffffbfff1c19fde R11: 1ffffffff1c19fdd R12: 1ffff11004f2190c
> > R13: 00000000000e0000 R14: ffff88802790c860 R15: 0000000000000000
> > FS:  000055555651b300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f207ed54000 CR3: 0000000026ea2000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  btrfs_release_global_block_rsv+0x2f/0x250 fs/btrfs/block-rsv.c:463
> >  btrfs_free_block_groups+0xb67/0xfd0 fs/btrfs/block-group.c:4053
> >  close_ctree+0x6c5/0xbde fs/btrfs/disk-io.c:4710
> >  generic_shutdown_super+0x130/0x310 fs/super.c:491
> >  kill_anon_super+0x36/0x60 fs/super.c:1085
> >  btrfs_kill_super+0x3d/0x50 fs/btrfs/super.c:2441
> >  deactivate_locked_super+0xa7/0xf0 fs/super.c:331
> >  cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
> >  task_work_run+0x146/0x1c0 kernel/task_work.c:177
> >  ptrace_notify+0x29a/0x340 kernel/signal.c:2354
> >  ptrace_report_syscall include/linux/ptrace.h:420 [inline]
> >  ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
> >  syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:249
> >  syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c:276
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
> >  syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:294
> >  do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f694614c2f7
> > Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffee1dcd8e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f694614c2f7
> > RDX: 00007ffee1dcd9a9 RSI: 000000000000000a RDI: 00007ffee1dcd9a0
> > RBP: 00007ffee1dcd9a0 R08: 00000000ffffffff R09: 00007ffee1dcd780
> > R10: 000055555651c653 R11: 0000000000000206 R12: 00007ffee1dcea20
> > R13: 000055555651c5f0 R14: 00007ffee1dcd910 R15: 0000000000000004
> >  </TASK>
>
> According to my analysis, this bug seems to be related to
> btrfs_free_reserved_bytes()(Please correct me if I am wrong).
>
> To be more specific, in btrfs_new_extent_direct(), kernel will
> reserves space for extent by btrfs_reserve_extent(), and
> frees those space by btrfs_free_reserved_extent() if
> btrfs_create_dio_extent() fails(such as inject_fault in the syzkaller)
>
> Yet the problem is that when reserving space for extent, kernel will
> converts it from * ->bytes_may_use to ->bytes_reserved, in
> btrfs_add_reserved_bytes(). But in freeing those space,
> kernel does not convert it from ->bytes_reserved back to
> * ->bytes_may_use in btrfs_free_reserved_bytes(),
> which triggers the above warning.(Please correct me if I am wrong)
>
> So I think we can convert space from ->bytes_reserved back to
> * ->bytes_may_use in btrfs_free_reserved_bytes() to solve this bug,
> as below:
>

It seems that syzbot build/boot failed because of some
irrelevant reason. Try the specific kernel version.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
493ffd6605b2d3d4dc7008ab927dba319f36671f

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index deebc8ddbd93..cb74fcbf7aaf 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3415,6 +3415,11 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
        space_info->bytes_reserved -= num_bytes;
        space_info->max_extent_size = 0;

+       trace_btrfs_space_reservation(cache->fs_info, "space_info",
+                                     space_info->flags, -num_bytes, 1);
+       btrfs_space_info_update_bytes_may_use(cache->fs_info,
+                                             space_info, num_bytes);
+
        if (delalloc)
                cache->delalloc_bytes -= num_bytes;
        spin_unlock(&cache->lock);
