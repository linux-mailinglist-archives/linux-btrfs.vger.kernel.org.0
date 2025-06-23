Return-Path: <linux-btrfs+bounces-14875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA3DAE4B21
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 18:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1281897F8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7447D23C51F;
	Mon, 23 Jun 2025 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EymQJAPa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46EB188735
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696246; cv=none; b=ryYBxOgUVk9OA4VMs3yvN3AG5ag4/20MRMWVwVhR7+qPnegDLEPRN3ooWU/9+PsVPUyHd2guAJY4Tez+ufu5QzfNQOFwKBnSrmmARVx+4thUS6OOFNP939YSPSkw9ivAl9pYtvFEdya4L3cy0QIXYQ1WlSkJoSUR+CJCe8om4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696246; c=relaxed/simple;
	bh=jEtBRa+8NKVWJTFFE2Zu5dC4lLrADeWUgZzmquMO5RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cp92oJtDDEQAy3zEtvknNWrWFycpCqqEdhp/5TxkoxKqIJkvbyreuZj5+JDt2VfGMqoNZIPJ1cUIT9FammIlwsU+e14JpskzlTLF3C2eyZa/ABsBYuIcItLgQ1DDZntpzJOvl6U+9WSWV7YeWVrxqzMHiBAWoiWWFK7RIKFj6Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EymQJAPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4361CC4CEEA
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750696246;
	bh=jEtBRa+8NKVWJTFFE2Zu5dC4lLrADeWUgZzmquMO5RY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EymQJAPaC4veSAKDn62jQ3aolR8k3E69Rf7lnDgu7IrcqhL7GfcEnbyfiDJDaXFPp
	 HJDy9op0FGwdjq+aHDfZuGwi59+Mi281i/L1v3x9L77QzqNrWoSkwEaSmerutdZxFK
	 Qp4UFn8bja1U3u+kasAQz85x7h2hbbx1koLdn5VrFi2rmrJaTVwxZm0CAo5yglv41R
	 v21leCMiGlnnQLVm7iWF2GvIBRwSMN50ENtPskGLZIqcRK3tPLC+/0etfddc525YeM
	 hyNTfEZctFwNgKxbymAEBB6rqdJx1d38KQywuGFkbjFtXWYRDs4nD8X1VEeW6OvehW
	 uw+wW9r9Xc92Q==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso95337066b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 09:30:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YwKzXeDUPyA/ZDGgnPW/IkaG5Dj6xGrenmCYBcRYT7omPEpq1ct
	K5W+XJEsAp7B3TaSk9L0C7SduktclZnz8/beFUtTnuJ2vhtemsJoOn60sgCb7mFj56IoJmF9oco
	4ICQdx5/6vL9Rp7bjW+4ZNVsapNfnzNc=
X-Google-Smtp-Source: AGHT+IHL/3E/Rpx7A48oO7wobGcknDcR9YKe4v6gfoU8O3aQB1eC0OPZza20FFN3YGP7+rEOXfr7Qm/SSZoQbzAFZlY=
X-Received: by 2002:a17:906:730c:b0:acb:37ae:619c with SMTP id
 a640c23a62f3a-ae0a73c3ea4mr19290866b.15.1750696244785; Mon, 23 Jun 2025
 09:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMthOuMkG7apm2thceT4rAkdJ-Y7aBBZSxF4Ct219aE6qiaGFw@mail.gmail.com>
 <CAMthOuNtOBVa41+MXEYXwqfEJgUsDjKnzPGnmRmbARNKcKPhbQ@mail.gmail.com>
 <CAMthOuPPGDu7Ojzf2okGA+5dd2-wQsePsTFiEt1LoT=B4zhn_A@mail.gmail.com>
 <CAL3q7H6kLAmrYxcm19t2xQ4sh6wUyrB8LtStr901VOLCkFX0dA@mail.gmail.com> <CAMthOuP_AE9OwiTQCrh7CK73xdTZvHsLTB1JU2WBK6cCc05JYg@mail.gmail.com>
