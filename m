Return-Path: <linux-btrfs+bounces-2020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8E684598C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 15:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6991C232CE
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB495D48F;
	Thu,  1 Feb 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="V6uoivNv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EtUyAS1n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9625338E;
	Thu,  1 Feb 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796199; cv=none; b=BTbyd6zMFvYVIADLQjLKuSM6XA49oHbk20schr19IvwFQU5FGLEo1G5qX4cQISwxhZLdzUljkJu+0lYppEze5fftpyFiFA+7zF7MgKUM/fOryvLcinXUEMquhuniywxGNxUBURErkKZ3R6nj6ELGpynKywxHHPYLc6q2WPcoLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796199; c=relaxed/simple;
	bh=ca8fj2gTG3iRmOfEmYapKTreDfkQJ3NcDZ7iQMWLM0k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=VGTizVjS8xtbv58wuSsbXRm+SKuIi21CW1KjzAKgC1PiDkphxrmQcR0uBzFamEr5fsMzYTqvshulVtwdn9ML3GPnX3zNIQU7h/U9XIyzTtPHeZDsbxFZHLGAPJ8gavZx//6Ks+QEh128IFtzRgLQPX94yrN6NEw4tLBBg3Z53Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=V6uoivNv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EtUyAS1n; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id DA5765C015A;
	Thu,  1 Feb 2024 09:03:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 01 Feb 2024 09:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706796191;
	 x=1706882591; bh=SrMsYSSdXBYrmJby1JuNx2foZxC1DPyP8T36AKwqkBI=; b=
	V6uoivNvjOsWV8cVN414irLYJXlAxzYQLgIylQ4tIF25byDBNWNzWAFRdI2GHwXG
	MqrpO04Rai1GLgT488yZbPpEnexlkT78FRbLnCRXSaWv2p3LNcpZ4KTQj6PDU8/q
	P6/4YK57n8AJ+xvxcKFoSC6LRAiV2duWOBxPr0Ritc2iBXQrQcEgJSax/ELkNevM
	omXro5wjkLCT/+BKTEDszb5lU6H1AUTKueRvQTV6brqfIO2Y0wc3RKBF4B/FODLZ
	4aQe53Rg812/uIB13jRoudEycB0R4CeE+UWFQLBv5xdj1cR/SWQ31ELe4mPQ1LqG
	XjZupRbQN8z0d9JXMsNNpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706796191; x=
	1706882591; bh=SrMsYSSdXBYrmJby1JuNx2foZxC1DPyP8T36AKwqkBI=; b=E
	tUyAS1nQPJjZFmzE8hd+Xi0j0IDvz3Hj5hZHLkcVSkEToZ0xLDtzH9zrFdQhPVcK
	4ORifOcYB+qP1esUYHQdMeUjevk2wtAGWtA5UVQDmm4sGazF/Amv2cM9/CwjrYeh
	cqXkC/mZeon+LU7GBTrjTrrs6bbSouPNyaRdnPvvcqNH3aSDpkzx5WwNltvOzj52
	bCL7x7DU7gVGQk5urJJm/SOrdhx0sgIs5PgHAQl+Xq0zJhmcgVyX20aZjUQfJfS0
	8cBWyDtfuOdcvqDZH0NEneABQY8yGy9zLW6Rl5VSXFOPPa7M9P9aeID1iBIZDvez
	RrfCGP2rJwYWO17+hRQSg==
X-ME-Sender: <xms:nqS7ZeZL0sSN5_odCeX5vdkvsOCiCpCr0DlG98SBeLHiqMPBiChcYg>
    <xme:nqS7ZRYRuXF7tf-BBEqzi-kMH3lfeKk4hWLR5Z4K4g5I-RCib-Acttig8AG15z0xM
    LYwh5UddWERCG88iPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:nqS7ZY9iznyhiGKP7YnBR_mUnhKxBooFkyaLliDR2nfmBTEMcgsymw>
    <xmx:nqS7ZQrdI7OIfLpGnDRXupFZQTd2lvuYxCIkWQq0YwhHJk_-Xfnypw>
    <xmx:nqS7ZZrdVyx3b5AJi1L8hmKTwflW3Tx7m_LLx88vZYDxN2HSclYC-Q>
    <xmx:n6S7ZQ5EuvV7yz_oWjsSWX4fKvwtp0TLNHOe6ZoA5H8SyRV2YAKZbw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9F57BB6008D; Thu,  1 Feb 2024 09:03:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b4309c85-026c-4fc9-8c26-61689ac38fa1@app.fastmail.com>
In-Reply-To: 
 <CAG_fn=Wb81V+axD2eLLiE9SfdbJ8yncrkhuyw8b+6OBJJ_M9Sw@mail.gmail.com>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-2-aleksander.lobakin@intel.com>
 <3f6df876-4b25-4dc8-bbac-ce678c428d86@app.fastmail.com>
 <CAG_fn=Wb81V+axD2eLLiE9SfdbJ8yncrkhuyw8b+6OBJJ_M9Sw@mail.gmail.com>
Date: Thu, 01 Feb 2024 15:02:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexander Potapenko" <glider@google.com>
Cc: "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Michal Swiatkowski" <michal.swiatkowski@linux.intel.com>,
 "Marcin Szycik" <marcin.szycik@linux.intel.com>,
 "Wojciech Drewek" <wojciech.drewek@intel.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Andy Shevchenko" <andy@kernel.org>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Jiri Pirko" <jiri@resnulli.us>, "Ido Schimmel" <idosch@nvidia.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 "Simon Horman" <horms@kernel.org>, linux-btrfs@vger.kernel.org,
 dm-devel@redhat.com, ntfs3@lists.linux.dev, linux-s390@vger.kernel.org,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Syed Nayyar Waris" <syednwaris@gmail.com>,
 "William Breathitt Gray" <william.gray@linaro.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next v5 01/21] lib/bitmap: add bitmap_{read,write}()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024, at 14:45, Alexander Potapenko wrote:
> On Thu, Feb 1, 2024 at 2:23=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>> On Thu, Feb 1, 2024, at 13:21, Alexander Lobakin wrote:
>>
>> As far as I can tell, the header ends up being included
>> indirectly almost everywhere, so just parsing these functions
>> likey adds not just dependencies but also compile time.
>>
>
> Removing particular functions from a header to reduce compilation time
> does not really scale.
> Do we know this case has a noticeable impact on the compilation time?
> If yes, maybe we need to tackle this problem in a different way (e.g.
> reduce the number of dependencies on it)?

Cleaning up the header dependencies is definitely possible in
theory, and there are other places we could start this, but
it's also a multi-year effort that several people have tried
without much success.

All I'm asking here is to not make it worse by adding this
one without need. If the function is not normally inlined
anyway, there is no benefit to having it in the header.

      Arnd

