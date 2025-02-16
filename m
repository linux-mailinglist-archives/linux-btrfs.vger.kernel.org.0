Return-Path: <linux-btrfs+bounces-11489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA3A37487
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 14:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72A416CE9D
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F771922E1;
	Sun, 16 Feb 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUfRGjBS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B51624C3
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739711954; cv=none; b=cEeOw/sKAujWD2fTS87Kf8ZMOV8NeO+lsVM9HW6KWGFXBkCpbrZypUSKnXumiqMAimig9LavJz2vG/phw7Q10fk6qs+LcElVOtraRR+nFJKv4G3Ikaqf2GGGFIdp7LbswMvoBMRXlyLRAvqjm7KteTv9f//5YPogEUYC//WSJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739711954; c=relaxed/simple;
	bh=h5vwYePETdlVJMzwSyYvExfYMizC7ndVI3Swjg8YVlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng9AQdD5hkV+8YBWVThsszfWDl3hoh2nEKMYoxlYbhON8zA4c0jlW6jMllC9/KQpbAYuegMA9YLNF50O3XveXTJYBuLkW6ztePVrGmDxCotzAxJCRvOtTktlyskciPbiIt5a3XeiwP0Rv1HWJiNmM/UHJ4oDDp8MyQfAfNAiGtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUfRGjBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337CCC4CEDD
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739711954;
	bh=h5vwYePETdlVJMzwSyYvExfYMizC7ndVI3Swjg8YVlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hUfRGjBS/oZUXrcqA5nPgsYn/MHrRumvZSm8uCzUMc6bn4HdsN+MVe8TIy9IBASGq
	 gPx03HEn9MIAsji5qaH74oN5TRFrSIOcLP5ZGs1fiH4jc8F8hGycMFqFiFdrNztcqF
	 yaBVR8fhZ+zpxGqapPJidy2FyUxi6UAyO04QiVl7qAFGw0vrQTrIXz9lrpdLVFmZhp
	 CMimV01LPhudj3559k7/hN/YEx+IVH3r+T59crUAu7WgWDAgCZpxVkPFCzvk1iDyGi
	 xi5yK/XejPWt9irwVfhGol3pYUY6hMyfXrez7ernndmnatFqbbZGw4zqgkcbrsRqgZ
	 wxfzvK2NaLqKw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso1180197a12.2
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 05:19:14 -0800 (PST)
X-Gm-Message-State: AOJu0YzNTmUemZxiF2d83M32BDR8hwZjYL6M9VtquuwmK8cc7qDShB1G
	0IwGM7FYeKZUP4Qp4GpVd+F5rCy/h/yJSg9t86wAUYQxzRIWzqWE+lg+wWlHfMmP0UVEAZfTU3l
	YP15sMAcobsnUB0zLaAw1c+EuUcU=
X-Google-Smtp-Source: AGHT+IFpr7PFxH+7OQWyGDbqsUy/mLmsFnDIiF8+W0Hqn3EULUpkmJCJlGZzS96NN9xVK7UNtw2doSXMW2dHe3akUPs=
X-Received: by 2002:a17:907:3e02:b0:ab6:d4d0:2be9 with SMTP id
 a640c23a62f3a-abb70e67725mr676562266b.56.1739711952810; Sun, 16 Feb 2025
 05:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0414d690ac5680d0d77dfc930606cdc36e42e12f.camel@intelfx.name>
 <CAL3q7H6Luh-LkX2tiuVwd8y-K6mfmjdJ9OOqjwcOEJ6SJCGysA@mail.gmail.com>
 <ce2829b58eb23b13c5f0feef835b9bba99b9d03f.camel@intelfx.name> <1e872bd9f90b6d99f04042d6af3fdba8f7e619a0.camel@intelfx.name>
