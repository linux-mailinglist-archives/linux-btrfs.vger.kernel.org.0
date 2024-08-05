Return-Path: <linux-btrfs+bounces-6982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004D9477C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 10:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFFFCB23374
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C42154BF8;
	Mon,  5 Aug 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandnabba.se header.i=@sandnabba.se header.b="GEAmgC5E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from r09.out0.gmailify.com (r09.out0.gmailify.com [159.255.151.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4C514D71A
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.255.151.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848195; cv=none; b=SWFR8UpYhNHCVbcNyVFIRPEsoLd+dDwN62DnDJVBb/V3k5njRvdfBV/MvDV8HqFo+YQO7KSe2ZxqmU3vv/Otbm7ucGzH2UA4Q8Ajryesg6sdwcMbGDcxsWdl23I1rw0bVl0u7nSIwQQpw1a2QmtXlkRoWo4B+8cHbsM6eSmxb/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848195; c=relaxed/simple;
	bh=ufQxPFow7uR+0iS8EE36/PWbTIoeViCam75pEZvWmow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taRclUjIl7zS0sBVGc9jBPQxihT6x3EAsg38gT3NEb9QpIIJCcDnooTWJ4Gqqkt7t/9A3x6/NBHxyr3IB45zTbHojhH5Giyja2rF4ioHLl5tpmD91Dsv975x7f0TTVeiNHxVi90I2Zu3WffJh4NqQ9aiUh74HFw61hDCH//EDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandnabba.se; spf=pass smtp.mailfrom=sandnabba.se; dkim=pass (2048-bit key) header.d=sandnabba.se header.i=@sandnabba.se header.b=GEAmgC5E; arc=none smtp.client-ip=159.255.151.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandnabba.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandnabba.se
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.gmailify.com (Postfix) with ESMTPSA id B2F5611C11EC
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 08:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandnabba.se;
	s=gm0; t=1722845814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHV05M/aPq7wJVqF1r3qoM+zM6KUw5Kf32W8RDV+JRo=;
	b=GEAmgC5Enr13lfAxH7G6SULGmAMxz4UkuIoKLQ7P9Z1EdtimZCQ6vSBgj/szP5XYramqpW
	u+M2lAy06gjx99ncnmQK6YzX475LD++w07PZmNkUOo6vAdn5Hsm1u2QSA0A17laQ1aPoeo
	/KhYCDdFJoxGFYZMWcbVCosJzZoNq9A+pkX0jba/+9X/zrJKB65Mb2hYms6YvmkHzwgYtG
	cm6jKuRoZJY80kGgpnYH69o9Qj00FsfjLfEp82syj+Rk72dHXPofeRbAszoRFUyGFadJCl
	PcmxFlRFAxKsQfr353grrH5zB8IOc+Cx4JD3uMMPs3Gg3o55mkGvfl9XNSeFmA==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b7a3e468a9so74535086d6.1
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Aug 2024 01:16:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLV/CnGWVxM7IW5wMd0S2MaygBSihewwImtd3naEXYn37B0iCvSYtHnb0U4GqML1u9LDNBPixU8ecrGi0dGv8Fwq+Juql6NCor9EA=
X-Gm-Message-State: AOJu0YwcgqajuW1Fq5WlsXygJTE+p42msiv8E34kFJkNbJxcnsgCjbib
	hIBprGcOrzoUJ0vkR9NioGMposTTb9rbNavOwSQ1zF+MRioaDtirxB956KiOH3PfY3aKrway7TX
	Wq2xnZVndU5RAahIQlDCOe+ou+Lc=
X-Google-Smtp-Source: AGHT+IGblYo9nNnfx6ftmBwBYqnaKlC//FeCp7mvUaHrV1glZbqlytB9ljQRwH5gkbHNsU38WnwwUckstOptMbueYr0=
X-Received: by 2002:a05:6214:3288:b0:6b5:eb34:6e72 with SMTP id
 6a1803df08f44-6bb983a9421mr109034156d6.11.1722845811763; Mon, 05 Aug 2024
 01:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEA9r7DVO8gCRz-9vbwaNWznz9AOFxOyPLO0ukOJh-6Ef0o5Bw@mail.gmail.com>
 <20240725224757.GD17473@twin.jikos.cz> <aeed4735-f6f2-49ef-9a02-816a3b74cbd3@gmx.com>
 <CAEA9r7AzYtQ9BifUPcW3=1zz=RmS9Fb3CnProGMg6GVkmd14TQ@mail.gmail.com> <2598F89C9D10565B+29575f56-c98e-4316-8360-0e3e9e7748ff@bupt.moe>
