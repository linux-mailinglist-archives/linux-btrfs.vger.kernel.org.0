Return-Path: <linux-btrfs+bounces-12897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F97DA81B0F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 04:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D6C7A61D8
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 02:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84E613C9B3;
	Wed,  9 Apr 2025 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="fV6F0ydL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXDVe6pT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DDB1C32
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165999; cv=none; b=qndAqrH+Ankszt8p+57x6onofWnwNBjFWF5sxCo4eBJQeA5mDukH3BboUpP8lJiacQ8ugj7thg2gVtfqEYFwPDhcndX/4ParlHpSf9+q8UbBTECmtaVUGRia5/J8a3ZBfOEVB2x8+fVVSIdlhwL/Y4zosrSJCaZiroivvn3UBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165999; c=relaxed/simple;
	bh=x1Y/SQFT6nmNFmezu+FJVXRqr50tcn44b2TWU2emMjI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XqtELwR37xyNce8fLPYGhpwLWMYr0L+3ZgFkAwqcY/DPUc8XL3umzefXHW4hVH61hbSiQ6SzGgC8gTkoWIQ3HimqXuYrgmyuOMuBqdf81/fOwLHleoS7vvwYSgXOYVeZSyS2fxIgqKNMdTQjZEc76yoqTjZX4LvUxGb7yPzkEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=fV6F0ydL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXDVe6pT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 794CA1140198;
	Tue,  8 Apr 2025 22:33:14 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Tue, 08 Apr 2025 22:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1744165994; x=1744252394; bh=x1Y/SQFT6nmNFmezu+FJV
	XRqr50tcn44b2TWU2emMjI=; b=fV6F0ydLd5mrXGJ+CuRfWM9ng3ToVUULRJ28t
	3ZFMCo620CTsrcZU94yY7Y/xZuqvX+ALurItS94nDPfC1Vbw4zuJeYJFp1em0gDo
	LbjPHF7HhiRhZ+uac90pW1/5Bux5L10zA+vH8yQWe3bHbJqm4oMOl21MF3mjtEbT
	W0NjaXZGMcuIlgHzj1s2Z2t7ppkRH2k4gMS5s/R2QpWr7P2pXlnt2IDx+MuVL/qf
	jmpoYO5WFh7kWrbfDOU4hy9vmj2LPzRcg3iA9Vk3M62MEs1RRoBOkKHIdovB/4Z9
	SUr4V4VmLVgmayPej4NUovyLS+2qnvHqEPZ5WpILGPHww2OqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744165994; x=1744252394; bh=x
	1Y/SQFT6nmNFmezu+FJVXRqr50tcn44b2TWU2emMjI=; b=mXDVe6pTYSeWc4Qpj
	/vi3SjH9UPZvy1S1byUHQhX7zO/18DnkjTy8HRK4lLH8hfQHo/LPQ0nyZLWVB2Wd
	0uxVphnOEcOXreyOwtKRcpuj97Hzyce0+xYhYO4TJXYoZ369WqYhpdOGOjvwmRq/
	BKCCldwS89IHmNdMYKdpxp71kqPdWinVDuQrd2Au6NkReGpShA9py9i3UVVbgnT0
	QdXvXlPkmUgRa2EcDKiV/hrndvN5Nyp7fOJc9h0qvs8i+AZzxxwUE3/s9I4Zbw2A
	3VTczl+6/gIFnk9WdC0H4U7SEgWfBBleErkIjm4rdke530fvpGiDWNlAjT5LUg8I
	AEgrA==
X-ME-Sender: <xms:atz1Z7CsfzQuUeQ9E1VKWc6U4vdDdBhQaITMchewXkJw-9IAE0BM4g>
    <xme:atz1ZxjDuCmr0mb7RrLfe5VvX0_iJTP31KFYAK31jqckAoB5XNmd6UpiQ9l2rDS8K
    IF51NB9FbhVrT6akHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorh
    hrvghmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhepkeeiueejkeffhfevvdef
    geefffelffelgfejieevteevleffueeuvdfghfdujefhnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvggu
    ihgvshdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepqhhufigvnhhruhhordgsthhrfhhssehgmhigrdgtohhmpdhrtghpthhtohep
    fhhpvghrrghlsehivghsmhgrrhhirghmohhlihhnvghrrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:atz1Z2n5cmSeLOaNC0uvxSiA5-s-NRF6Pr-rWgmYueVA8RDvUAnW5w>
    <xmx:atz1Z9zzt1AAnU9x1wHE2X_FbkJNqYsgqWmUELUgPWNCIarexMOMzA>
    <xmx:atz1ZwRBfnZ9E9qiyZsOHPE1SkZfRRl9PZFhkSsIVpe-zUcfaNNHTw>
    <xmx:atz1ZwbjwcpEYqlZdHtwoL0btv7CPlKCRwOP-LfeQWIdC3ZCrY2KAA>
    <xmx:atz1Zy2b6gCwPyjZi228WblA99S8IhJ34XplisZh_61fMqvbdob1VwNm>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 168F31C20067; Tue,  8 Apr 2025 22:33:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T007e04af87621db8
