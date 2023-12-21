Return-Path: <linux-btrfs+bounces-1115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B8B81C1A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 00:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D801C24A03
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 23:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E9679476;
	Thu, 21 Dec 2023 23:15:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F6579465
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Dec 2023 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A4E04801C9B;
	Thu, 21 Dec 2023 22:55:01 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0F2A5801716;
	Thu, 21 Dec 2023 22:54:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1703199300; a=rsa-sha256;
	cv=none;
	b=TYx1Iro6TAdNr50zQ9fJE6lKz09hkJi0vQIaSSgAkTgdbU03nBHtVm1NsSuJ5kiXrRpS1D
	imLLv6MruDiF1rtpPH8AsuoIMKJ+3xLhXBEeT2+Z8ueuHno85O66PEG2mFoJLP50HFb/Wl
	+hWXPUqe/sQgOOJSVLXggqmxj35c1pGhSerSyuDU/lAiUFks+/tfg30JCf5gfMBGE2nEB3
	cJLNA+CQZsKTIJtWAAZG5LMv0IP5m6s1jwM+lrlFTbw0+cy3pKpZ5GvZHqEuJK+3IA1x8m
	nR/JwMsp9KDPTw/aBsKugCkpXta3GimARQsasedNs8FWTirErjK8g7xxuRqTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1703199300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaFJ/ntuK8opL2HGRRwJOd/VGIq4wmygHBIwEt3cSp0=;
	b=eeIR+oUWdPFM5ZJfxK1KdvIPpk5SKNtafyPM4l6D5py/9slEpN8jqiEvZ79Oam0pjGzgRz
	VtelOI7YXQJ2K2kXgG4bvK5gWi/sALFnASKMp8bTfdchUYs/NjOgagYF61AsnzicrkEU0v
	oKDv6JSVj6PSvixaDl2Zr4VPTtATMP9/PciPwY4aFAhdW1MJ5UdbwJQQ+qvtbtcJN0PYCc
	hRLwCxa5IWVZ+anYZqyuH8an0jcAvpwb5nCZoYknvLT5q5pOZjP4yB06LFEqCnF4qEfGHx
	yO94nTW2/eV8Cp/5IN9swDMHQyKaBrnkiFG4GztgQA6ooKdj8mDz8lZ9yE5c/g==
ARC-Authentication-Results: i=1;
	rspamd-856c7f878f-gxdgv;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Irritate-Fearful: 620c3ed04b3fe6e5_1703199301030_3351372602
X-MC-Loop-Signature: 1703199301030:491497330
X-MC-Ingress-Time: 1703199301029
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.124.185.70 (trex/6.9.2);
	Thu, 21 Dec 2023 22:55:01 +0000
Received: from p5b0ed5dc.dip0.t-ipconnect.de ([91.14.213.220]:54268 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rGRwN-0000ld-1H;
	Thu, 21 Dec 2023 22:54:58 +0000
Message-ID: <c085dabb449f8088156d906062db0b9fa0f7fe32.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Andrei Borzenkov
 <arvidjaar@gmail.com>
Cc: kreijack@inwind.it, linux-btrfs@vger.kernel.org
Date: Thu, 21 Dec 2023 23:54:51 +0100
In-Reply-To: <ba9556f9-4784-4bf8-8fa1-49b17df6d31e@gmx.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
	 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
	 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
	 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
	 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
	 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
	 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
	 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
	 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
	 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
	 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
	 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
	 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
	 <b47ed92f14edde7db5c1037a75b38652afa6c1c1.camel@scientia.org>
	 <e6ef9ab3-06ab-4360-b205-3a7559b6b388@gmx.com>
	 <979fd68a4a766f823366797eab1060e5c515a776.camel@scientia.org>
	 <ba9556f9-4784-4bf8-8fa1-49b17df6d31e@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Fri, 2023-12-22 at 09:11 +1030, Qu Wenruo wrote:
> The whole one is easier for me to check.

https://drive.google.com/file/d/1-TJKoL85e23u5mJN0Nuoa9qyvgLRssFM/view?usp=
=3Dsharing

Should contain both (-t 257 and -e)

>  But I still strongly recommend
> to go "--hide-names" just in case.

Checked it, and it's really only the prometheus filenames, all of which
are completely non-sensitive... and it makes live easier if we can see
the names.


> Meanwhile you may want to upload the extent tree too (which can be
> pretty large though), as my final step would need to check-cross
> extent
> tree to be sure.

Here we go, thanks in advance.


Cheers,
Chris.

