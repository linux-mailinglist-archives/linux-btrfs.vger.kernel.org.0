Return-Path: <linux-btrfs+bounces-16691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59957B478D1
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Sep 2025 05:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059A6200368
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Sep 2025 03:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782FC1AAE13;
	Sun,  7 Sep 2025 03:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="A9Sx2/RY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRdtL2+C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3D3FE7
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Sep 2025 03:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757216979; cv=none; b=I3Xra95EUo+JzLQPgp0ChihhZItWf5hUUrmcFrwylw+TDCc9/69FT0GghHsVLNvrWgdXJI0J7px8FNABFiXWvaZyTjBX7uW0EGqYl8FD2c8zjP5bh9vO/jsqBsfSV7mJJRVBzNYBr4DBbmbpkwY7hk2L2dlc/y5SOW3ya94cFRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757216979; c=relaxed/simple;
	bh=pje0vi3bioUhsN9vDm3w8Ve/k3bkj7mKsoyP9T9DWfo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=guKVLQnUV9l0J+5ksUdz6NBr/iyQD6ulXs+Hgjt8vdCf2hKnIYT6R65qbL1PmiSLhftA/M9UmccrPbePuOgi78UEEpEgALjJaPuW6mIy1bBB7bDDlPYl/AmbtbY9zlCbn5NB+KPHVW8zT94vD7G6nk3mOz+3bRvvzF4OkL2tp2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=A9Sx2/RY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRdtL2+C; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6708140006C;
	Sat,  6 Sep 2025 23:49:35 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sat, 06 Sep 2025 23:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1757216975; x=1757303375; bh=bLgoNV+R0WliP4dvzdRiV
	eWBXtsIuH8s32dTqS/a3B4=; b=A9Sx2/RYl1N1stw1quA7cwOcCtwNfp0NAkNQZ
	abv5g1J5DA1BDtQX3iGwz0vZJfRilcORR2u5J4u29kgNKBriyc643gHQ3XLnipsw
	I9XrhL6J73CqLSt2pLSY9jt9kfQ1uRjeqQz8NhmByFh+PytQ76SSMVRo81lTIxbC
	5wvauZgSXQhxjjUVr4KfCKj+ER9BVEFvgXKuc83GIhMRINSLm9yU7l3bdSUXZRbS
	JgLtCKxU5TATYcdBRNQTilNizyFiD7+5bmkBkNVXFB5LIxD75MQGfNQbTR6Vc7DN
	WzaaTfj+vnEhOuntlbnL6UA+xFTDieuBzOXyAnqdVOZLyth/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757216975; x=1757303375; bh=b
	LgoNV+R0WliP4dvzdRiVeWBXtsIuH8s32dTqS/a3B4=; b=NRdtL2+C+7dVF9IU/
	IyehMo8ONgPEZHjqCIjTSqm5qVeVEJ1N6VsezqPyhb4B+0hpFKh3tqHSvgvAcWhn
	CLSRTIkM8pFRYd+4t6o+xdjXiLlgqEE8TECn73l8+gt+1q3e6btp0Iy4VgUtg1ry
	oZ+4dwbAGaRgm3MA3mK3QGeJTDnkUEAKo4cqk0GxrkD0mzdhwibjUApEoe0oDUhU
	UBwp9pTuHRjqV4fNXsghUOvlMOqspy/4Orb2UEg5sam8GlFo+/lrbMOzD6rHry5M
	LzcEH5l7uJnWytbxwEsIlNOM1e2geUhL4G9csBweRa8HCwR2W1sw8e1pehLZj9uO
	ymwuw==
