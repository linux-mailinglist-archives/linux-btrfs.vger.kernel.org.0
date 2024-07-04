Return-Path: <linux-btrfs+bounces-6207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C4927C4D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 19:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7751F215E2
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2992347A53;
	Thu,  4 Jul 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWYl9MG2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C149628;
	Thu,  4 Jul 2024 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114349; cv=none; b=CX8t3+xEX5riHYj/qJ7MxOGvz7yApDde7JM9iY6Kz6wf0vaY0DpsrwCB/l2IcN0nd1PLMxso4tQQkxwx2stEwmKv2xlxVC1tf4FwLPKq+PayqSjqUGl1YWFaXR9Whk7spR7svMG/Yps9nCYGUzPaCcfGk1KpBmboH1hnVLEsDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114349; c=relaxed/simple;
	bh=ln09xEmOM+kzw9WpLfjUjc3sZlPX+iXLorhBcZY3XKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNOH4/9CHLpb15M0K9xIy1/+EmrzObVkMn+IuW1zdkMmq+kEdTd4Wd/7BkSWvvIoCA1ljDLbqDegFr+mpCNRHqtepKiIho4f0WLKzltMCnWNEGJflNdaAB5DaBNeDAMBt2OERUh4kcO3hqAxyUXt3EJcduSciJfhM1pLjmwxZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWYl9MG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DE2C4AF0A;
	Thu,  4 Jul 2024 17:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720114349;
	bh=ln09xEmOM+kzw9WpLfjUjc3sZlPX+iXLorhBcZY3XKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HWYl9MG2yZ1rikoO6BWyPW3+TPODsL/ZKnK72pN3QFBIibrvYswoMFSTxtl3XFL2Y
	 3XEPC7MHkI2bAakxNXGSlJB0tlAjrWYYkCCqa4dAA3noOyJA7oKbtQSsaHW5QBXS17
	 Tk/RdspGp6aeY5U5WL0dL1a0MvPuxhdbcFRJr5ksCrdilan6o7upEJiJ9pAkzvJah1
	 hIsgxN6CC/BbjVmoXvqE92jpAknZOxYOrKJrYn+Z9qUCJYPJfVmo5/rPtFGo5CtZpK
	 YJ8S+ptTVDcCwbHCErE4JSYBS7sNvpFnQlPq7cgKt3MIh56paIhva74tR2mMuJg5n1
	 2Pzn51pQYoBGQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7523f0870cso100217766b.3;
        Thu, 04 Jul 2024 10:32:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTLrUcHz8/r6eTLWrtsAxVfdh6Rmdfm22w4Ev2dh4SNqQvDhAiKg/JxRhZHpswXfgAsy9BMDkPp2WwOLtB1nBMK9/GJw+Ccch2RFXTlp0vF6yqLrMxh43fTBEp2y475/rYfs5Q7lr2gfo=
X-Gm-Message-State: AOJu0YwjVDWDviqm3WJH3/UiyZJ/WVgGm1aZdHV3UCGfXnvv43kyYMNM
	d8ROFlbphuWL2s6lgCsewcItV+aR6AJWC6j+nyf4WWHvuCj1Sx0YbdNCAX5qgbyKTTk8BmCwnq9
	HVKJOthEt7fTl+lfUl3mwr9iZCHc=
X-Google-Smtp-Source: AGHT+IFZqWRfzSyRUXYjto4ORJlfnjFaKu7LIbKOqkA2/uYCdlWzOclXoUWpuR7YqssOCDNWdst5UtNTXEsgE0DjuJc=
X-Received: by 2002:a17:906:c256:b0:a72:7da4:267c with SMTP id
 a640c23a62f3a-a77ba44cfb2mr124294166b.12.1720114347425; Thu, 04 Jul 2024
 10:32:27 -0700 (PDT)
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
 <CAK-xaQZ25nyCeOvMs0G31sL7R71dxQqZhx61cYzTK7rZD-JxeQ@mail.gmail.com> <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com>
In-Reply-To: <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 4 Jul 2024 18:31:50 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5MEyR+=_16bzq533ua-Ne3F1evZmt2NMcYoT9t=XtPig@mail.gmail.com>
Message-ID: <CAL3q7H5MEyR+=_16bzq533ua-Ne3F1evZmt2NMcYoT9t=XtPig@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 6:25=E2=80=AFPM Filipe Manana <fdmanana@kernel.org> =
wrote:
>
> On Thu, Jul 4, 2024 at 3:48=E2=80=AFPM Andrea Gelmini <andrea.gelmini@gma=
il.com> wrote:
> >
> > Il giorno gio 4 lug 2024 alle ore 15:47 Andrea Gelmini
> > <andrea.gelmini@gmail.com> ha scritto:
> > > I send you everything when I collect enough data.
> >
> > Here we are.
> >
> > Kernel rc6+branch:
> >     Output of bfptrace:
> >     https://pastebin.com/P9RFp5mg
>
> So a couple interesting things here, which we didn't get in the short
> capture from Mikhail:
>
> 1) There's apparently multiple tasks entering the shrinker at the same ti=
me:
>      kswapd0, Chrome_ChildIOT, Chrome_IOThread, chrome, Xorg.
>
> 2) In some cases we get very large negative numbers for the number of
> extent maps to scan.
>     This shouldn't happen and either our own btrfs counter might have
> overflowed or some other bug,
>     or the super block's shrinker is being called with sc->nr_to_scan
> negative, and outside btrfs' control,
>     and it seems outside of control of the VFS's shrinker callback
> (see fs/super.c:super_cache_scan()).
>
> >
> >     Recording of tar session: (summary: start fast, then flipping super=
 slow)
