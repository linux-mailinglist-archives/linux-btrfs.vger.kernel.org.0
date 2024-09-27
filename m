Return-Path: <linux-btrfs+bounces-8308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541659889E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 20:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAA8283C26
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134FB1C175E;
	Fri, 27 Sep 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="qgaDsieT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbaDz4lF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788DAA920
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727460355; cv=none; b=aNSSXk9pchEc+my7GDVB9jXh0SaB/L3jSua8bFeQS6Jv0ivWGyh5znLNUlqvO3VwYhsduCnRnrF2b3no17rCkhXxn5Br6g7WKjnXtDU9Z5Aq4PL9TYXMTF8AynbDqHenydB8f3o6OyX5Ib43Na3qtjLOVh1EAmU7U3LaO/vJfoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727460355; c=relaxed/simple;
	bh=ac3z30GvZ4X38QVY2dx1o4yJt98/IzbTErCL1gFYDf4=;
	h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=atdnoSHFsWUT0kJF45Mknbdvp5SdgG5bRgaoHCkpVEtihsMNIm16PxuaE+SDsHr2oOISAMNxgyP9d6Bh6/F8rujdilStGeud5JTQJOeBq+f+IrqkLobsdd9jk3BS/XD2bP/lwixn3e9URH3RqSZc7tJwJ6Ou2rbQ61Yxu17ki5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com; spf=pass smtp.mailfrom=georgianit.com; dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b=qgaDsieT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbaDz4lF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=georgianit.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F920114016B;
	Fri, 27 Sep 2024 14:05:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 27 Sep 2024 14:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1727460351; x=1727546751; bh=ac3z30GvZ4X38QVY2dx1o4yJt98/IzbT
	ErCL1gFYDf4=; b=qgaDsieTqcqaDMb7mey24ARluiWQdHsyBvGKtxxqoEleQShY
	9rzG0PiG/uNlvLQzosKDaS7pOqEcH5M8UE1OXEWRBydBrm+71niQpT8gP7Ad2eQM
	HY0otRfAjGRcVVEXaNTHNi18MPKZZ0FCJXZKLFF0s6nN6Pkd4ZlPFhV0HmPeAyN7
	qGNKD0v1UQLo2r+VPJ/GsDzwYmGQn7qXYt5FCA5mgCXoG/ospJ9wqinuinosQlaW
	e+gP58QS19biByJQSJ/mUpAKyKvlc7EG/FOijZ/Cu8zzXxovXInbDqxsqmbHheyH
	MRv7GOtCrX4V/mj2ECVRVl9U8yhicP+8nlzU7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727460351; x=
	1727546751; bh=ac3z30GvZ4X38QVY2dx1o4yJt98/IzbTErCL1gFYDf4=; b=I
	baDz4lF20fw9JL48HAwmPUKyAKzjVUu4Y4KufkyIu4ZPBM747HPHoFEIFDLRSiyt
	Yn9OzsEcOczEYlHN8ioeLtBVBRe8UyciWx8IaUsLL33P/Jx57CZvvLLtl8rzO19C
	UjsDZDKtsdx3GuLwNGtin3PiGQwesRPidZVnM8tGSJc9cjPqQHj/Atsz6deXTgqA
	lwN/ervTmkDFNkbf1h+XN9ZL5n+BQwXmbrc1MEjNwfRUG7NrtKgjnLn1I1U+LK1E
	nm944yqD5HWn8N7lAewmdcWw03ipdAqu+POqrVhKulX8QBwOS6nvosJ/zkyPWhQ7
	Z5IRstir7qpLpwDPVG2HA==
X-ME-Sender: <xms:__P2Zq_IPhfuXfoQenZAT5_3oKmdAsxTX9HF5laVsjwlKP8MiV26pw>
    <xme:__P2ZqvIUlmXh4rvnA2BTEKcB-Atm1O7aW6-jc9rRe8GKNpO6RkCn4IdT_bmDVaNW
    33Dcymqoa-KxM6Ohw>
X-ME-Received: <xmr:__P2ZgBrjaer_slnZjDswIi1jq67Hbq6MSn9X1gziM9wfuVIS_djTLANc3UXiFgJXpNSgZSPQl7sCgQGs99QsAMH6R5PhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefvvehfhffukffffgggjggtgfesthhqredttdef
    jeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnih
    htrdgtohhmqeenucggtffrrghtthgvrhhnpeejfedufeegleeltdffveduueeuvdevvdel
    teeliedtgedtleeiheefieeiveelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfigrgihhvggr
    ugesughirhhttggvlhhlrghrrdhnvghtpdhrtghpthhtoheprhhmsehrohhmrghnrhhmrd
    hnvght
X-ME-Proxy: <xmx:__P2Zif7O07cRHSvrEQSzdnzQxMK6M1g8UnPf0iHIKnQ4afkBRqtuA>
    <xmx:__P2ZvO9Zsnf80tZDLxzAtxFm7i_XR6wh9AQq2QfJZloNfRjiGh3cA>
    <xmx:__P2ZsnOUWaTFGemGZYdooogiNgoJD8yEYK5iskHCYRo1WTcFZuA-A>
    <xmx:__P2Zhszh3JD6i-NDVfbE1nsLC2IzqyjklcEdGY8pJN1ZerSmK_gqA>
    <xmx:__P2Zorkr5_crUlvr8cw3nDPqb2bIm6LVcbuW39uPPlr4PLjI__RhNcJ>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 14:05:50 -0400 (EDT)
To: Roman Mamedov <rm@romanrm.net>, waxhead <waxhead@dirtcellar.net>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
 <20240927212755.5b24ecd4@nvm>
From: Remi Gauvin <remi@georgianit.com>
Subject: Re: BTRFS list of grievances
Message-ID: <03de7723-0be2-a153-d264-a1024be3c2b8@georgianit.com>
Date: Fri, 27 Sep 2024 14:05:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240927212755.5b24ecd4@nvm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 2024-09-27 12:27 p.m., Roman Mamedov wrote:
>
> Or if not, then how do you get from there to a consistent state? Run a =
scrub,
> make the system reread the entire 40 TB of data, correcting errors and =
lack of
> duplication where necessary.
>

The BTRFS handling of this situation is actually worse.

The often given, (and entirely too simple) answer is to scrub.=C2=A0 But =
this
has several caveats.


1. The system will not detect the error state automatically.=C2=A0 So fix=
ing
this requires the admin to be actively monitoring for errors to detect
the missed writes.=C2=A0 (regular monitoring of btrfs dev stats and aller=
t on
errors is required.)

2.=C2=A0 Any files that are stored on on the device with CoW Disabled wil=
l
not be fixed, and the two copies will be different, with no real way to
detect or fix.=C2=A0 There are packages that disable CoW on files by
default.=C2=A0 (systemd log files, but probably more concerning, and virt=
ual
disk created by libvirt, for example. (Some amount of divergence can
happen at any unclean shutdown in this scenario)

3. I don't have exact math at my fingertips, but with enough failed
writes, the chances of a CRC32 collision of the stale data leaving
unfixed/corrupted data behind gets fairly high.

For reasons of 2 and 3, the only way to fix this without increasing
chance of data corruption is to replace the previously disconnected
drive to a hot spare. (with the -r option to btrfs replace.)





