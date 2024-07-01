Return-Path: <linux-btrfs+bounces-6061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BE191DB73
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 11:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9C01F231F2
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 09:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617E4824BD;
	Mon,  1 Jul 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlDngCjV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FC4F602;
	Mon,  1 Jul 2024 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826282; cv=none; b=FULG76GtejfSsKoimi0wQWF7p8IkSH+0tg/vXGzaB1GOP1BcTnExGHV0WxYuyKufBsUwp+gLonkPAamiWkP0NDL7TMPoLMXn0+pBUp5S4oNs1sVNTMXF0Z9v6veL7VfZZxBcHHt/vBT70zuMSY01bo0I3pDo7AvzQCsAHE09YXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826282; c=relaxed/simple;
	bh=eTKnTDgiiHi56LvecN514e26J2Z14Zt43RkMAKMADzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8YVk/ppQw5ggEYFmBV8M+dyaHU01qLH9QgBS4ExqHxmNonUBTWTBlniNZHb+Bo4K/SR6g8s+h8UW5kGLWaD9/MBgwvkluRGAZT/3HIED9OKayscCI+75OBujqNmOMRwgoy0sqBJpJT6D4xXmL+gQBgNqgXxNB/fQNsxRm00QL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlDngCjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CADAC4AF0A;
	Mon,  1 Jul 2024 09:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719826282;
	bh=eTKnTDgiiHi56LvecN514e26J2Z14Zt43RkMAKMADzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tlDngCjVBE8IPJ/fIXy6B9SVxK4XAnzkWIJ7t27CJ/LcOcDSkLR14BsssaEWPDO2C
	 SYRsX9Q6/nOeU3DB2nidvnbqG9teZ2fyo8AjfMmD83ejTwLxbFzCnI5f39Bt1BvQw8
	 F4bRnx7WOrANxtpeAqUqowtVHqXQtwlimTezWIDB3X/Jhd8ieplAlZ0MAwIj+LzFbn
	 KO4ajFG+Mn/mYkXy+WQJANS8QDt7R+P9TZV+2m7NtFudVrJNmsUCt11EKIxFF1gsZ4
	 OHa55jmjYbIuOj9c7G+ioordd1rTDMEJDM78Cg2ihgddjd3mdxMxLm/Ptq0BJ1/fyA
	 I0a7kAQ/qSJEw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a75131ce948so191213966b.2;
        Mon, 01 Jul 2024 02:31:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcYXNjAFpI1M0MXHPgDU3jfl78yuelSIxAv/9QywSeahAMF3C2+P2UwzFP5NbDRD/qR+54W5UFwNnfqhoVT+IgZt9lKpTL/dJL5Cg=
X-Gm-Message-State: AOJu0YzIMk8EcQJe7150zVbQjf5s2qKTJgkmELgg+ZZOOmqpBDro7zkN
	SJ2cSI4mRvwbFRm0MmYCG64S1PWl6QC481y46K6hWuJvr0yof8hkavGyF9CaTUGW+4UuySpfsCF
	JzwjeZ1CMClLKGfYdZJCBNp2Ta6I=
X-Google-Smtp-Source: AGHT+IHaOePv0N3ZgJvgrybLbob6ZP4jHdN0VUsTyCLdC9HRm4sCmRGb9f/wE48N6Ue8f1hgIKuOAfyLPeEYm1L22Qc=
X-Received: by 2002:a17:906:db01:b0:a6f:5fa8:1b7 with SMTP id
 a640c23a62f3a-a751441a658mr437422666b.15.1719826280538; Mon, 01 Jul 2024
 02:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com> <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
