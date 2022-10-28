Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A370F6115E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 17:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJ1Pcg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Oct 2022 11:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJ1Pcf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 11:32:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138031D73E5;
        Fri, 28 Oct 2022 08:32:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x2so8417376edd.2;
        Fri, 28 Oct 2022 08:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rA52xSpWNjIdx/8QEz/cc4dBngxq1FlPz1lpxICBmW4=;
        b=bGFwqMWMZG1ZLcnK6YKpwXadUagKjTkDvkG8mhwnOxnfzefGFq5ijm6mn7HOKTmQwr
         UNoEh1GsHOlgUrMtA+G2GK/fMEDw2bLZpggpkY8gT31TSxakXuyYPAXA/uzgC6y/yu/r
         X+EBsSQFUIpRUBeqhaX09ACFDmI9gDRJDf9K0i7tkCE5/Y18e3eLjlyV5MLf2E/Sw2eh
         FSEFuxuu7NnooDeS9lfisM5K5PJYhKxGTAgBB88Rdh0zBz5bCwKaFlYbeIyXVzLLb/Ul
         vx7HnEYg66BN9taVH5kVrm0kXly/ltIBMOraQQnO2EuBaddfByh+Oj6Ud9PvcmLXqMX1
         fTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rA52xSpWNjIdx/8QEz/cc4dBngxq1FlPz1lpxICBmW4=;
        b=2vI37GPtge/oAA1mFsLTDDN7/37SgZIBW4qWmoyXo9pqWbKMLvjXRfSJnrFht44hew
         07MGWC93Kklt2VhNij5E2+dvN8ieqnKWTmyGcZZT7uz+9vbSkQ3J2werW5Q2RJPgNbGX
         MQtoQPq7z/dxaiAOEm7LEheybVIAoFLLyVZlG2udFvbJbDptOi3LQCewt+D/3s2y4ji3
         zzk0m0dplwrE87vVFBQbY8X3H5Y8M+51pBLqoAjtmXywHIHKhWPG8IzlPIGqWsVfj6Jr
         qmcujpiWYIgUN6o14XVDUqeQs0/FcmiC7AOnoNnkl9GPgDVZWaX/H/cLuVooy0rMGQXH
         Lp8g==
X-Gm-Message-State: ACrzQf30zi/Kxsl5ueivDWNf5T2Ax8V8aWPilQfMLfh+KOwbiNh6fVW8
        RVNuTEwqk5uWP2OAENnITnVq6YPIrO8lTt1qvuU=
X-Google-Smtp-Source: AMsMyM4yu8P8naNK3sitQlK8E3t9rjXJ1jA/lLsWlaREMfIj4OdAQ52kdXaZe7qedAAaokMiywUOz8LBXSyp2oMa+OA=
X-Received: by 2002:a05:6402:f2a:b0:461:eff7:bae8 with SMTP id
 i42-20020a0564020f2a00b00461eff7bae8mr9429eda.322.1666971152543; Fri, 28 Oct
 2022 08:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c5461a05ec18b4e6@google.com> <20221028150501.5159-1-yin31149@gmail.com>
