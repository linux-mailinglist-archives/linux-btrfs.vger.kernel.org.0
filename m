Return-Path: <linux-btrfs+bounces-14865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EBDAE3DCD
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 13:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45EB37A29DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 11:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB6A23D2AE;
	Mon, 23 Jun 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTo4LrKF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2742C1B808
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750677618; cv=none; b=NXFY9vjvvwnPv4fqxVqhFyXbMcyzla0wF7cW7TQGuqh1w3ppI55yVz2ac8QVumeJqkxQVb2wx+XUpNwpN8pr9SQYejDC0KlmSYgWjhyz0uJEIrJyO4yrT7dslCvyexhfRFmMCgFDo8JWe5FJLOLly0lU9Yh5XLsB2a61S2SHr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750677618; c=relaxed/simple;
	bh=H9jfnphwsXpUY4r2IIuntsGKcLeSEQs0Qabu9WLzX2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=im3b3DZ6UQrmB5UUkJH/JJg4qjeBOIYD8Uf9XW6ZnuqzlvMoJLg+BrZvF4YzHmV8dLYoE0dT9FZ1NYfTWkCMfI974fkdrgpVOoNvyriG03UgR/H+IACLEV9eYZwbfEtTSLcUrJ1OdY9IzfcJ5QZh4slMPLehECAv/w63aAm7eyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTo4LrKF; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a58c2430edso44313071cf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 04:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750677615; x=1751282415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO88YfN+RmAOo8+ZJjg35uvtAhc3nOEL9U3c5R/+m6w=;
        b=KTo4LrKFWjdleEamMdcy970KsY4EFBMEiyDXegyLXmtruDWiAxo4XQeyaiG8CMa617
         5kgFHWYKX85vmL0GANcL0BjXana66/u/E5iMhKSRg5CWBfGqwSztf1gk3sf7ECrPFdfU
         Ey8As19B38mc6O+Ev4kyIyzAxzoY+XbtGObaYKjkAF8PsKcNN5lA2j8aDdSjk5N9Gjyc
         8f0Oay7E88AuYWqb5zp2VEXyn88iyH2quk8bWHvxJhaP4sjyMZT6bjdb0N+Ql9TnPNqc
         UoxocQCFmlQX1wD32NcsOwyianFD3GMvcGuU/2jDhw8mvA9oL1FsypVv8QyZatpGgBWx
         6vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750677615; x=1751282415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO88YfN+RmAOo8+ZJjg35uvtAhc3nOEL9U3c5R/+m6w=;
        b=efzg4CzVB4DzbvOp8oOvT4sNdVmet/zbU9gyeGP5ooRyQhGoQlPKGWWOu+Q/eZ1JWO
         t5wEqHfrCHNswufu3XaBexQO63COrrvJEqY4BL7mP6IJZsQv8COjErNC5zNckl4uo3ER
         gERFiJg/+pGCI8KTGf8o6BOii2QRxwysRusUBcRXyt4NWWYUtkYAKkmnTmNYYTIVnd4y
         zDEzikfbkwfU2t5sRqAUfwRX2Bpfzigy1I5M4LMYREiKpxdPQPecpIfTWMwWeNPqmFgO
         RrAV9+lJChItXQsZjb2Cjb9tL6Dd90nipDh/ECzxTThvzHzTP3LszKefqaz6E7t9Na03
         SPvw==
X-Gm-Message-State: AOJu0Ywnxr27ILLFeEtjair7qEL5sNoi+/swzL8dodarlMoSUYqEqkkn
	q2ZFNfRJFU4ajsPh7+Wm9lEbHUTmWvObebrDjW3xSnZXhA+iqKCevKoVD+bhLAzlthHrqQMnI5G
	9W4/B63UtfllplYk9XpLpZDeZ3eB0FNCwKA==
