Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C46221A6
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 06:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfEREoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 May 2019 00:44:13 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45522 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbfEREoM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 00:44:12 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C081430276A; Sat, 18 May 2019 00:44:11 -0400 (EDT)
Date:   Sat, 18 May 2019 00:44:11 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: storm-of-soft-lockups: spinlocks running on all cores,
 preventing forward progress (4.14- to 5.0+)
Message-ID: <20190518044411.GH20359@hungrycats.org>
References: <20190515213650.GG20359@hungrycats.org>
 <0480104e-db25-4e2f-08e5-0236ffd5c1c2@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Content-Disposition: inline
In-Reply-To: <0480104e-db25-4e2f-08e5-0236ffd5c1c2@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 09:57:01AM +0300, Nikolay Borisov wrote:
>=20
>=20
> On 16.05.19 =D0=B3. 0:36 =D1=87., Zygo Blaxell wrote:
> > "Storm-of-soft-lockups" is a failure mode where btrfs puts all of the
> > CPU cores in kernel functions that are unable to make forward progress,
> > but also unwilling to release their respective CPU cores.  This is
> > usually accompanied by a lot of CPU usage (detectable as either kvm CPU
> > usage or just a lot of CPU fan noise) though I don't know if all cores
> > are spinning or only some of them.
> >=20
> > The kernel console presents a continual stream of "BUG: soft lockup"
> > warnings for some days.  None of the call traces change during this tim=
e.
> > The only way out is to reboot.
> >=20
> > You can reproduce this by writing a bunch of data to a filesystem while
> > bees is running on all cores.  It takes a few days to occur naturally.
> > It can probably be sped up by just doing a bunch of random LOGICAL_INO
> > ioctls in a tight loop on each core.
> >=20
> > Here's an instance on a 4-CPU VM where CPU#0 is running btrfs-transacti=
on
> > (btrfs_try_tree_write_lock) and CPU#1-3 are running the LOGICAL_INO
> > ioctl (btrfs_tree_read_lock_atomic):
>=20
>=20
> Provide output of all sleeping threads when this occur via
>  echo w > /proc/sysrq-trigger.

I fixed my SysRq configuration.  The results are...kind of interesting.
I guess the four threads that are running loops on all cores don't count
as "blocked"...

	[39610.791203] sysrq: SysRq : Show Blocked State
	[39610.791934]   task                        PC stack   pid father
	[39610.792832] btrfs-transacti D    0  4643      2 0x80000000
	[39610.793613] Call Trace:
	[39610.793970]  __schedule+0x3d4/0xb70
	[39610.794472]  schedule+0x3d/0x80
	[39610.794925]  wait_for_commit+0x59/0xa0
	[39610.795464]  ? wait_woken+0xa0/0xa0
	[39610.795962]  btrfs_commit_transaction+0x122/0xab0
	[39610.796635]  ? start_transaction+0x93/0x4d0
	[39610.797228]  transaction_kthread+0x155/0x190
	[39610.797836]  kthread+0x113/0x150
	[39610.798296]  ? btrfs_cleanup_transaction+0x630/0x630
	[39610.799004]  ? kthread_park+0x90/0x90
	[39610.799542]  ret_from_fork+0x3a/0x50
	[39610.800080] rsync           D    0 12832   8251 0x00000000
	[39610.800868] Call Trace:
	[39610.801223]  __schedule+0x3d4/0xb70
	[39610.801728]  schedule+0x3d/0x80
	[39610.802179]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39610.802919]  ? wake_up_var+0x40/0x40
	[39610.803436]  btrfs_setattr+0x316/0x5a0
	[39610.803970]  notify_change+0x2f0/0x450
	[39610.804513]  do_truncate+0x73/0xc0
	[39610.805029]  do_sys_ftruncate+0x12b/0x1c0
	[39610.805606]  __x64_sys_ftruncate+0x1b/0x20
	[39610.806193]  do_syscall_64+0x65/0x1a0
	[39610.806831]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39610.807556] RIP: 0033:0x7f10d5005c97
	[39610.808069] Code: Bad RIP value.
	[39610.808539] RSP: 002b:00007ffea589cf28 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39610.809649] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f10d5=
005c97
	[39610.810790] RDX: 0000000000000000 RSI: 00000000000001cc RDI: 0000000000=
000003
	[39610.811798] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000c8=
46d527
	[39610.812873] R10: 00000000894b52a9 R11: 0000000000000246 R12: 0000000000=
0001cc
	[39610.813936] R13: 0000000000000000 R14: 00000000000001cc R15: 0000000000=
000000
	[39610.815048] rsync           D    0 12834   8444 0x00000000
	[39610.815826] Call Trace:
	[39610.816181]  __schedule+0x3d4/0xb70
	[39610.816909]  schedule+0x3d/0x80
	[39610.817505]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39610.818264]  ? wake_up_var+0x40/0x40
	[39610.818808]  btrfs_setattr+0x316/0x5a0
	[39610.819373]  notify_change+0x2f0/0x450
	[39610.820129]  do_truncate+0x73/0xc0
	[39610.820739]  do_sys_ftruncate+0x12b/0x1c0
	[39610.821409]  __x64_sys_ftruncate+0x1b/0x20
	[39610.822040]  do_syscall_64+0x65/0x1a0
	[39610.822614]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39610.823385] RIP: 0033:0x7fade44efc97
	[39610.824203] Code: Bad RIP value.
	[39610.824877] RSP: 002b:00007ffc9f263818 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39610.826038] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fade4=
4efc97
	[39610.828361] RDX: 0000000000000000 RSI: 00000000001b0b3c RDI: 0000000000=
000003
	[39610.829580] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000e9=
809e58
	[39610.830932] R10: 00000000f8cf8f2b R11: 0000000000000246 R12: 0000000000=
1b0b3c
	[39610.832178] R13: 00000000001b0820 R14: 000000000000031c R15: 0000000000=
000000
	[39610.833491] rsync           D    0 12835   8183 0x00000000
	[39610.834353] Call Trace:
	[39610.834747]  __schedule+0x3d4/0xb70
	[39610.835286]  schedule+0x3d/0x80
	[39610.835782]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39610.836646]  ? wake_up_var+0x40/0x40
	[39610.837201]  btrfs_setattr+0x316/0x5a0
	[39610.837790]  notify_change+0x2f0/0x450
	[39610.838364]  do_truncate+0x73/0xc0
	[39610.838913]  do_sys_ftruncate+0x12b/0x1c0
	[39610.839542]  __x64_sys_ftruncate+0x1b/0x20
	[39610.840161]  do_syscall_64+0x65/0x1a0
	[39610.840720]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39610.841496] RIP: 0033:0x7f696d6efc97
	[39610.842138] Code: Bad RIP value.
	[39610.842679] RSP: 002b:00007fff121f34d8 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39610.844008] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f696d=
6efc97
	[39610.845271] RDX: 0000000000000000 RSI: 00000000000001cc RDI: 0000000000=
000003
	[39610.846532] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000c8=
46d527
	[39610.847696] R10: 00000000894b52a9 R11: 0000000000000246 R12: 0000000000=
0001cc
	[39610.848839] R13: 0000000000000000 R14: 00000000000001cc R15: 0000000000=
