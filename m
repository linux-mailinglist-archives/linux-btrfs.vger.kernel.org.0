Return-Path: <linux-btrfs+bounces-8516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A898F628
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 20:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221541C218AF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 18:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743A1A7076;
	Thu,  3 Oct 2024 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="XyPn6iyQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="McK5DSeo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1CBA41
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980350; cv=none; b=hkMihPJ7hnIwPrD9fOBYXHyLJ92cxnpRBFTw23UPmF2Rv40w1EO3F+MrUe8EhAfCn/0iUakv2N8towS0ugwrudmVJAx5Tcu9G+J5mfoghb6GLmTh3zQ/ca7RZ4QfzcWbM4LXQgdrpid/OtN+fTHe7wlvyta64JPTxrNyI1lWXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980350; c=relaxed/simple;
	bh=hCzV0hr5zykgu3ekNANywQ3rckfr7IPW91DstsymL68=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uBLeQp8zWw3IqIFt0gsjrMYwD83LdBHWxmwJ0pEbbq86DJfxnLcO4kYKvYHIhUvBULlW9nSD9O3UhM9y+yW2iQkB8zz7Cz6RTSKKDfJzwHtLEssp6gheqVQaM1vqGg/298m+fQu++I2K9vNr+gtMaOUMI2lAB1JRIf8izzlbPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com; spf=pass smtp.mailfrom=georgianit.com; dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b=XyPn6iyQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=McK5DSeo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=georgianit.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 9AD7D13801E2;
	Thu,  3 Oct 2024 14:32:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 03 Oct 2024 14:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1727980346; x=1728066746; bh=hCzV0hr5zykgu3ekNANywQ3rckfr7IPW
	91DstsymL68=; b=XyPn6iyQnO8fZxguwkxCmHiN4leOmS4wI8l4huPW1vFZHCr6
	XE0XB0BfwFxlcDedUhAjdRl01eIrpi6qCj7hMsK5Mfv73PlMyGJ9lTM4j0+Mo+Qh
	LVW5nSZp4ImzD9DUrINHA+pHgjqAaqMKhyN8Fxe+b6sMbWSxbcPwwYld8e+7H+EE
	L03Skd1NRAgP4n1+HwHwxCxsO82tojm2YCN/dB46Ip0OtVOV23J8BwsP5jBVF1Ak
	8zhZ2Mqojy5IYHZ/+yJ4URkP/ZboNPMWQKM5qYesk+a3mdFP+Hiwg/qXQoo4Qcof
	LAWKTt31lwhArOGsjTna7VGhiGg7ve7U+b62bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727980346; x=
	1728066746; bh=hCzV0hr5zykgu3ekNANywQ3rckfr7IPW91DstsymL68=; b=M
	cK5DSeooBqX6oDkkYj0We3UGj+7y6DR7hdj+Y+ZVGMVD1UhI3SnIN/doCdSFCPNH
	TVBus9hstdvz2uCBcoJw1HOlTUXhGpuocDcIrXo0VS+ec87zrrfukdlQ5sIu/bIg
	rjCxp79QoKI0XHuuJ/spECHiyTavif35QiAQc0vHOOYHH/Ld4ga+sBT34JLmn94u
	fOoECqsiJX3w3L5jY6zSng2KnIlaiOQ+R2NA1GeugUmZ08cC4yL+03fryE4wgr/t
	SzzTwr5BEogOG5UhQ4VB7oxGbpFi2VDNrg/0cYsh/v+exk6gWuJYG9oWzqAmmPCE
	REO6XXb9jNRZ5l2lgQcuw==
X-ME-Sender: <xms:OuP-ZqdandOWupKjLehvduB0-_cNqEv4f5Zz9Scr9LUE5LK-YlKclQ>
    <xme:OuP-ZkO_WyW26rZ4Xh75wnE1L7jp5QhE-Er18qynAwhHeTv6ksh4Sbg8JiDHKhOaC
    HriQJGYO7d87MkTCA>
X-ME-Received: <xmr:OuP-Zrj5CrmQ7ML2FhOMUuLtEHhckuALLJ-FoO94pY5hqRZKf8TbmKbyAt5sHn7z97JIa0NR2VXkq6FczwQ5KG3LTWANaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdef
    jeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnih
    htrdgtohhmqeenucggtffrrghtthgvrhhnpeefgfeivdefgeffteeffffgtdduleevgeej
    udevheegtdevteegjeelffeuffehkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhmpdhnsggp
    rhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrvghijhgr
    tghksehinhifihhnugdrihht
X-ME-Proxy: <xmx:OuP-Zn8Pi7BeyYvMJcA0AqmCIoafa83xNRVzt8Ynw2EsXpp0CoQ8Ew>
    <xmx:OuP-Zmt3ecL3GwQ-HWNVRuoQhZhaOFBlPH5f5qO-TMnY6VnndsoDGg>
    <xmx:OuP-ZuGWjFBPjGB6llbCdrCXz9DUNClthxTWJJr4Aeu9RG2gFdD1Kw>
    <xmx:OuP-ZlP1c0MyFm1CNmdEns3g4NhLGQ4ogOWHSn4embQTgrcTgJV9yQ>
    <xmx:OuP-Zv7mFfejtO_VS5m9yJhoO4kV1S2y6Ba1m0SuNoKo2ccXSVA6V-Ul>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 14:32:26 -0400 (EDT)
Subject: Re: BTRFS list of grievances
To: kreijack@inwind.it
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
 <4f672a82-28d8-490e-bdce-e794748d41fd@libero.it>
 <401088cf-85c0-4ea2-bc4c-b34138eae5e9@libero.it>
 <8236a191-88d5-b2bb-2048-87b49539a8a3@georgianit.com>
 <2733d961-cef0-4fac-8a46-3d74f1c4bf7a@inwind.it>
From: Remi Gauvin <remi@georgianit.com>
Message-ID: <9fe02f8f-9ad0-56a1-08a6-7949177adce6@georgianit.com>
Date: Thu, 3 Oct 2024 14:32:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2733d961-cef0-4fac-8a46-3d74f1c4bf7a@inwind.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

On 2024-10-03 2:24 p.m., Goffredo Baroncelli wrote:
>
>>
>
> It is a real output, and I didn't notice these errors.
>
> This was an old disks set. And these are old errors, due to a bad
> power supply.
> Replaced the power supply all the problem disappeared.
>
> Of course I didn't have any data issue, due to btrfs+raid1.
>
> However I never cared to clear those errors. Anyway I run a "btrfs scrub"
> which didn't find any error.



An excellent example of btrfs doing it's job as advertised!.. I would
suggest resetting the counters though, so future problems will be easy
to spot.



