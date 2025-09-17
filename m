Return-Path: <linux-btrfs+bounces-16890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF054B81003
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 18:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EBA176F1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2BE2222BF;
	Wed, 17 Sep 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YZC9Heap";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fFoev/Iw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2722D3EC7
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126441; cv=none; b=NynLcqsOrsdMgctQew2jnFssnC0FufLXIMXws7A+YI8Ftefduu9gPi7lUKrvOgOTXXndjCXGtNFVP7DL7yvE+Gn6CCEVgVKKrFW51vTO3BK79cUOXZigutNlMVv3krdZa4ChpQFZNGuQRBTla9fVGP7RmgD0/P8/kgQajInTHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126441; c=relaxed/simple;
	bh=xzuLnS/SiSv3YONbVaIu+63IFrBwRQ2ke0oGXd9hxlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFjgCiNJeB/89CgqQ524rXtAQAAQSGzqOyFKWDVPTLnZQbEhrT835VvOo6SZMZOOIsEJb84EapXhQfY06cpI9Z9zdny8Yk9CyfVpji2qxufxkOj2H0lYcdLE3XRbXsPK95rQkiX3FKeTRdw/OIdUPosme8IaOB2QvHidt+2FdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YZC9Heap; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fFoev/Iw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D47FB14001AA;
	Wed, 17 Sep 2025 12:27:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 17 Sep 2025 12:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1758126436; x=1758212836; bh=0ml9Lqvi93
	d+Hi4rG+oTEG6KDuZ9Ou8YXSB7n3ELgq8=; b=YZC9Heapd4zFlvOcifLvf72WeR
	NVd821/AHCULX6q8gKcvlYRLb9/M2o/cpiIu2MdlGUv/poxMInphwK54CkyKRRVD
	ZfYvEGFUcZbdVmstkVtBMi8OGPCofzI6772YZd1e1hoXJk6kaHv9w02QyL/xAsSK
	UlfirRwAET3BKmlK31NkfB2Ecg4XihNdvX7uk6XC/HsMld95779nIb95qFlnScDn
	Uj0Rsu9MH9TsypJedJCgfxk1tED3HOJuBJNDH0W6grCXkswKiKSbSKQqMmX5wRMd
	JVcwe1ghFbFjpoGm2NtCYRftTFwdUp9eIvVpOJkoUzcfJvXgMHn7pdypHsMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758126436; x=1758212836; bh=0ml9Lqvi93d+Hi4rG+oTEG6KDuZ9Ou8YXSB
	7n3ELgq8=; b=fFoev/IwnUO5tK+4ieuaoULD55ha3OdFTm42tEqYPwa61gt1TNi
	kWIWbFquhA7v2Md5y/DcuJZBjaqfXb2ZJesS7ogu1j82zSOz6Huob63XgBESBMyV
	mOAC4HbnqP6wBeIhh1PzZIIk2S8KJ/6r7UzWZXAosqWCJQO3tRo/u6MCgkGQlVvH
	A6iB1f5G3U1yv9nDfD7rHh9XERcnenrPPod8FV6cg6qykvbMReoWq9AENjV+2n+a
	7/XwUYMhmFjNX4gj6I2v2EsIfQbHCoeRuutF6fsXxpcxpFoQ0howTMq75D/AxrI3
	nMbqmZU938f9O3tw4kFWXVAmBmy42Eqxakg==
X-ME-Sender: <xms:ZOHKaFjj2yCu-Mrr7Oji56Dz1Akfa_iuwS--zCdotMZhynafKBkkng>
    <xme:ZOHKaKPSSaXV53m_wDlv6Jb5wH8WBPCI0lEl39hq7_LkJT8Y5CgmAN0M9csTx906P
    BjaSLwQSVEn1DaJS8A>
X-ME-Received: <xmr:ZOHKaG5qy2OpGr5DV9urrG-T8Lej_t3VqS07UZFclpKT7C2vschztIGI1CoV91ccZAGIlHkvJ6OhMY9r0djxR6GkeqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrrhhvihgujhgrrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZOHKaI2iaapX2BR02vNyrNmiHGxJK0LqCUBwGqiE48zKvlsiHGYiAg>
    <xmx:ZOHKaHbPmDTY6ex4c7xVfIGbiISi3z5PjZNzXvK9KM-3q2goD84stw>
    <xmx:ZOHKaAAM0R89Jmq0xj4Wz2XT2VehJs80vFOQ3GP2LtX2H0BgqvJRtA>
    <xmx:ZOHKaJ8TnB5pap8EmgC3g0R4Zeb2PzqIXETcmm32fG__u8adE2u3AA>
    <xmx:ZOHKaKzloFYw3QF6vde0QsF5lkiFLl7oMgmp5vS42QFl50RBinFdOKGV>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 12:27:16 -0400 (EDT)
Date: Wed, 17 Sep 2025 09:27:15 -0700
From: Boris Burkov <boris@bur.io>
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Does balance always allocate new chunk or attempts to utilize
 existing chunks?
Message-ID: <20250917162715.GA25454@zen.localdomain>
References: <CAA91j0UzyMWB8htCjuBvXoWeUxKwDS-W1HkaVS54p=aTjqBv1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA91j0UzyMWB8htCjuBvXoWeUxKwDS-W1HkaVS54p=aTjqBv1w@mail.gmail.com>

On Mon, Sep 15, 2025 at 10:54:03AM +0300, Andrei Borzenkov wrote:
> It is not about usage=0 filter.
> 
> Let's say the filesystem is near 100% allocated (no space for new
> chunks) but has 50% free space, meaning, chunks are just 50% full on
> average. Is it still possible to start "btrfs balance" in the
> expectation that it will move data from some partially filled chunks
> into another partially filled chunks or balance will always fail under
> these conditions?

It is possible. For each block group that it operates on, balance will
attempt to allocate each extent in the block group, and those
allocations can find space in the existing block groups, assuming the
extent is not too large and the existing block groups are not too
fragmented.

However, balance will not break up the extents; if there is no space for
a given extent then the balance will fail on that extent's block group.

> 
> Oh, and is usage=0 filter still necessary today? I thought btrfs frees
> empty chunks automatically now?

btrfs does free empty chunks automatically. This may be delayed by
discard=async, but it should happen eventually without any
intervention.

