Return-Path: <linux-btrfs+bounces-18338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27437C0A11D
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 01:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5681AA7DC6
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 23:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A5D2E54DA;
	Sat, 25 Oct 2025 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="hsB0eYeS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vUBFx400"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C02773EC;
	Sat, 25 Oct 2025 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761435678; cv=none; b=r+97edIg7wxhWAclwMDjKWElllp+VQV/HlOBldswBXdplf5k2LbVVnYtJMdX1uLamuBFwnjErclAN+5c/zPf2FOoMLOrjDgruNY5FJd/Sjw8HrXacu7MnXigJmh2dLml/+bn9ioU1tnlDGFyKBQB7PznRQNPQtjKmfI6LdHQewA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761435678; c=relaxed/simple;
	bh=+0yQ3PZ/Y6GvAIwGi6qJ8MBf11coH/dJxfHmD9XPI3E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tk4UMNdVJHq5agtTM1fM1KEXaxSrRSv2wwdAMS7Cnr0mdXK8Zmbcre9A0cLr0VkuQrshCLgyC9ythp35CoeKG4plzrIuPKeUKXULGB967zIwyyAYl6I6I6pe4okDSmhZ7gFqDhCHIovqHJbmI9LEA/3FdmMF8bF7GhnkWK6yDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=hsB0eYeS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vUBFx400; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 000FC1400157;
	Sat, 25 Oct 2025 19:41:14 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sat, 25 Oct 2025 19:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761435674; x=1761522074; bh=EpSnKmqai+
	3jFmppMoZumhVdGX9BUprbSJKZUnw1mcU=; b=hsB0eYeSnDyEFHPt5E+O3i+/1q
	neithNRIJ82/BbhOXs/YaUTWsJBXRRL8Kt1ozJ8oevYz9ejLzEzklwxvbEYTGb+P
	Wrut7B77MB28v0YjZ/DM02Enx5SpkYz/RwiPUzvd0LLxXqqWWzk8OtFhzHIy5y9Z
	hcBygvThSzmXr5cJ33aBG8iZ29eJ6LaD1/ICxG19d0TsIzIjkuyOwz1HWZNMOYl0
	jMAwV5VPcrRKPg1CQs6VC8mbcxdMD6S6az0welHu2HiY3cxun9Dy0+4lkK2bpKUi
	gLwiAiJtmvSsB/YmvYQVvQWefkHS+N03pcF6I1muqDKYk/rGxA432ZZPp0oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761435674; x=
	1761522074; bh=EpSnKmqai+3jFmppMoZumhVdGX9BUprbSJKZUnw1mcU=; b=v
	UBFx400jg9hw/tRsFdyTtlEURJyFMU7u44GGZVEWBJH1FwKrKGDH+fJxkTPV1taG
	x4EU0o5IHYvLYEB1l7gzg0wm2hh72BcB1wdQQodwrkert3NvblPhjAQ+eQ5l9xO5
	JLeSBTnqg5vJFKD+2m0OJjdKnAtwh/TlwOU/ckaOBAN5L+fmFkPbtCsIrn1WsyhA
	bfOMHHyK7hiFqBhGNTbbokcQeAjTktEjHApLHpcMf4UHeKhH/dWHvaI1uOLUW82p
	kaG1WgAQYf+WhLD8NQc3pgnTuFBvSW7UJVtWUgb8AIGz0iLIAcpLReKtbxCiVdWe
	RtVrmm/EaphiX6nnMHQdQ==
X-ME-Sender: <xms:GmD9aDIVW9XXuZzKrBWy653PjXYxLXqAFzSF34OaQd37kzcq7M1yEw>
    <xme:GmD9aB_GeW63CsGhOxKDWRdLGFoq4_XYSzWcnf4T9G19BlEWOBrMCBPaDoyReVazt
    n2NBWFS5zaHsVA6kbjqTCTgwP1IhD2IO3iGrWyRbi_eTWsjGqW3eR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheefheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpeekhedtieejleeuleetvefgvefgtedvhfegtdejieffhffg
    tdeutdeljeevgfdvueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtlhhmsehfsgdrtg
    homhdprhgtphhtthhopehslhgrvhgrrdhkohhvrghlvghvshhkihihrddvtddugeesghhm
    rghilhdrtghomhdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GmD9aCIsvY98HazfWjqCNgAJ-W3EOG4LkUKGNWt3Od8XV5TtQE53EA>
    <xmx:GmD9aFF1uuPkw-MVHnURhsmIsxl2J6X3V516TPIlmCxC5hgBWDrZ6A>
    <xmx:GmD9aBswf-5DbM2vpJFG9sEINcf0kvpdqfoO0C1fWjJAtVjzBZ_2Mw>
    <xmx:GmD9aMvBEZNn8E7Su-qaVcrH39OiRggffZl75wq839UULtLjkOkmtg>
    <xmx:GmD9aGcTp_ujcLCK4D8g34eQBBEG-_hFYbXYelVdWk_ZXa54g6ojv34z>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7721118C004E; Sat, 25 Oct 2025 19:41:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJNHBnwyGDYw
Date: Sat, 25 Oct 2025 19:40:54 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Vyacheslav Kovalevsky" <slava.kovalevskiy.2014@gmail.com>,
 "Filipe Manana" <fdmanana@kernel.org>
Cc: "Chris Mason" <clm@fb.com>, "David Sterba" <dsterba@suse.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <601d70f3-ab6d-4f15-88eb-169fede1a685@app.fastmail.com>
In-Reply-To: <d039a3c8-c4f7-487c-a848-2a26ea26f77d@gmail.com>
References: <03c5d7ec-5b3d-49d1-95bc-8970a7f82d87@gmail.com>
 <CAL3q7H5ggWXdptoGH9Bmk-hc2CMBLz-YmC1A8U-hx9q=ZZ0BHw@mail.gmail.com>
 <d039a3c8-c4f7-487c-a848-2a26ea26f77d@gmail.com>
Subject: Re: Directory is not persisted after writing to the file within directory if
 system crashes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sat, Oct 25, 2025, at 5:49 AM, Vyacheslav Kovalevsky wrote:
> I think the line with `echo` may not be the correct translation:
>  > echo -n "hello world" > $SCRATCH_MNT/file1
>
> In the original test, the file was opened with `O_SYNC` flag, if you=20
> remove it, the directory will be there when the system crashes.=C2=A0I=
 also=20
> forgot to close the file after the `creat` call in the original test,=20
> may be important as well.
>
> The test itself is quite weird (why would `dir` be gone after seemingl=
y=20
> unrelated operation?), any detail can matter.
>
> Please run the original test with a real system crash.=20

This would produce hardware specific results rather than determining whe=
ther the file system is behaving correctly. It's possible the hardware i=
s acknowledging the metadata, flush, super, flush, but then it's still n=
ot really persisting on disk


--=20
Chris Murphy