In-Reply-To: <20221028150501.5159-1-yin31149@gmail.com>
From:   Hawkins Jiawei <yin31149@gmail.com>
Date:   Fri, 28 Oct 2022 23:32:20 +0800
Message-ID: <CAKrof1NyNjozshnGPgxKHuBoKgnd79tC50M44UL_DfeVBad+Kw@mail.gmail.com>
Subject: Re: [syzbot] WARNING in btrfs_block_rsv_release
To:     syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     18801353760@163.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="00000000000066139005ec19f79f"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--00000000000066139005ec19f79f
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Oct 2022 at 23:06, Hawkins Jiawei <yin31149@gmail.com> wrote:
>
> On Fri, 28 Oct 2022 at 19:14, Hawkins Jiawei <yin31149@gmail.com> wrote:
> >
> > Hi,
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1025dd72880000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
> > > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d16e6e880000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1672873c880000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
> > > mounted in repro: https://storage.googleapis.com/syzbot-assets/df89d50ed284/mount_0.gz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122 btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:154 [inline]
> > > WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122 block_rsv_release_bytes fs/btrfs/block-rsv.c:151 [inline]
> > > WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122 btrfs_block_rsv_release+0x5d1/0x730 fs/btrfs/block-rsv.c:295
> > > Modules linked in:
> > > CPU: 0 PID: 3612 Comm: syz-executor894 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> > > RIP: 0010:btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:122 [inline]
> > > RIP: 0010:btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:154 [inline]
> > > RIP: 0010:block_rsv_release_bytes fs/btrfs/block-rsv.c:151 [inline]
> > > RIP: 0010:btrfs_block_rsv_release+0x5d1/0x730 fs/btrfs/block-rsv.c:295
> > > Code: 8b 7c 24 10 74 08 4c 89 f7 e8 2b 94 33 fe 49 8b 1e 48 89 df 48 8b 2c 24 48 89 ee e8 a9 2b e0 fd 48 39 eb 73 0b e8 5f 29 e0 fd <0f> 0b 31 db eb 25 e8 54 29 e0 fd 48 b8 00 00 00 00 00 fc ff df 41
> > > RSP: 0000:ffffc90003baf9e8 EFLAGS: 00010293
> > > RAX: ffffffff83a657f1 RBX: 00000000000d0000 RCX: ffff888020c59d80
> > > RDX: 0000000000000000 RSI: 00000000000e0000 RDI: 00000000000d0000
> > > RBP: 00000000000e0000 R08: ffffffff83a657e7 R09: fffffbfff1c19fde
> > > R10: fffffbfff1c19fde R11: 1ffffffff1c19fdd R12: 1ffff11004f2190c
> > > R13: 00000000000e0000 R14: ffff88802790c860 R15: 0000000000000000
> > > FS:  000055555651b300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f207ed54000 CR3: 0000000026ea2000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  btrfs_release_global_block_rsv+0x2f/0x250 fs/btrfs/block-rsv.c:463
> > >  btrfs_free_block_groups+0xb67/0xfd0 fs/btrfs/block-group.c:4053
> > >  close_ctree+0x6c5/0xbde fs/btrfs/disk-io.c:4710
> > >  generic_shutdown_super+0x130/0x310 fs/super.c:491
> > >  kill_anon_super+0x36/0x60 fs/super.c:1085
> > >  btrfs_kill_super+0x3d/0x50 fs/btrfs/super.c:2441
> > >  deactivate_locked_super+0xa7/0xf0 fs/super.c:331
> > >  cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
> > >  task_work_run+0x146/0x1c0 kernel/task_work.c:177
> > >  ptrace_notify+0x29a/0x340 kernel/signal.c:2354
> > >  ptrace_report_syscall include/linux/ptrace.h:420 [inline]
> > >  ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
> > >  syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:249
> > >  syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c:276
> > >  __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
> > >  syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:294
> > >  do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x7f694614c2f7
> > > Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007ffee1dcd8e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
> > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f694614c2f7
> > > RDX: 00007ffee1dcd9a9 RSI: 000000000000000a RDI: 00007ffee1dcd9a0
> > > RBP: 00007ffee1dcd9a0 R08: 00000000ffffffff R09: 00007ffee1dcd780
> > > R10: 000055555651c653 R11: 0000000000000206 R12: 00007ffee1dcea20
> > > R13: 000055555651c5f0 R14: 00007ffee1dcd910 R15: 0000000000000004
> > >  </TASK>
> >
> > According to my analysis, this bug seems to be related to
> > btrfs_free_reserved_bytes()(Please correct me if I am wrong).
> >
> > To be more specific, in btrfs_new_extent_direct(), kernel will
> > reserves space for extent by btrfs_reserve_extent(), and
> > frees those space by btrfs_free_reserved_extent() if
> > btrfs_create_dio_extent() fails(such as inject_fault in the syzkaller)
> >
> > Yet the problem is that when reserving space for extent, kernel will
> > converts it from * ->bytes_may_use to ->bytes_reserved, in
> > btrfs_add_reserved_bytes(). But in freeing those space,
> > kernel does not convert it from ->bytes_reserved back to
> > * ->bytes_may_use in btrfs_free_reserved_bytes(),
> > which triggers the above warning.(Please correct me if I am wrong)
> >
> > So I think we can convert space from ->bytes_reserved back to
> > * ->bytes_may_use in btrfs_free_reserved_bytes() to solve this bug,
> > as below:
> >
>
> It seems that syzbot build/boot failed because of some
> irrelevant reason. Try the specific kernel version.

It seems that the syzbot got the incomplete patch from email,
so use a text attachment instead.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
493ffd6605b2d3d4dc7008ab927dba319f36671f

--00000000000066139005ec19f79f
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-btrfs-fix.patch"
Content-Disposition: attachment; filename="0001-btrfs-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l9snk82o0>
X-Attachment-Id: f_l9snk82o0

RnJvbSA3M2ExYTZjMDEyYTViODlhMzE2OTZiYzhiMDM3NzI0M2EwOGM4NzVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXdraW5zIEppYXdlaSA8eWluMzExNDlAZ21haWwuY29tPgpE
YXRlOiBGcmksIDI4IE9jdCAyMDIyIDE2OjQ1OjMwICswODAwCgpTaWduZWQtb2ZmLWJ5OiBIYXdr
aW5zIEppYXdlaSA8eWluMzExNDlAZ21haWwuY29tPgotLS0KIGZzL2J0cmZzL2Jsb2NrLWdyb3Vw
LmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZnMvYnRyZnMvYmxvY2stZ3JvdXAuYyBiL2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMKaW5kZXgg
ZGVlYmM4ZGRiZDkzLi5jYjc0ZmNiZjdhYWYgMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL2Jsb2NrLWdy
b3VwLmMKKysrIGIvZnMvYnRyZnMvYmxvY2stZ3JvdXAuYwpAQCAtMzQxNSw2ICszNDE1LDExIEBA
IHZvaWQgYnRyZnNfZnJlZV9yZXNlcnZlZF9ieXRlcyhzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAg
KmNhY2hlLAogCXNwYWNlX2luZm8tPmJ5dGVzX3Jlc2VydmVkIC09IG51bV9ieXRlczsKIAlzcGFj
ZV9pbmZvLT5tYXhfZXh0ZW50X3NpemUgPSAwOwogCisJdHJhY2VfYnRyZnNfc3BhY2VfcmVzZXJ2
YXRpb24oY2FjaGUtPmZzX2luZm8sICJzcGFjZV9pbmZvIiwKKwkJCQkgICAgICBzcGFjZV9pbmZv
LT5mbGFncywgLW51bV9ieXRlcywgMSk7CisJYnRyZnNfc3BhY2VfaW5mb191cGRhdGVfYnl0ZXNf
bWF5X3VzZShjYWNoZS0+ZnNfaW5mbywKKwkJCQkJICAgICAgc3BhY2VfaW5mbywgbnVtX2J5dGVz
KTsKKwogCWlmIChkZWxhbGxvYykKIAkJY2FjaGUtPmRlbGFsbG9jX2J5dGVzIC09IG51bV9ieXRl
czsKIAlzcGluX3VubG9jaygmY2FjaGUtPmxvY2spOwotLSAKMi4yNS4xCgo=
--00000000000066139005ec19f79f--
