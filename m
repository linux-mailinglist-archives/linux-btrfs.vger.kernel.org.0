Return-Path: <linux-btrfs+bounces-11482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258CDA3703E
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2025 19:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3D3188F789
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2025 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E6D1EDA34;
	Sat, 15 Feb 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBbv6NWX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744C1EDA13
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739645652; cv=none; b=Rq+t9Hb4GD+sjwreAdaxv2PXEpCYdJdTbPgApmP8v6F0mosb2HMtvqFREQiAnufrmEfhK0npbCBfOtmugYiBUwwnbw9yBqjvdrl7f+wUkxg9E+mIbJkcFJx3bWtiCZRQyJSKAn84gzcC98YAiEzDIuxwkMHaoT6IkAwpmK/pZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739645652; c=relaxed/simple;
	bh=7r4PEjnh3Ljl+BWaZa++Cjt3DhDWjWnkpj1nyZi4cpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4QfBtMHNGWrINLKJv8WdPjV5JaL+N1qSQfaRLCMqRc956S8KEuznD5ltayHM/MIDoE+IhdpCic7syDRpZFyJrcYIQBeLjrIMZwAQnQzhq1e5n+kHhn9Bhk3ukWmM6lk+EFjVx9NMK9rcS0dCqI/FlWidDjrU3zqeMFLmCAx8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBbv6NWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF72C4CEE2
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 18:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739645651;
	bh=7r4PEjnh3Ljl+BWaZa++Cjt3DhDWjWnkpj1nyZi4cpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DBbv6NWX5ggj65Mi6UT4IC7Wsc4z64hf6+iVwLpc51qNEFMgmyKLvPl6LGbgyJ4f1
	 r/l7vDsgpmSXlb15CdbR8MROVLr2VTRwq/AByTFEfUk7v0fOL0FB5TJWjz9PMrv5Py
	 0niC/QcmFHP9bb+AhBi33apiP/tPSIEbVG7zAO2EPrwjTfV8/+nUluSQSTxdgkOOSJ
	 RJooBUibGeXfqFU8WWD5mIfmILrWpJAW/nO1dZ1bGNS2eDe54q8zc30ZQJ3WaJJe1g
	 ocj9jrlUaNt6D0WZWMzssL41/pROx/nhrDhCEmKxe8SaVGGksJhkJXLFsbn2Gp+oB6
	 0Adj46wmrYdCw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb7f539c35so94374466b.1
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 10:54:11 -0800 (PST)
X-Gm-Message-State: AOJu0YwjUcUBH8U7FR4M6tVpGsRBxYOCILJ9VGzLDR10PBF2miOY2Bo0
	kvCzHYi2o1TPUXBBEAMQYol+NKlxI6VfCWrzD1amHQvrWpOU/rVySKrZ6kt8SwX1EUCvGbTV4Qc
	H58hI/5QaGOO1+3jIzuZNs3c9uBc=
X-Google-Smtp-Source: AGHT+IGP8KPI7fxG0OC9Rx0dgNpkM7o3u0u44fQdruv2Nm5t0eAIR+pTuzzfBktpWvHCRBu3IxRmz6nhBl0USeB4UdY=
X-Received: by 2002:a17:907:9716:b0:ab7:e3f4:51cc with SMTP id
 a640c23a62f3a-abb70c314bemr480435966b.33.1739645650035; Sat, 15 Feb 2025
 10:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0414d690ac5680d0d77dfc930606cdc36e42e12f.camel@intelfx.name>
In-Reply-To: <0414d690ac5680d0d77dfc930606cdc36e42e12f.camel@intelfx.name>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 15 Feb 2025 18:53:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Luh-LkX2tiuVwd8y-K6mfmjdJ9OOqjwcOEJ6SJCGysA@mail.gmail.com>
X-Gm-Features: AWEUYZn786m040X2khpeaeL7RjrqqRId1YQJGHzHBnXMgO6eggfppIMVrd9cN1Q
Message-ID: <CAL3q7H6Luh-LkX2tiuVwd8y-K6mfmjdJ9OOqjwcOEJ6SJCGysA@mail.gmail.com>
Subject: Re: Linux 6.13: excessive CPU usage by btrfs-cleaner/kswapd (again?)
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 9:40=E2=80=AFPM Ivan Shapovalov <intelfx@intelfx.na=
me> wrote:
>
> Hi,
>
> On Linux 6.13.2 (+the pf-kernel patchset at 6.13-pf4, but I don't see
> any relevant patches in there), I'm seeing excessive CPU usage by the
> btrfs-cleaner and kswapd threads during batch "snapshot backup" runs
> (involving mounting historical snapshots one by one and running borg on
> them, which is basically lots of stat and open+close pairs):

So that's lots of inodes without extent maps that are being grabbed
and getting a delayed iput delegated to the cleaner.

>
> ```
>     PID CPU USER       PRI  NI  VIRT   RES   SHR  SWAP      MINFLT      M=
AJFLT   DISK READ  DISK WRITE    DISK R/W S  CPU% MEM%   TIME+ =E2=96=BDCom=
mand
>     423   1 root        20   0     0     0     0     0           0       =
    0         N/A         N/A         N/A R  53.4  0.0 51:12.81 btrfs-clean=
er
>      97   3 root        20   0     0     0     0     0           0       =
    0         N/A         N/A         N/A S  17.0  0.0 49:42.98 kswapd0
>    2065   5 intelfx     20   0 5812M  158M 74588     0     2548068      6=
02311         N/A         N/A         N/A S  14.5  1.0 46:34.02 /usr/bin/gn=
ome-shell
> ```
>
> (these are the top 3 processes by cumulative CPU time on my work
> laptop, after a few hours of uptime.)
>
> perf top on btrfs-cleaner (which is the best I know how to do... I suck
> at investigative profiling) says:
>
> ```
>   Children      Self  Shared Object     Symbol
> +  100,00%     0,68%  [kernel]          [k] cleaner_kthread
> +   94,22%     1,71%  [kernel]          [k] btrfs_run_delayed_iputs
> +   75,88%    23,45%  [kernel]          [k] run_delayed_iput_locked
> +   50,63%     4,15%  [kernel]          [k] iput
> +   25,27%     2,48%  [kernel]          [k] list_lru_add_obj
> +   24,18%    22,77%  [kernel]          [k] _raw_spin_lock
> +   20,36%     4,38%  [kernel]          [k] _atomic_dec_and_lock
> +   16,70%    11,57%  [kernel]          [k] _raw_spin_lock_irq
> +   15,48%     1,76%  [kernel]          [k] list_lru_add
> +    6,82%     6,78%  [kernel]          [k] mem_cgroup_from_slab_obj
> +    6,39%     6,22%  [kernel]          [k] native_queued_spin_lock_slowp=
ath
> +    5,29%     0,88%  [kernel]          [k] xa_load
> ```
>

And here this shows the cleaner is running a lot of delayed iputs.

> perf top on kswapd0 is inconclusive, all of it is shrink_folio_list and
> zswap from there, but I don't remember seeing that kind of CPU usage
> before. All of it is bursty, with kswapd0 eating CPU at the same time
> as btrfs-cleaner.
>
> Any ideas? Anything I can do to profile better?

Please try the 3 patches on the following git branch, which is based on 6.1=
3.2:

https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=
=3Dem-shrinker-6.13.2

That should dramatically reduce the amount of iputs.

Thanks.


>
> Thanks,
> --
> Ivan Shapovalov / intelfx /

