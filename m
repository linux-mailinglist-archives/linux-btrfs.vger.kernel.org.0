Return-Path: <linux-btrfs+bounces-8175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877D4983980
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 00:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221AE1C21517
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 22:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD02A84A5E;
	Mon, 23 Sep 2024 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="WtIhnvRH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RwvlPOzQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71D14A85
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727129937; cv=none; b=B0Gasiif7GF91DOoEPiqKEseLrfOKPVjaC/452wmTnVjaE6WA35uoThPdnTS3b/Oru8rd0zRpEjmQuz/22ap4tfHoqI+7kmBGzfFedhxbOiIPjx2fyBXyZ83E/Kjidwqd8TBjg7B6Qhv4JNovwrSDPh42IFGrDKvch1LJqFY93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727129937; c=relaxed/simple;
	bh=u2gJp8+5K5DI99poyWXE4FBr3hgVKBqmKmIq1KmTC+k=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=M1hQ1LsYx86+LK5v30uo9ed5JneDFpanh+A6GuwiDYv/N4uPRweHwBKFX2IL33P75rJ3TMol+hWRUtAi+lVjrvL8F02WUcRHVV2Kg+5iweBFSqCFPpo30mplBYC3Y4rLumEBJvlTbxoFctXivkymJ9dMVUXWCyfaT5ZCkJM9a+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=WtIhnvRH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RwvlPOzQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F9EC1380269
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 18:18:54 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Mon, 23 Sep 2024 18:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm2; t=
	1727129934; x=1727216334; bh=fsFfBYm93Q/wrQAUtiKlcWHdpV5NJmF88cf
	FkmbsJ2A=; b=WtIhnvRHPDSwFntGewsk41bw2y2eySP/pzpV2LzFRR9F9Fq77KV
	U0F2MNU7riAW4qLkRe+CSCfwyTd6H5/s+kB7tsAVOCcf2x7rM/nPRVyXMDnJa1fH
	fLMALMyhQCvVvdtIPpgwd6rHRWGb4wP8efBMNaSO2FDoEAU3au7Z1KBrmZmVlB1J
	xS8Cq3P3Z7uaT6V3h9XoX4PUJmBOnEJ4l2jsEXBwzUFxzHh0nrWWZMZ/PB26hg+u
	7/SSO9kcveQ8Ro73V0wJL3sckHcNQ+JIOg+lzztPEGVVwVKDbUp9MjH5ZjWU8Nco
	ouAUSngjx+6eZGiidpstRc1lmbkyub7wtSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727129934; x=1727216334; bh=fsFfBYm93Q/wrQAUtiKlcWHdpV5N
	JmF88cfFkmbsJ2A=; b=RwvlPOzQ0qzhsYOvljNVAadLAYf8RHFIZ06+IXVwASb0
	2p/iAX4IoNCZMJnadPq3M6vioxo0JXlAgyKr9cEAcMwIzKUBoakvQbidcZy3xG2E
	EKrw5QrV6se5WIMdCh11RX8bD559KzVQAjKGHmSUtuVon3JNcR7uIQQjRKe3h55W
	RSugL3wB8+JlLIEIpeHlT0xZb7C2L0ydmt3Umz0tX7Cb4IuhpHTmWKCoX2vJOX84
	hhIUcVgFjmfyefLaX30NQZH7kS91KhknvuL0gqKCOLfwUzltEuNUebVCrsCsKvHN
	mU5npoN9VVaeMmSQ5cPquF/ddZjC23COhlDn8kY2Zg==
X-ME-Sender: <xms:TunxZlIKA_XrVQPgOwrSnepNQBVFRvXuKHscgiplopHtormX9VmwWw>
    <xme:TunxZhItH_Xo8Jru00fLYbmLjD73dR9cksPVx-3SmRxr8gnZBMxlVHQSaOB9FTj7D
    PbPWzw9WlLNbCELXiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddttddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkufgtgfesthejredtredttdenucfh
    rhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvg
    guihgvshdrtghomheqnecuggftrfgrthhtvghrnhepveffkeduleeuuedtgeevteffheeg
    heffueduvdefhfehheetiedvgffhleejkeefnecuffhomhgrihhnpehrvgguhhgrthdrtg
    homhdpfhgvughorhgrphgvohhplhgvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvsh
    drtghomhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TunxZtu0vIBpzzrFQKF0iMmma8y9zHr4ACLU4SSkMCS2mQiQwd66Jw>
    <xmx:TunxZmYvnUNA3hcxwTTOD4HKCDIgelgiozbGLdcWttOZ5WWU2TD3tw>
    <xmx:TunxZsaWzmQfFfBDZv-GrBOZhws59nTuHVrzQJ3aChsImKXeda3L6A>
    <xmx:TunxZqCy2rrCCkafBzxQe-mTYWFQMD8v1Vx38lC8UVk5Xnba7CUMTQ>
    <xmx:TunxZlBymx0w3JGbrFYQvos6NG7Zcz1h3tQDJleQoUplJpUjUlX8lQPu>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 602671C20066; Mon, 23 Sep 2024 18:18:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Sep 2024 18:18:14 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <1079dd1b-b43b-434d-86a6-f65b20b4cb01@app.fastmail.com>
Subject: 6.10.6, tree first key mismatch detected, write time tree block corruption
 detected
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

User reports sporadic write time tree checker warnings since kernel 6.8.5 through 6.11.0 - some of these file systems break, can't be fixed, and the user reformats and reinstalls. Therefore some of the corruption is getting to disk.

https://bugzilla.redhat.com/show_bug.cgi?id=2314331

This seems similar to the other thread I've reported about write time tree checker being triggered. But this represents a more serious and frequent occurrence.

full dmesg for a 6.10.6 kernel here: https://hobbes1069.fedorapeople.org/dmesg-6.10.6.log

Looks like the first bad key is:
[   56.387823] 	key 121 (14136236289662124022 254 199011574867967) block 556335104 gen 5817



--
Chris Murphy

