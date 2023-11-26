Return-Path: <linux-btrfs+bounces-360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4587F9159
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Nov 2023 05:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE9C5B20E2A
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Nov 2023 04:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7D033F9;
	Sun, 26 Nov 2023 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBECDE
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Nov 2023 20:54:18 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E90B8C1340
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Nov 2023 04:45:38 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 64F0DC13C1
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Nov 2023 04:45:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1700973938; a=rsa-sha256;
	cv=none;
	b=If/AnUKI8fQxS6NMsK+PzB1uodtaMAvrWsECRyeXR446TFQgEEFtCCjDiaK/LCDzqo36VO
	Fk8MChd0OwGxHWupeWyHUrFA3HErfXHKFhR/ifgH91ep9uJXLxPhMaulm5JI5iTbaIrdkv
	zQ9g72Aah08hMhhBKdcPzFo9yf7x5hQ/y+TVBS8OLQzFNFKSvT+KS9ojTO4sINTr+E8N3B
	FDIOQnkAPyU5iKYew8/Z8BOEpgAodK/Y7bAolzUmLMFCfft8DQfJS3KMzzHz7RfK+kDebv
	KG6n/wm/ZcR4DFtOZdEPlqpE2BuOkwrpRaWJCvavd6u3W2uzKSdA1nvfvFzv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1700973938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yDVjjbjMfX4aDQtWM5BBy4AyfESya7Bi9Ii6j7fhW14=;
	b=fpV46rYNtKNLle215RjExnIUIYeFDEEXcTky0O9dLyhofug6goa6gYZkXXx/ORO0d4r/pW
	GsQVbSpOPicgtknSWtmrwQ5iMy7KatL17vARbcwmjme4bkcbAy6ucQpn1ggwNBHaE6OB00
	qSnzvcZyvmgRuWF2B9ql9JqpCF4iWQta6GAZZzLYP9bBfHOt2FMRvfkyL6N235PdE8rvu1
	sa9QQrfj+wmRQ6OCrzDR3Gpg5NTv2x4NnB1evgTViej12jQh7thptvd3ALZhJoQMe9kuXp
	VGz1XUv/vVSy0rHFaBGBOD0R3H3O9mTJOm3NmqI6kW0Giw2JQTUmPMOKQ3TJFw==
ARC-Authentication-Results: i=1;
	rspamd-d88d8bd54-l5j8f;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Language-Bitter: 4e22bd3247a52649_1700973938788_172984101
X-MC-Loop-Signature: 1700973938788:94744224
X-MC-Ingress-Time: 1700973938787
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.104.11.72 (trex/6.9.2);
	Sun, 26 Nov 2023 04:45:38 +0000
Received: from p5b0ed26e.dip0.t-ipconnect.de ([91.14.210.110]:38324 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1r771P-0005ao-2n
	for linux-btrfs@vger.kernel.org;
	Sun, 26 Nov 2023 04:45:36 +0000
Message-ID: <89811fd8276376cc8b5ef10ec5cec91c36a828f5.camel@scientia.org>
Subject: could send|receive be made interruptible|resumable?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: linux-btrfs@vger.kernel.org
Date: Sun, 26 Nov 2023 05:45:31 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.

This goes along with [0].

Could send|receive be extended to allow being interrupted and resumed
later on?
Maybe at least when sending read-only snapshots?

I'd naively assume that for a read-only snapshot it's always the same
that's being sent (well not really sure, if that's really the case,
e.g. when block groups are balanced, defragged, etc.).

If so, INTerrupting the two could print out some information on how far
it go, which next time one could feed into send as parameter, and it
would continue from there.


The motivation for this feature request is, that send|receving very
large subvolumes takes obviously quite long and one may want/need to
pause that (e.g. I don't want to leave my laptop running for days, even
while I'm away).

Thanks,
Chris.


[0] https://lore.kernel.org/linux-btrfs/6f340d377c584239a1b8d4236d404d708e6=
1d968.camel@scientia.org/T/#u