000000
	[39610.850001] rsync           D    0 12838   7602 0x00000000
	[39610.850909] Call Trace:
	[39610.851332]  __schedule+0x3d4/0xb70
	[39610.851981]  schedule+0x3d/0x80
	[39610.852535]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39610.853455]  ? wake_up_var+0x40/0x40
	[39610.854085]  btrfs_setattr+0x316/0x5a0
	[39610.854763]  notify_change+0x2f0/0x450
	[39610.855420]  do_truncate+0x73/0xc0
	[39610.856001]  do_sys_ftruncate+0x12b/0x1c0
	[39610.856691]  __x64_sys_ftruncate+0x1b/0x20
	[39610.857420]  do_syscall_64+0x65/0x1a0
	[39610.858104]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39610.859016] RIP: 0033:0x7f2bed4a1c97
	[39610.859673] Code: Bad RIP value.
	[39610.860260] RSP: 002b:00007fffa14b3ba8 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39610.861586] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2bed=
4a1c97
	[39610.862862] RDX: 0000000000000000 RSI: 00000000001b0b3c RDI: 0000000000=
000003
	[39610.864102] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000e9=
809e58
	[39610.865324] R10: 00000000f8cf8f2b R11: 0000000000000246 R12: 0000000000=
1b0b3c
	[39610.866559] R13: 00000000001b0820 R14: 000000000000031c R15: 0000000000=
000000
	[39610.867760] rsync           D    0 12842   8631 0x00000000
	[39610.868684] Call Trace:
	[39610.869102]  __schedule+0x3d4/0xb70
	[39610.869694]  schedule+0x3d/0x80
	[39610.870224]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39610.871162]  ? wake_up_var+0x40/0x40
	[39610.871826]  btrfs_setattr+0x316/0x5a0
	[39610.872466]  notify_change+0x2f0/0x450
	[39610.873087]  do_truncate+0x73/0xc0
	[39610.873702]  do_sys_ftruncate+0x12b/0x1c0
	[39610.874419]  __x64_sys_ftruncate+0x1b/0x20
	[39610.875168]  do_syscall_64+0x65/0x1a0
	[39610.875841]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39610.876736] RIP: 0033:0x7fd20067bc97
	[39610.877382] Code: Bad RIP value.
	[39610.877993] RSP: 002b:00007ffd11215d58 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39610.879337] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd200=
67bc97
	[39610.880591] RDX: 0000000000000000 RSI: 0000000001b9face RDI: 0000000000=
000003
	[39610.881881] RBP: 0000000000000003 R08: 0000000000000000 R09: 000000007a=
fe8ff0
	[39610.883163] R10: 00000000092d5688 R11: 0000000000000246 R12: 0000000001=
b9face
	[39610.884312] R13: 0000000001b9e700 R14: 00000000000013ce R15: 0000000000=
000000
	[39610.885445] rsync           D    0 12845   8614 0x00000000
	[39610.886352] Call Trace:
	[39610.886754]  __schedule+0x3d4/0xb70
	[39610.887301]  schedule+0x3d/0x80
	[39610.887820]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39610.888731]  ? wake_up_var+0x40/0x40
	[39610.889323]  btrfs_setattr+0x316/0x5a0
	[39610.889979]  notify_change+0x2f0/0x450
	[39610.890569]  do_truncate+0x73/0xc0
	[39610.891102]  do_sys_ftruncate+0x12b/0x1c0
	[39610.891803]  __x64_sys_ftruncate+0x1b/0x20
	[39610.892460]  do_syscall_64+0x65/0x1a0
	[39610.893029]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39610.893853] RIP: 0033:0x7f697f553c97
	[39610.894481] Code: Bad RIP value.
	[39610.895058] RSP: 002b:00007ffed6c8bbb8 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39610.896391] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f697f=
553c97
	[39610.897665] RDX: 0000000000000000 RSI: 0000000000014ab8 RDI: 0000000000=
000003
	[39610.898926] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000fb=
17ef2f
	[39610.900177] R10: 000000009ebff28a R11: 0000000000000246 R12: 0000000000=
014ab8
	[39610.901436] R13: 0000000000014820 R14: 0000000000000298 R15: 0000000000=
000000
	[39610.902697] rsync           D    0 12846   9349 0x00000000
	[39610.903619] Call Trace:
	[39610.904017]  __schedule+0x3d4/0xb70
	[39610.904584]  schedule+0x3d/0x80
	[39610.905125]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39610.906044]  ? wake_up_var+0x40/0x40
	[39610.906707]  btrfs_setattr+0x316/0x5a0
	[39610.907398]  notify_change+0x2f0/0x450
	[39610.908091]  do_truncate+0x73/0xc0
	[39610.908694]  do_sys_ftruncate+0x12b/0x1c0
	[39610.909390]  __x64_sys_ftruncate+0x1b/0x20
	[39610.910120]  do_syscall_64+0x65/0x1a0
	[39610.910715]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39610.911535] RIP: 0033:0x7f77c7350c97
	[39610.912171] Code: Bad RIP value.
	[39610.912750] RSP: 002b:00007fff3402b998 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39610.914036] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f77c7=
350c97
	[39610.915156] RDX: 0000000000000000 RSI: 000000000001b800 RDI: 0000000000=
000003
	[39610.916607] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000012=
f2a017
	[39610.917739] R10: 000000005ca8e044 R11: 0000000000000246 R12: 0000000000=
01b800
	[39610.918957] R13: 000000000001b580 R14: 0000000000000280 R15: 0000000000=
000000
	[39610.920107] rsync           D    0 12847  10903 0x00000000
	[39610.921024] Call Trace:
	[39610.921422]  __schedule+0x3d4/0xb70
	[39610.921964]  schedule+0x3d/0x80
	[39610.922457]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39610.923278]  ? wake_up_var+0x40/0x40
	[39610.924019]  btrfs_setattr+0x316/0x5a0
	[39610.924631]  notify_change+0x2f0/0x450
	[39610.925226]  do_truncate+0x73/0xc0
	[39610.925786]  do_sys_ftruncate+0x12b/0x1c0
	[39610.926723]  __x64_sys_ftruncate+0x1b/0x20
	[39610.927375]  do_syscall_64+0x65/0x1a0
	[39610.927963]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39610.928772] RIP: 0033:0x7f3462c85c97
	[39610.929341] Code: Bad RIP value.
	[39610.929883] RSP: 002b:00007ffd4b538368 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39610.931068] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3462=
c85c97
	[39610.932254] RDX: 0000000000000000 RSI: 0000000001b9face RDI: 0000000000=
000003
	[39610.933373] RBP: 0000000000000003 R08: 0000000000000000 R09: 000000007a=
fe8ff0
	[39610.934622] R10: 00000000092d5688 R11: 0000000000000246 R12: 0000000001=
b9face
	[39610.935811] R13: 0000000001b9e700 R14: 00000000000013ce R15: 0000000000=
