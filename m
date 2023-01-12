Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039E56673AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 14:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjALNyN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 08:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjALNyJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 08:54:09 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C836E1169;
        Thu, 12 Jan 2023 05:54:07 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pFy1s-0001To-HW; Thu, 12 Jan 2023 14:54:04 +0100
Message-ID: <7f25442f-b121-2a3a-5a3d-22bcaae83cd4@leemhuis.info>
Date:   Thu, 12 Jan 2023 14:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, de-DE
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthias Schoepfer <matthias.schoepfer@googlemail.com>,
        Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: =?UTF-8?Q?=5bregression=5d_Bug=c2=a0216908_-_General_Protection_Fau?=
 =?UTF-8?Q?lt_in_btrfs=5ffile=5fllseek?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673531647;cce516f8;
X-HE-SMSGID: 1pFy1s-0001To-HW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216908 :

>  Matthias Schoepfer 2023-01-10 13:58:06 UTC
> 
> When creating a large file (i.e. mkfs.ext4 within yocto embedded linux task, which means, 8+GB file), mkfs.ext4 will report a segfault and I get a general protection fault, the system becomes more or less unstable after this. 
> 
> I can reproduce this 100%, when I do the same with 6.0.6 kernel, it works fine. 
> 
> Here is the Kernel dump:
> Jan 10 14:12:38 michelle kernel: BTRFS warning (device nvme0n1p5): bad eb member end: ptr 0x3fea start 2704543268864 member offset 16383 size 8
> Jan 10 14:12:38 michelle kernel: general protection fault, probably for non-canonical address 0x85d8740000000: 0000 [#1] PREEMPT SMP
> Jan 10 14:12:38 michelle kernel: CPU: 21 PID: 2143606 Comm: mkfs.ext4.real Tainted: P           O    T  6.1.4-gentoo #2
> Jan 10 14:12:38 michelle kernel: Hardware name: Micro-Star International Co., Ltd. MS-7C37/X570-A PRO (MS-7C37), BIOS H.70 01/09/2020
> Jan 10 14:12:38 michelle kernel: RIP: 0010:btrfs_get_64+0xe7/0x100
> Jan 10 14:12:38 michelle kernel: Code: 40 08 48 2b 15 b2 3a 15 01 48 8d 0c 04 48 c1 fa 06 48 c1 e2 0c 48 03 15 af 3a 15 01 81 eb f8 0f 00 00 74 12 31 c0 89 c6 ff c0 <0f> b6 3c 32 40 88 3c 3>
> Jan 10 14:12:38 michelle kernel: RSP: 0018:ffffb2d4ca4c3dd0 EFLAGS: 00010202
> Jan 10 14:12:38 michelle kernel: RAX: 0000000000000001 RBX: 0000000000000007 RCX: ffffb2d4ca4c3dd9
> Jan 10 14:12:38 michelle kernel: RDX: 00085d8740000000 RSI: 0000000000000000 RDI: 000000000000000a
> Jan 10 14:12:38 michelle kernel: RBP: ffff96fbbfd9c600 R08: 0000000000000001 R09: 00000000ffffdfff
> Jan 10 14:12:38 michelle kernel: R10: ffffffff94a3a700 R11: ffffffff94aea700 R12: 0000000000000003
> Jan 10 14:12:38 michelle kernel: R13: ffff96fbbfd9c600 R14: 0000000000000003 R15: 0000000000003fea
> Jan 10 14:12:38 michelle kernel: FS:  00007f6ac90e5780(0000) GS:ffff97071ed40000(0000) knlGS:0000000000000000
> Jan 10 14:12:38 michelle kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jan 10 14:12:38 michelle kernel: CR2: 0000557c6f245760 CR3: 000000019a64a000 CR4: 0000000000350ee0
> Jan 10 14:12:38 michelle kernel: Call Trace:
> Jan 10 14:12:38 michelle kernel:  <TASK>
> Jan 10 14:12:38 michelle kernel:  btrfs_file_llseek+0x269/0x670
> Jan 10 14:12:38 michelle kernel:  ksys_lseek+0x61/0xa0
> Jan 10 14:12:38 michelle kernel:  do_syscall_64+0x56/0x80
> Jan 10 14:12:38 michelle kernel:  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> Jan 10 14:12:38 michelle kernel: RIP: 0033:0x7f6ac91e4d3b
> Jan 10 14:12:38 michelle kernel: Code: ff ff c3 0f 1f 40 00 48 8b 15 e1 90 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 f3 0f 1e fa b8 08 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 0>
> Jan 10 14:12:38 michelle kernel: RSP: 002b:00007fff68e04038 EFLAGS: 00000297 ORIG_RAX: 0000000000000008
> Jan 10 14:12:38 michelle kernel: RAX: ffffffffffffffda RBX: 000056367d4ffea0 RCX: 00007f6ac91e4d3b
> Jan 10 14:12:38 michelle kernel: RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000004
> Jan 10 14:12:38 michelle kernel: RBP: 0000000000000004 R08: 00007f6ac92bef90 R09: 000056367d4f6160
> Jan 10 14:12:38 michelle kernel: R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000000
> Jan 10 14:12:38 michelle kernel: R13: 000056367d4c0eb0 R14: 000056367d50d620 R15: 000056367d4ebab0
> Jan 10 14:12:38 michelle kernel:  </TASK>
> Jan 10 14:12:38 michelle kernel: Modules linked in: xt_CHECKSUM xt_MASQUERADE nvidia_drm(PO) nvidia_modeset(PO) ip6table_nat iptable_nat bpfilter nvidia(PO) uvcvideo videobuf2_vmalloc video>
> Jan 10 14:12:38 michelle kernel: ---[ end trace 0000000000000000 ]---
> Jan 10 14:12:38 michelle kernel: RIP: 0010:btrfs_get_64+0xe7/0x100
> Jan 10 14:12:38 michelle kernel: Code: 40 08 48 2b 15 b2 3a 15 01 48 8d 0c 04 48 c1 fa 06 48 c1 e2 0c 48 03 15 af 3a 15 01 81 eb f8 0f 00 00 74 12 31 c0 89 c6 ff c0 <0f> b6 3c 32 40 88 3c 3>
> Jan 10 14:12:38 michelle kernel: RSP: 0018:ffffb2d4ca4c3dd0 EFLAGS: 00010202
> Jan 10 14:12:38 michelle kernel: RAX: 0000000000000001 RBX: 0000000000000007 RCX: ffffb2d4ca4c3dd9
> Jan 10 14:12:38 michelle kernel: RDX: 00085d8740000000 RSI: 0000000000000000 RDI: 000000000000000a
> Jan 10 14:12:38 michelle kernel: RBP: ffff96fbbfd9c600 R08: 0000000000000001 R09: 00000000ffffdfff
> Jan 10 14:12:38 michelle kernel: R10: ffffffff94a3a700 R11: ffffffff94aea700 R12: 0000000000000003
> Jan 10 14:12:38 michelle kernel: R13: ffff96fbbfd9c600 R14: 0000000000000003 R15: 0000000000003fea
> Jan 10 14:12:38 michelle kernel: FS:  00007f6ac90e5780(0000) GS:ffff97071ed40000(0000) knlGS:0000000000000000
> Jan 10 14:12:38 michelle kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jan 10 14:12:38 michelle kernel: CR2: 0000557c6f245760 CR3: 000000019a64a000 CR4: 0000000000350ee0

See the ticket for more details.

I first assumed (see the ticket) it might be the same problem that was
fixed by "btrfs: fix resolving backrefs for inline extent followed by
prealloc"
(https://lore.kernel.org/all/20230104160512.620453792@linuxfoundation.org/
) -- but that is already in 6.1.4, so I better keep my nose out of it
and let the experts look into this.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.0..v6.1.4
https://bugzilla.kernel.org/show_bug.cgi?id=216908
#regzbot title: btrfs: General Protection Fault in btrfs_file_llseek
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
