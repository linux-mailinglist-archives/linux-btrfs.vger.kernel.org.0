Return-Path: <linux-btrfs+bounces-1037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0750A817A72
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 20:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E55B2347F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAD45D74E;
	Mon, 18 Dec 2023 18:59:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87775BF9D
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B2719501B52;
	Mon, 18 Dec 2023 16:24:17 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id B62DE50055D;
	Mon, 18 Dec 2023 16:24:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702916656; a=rsa-sha256;
	cv=none;
	b=yETcitU+K7dYaK7fqjlvINjgBSbR4mFBSe6wLy17c0VwFDSlxj3a0GYz/aX1MTbRRBgxhC
	WgOg0EWkLGJMYixUjGv67Af9bM4yK3DbeTmdxIGKTSg4qnesT7wbitt9cTkATH2T/puHL5
	ZXMl64TsXhV9hYaYuKLE3hoTSAWyezekARXAZ7hOBi7Qtyl3qu5wQvNHANOhgZLRzog65o
	BxVbTY5oookvyCfG5wAxsNYtidLtyLe833oHJl43u2eeNoGnFCOMBDV7I1knOrgxIGwe09
	d4tU+W+6dZ3r3I0/cByXGIi7WUICn3BhWZ7uGMGCnQIrXeEXtPVGVUv17X69Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702916656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8fzBqwcRbyuQSCYBsEAcH3j6slgDzNlkqvCzt5fVvY=;
	b=u6TP7PAIXs+SGr6Hx4d4JpXdcc/Mi9FDqqT8UV/ARZDENQqVtUHWJUqzaNPXR0PpjtUYP3
	FEIDX0RPmpVVdFcYVX/gdxFv3SOF4mmZQRlh6vGt+kKOReAdR/xH1ewaY5T1evS40kiCXK
	dkpiiKHp8AUBhPz3N/C16Xvdbpcg748Z4kfuiFWdUsdC6sK9ZoNOcjXYOl8ks4RCKES1RD
	xwcNj3WZSkuNJ9XQWSE1fgCtzG9Qc2eIOgksKkpTBPU9GUqu2bwu0mwlYTtUvgekCOqeQr
	ZZ3hZ8KZfBF6P07L9odhk+PPddTdr5fLeHSV1rk4ouJ2rWUoBSB5UBDY3GuyFQ==
ARC-Authentication-Results: i=1;
	rspamd-659dcc87c8-6g8fz;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Fearful-Thread: 306a70040665eeee_1702916656371_718820325
X-MC-Loop-Signature: 1702916656371:2647141577
X-MC-Ingress-Time: 1702916656371
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.120.248.43 (trex/6.9.2);
	Mon, 18 Dec 2023 16:24:16 +0000
Received: from p5b0ed5dc.dip0.t-ipconnect.de ([91.14.213.220]:40714 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rFGPa-0002QT-1K;
	Mon, 18 Dec 2023 16:24:14 +0000
Message-ID: <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date: Mon, 18 Dec 2023 17:24:08 +0100
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

Hey again.

Seems that even the manual defrag doesn't help at all:

After:
btrfs filesystem defragment -v -r -t 100000M

there's still:
# compsize .
Processed 309 files, 324 regular extents (324 refs), 146 inline.
Type       Perc     Disk Usage   Uncompressed Referenced =20
TOTAL      100%       22G          22G          13G      =20
none       100%       22G          22G          13G      =20


Any other ideas how this could be solved?

Cheers,
Chris.