X-Gm-Gg: ASbGnct/IeIyCHeWqPWjbTi2P80MscFU7QZuZvSEE7PK+q4Pp/vuESpMeqQ2KbfJEtv
	km+vlvDBUF+xcPPp7LJz6dEeWuJ8S5FD8zhMG+XedD3DVSTDzF0X9PgE1ZSYI2HDyz4jwFqfNiv
	4C0oIIK5mQ10lQu6KxOx6V9QgITzzLRJettqgDMeVnQkV/zrBDVgRUs1JpCO33vRb18rMaRc0Sv
	w==
X-Google-Smtp-Source: AGHT+IHDhtY+e2k+ayjMrrfhbErPYRlKfBI0cXgmegQZG6KXcxZjMSr0ATqyJkZwNNzDsi+CD+/cUQ00dU1SOCu1WcM=
X-Received: by 2002:a05:622a:c8:b0:4a7:817e:c345 with SMTP id
 d75a77b69052e-4a78707d14cmr138936801cf.24.1750677614738; Mon, 23 Jun 2025
 04:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMthOuMkG7apm2thceT4rAkdJ-Y7aBBZSxF4Ct219aE6qiaGFw@mail.gmail.com>
 <CAMthOuNtOBVa41+MXEYXwqfEJgUsDjKnzPGnmRmbARNKcKPhbQ@mail.gmail.com>
 <CAMthOuPPGDu7Ojzf2okGA+5dd2-wQsePsTFiEt1LoT=B4zhn_A@mail.gmail.com> <CAL3q7H6kLAmrYxcm19t2xQ4sh6wUyrB8LtStr901VOLCkFX0dA@mail.gmail.com>
In-Reply-To: <CAL3q7H6kLAmrYxcm19t2xQ4sh6wUyrB8LtStr901VOLCkFX0dA@mail.gmail.com>
From: Kai Krakow <hurikhan77@gmail.com>
Date: Mon, 23 Jun 2025 13:19:48 +0200
X-Gm-Features: AX0GCFvrFXZzr-UtkpJsofX970QEyzUT5CfARz5vuulIKa9aE6vJJ_PaIPckcpU
Message-ID: <CAMthOuP_AE9OwiTQCrh7CK73xdTZvHsLTB1JU2WBK6cCc05JYg@mail.gmail.com>
Subject: Re: btrfs dies in RIP: 0010:btrfs_get_64+0x65/0x110
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Filipe!

Am Mo., 23. Juni 2025 um 12:35 Uhr schrieb Filipe Manana <fdmanana@kernel.o=
rg>:
>
> On Mon, Jun 23, 2025 at 9:45=E2=80=AFAM Kai Krakow <hurikhan77@gmail.com>=
 wrote:
> >
> > Hello btrfs list!
> >
> > Some more context:
> >
> > > > Hello btrfs list!
> > > >
> > > > Once in a while, we are seeing the following kernel bug during the
> > > > night while the backup is putting some additional load on the syste=
m:
> > > >
> > > > Jun 22 04:11:29 vch01 kernel: rcu: INFO: rcu_sched self-detected st=
all on CPU
> > > > Jun 22 04:11:29 vch01 kernel: rcu:         10-....: (2100 ticks thi=
s
> > > > GP) idle=3D0494/1/0x4000000000000000 softirq=3D164826140/164826187
> > > > fqs=3D1052
> > > > Jun 22 04:11:29 vch01 kernel: rcu:         (t=3D2100 jiffies g=3D35=
8306033
> > > > q=3D2241752 ncpus=3D16)
> > > > Jun 22 04:11:29 vch01 kernel: CPU: 10 UID: 0 PID: 1524681 Comm:
> > > > map_0x178e45670 Not tainted 6.12.21-gentoo #1
> > > > Jun 22 04:11:29 vch01 kernel: Hardware name: Red Hat KVM, BIOS 0.5.=
1 01/01/2011
> > > > Jun 22 04:11:29 vch01 kernel: RIP: 0010:btrfs_get_64+0x65/0x110
> > > > Jun 22 04:11:29 vch01 kernel: Code: d3 ed 48 8b 4f 70 48 8b 31 83 e=
6
> > > > 40 74 11 0f b6 49 40 41 bc 00 10 00 00 49 d3 e4 49 83 ec 01 4a 8b 5=
c
> > > > ed 70 49 21 d4 45 89 c9 <48> 2b 1d 7c 99 09 01 49 01 c1 8b 55 08 49=
 8d
