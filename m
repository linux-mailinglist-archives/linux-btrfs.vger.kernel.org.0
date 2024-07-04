Return-Path: <linux-btrfs+bounces-6206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB126927C2F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 19:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FBF1F220EA
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354A46DD0D;
	Thu,  4 Jul 2024 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGR6Sz06"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A13308A;
	Thu,  4 Jul 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113956; cv=none; b=auIeOrwlhX7lIvW6IBfexyNrLc+SZuv815/cY70ylUSQZ3bpTvxA0xhE6uSAlM+lvVCKZwrG0AxEIYz3pqc3JTjfpz71+PUmiB8Lqq9ciTb8N31kXI0nCViFbNqKjWC69rKBGRDQfgQdG8neE1T7Xd6vVeb9ao3gIzoUNTXiuu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113956; c=relaxed/simple;
	bh=ivjABJQIZ/XjKkNr92Gnumgb4BuLwGJuayEUON94iIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G31g3wpmFRBnABufGinK0CdvXYZCzF9N49Dbv/J0KiW2ogealUcEmmLpLnjA4cMZEwkghde0nUOxP0m9pcuOt8hlFFAUM/tjlBu1i84yF/yRW8a92vREDckPvut0cXrx9YRSdcEtCWQkbIp9RtUbTSGsYvAAACkXk+NUjbVTDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGR6Sz06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10253C4AF0C;
	Thu,  4 Jul 2024 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720113956;
	bh=ivjABJQIZ/XjKkNr92Gnumgb4BuLwGJuayEUON94iIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MGR6Sz06/uFgdzWis82KjYXYZx7aygIcldk0nNZ1ZTUYzL0UpQ9EiUAkyNHuNIoGp
	 i5vBWqDjqPZt3ive3RD7OUc4W415x1hcrZmpUpIuGyYeXMbWbBQ/fRO5XQEkLzaZJV
	 qh6cat5pxD3TOIy+8g1KwaKBkgO9tGEdKFIs3Ied+kyyo3xHbVK2db+VYydOeBL3aN
	 iEePqdAwhs6C6RmF77IFV6egA0UhptiZIf2zIEJXYxu30B6nRCXaHRrfvZtyAe87jB
	 ZN7Z0aBlGy91pQkpyYqdUJkfR8IPdfGXDeIoVl/e42N4T3vKdRLWa+YkT8LTLFmf7q
	 5Djx6ZnMXo/kw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a724b3a32d2so90327466b.2;
        Thu, 04 Jul 2024 10:25:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVy3k0nV6ZGk1BG5U9Hl3DA/f48/IXjqCdnxtiT2+a77tRc+k7aseHS9lAl10FNVS6opyY0mhOwUhf10JCzltWYbQF8z3wyrJkHCL/2vRPHE4h4Zt8oFL01U55cIM522+bdtvPoOxjLEwQ=
X-Gm-Message-State: AOJu0Yz7T8JNtTGN3vLBp7Y86JTAkCqxlpESEfB3QqVR3BdFFmQFRiId
	cqrNTlTqdbagK9PEK1o9JLMU6aJ6wnB9tkXBt9trEXUblKretDzdYpOh7HXnVeTLUE//nJ4NxJQ
	MCrzUuuKOi+aHzuca3elQm3gmCoQ=
X-Google-Smtp-Source: AGHT+IHCaoSwecixF8KG9KKvBxFl5NV3BQBYQCNzIjG/bYJzqUiPJlG5EdctlAZ6Hm67lBypQxg9Uf/fgDEdfZlK8N0=
X-Received: by 2002:a17:907:97c8:b0:a72:8c15:c73e with SMTP id
 a640c23a62f3a-a77ba7099dbmr162064966b.55.1720113954579; Thu, 04 Jul 2024
 10:25:54 -0700 (PDT)
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
 <CAK-xaQb2OrgNOKKXp8d_43kqMNyuHxS1V8jSDL6PdNZPTv79+g@mail.gmail.com> <CAK-xaQZ25nyCeOvMs0G31sL7R71dxQqZhx61cYzTK7rZD-JxeQ@mail.gmail.com>
In-Reply-To: <CAK-xaQZ25nyCeOvMs0G31sL7R71dxQqZhx61cYzTK7rZD-JxeQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 4 Jul 2024 18:25:17 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com>
Message-ID: <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 3:48=E2=80=AFPM Andrea Gelmini <andrea.gelmini@gmail=
.com> wrote:
>
> Il giorno gio 4 lug 2024 alle ore 15:47 Andrea Gelmini
> <andrea.gelmini@gmail.com> ha scritto:
> > I send you everything when I collect enough data.
>
> Here we are.
>
> Kernel rc6+branch:
>     Output of bfptrace:
>     https://pastebin.com/P9RFp5mg

So a couple interesting things here, which we didn't get in the short
capture from Mikhail:

1) There's apparently multiple tasks entering the shrinker at the same time=
:
     kswapd0, Chrome_ChildIOT, Chrome_IOThread, chrome, Xorg.