In-Reply-To: <CAMthOuP_AE9OwiTQCrh7CK73xdTZvHsLTB1JU2WBK6cCc05JYg@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 23 Jun 2025 17:30:08 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6e9vE9VA4x2-jGcJ=BDWS254B3=-7JGZeDbeytNmagfA@mail.gmail.com>
X-Gm-Features: Ac12FXyAWNyGEO9rdcgE4EGnbOESxe61xNlgL7unJltmAqV84ZMSaK0klcbD4-c
Message-ID: <CAL3q7H6e9vE9VA4x2-jGcJ=BDWS254B3=-7JGZeDbeytNmagfA@mail.gmail.com>
Subject: Re: btrfs dies in RIP: 0010:btrfs_get_64+0x65/0x110
To: Kai Krakow <hurikhan77@gmail.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 12:20=E2=80=AFPM Kai Krakow <hurikhan77@gmail.com> =
wrote:
>
> Hi Filipe!
>
> Am Mo., 23. Juni 2025 um 12:35 Uhr schrieb Filipe Manana <fdmanana@kernel=
.org>:
> >
> > On Mon, Jun 23, 2025 at 9:45=E2=80=AFAM Kai Krakow <hurikhan77@gmail.co=
m> wrote:
> > >
> > > Hello btrfs list!
> > >
> > > Some more context:
> > >
> > > > > Hello btrfs list!
> > > > >
> > > > > Once in a while, we are seeing the following kernel bug during th=
e
> > > > > night while the backup is putting some additional load on the sys=
tem:
> > > > >
> > > > > Jun 22 04:11:29 vch01 kernel: rcu: INFO: rcu_sched self-detected =
stall on CPU
> > > > > Jun 22 04:11:29 vch01 kernel: rcu:         10-....: (2100 ticks t=
his
> > > > > GP) idle=3D0494/1/0x4000000000000000 softirq=3D164826140/16482618=
7
> > > > > fqs=3D1052
> > > > > Jun 22 04:11:29 vch01 kernel: rcu:         (t=3D2100 jiffies g=3D=
358306033
> > > > > q=3D2241752 ncpus=3D16)
> > > > > Jun 22 04:11:29 vch01 kernel: CPU: 10 UID: 0 PID: 1524681 Comm:
> > > > > map_0x178e45670 Not tainted 6.12.21-gentoo #1
> > > > > Jun 22 04:11:29 vch01 kernel: Hardware name: Red Hat KVM, BIOS 0.=
5.1 01/01/2011
> > > > > Jun 22 04:11:29 vch01 kernel: RIP: 0010:btrfs_get_64+0x65/0x110
> > > > > Jun 22 04:11:29 vch01 kernel: Code: d3 ed 48 8b 4f 70 48 8b 31 83=
 e6
> > > > > 40 74 11 0f b6 49 40 41 bc 00 10 00 00 49 d3 e4 49 83 ec 01 4a 8b=
 5c