> >     https://asciinema.org/a/BxYI83TkrlOhEe42IWXNY135D
> >
> >     Recording of htop session: (summary: PSI high and two threads at 10=
0%)
> >     https://asciinema.org/a/ZwGSepZZ8TSpFfPssACUUXcCB
>
> Ok, so maybe I missed it, but I haven't kswapd0 in there, or nothing
> taking 100% CPU.
> Maybe it was just Mikhail running into that?
>
> I was looking at the memory PSI and I never noticed it going over 60%.
> As for cpu and IO PSI, for cpu it was always low, under 3% from what
> I've seen and for IO even lower than that, very close to 0%.
>
> So I'm surprised that you get an unresponsive desktop.
>
> >
> >
> > Kernel 6.6.36:
> >     Recording of tar session: (summary: tar always fast)
> >     https://asciinema.org/a/a6dOkbjyPFkkQ5aNTaRiFD3H8
> >
> >     Recording of htop session: (summary: no threads and PSI load)
> >     https://asciinema.org/a/mFsypWzHfSdsjrIQf8zpzNpKo
>
> Interestingly, here the memory PSI stays at 0% or very close to that,
> it never reaches anything close to the 60%.
>
> >
> > If you need to run for longer time, I can do it in the weekend.
> > If you need dump of my BTRFS fs, no problem, but I need 'btrfs image
> > -s" working (point is: scrambling filenames).
>
> Ok, so I haven been delaying my reply because I kept accumulating
> things for you (or Mikhail) to try, and avoid sending several messages
> with very little.
>
> So first thing, I tried reproducing your scenario like you described
> in a previous message using tar:
>
> On a fresh btrfs filesystem, I cloned Linus' kernel tree into /mnt/git/li=
nux
> Compiled a kernel.
> Then copied the tree 3 times like this:
>
> cd /mnt/git
> cp --reflink=3Dnever -r linux linux2
> cp --reflink=3Dnever -r linux linux3
> cp --reflink=3Dnever -r linux linux4
>
> The total size of /mnt/git was 62G (as reported by:  du -hs /mnt/git).
>
> Than I ran:
>
> cd /mnt/git
> tar cp git/ | pv > /dev/null
>
> With htop in parallel, the bpftrace script, and since my htop version
> doesn't show PSI information (probably an older version than yours), I
> kept monitoring PSI like this:
>
> watch -d -n 3 'echo "cpu:\n"; cat /proc/pressure/cpu ; echo
> "\nmemory:\n" ; cat /proc/pressure/memory ; echo "\nio:\n" ; cat
> /proc/pressure/io'
>
> Nothing went out of the roof, the machine was always responsive, never
> seen kswapd0 anywhere near the top, and the process using most CPU was
> tar (and always under 30%).
> PSI had all values low.
>
> The shrinker was being triggered very often, for small numbers (mostly
> under 1000, and most of the time much less than that), but I never had
> those large negative numbers nor apparently different tasks entering
> into it concurrently.
> It took a few seconds at most in each run.
>
> I also tried monitoring while doing the "cp --reflink=3Dnever -r"
> commands and while PSI often peaked to 92%, 93%, the system was always
> responsive (and such IO PSI seems reasonable since we are doing a lot
> of read and write IO).
>
> So several different things to try here:
>
> 1) First let's check that the problem is really a consequence of the shri=
nker.
>     Try this patch:
>
>     https://gist.githubusercontent.com/fdmanana/b44abaade0000d28ba0e1e1ae=
3ac4fee/raw/5c9bf0beb5aa156b893be2837c9244d035962c74/gistfile1.txt
>
>     This disables the shrinker. This is just to confirm if I'm looking
> in the right direction, if your problem is the same as Mikhail's and
> double check his bisection.
>
> 2) Then drop that patch that disables the shrinker.
>      With all the previous 4 patches applied, apply this one on top of th=
em:
>
>      https://gist.githubusercontent.com/fdmanana/9cea16ca56594f8c7e20b67d=
c66c6c94/raw/557bd5f6b37b65d210218f8da8987b74bfe5e515/gistfile1.txt
>
>      The goal here is to see if the extent map eviction done by the
> shrinker is making reads from other tasks too slow, and check if
> that's what0s making your system unresponsive.
>
> 3) Then drop the patch from step 2), and on top of the previous 4
> patches from my git tree, apply this one:
>
>      https://gist.githubusercontent.com/fdmanana/a7c9c2abb69c978cf5b80c2f=
784243d5/raw/b4cca964904d3ec15c74e36ccf111a3a2f530520/gistfile1.txt
>
>      This is just to confirm if we do have concurrent calls to the
> shrinker, as the tracing seems to suggest, and where the negative
> numbers come from.
>      It also helps to check if not allowing concurrent calls to it, by
> skipping if it's already running, helps making the problems go away.

Oh and for this one, show your 'dmesg' after your testing to see if
any stack traces or warning messages were logged (even if it happens
to solve all the problems).

Thanks!


>
> >
> > Thanks a lot,
>
> Thanks a lot to you and Mikhail, not just for the reporting but also
> to apply patches, compile a kernel, run the tests and do all those
> valuable observations which are all very time consuming.
>
> Thanks!
>
> > Gelma

