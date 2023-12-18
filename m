Return-Path: <linux-btrfs+bounces-1042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D7817DE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 00:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 576B2B22AB2
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A27760A8;
	Mon, 18 Dec 2023 23:09:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from dormouse.elm.relay.mailchannels.net (dormouse.elm.relay.mailchannels.net [23.83.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013C7608B
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8BBA3941925
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 22:30:41 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id DCFE5941BB5
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 22:30:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702938641; a=rsa-sha256;
	cv=none;
	b=JbXT3QLRBU/ofN+NzZ7JeXhsS0IZ+k19JRO0dj59YckqVeJIPb4qnKQ6qS4dsosYxbXOO5
	lmVfxSWm0LZQpIs44Kms3W7bW39g5j7AE6BkonYTklrvDsIiG8cWUxmGqtGzxw/tESTYYz
	Cw1jXfBRsjkvDedSliP68EnXaZKJMtxTD2rJRSuTtk46+GtYepDIHOerx4cACTS+hYJBb6
	ecz5jGy2R9Np94o19QOI10TAJvzacbhse5BQY4iswRBQS1q29AarBCZyUx7aVRevUENWUV
	uu7t9Im2WC4eQiHBxtHakTufRXDFIOJw1wLy7f57mJou+W+lMELCU0unOIgfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702938641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6xlsSG0xCkrLJlODo6nftMgPe7YM7cjZ8eoloSfOP4=;
	b=H83f/0uNZq2suKr4GPnLNwyrjVoKKHiH42epBhEw+gOFXWSw6Tz6sdxoG+6XZdc7cGnyWy
	CJy1Ur6swum440qnAqdmSAzKu1OsvIleBFXC/rEy1WrIEv0dGoOwc6QfwRsdbPVfCTOjxD
	4M0flxlz7xHWz7w1VSnWfCA/YzgHItgjpD3K5ZH4X2KTpXiqSGysLkTdoVfCN3FBByRbvX
	ZMeEFuLQsUHQwMQsTCyXMQqmikdhKIz1pWlZuwa5rn5pniM7BjYGE2IeUxkDnf75Y9X9GL
	8scIXIbhvTx9cXlthk+69J5wEAkdMm/WFL5nDIMld3WQXUkDcL3su2afrAc7lA==
ARC-Authentication-Results: i=1;
	rspamd-659dcc87c8-pb9dr;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Name-Dime: 50e7bcaf4d2b1c3d_1702938641391_327959844
X-MC-Loop-Signature: 1702938641391:819029078
X-MC-Ingress-Time: 1702938641391
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.104.199.175 (trex/6.9.2);
	Mon, 18 Dec 2023 22:30:41 +0000
Received: from p5b0ed5dc.dip0.t-ipconnect.de ([91.14.213.220]:52336 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rFM8B-0000p8-1U
	for linux-btrfs@vger.kernel.org;
	Mon, 18 Dec 2023 22:30:39 +0000
Message-ID: <9205bba254d09a2afc57bc93fb7f818dc6835c6a.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: linux-btrfs@vger.kernel.org
Date: Mon, 18 Dec 2023 23:30:32 +0100
In-Reply-To: <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
	 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
	 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
	 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
	 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
	 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
	 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
	 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
	 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
	 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
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

Hey.

Had already sent the mail below this afternoon, but just got a bounce:
<linux-btrfs@vger.kernel.org>: lost connection with
    smtp.subspace.kernel.org[44.238.234.78] while receiving the initial ser=
ver
    greeting


So here it's again,... effectively it just says that autodefrag didn't
help either.

Cheers,
Chris.


On Tue, 2023-12-12 at 14:43 +1030, Qu Wenruo wrote:
> The direct cause is frequent fsync()/sync() with overwrites.
> Btrfs is really relying on merging the writes between transactions,
> if
> fsync()/sync() is called too frequently (like some data base) and the
> program is doing overwrites, this is exactly what you would have.
>=20
> IIRC we can set the AUTODEFRAG for an directory?

I have tried meanwhile with autodefrag for a few days, but that doesn't
cure the problem, not sure why it doesn't seem to kick in.


The way Prometheus writes together with btrfs, causes extensive loss of
space:
compsize /data/main/prometheus/metrics2
Processed 305 files, 567 regular extents (586 refs), 146 inline.
Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 Disk =
Usage=C2=A0=C2=A0 Uncompressed Referenced=C2=A0=20
TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 21G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 21G=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13G=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 21G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 21G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13G=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=20


I'll try with a manual defrag now, but it's a bit unfortunate that this
happens without manual intervention.
Or would it be better or even help to balance?


And nodatacow isn't IMO a real alternative either, as long as one
looses one of the greatest btrfs benefits with is (checksumming).


Cheers,
Chris.

