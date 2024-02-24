Return-Path: <linux-btrfs+bounces-2725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A618627B7
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 22:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF441F22E00
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916CE487B6;
	Sat, 24 Feb 2024 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="IZLK/nl4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OfsPqBoz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB39C2D0
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Feb 2024 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708808859; cv=none; b=Jzxk/PdIOSXRZrARPftokgc7Gc5ctM4bUNVpovgQhNOi/mlcKKa3aFaXWdx+xC0DLTrhIaTZbLA/V60aECmEPpix55iJueMY8izuUM+Zj3nN0e5TNx3ampqFMZJRkOrduWqEsvpamVe++uJrx7V4Fa0GXqTQZRu1rR/hGCVGC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708808859; c=relaxed/simple;
	bh=ZmWtAHhihER2dQD63jVsvkDsHJXNi9h1mhkVjzNdo1Y=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=VRcrFUUULmDWVPzkLsa93I0ZG4c197CbwJfTnSZFxJEOPU9spKWedIv3fo8bo/mnrssRm+GeIMbbdaT9afHyJvQxQChqu/MyfmDjKKqdswp3aq7LKW8EWJvl5PWZjZQg12g0+QiCGxu7/I/tBP7HLwoblMBQCqzGrI0JxZlck38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=IZLK/nl4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OfsPqBoz; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id D39695C0068;
	Sat, 24 Feb 2024 16:07:35 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Sat, 24 Feb 2024 16:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1708808855; x=
	1708895255; bh=YekmPLq3dCiHa8+o/Wr4rxR2DhagI3SFKJ6KSVYfOiI=; b=I
	ZLK/nl4UHH2BNsdY7gjjb1fzTpflMIbBrUDWVIDS6RGdVrW3rbvALJshUepMG3yV
	sLOJHjbfYd+k6KRlMIHESGf1ouoQGp9CjlQ122Cna6ehAmzhR0wiwfUEjsmPBPV9
	igKnvA9HHbMqd6Z8eNpCbGt1w2HFKNPoAWW0JLduUm93ulwpVScD5wS9wYuy7MJ1
	TXwVQ1DoXCo4nPFzkzAfyUshVQMUHH4aXxUwjGT2rF0YYx292tickN1qVpjxooUX
	+3dF2cqTiBfr9kk0IbYwkoXnEjVW266TbrB5yru624im4IsiWsKj32l+mhaySVcb
	cd8MgkcQF1S1kx7KTxKbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708808855; x=1708895255; bh=YekmPLq3dCiHa8+o/Wr4rxR2Dhag
	I3SFKJ6KSVYfOiI=; b=OfsPqBozHsooeM5P5AwIl+b6Xcmh5fM/LG4WW4rI9P3H
	YH1JfFFCJJWP66Wa2fDrxs7GC19RimJ9FyeKEn04ZzCrUANvmlhcY4ooJoF9p0t6
	XiCHEyPqsHhSw2OSv+PkMAgHqsn7Hwqh++Y7fkZrg46YY8b4CiNExQwKXG3b5bsm
	2NyP3dJ7Mxm5dfwkCHCsdctj150DuZgpxftbRte4FqlWxaI7fNUwk+yhu5bmrolb
	nTZ2MjTE16gxKm4gqskfxU16sSLlPxu7gRZJHxYH/kGiaMBxSxSvEr4IEYzQQsoT
	mvCIJwTBne0PeurrT4ARk0BtOBF+o0geLrDyp0IIyA==
X-ME-Sender: <xms:l1raZeYwIIrEoqq8R1OBJn_ndCiKhnH3Il7OCS5Ck7fa-nYpjDAQrQ>
    <xme:l1raZRaSoYtRE2z9rwYF3hZj5Fnf9rZZBa877ts9QrvMYv4YD5Bf3_Nd2aPK7pghc
    G4H0xaGOIkR5JLcURc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeekgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevhhhr
    ihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
    eqnecuggftrfgrthhtvghrnhepudehieevueetgffhkeetkeelveffueeltdejvdejveev
    vdeggfefhfegvddugeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:l1raZY9Ps1SKPcmgHdVCTH5JBt5RS5AwLYng0HSi2lDwUMpCTl7yUA>
    <xmx:l1raZQrGisiiuY4EokAv35RPb3I96aoEPzX0tIqpHePvqWV0n1ykvQ>
    <xmx:l1raZZoSf4qWvkpb4Oimq00qAVDShmUBnX4bBSnYLCWHmt4furovAQ>
    <xmx:l1raZQ0Z_Nlk8iCRn_98OcYTsmWHlXr0-JGap-03FTnhVHmjSmtBSA>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5F9FA1700093; Sat, 24 Feb 2024 16:07:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <279e03a9-647a-4395-bb03-58c9d3fdb9a4@app.fastmail.com>
In-Reply-To: <cf9db9ba-96cf-440c-8ce0-d1caf7afa1c9@edcint.co.nz>
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
 <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
 <7382a5c8-726f-41b3-9cbf-b2c67f0a5419@suse.com>
 <0dd56988-e191-45c7-a3d7-60f43fc4b7fd@edcint.co.nz>
 <2b2d37d2-d618-44eb-97f8-549b99b7b4d1@edcint.co.nz>
 <4e2faa16-3021-4d53-9121-f41d86b428fd@gmx.com>
 <cf9db9ba-96cf-440c-8ce0-d1caf7afa1c9@edcint.co.nz>
Date: Sat, 24 Feb 2024 14:07:06 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Matthew Jurgens" <mjurgens@edcint.co.nz>,
 "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
 "Matthew Jurgens" <default@edcint.co.nz>, "Qu WenRuo" <wqu@suse.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: How to repair BTRFS
Content-Type: text/plain



On Sat, Feb 24, 2024, at 2:41 AM, Matthew Jurgens wrote:

> I have run a memtest for 5 hours with 4 passes and 0 errors

The linux-btrfs@ archive has anecdotal stories of memtest run for days not finding known memory problems. It really can take a long time. I would just take the system offline and run the memory test as long as you can tolerate it. Transient memory errors can take a while to show up.

Other ideas also floated, multiple concurrent gcc compile, somehow this stresses the system enough to trigger obvious memory induced corruption problem quicker with certain defects than memtest. Others have reported faster reports using memtester (a user space memory tester, which is more sophisticated but also leave a lot more memory untestable due to needing a much larger environment than a pre-boot environment tester).



-- 
Chris Murphy

