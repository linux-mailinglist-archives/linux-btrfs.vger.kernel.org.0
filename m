Return-Path: <linux-btrfs+bounces-837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D780E2DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 04:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261D71C21729
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 03:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E449463;
	Tue, 12 Dec 2023 03:40:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E594CD
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 19:40:13 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E21A7140E6B;
	Tue, 12 Dec 2023 03:40:11 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 37CBB141298;
	Tue, 12 Dec 2023 03:40:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702352411; a=rsa-sha256;
	cv=none;
	b=h64rCDmVWCXX8mk1iRtiAZkG3yf72aMghUsaibUS++AMUkMGIAElgWJg1OsfPMX2MUvn2G
	hdRXK2g2lw5qopFkWrOat5Tr2CFSlKueWrW1/qkyztjPIvpMhOCIhinlPX+c68SRaJuYgN
	TLIMEMIhyzlQLwRVT06FobuNASUx3lpF/EnTgtryqePalAywpfdWtmJq6g6OaCN3MBdUGt
	ehQaWdmhR95v6xXtDtxu6xoaV2R2IPJ4QkW/R9UjYfYtIMe4yuJOQO8LCY0Ov3cb21uQVs
	Iai/eg8Y9+vFqT8WD1R7aln6vuftHyxgcleL7Hm4XBitERK8P50cX2d/iGvZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702352411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7Ym1cLaWBRItY+Y04y7gpkFi4ZwKFoHczd//3ko7v8=;
	b=ZH1BtNRt5c2fLxr6B/NiDI8AOKQ5sjvrXhsju2PrMkRB9UamSuMbTHl0ra8TAT5dqiwh89
	0oOQx/2sGSrJyRzkMDXQMD4GSDCW8MtLQ19Mkltce0q7gjIJgfCvQCOFkjNYS2aN08veLv
	WZjxJptTf+ffMPEp+OahbQwxkb7qddf+M6hOMIpWqI3rOlkJ2kFAYuqufInh7yvmnO1dRo
	aoRYhFiFV7VavtSLNmeKnrscfsKzWwOh4OHvdHUDQLbw1kbny2ONlM7nNZkPr4GMTWlFGK
	Hnc66dvA3K4IXFGPyg5gxL4wYfi/AEtothgrR6AI4u0aT9ZAWS6a/GtFWW7jlw==
ARC-Authentication-Results: i=1;
	rspamd-5749745b69-pwz72;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Befitting-Abortive: 51207ed87c11231c_1702352411747_870220017
X-MC-Loop-Signature: 1702352411746:2127108793
X-MC-Ingress-Time: 1702352411746
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.107.232.136 (trex/6.9.2);
	Tue, 12 Dec 2023 03:40:11 +0000
Received: from p5090f0e4.dip0.t-ipconnect.de ([80.144.240.228]:33508 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rCtcr-0000zv-2Y;
	Tue, 12 Dec 2023 03:40:09 +0000
Message-ID: <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date: Tue, 12 Dec 2023 04:40:03 +0100
In-Reply-To: <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
	 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
	 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
	 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
	 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
	 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
	 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
	 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
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

I just noticed that others have already had that problem with
Prometheus:
https://github.com/prometheus/prometheus/issues/9107

Some users there wondered whether the issue could be caused by too
aggressive preallocation via `fallocate`.

Do you think that would be something that could also cause the wasted
space?


Thanks,
Chris.

