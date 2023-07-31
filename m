Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91363768B71
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 07:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjGaF4X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 01:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGaF4W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 01:56:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F22BE7B;
        Sun, 30 Jul 2023 22:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690782962; x=1691387762; i=quwenruo.btrfs@gmx.com;
 bh=iZfM+1D+I33xUpNSlouoADjpWrN/B7KmrE01Ld0Ykcc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=n3DgeecefpFoI5GQKeSSg99IRCJN+wjngD80ifZk0kNN5VWFrcFMUCQgZxCuo3V20eqaGZm
 CDTmUxWDCCPwsPsbD4xXZH7ExEeszquV/KlxNuKefkGQXFzWfmtRfXqcrn+wv/UektEyZBU8D
 C7jPCp63FxrsVHwteRbsQEY0jq3zpWNbhTMQVUFATj7Om8GZPZUL7OVAZJmJFEUprHQ30SQeQ
 yxlkJC1aDMqxXzEhptRnQAD4DoD+LYgNN9xCpkS283YUN9JoxP4T6i9Up9CIHiC+gLR22udtU
 6+Msh8+fXcPAPQ2XAnzA3ixpbyuxCXos4jNAKZ6mOzxx/tNLcuJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MD9XF-1qYuae29T7-009BIr; Mon, 31
 Jul 2023 07:56:02 +0200
Message-ID: <2de85e6f-b1ad-69ae-1e60-cd47c91115a9@gmx.com>
Date:   Mon, 31 Jul 2023 13:55:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [syzbot] WARNING in lookup_inline_extent_backref
Content-Language: en-US
To:     syzbot <syzbot+d6f9ff86c1d804ba2bc6@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000003d4a1a05ef104401@google.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <0000000000003d4a1a05ef104401@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P1TvVKLaw8Xljs0HCPdgLedFB6doq4+5BsFqMfGUEYPojIUhMCH
 Tpv0PIPVa6FJp7abZ+anZVCCZgpn18jYmvtBA5TNDde+8KXEV1YIOvXQA4LW5OijyyHYCEd
 qRT7FZt+KrJJTjV9xBJ4aCv8ig9DxTDfgZ7zCOImqhDWAsjs7OYtDgbyGHqZuRAxSs7BgkU
 FbdCOC5ep6EAi8Bn3w2PA==
UI-OutboundReport: notjunk:1;M01:P0:QYk90iGofe0=;59X4KQ6cRYHgH6V4lOcIk/ouRZo
 WNkY2MJ0JgSZhLpIEqpuIYymqG+bUBvKNyMzSoTUbX+9BuLUr7XHs2o3BCa8E0THkpfuYK9qg
 vLTiNbK509AZBid5qhdwHpegUZNila0LVF0vs17M6Ah1S5QMV6izI9YQy2KCrUKpBwx/w7GIi
 aCNUZp4TB2wNQC6cq5FACT4Cmj23hHT+np2GBgs0NRbMYcs0XlyDiA0PaEP6KOp0DU9c8rlBz
 rsbhXNkqYuBgHeqAH379+RORRHdZ9A1su8HkG8+awWWHmCVpiwUNZTqufXUWNEKTtO3zugH3H
 7KVVGT+oIi66vgVsIPj4QpMnIKlAsGLiYKJ1Ux9nBLYJENb9YG9bY4nZkOjZabAHjJAn7TbeV
 oFQrAgWp/eGxe+h2g1Q92gGjG6KZmIBPib8FLV47rdVbTLbs6UwJG8fe4RQ9GDqXn9Suqa5xy
 MACXr9RqjAf4fLJE6lR5vjdZ9R/aC8uUjvoOEkGa4E7hKnoqos9x0Kx2yRmKNQ0sPoH2MBi/j
 COxW0ZJhNVh2uVSpDvonCkB1mXPNrYeRviW9CCLWbcOaHG8Y+TSP5xyepNwgkmoWE1uM/VALF
 E/X2cKzLBOJzmoQgLpTRPkLGuuUQpGxz1w+o3psYUWN7AGeY7sqe+MZP4tKBJWC9AE/7VNlnJ
 iZm/qfS3FRF4yvh59BHsO4f4++R1QG06Bd3wKMWvm+Ce5S+dpKu/hZTdMqgHg2vl6qBsYcG3p
 7PoYYkzkWg/L0KK7j3vQ5s14BmYdHhusZ+jLTcVds7mobvdsjQLcW8A3nG52JIC/7upJISjuS
 p9rXeQyoS+nbZh8JY0DpW7zlEpvahpjRzfEfnZdVqqRR/Z8o4Bv4+VLN+081risRYuJk+m3B9
 xdKlwjRtvcxKI8rCuB9DPghGrwfVkmWbTPot8ea3oZRxHCHOYH2xUILPiBZzW8vQx0J9K+YiS
 Kz85Ibr5qY9U97bI36UtxLimg2I=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/5 16:13, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a4412fdd49dc error-injection: Add prompt for function er=