000000
	[39610.936938] rsync           D    0 12849   6970 0x00000000
	[39610.938109] Call Trace:
	[39610.938515]  __schedule+0x3d4/0xb70
	[39610.939071]  schedule+0x3d/0x80
	[39610.939585]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39610.940407]  ? wake_up_var+0x40/0x40
	[39610.940959]  btrfs_setattr+0x316/0x5a0
	[39610.941544]  notify_change+0x2f0/0x450
	[39610.942146]  do_truncate+0x73/0xc0
	[39610.942762]  do_sys_ftruncate+0x12b/0x1c0
	[39610.943383]  __x64_sys_ftruncate+0x1b/0x20
	[39610.944209]  do_syscall_64+0x65/0x1a0
	[39610.944786]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39610.945656] RIP: 0033:0x7f3044497c97
	[39610.946409] Code: Bad RIP value.
	[39610.947155] RSP: 002b:00007fffb7404608 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39610.948596] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3044=
497c97
	[39610.949873] RDX: 0000000000000000 RSI: 000000000049a1d8 RDI: 0000000000=
000003
	[39610.951494] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000bb=
1d27a0
	[39610.952718] R10: 00000000f74314fb R11: 0000000000000246 R12: 0000000000=
49a1d8
	[39610.953893] R13: 0000000000499e10 R14: 00000000000003c8 R15: 0000000000=
000000
	[39610.954982] rsync           D    0 12850   8121 0x00000000
	[39610.956640] Call Trace:
	[39610.957089]  __schedule+0x3d4/0xb70
	[39610.957805]  schedule+0x3d/0x80
	[39610.958456]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39610.959472]  ? wake_up_var+0x40/0x40
	[39610.960176]  btrfs_setattr+0x316/0x5a0
	[39610.960779]  notify_change+0x2f0/0x450
	[39610.961377]  do_truncate+0x73/0xc0
	[39610.961924]  do_sys_ftruncate+0x12b/0x1c0
	[39610.962760]  __x64_sys_ftruncate+0x1b/0x20
	[39610.963419]  do_syscall_64+0x65/0x1a0
	[39610.964085]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39610.964943] RIP: 0033:0x7f8e0c156c97
	[39610.965924] Code: Bad RIP value.
	[39610.966517] RSP: 002b:00007ffcb0f66bb8 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39610.967977] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8e0c=
156c97
	[39610.969245] RDX: 0000000000000000 RSI: 00000000000093d8 RDI: 0000000000=
000003
	[39610.970619] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000021=
682eb2
	[39610.971881] R10: 00000000e1f12d36 R11: 0000000000000246 R12: 0000000000=
0093d8
	[39610.973300] R13: 00000000000093a8 R14: 0000000000000030 R15: 0000000000=
000000
	[39610.974593] rsync           D    0 12853  11202 0x00000000
	[39610.975480] Call Trace:
	[39610.975876]  __schedule+0x3d4/0xb70
	[39610.976457]  schedule+0x3d/0x80
	[39610.977133]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39610.977973]  ? wake_up_var+0x40/0x40
	[39610.978549]  btrfs_setattr+0x316/0x5a0
	[39610.979145]  notify_change+0x2f0/0x450
	[39610.980154]  do_truncate+0x73/0xc0
	[39610.980712]  do_sys_ftruncate+0x12b/0x1c0
	[39610.981348]  __x64_sys_ftruncate+0x1b/0x20
	[39610.982111]  do_syscall_64+0x65/0x1a0
	[39610.982770]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39610.983692] RIP: 0033:0x7ff863906c97
	[39610.984536] Code: Bad RIP value.
	[39610.985132] RSP: 002b:00007ffed3457e28 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39610.986388] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff863=
906c97
	[39610.987823] RDX: 0000000000000000 RSI: 000000000009ba00 RDI: 0000000000=
000003
	[39610.988936] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000b5=
8a5813
	[39610.990107] R10: 000000007951ae56 R11: 0000000000000246 R12: 0000000000=
09ba00
	[39610.991289] R13: 000000000009b760 R14: 00000000000002a0 R15: 0000000000=
000000
	[39610.992603] rsync           D    0 12855   9095 0x00000000
	[39610.993581] Call Trace:
	[39610.993964]  __schedule+0x3d4/0xb70
	[39610.994512]  schedule+0x3d/0x80
	[39610.995002]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39610.995882]  ? wake_up_var+0x40/0x40
	[39610.996538]  btrfs_setattr+0x316/0x5a0
	[39610.997211]  notify_change+0x2f0/0x450
	[39610.997841]  do_truncate+0x73/0xc0
	[39610.998368]  do_sys_ftruncate+0x12b/0x1c0
	[39610.999054]  __x64_sys_ftruncate+0x1b/0x20
	[39610.999787]  do_syscall_64+0x65/0x1a0
	[39611.000438]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39611.001343] RIP: 0033:0x7f93b080fc97
	[39611.001963] Code: Bad RIP value.
	[39611.002523] RSP: 002b:00007fffc289a6f8 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39611.003717] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f93b0=
80fc97
	[39611.004965] RDX: 0000000000000000 RSI: 0000000000006fc8 RDI: 0000000000=
000003
	[39611.006187] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000061=
0c490e
	[39611.007445] R10: 00000000ddc7f267 R11: 0000000000000246 R12: 0000000000=
006fc8
	[39611.008747] R13: 0000000000006d60 R14: 0000000000000268 R15: 0000000000=
000000
	[39611.010056] rsync           D    0 12856   8999 0x00000000
	[39611.011086] Call Trace:
	[39611.011599]  __schedule+0x3d4/0xb70
	[39611.012279]  schedule+0x3d/0x80
	[39611.012806]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39611.013748]  ? wake_up_var+0x40/0x40
	[39611.014410]  btrfs_setattr+0x316/0x5a0
	[39611.015129]  notify_change+0x2f0/0x450
	[39611.015840]  do_truncate+0x73/0xc0
	[39611.016471]  do_sys_ftruncate+0x12b/0x1c0
	[39611.017229]  __x64_sys_ftruncate+0x1b/0x20
	[39611.018002]  do_syscall_64+0x65/0x1a0
	[39611.018692]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39611.019624] RIP: 0033:0x7fb1cd9e1c97
	[39611.020273] Code: Bad RIP value.
	[39611.020900] RSP: 002b:00007ffc6ba2fbc8 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39611.022206] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb1cd=
9e1c97
	[39611.023308] RDX: 0000000000000000 RSI: 00000000000093d8 RDI: 0000000000=
000003
	[39611.024431] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000021=
682eb2
	[39611.025668] R10: 00000000e1f12d36 R11: 0000000000000246 R12: 0000000000=
0093d8
	[39611.027072] R13: 00000000000093a8 R14: 0000000000000030 R15: 0000000000=
000000
	[39611.028390] rsync           D    0 12857  10451 0x00000000
	[39611.029382] Call Trace:
	[39611.029843]  __schedule+0x3d4/0xb70
	[39611.030483]  schedule+0x3d/0x80
	[39611.031074]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39611.032050]  ? wake_up_var+0x40/0x40
	[39611.032722]  btrfs_setattr+0x316/0x5a0
	[39611.033409]  notify_change+0x2f0/0x450
	[39611.034118]  do_truncate+0x73/0xc0
	[39611.034756]  do_sys_ftruncate+0x12b/0x1c0
	[39611.035474]  __x64_sys_ftruncate+0x1b/0x20
	[39611.036161]  do_syscall_64+0x65/0x1a0
	[39611.036877]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39611.037787] RIP: 0033:0x7fab83a26c97
	[39611.039054] Code: Bad RIP value.
	[39611.039776] RSP: 002b:00007ffe7adce218 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39611.040967] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fab83=
