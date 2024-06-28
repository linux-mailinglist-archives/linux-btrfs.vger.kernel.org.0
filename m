Return-Path: <linux-btrfs+bounces-6048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC1B91C868
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 23:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF721F27402
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 21:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008080C0B;
	Fri, 28 Jun 2024 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="kG6VeCsz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pVQfxuKo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E196C80638;
	Fri, 28 Jun 2024 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611253; cv=none; b=gd81tA5eMfK4qZvSGqO3Yp0hw+Nq+PyjrlKeKlOJvBt7WYtmpicYDXGLA0NerqWzEMH/cDbrXcVTLOfwL+xq6UA1hjsi89emqlg8u1QZwJEAlpV0PNZLAy3KopixXwudS10WjG4UnxzQopg6huAYll1We/7eT53e2iiAdEhR6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611253; c=relaxed/simple;
	bh=UBycaDwy+cb2eekJcJ04AGf/406wFW0e1r1qOa1fXTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HusLIm1XXpdDw7dCiFHPqrnywH7wdodZREb72sNb7iqWZZIpcl0Inv/AfxglotBn1ibmpq0oAYDaoMkICAayOyJnRHJUOlv1RcCopzYTywuk7yIUnYoelZQ66MQKSXzpyqyWf2Xby6xTsEDHvBCD3/XPecvG1H/oAUOkPqQfdOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=kG6VeCsz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pVQfxuKo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 027D111401D1;
	Fri, 28 Jun 2024 17:47:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 28 Jun 2024 17:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1719611249; x=1719697649; bh=nl5Dui0tly
	gT/mIarp0PPzB/Hjt4P1E356L11DaeRSs=; b=kG6VeCszW8+D/dP7zj+rROhPRu
	PA2Y/6/dYCuCdrKtiC3TWOGBUUEFfaLWWmaUQX9wkDiGoA81poo35GEvaQ2jRY6x
	aSwP8aHkGxPQL5zBWNhHAcTh8O2X70MsDEdwOY/aHXFmnob5w0n24qiNROrd+J8S
	Vf+OMYJZ5VVLEJZCdgvoTobWVJwzZyx73SlBiOpENTlR4SivVgJd/2Cb+LRy85iU
	yxaO2jtx+MgcJM/RF4Jc1r3bWj/dSZ50SJ0ZJtxRftkfIPH6HUK9QSiPYK7oIUqh
	+jmDTf3Jh4OoIf03/2ZCw25gpwSmiDhXMCD0OZiFLqJpgj4j4KAm6brZDAqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719611249; x=1719697649; bh=nl5Dui0tlygT/mIarp0PPzB/Hjt4
	P1E356L11DaeRSs=; b=pVQfxuKoNuqppcLeY4LvLnAW4XESrx2Gw0lhMvaqsNXm
	BksWeMpFmhKOMasQRqmGXzWpMipifAhcl4D34bivqjm2SBn+sGg1EyhxReN66GmW
	VU9JjZsgMh7cbC9T2Bb8C6DxxhCK/aH6GGBZuY8rNR1FyNWZeskKQZ27m5Jc0050
	8TARwtRfv45YSIcRJIH0goxXjEhnj73IazNmibVeLKurnEGVYTSy3RE01rlPYWYH
	5IwqPMJlS3MfbmrVJRAyNSAWMo4eiUYPSa++BpIZ0SNM0Br6bhhAgr3VUTJnjSR+
	m6ZhnAUKOZ9mCtHXZnX7wWDIuzV4iSAlJojyH4c1Cw==
X-ME-Sender: <xms:cS9_ZsUZzQoFu-uPrri_OnOoV9_-UlI0rcDKDL9Ms16V_ugSik6rOA>
    <xme:cS9_ZgkTDb4n11PD4y9hnZesmza1IpKrByuBFHlffVInl_Wk3Oq-MEz3uuvacc7HC
    GgRR9MlLFh7S-HD-DQ>
X-ME-Received: <xmr:cS9_ZgaJV_w5PWcjmxq3-3XYvSUeOjB2BoqZ6xsSe1gr2YPZplopD9hHC8IWQRe7gznuMiHYykbYzT2PomrpRvPBciY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdekgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepfe
    eltdehgeetlefhteetgeejhfelveejuddtfeekvdekleelgeelfffhjeeflefgnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpshihiihkrghllhgvrhdrrghpphhsphhothdrtg
    homhdpghhoohhglhgvrghpihhsrdgtohhmpdhgohhordhglhenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:cS9_ZrUnzOBbNcwE6jRXMZBZLrdiSWhfHAWGe_5xyQIGXMLM470GOA>
    <xmx:cS9_ZmlKue-zmKSqQy7TU28g4NYIN50MpY5x3vD0cnL7XtWkuz3qmg>
    <xmx:cS9_ZgehcbITndXnWD4ASkdpErle9kFA5sauLWHYG9XJTiyMAaXagg>
    <xmx:cS9_ZoFrHwi25ZY7fosCP-NA-m0j7wpITkz6-lWSnGlDyApIbtkJTg>
    <xmx:cS9_ZoVx9U1p73sOPSgyewi6mx312YpjFbeBwYYQL1lII9WcApkP7O47>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jun 2024 17:47:29 -0400 (EDT)