In-Reply-To: <2598F89C9D10565B+29575f56-c98e-4316-8360-0e3e9e7748ff@bupt.moe>
X-Report-Abuse: Please report any abuse attempt to abuse@gmailify.com and include these headers.
From: "Emil.s" <emil@sandnabba.se>
Date: Mon, 5 Aug 2024 10:16:40 +0200
X-Gmail-Original-Message-ID: <CAEA9r7CaJJRvDZ3iL9LuKtgi-xO+R-qOxiUg-4Ms-vzG_y+Y5g@mail.gmail.com>
Message-ID: <CAEA9r7CaJJRvDZ3iL9LuKtgi-xO+R-qOxiUg-4Ms-vzG_y+Y5g@mail.gmail.com>
Subject: Re: Force remove of broken extent/subvolume? (Crash in btrfs_run_delayed_refs)
To: Yuwei Han <hrx@bupt.moe>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Gmailify-Queue-Id: B2F5611C11EC
X-Gmailify-Score: -0.10

> For curiosity, did you setup any scrub after rebuild FS?

The new FS is built on new drives, on new hardware and new Linux
kernel. And I'm rsyncing over all files so that everything will be
built from scratch.

However, I still got a snapshot (from 2024-03-20) on my offsite backup.
I just scrubbed that drive, and it reports no errors. I'm also quite
sure I scrubbed the corrupt drive quite recently without issues.

Another interesting note is that I'm also unable to send any file
system from the corrupt drive (which is probably a good thing).
```
$ btrfs send /mnt/snapshots/user_data_2024-03-20 > /dev/null
At subvol /mnt/snapshots/user_data_2024-03-20
ERROR: send ioctl failed with -30: Read-only file system
```

Wasn't expecting a "Read-only file system" error when sending a
read-only snapshot? (But maybe that is expected?).