> > > > 49 08 44 8b 75 0c 48
> > > > Jun 22 04:11:29 vch01 kernel: RSP: 0018:ffffbb7ad531bba0 EFLAGS: 00=
000202
> > > > Jun 22 04:11:29 vch01 kernel: RAX: 0000000000001f15 RBX:
> > > > fffff437ea382200 RCX: fffff437cb891200
> > > > Jun 22 04:11:29 vch01 kernel: RDX: 000001922b68df2a RSI:
> > > > 0000000000000000 RDI: ffffa434c3e66d20
> > > > Jun 22 04:11:29 vch01 kernel: RBP: ffffa434c3e66d20 R08:
> > > > 000001922b68c000 R09: 0000000000000015
> > > > Jun 22 04:11:29 vch01 kernel: R10: 6c0000000000000a R11:
> > > > 0000000009fe7000 R12: 0000000000000f2a
> > > > Jun 22 04:11:29 vch01 kernel: R13: 0000000000000001 R14:
> > > > ffffa43192e6d230 R15: ffffa43160c4c800
> > > > Jun 22 04:11:29 vch01 kernel: FS:  000055d07085e6c0(0000)
> > > > GS:ffffa4452bc80000(0000) knlGS:0000000000000000
> > > > Jun 22 04:11:29 vch01 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033
> > > > Jun 22 04:11:29 vch01 kernel: CR2: 00007fff204ecfc0 CR3:
> > > > 0000000121a0b000 CR4: 00000000001506f0
> > > > Jun 22 04:11:29 vch01 kernel: DR0: 0000000000000000 DR1:
> > > > 0000000000000000 DR2: 0000000000000000
> > > > Jun 22 04:11:29 vch01 kernel: DR3: 0000000000000000 DR6:
> > > > 00000000fffe0ff0 DR7: 0000000000000400
> > > > Jun 22 04:11:29 vch01 kernel: Call Trace:
> > > > Jun 22 04:11:29 vch01 kernel:  <IRQ>
> > > > Jun 22 04:11:29 vch01 kernel:  ? rcu_dump_cpu_stacks+0xd3/0x100
> > > > Jun 22 04:11:29 vch01 kernel:  ? rcu_sched_clock_irq+0x4ff/0x920
> > > > Jun 22 04:11:29 vch01 kernel:  ? update_process_times+0x6c/0xa0
> > > > Jun 22 04:11:29 vch01 kernel:  ? tick_nohz_handler+0x82/0x110
> > > > Jun 22 04:11:29 vch01 kernel:  ? tick_do_update_jiffies64+0xd0/0xd0
> > > > Jun 22 04:11:29 vch01 kernel:  ? __hrtimer_run_queues+0x10b/0x190
> > > > Jun 22 04:11:29 vch01 kernel:  ? hrtimer_interrupt+0xf1/0x200
> > > > Jun 22 04:11:29 vch01 kernel:  ? __sysvec_apic_timer_interrupt+0x44=
/0x50
> > > > Jun 22 04:11:29 vch01 kernel:  ? sysvec_apic_timer_interrupt+0x60/0=
x80
> > > > Jun 22 04:11:29 vch01 kernel:  </IRQ>
> > > > Jun 22 04:11:29 vch01 kernel:  <TASK>
> > > > Jun 22 04:11:29 vch01 kernel:  ? asm_sysvec_apic_timer_interrupt+0x=
16/0x20
> > > > Jun 22 04:11:29 vch01 kernel:  ? btrfs_get_64+0x65/0x110
> > > > Jun 22 04:11:29 vch01 kernel:  find_parent_nodes+0x1b84/0x1dc0
> > > > Jun 22 04:11:29 vch01 kernel:  btrfs_find_all_leafs+0x31/0xd0
> > > > Jun 22 04:11:29 vch01 kernel:  ? queued_write_lock_slowpath+0x30/0x=
70
> > > > Jun 22 04:11:29 vch01 kernel:  iterate_extent_inodes+0x6f/0x370
> > > > Jun 22 04:11:29 vch01 kernel:  ? update_share_count+0x60/0x60
> > > > Jun 22 04:11:29 vch01 kernel:  ? extent_from_logical+0x139/0x190
> > > > Jun 22 04:11:29 vch01 kernel:  ? release_extent_buffer+0x96/0xb0
> > > > Jun 22 04:11:29 vch01 kernel:  iterate_inodes_from_logical+0xaa/0xd=
0
> > > > Jun 22 04:11:29 vch01 kernel:  btrfs_ioctl_logical_to_ino+0xaa/0x15=
0
> > > > Jun 22 04:11:29 vch01 kernel:  __x64_sys_ioctl+0x84/0xc0
> > > > Jun 22 04:11:29 vch01 kernel:  do_syscall_64+0x47/0x100
> > > > Jun 22 04:11:29 vch01 kernel:  entry_SYSCALL_64_after_hwframe+0x4b/=
0x53
> > > > Jun 22 04:11:29 vch01 kernel: RIP: 0033:0x55d07617eaaf
> > > > Jun 22 04:11:29 vch01 kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 4=
4
> > > > 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 2=
4
> > > > 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18=
 64
