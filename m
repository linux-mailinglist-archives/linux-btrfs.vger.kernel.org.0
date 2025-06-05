Return-Path: <linux-btrfs+bounces-14500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978C8ACF508
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 19:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF363AD6B1
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FE92750E3;
	Thu,  5 Jun 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="uifqDFus"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69EE13D521
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143369; cv=none; b=IfgwIgOapVHmsX6vRnKyUtJnWO7xTpgVZz3vDcqN013Vys/cYAT9sYTI3OoyRup6gEizpP0wopKa4NtNyiQiLVR5wQToKumPHSgIBuhTN4uVcjAHxgIoRoMiUtaWZYg3pR6yGyBJezz1XQu2okh1BprWcZEl//0PZK77QVfhRT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143369; c=relaxed/simple;
	bh=SE3Jho3qINuzIEWKx936N+56/UrEAag3IIRkbStZ1DA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tMu/PEyzjA8q1Rmkmg0zsvSdHxvDkBDKQHXC23Us+zbqFa6IYDrD0/nOayAlgFnzjGjKYPQWikEx5otxh10DEJqr3aOElf6GLIPbXz59s6ayRTjZay8w891DRkupD13/gcSkSXES8LR0kpVrvjMURSyRGFs2yyENoYm3J5iVdVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=uifqDFus; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1749143349; x=1749748149; i=jimis@gmx.net;
	bh=6UlKvnoDbPaQKwqEu4ip7TVzTxKsESppNl9xobFkgjQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uifqDFuslUQawdu+ZBDUefcmiK1p3atPNeQ+wApGIQPyljQ+lshu/XShKxK3s8KV
	 0mxg4ZYqHC2h3tg3OPI0CJpw2CkNWlkFgeaiNuVthqnCnsQsTExR13duWmLo6ub7q
	 ATKuf9m3BYT78a5fDkk44D7cHE5yvKsTdQDAKRrAKZrsO/xY84T9nNr/CmMUJB7vy
	 eZA2HmdFeTWq0FZ0q6xgO5lveJ8qYTS5mqlng+WHdQrXcLMDlt3SduVjvGvktscwT
	 XeHA++MhHxqpU2Gb70ruzvSidwl8Q3L8uyMsIK9z94W+WRJWO634s4q12mNAX71mU
	 VkekxNjRyfJJ/7+O1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O2W-1uR3qE2lp8-003MU0; Thu, 05
 Jun 2025 19:09:08 +0200
Date: Thu, 5 Jun 2025 19:09:07 +0200 (CEST)
From: Dimitrios Apostolou <jimis@gmx.net>
To: Boris Burkov <boris@bur.io>
cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org, 
    Qu Wenruo <quwenruo.btrfs@gmx.com>, Anand Jain <anand.jain@oracle.com>, 
    Matthew Wilcox <willy@infradead.org>
Subject: Re: Sequential read(8K) from compressed files are very slow
In-Reply-To: <20250604180303.GA978719@zen.localdomain>
Message-ID: <d934d1ea-4e3e-71ef-8b42-698ccd747799@gmx.net>
References: <34601559-6c16-6ccc-1793-20a97ca0dbba@gmx.net> <20250604013611.GA485082@zen.localdomain> <aD_mE1n1fmQ09klP@infradead.org> <20250604180303.GA978719@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:EdsdcI7rQkp/TfhUa+zl9sc/fSpFFoVgr7f0+ffLwtd2KczxFYG
 QXvcwJ3Q5QLs4o406lYgdTpPKL2yp2qnvCx5iMl3P+N49W0ydoghMG6mtKVeiO0EaV69pK5
 fxJY0bfXaWANowd49TTqBD1GT5YZlPtaZAncc6T+4oLb9vWS48R67D81+uHe6U8aNA4Kq3+
 AdIi6a/AGcnq5Xv68vaxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wbEfw7+BZAw=;yH/jWRvZcnS40ekNTk38GPr/JRj
 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
Content-Transfer-Encoding: quoted-printable

Hi Boris, thank you for investigating! I've been chasing this for years=20
and I was hitting a wall, the bottleneck was not obvious at all when=20
looking from outside the kernel. I've started a few threads before but=20
they were fruitless.

On Wed, 4 Jun 2025, Boris Burkov wrote:

>
> stats from an 8K run:
> $ sudo bpftrace readahead.bt
> Attaching 4 probes...
>
> @add_ra_delay_ms: 19450
> @add_ra_delay_ns: 19450937640
> @add_ra_delay_s: 19
>
> @ra_sz_freq[8]: 81920
> @ra_sz_hist:
> [8, 16)            81920 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@|
>
>
> stats from a 128K run:
> $ sudo bpftrace readahead.bt
> Attaching 4 probes...
>
> @add_ra_delay_ms: 15
> @add_ra_delay_ns: 15333301
> @add_ra_delay_s: 0
>
> @ra_sz_freq[512]: 1
> @ra_sz_freq[256]: 1
> @ra_sz_freq[128]: 2
> @ra_sz_freq[1024]: 2559
> @ra_sz_hist:
> [128, 256)             2 |                                              =
      |
> [256, 512)             1 |                                              =
      |
> [512, 1K)              1 |                                              =
      |
> [1K, 2K)            2559 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@|
>
>
> so we are spending 19 seconds (vs 0) in add_ra_bio_pages and calling
> btrfs_readahead() 81920 times with 8 pages vs 2559 times with 1024
> pages.

I specifically like the bpftrace utility you are using, it opens up new=20
possibilities without custom kernel compiles, so I want to experiment.=20
Could you please include the script you used for this histogram?

>
> The total time difference is ~30s on my setup, so there are still ~10
> seconds unaccounted for in my analysis here, though.

This is outstanding. I expect such improvement will give a *huge* boost to=
=20
postgresql workloads on compressed filesystems. By huge I mean 5-10x for=
=20
sequential table scans.

I'm also wondering, in the past I was trying to see if it makes any=20
difference to tweak the setting /sys/block/sdX/queue/read_ahead_kb but=20
couldn't see any substantial change. Do you see it affecting your results,=
=20
with your patch applied? Or is btrfs following different code paths and=20
completely ignoring that?

>
>>> I removed all the extent locking as an experiment, as it is not really
>>> needed for safety in this single threaded test and did see an
>>> improvement but not full parity between 8k and 128k for the compressed
>>> file. I'll keep poking at the other sources of overhead in the builtin
>>> readahead logic and in calling btrfs_readahead more looping inside it.

Since your findings indicate that the issue is probably lock contention,=
=20
you might want to try /proc/lock_stat. It requires a kernel built with=20
CONFIG_LOCK_STAT, which is what blocks me at the moment, but it might be=
=20
easier for you if you already compile it for developing btrfs. Docs at:

https://docs.kernel.org/locking/lockstat.html


Thank you,
Dimitris