X-ME-Sender: <xms:zwC9aDOjLZAZoMmjGQQxpEwsm896Re6f78ztSTw2kG0i5dEqIzL_GA>
    <xme:zwC9aN9qCFnKYsmhiVm5J6sWHo2wOo17k_KgQEJkv44bubHwVfVFFSFqNCF7FTMO7
    8cEjGun3O6yMgK3PC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhrhhishcu
    ofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeekieeujeekfffhvedvfeegfefflefflefgjeeiveetveelffeu
    uedvgffhudejhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghkvghrnhhsthhotg
    hksehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zwC9aJ03azkD-XMYII9KC3jXH2b3gfABERtCuRyzZ_xJvcFWp67xlg>
    <xmx:zwC9aG83u5vUCkkx_zUcPWP6YozaQwX9bf4EGy62drqLetnSX-PPrw>
    <xmx:zwC9aG3VaekClnyY4q5CVHLvuWFHJiSWr799IoO4z7eF2mReVqtIcw>
    <xmx:zwC9aD_XHixDb9hP1UiHLDMhutPRFsW8o0taZ9DrmQZnqXg_zEnbuQ>
    <xmx:zwC9aLDPSZYG6QkTw-R-XcDtIPsBImLTmd755_DUiBldeqPLNrgjhsaY>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9BB9E18C0067; Sat,  6 Sep 2025 23:49:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOPGbf7Ukwr-
Date: Sat, 06 Sep 2025 23:48:59 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu WenRuo" <wqu@suse.com>, "Charlie Kernstock" <cakernstock@gmail.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <e63d56a7-11ea-4c25-95c2-d8b661146f36@app.fastmail.com>
In-Reply-To: <5b037515-42da-476f-bcf3-d6c50f70f07c@suse.com>
References: 
 <CALRiM0xL5A70zuTgBFwCW94RQB7JV5ssaigwg7jxh6=tfEZyhg@mail.gmail.com>
 <5b037515-42da-476f-bcf3-d6c50f70f07c@suse.com>
Subject: Re: Need guidance on btrfs: uncorrectable errors from scrub
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Sep 5, 2025, at 1:41 AM, Qu Wenruo wrote:
> =E5=9C=A8 2025/9/5 11:40, Charlie Kernstock =E5=86=99=E9=81=93:
>> When trying to run "rpm-ostree reset" or similar, dmesg shows this:
>>=20
>> [  101.630706] BTRFS warning (device nvme0n1p8): checksum verify
>> failed on logical 582454427648 mirror 1 wanted 0xf0af24c9 found
>> 0xb3fe78f4 level 0
>> [  101.630887] BTRFS warning (device nvme0n1p8): checksum verify
>> failed on logical 582454427648 mirror 2 wanted 0xf0af24c9 found
>> 0xb3fe78f4 level 0
>
> This is not a good news, metadata checksum mismatch normally means the=20
> metadata is damaged.

But also both copies are damaged identically, the found csums are the sa=
me. What are the chances?=20

If it's a kernel bug, wouldn't write time tree checker catch it?

If it's corruption from the drive, does both copies being identical sugg=
est the firmware is doing opportunistic dedup of concurrent writes?

I have another Fedora user experiencing similar scrub results, just 8 er=
rors: 1 metadata block, DUP. So 4 retries for each mirror. Both mirrors =
have identical corruption. And it affects a subvolume. The user previous=
ly made a rw snapshot of this subvolume and it wasn't exhibiting problem=
s. So we thought maybe the corruption was isolated to the original subvo=
lume.  Since --repair would not proceed past the checksum failures, we t=
ried to delete the subvolume. It worked, until the last half of the kern=
el cleaner thread work, and the file system went read-only. And now it's=
 stuck, will only mount ro.

I think it might be best for Charles to avoid any writes to this file sy=
stem. No modifications, including repair or trying to delete the affecte=
d subvolume. The corruption may not be isolated.=20

Instead, mount ro, and try to copy out any important data.

Look like Charles is using 6.15.6. The other user was on 6.15.10 at the =
time.

Another thing to try is to recover the corrupt block. Maybe it will give=
 a clue what's wrong. Unfortunately `btrfs insp dump-t ` has no force op=
tion to show a block contents if the checksum verify fails.

Charles, try
btrfs-map-logical -l 582454427648 -b 16384 -o btrfsblock.bin /dev/nvme0n=
1p8

You can hexdump -C to check for file names, but I don't think there will=
 be any.

Right now I don't know of a tool that can parse the on-disk format from =
a file, I think Boris said it was being worked on.

I've asked the other user for the same.



--=20
Chris Murphy

