Return-Path: <linux-btrfs+bounces-6683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0141D93B500
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A63B1F21DD5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D404015ECE8;
	Wed, 24 Jul 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="GNvjCnR+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4E18E10;
	Wed, 24 Jul 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838574; cv=none; b=CADor7UZJrfChLd9L29rC6U5l1ZieDarcNkx23cJqtr89d/Vj7bgiCguH9VRivtdER1nwVtQkbCMJimNWRwfLJ1F+JqFiYK1kouQQTG/MXHOV1ph/vX/Vc6f9DBR6fewAYU+Xns8raRIbDfFp1K08hoyb2CA4O5SaSP5ZdG1QQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838574; c=relaxed/simple;
	bh=ftlPVIOI0qw+wGWV4oZk7tXzIkmFbPX/G5JK05JDslM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YWyXtyyFDSgh677R7hJADK9eHpB8RHfRv/Wzck1klx16GNtzd2lV9ax1W8FcLAkuU9ah5g/jK8xo98hXARFy3p/1z0yhyEZhj4jbaMGrd6WEPwKkrBoLoCXWok4FBbk2mKhe6o9CWOuDItSubxemmHGZCGk1FMsljhev4WVRkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=GNvjCnR+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721838555; x=1722443355; i=efault@gmx.de;
	bh=BYZjEGc4YVudcgENM058UCy6tfpRPmI4j7O72IWha4A=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GNvjCnR+JCF6N019EuyhqS7GZJiqw7uI/WKHdu7OeitiiAlnPSpS84ai86Qkg5cI
	 9kV0VjlBd/dKiF0SIHXv2TXbgWCNC8T6TlnO+k5twJ1JGQfxG0AkHkT7dN6uuvGb8
	 GZehGSPho95lNhXipBnF/28lg51a6lhhLMDaFb+JdioDXY/zdzy/uyMwADJNah1J5
	 eRGRHIz6vUyGuznJZdNTdv1ikJhhK9I43E8gcTePdlKLjTQ4ENBwoC3igl8xlEFTY
	 kwbKG3XHmhzLfredYsnRWHC53UcCXZe53DGThUv0RsRUxBZ9M6SiGI5lUp7pfexqq
	 gyAxanys1DiMtE8mkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.149.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mFY-1s9j6N2Sy4-00v2W4; Wed, 24
 Jul 2024 18:29:15 +0200
Message-ID: <684a1811297c210c6efd46c4e3c7b35e26b03b19.camel@gmx.de>
Subject: Re: [RFC] Slow down of LTP tests aiodio_sparse.c and dio_sparse.c
 in kernel 6.6
From: Mike Galbraith <efault@gmx.de>
To: Petr Vorel <pvorel@suse.cz>, Jan Kara <jack@suse.cz>
Cc: ltp@lists.linux.it, linux-block@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 fstests@vger.kernel.org,  Jens Axboe <axboe@kernel.dk>, David Sterba
 <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>, Amir Goldstein
 <amir73il@gmail.com>, Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato
 <andrea.cervesato@suse.com>, Avinesh Kumar <akumar@suse.de>, Peter Zijlstra
 <peterz@infradead.org>
Date: Wed, 24 Jul 2024 18:29:12 +0200
In-Reply-To: <20240724131816.GA950793@pevik>
References: <20240719174325.GA775414@pevik>
	 <20240722090012.mlvkaenuxar2x3vr@quack3> <20240724131816.GA950793@pevik>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UWBOdxjNJyiHG2TMf8ox0PHfBtgY/mgi9HVdGVCVaJ6bAC2k80K
 pJX+y2qWZIMkIrApXkmlHL43njiMk1SVnqwxHjR1mD6s2CHI4CYeAWedhJsoj9N/TsKqKIA
 /o+NP34ZIctcH8qSVkRTCL8jD3myGESZWtJYStR9jfaZYoSh2uWVLUpNF6QOc34v1hPkaAP
 rlhhj3zSmQb/XRHBskIhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w/bY2nrEeWs=;AiIwYn2wc/FW9jI/FqFfCpdARMX
 iqoRMTZi0UIEylmBl1YaRGGgPFmdn2SCXblzuV7oMvTzAKZ/kvcjPNGMONGQgv1hxfJyr+4Mo
 muDAcszKsTb2gi4E+fRsRExATUhgvw/dglYk6yTrzntZX5WzkEzS3yY8wRCvH4yBYz+dPv6td
 rqlqAeLj/iXUk3U1S46ur/yeDNAEdw2YcBNksl4FjjMKS4FuwtGYSageoV/aJcirrknlRGsLr
 f4kDKLCwhj4K5A/tz7DeKjYvbksXCHqASW0aSBAibZO/2df9CpEelRRlwXjRetMZ+xIXKJPDU
 ThqJr5UDC2NGZYnf47zhPuyvyDOaJBYzkfaracARc+LfVFolWob5aM5YF2T5Xcg1t+8sQh79A
 j5Kf6QEZFnr8j5ZAJxaDNRn9AXMCXfFMhWLSg0JLyBFlunHzlKrmuYf6069W5ZQJm4LGbYwL2
 k5FfrlwZe3LTU2/TsWfy90muX416/VIYHp8JAkD9m2h3jLuKlG6Qd8FQSarRV5ndC+GPfyVqo
 C1SOb9yIp+tvDxjHgPEIujGd3PBZE1yolF+zJbsVL5HI1SGBEP7bbWKzObzS41eX5M1+LYXD6
 dJe0w9S/Ps0A8sFdOGFqsb18yj63DsN/1AAfYmMKREdM0Ozl6S31Bowklcij9EaymWOJX8U/l
 3djLfIQTZFO1SJTxR3Ub/DggNZXf9nNKJBjiftM2fNQg5u3q4HH/viKd52zYtH7Kxerh5R/vG
 6DPIN2PfAsJsRtibe8zhiAhuvSdKgmZ0z52ZvVG52qf9icwwHgiu695mdhQu+KUQhxAqvxwF5
 +ZgeF1LO/BWulqYdRMbx+ErA==

On Wed, 2024-07-24 at 15:18 +0200, Petr Vorel wrote:
> Hi all,
>
>
> [ Cc Peter and Mike ]
> > Hi!
>
> > On Fri 19-07-24 19:43:25, Petr Vorel wrote:
> > > LTP AIO DIO tests aiodio_sparse.c [1] and dio_sparse.c [2] (using [3=
])
> > > slowed down on kernel 6.6 on Btrfs and XFS, when run with default
> > > parameters. These tests create 100 MB sparse file and write zeros (u=
sing
> > > libaio or O_DIRECT) while 16 other processes reads the buffer and ch=
eck
> > > only zero is there.
>
> > So the performance of this test is irrelevant because combining buffer=
ed
> > reads with direct IO writes was always in "better don't do it" territo=
ry.
> > Definitely not if you care about perfomance.
>
> > > Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS=
 on the
> > > same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not af=
fected.
> > > (Non default parameter creates much smaller file, thus the change is=
 not that
> > > obvious).
>
> > But still it's kind of curious what caused the 9x slow down. So I'd be
> > curious to know the result of the bisection :). Thanks for report!
>
> It looks to be the slowdown was introduced by commit 63304558ba5d
> ("sched/eevdf: Curb wakeup-preemption") [1] from v6.6-rc1.

That's not good, I'd rather not have over-zealous preemption back, my
box doesn't miss that one tiny bit.

Hrm... have you tried Peter's eevdf queue?  The DELAY_DEQUEUE feature
therein does good things for tbench, restoring pre-eevdf throughput.

	-Mike


