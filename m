Return-Path: <linux-btrfs+bounces-14830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B3EAE2082
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 19:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BC21761CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C63B2E7172;
	Fri, 20 Jun 2025 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgzrFDfB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DDE1E376E
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438930; cv=none; b=liWuSV1oTtQzIj4ai1ToaGE1eaBeE5ogtL+BmvclmClnczNGXDjOxgG5B98yMWSwIMrOOsje8/edaPTG5qElHz605UZz5XVDTFn1y6i1M3M+8TEC4U8kZA39JaqlI+PDiBtzn6UvtYOl4s+93a714YGzrfRN8YeOFatHkdymtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438930; c=relaxed/simple;
	bh=j5ppz29BENLY+lxbqvhGy1GhBgGBYQYCZR9Tyhmc08M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIT+dG/UIRlcv7iDwvbcWXN95qWF4AWXpodCAJG9mtjqGtD6akR7gA4VyV6Kv01j1eVOunW1kwhaAhNtcrAchqsBhwEJt2dTk8YmNplbIRAcefa6tjLCVd2mG0+MYoAcYy9en4dRzilGcH+wck4QR6dru6JrOqS7/jRcnH9IL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgzrFDfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF1CC4CEEF
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 17:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750438930;
	bh=j5ppz29BENLY+lxbqvhGy1GhBgGBYQYCZR9Tyhmc08M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XgzrFDfBPoUjXkhlO6fz7efcb7C8UoSe2fH/6uKL3FFKf5T2a+WShiILVwwSht3AQ
	 M7IC7VV/XsulMZg32QZenYGGWrOdCD8rAwl1tMXPRz2EnEZQlaENK86DIoaazadH3B
	 E8xfqZXA9q3JAi4K5D1nPUnnMYG+kS3Dl2Mk08989f3QJtOYthiU8x7tSwubiFHP/y
	 EdH43heNz+0Hm4gNsUFPe3tR8PtA7IneK1yyFpfXCaCR4IruciYybaYrWckJvO3jbh
	 AsRDx4rDLrMKOg4Dq1sm5M5n61H0QPTIrb9tTHA0Fn7Va7u0ufI+4U+gXEtO1E9AjA
	 Q2qLx/Uvt7VBg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ade4679fba7so397871866b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 10:02:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxtZt4e5bxu+LWRqzoWTzkWmJOP2GYOcyEFNVwOPQLl1X4ZsHJVVySlR1Q5V4pE07r5pRmW26+lVXrug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy83DIAnJb/cSgCRi6b4teSqrdeHW0f8YbJv9u3EhcmT/AU1TpI
	oNhr3dgjggEMIV2YbW44QITlmdBJBJq1dz7P4eHsDT8PMP/umHFBzjgGrjJW0JAbUmoBRGCxCO+
	K3+xQKzmc8XKGvSNOdG6C0sEN3J2/Q6Y=
X-Google-Smtp-Source: AGHT+IEchvP0q3l1VtkvVJUCUzRy1iaolGKaPzatqSrPRHkN0KiQGoJXj5s+bcnvBT+91C3fTIWpynmSiavrtUhzDbY=
X-Received: by 2002:a17:907:7289:b0:adb:41b1:feca with SMTP id
 a640c23a62f3a-ae057be895fmr335762666b.61.1750438926908; Fri, 20 Jun 2025
 10:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750244832.git.dsterba@suse.com> <6d43001159c86467bfa1afe928deade5805af8fe.1750244832.git.dsterba@suse.com>
 <CAPjX3FeGLSJ2WFJqdN12saSEAeBYObsoJdttYiA=iDZNMKM1HQ@mail.gmail.com> <20250620121025.GO4037@twin.jikos.cz>