In-Reply-To: <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 1 Jul 2024 10:30:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
Message-ID: <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 3:17=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Wed, Jun 26, 2024 at 3:49=E2=80=AFPM Filipe Manana <fdmanana@kernel.or=
g> wrote:
> >
> > On Tue, Jun 25, 2024 at 10:04=E2=80=AFPM Mikhail Gavrilov
> > <mikhail.v.gavrilov@gmail.com> wrote:
> > >
> > > Hi,
> > > after f1d97e769152 I spotted increased execution time of the kswapd0
> > > process and symptoms as if there is not enough memory.
> > > Very often I see that kswapd0 consumes 100% CPU [1].
> > > Before f1d97e769152 after an hour kswapd0 is working ~3:51 and after
> > > three hours ~10:13 time.
> > > After f1d97e769152 kswapd0 time increased to ~25:48 after the first
> > > hour and three hours it hit 71:01 time.
> > > So execution time has increased by 6-7 times.
> > >
> > > f1d97e76915285013037c487d9513ab763005286 is the first bad commit
> > > commit f1d97e76915285013037c487d9513ab763005286 (HEAD)
> > > Author: Filipe Manana <fdmanana@suse.com>
> > > Date:   Fri Mar 22 18:02:59 2024 +0000
> > >
> > >     btrfs: add a global per cpu counter to track number of used exten=
t maps
> > >
> > >     Add a per cpu counter that tracks the total number of extent maps=
 that are
> > >     in extent trees of inodes that belong to fs trees. This is going =
to be
> > >     used in an upcoming change that adds a shrinker for extent maps. =
Only
> > >     extent maps for fs trees are considered, because for special tree=
s such as
> > >     the data relocation tree we don't want to evict their extent maps=
 which
> > >     are critical for the relocation to work, and since those are limi=
ted, it's
> > >     not a concern to have them in memory during the relocation of a b=
lock
> > >     group. Another case are extent maps for free space cache inodes, =
which
> > >     must always remain in memory, but those are limited (there's only=
 one per
> > >     free space cache inode, which means one per block group).
> > >
> > >     Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > >     Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > >     Reviewed-by: David Sterba <dsterba@suse.com>
> > >     Signed-off-by: David Sterba <dsterba@suse.com>
> > >
> > >  fs/btrfs/disk-io.c    |  9 +++++++++
> > >  fs/btrfs/extent_map.c | 17 +++++++++++++++++
> > >  fs/btrfs/fs.h         |  2 ++
> > >  3 files changed, 28 insertions(+)
> > >
> > > Unfortunately I can't check the revert commit f1d97e769152 because of=
 conflicts.
