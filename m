Return-Path: <linux-btrfs+bounces-18128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF9BF8297
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 20:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592BF3AABFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 18:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF5F34E751;
	Tue, 21 Oct 2025 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="pMEzNw/p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="koUCiktc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5834D904
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072951; cv=none; b=GJV/AgvPyxePSixJY6XF6qrnEEGdgS+qWyUuUA8eEozGuigF6558Mok3ybywghYO/YKicDvKmcLaomnFXlvF9MRG2Pn8HqrIQg8H9DLE0YRoGkcwuDT24xxt7YH02eIbB5ro/GGIr20/OL1aI4a1S+DCeRNaL0pqXTo8pFDIi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072951; c=relaxed/simple;
	bh=pbyzMHoSwJJFfnr1jstzLntQV6Vzf3XXwIJEC4q9EjI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pWCozO7fE430kHsIPXZOZHaNaEoBFMOHp/vlmUChLgckmVqXfW1LSjbOMd909zUcKnk541iZLobwXUFr3gRmg0wjJ361/f3u9MIkKrg1Sj1bLS52VVbbE7nGtfiEAwoTd+jM4fmqCFf2FjVLsiB+LK4JyH98xgtFvE8SFgFowvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=pMEzNw/p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=koUCiktc; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30897140019C;
	Tue, 21 Oct 2025 14:55:48 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 14:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1761072948; x=1761159348; bh=pbyzMHoSwJJFfnr1jstzL
	ntQV6Vzf3XXwIJEC4q9EjI=; b=pMEzNw/pI+jyiNGIS4bO0Oc6ZLvH0VxCnOFvo
	XsR0D5OncSLcVyPCXSbJ6U3sC0dXqDYr7pEDALuNMghm25Zxn0fXeVqf/+Ef6G5A
	RQTtlmUm1D59bF0s2oPyFrRJCXS9lAfoyC8F3/LyLHuqTnuChhvyAjhhEunLFgTu
	YF6kMgwJDi9yr/GxADVgmlOVa8Y4omLk9tC8EquYiB9RvqGFYgm3Vekc2pavIPfS
	tefaoin3WQgOiSdhSPAtH+7nCHnk/VHD2FaZdEQBXpDfNGJkhJ5pw1AXmaRCcuxI
	EuVjb5FhgGU1l8GwJV+8k5AxnFSN6eAQry6pVXhlD5HrNwDeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761072948; x=1761159348; bh=p
	byzMHoSwJJFfnr1jstzLntQV6Vzf3XXwIJEC4q9EjI=; b=koUCiktcSDrdK4Q6R
	HD2qjZMGc4oq4YQTeUqfOm3A765bTMXdBe3UIw6zCabj7PfN1FIIv7Jf/ew1QOR2
	mSRaY850SxCfVteeqO1nKlrRl1EL1OoQ1s/VPJq29Z8GusmBiAswYu/Z/pjtr37d
	gkURUU5HKTEua1whb+zva1gpcOro4KyTy5rDF+XF5LXSxInMMdhUFPdHyYch8tvH
	10tLjei+Vq0iNoQyk1KksGVnsSo1xYJxlBuzH0Mr1sLKQW8lWl+vSVP4KEGCmkBT
	1l3Qo3aNHFGkvCnZ5H1BDojz4uLVNIvNX0vZ7gST/tONgTJv/eT4+aXXJxkOu1wP
	mBx8Q==
X-ME-Sender: <xms:M9f3aD7RK83R5b__KbfK3RI23uYHL1_7KF6fgQrqdoi3UP2ZxAddCA>
    <xme:M9f3aDufXD6cziArxKs_8AEeuCzOWFAXtFmF6gTuFAVgneVMc9G-gyT5ciDU9puK-
    4VN7t3kIASgWZAcwA1K3FAddxioOQ-D8qBhZrSjMns656UMW0Tps2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepkeejjeeftefgfeekgeekteekheevjeejtddvkeelkefhteej
    jefhudettdelheehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhlohhr
    rhgvmhgvughivghsrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohhnrghhsehjshgvrdhiohdprhgtphhtthhopehlihhnuhig
    qdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:M9f3aOkDJXvjXSXDusBc7d22W2-lNDkowR1uhfYBqkEGedtqPpM_bg>
    <xmx:M9f3aDxJ7IAH9XqO37roL5fiQzeERsuaPQKptWdCSKd6euy3eEFDJw>
    <xmx:M9f3aEOUfaM6KPEpyywdeVCoND9UDv2zqaPpZU41OEt20ClQRU2c-Q>
    <xmx:M9f3aPQ9CNVf_QfVEKGuiSSTwrROCyXD8eL3nnH1qg3aeY-vrMcHaA>
    <xmx:NNf3aEeXYGn8zrod84HNslLjH_MPF4eOyFHWl8K-3FxIOoMJnw7F86Ip>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BD93918C004E; Tue, 21 Oct 2025 14:55:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYo6J0g5KRfR
Date: Tue, 21 Oct 2025 14:55:28 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Jonah Sabean" <jonah@jse.io>, "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <7def6c73-d1e4-4c43-957b-6e88b16ea9ae@app.fastmail.com>
In-Reply-To: 
 <CAFMvigdN7F20FiX0yVn1mcFp709Y8W6USyMBPDw-Db-mfJgcVw@mail.gmail.com>
References: <20250922071748.GB2624931@tik.uni-stuttgart.de>
 <CAFMvigdN7F20FiX0yVn1mcFp709Y8W6USyMBPDw-Db-mfJgcVw@mail.gmail.com>
Subject: Re: btrfsmaintenance?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Sep 24, 2025, at 11:32 AM, Jonah Sabean wrote:
> On Mon, Sep 22, 2025 at 4:18=E2=80=AFAM Ulli Horlacher
> <framstag@rus.uni-stuttgart.de> wrote:
>>
>> In Ubuntu btrfsmaintenance is an optional package, whereas SLES has it
>> default installed (at least last time I have checked it).
>>
>> Is it suggestive/recommendable to install btrfsmaintenance on every s=
ystem?
> I don't personally use it, but to each their own. It's really up to
> you and your use case. I use btrfs to store media files, so read heavy
> workload not much writing. I don't run balance at all unless I need to
> which I'm comfortable with just doing manually, and I schedule my own
> scrub jobs.

Same. But I'm also biased in that I'm looking for bugs.=20

I did just bump this older thread from July, enabling periodic dynamic r=
eclaim in the kernel by default on data bg's only.

https://lore.kernel.org/linux-btrfs/52b863849f0dd63b3d25a29c8a830a09c748=
d86b.1752605888.git.boris@bur.io/

--=20
Chris Murphy

