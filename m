Return-Path: <linux-btrfs+bounces-19746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8F2CBE8F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 16:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 563C43001611
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B88D349B19;
	Mon, 15 Dec 2025 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="fuO58JYC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xK0zc0y+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2DE2DF130
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810057; cv=none; b=aN3cJ0b/FcakCeJ/hV8Bsv1P7Q5lWrOUm2QvBhTlPUb7iCgBSeQAuKdTt5QwGIjBmyUJOzmV6FjkiVgPak0WjzWI2t10I1kDbs5l6zjB70Wj1P9GbypkB5LHGrRJ/qkxwHvvIH781AwCAUFY44Fkz6GAFmlqK01cOY0LKD4Gz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810057; c=relaxed/simple;
	bh=v7PJvwHD9wqnlA+7mmlKSwdsLfUZwDL+tCF6c6wZbvA=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EsMiz80WV1dxR80wFxzOJCQRTrapzAX+S6q0Cy4oOgAlbKnT/p/SdVBAgo/luWTl3gO5ZNQqG7vtRrjFPLhORGfHj3l/CxZLHWd8EsJsERvQSZxyKUgln1h6wk4pMdocbJfKVTdmTkmAM2tbkMHoADvBKO3V6CCeZPRMRaD5CNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=fuO58JYC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xK0zc0y+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 50BCDEC0169;
	Mon, 15 Dec 2025 09:47:34 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Mon, 15 Dec 2025 09:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1765810054; x=1765896454; bh=UuHyTDRoHIwcMrZb9uRKK
	+ZFfr3qb3CjiXZlZqtPj5Q=; b=fuO58JYCZgYPnlj9AEQv3OLRzWEXX6tN+1oXc
	I7JOiI4W6XNxFrTDT6Sua1vRztcgaesdu/TZQ3s2FoJ0B2aSfyEm53F5x31FuCbF
	ck4KR1GQzflkXfqy+Tybl7GO0jwILPanVYDXY3jWcinyeX9yTLBBRu8F8L5yG75L
	D7owrcCbk9GOyJeYp01reT/76MKRYyTZFjhiHGJCJ3E5Nx/WO0x5k7Sw3ju+CFCe
	moVg4/zdH7DzHx8J3kiZEjtcDQ0kLMXcfKJuq1DPOz5PUHUOSPDFFdY5WimCUOod
	RkcQah8GZwsm80syqPheZvZddWKFTsaH+c1bMU7YfZxpSELeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765810054; x=1765896454; bh=U
	uHyTDRoHIwcMrZb9uRKK+ZFfr3qb3CjiXZlZqtPj5Q=; b=xK0zc0y+GeJzMmzTM
	NHo7hfQZ0sDe2ujQT4WnnUdvrAqq1uAL3SHxbB1Ld5ISVO5/0j7EjDAk5Q0ZsFJ5
	r/4fnZF5iaf8B7YgAhqyAqFlzM2zCUuYkPINQhYXNbSn5uDUnwck617/CNEODfS/
	mGPBnYcJcKgZh1cLkfFqqfaOTqTYUP3mcsPCi866NQ+t3PNbmoXfTV4fVzdyAgU2
	ahfq+yZwabUfqTeJ99W9A6URAKgzXoyORmd64qx8bBbwPGCOOHih6s4BO8pBOLGs
	52wR72tYWUYNxiRiDwdDJe/ayLrXJx5AcuwtTeo0WWC/swXSDDvQNYlytcy7QZmo
	A8KQg==
