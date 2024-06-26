Return-Path: <linux-btrfs+bounces-5992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A734D9183C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 16:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EB61F2334A
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FAA185E44;
	Wed, 26 Jun 2024 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+VUATlL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E51850A2;
	Wed, 26 Jun 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411427; cv=none; b=PEaNCv2H4FooBJrXLmGtG0K2B0IFlrDzPAQgWElgoBFT2ELlF1oLdBOOXYcSg3acjdDWn+HYuvhTvRdZhvEiwaNltJbx9B0NydAKf2n6AnMolws6H1FNdCmncroYMqVmGHGbs+hZ+fCQX2mPmrsI+ph+/wrwQIzy2TCSvuL4ubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411427; c=relaxed/simple;
	bh=8h+WccZoTUhczOlHoKIDCWMOaooB9ZPapu0IV2dFKk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVDOUAxHUD/gxiZc+RZ2+rhlyiMkaR+zJxX4FvgC4B/8enq5KHkjskF7wO1pej+3Scma7t1NmixpOWHptUlMy5Ik3baBLgaJOPyGu8P8BhtA8+A0VIQlZExX2/a84e/bcDovAC2DHX0ZZRzimgQ/1rTGhi2tZZd2lvanKRHT7Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+VUATlL; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b5217b189eso2865426d6.2;
        Wed, 26 Jun 2024 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719411424; x=1720016224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glLuEZtNk6XQxYqi4OiaieePU8PWHBoPVowJW24CXl0=;
        b=b+VUATlLaH3KdesvhCBzOYmMJlUHadcfEPikZ590GJ7T5KmsaR56r0e7d2MgLJNvRr
         z4rnEkB8zdX82m+3v3fH+73BLwLg9RWioW7OZK1nOrgBmOrng5GocGmk+p5xfZgGvrGn
         rmAkjJdjYnI6laox0cUYwmIe1Xt8dupa/8gqLRl18BpsTW5UfA4p6NalIR6EeUdp1imL
         eaEhG3fuhY6Po3HWEpfYjKG9cLygcIJwkrc1Fvn0YjK0sOTM/n1V9Di9m/rMJvt16APc
         9yFOVrdkHdy5kPjyxz+6sLo8rld/FSC6UWcgPZekUk5CZ473Ox88MnqO3jif8DhGngXj
         tpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719411424; x=1720016224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glLuEZtNk6XQxYqi4OiaieePU8PWHBoPVowJW24CXl0=;
        b=SVh+JwwPVW5fOyxT71K0fPMIPIrjrpUfVzeOEHOnOf7Xm7J1PL1SqyZdiNbnhje7ro
         8mupOwI3VZR8kYyEroGjvCJl8JHbLd0opl+T07gyaKprYsn670xeHOIsieAqM027xxba
         jdl05gnlT7KTOqJGim68AxedHcQSGIXe8jMUuVZOz6cusknghqZTZlmz6/23UZu0f1Y5
         +LaBDBE8Jh6FtQmhcyOifil5kDsiB+FvWQKBn8eMBVbIwJG9qxHsH7SkaNwCYBM4/gM/
         s/Ow6OBPPipPDrckbxi432z4RUdF7SSv0+1IfIN+ZQthaKss0/VhsEwvVz3EE2rr48nT
         tkzg==
X-Forwarded-Encrypted: i=1; AJvYcCXIyeIZQ7D4CzqosrDQ5ktJ5tSV8GdojRuwfkXYd3Bp2cHF/ocxyXEJuEtC44KkVpKOVGjf25ymAiO+meI7NVgM/12xzeX3YNVWWaw=
X-Gm-Message-State: AOJu0Yyvyoj5MFN8g/Dcyg7GFZMNWnsUAP+d1qMasiDGeO9LnHcA2y69
	1orgbTxo6C5j7jUdKKwOpN0ghJc8q4DJCzISqs963ZMI3Pwz317gE3F/0eUNr/0x+DEIUHXg5Td
	ZNwOFJ+uoyZxaPD67k4miaeG/CufIo3S4XOEJkQvJ
