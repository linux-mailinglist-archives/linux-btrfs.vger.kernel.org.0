Return-Path: <linux-btrfs+bounces-6191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724A8927358
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 11:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01853281947
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D477F1AB90B;
	Thu,  4 Jul 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/YIfZe+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A31AB8E6;
	Thu,  4 Jul 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086570; cv=none; b=CMujw2bNlR7e6LNN+vowWHfHfZ54vBMpzh6VgIvmAyrGb9Hh2kOOhLWMWyNYCLtYykTHRxpc77cy+QDWrLIcBF0D1v/KBZ5D+0P11n9SPC1SoiZ9nk+zTP8cgFT77gQGzMR6DhoBH68SRXyPYyYVzP2Wi17mR+J1S56VHcRoDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086570; c=relaxed/simple;
	bh=b00IxYDAeikWpgDJD4xLbTBlof/vNk7MI6sw5PDIdo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKQ4hmsWalZ1HMNSPNifnaBudf4sSlZwx74Kd/gjc3GC5vIti7VkQH2bQAd3vbM3qJwSFuTE9A3hckRa8hohWE1kFnkpM05xcBRn9ZbSY4mVdIfY6DpiJ8vpeZQl8mPBH81CCC72JHiPBy8Ewglpt6qlkXealiDxIzGoVVfkJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/YIfZe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24A6C4AF11;
	Thu,  4 Jul 2024 09:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720086569;
	bh=b00IxYDAeikWpgDJD4xLbTBlof/vNk7MI6sw5PDIdo0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q/YIfZe+HLRZsqTOXHUjVoT1YVMaopeFByadpWoLIC6Ae8PQc7HFk4jjwLH4TWjLw
	 Fbb9MLU5qMzwcZdD8KhjopAHkmikyeMnmqYcnSHtTOCiB8hj5DSVacn5CU5uhtVl9E
	 mdInJCl+QpiU8sukf0oXa9uFOj0Y7g+Cb2SFl9LyUd4WxQGDRbDD9LeDGywb5NNz1M
	 g2IeRkfLbtakP5FXo9aHAtDpjU7aJiOHGGli1ABz1ffyOJRYUE/3ftS7VDBegjX91b
	 cWvSg6/Gz/85Zf+/8mJAsvDeeP8Zj/W0zF8nuT7NmcuO5bnsnNN70QfANKGeb/ZEgP
	 aU35l9UmFPfLA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so619124a12.1;
        Thu, 04 Jul 2024 02:49:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjxsP2Dp8oa0cpe0OWMZG7vUTsFUZ1kHXXV+spD6qmyD76OeopGY16auaDUHqnNLTqsbleUX6xkVpPqv8rg+wx9YJG8evSSLjsBwtgo3QjX0mY+uYkV9yGyHMBHNw8ld2Qilu93w2RI7U=
X-Gm-Message-State: AOJu0YzLD+8pKKEPd6Tij7U+ip98qyComrGSSzqFl50cj7BdbDryQFMD
	HkRj7BYjh+CDWpziBSIUGtSJhng2hVh5SwMEVDUjW2g/vB0wgM1QbsP5tiPAfi9hNurPd6wlJrE
	EjFOyK8K1Jt3E1vKKZOiu/OnZ9+Q=
X-Google-Smtp-Source: AGHT+IHv4dV38PoUbX9m+h4A+7s5pTuFTanK6I1V7kPNHqAr4eytUG4G29nV3hhGsCAZN2J8p55FwDaJTvQx/PX/9j8=
X-Received: by 2002:a17:906:4089:b0:a6f:c4d6:4874 with SMTP id
 a640c23a62f3a-a77ba4c5901mr63594166b.34.1720086568232; Thu, 04 Jul 2024
 02:49:28 -0700 (PDT)
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
 <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com> <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
In-Reply-To: <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 4 Jul 2024 10:48:51 +0100
X-Gmail-Original-Message-ID: <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
Message-ID: <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 10:07=E2=80=AFPM Andrea Gelmini <andrea.gelmini@gmai=
l.com> wrote:
>
> Il giorno mer 3 lug 2024 alle ore 13:59 Filipe Manana
> <fdmanana@kernel.org> ha scritto:
> >
> > I'm collecting all the patches in this branch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/=
?h=3Dem_shrinker_6.10
> >
> > They apply cleanly to 6.10-rc.
>
> Yeap, as I wrote before, same problem here.
> I tried the branch over today Linus git (master), and nothing changed.
> But, good news, I can provide a few more details.
>
> So, no need to use restic. On my laptop (nvme + ssd, 32GB RAM, Lenovo T48=
0):
> a) boot up;
> b) just open Window Maker and two Konsole, one with htop (with a few
> tricks to view PSI and so on);
> c) on one terminal run: tar cp /home/ | pv > /dev/null
> d) wait less than one minutes, and I see "PSI full memory" increase
> more than 50, memory pressure on swap, and two CPU threads (out of
> eight) busy at  100%;

I'll try that soon and see if I can reproduce.

In the meanwhile, just curious: are you using swapfiles on btrfs?

Thanks.

> e) system get sluggish (on htop I see no process eating CPU);
> f) if I kill tar, PSI memory keeps going up and down, so the threads.
> After lots of minutes, everything get back to no activity. In these
> minutes I see by iotop there's no activity nor on ssd or nvme. Until
> the end, the system is unresponsive, oh well, really slow.
>
> My / is BTRFS. Not many years of aging. Usually with daily snapshots
> and forced compression.
>
> Less than 4.000.000 files on the system. Usually .git and source code.
>
> root@glen:/home/gelma# btrfs filesystem usage /
> Overall:
>    Device size:                   3.54TiB
>    Device allocated:              2.14TiB
>    Device unallocated:            1.40TiB
>    Device missing:                  0.00B
>    Device slack:                    0.00B
>    Used:                          2.03TiB
>    Free (estimated):              1.50TiB      (min: 1.50TiB)
>    Free (statfs, df):             1.50TiB
>    Data ratio:                       1.00
>    Metadata ratio:                   1.00
>    Global reserve:              512.00MiB      (used: 0.00B)
>    Multiple profiles:                  no
>
> Data,single: Size:2.12TiB, Used:2.02TiB (95.09%)
>   /dev/mapper/sda6_crypt          2.12TiB
>
> Metadata,single: Size:16.00GiB, Used:14.73GiB (92.04%)
>   /dev/mapper/sda6_crypt         16.00GiB
>
> System,single: Size:32.00MiB, Used:320.00KiB (0.98%)
>   /dev/mapper/sda6_crypt         32.00MiB
>
> Unallocated:
>   /dev/mapper/sda6_crypt          1.40TiB