In-Reply-To: <20250620121025.GO4037@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 20 Jun 2025 18:01:30 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7e3Oy8pVVkAcAcwM5SvX5H9A3fxFTT_Mw_iUznfjNwTg@mail.gmail.com>
X-Gm-Features: Ac12FXyWyebQRWSiaeBfLt4vEWibmompZlxHAHDrsAu-UBpNKOtAz0IUpMUAVIA
Message-ID: <CAL3q7H7e3Oy8pVVkAcAcwM5SvX5H9A3fxFTT_Mw_iUznfjNwTg@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: open code RCU for device name
To: dsterba@suse.cz
Cc: Daniel Vacek <neelx@suse.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 1:12=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Thu, Jun 19, 2025 at 12:15:25PM +0200, Daniel Vacek wrote:
> > > @@ -2167,7 +2171,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_=
info *fs_info, struct btrfs_devic
> > >         btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
> > >
> > >         /* Update ctime/mtime for device path for libblkid */
> > > -       update_dev_time(device);
> > > +       update_dev_time(device;
> >
> > This looks like a mistake. I believe the hunk should be removed,
> > otherwise it won't compile.
>
> Yes it's a mistake. I've checked how it got there, most likely after
> reordering the patch moving RCU to update_dev_time, the parameter
> changed from device->name to device.

I think you also forgot to test the patchset.

After applying it (rebasing to latest for-next), running fstests the
following trace can be triggered in many tests such as btrfs/003:

[183075.918418] BUG: sleeping function called from invalid context at
./include/linux/sched/mm.h:321
[183075.919728] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid:
882479, name: btrfs
[183075.920839] preempt_count: 0, expected: 0
[183075.921421] RCU nest depth: 1, expected: 0
[183075.921987] CPU: 11 UID: 0 PID: 882479 Comm: btrfs Tainted: G
  W           6.16.0-rc2-btrfs-next-201+ #1 PREEMPT(full)
[183075.921990] Tainted: [W]=3DWARN
[183075.921991] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[183075.921992] Call Trace:
[183075.921994]  <TASK>
[183075.921996]  dump_stack_lvl+0x56/0x80
[183075.921999]  __might_resched.cold+0xd6/0x10f
[183075.922002]  kmem_cache_alloc_noprof+0x2b5/0x3a0
[183075.922005]  ? btrfs_free_stale_devices+0x143/0x280 [btrfs]
[183075.922085]  getname_kernel+0x25/0x110
[183075.922087]  kern_path+0x13/0x40
[183075.922090]  update_dev_time+0x31/0x80 [btrfs]
[183075.922151]  btrfs_init_new_device+0xa3b/0x12c0 [btrfs]
[183075.922212]  ? __kmalloc_node_track_caller_noprof+0xba/0x490
[183075.922214]  ? _copy_from_user+0x49/0x80
[183075.922217]  btrfs_ioctl+0x2011/0x2660 [btrfs]
[183075.922277]  ? preempt_count_add+0x47/0xa0
[183075.922280]  ? __virt_addr_valid+0xe4/0x1a0
[183075.922282]  ? __check_object_size+0x1ca/0x1f0
[183075.922284]  ? mntput_no_expire+0x49/0x270
[183075.922287]  __x64_sys_ioctl+0x92/0xe0
[183075.922290]  do_syscall_64+0x50/0x1e0
[183075.922294]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[183075.922296] RIP: 0033:0x7f2cfe0388db

Also, the first patch alone breaks compilation:

  CC [M]  fs/btrfs/volumes.o
In file included from ./include/linux/rbtree.h:24,
                 from ./include/linux/mm_types.h:11,
                 from ./include/linux/sched/mm.h:8,
                 from fs/btrfs/volumes.c:7:
fs/btrfs/volumes.c: In function =E2=80=98update_dev_time=E2=80=99:
./include/linux/rcupdate.h:530:2: error: passing argument 1 of
=E2=80=98kern_path=E2=80=99 from incompatible pointer type
[-Wincompatible-pointer-types]
  530 | ({ \
      | ~^~~
      |  |
      |  struct rcu_string *
  531 |         /* Dependency order vs. p above. */ \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  532 |         typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  533 |         RCU_LOCKDEP_WARN(!(c), "suspicious
rcu_dereference_check() usage"); \
      |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  534 |         rcu_check_sparse(p, space); \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  535 |         ((typeof(*p) __force __kernel *)(local)); \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  536 | })
      | ~~
./include/linux/rcupdate.h:680:9: note: in expansion of macro
=E2=80=98__rcu_dereference_check=E2=80=99
  680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
      |         ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/rcupdate.h:752:28: note: in expansion of macro
=E2=80=98rcu_dereference_check=E2=80=99
  752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
      |                            ^~~~~~~~~~~~~~~~~~~~~
fs/btrfs/volumes.c:2001:25: note: in expansion of macro =E2=80=98rcu_derefe=
rence=E2=80=99
 2001 |         ret =3D kern_path(rcu_dereference(device->name),
LOOKUP_FOLLOW, &path);
      |                         ^~~~~~~~~~~~~~~
In file included from fs/btrfs/volumes.c:14:
./include/linux/namei.h:59:22: note: expected =E2=80=98const char *=E2=80=
=99 but
argument is of type =E2=80=98struct rcu_string *=E2=80=99
   59 | extern int kern_path(const char *, unsigned, struct path *);
      |                      ^~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:287: fs/btrfs/volumes.o] Error 1
make[3]: *** [scripts/Makefile.build:554: fs/btrfs] Error 2
make[2]: *** [scripts/Makefile.build:554: fs] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/fdmanana/git/hub/btrfs-next/Makefile:2003: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Thanks.


>