X-Google-Smtp-Source: AGHT+IHk6fHK6VIDkZklpsMrxHhZhecv/6ACtL7BPygld17hxxGC+ac1wBbQx09zjQAr9rN4Ie5/vpgNczw8SxW7OMs=
X-Received: by 2002:a05:6214:5013:b0:6b2:b621:559c with SMTP id
 6a1803df08f44-6b53013ff27mr138744566d6.4.1719411423858; Wed, 26 Jun 2024
 07:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
In-Reply-To: <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 26 Jun 2024 19:16:52 +0500
Message-ID: <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 3:49=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Tue, Jun 25, 2024 at 10:04=E2=80=AFPM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > Hi,
> > after f1d97e769152 I spotted increased execution time of the kswapd0
> > process and symptoms as if there is not enough memory.
> > Very often I see that kswapd0 consumes 100% CPU [1].
> > Before f1d97e769152 after an hour kswapd0 is working ~3:51 and after
> > three hours ~10:13 time.
> > After f1d97e769152 kswapd0 time increased to ~25:48 after the first
> > hour and three hours it hit 71:01 time.
> > So execution time has increased by 6-7 times.
> >
> > f1d97e76915285013037c487d9513ab763005286 is the first bad commit
> > commit f1d97e76915285013037c487d9513ab763005286 (HEAD)
> > Author: Filipe Manana <fdmanana@suse.com>
> > Date:   Fri Mar 22 18:02:59 2024 +0000
> >
> >     btrfs: add a global per cpu counter to track number of used extent =
maps
> >
> >     Add a per cpu counter that tracks the total number of extent maps t=
hat are
> >     in extent trees of inodes that belong to fs trees. This is going to=
 be
> >     used in an upcoming change that adds a shrinker for extent maps. On=
ly
> >     extent maps for fs trees are considered, because for special trees =
such as
> >     the data relocation tree we don't want to evict their extent maps w=
hich
> >     are critical for the relocation to work, and since those are limite=
d, it's
> >     not a concern to have them in memory during the relocation of a blo=
ck
> >     group. Another case are extent maps for free space cache inodes, wh=
ich
> >     must always remain in memory, but those are limited (there's only o=
ne per
> >     free space cache inode, which means one per block group).
> >
> >     Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> >     Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >     Reviewed-by: David Sterba <dsterba@suse.com>
> >     Signed-off-by: David Sterba <dsterba@suse.com>
> >
> >  fs/btrfs/disk-io.c    |  9 +++++++++
> >  fs/btrfs/extent_map.c | 17 +++++++++++++++++
> >  fs/btrfs/fs.h         |  2 ++
> >  3 files changed, 28 insertions(+)
> >
> > Unfortunately I can't check the revert commit f1d97e769152 because of c=
onflicts.
>
> Yes, because there are follow up commits that depend on it.
>
> I seriously doubt that this is correctly bisected, because that commit
> only adds a counter for tracking the number of extent maps.
> It's using a per cpu counter and I can't think of anything more
> efficient than that.
>
> The commit that adds the extent map shrinker, which is the next commit
> (956a17d9d050761e34ae6f2624e9c1ce456de204), that can
> explain what you are observing.
>
> Now the one you bisected doesn't make sense, not just because it's
> just a counter update but also because you are
> only seeing the kswapd0 slowdown, which is what triggers the shrinker.

git bisect start
# status: waiting for both good and bad commits
# good: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
git bisect good a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
# bad: [1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0] Linux 6.10-rc1
git bisect bad 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0

# bad: [db5d28c0bfe566908719bec8e25443aabecbb802] Merge tag
'drm-next-2024-05-15' of https://gitlab.freedesktop.org/drm/kernel
git bisect bad db5d28c0bfe566908719bec8e25443aabecbb802
6.9.0-01-db5d28c0bfe566908719bec8e25443aabecbb802
up  1:01
root         269 17.4  0.0      0     0 ?        R    16:00  10:36 [kswapd0=
]
up  2:00
root         269 34.5  0.0      0     0 ?        S    16:00  41:36 [kswapd0=
]
up  3:00
root         269 40.2  0.0      0     0 ?        R    16:00  72:47 [kswapd0=
]
BAD

