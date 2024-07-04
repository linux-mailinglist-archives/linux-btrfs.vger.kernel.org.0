Return-Path: <linux-btrfs+bounces-6192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18981927373
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 11:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B9A1F23BD7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ACF1AB8FC;
	Thu,  4 Jul 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMfXuc3g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4831AB506;
	Thu,  4 Jul 2024 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087051; cv=none; b=WoJpDhurVht+geHM3V+KAyupUIrbrEVzuAt7KjZTEPwN4M3jFPJTkL2IeB3iTgK2SI2ePnPkxR2Bku4KZMhUA7PXAkVysM3eyKdH/3O6I1OfHVDCXlaEuLVHxaK2fkGrvufMxFxaQaXKG5iemznb7ooqgtrSbXKHDqCG1XjvQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087051; c=relaxed/simple;
	bh=Xr6B17nW/I57xdcXG07JqJqh4hldNLJBk9kDAFf/DQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhR7MpE3krkD3w3+D/HKX3vTP9apvtNhlLh93/c+y/E9B3rAbbT+YAYvX5GiJyjRX3ZcX1lG86nneZJufaYeXubgPQuCFfIGG7noQWDItRNyr52+zoHZhsDPjW/Q9oVivkC3AEkcGSiv1Kwlmn4uPeIRyX9ncFZCCjSyXX5+7Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMfXuc3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4DAC4AF0B;
	Thu,  4 Jul 2024 09:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720087051;
	bh=Xr6B17nW/I57xdcXG07JqJqh4hldNLJBk9kDAFf/DQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HMfXuc3gOBpVU4VmafZvgD5uTTlSiE/zeE6fbrXg4zCb6Ir1Yu3EEgihMP10agEqB
	 1c4gNs3ASl968ey8wUXzo9/pTmsbz6p9wNxO7kdt6aVn07LsnSnzJ6UEf1HXkiFYly
	 Xj1RxUjQNOw2taYfEsP0lTggZ69kwRFEvtFsmwseXkK121LQgwkkJAmKH7VdxmX75a
	 wcY5hUsEqWrvG6CB+gY7oyLQwXyl5XHCvzh1QU6eO0dPARxnUbgy3mauUx9Uw+nAQD
	 +yz7tTgnA6DguwzMI8TMbyrzWI571Ho6EhvCygYKTRKqDRLpawnFTNDV5MA9EHiqEJ
	 /xxV+osxiiNNg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a72988749f0so59533466b.0;
        Thu, 04 Jul 2024 02:57:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVa8Y6YGSrneEBz+ALmKuokXx+u2FtH9rmL8adrH0xbroAebOJOCoQr6CaWe8wS+iqkuXjPflVHAwnRpc8J4+s0QuEsjET0jYJDubxUa6ddAQvdz19ljC5OvTRBszI7/zM2S7DS8C/fKpU=
X-Gm-Message-State: AOJu0YxKcUuKypM/uE/nNv1r4tzPnVZCsdgoZPwsyXLysrtH62LRjRNO
	pc/1oy6Te/y5DiRDpROerKjB9MshUya2deQxdyr/Tyg/k5B7X8ga/wM6VHFaktiS8R9vKlwYbe8
	jL3xe8eK17fnAWnF3KutID6PkMVE=