> > > > > ed 70 49 21 d4 45 89 c9 <48> 2b 1d 7c 99 09 01 49 01 c1 8b 55 08 =
49 8d
> > > > > 49 08 44 8b 75 0c 48
> > > > > Jun 22 04:11:29 vch01 kernel: RSP: 0018:ffffbb7ad531bba0 EFLAGS: =
00000202
> > > > > Jun 22 04:11:29 vch01 kernel: RAX: 0000000000001f15 RBX:
> > > > > fffff437ea382200 RCX: fffff437cb891200
> > > > > Jun 22 04:11:29 vch01 kernel: RDX: 000001922b68df2a RSI:
> > > > > 0000000000000000 RDI: ffffa434c3e66d20
> > > > > Jun 22 04:11:29 vch01 kernel: RBP: ffffa434c3e66d20 R08:
> > > > > 000001922b68c000 R09: 0000000000000015
> > > > > Jun 22 04:11:29 vch01 kernel: R10: 6c0000000000000a R11:
> > > > > 0000000009fe7000 R12: 0000000000000f2a
> > > > > Jun 22 04:11:29 vch01 kernel: R13: 0000000000000001 R14:
> > > > > ffffa43192e6d230 R15: ffffa43160c4c800
> > > > > Jun 22 04:11:29 vch01 kernel: FS:  000055d07085e6c0(0000)
> > > > > GS:ffffa4452bc80000(0000) knlGS:0000000000000000
> > > > > Jun 22 04:11:29 vch01 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
> > > > > Jun 22 04:11:29 vch01 kernel: CR2: 00007fff204ecfc0 CR3:
> > > > > 0000000121a0b000 CR4: 00000000001506f0
> > > > > Jun 22 04:11:29 vch01 kernel: DR0: 0000000000000000 DR1:
> > > > > 0000000000000000 DR2: 0000000000000000
> > > > > Jun 22 04:11:29 vch01 kernel: DR3: 0000000000000000 DR6:
> > > > > 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Jun 22 04:11:29 vch01 kernel: Call Trace:
> > > > > Jun 22 04:11:29 vch01 kernel:  <IRQ>
> > > > > Jun 22 04:11:29 vch01 kernel:  ? rcu_dump_cpu_stacks+0xd3/0x100
> > > > > Jun 22 04:11:29 vch01 kernel:  ? rcu_sched_clock_irq+0x4ff/0x920
> > > > > Jun 22 04:11:29 vch01 kernel:  ? update_process_times+0x6c/0xa0
> > > > > Jun 22 04:11:29 vch01 kernel:  ? tick_nohz_handler+0x82/0x110
> > > > > Jun 22 04:11:29 vch01 kernel:  ? tick_do_update_jiffies64+0xd0/0x=
d0
> > > > > Jun 22 04:11:29 vch01 kernel:  ? __hrtimer_run_queues+0x10b/0x190
> > > > > Jun 22 04:11:29 vch01 kernel:  ? hrtimer_interrupt+0xf1/0x200
> > > > > Jun 22 04:11:29 vch01 kernel:  ? __sysvec_apic_timer_interrupt+0x=
44/0x50
> > > > > Jun 22 04:11:29 vch01 kernel:  ? sysvec_apic_timer_interrupt+0x60=
/0x80
> > > > > Jun 22 04:11:29 vch01 kernel:  </IRQ>
> > > > > Jun 22 04:11:29 vch01 kernel:  <TASK>
> > > > > Jun 22 04:11:29 vch01 kernel:  ? asm_sysvec_apic_timer_interrupt+=
0x16/0x20
> > > > > Jun 22 04:11:29 vch01 kernel:  ? btrfs_get_64+0x65/0x110
> > > > > Jun 22 04:11:29 vch01 kernel:  find_parent_nodes+0x1b84/0x1dc0
> > > > > Jun 22 04:11:29 vch01 kernel:  btrfs_find_all_leafs+0x31/0xd0
> > > > > Jun 22 04:11:29 vch01 kernel:  ? queued_write_lock_slowpath+0x30/=
0x70
> > > > > Jun 22 04:11:29 vch01 kernel:  iterate_extent_inodes+0x6f/0x370
> > > > > Jun 22 04:11:29 vch01 kernel:  ? update_share_count+0x60/0x60
> > > > > Jun 22 04:11:29 vch01 kernel:  ? extent_from_logical+0x139/0x190
> > > > > Jun 22 04:11:29 vch01 kernel:  ? release_extent_buffer+0x96/0xb0
> > > > > Jun 22 04:11:29 vch01 kernel:  iterate_inodes_from_logical+0xaa/0=
xd0
> > > > > Jun 22 04:11:29 vch01 kernel:  btrfs_ioctl_logical_to_ino+0xaa/0x=
150
> > > > > Jun 22 04:11:29 vch01 kernel:  __x64_sys_ioctl+0x84/0xc0
> > > > > Jun 22 04:11:29 vch01 kernel:  do_syscall_64+0x47/0x100
> > > > > Jun 22 04:11:29 vch01 kernel:  entry_SYSCALL_64_after_hwframe+0x4=
b/0x53
> > > > > Jun 22 04:11:29 vch01 kernel: RIP: 0033:0x55d07617eaaf
> > > > > Jun 22 04:11:29 vch01 kernel: Code: 00 48 89 44 24 18 31 c0 48 8d=
 44
