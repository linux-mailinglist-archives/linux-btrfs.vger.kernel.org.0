Return-Path: <linux-btrfs+bounces-1119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CFE81C2AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 02:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C203C283489
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 01:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4001F259D;
	Fri, 22 Dec 2023 01:23:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CEF23B1
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Dec 2023 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5575F6C3008;
	Fri, 22 Dec 2023 01:23:13 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 173AA6C2465;
	Fri, 22 Dec 2023 01:23:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1703208192; a=rsa-sha256;
	cv=none;
	b=2Nv3P587fjyKf2Wm2w4nuhRoDTP3gnAEA1eiuPfzPlasDhAWDs0Jjqm1bizHeZWgu3ipF0
	J7g4hE9z8S1GwXQF4IFL8+8NRdmE0LqJsBMqoG5eZfHaquqcmCLUrJp4DuZDuSnRQc8oCt
	P6s1bHmtn5yyNluzKQ5hgqOdmOCn5yohhZOJQGIkGxnEPvO3trpzA9+KAwobUL2NjiDsB1
	ucm7NCCimija5DOpmBQwxg04zU5TfWNuBYcl4euU7HM7JzWwPlql4BypMMu2yMbKmQ21xL
	JyyfPk29KWFyLC/IFHRhuEDd6uTfmBQyaZ9b//ZuEM0XG/zrSnG6TPkn43wkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1703208192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWCHkUD6SKRXup626++vHoISW0JYtFb1pem/uQ8UCqw=;
	b=lgBLR7MGqNPdoljXeduNkXRZJ05rC4+ddQEk7Ge9E0JCmLxzeYYTwbkFnpGxgcjlLE+tOc
	ybrIfScAFq7QrRKWxiT3+17EzrxJFxYfpJm1neVYhis7+cd84nUS0YEmrwLkVdpNm4dLIP
	in/6DNGKFUB2B7OvpR/X+nMb5E7ORojwvLJ/UOa8P5/HA/ahVc2P4F6i0NQlj4ZVGip5MB
	mXbHPRld1t8PByvI6CxHDrUZiYzLeoCurl3gl2CEScB59hHNoWFvxcWJTj23gBgZ/Ca75J
	DD2XGnXhMDu5baqIkkH4/EVyfPwNJ1+MECLjV25AmvMDPJ9GfZsPocBUgiRDIQ==
ARC-Authentication-Results: i=1;
	rspamd-659dcc87c8-hldlj;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Absorbed-Duck: 5b3d6f0e6295273f_1703208193171_20346055
X-MC-Loop-Signature: 1703208193171:3109408662
X-MC-Ingress-Time: 1703208193171
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.96.174.32 (trex/6.9.2);
	Fri, 22 Dec 2023 01:23:13 +0000
Received: from p5b0ed5dc.dip0.t-ipconnect.de ([91.14.213.220]:47278 helo=[192.168.0.100])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rGUFo-0001LL-0J;
	Fri, 22 Dec 2023 01:23:10 +0000
Message-ID: <335d576a39c5296c4cb835d23c20f7896c3424a8.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, Andrei
	Borzenkov <arvidjaar@gmail.com>
Cc: kreijack@inwind.it, linux-btrfs@vger.kernel.org
Date: Fri, 22 Dec 2023 02:23:03 +0100
In-Reply-To: <57a0f910-a100-4f31-ad22-762e8c0ecb39@gmx.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
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
	 <c085dabb449f8088156d906062db0b9fa0f7fe32.camel@scientia.org>
	 <aa69e84f-d466-457d-9b29-47043c2aef53@suse.com>
	 <bf5726d2a30996d06204b17d05daec9c77b7d769.camel@scientia.org>
	 <57a0f910-a100-4f31-ad22-762e8c0ecb39@gmx.com>
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

On Fri, 2023-12-22 at 11:43 +1030, Qu Wenruo wrote:
> That's not a big deal, because before sending that reply, I have
> already
> reproduced the problem using 6.6 kernel, so it's a long existing
> problem.
> Just like the whole PREALLOC and compression problem.

A I see. Just wanted to mention it, not that you waste hours of time by
searching for an issue that might have been fixed meanwhile without
anyone noticing it.

Cheers,
Chris.