a26c97
	[39611.042422] RDX: 0000000000000000 RSI: 00000000015983b4 RDI: 0000000000=
000003
	[39611.043747] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000004=
809bce
	[39611.044974] R10: 000000007f4aa483 R11: 0000000000000246 R12: 0000000001=
5983b4
	[39611.047307] R13: 0000000001598250 R14: 0000000000000164 R15: 0000000000=
000000
	[39611.048509] rsync           D    0 12858  10345 0x00000000
	[39611.049365] Call Trace:
	[39611.050235]  __schedule+0x3d4/0xb70
	[39611.050798]  schedule+0x3d/0x80
	[39611.051289]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39611.052121]  ? wake_up_var+0x40/0x40
	[39611.053007]  btrfs_setattr+0x316/0x5a0
	[39611.053599]  notify_change+0x2f0/0x450
	[39611.054182]  do_truncate+0x73/0xc0
	[39611.054711]  do_sys_ftruncate+0x12b/0x1c0
	[39611.055338]  __x64_sys_ftruncate+0x1b/0x20
	[39611.056072]  do_syscall_64+0x65/0x1a0
	[39611.057115]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39611.058458] RIP: 0033:0x7f5fdff91c97
	[39611.059133] Code: Bad RIP value.
	[39611.059660] RSP: 002b:00007ffc67d00a58 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39611.060833] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5fdf=
f91c97
	[39611.062271] RDX: 0000000000000000 RSI: 0000000000006fc8 RDI: 0000000000=
000003
	[39611.063389] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000061=
0c490e
	[39611.064526] R10: 00000000ddc7f267 R11: 0000000000000246 R12: 0000000000=
006fc8
	[39611.065649] R13: 0000000000006d60 R14: 0000000000000268 R15: 0000000000=
000000
	[39611.066902] rsync           D    0 12861  10901 0x00000000
	[39611.067957] Call Trace:
	[39611.068355]  __schedule+0x3d4/0xb70
	[39611.068912]  schedule+0x3d/0x80
	[39611.069413]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39611.070605]  ? wake_up_var+0x40/0x40
	[39611.071174]  btrfs_setattr+0x316/0x5a0
	[39611.071789]  notify_change+0x2f0/0x450
	[39611.072383]  do_truncate+0x73/0xc0
	[39611.073001]  do_sys_ftruncate+0x12b/0x1c0
	[39611.073644]  __x64_sys_ftruncate+0x1b/0x20
	[39611.074299]  do_syscall_64+0x65/0x1a0
	[39611.074883]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39611.075681] RIP: 0033:0x7f3de4043c97
	[39611.076251] Code: Bad RIP value.
	[39611.076772] RSP: 002b:00007ffe58c8fac8 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39611.077957] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3de4=
043c97
	[39611.079073] RDX: 0000000000000000 RSI: 0000000000003138 RDI: 0000000000=
000003
	[39611.080188] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000a8=
1c530d
	[39611.081339] R10: 00000000f7dbc024 R11: 0000000000000246 R12: 0000000000=
003138
	[39611.082533] R13: 0000000000002e7c R14: 00000000000002bc R15: 0000000000=
000000
	[39611.083724] rsync           D    0 12863   7311 0x00000000
	[39611.084641] Call Trace:
	[39611.085060]  __schedule+0x3d4/0xb70
	[39611.085653]  schedule+0x3d/0x80
	[39611.086183]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39611.087052]  ? wake_up_var+0x40/0x40
	[39611.087660]  btrfs_setattr+0x316/0x5a0
	[39611.088286]  notify_change+0x2f0/0x450
	[39611.088923]  do_truncate+0x73/0xc0
	[39611.089506]  do_sys_ftruncate+0x12b/0x1c0
	[39611.090176]  __x64_sys_ftruncate+0x1b/0x20
	[39611.090870]  do_syscall_64+0x65/0x1a0
	[39611.091492]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39611.092333] RIP: 0033:0x7fdf2e203c97
	[39611.092938] Code: Bad RIP value.
	[39611.093491] RSP: 002b:00007ffda441e7e8 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39611.094737] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdf2e=
203c97
	[39611.095916] RDX: 0000000000000000 RSI: 000000000000001d RDI: 0000000000=
000003
	[39611.097097] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000=
00001d
	[39611.098277] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000=
00001d
	[39611.099439] R13: 0000000000000000 R14: 000000000000001d R15: 0000000000=
000000
	[39611.100839] rsync           D    0 12864   7029 0x00000000
	[39611.101792] Call Trace:
	[39611.102223]  __schedule+0x3d4/0xb70
	[39611.102939]  schedule+0x3d/0x80
	[39611.103548]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39611.104391]  ? wake_up_var+0x40/0x40
	[39611.104979]  btrfs_setattr+0x316/0x5a0
	[39611.105598]  notify_change+0x2f0/0x450
	[39611.106211]  do_truncate+0x73/0xc0
	[39611.106775]  do_sys_ftruncate+0x12b/0x1c0
	[39611.107413]  __x64_sys_ftruncate+0x1b/0x20
	[39611.108061]  do_syscall_64+0x65/0x1a0
	[39611.108651]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39611.109450] RIP: 0033:0x7fbd0ecc1c97
	[39611.110016] Code: Bad RIP value.
	[39611.110535] RSP: 002b:00007ffe7ccb9f98 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39611.111718] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbd0e=
cc1c97
	[39611.112835] RDX: 0000000000000000 RSI: 0000000000004f10 RDI: 0000000000=
000003
	[39611.114054] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000a7=
2ac329
	[39611.115210] R10: 000000006c1ecb5e R11: 0000000000000246 R12: 0000000000=
004f10
	[39611.116358] R13: 0000000000004c90 R14: 0000000000000280 R15: 0000000000=
000000
	[39611.117842] rsync           D    0 12868   8122 0x00000000
	[39611.118737] Call Trace:
	[39611.119144]  __schedule+0x3d4/0xb70
	[39611.119723]  schedule+0x3d/0x80
	[39611.120238]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39611.121183]  ? wake_up_var+0x40/0x40
	[39611.121778]  btrfs_setattr+0x316/0x5a0
	[39611.122374]  notify_change+0x2f0/0x450
	[39611.122978]  do_truncate+0x73/0xc0
	[39611.123528]  do_sys_ftruncate+0x12b/0x1c0
	[39611.124162]  __x64_sys_ftruncate+0x1b/0x20
	[39611.124931]  do_syscall_64+0x65/0x1a0
	[39611.125528]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39611.126316] RIP: 0033:0x7f57cb45cc97
	[39611.126896] Code: Bad RIP value.
	[39611.127702] RSP: 002b:00007ffe555eee38 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39611.128893] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f57cb=
45cc97
	[39611.130050] RDX: 0000000000000000 RSI: 000000000000007e RDI: 0000000000=
000003
	[39611.131206] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000a6=
4251e9
	[39611.132309] R10: 00000000b69a9260 R11: 0000000000000246 R12: 0000000000=
00007e
	[39611.133449] R13: 0000000000000000 R14: 000000000000007e R15: 0000000000=