> > > > > 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44=
 24
> > > > > 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 =
18 64
> > > > > 48 2b 04 25 28 00 00
> > > > > Jun 22 04:11:29 vch01 kernel: RSP: 002b:000055d07085bc20 EFLAGS:
> > > > > 00000246 ORIG_RAX: 0000000000000010
> > > > > Jun 22 04:11:29 vch01 kernel: RAX: ffffffffffffffda RBX:
> > > > > 000055d0402f8550 RCX: 000055d07617eaaf
> > > > > Jun 22 04:11:29 vch01 kernel: RDX: 000055d07085bca0 RSI:
> > > > > 00000000c038943b RDI: 0000000000000003
> > > > > Jun 22 04:11:29 vch01 kernel: RBP: 000055d07085bea0 R08:
> > > > > 00007fee46c84080 R09: 0000000000000000
> > > > > Jun 22 04:11:29 vch01 kernel: R10: 0000000000000000 R11:
> > > > > 0000000000000246 R12: 0000000000000003
> > > > > Jun 22 04:11:29 vch01 kernel: R13: 000055d07085bf80 R14:
> > > > > 000055d07085bf48 R15: 000055d07085c0b0
> > > > > Jun 22 04:11:29 vch01 kernel:  </TASK>
> > > > >
> > > > > Some more information about the environment and incident observat=
ions:
> > > > >
> > > > > The kernel is compiled without module support, everything baked i=
n, no
> > > > > proprietary modules.
> > > > >
> > > > > The file system has previously been recreated by restoring from b=
ackup
> > > > > but we still see this problem once in a while, so I suspect there=
's no
> > > > > file system inconsistency involved.
> > > > >
> > > > > The rootfs itself is on xfs, so I can still login. But the system=
 is
> > > > > very slow, takes 5-10 minutes to log in via SSH, commands like
> > > > > "reboot" time out because the system dbus is congested.
> > > > >
> > > > > This bug cannot be easily triggered. So far, it only happened at
> > > > > night, the system needs uptime of multiple days or weeks, with so=
me
> > > > > amount of swap used, and the backup (borg backup) has to run. So =
I
> > > > > think this happens because we get some memory pressure while we a=
lso
> > > > > have memory fragmentation going on for some time.
> > > > >
> > > > > The system is running bees on the btrfs pool because naturally th=
is
> > > > > web and mail hosting system has a lot of duplicate files. Mysql i=
s
> > > > > running on xfs only. Temporary files during backup are created on=
 xfs
> > > > > only (the backup can access the btrfs only via r/o, no writes
> > > > > allowed). Snapper takes snapshots every hour and cleans out older
> > > > > snapshots over time.
> > > > >
> > > > > I've now upgraded to the current Gentoo stable release 6.21.31 of=
 the kernel.
