Return-Path: <linux-btrfs+bounces-822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3307380DE34
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 23:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CBB1F21A64
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 22:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DE55797;
	Mon, 11 Dec 2023 22:26:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
X-Greylist: delayed 149 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 14:26:32 PST
Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF7C8F
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 14:26:32 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CAD527A1DDF;
	Mon, 11 Dec 2023 22:26:31 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 36F8B7A1E6E;
	Mon, 11 Dec 2023 22:26:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702333591; a=rsa-sha256;
	cv=none;
	b=B6FINbt0aNKU8Sx8aFy2GXyyQtoJ8cg+17+n/c5b0QJeZkxKzEUK7DuRROVeyH5hlgYUBU
	/FJHQqb0x1Dm66JWiHjt1N9NJc1eSoKyHqzr0UMgnYvd9wKmAM2uZCzb5SgHebB96+rHga
	WXRZLoQo9hkjfsGJ04b1DUyyCeNWlBSgRMdGFpHSrlWH+xl9qb4m361W8Uq/HkQEaiodA9
	ZYBGC6xCGPKUEY3UDp7mRGkh41gfR6uvF8PAn3DU5ppKH6igrgmJRu+84ycNlnSa/p+1qv
	+Dkc4sSeRtOFslOwv2XBLDjtDpvO+7E7WiD9p9hz3TqVsdJcfOyWxqDT4QFXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702333591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CErQOc8vSOqwh6vJui7zRKsabjnKMPByEM3NBC0ZcII=;
	b=0bZgxVNGGRKu2HZM2ofU9DaOCm+YeiqoPyavPRfLXvxkze1r84lzeRyj0wKRPw1xalBr7K
	E/perxtOycAsc9h3upaemJM+8fD5OxgPh1+ZOKRkgFFwzVBkt7UT2DttScSLj+jDV/389M
	+Ti00DvH0Mnud+zsRDWxG8BGtxbG/yO2C+eM5wzOzS1syFfP5q4dkr0b0ogmEI24kSMCjx
	WQturjtcKXitl+fLyioi9SfIy5xzL2giMWSF6I9UaxU393YUYH/xAdaGSdLVFvuOF0Ssip
	tOZe1RcXI2zr9Ee+q/AXCTsXXZ79T8m8nYTRmQP9x7W5Z4dkbvP5UvPAYguZHA==
ARC-Authentication-Results: i=1;
	rspamd-5749745b69-c5kst;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Towering-Celery: 7a2b5261056e0177_1702333591662_1127547581
X-MC-Loop-Signature: 1702333591662:1053256317
X-MC-Ingress-Time: 1702333591662
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.107.232.136 (trex/6.9.2);
	Mon, 11 Dec 2023 22:26:31 +0000
Received: from p5090f0e4.dip0.t-ipconnect.de ([80.144.240.228]:60182 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rCojK-0002KI-0C;
	Mon, 11 Dec 2023 22:26:29 +0000
Message-ID: <af3edd3b1acc1b056e3eae8923823c15740ad98d.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date: Mon, 11 Dec 2023 23:26:23 +0100
In-Reply-To: <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
	 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
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

Oh and btw: I did fully unmount all mountpoins of the fs in
question,... so it cannot be just some process that still holds 11G in
deleted file(s).


Cheers,
Chris.