# bad: [b850dc206a57ae272c639e31ac202ec0c2f46960] Merge tag
'firewire-updates-6.10' of
git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394
git bisect bad b850dc206a57ae272c639e31ac202ec0c2f46960
6.9.0-02-b850dc206a57ae272c639e31ac202ec0c2f46960
up  1:00
root         269 25.4  0.0      0     0 ?        R    19:09  15:28 [kswapd0=
]
up  1:18
OOM KILLER
up  2:00
root         269 40.2  0.0      0     0 ?        R    19:09  48:18 [kswapd0=
]
up  3:00
root         269 43.0  0.0      0     0 ?        S    19:09  77:38 [kswapd0=
]
up  3:59
root         269 46.4  0.0      0     0 ?        S    19:09 111:09 [kswapd0=
]
BAD

# good: [59729c8a76544d9d7651287a5d28c5bf7fc9fccc] Merge tag
'tag-chrome-platform-for-v6.10' of
git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux
git bisect good 59729c8a76544d9d7651287a5d28c5bf7fc9fccc
6.9.0-03-59729c8a76544d9d7651287a5d28c5bf7fc9fccc+
up  1:00
root         269  9.3  0.0      0     0 ?        S    10:08   5:38 [kswapd0=
]
up  2:02
root         269  8.8  0.0      0     0 ?        S    10:08  10:49 [kswapd0=
]
up  3:00
root         269  8.7  0.0      0     0 ?        S    10:08  15:42 [kswapd0=
]
up  3:56
root         269  8.1  0.0      0     0 ?        S    10:08  19:22 [kswapd0=
]
up  5:00
root         269  7.7  0.0      0     0 ?        S    10:08  23:16 [kswapd0=
]
up  6:00
root         269  7.5  0.0      0     0 ?        S    10:08  27:12 [kswapd0=
]
GOOD

# good: [101b7a97143a018b38b1f7516920a7d7d23d1745] Merge tag
'acpi-6.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 101b7a97143a018b38b1f7516920a7d7d23d1745
6.9.0-04-101b7a97143a018b38b1f7516920a7d7d23d1745
up  1:00
root         269  8.1  0.0      0     0 ?        S    17:17   4:53 [kswapd0=
]
up  2:00
root         269  6.9  0.0      0     0 ?        S    17:17   8:19 [kswapd0=
]
up  3:19
root         269  6.9  0.0      0     0 ?        S    17:17  13:57 [kswapd0=
]
up  4:01
root         269  7.9  0.0      0     0 ?        S    17:17  19:08 [kswapd0=
]
up  5:02
root         269  8.6  0.0      0     0 ?        R    17:17  26:16 [kswapd0=
]
up  6:00
root         269  8.3  0.0      0     0 ?        S    17:17  29:59 [kswapd0=
]
GOOD

# good: [47e9bff7fc042b28eb4cf375f0cf249ab708fdfa] Merge tag
'erofs-for-6.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
git bisect good 47e9bff7fc042b28eb4cf375f0cf249ab708fdfa
6.9.0-05-47e9bff7fc042b28eb4cf375f0cf249ab708fdfa
up  1:00
root         269  8.0  0.0      0     0 ?        S    14:00   4:49 [kswapd0=
]
up  3:00
root         269  7.2  0.0      0     0 ?        S    14:00  13:00 [kswapd0=
]
up  4:00
root         269  7.3  0.0      0     0 ?        S    14:00  17:36 [kswapd0=
]
up  5:08
root         269  6.5  0.0      0     0 ?        R    14:00  20:12 [kswapd0=
]
up  6:00
root         269  6.1  0.0      0     0 ?        S    14:00  22:14 [kswapd0=
]
GOOD

