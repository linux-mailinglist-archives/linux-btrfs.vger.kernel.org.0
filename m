Return-Path: <linux-btrfs+bounces-6224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C6E928767
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 13:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38EB282AD0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08F4149C45;
	Fri,  5 Jul 2024 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFtDFdLJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5731465A3;
	Fri,  5 Jul 2024 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177251; cv=none; b=C4pyrMJ9Z8t6wk9S5c08lvNS9Y1YCQDLZ6SwUpF392JPB17zqDKgbTeeuSdcrmwqvBRc/1bxnHR33heBMtBeu6eTKKmyLZTbccj0NOxw0j1WyH2qwywq+xAapJw4INHCw5VnJWeSkKwQzsbJ+ZjD+Yt9SHgNMWrYkD8huzQAY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177251; c=relaxed/simple;
	bh=Fgt3RnGtwmO5wB3uewwZsYlqeRL9Q4dvJgMlsjigWf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7IKNPKZg+TcjFqzJDbawH8imXWcnsrVpr57dacZ+wysFLgbpp3CVRM6dvDORbEvrAmFUak+9RCG9U2wQW3LOqweNS3rZ6nHpaQv/h0IpKH9u6mPSbDrrRuExyDNQ8Pq3EUWR7yiNJWHClBrOvyD/Tr0th1b+c7G1XIdObGz1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFtDFdLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9695BC116B1;
	Fri,  5 Jul 2024 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720177250;
	bh=Fgt3RnGtwmO5wB3uewwZsYlqeRL9Q4dvJgMlsjigWf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bFtDFdLJdRmvD9F9W42sJ63l9PJA+ADSBPMhYYGhWwbbo5N6VBjcZyctbbtaYGu8L
	 3+cTV7GZZBh17NRGcFsm+9bumcNUjAdcmhemprwgTPG9VxfjTeOoa4uUxab3K9wsmm
	 Mh0LfLofall1YnvJEwOlEKwsgAqYZ9O0RSL02l2SMZiNx6DANNBPHO/Bd7RUSE+QX/
	 2dlxx8yZ3K7oT0ncdNxBfMapkQmAS+TqcoIM6SQKLXl0SBHcmJASt57vN0Zo7CrMmA
	 gMBUnuWlRyw2JESv+bfxscF0i+Sl+JQ2MUvPDzNOtNEXYzSEcvuiKfEJX/1OjEYoBm
	 hii88eyCQU/pA==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so2077787a12.1;
        Fri, 05 Jul 2024 04:00:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvfRpY528aeUi8DX2BuLcKGfnxGLJOr8eiG4qIOHyLN65qDuF5n8UfmJNnaWcALzroCSVBDuR3hD6qV9fGDpr5agqxEGD4gF+0DXKwCJCxsAvjA1xiT9/6Oph+rtsbh8IHcH/MMVINqK4=
X-Gm-Message-State: AOJu0YxNsJH8LJsXpN9RXtS+sGtdvvJjcai8jg5n5NwUSZjB4lim2LzQ
	uXIzZmRuIs9baITdyYX6g3xpSV7DiJofzlIyLpPuiA+h/xtaeD3jqbGP50aUd0dSn3uD0vgPg6B
	COn9qs+8gFOtY7qvtT3vmf1iVme8=
X-Google-Smtp-Source: AGHT+IFuUSm9RlYCkmQLzKs9FUyEgaD5z0JbhqzUNvkEF0C7nb1RcZBZwuulQciVrer2M2tG71l2ufmovAY64qV1q1A=
X-Received: by 2002:a17:906:c247:b0:a77:c548:6456 with SMTP id
 a640c23a62f3a-a77c54864b3mr189131966b.59.1720177249139; Fri, 05 Jul 2024
 04:00:49 -0700 (PDT)
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
 <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com> <CAK-xaQa2NP0kfwQZoko-FUsSCbW31F1S48SJy8+94aSs7PCd3w@mail.gmail.com>