X-ME-Sender: <xms:hh9Aabg4ibdjwzal_iad4AQ0NuzvCMO41unBsP-q0qJX6e69ylLkgg>
    <xme:hh9AaS1KkSPXgiBPVlJOfKi0Po1_CyVIe_nzNDt9mpoMPj2CZzfj9Ff9ZnBS37yhX
    kpi-gFX9gqq-Hp7Di3NmhZM5lEg1d4R3EK7kwiD9ziHj0PbFre-B20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefjedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdduhedmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvg
    hmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhepleffteeuiefgffevudeitddu
    teetleeiteeffeetgeetleeuteejudffjeevgedtnecuffhomhgrihhnpehmihhkkhgvlh
    drtggtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    lhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthhtohepfe
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhhufigvnhhruhhordgsthhrfhhs
    sehgmhigrdgtohhmpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hh9AaU9OJ_sSod6uhg30WEoJnWj0MXQSh9jIqFgLJS9RMGc3gXwkVg>
    <xmx:hh9AaUfVtdtCBMs-1UH6jkaTT1f2zW4ZTLFV-fHU7duqmSdL7MXKHw>
    <xmx:hh9AadEU34PRCVLUk73usdZcDGT270rL-bDnpTr9h-L2MrcOpQrDZQ>
    <xmx:hh9AaSck7QvYOt-n-dKN-oJGCjckq797f6kmHFnuAnOJM9Pv_UNj1g>
    <xmx:hh9AaXeIMGOZXI8xQXAEDKqw51S8KlFJN-YldW0fGzmy5CeEalO5e9nz>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 21B5218C0066; Mon, 15 Dec 2025 09:47:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5g2OpuDMuvg
Date: Mon, 15 Dec 2025 07:47:13 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu Wenruo" <quwenruo.btrfs@gmx.com>, "Qu WenRuo" <wqu@suse.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <3187ffcc-bbaa-45a3-9839-bb266f188b47@app.fastmail.com>
In-Reply-To: <20a1aecc-aaf3-4fe1-8b4a-5c5bb8ba92a8@gmx.com>
References: <e2095d93-fa47-46b2-b894-0918b6ce348c@app.fastmail.com>
 <d9ab1004-a7ff-4939-9692-0c8f32df27a9@suse.com>
 <651e259c-ac24-49d0-8eba-4d9c7c9f11c8@app.fastmail.com>
 <20a1aecc-aaf3-4fe1-8b4a-5c5bb8ba92a8@gmx.com>
Subject: Re: kernel 6.17 and 6.18, WARNING: CPU: 5 PID: 7181 at fs/btrfs/inode.c:4297
 __btrfs_unlink_inode, forced readonly
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Dec 15, 2025, at 2:02 AM, Qu Wenruo wrote:
> =E5=9C=A8 2025/12/12 04:31, Chris Murphy =E5=86=99=E9=81=93:
>>=20
>>=20
>> On Wed, Dec 10, 2025, at 6:55 PM, Qu Wenruo wrote:
>>> =E5=9C=A8 2025/12/11 11:58, Chris Murphy =E5=86=99=E9=81=93:
>>>> User reports root file system going read-only at some point after s=
tartup. Seems to be when a Firefox cache file is accessed.
>>>>
>>>> Initial report is kernel 6.17.8-300.fc43.x86_64, but the problem al=
so happens with 6.18.0-65.fc44.x86_64.
>>>>
>>>> User previously discovered bad RAM and has replaced it, so I guess =
it's possible we have a bad write that made it to disk despite write tim=
e tree checker (?) and now can't handle the issue when reading the file.=
 But I haven't seen this kind of error or call trace before, so I'm not =
sure what to recommend next. If --repair can fix it.
>>>
>>> This looks like a previous memory corruption caused on-disk metadata
>>> corruption.
>>>
>>> Tree-checker is not a memtest tool, it can only detect very obvious
>>> problems, it can not do cross-reference, and unfortunately this is e=
xact
>>> cross-reference case.
>>>
>>> For this particular one, I'd recommend to do a "btrfs check --repair"
>>> then "btrfs check" to verify.
>>=20
>> Looks like --repair changed from "errors 4" to "errors 6"
>>=20
>>=20
>> [1/8] checking log
>> [2/8] checking root items
>> [3/8] checking extents
>> [4/8] checking free space tree
>> [5/8] checking fs roots
>> 	unresolved ref dir 1924 index 0 namelen 40 name AC1E6A9C763DC6BC7749=
4D6E8DE724C240D36C9E filetype 1 errors 6, no dir index, no inode ref
>
> And repair again?

No change.

sudo btrfs-image -t 16 -c 9 -ss /dev/sda3 fs_post_repair.img

https://paste.mikkel.cc/gNwpLmyw

> If after repair, readonly check still shows error, I can craft a quick=20
> fix branch for the reporter.

I'll check to see if they still have the file system. I asked them to ma=
ke a btrfs-image before starting over. Thanks Qu!

--=20
Chris Murphy