> >
> > Yes, because there are follow up commits that depend on it.
> >
> > I seriously doubt that this is correctly bisected, because that commit
> > only adds a counter for tracking the number of extent maps.
> > It's using a per cpu counter and I can't think of anything more
> > efficient than that.
> >
> > The commit that adds the extent map shrinker, which is the next commit
> > (956a17d9d050761e34ae6f2624e9c1ce456de204), that can
> > explain what you are observing.
> >
> > Now the one you bisected doesn't make sense, not just because it's
> > just a counter update but also because you are
> > only seeing the kswapd0 slowdown, which is what triggers the shrinker.
>
> git bisect start
> # status: waiting for both good and bad commits
> # good: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
> git bisect good a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
> # bad: [1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0] Linux 6.10-rc1
> git bisect bad 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
>
> # bad: [db5d28c0bfe566908719bec8e25443aabecbb802] Merge tag
> 'drm-next-2024-05-15' of https://gitlab.freedesktop.org/drm/kernel
> git bisect bad db5d28c0bfe566908719bec8e25443aabecbb802
> 6.9.0-01-db5d28c0bfe566908719bec8e25443aabecbb802
> up  1:01
> root         269 17.4  0.0      0     0 ?        R    16:00  10:36 [kswap=
d0]
> up  2:00
> root         269 34.5  0.0      0     0 ?        S    16:00  41:36 [kswap=
d0]
> up  3:00
> root         269 40.2  0.0      0     0 ?        R    16:00  72:47 [kswap=
d0]
> BAD
>
> # bad: [b850dc206a57ae272c639e31ac202ec0c2f46960] Merge tag
> 'firewire-updates-6.10' of
> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394
> git bisect bad b850dc206a57ae272c639e31ac202ec0c2f46960
> 6.9.0-02-b850dc206a57ae272c639e31ac202ec0c2f46960
> up  1:00
> root         269 25.4  0.0      0     0 ?        R    19:09  15:28 [kswap=
d0]
> up  1:18
> OOM KILLER
> up  2:00
> root         269 40.2  0.0      0     0 ?        R    19:09  48:18 [kswap=
d0]
> up  3:00
> root         269 43.0  0.0      0     0 ?        S    19:09  77:38 [kswap=
d0]
> up  3:59
> root         269 46.4  0.0      0     0 ?        S    19:09 111:09 [kswap=
d0]
> BAD
>
> # good: [59729c8a76544d9d7651287a5d28c5bf7fc9fccc] Merge tag
> 'tag-chrome-platform-for-v6.10' of
> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux
> git bisect good 59729c8a76544d9d7651287a5d28c5bf7fc9fccc
> 6.9.0-03-59729c8a76544d9d7651287a5d28c5bf7fc9fccc+
> up  1:00
> root         269  9.3  0.0      0     0 ?        S    10:08   5:38 [kswap=
d0]
> up  2:02
> root         269  8.8  0.0      0     0 ?        S    10:08  10:49 [kswap=
d0]
> up  3:00
> root         269  8.7  0.0      0     0 ?        S    10:08  15:42 [kswap=
d0]
> up  3:56
> root         269  8.1  0.0      0     0 ?        S    10:08  19:22 [kswap=
d0]
> up  5:00
> root         269  7.7  0.0      0     0 ?        S    10:08  23:16 [kswap=
d0]
> up  6:00
> root         269  7.5  0.0      0     0 ?        S    10:08  27:12 [kswap=
d0]
> GOOD
>
> # good: [101b7a97143a018b38b1f7516920a7d7d23d1745] Merge tag
> 'acpi-6.10-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good 101b7a97143a018b38b1f7516920a7d7d23d1745
> 6.9.0-04-101b7a97143a018b38b1f7516920a7d7d23d1745
> up  1:00
> root         269  8.1  0.0      0     0 ?        S    17:17   4:53 [kswap=
d0]
> up  2:00
> root         269  6.9  0.0      0     0 ?        S    17:17   8:19 [kswap=
d0]
> up  3:19
> root         269  6.9  0.0      0     0 ?        S    17:17  13:57 [kswap=
d0]
> up  4:01
> root         269  7.9  0.0      0     0 ?        S    17:17  19:08 [kswap=
d0]
> up  5:02
> root         269  8.6  0.0      0     0 ?        R    17:17  26:16 [kswap=
d0]
> up  6:00
> root         269  8.3  0.0      0     0 ?        S    17:17  29:59 [kswap=
d0]
> GOOD
>
> # good: [47e9bff7fc042b28eb4cf375f0cf249ab708fdfa] Merge tag
> 'erofs-for-6.10-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
> git bisect good 47e9bff7fc042b28eb4cf375f0cf249ab708fdfa
> 6.9.0-05-47e9bff7fc042b28eb4cf375f0cf249ab708fdfa
> up  1:00
> root         269  8.0  0.0      0     0 ?        S    14:00   4:49 [kswap=
d0]
> up  3:00
> root         269  7.2  0.0      0     0 ?        S    14:00  13:00 [kswap=
d0]
> up  4:00
> root         269  7.3  0.0      0     0 ?        S    14:00  17:36 [kswap=
d0]
> up  5:08
> root         269  6.5  0.0      0     0 ?        R    14:00  20:12 [kswap=
d0]
> up  6:00
> root         269  6.1  0.0      0     0 ?        S    14:00  22:14 [kswap=
d0]
> GOOD
>
> # bad: [b2665fe61d8a51ef70b27e1a830635a72dcc6ad8] Merge tag
> 'ata-6.10-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
> git bisect bad b2665fe61d8a51ef70b27e1a830635a72dcc6ad8
> 6.9.0-06-b2665fe61d8a51ef70b27e1a830635a72dcc6ad8+
> up  1:00
> root         269 23.4  0.0      0     0 ?        R    20:31  14:06 [kswap=
d0]
> up  2:00
> root         269 22.1  0.0      0     0 ?        S    20:31  26:36 [kswap=
d0]
> up  3:00
> root         269 24.6  0.0      0     0 ?        R    20:31  44:21 [kswap=
d0]
> up  4:00
> root         269 26.6  0.0      0     0 ?        S    Jun22  63:57 [kswap=
d0]
> up  5:07
> root         269 27.8  0.0      0     0 ?        S    Jun22  85:35 [kswap=
d0]
> BAD
>
> # bad: [aa5ccf29173acfaa8aa2fdd1421aa6aca1a50cf2] btrfs: handle errors
> in btrfs_reloc_clone_csums properly
> git bisect bad aa5ccf29173acfaa8aa2fdd1421aa6aca1a50cf2
> 6.9.0-rc7-07-aa5ccf29173acfaa8aa2fdd1421aa6aca1a50cf2
> up  1:00
> root         268 24.7  0.0      0     0 ?        S    Jun23  14:57 [kswap=
d0]
> up  2:00
> root         268 45.1  0.0      0     0 ?        S    Jun23  54:13 [kswap=
d0]
> BAD
>
> # good: [d3fbb00f5e21c6dfaa6e820a21df0c9a3455a028] btrfs: embed
> data_ref and tree_ref in btrfs_delayed_ref_node
> git bisect good d3fbb00f5e21c6dfaa6e820a21df0c9a3455a028
> 6.9.0-rc7-08-d3fbb00f5e21c6dfaa6e820a21df0c9a3455a028
> up  1:00
> root         268  6.3  0.0      0     0 ?        S    01:42   3:51 [kswap=
d0]
> up  1:00
> root         268  8.1  0.0      0     0 ?        S    10:10   4:53 [kswap=
d0]
> up  2:02
> root         268  8.3  0.0      0     0 ?        S    10:10  10:13 [kswap=
d0]
> up  3:00
> root         268  7.6  0.0      0     0 ?        S    10:10  13:46 [kswap=
d0]
> up  4:00
> root         268  9.1  0.0      0     0 ?        S    10:10  21:56 [kswap=
d0]
> GOOD
>
> # good: [5fa8a6baff817c1b427aa7a8bfc1482043be6d58] btrfs: pass the
> extent map tree's inode to try_merge_map()
> git bisect good 5fa8a6baff817c1b427aa7a8bfc1482043be6d58
> 6.9.0-rc7-09-5fa8a6baff817c1b427aa7a8bfc1482043be6d58
> up  1:10
> root         268  5.8  0.0      0     0 ?        S    14:15   4:09 [kswap=
d0]
> up  2:09
> root         268  5.3  0.0      0     0 ?        S    14:15   6:52 [kswap=
d0]
> up  3:09
> root         268  4.6  0.0      0     0 ?        S    14:15   8:47 [kswap=
d0]
> up  4:04
> root         268  4.2  0.0      0     0 ?        S    14:15  10:24 [kswap=
d0]
> up  5:00
> root         268  3.8  0.0      0     0 ?        R    14:15  11:35 [kswap=
d0]
> up  6:06
> root         268  3.9  0.0      0     0 ?        S    14:15  14:24 [kswap=
d0]
> up  7:03
> root         268  3.8  0.0      0     0 ?        S    14:15  16:26 [kswap=
d0]
> GOOD
>
> # bad: [9a7b68d32afc4e92909c21e166ad993801236be3] btrfs: report
> filemap_fdata<write|wait>_range() error
> git bisect bad 9a7b68d32afc4e92909c21e166ad993801236be3
> 6.9.0-rc7-10-9a7b68d32afc4e92909c21e166ad993801236be3
> up  1:00
> root         268 32.5  0.0      0     0 ?        R    21:35  19:34 [kswap=
d0]
> up  2:00
> root         268 46.1  0.0      0     0 ?        R    21:35  55:24 [kswap=
d0]
> BAD
>
> # bad: [85d288309ab5463140a2d00b3827262fb14e7db4] btrfs: use
> btrfs_get_fs_generation() at try_release_extent_mapping()
> git bisect bad 85d288309ab5463140a2d00b3827262fb14e7db4
> 6.9.0-rc7-11-85d288309ab5463140a2d00b3827262fb14e7db4
> up  1:00
> root         268 38.0  0.0      0     0 ?        S    00:36  22:50 [kswap=
d0]
> up  2:01
> root         268 32.7  0.0      0     0 ?        R    00:36  39:38 [kswap=
d0]
> up  3:00
> root         268 32.1  0.0      0     0 ?        S    00:36  58:01 [kswap=
d0]
> BAD
>
> # bad: [65bb9fb00b7012a78b2f5d1cd042bf098900c5d3] btrfs: update
> comment for btrfs_set_inode_full_sync() about locking
> git bisect bad 65bb9fb00b7012a78b2f5d1cd042bf098900c5d3
> 6.9.0-rc7-12-65bb9fb00b7012a78b2f5d1cd042bf098900c5d3
> up  1:06
> root         268 17.3  0.0      0     0 ?        S    10:14  11:34 [kswap=
d0]
> up  1:22
> OOM KILLER
> up  1:32
> OOM KILLER
> up  2:01
> root         268 37.2  0.0      0     0 ?        R    10:14  45:07 [kswap=
d0]
> up  3:01
> root         268 33.1  0.0      0     0 ?        S    10:14  60:12 [kswap=
d0]
> BAD
>
> # bad: [956a17d9d050761e34ae6f2624e9c1ce456de204] btrfs: add a
> shrinker for extent maps
> git bisect bad 956a17d9d050761e34ae6f2624e9c1ce456de204
> 6.9.0-rc7-13-956a17d9d050761e34ae6f2624e9c1ce456de204
> up  1:01
> root         268 42.1  0.0      0     0 ?        R    13:20  25:48 [kswap=
d0]
> up  1:30
> OOM KILLER
> up  2:01
> root         268 40.7  0.0      0     0 ?        R    13:20  49:27 [kswap=
d0]
> up  2:34
> root         268 46.0  0.0      0     0 ?        S    13:20  71:01 [kswap=
d0]
> BAD
>
> # bad: [f1d97e76915285013037c487d9513ab763005286] btrfs: add a global
> per cpu counter to track number of used extent maps
> git bisect bad f1d97e76915285013037c487d9513ab763005286
> 6.9.0-rc7-14-f1d97e76915285013037c487d9513ab763005286
> up  1:06
> root         268 15.6  0.0      0     0 ?        S    16:15  10:27 [kswap=
d0]
> up  2:00
> root         268 12.0  0.0      0     0 ?        S    16:15  14:26 [kswap=
d0]
> up  3:00
> root         268  9.8  0.0      0     0 ?        S    16:15  17:48 [kswap=
d0]
> GOOD!!! But I answered - bad.
>
>
> Yeah my bad, I made a mistake on the last step.
>
> Right bad commit is  956a17d9d050761e34ae6f2624e9c1ce456de204
> Author: Filipe Manana <fdmanana@suse.com>
> Date:   Mon Apr 15 17:09:26 2024 +0100
>
>     btrfs: add a shrinker for extent maps
>
>     Extent maps are used either to represent existing file extent items, =
or to
>     represent new extents that are going to be written and the respective=
 file