2) In some cases we get very large negative numbers for the number of
extent maps to scan.
    This shouldn't happen and either our own btrfs counter might have
overflowed or some other bug,
    or the super block's shrinker is being called with sc->nr_to_scan
negative, and outside btrfs' control,
    and it seems outside of control of the VFS's shrinker callback
(see fs/super.c:super_cache_scan()).

>
>     Recording of tar session: (summary: start fast, then flipping super s=
low)
>     https://asciinema.org/a/BxYI83TkrlOhEe42IWXNY135D
>
>     Recording of htop session: (summary: PSI high and two threads at 100%=
)
>     https://asciinema.org/a/ZwGSepZZ8TSpFfPssACUUXcCB

Ok, so maybe I missed it, but I haven't kswapd0 in there, or nothing
taking 100% CPU.
Maybe it was just Mikhail running into that?

I was looking at the memory PSI and I never noticed it going over 60%.
As for cpu and IO PSI, for cpu it was always low, under 3% from what
I've seen and for IO even lower than that, very close to 0%.

So I'm surprised that you get an unresponsive desktop.

>
>
> Kernel 6.6.36:
>     Recording of tar session: (summary: tar always fast)
>     https://asciinema.org/a/a6dOkbjyPFkkQ5aNTaRiFD3H8
>
>     Recording of htop session: (summary: no threads and PSI load)
>     https://asciinema.org/a/mFsypWzHfSdsjrIQf8zpzNpKo

Interestingly, here the memory PSI stays at 0% or very close to that,
it never reaches anything close to the 60%.

>
> If you need to run for longer time, I can do it in the weekend.
> If you need dump of my BTRFS fs, no problem, but I need 'btrfs image
> -s" working (point is: scrambling filenames).

Ok, so I haven been delaying my reply because I kept accumulating
things for you (or Mikhail) to try, and avoid sending several messages
with very little.

So first thing, I tried reproducing your scenario like you described
in a previous message using tar:

On a fresh btrfs filesystem, I cloned Linus' kernel tree into /mnt/git/linu=
x
Compiled a kernel.
Then copied the tree 3 times like this:

cd /mnt/git
cp --reflink=3Dnever -r linux linux2
cp --reflink=3Dnever -r linux linux3
cp --reflink=3Dnever -r linux linux4

The total size of /mnt/git was 62G (as reported by:  du -hs /mnt/git).

Than I ran:

cd /mnt/git
tar cp git/ | pv > /dev/null

With htop in parallel, the bpftrace script, and since my htop version
doesn't show PSI information (probably an older version than yours), I
kept monitoring PSI like this:

watch -d -n 3 'echo "cpu:\n"; cat /proc/pressure/cpu ; echo
"\nmemory:\n" ; cat /proc/pressure/memory ; echo "\nio:\n" ; cat
/proc/pressure/io'

Nothing went out of the roof, the machine was always responsive, never
seen kswapd0 anywhere near the top, and the process using most CPU was
tar (and always under 30%).
PSI had all values low.

The shrinker was being triggered very often, for small numbers (mostly
under 1000, and most of the time much less than that), but I never had
those large negative numbers nor apparently different tasks entering
into it concurrently.
It took a few seconds at most in each run.

I also tried monitoring while doing the "cp --reflink=3Dnever -r"
commands and while PSI often peaked to 92%, 93%, the system was always
responsive (and such IO PSI seems reasonable since we are doing a lot
of read and write IO).

So several different things to try here:

1) First let's check that the problem is really a consequence of the shrink=
er.
    Try this patch:

    https://gist.githubusercontent.com/fdmanana/b44abaade0000d28ba0e1e1ae3a=
c4fee/raw/5c9bf0beb5aa156b893be2837c9244d035962c74/gistfile1.txt

    This disables the shrinker. This is just to confirm if I'm looking
in the right direction, if your problem is the same as Mikhail's and
double check his bisection.

2) Then drop that patch that disables the shrinker.
     With all the previous 4 patches applied, apply this one on top of them=
:

     https://gist.githubusercontent.com/fdmanana/9cea16ca56594f8c7e20b67dc6=
6c6c94/raw/557bd5f6b37b65d210218f8da8987b74bfe5e515/gistfile1.txt

     The goal here is to see if the extent map eviction done by the
shrinker is making reads from other tasks too slow, and check if
that's what0s making your system unresponsive.

3) Then drop the patch from step 2), and on top of the previous 4
patches from my git tree, apply this one:

     https://gist.githubusercontent.com/fdmanana/a7c9c2abb69c978cf5b80c2f78=
4243d5/raw/b4cca964904d3ec15c74e36ccf111a3a2f530520/gistfile1.txt

     This is just to confirm if we do have concurrent calls to the
shrinker, as the tracing seems to suggest, and where the negative
numbers come from.
     It also helps to check if not allowing concurrent calls to it, by
skipping if it's already running, helps making the problems go away.

>
> Thanks a lot,

Thanks a lot to you and Mikhail, not just for the reporting but also
to apply patches, compile a kernel, run the tests and do all those
valuable observations which are all very time consuming.

Thanks!

> Gelma