On Sun, 28 Jul 2024 at 18:09, Yuwei Han <hrx@bupt.moe> wrote:
>
>
>
> =E5=9C=A8 2024/7/26 18:52, Emil.s =E5=86=99=E9=81=93:
> >> As for any bitflip induced errors, it's hard to tell how far it got
> >> propagated, this could be the only instance or there could be other
> >> items referring to that one too.
> >
> > Right, yeah that sounds a bit more challenging then I initially thought=
.
> > Maybe it is easier to just rebuild the array after all.
> >
> > And in regards to Qu's question, that is probably a good idea anyhow.
> >
> >> - History of the fs
> >> - The hardware spec
> >
> > This has been my personal NAS / home server for quite some time.
> > It's basically a mix of just leftover desktop hardware (without ECC mem=
ory).
> >
> > It was a 12 year old Gigabyte H77-D3H motherboard, an Intel i7-2600 CPU
> > and 4 DDR3 DIMMs, all of different types and brands.
> > The disks are WD red series, and I see now that one of them has over
> > 80k power on hours.
> >
> > I know I did a rebuild about 5 years ago so the FS was probably
> > created using Ubuntu server 18.04 (Linux 4.15), which has been
> > upgraded to the major LTS versions since then.
> > I actually hit this error when I was doing the "final backup" before
> > retiring this setup, and it seems it was about time! (Was running
> > Ubuntu 22.04 / Linux 5.15)
> >
> For curiosity, did you setup any scrub after rebuild FS?
> > The Arch setup on the Thinkstation is my workstation where I attempted
> > the data recovery.
> >
> > So due to the legacy hardware and crappy setup I think it's worth
> > wasting more time here.
> >
> > But thanks a lot for the detailed answer, much appreciated!
> >
> > Best,
> > Emil
> >
> > On Fri, 26 Jul 2024 at 01:19, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/7/26 08:17, David Sterba =E5=86=99=E9=81=93:
> >>> On Thu, Jul 25, 2024 at 11:06:00PM +0200, Emil.s wrote:
> >>>> Hello!
> >>>>
> >>>> I got a corrupt filesystem due to backpointer mismatches:
> >>>> ---
> >>>> [2/7] checking extents
> >>>> data extent[780333588480, 942080] size mismatch, extent item size
> >>>> 925696 file item size 942080
> >>>
> >>> This looks like a single bit flip:
> >>>
> >>>>>> bin(925696)
> >>> '0b11100010000000000000'
> >>>>>> bin(942080)
> >>> '0b11100110000000000000'
> >>>>>> bin(942080 ^ 925696)
> >>> 0b100000000000000'
> >>>
> >>> or an off by one error, as the delta is 0x4000, 4x page which is one
> >>> node size.
> >>>
> >>>> backpointer mismatch on [780333588480 925696]
> >>>> ---
> >>>>
> >>>> However only two extents seem to be affected, in a subvolume only us=
ed
> >>>> for backups.
> >>>>
> >>>> Since I've not been able to repair it, I thought that I could just
> >>>> delete the subvolume and recreate it.
> >>>> But now the btrfs_run_delayed_refs function crashes a while after
> >>>> mounting the filesystem. (Which is quite obvious when I think about
> >>>> it, since I guess it's trying to reclaim space, hitting the bad exte=
nt
> >>>> in the process?)
> >>>>
> >>>> Anyhow, is it possible to force removal of these extents in any way?
> >>>> My understanding is that extents are mapped to a specific subvolume =
as
> >>>> well?
> >>>>
> >>>> Here is the full crash dump:
> >>>> https://gist.github.com/sandnabba/e3ed7f57e4d32f404355fdf988fcfbff
> >>>
> >>> WARNING: CPU: 3 PID: 199588 at fs/btrfs/extent-tree.c:858 lookup_inli=
ne_extent_backref+0x5c3/0x760 [btrfs]
> >>>
> >>>    858         } else if (WARN_ON(ret)) {
> >>>    859                 btrfs_print_leaf(path->nodes[0]);
> >>>    860                 btrfs_err(fs_info,
> >>>    861 "extent item not found for insert, bytenr %llu num_bytes %llu =
parent %llu root_objectid %llu owner %llu offset %llu",
> >>>    862                           bytenr, num_bytes, parent, root_obje=
ctid, owner,
> >>>    863                           offset);
> >>>    864                 ret =3D -EUCLEAN;
> >>>    865                 goto out;
> >>>    866         }
> >>>    867
> >>>
> >>> CPU: 3 PID: 199588 Comm: btrfs-transacti Tainted: P           OE     =
 6.9.9-arch1-1 #1 a564e80ab10c5cd5584d6e9a0715907a10e33ca4
> >>> Hardware name: LENOVO 30B4S01W00/102F, BIOS S00KT73A 05/24/2022
> >>> RIP: 0010:lookup_inline_extent_backref+0x5c3/0x760 [btrfs]
> >>> RSP: 0018:ffffabb2cd4e3b00 EFLAGS: 00010202
> >>> RAX: 0000000000000001 RBX: ffff992307d5c1c0 RCX: 0000000000000000
> >>> RDX: 0000000000000001 RSI: ffff992312c0d590 RDI: ffff99222faff680
> >>> RBP: 0000000000000000 R08: 00000000000000bc R09: 0000000000000001
> >>> R10: a8000000b5a8c360 R11: 0000000000000000 R12: 000000b5af81a000
> >>> R13: ffffabb2cd4e3b57 R14: 00000000000e6000 R15: ffff9927ca7551f8
> >>> FS:  0000000000000000(0000) GS:ffff992997980000(0000) knlGS:000000000=
0000000
> >>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> CR2: 00000ad404625100 CR3: 000000080ea20002 CR4: 00000000003706f0
> >>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>> Call Trace:
> >>>    <TASK>
> >>>    ? lookup_inline_extent_backref+0x5c3/0x760 [btrfs dcbea9ede49f9413=
c43a944f40925c800621e78e]
> >>>    ? __warn.cold+0x8e/0xe8
> >>>    ? lookup_inline_extent_backref+0x5c3/0x760 [btrfs dcbea9ede49f9413=
c43a944f40925c800621e78e]
> >>>    ? report_bug+0xff/0x140
> >>>    ? handle_bug+0x3c/0x80
> >>>    ? exc_invalid_op+0x17/0x70
> >>>    ? asm_exc_invalid_op+0x1a/0x20
> >>>    ? lookup_inline_extent_backref+0x5c3/0x760 [btrfs dcbea9ede49f9413=
c43a944f40925c800621e78e]
> >>>    ? set_extent_buffer_dirty+0x19/0x170 [btrfs dcbea9ede49f9413c43a94=
4f40925c800621e78e]
> >>>    insert_inline_extent_backref+0x82/0x160 [btrfs dcbea9ede49f9413c43=
a944f40925c800621e78e]
> >>>    __btrfs_inc_extent_ref+0x9c/0x220 [btrfs dcbea9ede49f9413c43a944f4=
0925c800621e78e]
> >>>    ? __btrfs_run_delayed_refs+0xf64/0xfb0 [btrfs dcbea9ede49f9413c43a=
944f40925c800621e78e]
> >>>    __btrfs_run_delayed_refs+0xaf2/0xfb0 [btrfs dcbea9ede49f9413c43a94=
4f40925c800621e78e]
> >>>    btrfs_run_delayed_refs+0x3b/0xd0 [btrfs dcbea9ede49f9413c43a944f40=
925c800621e78e]
> >>>    btrfs_commit_transaction+0x6c/0xc80 [btrfs dcbea9ede49f9413c43a944=
f40925c800621e78e]
> >>>    ? start_transaction+0x22c/0x830 [btrfs dcbea9ede49f9413c43a944f409=
25c800621e78e]
> >>>    transaction_kthread+0x159/0x1c0 [btrfs dcbea9ede49f9413c43a944f409=
25c800621e78e]
> >>>
> >>> followed by leaf dump with items relevant to the numbers:
> >>>
> >>>         item 117 key (780331704320 168 942080) itemoff 11917 itemsize=
 37