In-Reply-To: <1e872bd9f90b6d99f04042d6af3fdba8f7e619a0.camel@intelfx.name>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 16 Feb 2025 13:18:36 +0000
X-Gmail-Original-Message-ID: <CAL3q7H42fVskYxbpKbrpv3Pf_vTyT7uKMt2yTt3YPWWik8HhNQ@mail.gmail.com>
X-Gm-Features: AWEUYZktToiDEkOgeYhPkUzeMFAJLGHQw5Ritom-ZTS4eC2q8WvuWylMq3i8OBQ
Message-ID: <CAL3q7H42fVskYxbpKbrpv3Pf_vTyT7uKMt2yTt3YPWWik8HhNQ@mail.gmail.com>
Subject: Re: Linux 6.13: excessive CPU usage by btrfs-cleaner/kswapd (again?)
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 12:41=E2=80=AFPM Ivan Shapovalov <intelfx@intelfx.n=
ame> wrote:
>
> On 2025-02-16 at 16:24 +0400, Ivan Shapovalov wrote:
> > On 2025-02-15 at 18:53 +0000, Filipe Manana wrote:
> > > On Fri, Feb 14, 2025 at 9:40=E2=80=AFPM Ivan Shapovalov <intelfx@inte=
lfx.name> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Linux 6.13.2 (+the pf-kernel patchset at 6.13-pf4, but I don't s=
ee
> > > > any relevant patches in there), I'm seeing excessive CPU usage by t=
he
> > > > btrfs-cleaner and kswapd threads during batch "snapshot backup" run=
s
> > > > (involving mounting historical snapshots one by one and running bor=
g on
> > > > them, which is basically lots of stat and open+close pairs):
> > >
> > > So that's lots of inodes without extent maps that are being grabbed
> > > and getting a delayed iput delegated to the cleaner.
> > >
> > > >
> > > > ```
> > > >     PID CPU USER       PRI  NI  VIRT   RES   SHR  SWAP      MINFLT =
     MAJFLT   DISK READ  DISK WRITE    DISK R/W S  CPU% MEM%   TIME+ =E2=96=
=BDCommand
> > > >     423   1 root        20   0     0     0     0     0           0 =
          0         N/A         N/A         N/A R  53.4  0.0 51:12.81 btrfs=
-cleaner
> > > >      97   3 root        20   0     0     0     0     0           0 =
          0         N/A         N/A         N/A S  17.0  0.0 49:42.98 kswap=
d0
> > > >    2065   5 intelfx     20   0 5812M  158M 74588     0     2548068 =
     602311         N/A         N/A         N/A S  14.5  1.0 46:34.02 /usr/=
bin/gnome-shell
> > > > ```
> > > >
> > > > (these are the top 3 processes by cumulative CPU time on my work
> > > > laptop, after a few hours of uptime.)
> > > >
> > > > perf top on btrfs-cleaner (which is the best I know how to do... I =
suck
> > > > at investigative profiling) says:
> > > >
> > > > ```
> > > >   Children      Self  Shared Object     Symbol
> > > > +  100,00%     0,68%  [kernel]          [k] cleaner_kthread
> > > > +   94,22%     1,71%  [kernel]          [k] btrfs_run_delayed_iputs
> > > > +   75,88%    23,45%  [kernel]          [k] run_delayed_iput_locked
> > > > +   50,63%     4,15%  [kernel]          [k] iput
> > > > +   25,27%     2,48%  [kernel]          [k] list_lru_add_obj
> > > > +   24,18%    22,77%  [kernel]          [k] _raw_spin_lock
> > > > +   20,36%     4,38%  [kernel]          [k] _atomic_dec_and_lock
> > > > +   16,70%    11,57%  [kernel]          [k] _raw_spin_lock_irq
> > > > +   15,48%     1,76%  [kernel]          [k] list_lru_add
> > > > +    6,82%     6,78%  [kernel]          [k] mem_cgroup_from_slab_ob=
j
> > > > +    6,39%     6,22%  [kernel]          [k] native_queued_spin_lock=
_slowpath
> > > > +    5,29%     0,88%  [kernel]          [k] xa_load
> > > > ```
> > > >
> > >
> > > And here this shows the cleaner is running a lot of delayed iputs.
> > >
> > > > perf top on kswapd0 is inconclusive, all of it is shrink_folio_list=
 and
> > > > zswap from there, but I don't remember seeing that kind of CPU usag=
e
> > > > before. All of it is bursty, with kswapd0 eating CPU at the same ti=
me
> > > > as btrfs-cleaner.
> > > >
> > > > Any ideas? Anything I can do to profile better?
> > >
> > > Please try the 3 patches on the following git branch, which is based =
on 6.13.2:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/lo=
g/?h=3Dem-shrinker-6.13.2
> > >
> > > That should dramatically reduce the amount of iputs.
> > >
> >
> > Appreciate the quick response! Yes, that seems to work. I no longer
> > observe elevated CPU time in either btrfs-cleaner or kswapd threads.
>
> Oh, I forgot: there's no formal bug report for this, so I'm not sure it
> applies, but if it does, then:
>
> Tested-by: Ivan Shapovalov <intelfx@intelfx.name>

Thanks for the testing and report.
Writing a mail to the list is enough to report issues.

I've just sent the patchset to the list:

https://lore.kernel.org/linux-btrfs/cover.1739710434.git.fdmanana@suse.com/


>
> Thanks again!