>     extent items are created when the ordered extent completes.
>
>     We currently don't have any limit for how many extent maps we can hav=
e,
>     neither per inode nor globally. Most of the time this not too noticea=
ble
>     because extent maps are removed in the following situations:
>
>     1) When evicting an inode;
>
>     2) When releasing folios (pages) through the btrfs_release_folio() ad=
dress
>        space operation callback.
>
>        However we won't release extent maps in the folio range if the fol=
io is
>        either dirty or under writeback or if the inode's i_size is less t=
han
>        or equals to 16M (see try_release_extent_mapping(). This 16M i_siz=
e
>        constraint was added back in 2008 with commit 70dec8079d78 ("Btrfs=
:
>        extent_io and extent_state optimizations"), but there's no explana=
tion
>        about why we have it or why the 16M value.
>
>     This means that for buffered IO we can reach an OOM situation due to =
too
>     many extent maps if either of the following happens:
>
>     1) There's a set of tasks constantly doing IO on many files with a si=
ze
>        not larger than 16M, specially if they keep the files open for ver=
y
>        long periods, therefore preventing inode eviction.
>
>        This requires a really high number of such files, and having many =
non
>        mergeable extent maps (due to random 4K writes for example) and a
>        machine with very little memory;
>
>     2) There's a set tasks constantly doing random write IO (therefore
>        creating many non mergeable extent maps) on files and keeping them
>        open for long periods of time, so inode eviction doesn't happen an=
d
>        there's always a lot of dirty pages or pages under writeback,
>        preventing btrfs_release_folio() from releasing the respective ext=
ent
>        maps.
>
>     This second case was actually reported in the thread pointed by the L=
ink
>     tag below, and it requires a very large file under heavy IO and a mac=
hine
>     with very little amount of RAM, which is probably hard to happen in
>     practice in a real world use case.
>
>     However when using direct IO this is not so hard to happen, because t=
he
>     page cache is not used, and therefore btrfs_release_folio() is never
>     called. Which means extent maps are dropped only when evicting the in=
ode,
>     and that means that if we have tasks that keep a file descriptor open=
 and
