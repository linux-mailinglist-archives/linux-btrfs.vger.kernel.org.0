Return-Path: <linux-btrfs+bounces-17035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 021D1B8EB81
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 03:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD457A16A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 01:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE0E19994F;
	Mon, 22 Sep 2025 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="bSrYnJi/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ipVnGkI+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B0C1917CD
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505390; cv=none; b=VfpyULUGCKZevPmeM+5h92h8j9Rr4LLOLJIWXhtSD/GrczzMZXAgSZ8BevYJs8063HU2LTZc4KfmUE4CjIk+fqOIXNgnsWeXLFkioRPooFPGbacy26skWn1wC307Zz69AlKfVuMYOqfi8WbQMwfhkwAewTHRifDW9V25nJwxwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505390; c=relaxed/simple;
	bh=kG6jzdFfjxSY32T9uas2395R2mV84lFy+m8Ab2eqvgU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eF3q2jwSsn8qUADAmHXSV78HWAi9tStf8ri7sKaAIOZi69muq80S+hV2iBZ/cNBjUeEWdgDbt5yavSshPRRf2KaE4pqWY/3bF9Wv8r2tpm8YD3VCIklfb942vHNVDAuzl0o1SFSgYlWsxesGBgfOjRYlBpp7rfRSTJ0Ux/Vdw5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=bSrYnJi/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ipVnGkI+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 56C4BEC00A6;
	Sun, 21 Sep 2025 21:43:07 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sun, 21 Sep 2025 21:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1758505387; x=1758591787; bh=QFeiEzw6qb
	ZnN4JC2sAN57ez6eZe+apPlX9/3p1iGz4=; b=bSrYnJi/P4Iz35bUnNdGgN5kP5
	6qL6Q75PvTnqew3RPnq2ymD1DjOnpdcFijFvnMFcftY1aehVTehFc3KyNsN7uzrU
	hqHcdz3MGCx8tyxMG6nMbi1zrBAxlL7S5r9490PllkOHEU7uEUa+fD/E/fkukAbU
	4Dk15m8UcWA7imZsjQHhYvXStB3J8rx7puzjPX5IaqTPVSC7hcx7VSusCN9V6bkM
	4Y6r6vLxQKHGWXAUFnLy3EKwGTfGy2S0AFUm0m5smUjaXuKz/F8KmggBPYKJlagA
	C0FuY+cDs2beagszZeDGFrJf2vVAm0nvmrsZWy2I0/bUJ+A1GGQlVSfIdNbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758505387; x=
	1758591787; bh=QFeiEzw6qbZnN4JC2sAN57ez6eZe+apPlX9/3p1iGz4=; b=i
	pVnGkI+nRAkS8vZGritL+JFulbWNPwX1+W3f0J7p/F2wELDjHq9Vki/ectwauBsq
	9P2cJjN9qs5Ld5GFSGdQKpPoB7Tkv5q0A3t9il8yQEc5AZ3XWqhuFaucIKEP3hLl
	5kVV9vIcfccG1gMv4jmcSD/fTD2bypxYZ+ss7xirCYnp4/EpvMwA66sP0mkeSjaz
	XL++aHh45tV3QqjwBpmGuyuCcKmGN2j1mQFiOHg+ezCjc5VR7O9IYLj/sio1rtJa
	MdQDKhWEnB/1dvRNx8waFQpKf2QdJoKtzVOAHCXm5qbTAjl49lcAUakmu8YVfgGb
	5n7ylUYdz/QAL/x72WUbQ==
X-ME-Sender: <xms:q6nQaMG_NXOwWa0v6tuh_Iw7UXhKTOdIhue-txhEbu0lR10Ar0jCIA>
    <xme:q6nQaFUnDMTcY1UwiqzqocoFH1Wjo9uzsiAzpylzx5y6ec1QKK7xnpt010CN9Ergl
    HB9lq4L3VGHSr8RSnI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhephfeuvdekteduhefgtefhvedtfeeigfffheevhfevuefffedv
    tdegiefflefflefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhushhtihhnrdgsrh
    hofihnsehfrghnughinhhgohdrohhrghdprhgtphhtthhopehquhifvghnrhhuohdrsght
    rhhfshesghhmgidrtghomhdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtph
    htthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q6nQaJMOLq8babcOHlmKPMJxWxKPVYGTOeDUYmBq7r3PD03LDIma8g>
    <xmx:q6nQaFZ8eY6VguyxyyC500HF0_5IuZ-V9f0eIyQsxBjyDaTtNF6Dkw>
    <xmx:q6nQaH2CTVEA67Ify90pIfpm_enjpd7vf0b8IvlSXEd3vPxfVRmVew>
    <xmx:q6nQaLfwY3oTfKzF2aFi3Ncf9FC1PbGQ7VWg1Z4A4H8bmxW4noE2pw>
    <xmx:q6nQaJIpaqH0uZvkcOiHENkCtLG5zJawPf_DIz2-WSnRSc3J_AzEb5Bx>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 07E0018C0067; Sun, 21 Sep 2025 21:43:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ac8M0w2PifQg
Date: Sun, 21 Sep 2025 21:42:25 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Justin Brown" <Justin.Brown@fandingo.org>
Cc: "Qu Wenruo" <quwenruo.btrfs@gmx.com>, "Qu WenRuo" <wqu@suse.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <83febe47-2c3b-46e2-b019-0f5bfed7d0d6@app.fastmail.com>
In-Reply-To: 
 <CAKZK7ux=z2OT2psm8C06RTM+D4CweQe8dQZxEZ4SNeOwhhfA0g@mail.gmail.com>
References: 
 <CAKZK7uzqNj1336MijN2De-R9+rdjw_Zm6=b-Q1jCCDQb5+fmXw@mail.gmail.com>
 <27b4ca8f-de3a-4b9f-b90d-c6260ba81f9c@suse.com>
 <CAKZK7uxiRmDxk-1goC4yj7QZPSmL-=GAoAuF=OdekbSNVrG8fg@mail.gmail.com>
 <23d859bc-19f9-4cf5-9405-03792dbf2e7a@gmx.com>
 <293aab80-89e4-44fe-b588-977ab24dbf51@app.fastmail.com>
 <CAKZK7ux=z2OT2psm8C06RTM+D4CweQe8dQZxEZ4SNeOwhhfA0g@mail.gmail.com>
Subject: Re: [Support] failed to read chunk root / open_ctree failed: -5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Sep 21, 2025, at 9:07 PM, Justin Brown wrote:
> Here's the output of the backup roots. I have no clue what to make of
> this information, though.

All three supers are the same. The backup roots all show the same chunk tree generation, level, and address as the super, and this hasn't changed in a while, ~11 generations.

generation        4956
root            998506496

chunk_root_generation    4945
chunk_root        27656192
chunk_root_level    1

Seems strange to me that anything could remain in the drive write cache, and not on stable media, for minutes let alone a week.



-- 
Chris Murphy