Date: Fri, 28 Jun 2024 14:46:53 -0700
From: Boris Burkov <boris@bur.io>
To: syzbot <syzbot+fe3566bcb509ae7764ef@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING in __btrfs_free_extent (2)
Message-ID: <20240628214653.GA2159431@zen.localdomain>
References: <0000000000000b2e35061b9078aa@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000b2e35061b9078aa@google.com>

On Sun, Jun 23, 2024 at 08:39:23AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10aed446980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
> dashboard link: https://syzkaller.appspot.com/bug?extid=fe3566bcb509ae7764ef
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ebe941980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1374b3de980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/35e32e9073a7/disk-2ccbdf43.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6c6e34658d16/vmlinux-2ccbdf43.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4417e7ef76ed/bzImage-2ccbdf43.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/b1cd2f1f0c7e/mount_0.gz
> 
> The issue was bisected to:
> 
> commit cecbb533b5fcec4ff77e786b7f94457f6cacd9e7
> Author: Boris Burkov <boris@bur.io>
> Date:   Wed Jun 28 18:00:15 2023 +0000
> 
>     btrfs: record simple quota deltas in delayed refs
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a47be2980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a47be2980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a47be2980000
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fe3566bcb509ae7764ef@syzkaller.appspotmail.com
> Fixes: cecbb533b5fc ("btrfs: record simple quota deltas in delayed refs")
> 
> BTRFS: Transaction aborted (error -2)
> WARNING: CPU: 0 PID: 5085 at fs/btrfs/extent-tree.c:2984 do_free_extent_accounting fs/btrfs/extent-tree.c:2984 [inline]
> WARNING: CPU: 0 PID: 5085 at fs/btrfs/extent-tree.c:2984 __btrfs_free_extent+0x32d1/0x3a10 fs/btrfs/extent-tree.c:3358
> Modules linked in:
> CPU: 0 PID: 5085 Comm: syz-executor845 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> RIP: 0010:do_free_extent_accounting fs/btrfs/extent-tree.c:2984 [inline]
> RIP: 0010:__btrfs_free_extent+0x32d1/0x3a10 fs/btrfs/extent-tree.c:3358
> Code: e8 64 b0 b0 fd 90 0f 0b 90 90 e9 3c f3 ff ff e8 b5 81 ee fd 90 48 c7 c7 00 2e 0b 8c 44 8b 6c 24 18 44 89 ee e8 40 b0 b0 fd 90 <0f> 0b 90 90 4c 8b 24 24 e9 4f f3 ff ff e8 8d 81 ee fd 90 48 c7 c7
> RSP: 0018:ffffc9000352f220 EFLAGS: 00010246
> RAX: 7e1377ca92db5900 RBX: ffff888024e3c001 RCX: ffff88807c1f0000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc9000352f3f0 R08: ffffffff81585742 R09: fffffbfff1c39994
> R10: dffffc0000000000 R11: fffffbfff1c39994 R12: dffffc0000000000
> R13: 00000000fffffffe R14: 0000000000000000 R15: ffff888063a8b5c8
> FS:  000055556fa3c3c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005648b40a4798 CR3: 0000000023a7e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  run_delayed_tree_ref fs/btrfs/extent-tree.c:1736 [inline]
>  run_one_delayed_ref fs/btrfs/extent-tree.c:1762 [inline]
>  btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2027 [inline]
>  __btrfs_run_delayed_refs+0x117c/0x4670 fs/btrfs/extent-tree.c:2097
>  btrfs_run_delayed_refs+0xe3/0x2c0 fs/btrfs/extent-tree.c:2209
>  btrfs_commit_transaction+0xf5d/0x3740 fs/btrfs/transaction.c:2400
>  sync_filesystem+0x1c8/0x230 fs/sync.c:66
>  generic_shutdown_super+0x72/0x2d0 fs/super.c:621
>  kill_anon_super+0x3b/0x70 fs/super.c:1226
>  btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2096
>  deactivate_locked_super+0xc4/0x130 fs/super.c:473
>  cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
>  task_work_run+0x24f/0x310 kernel/task_work.c:180
>  ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
>  ptrace_report_syscall include/linux/ptrace.h:415 [inline]
>  ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
>  syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
>  syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
>  syscall_exit_to_user_mode+0x273/0x370 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fda22d8de67
> Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
> RSP: 002b:00007fffaba15888 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fda22d8de67
> RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffaba15940
> RBP: 00007fffaba15940 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000206 R12: 00007fffaba16a00
> R13: 000055556fa3d700 R14: 431bde82d7b634db R15: 00007fffaba169a4
>  </TASK>
> 
> 

This is a legitimate issue. The basic idea is that when you enable
simple quotas on an existing fs, the existing subvols start at 0 usage.
Subsequently, we can add and remove extents and occasionally hit 0
again.

If 0 usage is the only saving grace for rejecting qgroup deletion, we
can hit a race where we pass the 0 check in the deletion code, then
record a positive squota delta, then actually delete the qgroup, then
delete and try to record the delete for that extent by which point the
qgroup is gone and we blow up on ENOENT.

The possible fixes I can think of are:
- lock something during qgroup deletion that record_squota_delta also
  takes
- mark the qgroup ro after the point of no return on deleting it
- disallow deleting qgroups whose subvol still exists

The third option has already been implemented and is why this doesn't
reproduce on the tip of btrfs/for-next. The first option could be an
interesting option to be extra safe, even with the third in place.

Therefore,
#syz fix: btrfs: slightly loosen the requirement for qgroup removal

> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

