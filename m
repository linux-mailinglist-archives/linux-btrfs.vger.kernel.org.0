Return-Path: <linux-btrfs+bounces-6263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC46929751
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 11:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4251C20CF8
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CE017BD2;
	Sun,  7 Jul 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCz5xzgD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556C11CA9;
	Sun,  7 Jul 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720345302; cv=none; b=WpxWkMKdPVImYhjA7QMhef50hwZ1wGC2sXKoMjdz/NWHeLZA1I3TuCEEAlmn1qrJPiCY7iMZvSv9y6lTEBmbLIpYDCtA3CT3gyYHD6WKxi/e+svAl7ihmsaTYYGOYl4iY32GX7WpgjDegya7aQ8lUh18IplWR/hdjoNhsJMicd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720345302; c=relaxed/simple;
	bh=2bi+gBoUIyePjQNmV3oMEFozEHi+tWljkvNKMDbCNKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US5+eT/MKgOvNSIubhvGMHh0EDI91iS598dnlihCCSBVEwryfww66kNd+zP8rpWqEOc38WzaWUW15n9X9weM1bANz/di6hkMmVfmgohbQwcMwvbWF/tkEdV/BZHGw3bSDslyatrNkjPCwsCS5iOpq0dgICIvkL7k9beIbPNjCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCz5xzgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F792C4AF0C;
	Sun,  7 Jul 2024 09:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720345302;
	bh=2bi+gBoUIyePjQNmV3oMEFozEHi+tWljkvNKMDbCNKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GCz5xzgDtIuxMlDXqu23YwMYw85Qa+Wnx13bogly93GyXjydn2JqllMLKim/S1G2N
	 wUqznKfACiO+slZzXmPPV/V57AgZzvLh8iccQY3ULqt3BKf0h+CEL08k6hlUx0sufq
	 6OCGqNZgmI4mXZG7/DgS9w85XJxOb/NyMT6aIX5QhsBb+QZipHbiz5be0ArS2oNwcX
	 Kwcu/6PCbxU8uWQHzM+KGuuYIu1IyWwvEXdnBFGs0lciyNmD4eOqAKU1/lsIZOBYvg
	 DtdBi8UdZRbwDy3XH43GRZ/RfxHUeytH98pc8+sRg22Y+Jew+h4KKLR/QhnnHbtW18
	 lszYXzqAdhrvw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso260715466b.0;
        Sun, 07 Jul 2024 02:41:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPfnXCgGUkdM2+6GgBNKAJH45ZTD5d67DcpFk/vGMt/NnYodCP9zLZM6pEzLao3NFgU9aNF3h4NX0Tpv5fh8o2Wlx8BZsVQIHogprrtvOsVeGgU9K1I+jk24h+2MhkEAqt/IvTnvgwgHU=
X-Gm-Message-State: AOJu0YxA6sQiNDU/UeQtAPAQNiPAVLUo+IZfJvhjaQQVEUdDI/deDLTo
	61WtCJB/0ak8fWasO1L90Q4X9urovK1OmiUnrrfhtNDAsk/vZ0vSJqWVqCMDUOtOYR+XJLrJ1rk
	rOveiX0539jytxwuU4qy+dzRbw2w=
X-Google-Smtp-Source: AGHT+IH1noGpdqiH/cDwVQT78zL9snwgWra8FrGjlWR7/FpRQhygswid+vuySB0yHKuQqphJKgNb2eS6WEfMIRLKfwM=
X-Received: by 2002:a17:906:5ca:b0:a77:c26c:a571 with SMTP id
 a640c23a62f3a-a77c26cb495mr494257066b.54.1720345300648; Sun, 07 Jul 2024
 02:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
 <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
 <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
 <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
 <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com>
 <CAK-xaQZ=c7aociwZ5YQreTmT+sBLGdH0rkTKmFzt4i_mrXBmgg@mail.gmail.com>
 <CAK-xaQb2OrgNOKKXp8d_43kqMNyuHxS1V8jSDL6PdNZPTv79+g@mail.gmail.com>
 <CAK-xaQZ25nyCeOvMs0G31sL7R71dxQqZhx61cYzTK7rZD-JxeQ@mail.gmail.com>
 <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com>
 <CAK-xaQaesuU-TjDQcXgbjoNbZa0Y2qLHtSu5efy99EUDVnuhUg@mail.gmail.com>
 <CAK-xaQbcpzvH1uGiDa04g1NrQsBMnyH2z-FPC4CdS=GDfRCsLg@mail.gmail.com> <CAL3q7H63GexJexkDxSz9Av_s=XyYotJqLqjUubZmuU7vynaQNQ@mail.gmail.com>
In-Reply-To: <CAL3q7H63GexJexkDxSz9Av_s=XyYotJqLqjUubZmuU7vynaQNQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 7 Jul 2024 10:41:03 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5fogJTfdkj_7y8upZj7+4dz65o-tKzyGf0WfLwm3nfUw@mail.gmail.com>
Message-ID: <CAL3q7H5fogJTfdkj_7y8upZj7+4dz65o-tKzyGf0WfLwm3nfUw@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 6:37=E2=80=AFPM Filipe Manana <fdmanana@kernel.org> =
wrote:
>
> On Sat, Jul 6, 2024 at 1:07=E2=80=AFPM Andrea Gelmini <andrea.gelmini@gma=
il.com> wrote:
> >
> > Il giorno sab 6 lug 2024 alle ore 02:11 Andrea Gelmini
> > <andrea.gelmini@gmail.com> ha scritto:
> > > For the moment it seems we have a winner!
> >
> > I confirm this, but I forgot to add this (a lot of these):
>
> Oh, those I added on purpose to confirm what the bpftrace logs
> suggested: concurrent calls into the shrinker.
>
>
> > [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm firefox-bin nr_to_scan 2
> > [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm firefox-bin nr_to_scan 2
> > [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> > [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> > shrinker already running, comm cc1plus nr_to_scan 2
> >
> > Just for the record, compiling LibreOffice.
> >
> > In the meanwhile running restic (full backup to force read
> > everything), no sluggish at all.
>
> That's great!
>
> So I've been working on a proper approach following all those test
> results from you and Mikhail, and I would like to ask you both to try
> this branch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=
=3Dtest3_em_shrinker_6.10
>
> Again, this is based on 6.10-rc6 plus 3 fixes for this issue you're both =
having.
>
> Can you guys test that branch?

I just updated the branch with a last minute change to avoid an
unnecessary reschedule and re-lock, therefore helping reduce latency.
Thanks.

>
> Thank you a lot for all the time spent on this!

