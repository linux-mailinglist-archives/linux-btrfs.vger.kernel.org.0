Return-Path: <linux-btrfs+bounces-12745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04C0A78685
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 04:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CC73AD91F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 02:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC94D126C1E;
	Wed,  2 Apr 2025 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="AnhOQ2FE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c5mlmtnv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581723A9
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743561777; cv=none; b=KdkTxTGJlmCmh/KC8wsUc+q7pncl4T80iw7kMlQZ0w49gEzW+WjYGGzjPhyiG1IQH5ynXZauAWLiwUorPOW/wvbqE/MytllrZwos5aIacppo3BPX5emsZMCDOD22VNomm4WkSS+qNu5f7JNrmcu0pH1+ZksXXxcENjGpf5a9S2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743561777; c=relaxed/simple;
	bh=wSo+ZNeaR7Nk9cebvRh1pA0cwofMpW8jAMWDzo2rJz0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CfInBMVHumUnBZwOslhuZe/KVMq/+HA3JCpEyXVpof34moC4nV/vnnl4MW8fRmO+EuiQY8WhFHccTG+HmIn2ShdHx+Xr3the7NM+4RsJtYxC4Jaqpb2OCiP5iRy2P50+AmOGIDMroOaglnFG8oSunE2rSFojnk76WEDr+vGPWX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=AnhOQ2FE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c5mlmtnv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08F8611400F8;
	Tue,  1 Apr 2025 22:42:54 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-11.internal (MEProxy); Tue, 01 Apr 2025 22:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1743561774; x=1743648174; bh=COlpLbB+cuq+j1URKh6tO
	hm5TN0z7UOuHRs2CxIiyFs=; b=AnhOQ2FEI1NHSIZZH2v1kGC36dd8qDWipLuQn
	SW3zI49/ltyYG7n+LdS1DjhuaMVYS2UquaHqT2M8SZTC3+rFH+guPT1GxyB7KU0/
	ixMJtTDriX0bSBKW0fxut6bVVqv05oQYlpo3vWki88BrJ7JH8YEXXQa8o+yuzPCw
	ia80CU4CmFVHeS3kdr/4BkId1doIgCEDoQ9yu5GUneEnvhbdKjH7Wnkcu65pLa9f
	Q8Gc8PNT03QZLQrItcOJiz26wfhrkjMPeIh5qc6XGldsirV5GMfTZLbHEyIMmLZg
	q2WLKsR+UVySGoWmQM1c4WUQYcYthR60X6gnOlp+evmkpAHOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743561774; x=1743648174; bh=C
	OlpLbB+cuq+j1URKh6tOhm5TN0z7UOuHRs2CxIiyFs=; b=c5mlmtnv24tjKnn4v
	TKBe0nRG0EpJqthHUIEwRVpqyTWct67CbOqYPL2uDdf2Z4+sR1ZqKGem13dDaJSZ
	2BSTPkLeCqttw6cdwcxr8dT8mMeSC2swDqemommul5mGpDON6spvzzvNCER6Oxjt
	OkTVN4iqB7Vpa8yUiRqs9GDIFJjxonyizlGaVA5czz4j8/HwbrtvitOP/IZ6Pd8u
	ubHsoFJcRqyISX9A71uaeFRJr8gVjzh14tuakfp/OSVMyjGaHxz80Dzxu9zi8zet
	HUhmpkO06CDyPPdrTk1xCQbunX75hrn3+VBfYZ0V+p1rB+8U0rN9N6vKFT5Alvao
	XlnsA==
X-ME-Sender: <xms:LaTsZ5ifAbmB_0lPQo98BuNVXuPlYtRTnSkIZ1-4xIgZzCMTN00XgQ>
    <xme:LaTsZ-CfKXPAdCwxHSMDWtuyWcL1gKbqlg848At6rNYcmyfIwrEa00Lxy5QBxtn8z
    3XV4ABqWVVBQUADXNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorh
    hrvghmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhepteefudehkeehgeekhfdv
    gefhjedvveeuhfdtgfejgfevieeviedvfedvhfevvdegnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvggu
    ihgvshdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheprhhushhsvghllhestghokhgvrhdrtghomhdrrghupdhrtghpthhtoheplhhi
    nhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LaTsZ5GqPAinTS_f6RLOCZrxIDVB9hxkUQyBJAzSpXe1hU-quahDsw>
    <xmx:LaTsZ-RRokNfBEmC7IUUdz4_Ah43X-lLjdzewsMLQzR2yOmMpGySGA>
    <xmx:LaTsZ2x6IxQD7KrFPCNtGIWYHREg8M4ZxAJfs-jWF5-fQBYwhWm11g>
    <xmx:LaTsZ07EjncvO7E1-WmbRCkzgOBhjz_GbmfE6PqEgD_Us14BDzTU6A>
    <xmx:LqTsZyk9AK7oX3WWnpAKIf2iXwCbQDKrHlht75EbUhdmmTaEv0fR81iG>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C00DD1C20066; Tue,  1 Apr 2025 22:42:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T94110d4a53b0169f
Date: Tue, 01 Apr 2025 22:42:32 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Russell Coker" <russell@coker.com.au>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <70f5d224-f302-4664-8018-d37c06c9048b@app.fastmail.com>
In-Reply-To: <873501505.0ifERbkFSE@cupcakke>
References: <3349404.aeNJFYEL58@xev> <3682098.taCxCBeP46@cupcakke>
 <7b155ed6-da59-4560-9e2f-1ffa0143d84b@app.fastmail.com>
 <873501505.0ifERbkFSE@cupcakke>
Subject: Re: BTRFS error count 754 after reboot on Debian kernel 6.12.17
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Apr 1, 2025, at 10:32 PM, Russell Coker wrote:
> On Wednesday, 2 April 2025 03:00:33 AEDT Chris Murphy wrote:
>> On Tue, Apr 1, 2025, at 1:18 AM, Russell Coker wrote:
>> > On Tuesday, 1 April 2025 15:04:20 AEDT Chris Murphy wrote:
>> >> These are likely old errors. You'd need to check old logs to see when the
>> >> write errors occurred. These statistics are just a counter. You can reset
>> >> them with `btrfs dev stats -z` and they'll go back to zero.
>> >> 
>> >> It's simple counter. It could be 754 errors seen one time. Or it could be
>> >> `1 error seen 754 times. Or any combination of multiple errors multiple
>> >> times adding up to 754 errors.
>> > 
>> > Is "btrfs dev stats -z" covered by removing the device from the set and
>> > adding it again?  If so I did that but it kept recurring.  The fact that
>> > the error count was there in the first place wasn't the unexpected thing,
>> > it was the fact that it kept coming back and had no log entries about it.
>> 
>> Removing it with a `btrfs` command? Or physically disconnecting and
>> reconnecting?
>
> btrfs commands.
>
>> The statistics are per device, persistently stored in the device b-tree
>> which is metadata block group. So this metadata could be on any device in a
>> multiple device Btrfs, not necessarily on the device that produced the
>> errors.
>
> It should be on the device itself and once the device is subject to a btrfs 
> dev rem command it should be gone for good.
>
>> I'd like to think upon `btrfs device remove` or `btrfs replace` the device's
>> stats are also removed from dev tree. But I haven' tested it, and I'm not
>> sure what the code says should happen.
>
> After doing the btrfs dev add it reports 0 errors until after reboot.

Uhh, well I'm confused then.

What happens if you use `btrfs dev stats -z $MNT` and then reboot? 



-- 
Chris Murphy