000000
	[39611.134660] rsync           D    0 12869   7189 0x00000000
	[39611.135511] Call Trace:
	[39611.135895]  __schedule+0x3d4/0xb70
	[39611.136441]  schedule+0x3d/0x80
	[39611.136949]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39611.138069]  ? wake_up_var+0x40/0x40
	[39611.138663]  btrfs_setattr+0x316/0x5a0
	[39611.139257]  notify_change+0x2f0/0x450
	[39611.140031]  do_truncate+0x73/0xc0
	[39611.140798]  do_sys_ftruncate+0x12b/0x1c0
	[39611.141726]  __x64_sys_ftruncate+0x1b/0x20
	[39611.142449]  do_syscall_64+0x65/0x1a0
	[39611.143013]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39611.143792] RIP: 0033:0x7f2d34f4cc97
	[39611.144344] Code: Bad RIP value.
	[39611.144929] RSP: 002b:00007ffdb5c693d8 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39611.146088] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2d34=
f4cc97
	[39611.147180] RDX: 0000000000000000 RSI: 000000000063c214 RDI: 0000000000=
000003
	[39611.148819] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000001=
a4a74f
	[39611.149950] R10: 00000000763c97e2 R11: 0000000000000246 R12: 0000000000=
63c214
	[39611.151040] R13: 000000000063b9f8 R14: 000000000000081c R15: 0000000000=
000000
	[39611.152445] rsync           D    0 29478  29477 0x00000000
	[39611.153311] Call Trace:
	[39611.153735]  __schedule+0x3d4/0xb70
	[39611.154292]  schedule+0x3d/0x80
	[39611.154981]  btrfs_wait_for_snapshot_creation+0xb2/0xe0
	[39611.155912]  ? wake_up_var+0x40/0x40
	[39611.156481]  btrfs_setattr+0x316/0x5a0
	[39611.157169]  notify_change+0x2f0/0x450
	[39611.157766]  do_truncate+0x73/0xc0
	[39611.158309]  do_sys_ftruncate+0x12b/0x1c0
	[39611.158950]  __x64_sys_ftruncate+0x1b/0x20
	[39611.159626]  do_syscall_64+0x65/0x1a0
	[39611.160191]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[39611.160991] RIP: 0033:0x7f256a298c97
	[39611.161564] Code: Bad RIP value.
	[39611.162077] RSP: 002b:00007ffeadbc85c8 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004d
	[39611.163255] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f256a=
298c97
	[39611.164355] RDX: 0000000000000000 RSI: 0000000000008d10 RDI: 0000000000=
000003
	[39611.165474] RBP: 0000000000000003 R08: 0000000000000000 R09: 000000008c=
0d9c29
	[39611.166588] R10: 000000003afa98d7 R11: 0000000000000246 R12: 0000000000=
008d10
	[39611.167700] R13: 0000000000008b74 R14: 000000000000019c R15: 0000000000=
000000

All the blocked threads are waiting for a snapshot, which is here:

	[42829.412010] btrfs           R  running task        0 11306   6447 0x000=
00000
	[42829.413392] Call Trace:
	[42829.413895]  __schedule+0x3d4/0xb70
	[42829.414598]  preempt_schedule_common+0x1f/0x30
	[42829.415480]  _cond_resched+0x22/0x30
	[42829.416198]  wait_for_common_io.constprop.2+0x47/0x1b0
	[42829.417212]  ? submit_bio+0x73/0x140
	[42829.417932]  wait_for_completion_io+0x18/0x20
	[42829.418791]  submit_bio_wait+0x68/0x90
	[42829.419546]  blkdev_issue_discard+0x80/0xd0
	[42829.420381]  btrfs_issue_discard+0xc7/0x160
	[42829.421215]  ? btrfs_issue_discard+0xc7/0x160
	[42829.422088]  btrfs_discard_extent+0xcc/0x160
	[42829.423191]  btrfs_finish_extent_commit+0x118/0x280
	[42829.424310]  btrfs_commit_transaction+0x7f9/0xab0
	[42829.425231]  ? wait_woken+0xa0/0xa0
	[42829.425907]  btrfs_mksubvol+0x5b4/0x630
	[42829.426766]  ? mnt_want_write_file+0x28/0x60
	[42829.427597]  btrfs_ioctl_snap_create_transid+0x16b/0x1a0
	[42829.428614]  btrfs_ioctl_snap_create_v2+0x125/0x180
	[42829.429548]  btrfs_ioctl+0x1351/0x2cb0
	[42829.430272]  ? __handle_mm_fault+0x110c/0x1950
	[42829.431124]  ? do_raw_spin_unlock+0x4d/0xc0
	[42829.431934]  ? _raw_spin_unlock+0x27/0x40
	[42829.432704]  ? __handle_mm_fault+0x110c/0x1950
	[42829.433556]  ? kvm_sched_clock_read+0x18/0x30
	[42829.434437]  do_vfs_ioctl+0xa6/0x6e0
	[42829.435345]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[42829.436803]  ? do_vfs_ioctl+0xa6/0x6e0
	[42829.437528]  ? up_read+0x1f/0xa0
	[42829.438159]  ksys_ioctl+0x75/0x80
	[42829.438798]  __x64_sys_ioctl+0x1a/0x20
	[42829.439565]  do_syscall_64+0x65/0x1a0
	[42829.440510]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[42829.441463] RIP: 0033:0x7f1faa8f5777
	[42829.442133] Code: Bad RIP value.
	[42829.442736] RSP: 002b:00007ffec1520458 EFLAGS: 00000202 ORIG_RAX: 00000=
00000000010
	[42829.444352] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1faa=
8f5777
	[42829.445710] RDX: 00007ffec1520498 RSI: 0000000050009417 RDI: 0000000000=
000003
	[42829.447030] RBP: 00005621c22ef260 R08: 0000000000000008 R09: 00007f1faa=
97fe80
	[42829.448372] R10: fffffffffffffa4a R11: 0000000000000202 R12: 00005621c2=
2ef290
	[42829.449723] R13: 00005621c22ef290 R14: 0000000000000003 R15: 0000000000=
000004