> > > > 48 2b 04 25 28 00 00
> > > > Jun 22 04:11:29 vch01 kernel: RSP: 002b:000055d07085bc20 EFLAGS:
> > > > 00000246 ORIG_RAX: 0000000000000010
> > > > Jun 22 04:11:29 vch01 kernel: RAX: ffffffffffffffda RBX:
> > > > 000055d0402f8550 RCX: 000055d07617eaaf
> > > > Jun 22 04:11:29 vch01 kernel: RDX: 000055d07085bca0 RSI:
> > > > 00000000c038943b RDI: 0000000000000003
> > > > Jun 22 04:11:29 vch01 kernel: RBP: 000055d07085bea0 R08:
> > > > 00007fee46c84080 R09: 0000000000000000
> > > > Jun 22 04:11:29 vch01 kernel: R10: 0000000000000000 R11:
> > > > 0000000000000246 R12: 0000000000000003
> > > > Jun 22 04:11:29 vch01 kernel: R13: 000055d07085bf80 R14:
> > > > 000055d07085bf48 R15: 000055d07085c0b0
> > > > Jun 22 04:11:29 vch01 kernel:  </TASK>
> > > >
> > > > Some more information about the environment and incident observatio=
ns:
> > > >
> > > > The kernel is compiled without module support, everything baked in,=
 no
> > > > proprietary modules.
> > > >
> > > > The file system has previously been recreated by restoring from bac=
kup
> > > > but we still see this problem once in a while, so I suspect there's=
 no