# bad: [b2665fe61d8a51ef70b27e1a830635a72dcc6ad8] Merge tag
'ata-6.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
git bisect bad b2665fe61d8a51ef70b27e1a830635a72dcc6ad8
6.9.0-06-b2665fe61d8a51ef70b27e1a830635a72dcc6ad8+
up  1:00
root         269 23.4  0.0      0     0 ?        R    20:31  14:06 [kswapd0=
]
up  2:00
root         269 22.1  0.0      0     0 ?        S    20:31  26:36 [kswapd0=
]
up  3:00
root         269 24.6  0.0      0     0 ?        R    20:31  44:21 [kswapd0=
]
up  4:00
root         269 26.6  0.0      0     0 ?        S    Jun22  63:57 [kswapd0=
]
up  5:07
root         269 27.8  0.0      0     0 ?        S    Jun22  85:35 [kswapd0=
]
BAD

# bad: [aa5ccf29173acfaa8aa2fdd1421aa6aca1a50cf2] btrfs: handle errors
in btrfs_reloc_clone_csums properly
git bisect bad aa5ccf29173acfaa8aa2fdd1421aa6aca1a50cf2
6.9.0-rc7-07-aa5ccf29173acfaa8aa2fdd1421aa6aca1a50cf2
up  1:00
root         268 24.7  0.0      0     0 ?        S    Jun23  14:57 [kswapd0=
]
up  2:00
root         268 45.1  0.0      0     0 ?        S    Jun23  54:13 [kswapd0=
]
BAD

# good: [d3fbb00f5e21c6dfaa6e820a21df0c9a3455a028] btrfs: embed
data_ref and tree_ref in btrfs_delayed_ref_node
git bisect good d3fbb00f5e21c6dfaa6e820a21df0c9a3455a028
6.9.0-rc7-08-d3fbb00f5e21c6dfaa6e820a21df0c9a3455a028
up  1:00
root         268  6.3  0.0      0     0 ?        S    01:42   3:51 [kswapd0=
]
up  1:00
root         268  8.1  0.0      0     0 ?        S    10:10   4:53 [kswapd0=
]
up  2:02
root         268  8.3  0.0      0     0 ?        S    10:10  10:13 [kswapd0=
]
up  3:00
root         268  7.6  0.0      0     0 ?        S    10:10  13:46 [kswapd0=
]
up  4:00
root         268  9.1  0.0      0     0 ?        S    10:10  21:56 [kswapd0=
]
GOOD

# good: [5fa8a6baff817c1b427aa7a8bfc1482043be6d58] btrfs: pass the
extent map tree's inode to try_merge_map()
git bisect good 5fa8a6baff817c1b427aa7a8bfc1482043be6d58
6.9.0-rc7-09-5fa8a6baff817c1b427aa7a8bfc1482043be6d58
up  1:10
root         268  5.8  0.0      0     0 ?        S    14:15   4:09 [kswapd0=
]
up  2:09
root         268  5.3  0.0      0     0 ?        S    14:15   6:52 [kswapd0=
]
up  3:09
root         268  4.6  0.0      0     0 ?        S    14:15   8:47 [kswapd0=
]
up  4:04
root         268  4.2  0.0      0     0 ?        S    14:15  10:24 [kswapd0=
]
up  5:00
root         268  3.8  0.0      0     0 ?        R    14:15  11:35 [kswapd0=
]
up  6:06
root         268  3.9  0.0      0     0 ?        S    14:15  14:24 [kswapd0=
]
up  7:03
root         268  3.8  0.0      0     0 ?        S    14:15  16:26 [kswapd0=
]
GOOD

# bad: [9a7b68d32afc4e92909c21e166ad993801236be3] btrfs: report
filemap_fdata<write|wait>_range() error
git bisect bad 9a7b68d32afc4e92909c21e166ad993801236be3
6.9.0-rc7-10-9a7b68d32afc4e92909c21e166ad993801236be3
up  1:00
root         268 32.5  0.0      0     0 ?        R    21:35  19:34 [kswapd0=
]
up  2:00
root         268 46.1  0.0      0     0 ?        R    21:35  55:24 [kswapd0=
]
BAD