Also I just noticed there's sometimes (but not always!) a BUG in
fs/btrfs/ctree.c just before all the soft lockups start:

	[26101.008546] ------------[ cut here ]------------
	[26101.016090] kernel BUG at fs/btrfs/ctree.c:1227!
	[26101.018285] irq event stamp: 36913
	[26101.018287] invalid opcode: 0000 [#1] SMP PTI
	[26101.018293] CPU: 1 PID: 4823 Comm: crawl_5268 Not tainted 5.0.16-zb64-9=
b948ea3083a+ #1
	[26101.019115] hardirqs last  enabled at (36913): [<ffffffffbb25b02c>] get=
_page_from_freelist+0x40c/0x19e0
	[26101.019118] hardirqs last disabled at (36912): [<ffffffffbb25af70>] get=
_page_from_freelist+0x350/0x19e0
	[26101.020820] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=
 1.10.2-1 04/01/2014
	[26101.022456] softirqs last  enabled at (36478): [<ffffffffbc0003a0>] __d=
o_softirq+0x3a0/0x45a
	[26101.022461] softirqs last disabled at (36459): [<ffffffffbb0a9949>] irq=
_exit+0xe9/0xf0
	[26101.024212] RIP: 0010:__tree_mod_log_rewind+0x239/0x240
	[26101.039031] Code: c0 48 89 df 48 89 d6 48 c1 e6 05 48 8d 74 32 65 ba 19=
 00 00 00 e8 87 02 05 00 e9 88 fe ff ff 49 63 57 2c e9 16 ff ff ff 0f 0b <0=
f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 55 83 c2 01 48 63 d2 48 89 e5
	[26101.042382] RSP: 0018:ffffb3f401613820 EFLAGS: 00010206
	[26101.043512] RAX: ffff9f8068690180 RBX: ffff9f7ebf2ba660 RCX: ffff9f8003=
b1eb80
	[26101.044719] RDX: 000000000000015d RSI: 000000000000007e RDI: 0000018aff=
0a8000
	[26101.046157] RBP: ffffb3f401613850 R08: ffffb3f4016137c8 R09: ffffb3f401=
6137d0
	[26101.047474] R10: 0000000000007af3 R11: 000000000000007e R12: 0000000000=
000008
	[26101.048779] R13: ffff9f7ea7d77d00 R14: 0000000000000a49 R15: ffff9f8068=
690180
	[26101.049939] FS:  00007f9064d7a700(0000) GS:ffff9f80b6000000(0000) knlGS=
:0000000000000000
	[26101.051415] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[26101.052330] CR2: 00007fcc462fd8a0 CR3: 000000020e002006 CR4: 0000000000=
1606e0
	[26101.053615] Call Trace:
	[26101.054103]  btrfs_search_old_slot+0xfe/0x800
	[26101.054900]  resolve_indirect_refs+0x1c5/0x910
	[26101.055734]  ? prelim_ref_insert+0x10a/0x320
	[26101.056474]  find_parent_nodes+0x443/0x1340
	[26101.057153]  btrfs_find_all_roots_safe+0xc5/0x140
	[26101.057890]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[26101.058813]  iterate_extent_inodes+0x198/0x3e0
	[26101.059608]  iterate_inodes_from_logical+0xa1/0xd0
	[26101.060377]  ? iterate_inodes_from_logical+0xa1/0xd0
	[26101.061142]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[26101.061975]  btrfs_ioctl_logical_to_ino+0xf3/0x1a0
	[26101.062710]  btrfs_ioctl+0xcf7/0x2cb0
	[26101.063318]  ? __lock_acquire+0x477/0x1b50
	[26101.063988]  ? kvm_sched_clock_read+0x18/0x30
	[26101.065010]  ? kvm_sched_clock_read+0x18/0x30
	[26101.065781]  ? sched_clock+0x9/0x10
	[26101.066402]  do_vfs_ioctl+0xa6/0x6e0
	[26101.067072]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[26101.068102]  ? do_vfs_ioctl+0xa6/0x6e0
	[26101.068765]  ? __fget+0x119/0x200
	[26101.069381]  ksys_ioctl+0x75/0x80
	[26101.069937]  __x64_sys_ioctl+0x1a/0x20
	[26101.070627]  do_syscall_64+0x65/0x1a0
	[26101.071299]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[26101.072125] RIP: 0033:0x7f9067675777
	[26101.072732] Code: 00 00 90 48 8b 05 19 a7 0c 00 64 c7 00 26 00 00 00 48=
 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <4=
8> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 a6 0c 00 f7 d8 64 89 01 48
	[26101.075884] RSP: 002b:00007f9064d77458 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010
	[26101.077193] RAX: ffffffffffffffda RBX: 00007f9064d77780 RCX: 00007f9067=
675777
	[26101.078362] RDX: 00007f9064d77788 RSI: 00000000c038943b RDI: 0000000000=
000004
	[26101.079543] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007f9064=
d77960
	[26101.080837] R10: 0000565444959c40 R11: 0000000000000246 R12: 0000000000=
000004
	[26101.082724] R13: 00007f9064d77788 R14: 00007f9064d77668 R15: 00007f9064=
d77890
	[26101.084083] Modules linked in: mq_deadline bfq dm_cache_smq dm_cache dm=
_persistent_data snd_pcm crct10dif_pclmul crc32_pclmul dm_bio_prison crc32c=
_intel ghash_clmulni_intel dm_bufio sr_mod snd_timer cdrom snd sg aesni_int=
el ppdev joydev aes_x86_64 dm_mod soundcore crypto_simd ide_pci_generic cry=
ptd piix glue_helper psmouse input_leds parport_pc ide_core rtc_cmos pcspkr=
 serio_raw bochs_drm evbug parport evdev floppy i2c_piix4 qemu_fw_cfg ip_ta=
bles x_tables ipv6 crc_ccitt autofs4
	[26101.091346] ---[ end trace d327561dc44a663d ]---
	[26101.092065] RIP: 0010:__tree_mod_log_rewind+0x239/0x240
	[26101.092893] Code: c0 48 89 df 48 89 d6 48 c1 e6 05 48 8d 74 32 65 ba 19=
 00 00 00 e8 87 02 05 00 e9 88 fe ff ff 49 63 57 2c e9 16 ff ff ff 0f 0b <0=
f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 55 83 c2 01 48 63 d2 48 89 e5
	[26101.095707] RSP: 0018:ffffb3f401613820 EFLAGS: 00010206
	[26101.096505] RAX: ffff9f8068690180 RBX: ffff9f7ebf2ba660 RCX: ffff9f8003=
b1eb80
	[26101.097595] RDX: 000000000000015d RSI: 000000000000007e RDI: 0000018aff=
0a8000
	[26101.098678] RBP: ffffb3f401613850 R08: ffffb3f4016137c8 R09: ffffb3f401=
6137d0
	[26101.099771] R10: 0000000000007af3 R11: 000000000000007e R12: 0000000000=
000008
	[26101.100994] R13: ffff9f7ea7d77d00 R14: 0000000000000a49 R15: ffff9f8068=
690180
	[26101.102230] FS:  00007f9064d7a700(0000) GS:ffff9f80b6000000(0000) knlGS=
:0000000000000000
	[26101.103649] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[26101.104627] CR2: 00007fcc462fd8a0 CR3: 000000020e002006 CR4: 0000000000=
1606e0
	[26101.105812] BUG: sleeping function called from invalid context at ./inc=
lude/linux/percpu-rwsem.h:34
	[26101.107351] in_atomic(): 1, irqs_disabled(): 0, pid: 4823, name: crawl_=
5268
	[26101.108628] INFO: lockdep is turned off.
	[26101.109362] CPU: 1 PID: 4823 Comm: crawl_5268 Tainted: G      D        =
   5.0.16-zb64-9b948ea3083a+ #1
	[26101.110931] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=
 1.10.2-1 04/01/2014
	[26101.112303] Call Trace:
	[26101.112757]  dump_stack+0x86/0xc5
	[26101.113387]  ___might_sleep+0x217/0x240
	[26101.114077]  __might_sleep+0x4a/0x80
	[26101.114730]  exit_signals+0x33/0x250
	[26101.115508]  do_exit+0xb9/0xd70
	[26101.116095]  rewind_stack_do_exit+0x17/0x20
	[26101.116858] RIP: 0033:0x7f9067675777
	[26101.117497] Code: 00 00 90 48 8b 05 19 a7 0c 00 64 c7 00 26 00 00 00 48=
 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <4=
8> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 a6 0c 00 f7 d8 64 89 01 48
	[26101.120764] RSP: 002b:00007f9064d77458 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010
	[26101.122031] RAX: ffffffffffffffda RBX: 00007f9064d77780 RCX: 00007f9067=
675777
	[26101.123266] RDX: 00007f9064d77788 RSI: 00000000c038943b RDI: 0000000000=
000004
	[26101.124474] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007f9064=
d77960
	[26101.125746] R10: 0000565444959c40 R11: 0000000000000246 R12: 0000000000=
000004
	[26101.126982] R13: 00007f9064d77788 R14: 00007f9064d77668 R15: 00007f9064=
d77890
	[26101.128246] note: crawl_5268[4823] exited with preempt_count 2
	[26128.042702] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [crawl_52=
68:4821]
	[26128.048713] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [crawl_52=
68:4820]
	[26128.051844] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [crawl_52=
68:4822]
	[26128.055703] watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [btrfs-ba=
lance:4691]
	[...etc...]

The stack traces for the 4 running threads are:

	[42826.377803] crawl_5268      R  running task        0  4821   4806 0x800=
00008
	[42826.379193] Call Trace:
	[42826.379683]  <IRQ>
	[42826.380076]  sched_show_task+0x198/0x260
	[42826.380760]  show_state_filter+0xa0/0x1a0
	[42826.381438]  sysrq_handle_showstate+0x10/0x20
	[42826.382251]  __handle_sysrq+0x139/0x210
	[42826.382911]  handle_sysrq+0x26/0x30
	[42826.383507]  serial8250_handle_irq.part.16+0xbc/0x100
	[42826.384476]  serial8250_default_handle_irq+0x53/0x60
	[42826.385369]  serial8250_interrupt+0x68/0x100
	[42826.386102]  __handle_irq_event_percpu+0x4e/0x2b0
	[42826.386890]  handle_irq_event_percpu+0x32/0x80
	[42826.387627]  handle_irq_event+0x39/0x60
	[42826.388274]  handle_edge_irq+0xef/0x1c0
	[42826.388921]  handle_irq+0x75/0x120
	[42826.389475]  do_IRQ+0x64/0x130
	[42826.390007]  common_interrupt+0xf/0xf
	[42826.390617]  </IRQ>
	[42826.390984] RIP: 0010:native_safe_halt+0x12/0x20
	[42826.391750] Code: f0 80 48 02 20 48 8b 00 a8 08 0f 84 7b ff ff ff eb bd=
 90 90 90 90 90 90 55 48 89 e5 e9 07 00 00 00 0f 00 2d b2 ec 43 00 fb f4 <5=
d> c3 66 90 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 e9 07 00 00
	[42826.395273] RSP: 0018:ffffb3f401603750 EFLAGS: 00000246 ORIG_RAX: fffff=
fffffffffd6
	[42826.396849] RAX: 0000000000000000 RBX: ffff9f80a36716a4 RCX: 0000000000=
000008
	[42826.398308] RDX: ffff9f80ab13c000 RSI: ffffffffbb119a73 RDI: ffffffffbb=
07a326
	[42826.399766] RBP: ffffb3f401603750 R08: 0000000000000000 R09: 0000000000=
00005c
	[42826.401269] R10: ffffb3f401603790 R11: ffff9f80a36716b8 R12: 0000000000=
000246
	[42826.402715] R13: 0000000000000003 R14: 0000000000000100 R15: 0000000000=
000000
	[42826.403891]  ? __pv_queued_spin_lock_slowpath+0x273/0x2b0
	[42826.404798]  ? kvm_wait+0x86/0x90
	[42826.405346]  kvm_wait+0x8b/0x90
	[42826.405998]  __pv_queued_spin_lock_slowpath+0x273/0x2b0
	[42826.407075]  queued_read_lock_slowpath+0x75/0x80
	[42826.408088]  do_raw_read_lock+0x4b/0x50
	[42826.408717]  _raw_read_lock+0x58/0x70
	[42826.409319]  __tree_mod_log_search+0x2d/0xb0
	[42826.410019]  btrfs_search_old_slot+0x312/0x800
	[42826.410738]  ? __tree_mod_log_search+0x73/0xb0
	[42826.411466]  resolve_indirect_refs+0x1c5/0x910
	[42826.412192]  ? prelim_ref_insert+0x10a/0x320
	[42826.412890]  find_parent_nodes+0x443/0x1340
	[42826.413597]  btrfs_find_all_roots_safe+0xc5/0x140
	[42826.414591]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[42826.415573]  iterate_extent_inodes+0x198/0x3e0
	[42826.416530]  iterate_inodes_from_logical+0xa1/0xd0
	[42826.417568]  ? iterate_inodes_from_logical+0xa1/0xd0
	[42826.418511]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[42826.419334]  btrfs_ioctl_logical_to_ino+0xf3/0x1a0
	[42826.420390]  btrfs_ioctl+0xcf7/0x2cb0
	[42826.421300]  ? __lock_acquire+0x477/0x1b50
	[42826.422246]  ? kvm_sched_clock_read+0x18/0x30
	[42826.422960]  ? kvm_sched_clock_read+0x18/0x30
	[42826.423731]  ? sched_clock+0x9/0x10
	[42826.424317]  do_vfs_ioctl+0xa6/0x6e0
	[42826.425014]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[42826.426162]  ? do_vfs_ioctl+0xa6/0x6e0
	[42826.426813]  ? __fget+0x119/0x200
	[42826.427370]  ksys_ioctl+0x75/0x80
	[42826.427926]  __x64_sys_ioctl+0x1a/0x20
	[42826.428609]  do_syscall_64+0x65/0x1a0
	[42826.429444]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[42826.430473] RIP: 0033:0x7f9067675777
	[42826.431201] Code: 00 00 90 48 8b 05 19 a7 0c 00 64 c7 00 26 00 00 00 48=
 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <4=
8> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 a6 0c 00 f7 d8 64 89 01 48
	[42826.434629] RSP: 002b:00007f9065d79458 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010
	[42826.435975] RAX: ffffffffffffffda RBX: 00007f9065d79780 RCX: 00007f9067=
675777
	[42826.437165] RDX: 00007f9065d79788 RSI: 00000000c038943b RDI: 0000000000=
000004
	[42826.438305] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007f9065=
d79960
	[42826.439540] R10: 0000565444959c40 R11: 0000000000000246 R12: 0000000000=
000004
	[42826.440947] R13: 00007f9065d79788 R14: 00007f9065d79668 R15: 00007f9065=
d79890

	[42826.343964] crawl_5268      R  running task        0  4820   4806 0x800=
00008
	[42826.345377] Call Trace:
	[42826.345865]  __schedule+0x3dc/0xb70
	[42826.346500]  schedule+0x3d/0x80
	[42826.347055]  ? wait_on_page_bit+0x193/0x270
	[42826.347965]  ? retint_kernel+0x10/0x10
	[42826.348861]  ? trace_hardirqs_on_thunk+0x1a/0x1c
	[42826.349961]  ? retint_kernel+0x10/0x10
	[42826.350727]  ? trace_hardirqs_on_thunk+0x1a/0x1c
	[42826.351648]  ? trace_hardirqs_on_caller+0x4a/0x100
	[42826.352683]  ? trace_hardirqs_on_thunk+0x1a/0x1c
	[42826.353593]  ? retint_kernel+0x10/0x10
	[42826.354322]  ? kvm_wait+0x86/0x90
	[42826.354922]  ? __pv_queued_spin_lock_slowpath+0x1ed/0x2b0
	[42826.355802]  ? trace_hardirqs_on+0x4c/0x100
	[42826.356489]  ? kvm_wait+0x8b/0x90
	[42826.357215]  ? __pv_queued_spin_lock_slowpath+0x1ed/0x2b0
	[42826.358172]  ? queued_write_lock_slowpath+0x80/0x90
	[42826.359170]  ? do_raw_write_lock+0xae/0xb0
	[42826.359845]  ? _raw_write_lock+0x55/0x70
	[42826.360490]  ? btrfs_get_tree_mod_seq+0x32/0xc0
	[42826.361513]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[42826.362373]  ? iterate_extent_inodes+0x357/0x3e0
	[42826.363149]  ? release_extent_buffer+0xaa/0xe0
	[42826.364283]  ? _raw_spin_unlock+0x27/0x40
	[42826.365094]  ? iterate_inodes_from_logical+0xa1/0xd0
	[42826.366083]  ? iterate_inodes_from_logical+0xa1/0xd0
	[42826.367077]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[42826.368108]  ? btrfs_ioctl_logical_to_ino+0xf3/0x1a0
	[42826.369098]  ? btrfs_ioctl+0xcf7/0x2cb0
	[42826.369769]  ? lock_acquire+0xbd/0x1c0
	[42826.370430]  ? lock_acquire+0xbd/0x1c0
	[42826.371226]  ? do_vfs_ioctl+0xa6/0x6e0
	[42826.371884]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[42826.372899]  ? do_vfs_ioctl+0xa6/0x6e0
	[42826.373653]  ? __fget+0x119/0x200
	[42826.374490]  ? ksys_ioctl+0x75/0x80
	[42826.375323]  ? __x64_sys_ioctl+0x1a/0x20
	[42826.376203]  ? do_syscall_64+0x65/0x1a0
	[42826.376896]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe

	[42826.442068] crawl_5268      R  running task        0  4822   4806 0x800=
00008
	[42826.443327] Call Trace:
	[42826.443765]  __schedule+0x3dc/0xb70
	[42826.444410]  schedule+0x3d/0x80
	[42826.445077]  ? wait_on_page_bit+0x193/0x270
	[42826.445949]  ? retint_kernel+0x10/0x10
	[42826.446568]  ? trace_hardirqs_on_thunk+0x1a/0x1c
	[42826.447332]  ? trace_hardirqs_on_caller+0x4a/0x100
	[42826.448104]  ? trace_hardirqs_on_thunk+0x1a/0x1c
	[42826.448845]  ? retint_kernel+0x10/0x10
	[42826.449452]  ? kvm_wait+0x86/0x90
	[42826.450000]  ? __pv_queued_spin_lock_slowpath+0x1ed/0x2b0
	[42826.450870]  ? kvm_wait+0x86/0x90
	[42826.451422]  ? trace_hardirqs_on+0x4c/0x100
	[42826.452394]  ? kvm_wait+0x8b/0x90
	[42826.453108]  ? __pv_queued_spin_lock_slowpath+0x1ed/0x2b0
	[42826.454029]  ? queued_write_lock_slowpath+0x80/0x90
	[42826.455032]  ? do_raw_write_lock+0xae/0xb0
	[42826.455721]  ? _raw_write_lock+0x55/0x70
	[42826.456384]  ? btrfs_get_tree_mod_seq+0x32/0xc0
	[42826.457362]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[42826.458465]  ? iterate_extent_inodes+0x357/0x3e0
	[42826.459275]  ? release_extent_buffer+0xaa/0xe0
	[42826.460200]  ? _raw_spin_unlock+0x27/0x40
	[42826.461139]  ? iterate_inodes_from_logical+0xa1/0xd0
	[42826.462004]  ? iterate_inodes_from_logical+0xa1/0xd0
	[42826.463032]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[42826.463906]  ? btrfs_ioctl_logical_to_ino+0xf3/0x1a0
	[42826.464752]  ? btrfs_ioctl+0xcf7/0x2cb0
	[42826.466053]  ? lock_acquire+0xbd/0x1c0
	[42826.466921]  ? lock_acquire+0xbd/0x1c0
	[42826.467765]  ? do_vfs_ioctl+0xa6/0x6e0
	[42826.468482]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[42826.469726]  ? do_vfs_ioctl+0xa6/0x6e0
	[42826.470366]  ? __fget+0x119/0x200
	[42826.470950]  ? ksys_ioctl+0x75/0x80
	[42826.471558]  ? __x64_sys_ioctl+0x1a/0x20
	[42826.472367]  ? do_syscall_64+0x65/0x1a0
	[42826.473038]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe

	[42826.119748] btrfs-balance   R  running task        0  4691      2 0x800=
00008
	[42826.121155] Call Trace:
	[42826.121620]  tree_mod_log_insert_root.isra.2+0x117/0x350
	[42826.122670]  ? queued_write_lock_slowpath+0x50/0x90
	[42826.123496]  ? do_raw_write_lock+0xae/0xb0
	[42826.124167]  ? _raw_write_lock+0x55/0x70
	[42826.124804]  ? tree_mod_log_insert_root.isra.2+0x117/0x350
	[42826.125691]  ? __btrfs_cow_block+0x41e/0x570
	[42826.126390]  ? btrfs_cow_block+0xf8/0x230
	[42826.127051]  ? replace_path.isra.18+0x403/0x770
	[42826.127785]  ? merge_reloc_root+0x2ab/0x5a0
	[42826.128469]  ? btrfs_get_fs_root.part.12+0xc0/0x160
	[42826.129262]  ? merge_reloc_roots+0xe0/0x270
	[42826.129948]  ? relocate_block_group+0x184/0x600
	[42826.130681]  ? btrfs_relocate_block_group+0x15a/0x270
	[42826.131499]  ? btrfs_relocate_chunk+0x50/0x100
	[42826.132222]  ? btrfs_balance+0xa72/0x1330
	[42826.132878]  ? balance_kthread+0x25/0x50
	[42826.133520]  ? balance_kthread+0x3b/0x50
	[42826.134166]  ? kthread+0x113/0x150
	[42826.134720]  ? btrfs_balance+0x1330/0x1330
	[42826.135389]  ? kthread_park+0x90/0x90
	[42826.135993]  ? ret_from_fork+0x3a/0x50

This doesn't quite match the traces I previously posted.  Maybe the
storm-of-soft-lockups is a symptom of multiple bugs (at least one which
happens after a bug in ctree.c and one that happens at other times)?
I'll run this a few more times and see if different cases come up.

The one thing that is common to all the storm-of-soft-lockups I've seen
so far is the involvement of multiple crawl_* threads, and those spend
~60% of their time running logical_to_ino.

> Also do you have this patch on the affected machine:
>=20
> 38e3eebff643 ("btrfs: honor path->skip_locking in backref code") can you
> try and test with it applied ?
>=20
>=20
> <SNIP>

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXN+NlwAKCRCB+YsaVrMb
nONzAKC9TY0QcswHMOoF94GjL3MYnUp8WwCfT5ixuUGzSaWrRo3zrfnEuX8y+jk=
=H/6p
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