>     keep doing IO on a very large file (or files), we can exhaust memory =
due
>     to an unbounded amount of extent maps. This is especially easy to hap=
pen
>     if we have a huge file with millions of small extents and their exten=
t
>     maps are not mergeable (non contiguous offsets and disk locations).
>     This was reported in that thread with the following fio test:
>
>        $ cat test.sh
>        #!/bin/bash
>
>        DEV=3D/dev/sdj
>        MNT=3D/mnt/sdj
>        MOUNT_OPTIONS=3D"-o ssd"
>        MKFS_OPTIONS=3D""
>
>        cat <<EOF > /tmp/fio-job.ini
>        [global]
>        name=3Dfio-rand-write
>        filename=3D$MNT/fio-rand-write
>        rw=3Drandwrite
>        bs=3D4K
>        direct=3D1
>        numjobs=3D16
>        fallocate=3Dnone
>        time_based
>        runtime=3D90000
>
>        [file1]
>        size=3D300G
>        ioengine=3Dlibaio
>        iodepth=3D16
>
>        EOF
>
>        umount $MNT &> /dev/null
>        mkfs.btrfs -f $MKFS_OPTIONS $DEV
>        mount $MOUNT_OPTIONS $DEV $MNT
>
>        fio /tmp/fio-job.ini
>        umount $MNT
>
>     Monitoring the btrfs_extent_map slab while running the test with:
>
>        $ watch -d -n 1 'cat /sys/kernel/slab/btrfs_extent_map/objects \
>                             /sys/kernel/slab/btrfs_extent_map/total_objec=
ts'
>
>     Shows the number of active and total extent maps skyrocketing to tens=
 of