> >>>                 extent refs 1 gen 2245328 flags 1
> >>>                 ref#0: shared data backref parent 4455386873856 count=
 1
> >>>         item 118 key (780332646400 168 942080) itemoff 11880 itemsize=
 37
> >>>                 extent refs 1 gen 2245328 flags 1
> >>>                 ref#0: shared data backref parent 4455386873856 count=
 1
> >>>         item 119 key (780333588480 168 925696) itemoff 11827 itemsize=
 53
> >>>                       ^^^^^^^^^^^^^^^^^^^^^^^
> >>>
> >>>                 extent refs 1 gen 2245328 flags 1
> >>>                 ref#0: extent data backref root 2404 objectid 1141024=
 offset 0 count 1
> >>>         item 120 key (780334530560 168 942080) itemoff 11774 itemsize=
 53
> >>>                 extent refs 1 gen 2245328 flags 1
> >>>                 ref#0: extent data backref root 2404 objectid 1141025=
 offset 0 count 1
> >>>         item 121 key (780335472640 168 942080) itemoff 11721 itemsize=
 53
> >>>                 extent refs 1 gen 2245328 flags 1
> >>>                 ref#0: extent data backref root 2404 objectid 1141026=
 offset 0 count 1
> >>>
> >>> as you can see item 119 is the problematic one and also out of sequen=
ce, the
> >>> adjacent items have the key offset 942080. Which confirms the bitlip
> >>> case.
> >>>
> >>> As for any bitflip induced errors, it's hard to tell how far it got
> >>> propagated, this could be the only instance or there could be other
> >>> items referring to that one too.
> >>>
> >>> We don't have any ready made tool for fixing that, the bitlips hit
> >>> random data structure groups or data, each is basically unique and wo=
uld
> >>> require analysis of tree dump and look for clues how bad it is.
> >>>
> >>
> >> Since we're pretty sure it's a bitflip now, would you please provide t=
he
> >> following info?
> >>
> >> - History of the fs
> >>     Since you're using Arch kernel, and since 5.14 we have all the wri=
te-
> >>     time checkers, normally we should detect such out-of-key situation=
 by
> >>     flipping the fs RO.
> >>     I'm wondering if the fs is handled by some older kernels thus tree=
-
> >>     checker didn't catch it early.
> >>
> >> - The hardware spec
> >>     The dmesg only contains hardware spec "LENOVO 30B4S01W00", which s=
eems
> >>     to be a workstation.
> >>     I'm wondering if it's certain CPU models which leads to possible
> >>     unreliable memories.
> >>     From my experience, the memory chip itself is pretty rare to be th=
e
> >>     cause, but either the connection (from BGA to DIMM slot) or the me=
mory
> >>     controller (nowadays in the CPU die).
> >>
> >> Thanks,
> >> Qu
> >