ro..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1469bdbd8800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2325e409a9a8=
93e1
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd6f9ff86c1d804=
ba2bc6
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2d=
a-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12d8924788=
0000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16b1ca838800=
00
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3bbe66b25958/di=
sk-a4412fdd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6851483ca667/vmlin=
ux-a4412fdd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2d5b23cb4616/=
bzImage-a4412fdd.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/1f178223d=
d56/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+d6f9ff86c1d804ba2bc6@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6559 at fs/btrfs/extent-tree.c:865 lookup_inline_ex=
tent_backref+0x8c1/0x13f0
> Modules linked in:
> CPU: 0 PID: 6559 Comm: syz-executor311 Not tainted 6.1.0-rc7-syzkaller-0=
0123-ga4412fdd49dc #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 10/26/2022
> RIP: 0010:lookup_inline_extent_backref+0x8c1/0x13f0 fs/btrfs/extent-tree=
.c:865
> Code: 98 00 00 00 0f 87 42 0b 00 00 e8 5a 9c 07 fe 4c 8b 6c 24 28 eb 3d =
83 7d 28 00 4c 8b 6c 24 28 0f 84 b0 04 00 00 e8 3f 9c 07 fe <0f> 0b 41 bc =
fb ff ff ff e9 f3 05 00 00 e8 2d 9c 07 fe e9 ca 05 00
> RSP: 0018:ffffc90006296e40 EFLAGS: 00010293
> RAX: ffffffff8382fbb1 RBX: 0000000000000000 RCX: ffff88801eab1d40
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90006296ff0 R08: ffffffff8382f700 R09: ffffed100faf1008
> R10: ffffed100faf1008 R11: 1ffff1100faf1007 R12: dffffc0000000000
> R13: ffff888075edcd10 R14: ffffc90006296f60 R15: ffff88807d788000
> FS:  00007fdb617d5700(0000) GS:ffff8880b9900000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055912e028900 CR3: 000000001954b000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   insert_inline_extent_backref+0xcc/0x260 fs/btrfs/extent-tree.c:1152
>   __btrfs_inc_extent_ref+0x108/0x5e0 fs/btrfs/extent-tree.c:1455
>   btrfs_run_delayed_refs_for_head+0xf00/0x1df0 fs/btrfs/extent-tree.c:19=
43
>   __btrfs_run_delayed_refs+0x25f/0x490 fs/btrfs/extent-tree.c:2008
>   btrfs_run_delayed_refs+0x312/0x490 fs/btrfs/extent-tree.c:2139
>   qgroup_account_snapshot+0xce/0x340 fs/btrfs/transaction.c:1538
>   create_pending_snapshot+0xf35/0x2560 fs/btrfs/transaction.c:1800
>   create_pending_snapshots+0x1a8/0x1e0 fs/btrfs/transaction.c:1868
>   btrfs_commit_transaction+0x13f0/0x3760 fs/btrfs/transaction.c:2323
>   create_snapshot+0x4aa/0x7e0 fs/btrfs/ioctl.c:833
>   btrfs_mksubvol+0x62e/0x760 fs/btrfs/ioctl.c:983
>   btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1029
>   __btrfs_ioctl_snap_create+0x339/0x450 fs/btrfs/ioctl.c:2184
>   btrfs_ioctl_snap_create+0x134/0x190 fs/btrfs/ioctl.c:2211
>   btrfs_ioctl+0x15c/0xc10
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:870 [inline]
>   __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fdb6184aa69
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdb617d52f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fdb618d57f0 RCX: 00007fdb6184aa69
> RDX: 00000000200000c0 RSI: 0000000050009401 RDI: 0000000000000004
> RBP: 00007fdb618a226c R08: 00007fdb617d5700 R09: 0000000000000000
> R10: 00007fdb617d5700 R11: 0000000000000246 R12: 8000000000000000
> R13: 00007fdb618a1270 R14: 0000000100000000 R15: 00007fdb618d57f8
>   </TASK>

# syz test: git://github.com/adam900710/linux.git inline_lookup_debug
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
