Return-Path: <linux-btrfs+bounces-10211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92549EBD5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 23:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D32282E4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 22:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2A52375F0;
	Tue, 10 Dec 2024 22:02:56 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from seagreen.cherry.relay.mailchannels.net (seagreen.cherry.relay.mailchannels.net [23.83.223.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BD71EE7DE
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868175; cv=pass; b=Lj2e5V/3j5URhua4bpIDW3y1v9aRHd6CyZ2UL5ysh4tSGPZh6bC/h0tNB8wtshS6e8NVAvaxvHZgqKka69e+7UTQ9D1ZFBZBepvWYmUwvuy1BveOK6fvPx2YtFvVPuoaoXCQl7HErDzzWzG2sEBnRJZ9KiGgnGycq1BhA40m9yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868175; c=relaxed/simple;
	bh=qf7SNII4RF2ZDUTilhwpO9n30za5wfZOI0i9TIlONqU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IOrfPIbU8j++CCHW4XHBagznKP043pyEBrAtX/9axe+ZioT70mpOJIcDLmTr2kFjuKehMhbqarrx4PPJKIgV81q3Xsyk92x5b5NffqGmnGjztZvF7Inmj56nYqNMvIuLXwF46HQo1/bGQ7gNbhfzEqLKWxkT0/0nZY6EQbXBWzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 67E94322721;
	Tue, 10 Dec 2024 22:02:46 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-101-211-3.trex-nlb.outbound.svc.cluster.local [100.101.211.3])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 741CB322F9A;
	Tue, 10 Dec 2024 22:02:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1733868165; a=rsa-sha256;
	cv=none;
	b=cEIw5Nc/4Rew/yqbVke0JAMqfAOCqPyw4ARvBmQ2hFYm4wXXPUDUH1Xeq5pEf+EsXqMSD8
	nTl+y21gMZqUWSXip1GklH5mAZ/uu8dV2/na8BEgbEtl3JxNRiit7U9XjlBJN41GK7HbVJ
	koZSVG/FKwhZMGqprKZGhumv94wHgvpULAtyL5tJ4B3TQQw5zMcBodrbKXpoQ9hSW9sDIb
	4Iaq5wiZERgB2yq8b19xaCZ00M8JpNyv+Br4yURCPf9NBPR3C8CkNOvSHnXfYhyUBdcLTq
	uImi8AOILGTfB1uJnKlUuhi6qFFUBar8Dk9tI2dUjecgug2/gBCwtYXSXafhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1733868165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qf7SNII4RF2ZDUTilhwpO9n30za5wfZOI0i9TIlONqU=;
	b=GUyrp6Rkv7XgzHJchAqV7TwgIoEHXLs8X8eejnbkY+YnMYRn1KZPZAdPtSKuaJ5iTPhOkp
	yaYdHfcrcaUluIOQUsFCD2VZAGcHc1mMatbIKNSKUQCIl5lk4sfw22zAe7EAriYYrmt6a8
	fqA9+UnRQca0DCy45O4tpxkNVD17IveF4F3n0vhHmrvNrm2dHp07O0pOg3ec+csWoJn4FQ
	Y/92r15H1g4FN0gzsLJ9iEEAf5XVi09UV7JxxDBZePR+4xOR7nQu7Fxb1j1V73uiXmmWse
	XCQ+dw0w0ubX4h+xJ7D+iiZbC4jCD4lBseDKFG9K2aSgY9hB2P9Vj3RI7Mz5ew==
ARC-Authentication-Results: i=1;
	rspamd-fc7fd4597-mxn8z;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Desert-Stop: 46bf8c944cada628_1733868166090_2520670777
X-MC-Loop-Signature: 1733868166090:1481229378
X-MC-Ingress-Time: 1733868166089
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.211.3 (trex/7.0.2);
	Tue, 10 Dec 2024 22:02:46 +0000
Received: from p5090f2d3.dip0.t-ipconnect.de ([80.144.242.211]:60351 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <calestyo@scientia.org>)
	id 1tL8JY-00000005Kj9-3tPq;
	Tue, 10 Dec 2024 22:02:43 +0000
Message-ID: <d8135ff262c4123c0aa0c8a7140f9093d31c3ae8.camel@scientia.org>
Subject: Re: super slow mounts and open_ctree failed
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Date: Tue, 10 Dec 2024 23:02:42 +0100
In-Reply-To: <84b36917-c7a1-49a0-98ab-569df0df6fab@gmx.com>
References: <9b9c4d2810abcca2f9f76e32220ed9a90febb235.camel@scientia.org>
	 <1067d68e-322a-4aa4-b72c-f07e21d3afdb@suse.com>
	 <ee6c1c04eed9b0bf56abd68013320fc05e6b3953.camel@scientia.org>
	 <84b36917-c7a1-49a0-98ab-569df0df6fab@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey

On Tue, 2024-12-10 at 11:44 +1030, Qu Wenruo wrote:
> Well, I was almost 100% sure, but not any more after you mentioned
> the
> hardware raid56 controller situation.

Our setup on the controller is, that there is one RAID6 over 22 HDDs
and one RAID1 over 2 SSDs.
On that one RAID6, I've created N virtual devices (in the controller),
each but the last 32 TiB.

What I found out meanwhile is, that the controller doesn't run that
background initialisation once over the whole RAID6, but apparently
actually in parallel over any virtual drive on the RAID6... which IMO
makes no sense, but well, it still does it. ^^

That makes it however quite likely, that all IO is sucked up by these
13 BGIs, especially when the controller doesn't notice the random reads
by btrfs' mount as such (which actually I can also imagine very well to
happen).


Still don't understand why the controller even started with that
background initialisation(s) in the first place (till then, only one
HDD had failed, and no replacement taken place... so this ain't a
rebuild).


> If degradation is involved it may greatly affect the random read
> performance, pushing the original more or less acceptable mount time
> to
> unacceptable.

Yes. Which would explain why it still works when I manually mount one
device from the emergency shell, but not, when systemd mounts all of
them in parallel when booting.


> But even in that case, block group tree should still work like a
> charm.
> Because previous if we need to read 16K (the number, not the size)
> leaves to find all block group items, we will only need around 30~40
> leaves to do the same thing.

Sounds like a pretty nice improvement :-)

Just as a side question: On my personal data HDDs, which tend to have
many snapshots (of the same data, but each snapshot typically just adds
files, not removes or changes them)... mount times also take longer and
longer the more snapshots I get.
Will that also be fixed with a block group tree?


> Even for degraded hardware raid56 array, 40 random reads on tree
> blocks
> should be no big deal at all.

In principle not, but if the controller gives nearly all IO to 13 in
parallel running background initialisation jobs, because it doesn't
recognise the "tiny" random reads by btrfs' mount as enough, to cause
the BGI being slowed down / suspended...

Cause as I've said, if I do sequential reads, I get pretty decent
transfer rates.


> > I mean we have production data on those systems and quite some
> > scientists from the LHC will probably not be too pleased if its
> > lost.
> > ;-)
>=20
> Although I can not say the same for the conversion tool though :(

I see.
But if you think recent progs versions are stable, it would indeed nice
to have that feature become the default soon :-)


> So if the data is priceless, I'd recommend not to convert, but let
> the
> hardware controller to do its silvering first to see if it can solve
> the
> performance.

Well, priceless is always relative... probably no one will die if data
is lost,... but it isn't the kind of "famous" one would want to get
within the LHC computing grid either ;-)

So I'll probably leave it and only switch to it on newer fs, and once
more recent btrfs progs versions have landed in the next Debian stable.


As usual, thanks for your community help efforts :-)


Cheers,
Chris.

