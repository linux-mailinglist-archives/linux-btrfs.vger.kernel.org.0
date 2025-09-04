Return-Path: <linux-btrfs+bounces-16624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B94B443EA
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 19:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6336716E979
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C3B3093DE;
	Thu,  4 Sep 2025 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="enzqpNUD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvgJMiNk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251D2D3731;
	Thu,  4 Sep 2025 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005690; cv=none; b=d5E/tcJt1CyLFpSZu0ynHAM7BJ/z3Om3v21MR+6EIqRK4uDnMcJaHI5OO39yZ1XIWtUiCy1EwtZ7WXZlY8jRTdfEpVAjmgCz6U6EWUCtjxoNrZto6GIyIPzU7eMhP81GNKwEVdoFprSSJj++L/DcLNhDz3H1OdSdF4h/1axbpuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005690; c=relaxed/simple;
	bh=Aj/OVRwW5kxYOThShXwyfouSm/7ljjHYWAweFUmu38A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UQ8pKZbhDYrghVEscTzk5uwIhKk3oL8RYK9BAKO27ix6v9OqpDqSog4MSBrUktUjmyT+I6lIzglRRlxhC9uCacpwSw60b5050+tF9SZkV8AuzXTKwBFNUZvOThl+7ZtcoQdAo1tbW2EmIBBW1DfE1COGb7dDioczNM7ItACHzag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=enzqpNUD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OvgJMiNk; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B5E17A03E8;
	Thu,  4 Sep 2025 13:08:07 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Thu, 04 Sep 2025 13:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757005687; x=1757092087; bh=dDk28bcgI0
	GyFMIbbY33M3Yn0KdYN90r6j3KGkJeiHg=; b=enzqpNUD55iJsFzu2mG6gAg4hi
	threPySO9UBX4Ax6lVt9qfs6rigV1Wd43m4pJcK1+dy7gqHCr27fP4D1GN4iyoMV
	jU6ok1D8C7aBJ7oQPFmF+HXkjr19gARO3N0k1I8TCK/iMEqwfH3J53t8xEeujvaB
	G/IvRXF3k+V/n9+km3c3sLNKx1yuiK+MKKQsqt78TlcT9d4tEML2+lhLnGDDPswh
	+tvoTAY+BjLp7pCZwSNceu9HCJsAn5Y017pUjM1L2qectqDHkjow2YYvKv+FXRwU
	AY3tVSalf4YS+Pr5aEMXK0C2saoIPMLrPO6AeM9OwpFdSbx/VM2cZrv/A95Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757005687; x=
	1757092087; bh=dDk28bcgI0GyFMIbbY33M3Yn0KdYN90r6j3KGkJeiHg=; b=O
	vgJMiNkUU25PMiJERuj/31199CId96/WeFUCpmR5b4BWgbWGVkkyuC18Dn6hRTgB
	Xti4nV8HFuvj3tMGyDaqi1z8kNElUGTNyV/rqRcfibJTlYdLOfVI0gg4sy41SkXr
	mYkKeaD6WGhQajilKa8wIxDzde2OAUQHyR9yl6xlT0CIHC11WGP25ZynBKWHBQpd
	3ZDYGcAv9d85ocxTnt6RMyVfqAaJnKWofBKOchrnRFEiroj8u3YuIDWPO+k7ZoPC
	E3ycE3KJI1JYSuzuwEqTf2ccovsjUfAoo//UHwIa+tS0xKvBS3W3CprDalwllhGd
	wXLdwSD8ID18f17MPo3XQ==
X-ME-Sender: <xms:dse5aPTbDSTGn9JbBz9AVYrHowE_LnXttDqOLl-sZKZsPvHQ7_yakw>
    <xme:dse5aAz7aXIcsXXuAxiTzUADJ-tZ0ATHqQ5XcLIurUK8jzkZq1TeHwmkv186bv1vl
    PMN6MkyDCAwyFHxGBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhishcu
    ofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefhuedvkeetudehgfethfevtdefiefgffehvefhveeuffefvddt
    geeiffelffelgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlkhhpsehinhhtvghlrd
    gtohhmpdhrtghpthhtohepohhlihhvvghrrdhsrghnghesihhnthgvlhdrtghomhdprhgt
    phhtthhopehovgdqlhhkpheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    gushhtvghrsggrsehsuhhsvgdrtghomhdprhgtphhtthhopeifqhhusehsuhhsvgdrtgho
    mhdprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdrtgiipdhrtghpthhtoheplhhinh
    hugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dse5aMy_sx5b98kxmOp0AjpChn1ukpTNGYd5-RJ17yoAIKXYDo_oWg>
    <xmx:dse5aNLGB9DJtiqwmuazXM8HpzwyFQogRi2M6MFOUZGrr-42LayK1Q>
    <xmx:dse5aOEIFQPnCXaErk8286Eo7yLoMYQUatH5iddtT-DJqJYLi8bNMA>
    <xmx:dse5aJ8d2wRJpWmo-uUr8z5UiildzXRHwxCe_hJQ5YSbGqbTQe6sFA>
    <xmx:d8e5aFoZT9hiNwop4N9YH890Er8bgaoAxxETwnH8I6cpKTZQ0BHq47HT>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5713518C0067; Thu,  4 Sep 2025 13:08:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVNDbmFqk_xc
Date: Thu, 04 Sep 2025 13:07:44 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "David Sterba" <dsterba@suse.cz>, "Qu WenRuo" <wqu@suse.com>
Cc: "kernel test robot" <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel <linux-kernel@vger.kernel.org>,
 "David Sterba" <dsterba@suse.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <7302d357-b42f-4874-af59-43ad03a0b47f@app.fastmail.com>
In-Reply-To: <20250904143415.GL5333@suse.cz>
References: <202509031643.303d114c-lkp@intel.com>
 <9d6db7e9-318f-4242-9883-9eee8ee20f5e@suse.com>
 <20250904143415.GL5333@suse.cz>
Subject: Re: [linus:master] [btrfs] bddf57a707: stress-ng.sync-file.ops_per_sec 44.2%
 regression
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Sep 4, 2025, at 10:34 AM, David Sterba wrote:
> On Wed, Sep 03, 2025 at 06:18:01PM +0930, Qu Wenruo wrote:
>> This doesn't sound sane to me.
>> 
>> The two commits are only affecting btrfs mounting/unmounting, I can not 
>> make any sense on why they would affect performance.
>> 
>> Or does stress-ng doing a lot of mounting/unmounting?
>
> Yeah, unless there's some indirect way how mount affects the tests the
> numbers do not match the identified patches. The difference is roughly
> consistent in all the stats to be about 40% less so it's like it's doing
> half of the work. Delayed device opening does not explain that.

Does the test run on qemu/kvm? Could cache mode and host workload affect the result?

If it were unsafe mode, the guest very quickly thinks the write is on stable media even though the host can significantly delay writing to stable media. Whereas directsync mode might be really slow since the host must commit to stable media before the guest sees it as on stable media.


-- 
Chris Murphy