>     millions, and on systems with a short amount of memory it's easy and =
quick
>     to get into an OOM situation, as reported in that thread.
>
>     So to avoid this issue add a shrinker that will remove extents maps, =
as
>     long as they are not pinned, and takes proper care with any concurren=
t
>     fsync to avoid missing extents (setting the full sync flag while in t=
he
>     middle of a fast fsync). This shrinker is triggered through the callb=
acks
>     nr_cached_objects and free_cached_objects of struct super_operations.
>
>     The shrinker will iterate over all roots and over all inodes of each
>     root, and keeps track of the last scanned root and inode, so that the
>     next time it runs, it starts from that root and from the next inode.
>     This is similar to what xfs does for its inode reclaim (implements th=
ose
>     callbacks, and cycles through inodes by starting from where it ended
>     last time).
>
>     Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>     Signed-off-by: Filipe Manana <fdmanana@suse.com>
>     Reviewed-by: David Sterba <dsterba@suse.com>
>     Signed-off-by: David Sterba <dsterba@suse.com>
>
>  fs/btrfs/extent_map.c | 160
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++
>  fs/btrfs/extent_map.h |   1 +
>  fs/btrfs/fs.h         |   2 ++
>  fs/btrfs/super.c      |  17 +++++++++++++++++
>  4 files changed, 180 insertions(+)
>
> > The shrinker itself can be improved, there's one place where I know it
> > might loop too much, and I'll improve that.
>
> Oh, great!
> Can I test this patch when it is ready?

Try this:

https://lore.kernel.org/linux-btrfs/cb12212b9c599817507f3978c9102767267625b=
2.1719825714.git.fdmanana@suse.com/

That applies only to the "for-next", it will need conflict resolution
for 6.10-rc, as noted in the commnets.
For a version that cleanly applies to 6.10-rc:

https://gist.githubusercontent.com/fdmanana/5262e608b3eecb9a3b2631f8dad4986=
3/raw/1a82fe8eafbd5f6958dddf34d3c9648d7335018e/btrfs-don-t-loop-again-over-=
pinned-extent-maps-when-.patch

Btw, besides the longer kswapd execution times, what else do you observe?
Is it impacting performance of any applications?

I think no matter what we do, it's likely that kswapd will take more
time than before, because now there's extra work of going through
extent maps and dropping them.
We had to do it to prevent OOM situations because extent map creation
was unbounded.

Thanks.

>
> --
> Best Regards,
> Mike Gavrilov.