> > > > >
> > > > > btrfs is running in single data / raid1 meta on three disks provi=
ded
> > > > > by KVM via virtio. The KVM images itself are served by drbd redun=
dant
> > > > > over multiple servers (outside of the VM). The hardware itself ha=
s no
> > > > > known hardware issues (no memory errors, no storage errors). Scru=
bbing
> > > > > finds no checksum or other errors. The VM or storage hasn't been
> > > > > migrated at time of the incident or recently.
> > > > >
> > > > > #  uname -a
> > > > > Linux vch01 6.12.21-gentoo #2 SMP Thu May 15 18:02:52 CEST 2025 x=
86_64
> > > > > Intel Xeon E3-12xx v2 (Ivy Bridge) GenuineIntel GNU/Linux
> > > > >
> > > > > # free -m
> > > > >               total        used        free      shared  buff/cac=
he   available
> > > > > Mem:           84476       33122        1941        3344       48=
183       51353
> > > > > Swap:          15358        5362        9996
> > > > >
> > > > > #  cat /proc/cpuinfo | egrep 'processor|model|cpu|cache' | sort -=
u
> > > > > bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_b=
ypass
> > > > > l1tf mds swapgs itlb_multihit srbds mmio_unknown bhi
> > > > > cache_alignment : 64
> > > > > cache size      : 4096 KB
> > > > > cpu cores       : 1
> > > > > cpu family      : 6
> > > > > cpuid level     : 13
> > > > > cpu MHz         : 2399.998
> > > > > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtr=
r pge
> > > > > mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx rdtscp lm
> > > > > constant_tsc rep_good nopl cpuid tsc_known_freq pni pclmulqdq sss=
e3
> > > > > cx16 sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx=
 f16c
> > > > > rdrand hypervisor lahf_lm fsgsbase smep erms xsaveopt
> > > > > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtr=
r pge
> > > > > mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx rdtscp lm
> > > > > constant_tsc rep_good nopl cpuid tsc_known_freq pni pclmulqdq sss=
e3
> > > > > cx16 sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx=
 f16c
> > > > > rdrand hypervisor lahf_lm intel_ppin fsgsbase smep erms xsaveopt
> > > > > model           : 58
> > > > > model name      : Intel Xeon E3-12xx v2 (Ivy Bridge)
> > > > > processor       : 0
> > > > > processor       : 1
> > > > > processor       : 10
> > > > > processor       : 11
> > > > > processor       : 12
> > > > > processor       : 13
> > > > > processor       : 14
> > > > > processor       : 15
> > > > > processor       : 2
> > > > > processor       : 3
> > > > > processor       : 4
> > > > > processor       : 5
> > > > > processor       : 6
> > > > > processor       : 7
> > > > > processor       : 8
> > > > > processor       : 9
> > > > >
> > > > > Thanks for looking into it. If you need more information, I may b=
e
> > > > > able to provide it as long as I don't have to get it from the sti=
ll
> > > > > running machine: it has been rebooted since the incident.
> > >
> > > We have reports that the system already slowed down around 4-5 hours
> > > before the kernel log. This was reported before the backup started at
> > > 1 am. So the additional load introduced by the backup probably only
> > > accelerated what already has gone wrong. On another note, I think if
> > > it survived the backup, the situation would have probably relaxed
> > > enough to not trigger the RCU stall.
> >
> > The RCU stall could be because there's a large number of backrefs for
> > some extents and we're spending too much time looping over them
> > without ever yielding the cpu.
> >
> > Are you able to test the following patch and see if the warning goes aw=
ay?
> >
> > https://pastebin.com/raw/aGUPHi93
>
> I will happily test this patch. But since this problem only triggers
> every few weeks, it's hard to reproduce, and even harder to say if it
> solved anything.
>
> Using ChatGPT, I worked out that I should probably reduce meta data
> operations like snapshot cleanups while the backup is running. So I
> modified snapper-cleanup.service to not run while the borgbackup lock
> file exists. This may already modify the outcome of testing the patch,
> what do you think?

There are many variables that can make something more likely or less
likely to happen.
If by snapshot cleanups you mean deleting snapshots, that could help
decrease the number of the backrefs and maybe make the problem less
likely.
But then there may be other things running in your system that are
creating a lot more backrefs (clone, dedupe. snapshot creation) at a
higher rate.
Unlinks also remove backrefs, and so many other things.

The best way to test the patch is really without doing any changes to
the workload.

Judging from your stack trace, we are processing keyed backrefs, and
that means there are at least 33 backrefs for one particular extent at
least.
Maybe you have some extents that are shared hundreds or thousands of
times, and that could make the task running the logical_to_ino ioctl
spend a lot of time iterating over backrefs without yielding the cpu,
therefore triggering the RCU stall detector.

>
> > Thanks.
>
> Regards,
> Kai