X-Google-Smtp-Source: AGHT+IFM2J4ZPmhN4lgXEZMzfk3lH5FGbKSx2yLA5OmBD93zi4PSvy7DVElSaZMfWeTsYNWheM3Zw0ujj9A+44w+1+g=
X-Received: by 2002:a17:907:3d9f:b0:a6f:5318:b8f0 with SMTP id
 a640c23a62f3a-a77ba48df9dmr89454066b.37.1720087049692; Thu, 04 Jul 2024
 02:57:29 -0700 (PDT)
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
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com> <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
In-Reply-To: <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 4 Jul 2024 10:56:52 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com>
Message-ID: <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 10:48=E2=80=AFAM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Wed, Jul 3, 2024 at 10:07=E2=80=AFPM Andrea Gelmini <andrea.gelmini@gm=
ail.com> wrote:
> >
> > Il giorno mer 3 lug 2024 alle ore 13:59 Filipe Manana
> > <fdmanana@kernel.org> ha scritto:
> > >
> > > I'm collecting all the patches in this branch:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/lo=
g/?h=3Dem_shrinker_6.10
> > >
> > > They apply cleanly to 6.10-rc.
> >
> > Yeap, as I wrote before, same problem here.
> > I tried the branch over today Linus git (master), and nothing changed.
> > But, good news, I can provide a few more details.
> >
> > So, no need to use restic. On my laptop (nvme + ssd, 32GB RAM, Lenovo T=
480):
> > a) boot up;
> > b) just open Window Maker and two Konsole, one with htop (with a few
> > tricks to view PSI and so on);
> > c) on one terminal run: tar cp /home/ | pv > /dev/null
> > d) wait less than one minutes, and I see "PSI full memory" increase
> > more than 50, memory pressure on swap, and two CPU threads (out of
> > eight) busy at  100%;
>
> I'll try that soon and see if I can reproduce.
>
> In the meanwhile, just curious: are you using swapfiles on btrfs?

I wonder if you have bpftrace installed and can run the following
script while doing the test:

$ cat bpftrace-em-shrinker.sh
#!/usr/bin/bpftrace

tracepoint:btrfs:btrfs_extent_map_shrinker_scan_enter
{
time("%H:%M:%S ");
@start_em_scan[tid] =3D nsecs;
printf("%s enter shrinker scan %ld nr %ld root %llu ino %llu\n",
       comm, args->nr_to_scan, args->nr, args->last_root_id, args->last_ino=
);
}

tracepoint:btrfs:btrfs_extent_map_shrinker_scan_exit
/@start_em_scan[tid]/
{
time("%H:%M:%S ");
$dur =3D (nsecs - @start_em_scan[tid]) / 1000;
delete(@start_em_scan[tid]);
printf("%s exit shrinker drop %ld nr %ld root %llu ino %llu | %llu us\n",
       comm, args->nr_dropped, args->nr, args->last_root_id,
args->last_ino, $dur);
}

END
{
clear(@start_em_scan);
}

The run it like:

$ ./bpftrace-em-shrinker.sh 2>&1 | tee em_shrinker_log.txt

And provide the log file.

Thanks.

>
> Thanks.
>
> > e) system get sluggish (on htop I see no process eating CPU);
> > f) if I kill tar, PSI memory keeps going up and down, so the threads.
> > After lots of minutes, everything get back to no activity. In these
> > minutes I see by iotop there's no activity nor on ssd or nvme. Until
> > the end, the system is unresponsive, oh well, really slow.
> >
> > My / is BTRFS. Not many years of aging. Usually with daily snapshots
> > and forced compression.
> >
> > Less than 4.000.000 files on the system. Usually .git and source code.
> >
> > root@glen:/home/gelma# btrfs filesystem usage /
> > Overall:
> >    Device size:                   3.54TiB
> >    Device allocated:              2.14TiB
> >    Device unallocated:            1.40TiB
> >    Device missing:                  0.00B
> >    Device slack:                    0.00B
> >    Used:                          2.03TiB
> >    Free (estimated):              1.50TiB      (min: 1.50TiB)
> >    Free (statfs, df):             1.50TiB
> >    Data ratio:                       1.00
> >    Metadata ratio:                   1.00
> >    Global reserve:              512.00MiB      (used: 0.00B)
> >    Multiple profiles:                  no
> >
> > Data,single: Size:2.12TiB, Used:2.02TiB (95.09%)
> >   /dev/mapper/sda6_crypt          2.12TiB
> >
> > Metadata,single: Size:16.00GiB, Used:14.73GiB (92.04%)
> >   /dev/mapper/sda6_crypt         16.00GiB
> >
> > System,single: Size:32.00MiB, Used:320.00KiB (0.98%)
> >   /dev/mapper/sda6_crypt         32.00MiB
> >
> > Unallocated:
> >   /dev/mapper/sda6_crypt          1.40TiB