Date: Tue, 08 Apr 2025 22:31:53 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
 "Fernando Peral" <fperal@iesmariamoliner.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <eee9ec59-68c8-4ef8-90c5-7ba9a182c54f@app.fastmail.com>
In-Reply-To: <7798ba7e-74f3-4ee3-abf3-da2fcc68802c@gmx.com>
References: 
 <CA+n7ozwhzdWs=KaBQh2miNwPwYxqBi+MEb807kddGNUZAOyNEA@mail.gmail.com>
 <ad298eab-b9c9-4954-beb7-fc09b238ed23@gmx.com>
 <2992e93d-ebab-4e00-ae9c-58bcbaecf690@iesmariamoliner.com>
 <7798ba7e-74f3-4ee3-abf3-da2fcc68802c@gmx.com>
Subject: Re: A lot of errors in btrfscheck. Can fix it?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Apr 4, 2025, at 5:37 PM, Qu Wenruo wrote:
> =E5=9C=A8 2025/4/4 19:58, Fernando Peral =E5=86=99=E9=81=93:
>> On 4/4/25 09:54, Qu Wenruo wrote:
>>>
>>>
>>> =E5=9C=A8 2025/4/4 09:00, Fernando Peral P=C3=A9rez =E5=86=99=E9=81=93:
>>>> Opensuse leap 15.6 with btrfs in /dev/nvme0n1p1
>>>>
>>>> one day fs remounts RO.
>>>
>>> The first time you hit RO the dmesg is the most helpful.
>>>
>>>> =C2=A0I reboot the system and all works and i
>>>> forgot about it.=C2=A0 Then some days after it happen again... and =
again,
>>>> and once each 1-2 days.
>>>>
>>>> I boot with last opensuse tumbleweed rescue system and run
>>>> btrfs check /dev/nvme0n1p1=C2=A0 > btrfserrors.log 2>&1
>>>> file size is 7MB (72000+ lines)
>>>> This is an extract
>>>> [1/8] checking log skipped (none written)
>>>> [2/8] checking root items
>>>> [3/8] checking extents
>>>> parent transid verify failed on 49450893312 wanted 349472898974925
>>>> found 820429
>>>> parent transid verify failed on 49450893312 wanted 349472898974925
>>>> found 820429
>>>
>>> Although you have ran memtest, the pattern still looks like some mem=
ory
>>> corruption at runtime:
>>>
>>> hex(349472898974925) =3D 0x13dd8000084cd
>>> hex(820429)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 0x00000000c84cd
>>>
>>> BTW, the 349472898974925 value looks too large for a transid, thus it
>>> may be the corrupted one.
>>>
>>>
>>> Not sure why but the lowest 2 bytes matches, maybe an indication of
>>> random memory range corruption.
>>>
>>> There used to be a known bug related to amd_sfh driver which causes
>>> runtime kernel memory corruption.
>>>
>>> But it should not affect the openssue kernel AFAIK.
>>>
>>> So I have no idea what can cause this, especially when you have ran
>>> memtest already.
>>>
>>> [...]
>>>> My questions
>>>>
>>>> Can the fs be fixed?
>>>
>>> Nope.
>>>
>>>> Can the copies I have done be reliables?
>>>
>>> From the fsck, at least csum tree is not corrupted, thus the recover=
ed
>>> one should have csum verified.
>>>
>>> So yes.
>>>
>>> Thanks,
>>> Qu>
>>>> Thanks in advance.
>>>>
>>>
>>>
>>>
>> I had the memtest running about 2 hours (two full passes).
>>
>> You say it seems memory error. Then it can have been caused by a "one-
>> time" memory error (or one time whatever error) or must I search for
>> some fault in my hardware?
>
> Kernel modules have full access to all the pages, and can corrupt the
> memory if there are some bugs. Just like the amd_sfh example I mention=
ed.
>
> In that case, it's possible.
>
> But that can also be exposed by memtester, which runs as a user space
> program, mlocks tons of pages and tests those locked pages.
> This exposes all those pages to the same kernel you're running, thus if
> it's really some bad kernel modules, with enough runs it should expose=
 them.


Also possible to expose it by enabling kasan.=20

--=20
Chris Murphy