# bad: [85d288309ab5463140a2d00b3827262fb14e7db4] btrfs: use
btrfs_get_fs_generation() at try_release_extent_mapping()
git bisect bad 85d288309ab5463140a2d00b3827262fb14e7db4
6.9.0-rc7-11-85d288309ab5463140a2d00b3827262fb14e7db4
up  1:00
root         268 38.0  0.0      0     0 ?        S    00:36  22:50 [kswapd0=
]
up  2:01
root         268 32.7  0.0      0     0 ?        R    00:36  39:38 [kswapd0=
]
up  3:00
root         268 32.1  0.0      0     0 ?        S    00:36  58:01 [kswapd0=
]
BAD

# bad: [65bb9fb00b7012a78b2f5d1cd042bf098900c5d3] btrfs: update
comment for btrfs_set_inode_full_sync() about locking
git bisect bad 65bb9fb00b7012a78b2f5d1cd042bf098900c5d3
6.9.0-rc7-12-65bb9fb00b7012a78b2f5d1cd042bf098900c5d3
up  1:06
root         268 17.3  0.0      0     0 ?        S    10:14  11:34 [kswapd0=
]
up  1:22
OOM KILLER
up  1:32
OOM KILLER
up  2:01
root         268 37.2  0.0      0     0 ?        R    10:14  45:07 [kswapd0=
]
up  3:01
root         268 33.1  0.0      0     0 ?        S    10:14  60:12 [kswapd0=
]
BAD

# bad: [956a17d9d050761e34ae6f2624e9c1ce456de204] btrfs: add a
shrinker for extent maps
git bisect bad 956a17d9d050761e34ae6f2624e9c1ce456de204
6.9.0-rc7-13-956a17d9d050761e34ae6f2624e9c1ce456de204
up  1:01
root         268 42.1  0.0      0     0 ?        R    13:20  25:48 [kswapd0=
]
up  1:30
OOM KILLER
up  2:01
root         268 40.7  0.0      0     0 ?        R    13:20  49:27 [kswapd0=
]
up  2:34
root         268 46.0  0.0      0     0 ?        S    13:20  71:01 [kswapd0=
]
BAD

# bad: [f1d97e76915285013037c487d9513ab763005286] btrfs: add a global
per cpu counter to track number of used extent maps
git bisect bad f1d97e76915285013037c487d9513ab763005286
6.9.0-rc7-14-f1d97e76915285013037c487d9513ab763005286
up  1:06
root         268 15.6  0.0      0     0 ?        S    16:15  10:27 [kswapd0=
]
up  2:00
root         268 12.0  0.0      0     0 ?        S    16:15  14:26 [kswapd0=
]
up  3:00
root         268  9.8  0.0      0     0 ?        S    16:15  17:48 [kswapd0=
]
GOOD!!! But I answered - bad.


Yeah my bad, I made a mistake on the last step.

Right bad commit is  956a17d9d050761e34ae6f2624e9c1ce456de204
Author: Filipe Manana <fdmanana@suse.com>
Date:   Mon Apr 15 17:09:26 2024 +0100

    btrfs: add a shrinker for extent maps

    Extent maps are used either to represent existing file extent items, or=
 to
    represent new extents that are going to be written and the respective f=
ile
    extent items are created when the ordered extent completes.

    We currently don't have any limit for how many extent maps we can have,
    neither per inode nor globally. Most of the time this not too noticeabl=
e
    because extent maps are removed in the following situations:

    1) When evicting an inode;

    2) When releasing folios (pages) through the btrfs_release_folio() addr=
ess
       space operation callback.

       However we won't release extent maps in the folio range if the folio=
 is
       either dirty or under writeback or if the inode's i_size is less tha=
