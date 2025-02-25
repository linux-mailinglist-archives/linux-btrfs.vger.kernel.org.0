Return-Path: <linux-btrfs+bounces-11819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217FAA44EDE
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 22:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1949C7A14BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 21:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34521148F;
	Tue, 25 Feb 2025 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GZconbnL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zqPQAaKr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069881922DD;
	Tue, 25 Feb 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518953; cv=none; b=YhVIdEP3IUrnFzmlEf6F6cTwLHO4T0Wtvq8QF3WrS7qHRAWU+E0pohh3il0cWS7n06KoDoygBEIz4L0NVCDtUriyamG6jIAgr2M2tTB3J/sBbjUAWU+NlNlH7wY6W/S5ek7EQeZYV5Y1UXev+3otR8Xxjj99ejHwv66R1IKBYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518953; c=relaxed/simple;
	bh=FxwfQzdbz6KatbH/+0YlWUJBtEi3hcVntsB9J35auAQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ERP9pJZrFOU8wfJylEJsvcFEIO3gF6iEkxktFpbODLCj0UU7QmnViYH/1D8MDfWtI+0Oj+Ov1geZ0Vsu/Xf1+5Xf0IkUBs97o8MMs722m6FVV8JwjuhyX6EcpukBJhnLprwK2Z6fpgVAuSPxizP9yui3qnABu+M+hF/36tDjfYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GZconbnL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zqPQAaKr; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE99B1140101;
	Tue, 25 Feb 2025 16:29:10 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 16:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740518950;
	 x=1740605350; bh=v8iPHUFSnne9b1cDj8M4Dt4vwU+27ni91gVpMbu0RLU=; b=
	GZconbnLJHwZjSaN7/pqMDjyStBjFpPUkRxHtLaEcpI6AXa/j85uK0FXECc0uFax
	TG+k6u3SC5H9QLpkr7ksEY+qBDmcuo+z3JlFdpQauE0jO/HQuO7PK/swik8zRPZu
	zFh0AUvypTGn64NcPQjapv1pkdS8Ooct0T0qUq8S8yCeldK3ZfRgYTJL+G88vrXf
	qsIi1sVzC75ogpKFJS31knwW7omV8aPnsx7vpXPme1WzcH3t7F41eVn57UBaFItg
	87VqrnDNrtFI3taLo/PL9XuTMIuEK9FhuQDxpEERMcQ1DLoy7SH6bdlg7nXF/Y7Z
	WQpktOUWwlEJAkzYigPizg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740518950; x=
	1740605350; bh=v8iPHUFSnne9b1cDj8M4Dt4vwU+27ni91gVpMbu0RLU=; b=z
	qPQAaKrYnLn7knnyN0HkR9LO+O/v1OzZeH9bMmTySev+o0+E4AJBI0hikdp3yW0u
	yO22jBz6S2z0shSTnokMaWEJsTom1MLpyiauOLa+pBtuk7UUotZIaYqnz8o7XdmF
	16vPpA6yjxNsXnuB8BcqzPrUxAPW4Brnd4TUUBOWh++kNH2vtW4YcVSDR6C6WISN
	dminVLq683Mq6runo0kldjFGJMC+S1PrdSi1gnP5WsesdXn1AcpGnlEAsowe9zuE
	gRIHnUrEDLrMtJQCHWJwhXVYqFmsFOrqcA7Lfzo93xL1SedD7cpDpV2C2pu24nb1
	0uaKLC5H6VHYkZFOujJ2g==
X-ME-Sender: <xms:Jja-Z06D7Ob1uPFYivGOWE7-Ko3FlJKF97WKFZs1jzv3PVqDpDPv9w>
    <xme:Jja-Z14Yisjj4ZG-ydvCnp0ibxuFJxi7JNX93u-sPH0nA3paKVOA76Ab6M3gPrCDb
    UV0Ru9DrV9gxYiljSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeekvdeuhfeitdeuieejvedtieeijeefleevffef
    leekieetjeffvdekgfetuefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegtlhhmsehfsgdrtghomhdprhgtphhtthhopehlihiivghtrghoudeshhhu
    rgifvghirdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtth
    hopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnrghnugdrjhgrihhn
    sehorhgrtghlvgdrtghomhdprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdrtghomh
    dprhgtphhtthhopehfughmrghnrghnrgesshhushgvrdgtohhmpdhrtghpthhtohepfihq
    uhesshhushgvrdgtohhmpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrd
    gtohhm
X-ME-Proxy: <xmx:Jja-ZzcsuWbb-CF01DgWVqKWfIJ0cFyrEHM50S3u8XCC2PTVUaKzyQ>
    <xmx:Jja-Z5KpKNSB4J8skgXAJfFo1hLLE_EGg1LEnuvlSkxEpgLkWT-qXg>
    <xmx:Jja-Z4IjhQg_2woQqDR167w630MR5T7KYw-QIQpgyrYcN-Qok6pnbA>
    <xmx:Jja-Z6yGVTfSBaj-BmXPHY6z7WFx3ZAhCgmN0tTqJZ3UzMIHjofVuQ>
    <xmx:Jja-Z2ycSnzBxyjF4fkEvvvcLPoSEM6E-efm2rwHd4HdnNXNsxxQvYfM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 082A72220071; Tue, 25 Feb 2025 16:29:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 22:28:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Qu Wenruo" <wqu@suse.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Chris Mason" <clm@fb.com>, "Josef Bacik" <josef@toxicpanda.com>,
 "David Sterba" <dsterba@suse.com>
Cc: "kernel test robot" <lkp@intel.com>,
 "Johannes Thumshirn" <johannes.thumshirn@wdc.com>,
 "Anand Jain" <anand.jain@oracle.com>, "Filipe Manana" <fdmanana@suse.com>,
 "Li Zetao" <lizetao1@huawei.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <d3917385-c852-490a-b600-7cb5d6d12465@app.fastmail.com>
In-Reply-To: <1cfc2f43-8ea4-4c39-b543-1f54ba9b284e@suse.com>
References: <20250225194416.3076650-1-arnd@kernel.org>
 <1cfc2f43-8ea4-4c39-b543-1f54ba9b284e@suse.com>
Subject: Re: [PATCH 1/2] btrfs: use min_t() for mismatched type comparison
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025, at 22:22, Qu Wenruo wrote:
> =E5=9C=A8 2025/2/26 06:14, Arnd Bergmann =E5=86=99=E9=81=93:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> loff_t is a signed type, so using min() to compare it against a u64
>> causes a compiler warning:
>>=20
>> fs/btrfs/extent_io.c:2497:13: error: call to '__compiletime_assert_72=
8' declared with 'error' attribute: min(folio_pos(folio) + folio_size(fo=
lio) - 1, end) signedness error
>>   2497 |                 cur_end =3D min(folio_pos(folio) + folio_siz=
e(folio) - 1, end);
>>        |                           ^
>>=20
>> Use min_t() instead.
>>=20
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202502211908.aCcQQyEY-l=
kp@intel.com/
>> Fixes: aba063bf9336 ("btrfs: prepare extent_io.c for future larger fo=
lio support")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks a lot, those fixes will be merged into the next version.
>
> For now the series is only for test purposes as there is a backlog of=20
> subpage block size related patches pending.

Ok, thanks! Please double-check that the calculation in
patch 2/2 is actually correct though, as I wasn't entirely
sure about that part.=20

     Arnd

