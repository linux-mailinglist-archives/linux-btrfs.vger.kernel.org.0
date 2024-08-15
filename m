Return-Path: <linux-btrfs+bounces-7205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9095272F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 02:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FC81C21812
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 00:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09556FC3;
	Thu, 15 Aug 2024 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="o5kxpeoM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oOfZH6Bs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21FF63C
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 00:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683216; cv=none; b=eoeIuY2loHrG1j9IDOc4mO5EX43PtTWnfLZtaE9CSlSVDfHKzWLldkU3osWlYbcyd830JwnYcfKinwggfHmGrajR0AxWxH1Z99TX5EnusWchQY6Ep+eoV8KFhEEleTgBD0Gly+7Q522mSOfQ+cNcXpRVb7w6bdf113cUp7posyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683216; c=relaxed/simple;
	bh=j2I61to9lYxwwRTJsVfCJ5nMfG/xaeVhSWPMLdrqYlU=;
	h=To:References:From:Subject:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lEXRpWOXH/Q5PXXDKMvMRQZYzJWGeUqKfvvLRLOVr0BDuW6NNOnDpn6KmIadzZA6BH6zQLJbKMgrcVHYaNVO5ud5L71i1tlWpzVLvwRad0afnLqG/B7/i/H6n6Kn4T3lvH3yhShVSFA5X8TbX+kgpmoK1r0IKKESZSPx2lH3TAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com; spf=pass smtp.mailfrom=georgianit.com; dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b=o5kxpeoM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oOfZH6Bs; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=georgianit.com
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C5B55114FF30;
	Wed, 14 Aug 2024 20:53:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 20:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723683212;
	 x=1723769612; bh=j2I61to9lYxwwRTJsVfCJ5nMfG/xaeVhSWPMLdrqYlU=; b=
	o5kxpeoMYK1ZWNyUGLRbXvuKnsZL9qy4a7sQf2dYnXu33ji/bFWFdx5Fz0Rl9Jiq
	635keJ92xbKcdSdhgEDq2t6o+xHltDGm8yfBV6NmRIwgqHhwmubZEdga1jXL5neT
	G7pOrcGqH/y0cIZiNGs7lZr18fZ3hZZcPOOiEQm2VZjUkIpeXoudyb4mWSy4MzJ5
	EDvC9n0QA7CZ2+zx2zOzoVa4su32+QmG2dksMMtd7rT3dGxspIR0Ll0gcTM90HZl
	9iTX14/As1WxOQVj+mk2hiU2r+Toaz9coHwySHpIkTtPSywAqrKP25hG6/27N2vV
	l/dF9OXDY9BAcvqqHPK2FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723683212; x=
	1723769612; bh=j2I61to9lYxwwRTJsVfCJ5nMfG/xaeVhSWPMLdrqYlU=; b=o
	OfZH6BsjqBUdlnZejk2m7V3T7cxVVPu19RIk9oBzlhuARU/rvCQjMIJ2HAULly+b
	LrXRC1WbkARhEFysF5si58lsjZm8sg4Dnaqm+5GKmebexrywCHdexWchfiFITePi
	TdW1A903V9bSXgz+3nmewqCnlW8D6+FOl99pfRsS8Ut3DIJxPXBLq9LWblmIP11a
	ZD+ViYozBWSRve2JGIbmYhxE5H72S4hwVhdx0lSsijN3IPQksUBwlDMCG5mN/kiQ
	THjkvUH13GZs7hTUiB9cRCbUp08F+SHhZ8J6OxK0Lq/zxERAIJjbhAabYspCm3Qr
	niHTaJ4bQ6k6cMWEnrtJQ==
X-ME-Sender: <xms:jFG9Zi3WloHXQwLqzuyXD633c5E38rgmFb6c4I0f2CFApb4NIOZ8EQ>
    <xme:jFG9ZlG7F3Fl1Ayfwr9w10gjpYp-gz6G0mgIIS4P9khtwjFXE_3WomaCe-NjYykCc
    hyJZZwiHvm6LUsHhw>
X-ME-Received: <xmr:jFG9Zq7fcV1bXvyCbYRQGg5LyACjJdldxuiwCYGrhHcChUSpFdd546M7oBvRb4iLEWM_GxTvxNeIQT736cH6WNdhwFLJDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefvfhfhuf
    fkffgfgggjtgfgsehtqhertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceo
    rhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhepvdffke
    fgudejieduvddvvedtveegiefhledvvdfghefhvefgleeiuddvtdduffffnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorh
    hgihgrnhhithdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdgsthhrfhhsqdhmlhesiigvthgrfhhlvggvthdrtgho
    mh
X-ME-Proxy: <xmx:jFG9Zj39vXX-xR0I6mI0pGKQ_tyyvymYmBgHJdoG0xul2w8y1mZbNw>
    <xmx:jFG9ZlFl6Wnd8mT2TqP0rhwX4BMLSAt_8vbTe7jRnqaWC5lBQcx3Dg>
    <xmx:jFG9Zs-F-e4_FPAe9di2pmjiF_udYzEaBX1CQOuZsiffB8oXuBRTPg>
    <xmx:jFG9ZqmE5z1-kOtGyxd6RD3uEgi677jTO-abELXSiS7L30aix6dfLA>
    <xmx:jFG9ZqRrg01gMQQkd1QQNVPVoEuPajuVn0UGc3hrFGBNYcs5ibWnDh7T>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 20:53:32 -0400 (EDT)
To: Colin S <linux-btrfs-ml@zetafleet.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <55c3f03d-a650-4193-8982-ffcb70575c2e@zetafleet.com>
From: Remi Gauvin <remi@georgianit.com>
Subject: Re: Needed improvements for raid1 integrity and availability
Message-ID: <83f9d3d8-f7f2-b9f1-7239-2a6cd31e5a8b@georgianit.com>
Date: Wed, 14 Aug 2024 20:53:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <55c3f03d-a650-4193-8982-ffcb70575c2e@zetafleet.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 2024-08-13 5:07 p.m., Colin S wrote:
>
>
> I would also suggest stability status for raid1 should only be =E2=80=9C=
mostly
> OK=E2=80=9D in status page documentation until at least items 1 & 2 fro=
m above
> are implemented, since currently btrfs raid1 does not assure data
> integrity to the same level as mdadm raid1 in this common failure
> scenario.


I agree with everything you've said here, but I will also offer a
counter example.

There have been many times I consider stopping all use of btrfs raid and
use btrfs (for snapshotting) over mdraid only.=C2=A0 But on a regular bas=
is,
(4 so far) I encounter a situation where btrfs saves my data where
traditional raid would have silently corrupted it.=C2=A0 The most recent
example was a 2 device raid 1 where both ssd's were experiencing
thousands of bad sectors. I had run a scrub week prior and, though the
drives reported more bad sectors and read failures, there was no data
corruption.=C2=A0 At the time I actually replaced the 1st drive, however,=
 (I
chose to read from the drive with the lease bad sectors so far,) Btrfs
completed the recovery with 5 crc errors from the drive I was reading
from (over and above bad sector read failures.)



