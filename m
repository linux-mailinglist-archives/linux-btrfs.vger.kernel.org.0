Return-Path: <linux-btrfs+bounces-6158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E90924890
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 21:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E460A1C22945
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 19:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA41CCCB5;
	Tue,  2 Jul 2024 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="MBKu923b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KkgGMGoj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433814F7A;
	Tue,  2 Jul 2024 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949615; cv=none; b=Bvy1hU5b62+b/G9TDgSl8wLqYezFYIKJFgwIGaExoNMRXtaVuAt3l5SBS4ODEUN0OMJwlw/hxwhAIYfZAZFrBrq+LsAS+ekcakyPUwj9MQQcGrStYtgeveEMJYLBVpkGGvvio0Q40bmGSlm14Y8YnF3PHHGmUIjES0eqRGME6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949615; c=relaxed/simple;
	bh=qZaEi+CqhBPcsH5Eow79zhbsY4RJIggjmkMPqJf8N0k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=i00FawLrpkxYCVoaxBShRhxxznEEJnKjKuJiHEeGbB/fjkwI6jBqwKO/fhExz5Z18Qj82E244a+FSfVbjzVS8i6AfXiOw9hU2sLcopKRYLrmP+lP34kHw99hjU2AqMf2IFGs0ln5JiqsBRyeb4Q9UqS+pDkFx00vQUqhsaZ0Kn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=MBKu923b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KkgGMGoj; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0EB79114021B;
	Tue,  2 Jul 2024 15:46:53 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Tue, 02 Jul 2024 15:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1719949613; x=1720036013; bh=qZaEi+CqhB
	PcsH5Eow79zhbsY4RJIggjmkMPqJf8N0k=; b=MBKu923baKTVC4S1f+EmmxDywZ
	BbVqs4kIev4QCGLw+ujN1H/1v7JGwMvuIGaL8diK0XuNTHpMf+ubvkgIIaRjqfAF
	pPklYXrJ6qdOYnfpf+V1UjEKUB3cLinQye0Uic1dAiGfBmrxkcktBK0v3lwzDr2f
	qN1017/nZ9OsJ2NZqosfXwv67jJByr1mzwrIoLCzpKXt0SX5rPONe1h0gEV8ZUJU
	hRIzlzpYjOjdqybIaTbYe2yWOkZ4UmA6S/alFGDR5GGcvf4magTo/N5PCxJV9S6m
	b0A8MS3tX5lPDDrkgeUhAyljC/FWEHTPN5tQ8LxiRzy+WOLdQq/UJLXMKZ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719949613; x=
	1720036013; bh=qZaEi+CqhBPcsH5Eow79zhbsY4RJIggjmkMPqJf8N0k=; b=K
	kgGMGoj9N/GlnGimst7f0kLl0AoVr5VSMYpDDl2k+TxhYY/gG6oxpTy8d+ODqdOJ
	QWOTBO3hXluQwkWfDC5UT04/9PSF5a0UX6+xBkzdV2Fj1WXK6lKZ27exyLet/UbR
	toaU5ht0QYirVsKivLljWaF/0xqEUQqcbyGL5kP+ZtPW9RK3vfosPVDqmItNuB97
	tj8VT0MCIbafzfm/tlfESOoUsTUxgFeiJ0Gd9i6ENJEIWzTk3YpxwqymxJS7jLJq
	n2c7LJMBE/fBCiBtMx7L5SBrBv93Yf22+PPLnQkU/ll44AcctDC0l6nt3RfzctXI
	lXGPB5d1cAbz7jrm5+/dw==
X-ME-Sender: <xms:LFmEZh4osfu8j9Yp-zKhewtDYcUryrMhEkMaUxZ_2fW5EJiIB8ue3w>
    <xme:LFmEZu4kF5x1L-319bqGfC_nt7HCAZXGKEMs7rllPsfLFQc78hvfglgAO2XgiANMV
    ftHyCeTNe70Lhsj5m8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepleeifeeutdefgfejgfetieeiveektdevvdetiefh
    vdelveetlefhuedvffejieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:LFmEZofl0KdKIRU3e_cyh62iflkW4ccCiC7bbB2z-mXKXMaOmigFkw>
    <xmx:LFmEZqJwgBH8hh99M-kq0Ngu5PJ9f7fF2F7vbzKqaEU6N1FfEi-vWQ>
    <xmx:LFmEZlJFfWZ7gnthytXGz6jW0YewId_vwSeOe6a5xFDrDM2WVLmTdA>
    <xmx:LFmEZjzMHLSy1dvBEOYWiz3qnASPsMld9dSddStS0UCn56PlZ7letw>
    <xmx:LVmEZt_QUGNeUjtF0fyU8Hng0kzDB6xTJPlI0LghNJrAXI3A3K7uxWQ2>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B4EED1700093; Tue,  2 Jul 2024 15:46:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <93b5fac5-6315-4f2e-a2df-37ef4bf56f9e@app.fastmail.com>
In-Reply-To: 
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
References: 
 <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
Date: Tue, 02 Jul 2024 15:46:30 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Filipe Manana" <fdmanana@kernel.org>,
 =?UTF-8?Q?=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB_=D0=93=D0=B0=D0=B2=D1=80?=
 =?UTF-8?Q?=D0=B8=D0=BB=D0=BE=D0=B2?= <mikhail.v.gavrilov@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 "Linux regressions mailing list" <regressions@lists.linux.dev>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
 "David Sterba" <dsterba@suse.com>, "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough
 memory
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Jul 2, 2024, at 1:22 PM, Filipe Manana wrote:
> On Tue, Jul 2, 2024 at 3:13=E2=80=AFPM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:

>> Unfortunately, the patch didn't improve anything.
>> kswapd0 still consumes 100% CPU under load.
>> And my system continues to freeze.
>
> Ok, the concerning part is the freezing and high cpu usage.

We're seeing this in Fedora Rawhide, which is always using the most rece=
nt mainline kernel.=20

User first reported June 25 they were experiencing much longer backup ti=
mes, normal is ~5 minutes, they're taking 1+ hours now, with frequent fr=
eezes of the DE, notices kswapd using 100% CPU and then other processes =
also start hanging with 100% CPU. Resolution is a power cycle and revert=
ing to 6.9 series.

The workload is described as "restic via ssh to a repo on a backup serve=
r".

I can try to get more info to narrow down the last known good and first =
known bad kernels if that's useful.


--=20
Chris Murphy