In-Reply-To: <CAK-xaQa2NP0kfwQZoko-FUsSCbW31F1S48SJy8+94aSs7PCd3w@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 5 Jul 2024 12:00:11 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6G43cb-k-efam8=ydR0L_MdEXvFtLf4T6uqakuS1FBiw@mail.gmail.com>
Message-ID: <CAL3q7H6G43cb-k-efam8=ydR0L_MdEXvFtLf4T6uqakuS1FBiw@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 11:15=E2=80=AFPM Andrea Gelmini <andrea.gelmini@gmai=
l.com> wrote:
>
> Il giorno gio 4 lug 2024 alle ore 19:25 Filipe Manana
> <fdmanana@kernel.org> ha scritto:
> > 2) In some cases we get very large negative numbers for the number of
> > extent maps to scan.
> >     This shouldn't happen and either our own btrfs counter might have
> > overflowed or some other bug,
>
> Well, I was thinking about my specific odds, and I tried this:
> a) kernel 6.6.36;
> b) on spare partition nvme created a new shiny btrfs;
> c) then mount it forcing compression;
> d) multiple parallel cp of kernel and libreoffice src;
> e) reboot with same rc6+branch already used;
> f) tar of the new btrfs: no problem at all;
> g) let it finish;
> h) tar of /.snapshots: PSI memory skyrocket, and usual slowdown reading;
> i) stop it;
> l) again tar of the new btrfs: no problem
> m) repeat a few times.
>
> You can see the output here:
> https://asciinema.org/a/rJpGWvXYH6IDBXWYhtJckkKWo
>
> In the end you see I kill tar and let the PSI going down to zero, if
> you are interested.
>
> > Ok, so maybe I missed it, but I haven't kswapd0 in there, or nothing
> > taking 100% CPU.
> > Maybe it was just Mikhail running into that?
>
> To have this effect and the extreme luggish response (I mean, click
> something and it takes more than 30 seconds to react)
> I need to work at least one day on my laptop. At this point also
> cycling to virtual desktop takes a lot.
>
> Thinking about my different use case:
> a) i always suspend. I just reboot when change kernel. So, I can work
> for weeks with same kernel. Suspend2RAM, not disk, btw;
> b) months ago I let run beesd for a day.
>
> > So I'm surprised that you get an unresponsive desktop.
> Same point as before. In this case is not so luggish, but - i.e. - if
> I click for screenlock it doesn't start immediately, it waits for a
> little bit more than one second.

Oh I see that on my main desktop which only uses ext4 and always has 2
qemu vms usually running debian and opensuse.
Sometimes even if the VMs aren't doing anything, but they used to be
doing IO heavy testing, the desktop in the host gets unresponsive,
clicking the screenlock often takes at least some 5 seconds, or
changing workspaces takes a few seconds too, etc. Shouldn't happen in
theory.

>
> > Interestingly, here the memory PSI stays at 0% or very close to that,
> > it never reaches anything close to the 60%.
>
> You see the same thing with the last test with new btrfs partition.
> New partition: ~0%
> /.snapshots/: near 60%.

It could be due to heavy fragmentation, but that should only be too
slow if you were using a spinning disk.
I think somewhere you mentioned nvme or ssd.

Removing the extent maps could cause extra reads of metadata and be slow.
But the number of extent maps removed on every iteration is relatively
small, and round-robin, so... it's strange that it causes such huge
pressure and desktop unresponsiveness.
We will know if that's the case with the 2nd test patch.

>
>
> > With htop in parallel, the bpftrace script, and since my htop version
> > doesn't show PSI information (probably an older version than yours), I
> > kept monitoring PSI like this:
>
> Well, mine is taken from here:
> https://github.com/htop-dev/htop.git
> Compiled with:
> ./configure --enable-capabilities --enable-delayacct --enable-sensors
> --enable-werror   --enable-affinity
> And tweaked config file. If you want I can send it.

Thanks, I'll have to try it eventually.

>
>
> > So several different things to try here:
>
> I stop here for the moment. I have to sleep.
> In the weekend I do the rest and reply to you!

Sure, take your time. It takes time patching and building kernels,
plus the testing, etc.
Many thanks for that!

>
> > Thanks a lot to you and Mikhail, not just for the reporting but also
> > to apply patches, compile a kernel, run the tests and do all those
> > valuable observations which are all very time consuming.
>
> My little contribution to free software!
>
> Ciao,
> Gelma