n
       or equals to 16M (see try_release_extent_mapping(). This 16M i_size
       constraint was added back in 2008 with commit 70dec8079d78 ("Btrfs:
       extent_io and extent_state optimizations"), but there's no explanati=
on
       about why we have it or why the 16M value.

    This means that for buffered IO we can reach an OOM situation due to to=
o
    many extent maps if either of the following happens:

    1) There's a set of tasks constantly doing IO on many files with a size
       not larger than 16M, specially if they keep the files open for very
       long periods, therefore preventing inode eviction.

       This requires a really high number of such files, and having many no=
n
       mergeable extent maps (due to random 4K writes for example) and a
       machine with very little memory;

    2) There's a set tasks constantly doing random write IO (therefore
       creating many non mergeable extent maps) on files and keeping them
       open for long periods of time, so inode eviction doesn't happen and
       there's always a lot of dirty pages or pages under writeback,
       preventing btrfs_release_folio() from releasing the respective exten=
t
       maps.

    This second case was actually reported in the thread pointed by the Lin=
k
    tag below, and it requires a very large file under heavy IO and a machi=
ne
    with very little amount of RAM, which is probably hard to happen in
    practice in a real world use case.

    However when using direct IO this is not so hard to happen, because the
    page cache is not used, and therefore btrfs_release_folio() is never
    called. Which means extent maps are dropped only when evicting the inod=
e,
    and that means that if we have tasks that keep a file descriptor open a=
nd
    keep doing IO on a very large file (or files), we can exhaust memory du=
e
    to an unbounded amount of extent maps. This is especially easy to happe=
n
    if we have a huge file with millions of small extents and their extent
    maps are not mergeable (non contiguous offsets and disk locations).
    This was reported in that thread with the following fio test:

       $ cat test.sh
       #!/bin/bash

       DEV=3D/dev/sdj
       MNT=3D/mnt/sdj
       MOUNT_OPTIONS=3D"-o ssd"
       MKFS_OPTIONS=3D""

       cat <<EOF > /tmp/fio-job.ini
       [global]
       name=3Dfio-rand-write
       filename=3D$MNT/fio-rand-write
       rw=3Drandwrite
       bs=3D4K
       direct=3D1
       numjobs=3D16
       fallocate=3Dnone
       time_based
       runtime=3D90000

       [file1]
       size=3D300G
       ioengine=3Dlibaio
       iodepth=3D16

       EOF

       umount $MNT &> /dev/null
       mkfs.btrfs -f $MKFS_OPTIONS $DEV
       mount $MOUNT_OPTIONS $DEV $MNT

       fio /tmp/fio-job.ini
       umount $MNT

    Monitoring the btrfs_extent_map slab while running the test with:

       $ watch -d -n 1 'cat /sys/kernel/slab/btrfs_extent_map/objects \
                            /sys/kernel/slab/btrfs_extent_map/total_objects=
'

    Shows the number of active and total extent maps skyrocketing to tens o=
f
    millions, and on systems with a short amount of memory it's easy and qu=
ick
    to get into an OOM situation, as reported in that thread.

    So to avoid this issue add a shrinker that will remove extents maps, as
    long as they are not pinned, and takes proper care with any concurrent
    fsync to avoid missing extents (setting the full sync flag while in the
    middle of a fast fsync). This shrinker is triggered through the callbac=
ks
    nr_cached_objects and free_cached_objects of struct super_operations.

    The shrinker will iterate over all roots and over all inodes of each
    root, and keeps track of the last scanned root and inode, so that the
    next time it runs, it starts from that root and from the next inode.
    This is similar to what xfs does for its inode reclaim (implements thos=
e
    callbacks, and cycles through inodes by starting from where it ended
    last time).

    Reviewed-by: Josef Bacik <josef@toxicpanda.com>
    Signed-off-by: Filipe Manana <fdmanana@suse.com>
    Reviewed-by: David Sterba <dsterba@suse.com>
    Signed-off-by: David Sterba <dsterba@suse.com>

 fs/btrfs/extent_map.c | 160
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
 fs/btrfs/extent_map.h |   1 +
 fs/btrfs/fs.h         |   2 ++
 fs/btrfs/super.c      |  17 +++++++++++++++++
 4 files changed, 180 insertions(+)

> The shrinker itself can be improved, there's one place where I know it
> might loop too much, and I'll improve that.

Oh, great!
Can I test this patch when it is ready?

--=20
Best Regards,
Mike Gavrilov.