> > > > file system inconsistency involved.
> > > >
> > > > The rootfs itself is on xfs, so I can still login. But the system i=
s
> > > > very slow, takes 5-10 minutes to log in via SSH, commands like
> > > > "reboot" time out because the system dbus is congested.
> > > >
> > > > This bug cannot be easily triggered. So far, it only happened at
> > > > night, the system needs uptime of multiple days or weeks, with some
> > > > amount of swap used, and the backup (borg backup) has to run. So I
> > > > think this happens because we get some memory pressure while we als=
o
> > > > have memory fragmentation going on for some time.
> > > >
> > > > The system is running bees on the btrfs pool because naturally this
> > > > web and mail hosting system has a lot of duplicate files. Mysql is
> > > > running on xfs only. Temporary files during backup are created on x=
fs
> > > > only (the backup can access the btrfs only via r/o, no writes
> > > > allowed). Snapper takes snapshots every hour and cleans out older
> > > > snapshots over time.
> > > >
> > > > I've now upgraded to the current Gentoo stable release 6.21.31 of t=
he kernel.
> > > >
> > > > btrfs is running in single data / raid1 meta on three disks provide=
d
> > > > by KVM via virtio. The KVM images itself are served by drbd redunda=
nt
> > > > over multiple servers (outside of the VM). The hardware itself has =
no
> > > > known hardware issues (no memory errors, no storage errors). Scrubb=
ing
> > > > finds no checksum or other errors. The VM or storage hasn't been
> > > > migrated at time of the incident or recently.
> > > >
> > > > #  uname -a
> > > > Linux vch01 6.12.21-gentoo #2 SMP Thu May 15 18:02:52 CEST 2025 x86=
_64
> > > > Intel Xeon E3-12xx v2 (Ivy Bridge) GenuineIntel GNU/Linux
> > > >
> > > > # free -m
> > > >               total        used        free      shared  buff/cache=
   available
> > > > Mem:           84476       33122        1941        3344       4818=
3       51353
> > > > Swap:          15358        5362        9996
> > > >
> > > > #  cat /proc/cpuinfo | egrep 'processor|model|cpu|cache' | sort -u
> > > > bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_byp=
ass
> > > > l1tf mds swapgs itlb_multihit srbds mmio_unknown bhi
> > > > cache_alignment : 64
> > > > cache size      : 4096 KB
> > > > cpu cores       : 1
> > > > cpu family      : 6
> > > > cpuid level     : 13
> > > > cpu MHz         : 2399.998
> > > > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr =
pge
> > > > mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx rdtscp lm
> > > > constant_tsc rep_good nopl cpuid tsc_known_freq pni pclmulqdq ssse3
> > > > cx16 sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f=
16c
> > > > rdrand hypervisor lahf_lm fsgsbase smep erms xsaveopt
> > > > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr =
pge
> > > > mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx rdtscp lm
> > > > constant_tsc rep_good nopl cpuid tsc_known_freq pni pclmulqdq ssse3
> > > > cx16 sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f=
16c
> > > > rdrand hypervisor lahf_lm intel_ppin fsgsbase smep erms xsaveopt
> > > > model           : 58
> > > > model name      : Intel Xeon E3-12xx v2 (Ivy Bridge)
> > > > processor       : 0
> > > > processor       : 1
> > > > processor       : 10
> > > > processor       : 11
> > > > processor       : 12
> > > > processor       : 13
> > > > processor       : 14
> > > > processor       : 15
> > > > processor       : 2
> > > > processor       : 3
> > > > processor       : 4
> > > > processor       : 5
> > > > processor       : 6
> > > > processor       : 7
> > > > processor       : 8
> > > > processor       : 9
> > > >
> > > > Thanks for looking into it. If you need more information, I may be
> > > > able to provide it as long as I don't have to get it from the still
> > > > running machine: it has been rebooted since the incident.
> >
> > We have reports that the system already slowed down around 4-5 hours
> > before the kernel log. This was reported before the backup started at
> > 1 am. So the additional load introduced by the backup probably only
> > accelerated what already has gone wrong. On another note, I think if
> > it survived the backup, the situation would have probably relaxed
> > enough to not trigger the RCU stall.
>
> The RCU stall could be because there's a large number of backrefs for
> some extents and we're spending too much time looping over them
> without ever yielding the cpu.
>
> Are you able to test the following patch and see if the warning goes away=
?
>
> https://pastebin.com/raw/aGUPHi93

I will happily test this patch. But since this problem only triggers
every few weeks, it's hard to reproduce, and even harder to say if it
solved anything.

Using ChatGPT, I worked out that I should probably reduce meta data
operations like snapshot cleanups while the backup is running. So I
modified snapper-cleanup.service to not run while the borgbackup lock
file exists. This may already modify the outcome of testing the patch,
what do you think?

> Thanks.

Regards,
Kai

