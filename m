Return-Path: <linux-btrfs+bounces-13525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B6AA1B27
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 21:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF4A9C0257
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 19:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6212259C8D;
	Tue, 29 Apr 2025 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="KERLm/kn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gF7NvBwr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58E216E30
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953785; cv=none; b=Eq+3nVw8yO5d+fxF6hWGHiBUelg1zMg/A8V43xEMHVMSX2ujc2T2oyjHqW7BP58DMdkBeJl67R1H4vgwsIr6X+wvAMAKMjdGRbAEiWncHAqYjRA8/PrP/dvwLe5vW2WORVCFbtvA23zAM+ik3aPlTaz4b/QCXMhAQESQB/AD2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953785; c=relaxed/simple;
	bh=lqNsNP4fdG6PAmP7R956fkiNnGG69cZFm6NerVxusd0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lOChbASQDXFA69i+OYpXf2f2E6ECTReFaLscBbLzQA40kMbfxbC4168j+FSJWt+4T6Q84yZ4WAB7OBEStP/csLXMG6xjHMufAWaZqmuL9lBuIg9gJXhF7A+lYOLyvxuLX3E6slnTwhkXLx58pOGvJTzr/YPYWG91yd8frlPToRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=KERLm/kn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gF7NvBwr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A8CAA13803EA;
	Tue, 29 Apr 2025 15:09:41 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Tue, 29 Apr 2025 15:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1745953781; x=1746040181; bh=mW5BpemCyN03qtTAVOiDo
	f7W6kfVJIvuVAvbsbFutxA=; b=KERLm/knYzTnn8i/goj+1nad1V2Ot6sAdQ8nA
	dsJD/hp1KOZddBNAGykENa2/4fAYiEk0u5Ba2ozFlzpAhPKewUU/aMkfgHBB1UVb
	MxoI7PhDaPJeHbmSXERDO/3xifid1kb1lWPTMCQNWsZXhjx34MjMae52Mie+HgPr
	sBzSrtE9IogbfQ/1ca6twckKDECcD60rjlJ2BDF7+C48T5HDhvkSE/1NciUkgOEl
	gfQidfafoAoathcwfaevIDnjdKPJg96T0J7JXffoi3s6n2sB0+jP2wPeiUmtol/z
	jx4YKQ3pnPnmJxtn5kdyHK1MtF2bDZPW0YBkN7HVPjtAy3dmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1745953781; x=1746040181; bh=m
	W5BpemCyN03qtTAVOiDof7W6kfVJIvuVAvbsbFutxA=; b=gF7NvBwrYoEHz1qF8
	OD3t3FyHBkKZksm4Df9MvtdmdSWUPs+CNBosBkBazqJorx4fuaiR1e/uL+iJ9sp5
	hAZbI16bT7NFxRCf0w1eiAHxlkXjyAoXjyfdIeOKeVhRGIBh7MjigjZ/TqmVwydy
	daNoQ5uYqEiD1322JL/GBFdmVuPgzBSJVfIEzOWWSLul+dIRNu8LGUyb0mIbfo9+
	2B/Xd0k0TLpHKa28vwkE/uR0OmtZ7WRQJQuoKdcHKM4An4zekg/bZ2UqCcxGox5s
	7KuBfrXKf+/Xgoc1yLfJ0y3SrCmkRLLqHguDeRyPIF1LBePaj8vOxYkl0KoZB+lH
	rnbFQ==
X-ME-Sender: <xms:9SMRaExPbJiSzsVb361oFfCSxrV6eN2eyj7OPanASh8fXvBaOK0THw>
    <xme:9SMRaIQnYn_rY718i9a_bdEegxhrGMQb8RIJqL5VFHJQOT-Xj2iKNyevZ2JdbNs_6
    CC-8tqOSsvv2G3GGkI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorh
    hrvghmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhepteefudehkeehgeekhfdv
    gefhjedvveeuhfdtgfejgfevieeviedvfedvhfevvdegnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvggu
    ihgvshdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepqhhufigvnhhruhhordgsthhrfhhssehgmhigrdgtohhmpdhrtghpthhtohep
    mhgrshhsihhmohdrsgesghhmgidrnhgvthdprhgtphhtthhopehlihhnuhigqdgsthhrfh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9SMRaGXDW0l8Bx-zy7GmFwMKn_vthj5OeHoNmyTjCxbA3T8Ip_S8Lg>
    <xmx:9SMRaChcnqnaQphhCvrt1HBiNijouCeqMkvfTubGFrENGxjCvrSjoA>
    <xmx:9SMRaGDxXGA7oFQowO1f1YuQYuC5I_HwRCcGX-JMhnN-sQbD22GBBA>
    <xmx:9SMRaDKi1c3Vl56AWZTnf6c0FjcrZ8mf1yFSMhGefW2WTcwG0-iZQQ>
    <xmx:9SMRaNIqOmHsV2QsJAmXhEYER3cvreTAEtyDzQmMygFG5rBRXsmTVjXX>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5CD451C2006A; Tue, 29 Apr 2025 15:09:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T5ae035d0611cce84
Date: Tue, 29 Apr 2025 12:09:21 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu Wenruo" <quwenruo.btrfs@gmx.com>, "Massimo B." <massimo.b@gmx.net>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <7c762297-2425-439a-916c-e61c0403c1fb@app.fastmail.com>
In-Reply-To: <bb9b6bd4-6638-4139-8ccc-dc677f85e3a2@gmx.com>
References: <180daac980bec43d45d0e6fa4f9e1d14fb126de1.camel@gmx.net>
 <bb9b6bd4-6638-4139-8ccc-dc677f85e3a2@gmx.com>
Subject: Re: bad tree block start, how to repair
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Apr 26, 2025, at 3:08 AM, Qu Wenruo wrote:
> Unfortunately I'm not aware of tools that can drop a corrupted free 
> space tree (the existing tools all requires a working free space tree to 
> drop free space tree...).

I thought btrfs check --clear-space-cache v1|v2 will just remove it, and it gets rebuilt by the kernel at the next mount by using the extent tree? It seems fast enough it's not actually checking the tree for validity?

Is the btrfs rescue clear-space-cache <v1|v2> essentially the same code as the check subcommand? Or is there a meaningful difference between them?

-- 
Chris Murphy

