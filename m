Return-Path: <linux-btrfs+bounces-1117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E2781C278
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 01:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42185286708
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 00:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50C15AA;
	Fri, 22 Dec 2023 00:57:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from hedgehog.birch.relay.mailchannels.net (hedgehog.birch.relay.mailchannels.net [23.83.209.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF61361
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Dec 2023 00:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5856C9428DB;
	Fri, 22 Dec 2023 00:57:07 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0C14294236E;
	Fri, 22 Dec 2023 00:57:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1703206626; a=rsa-sha256;
	cv=none;
	b=VJpxJVoAN8TZ+Pbn80SPq4CWKTZH+1fdWjWbHTS/SLaONqA1Kjctzw6AA9DcX+pVLoMbz3
	nwFdo93c1wGhY2ee+WY3VHlHb1VQXFhukKHF59wOPKY6vJgl9Q/2zbS1iKtrQvNmiCsMRI
	Vho/3m+KvpTmg4dRsqDG6HXG12geLjhhIufw43hV1BTpoQHC1lhlXTdVnECQ5dRxPhnxNo
	dDgDRtY5+P65oB5Iy+hqHx9SCPFGkcvKobYS0meog9wk9sRVfrYodXl8PYFZw77cn38gYn
	dnRWByfQqY208eIVHKZVmkNeZzObxrBziGG2yWm86GtOS8Npui+c56grDRokKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1703206626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibJoL2tn2GX9IcFKs0C1F4O1Uwr8wYU47R+0vDItJr8=;
	b=eYFSYS3sMn/ifLLVqc1oAOWGFl0NZqh+AF368jcpbcVwqDcTUeUsqmvzqasFAhlyFYOfRz
	/8WMscabWKvnvv6qnNphZH/0iIg3jhgO4P3n77ocKoKNhRu0yomVFUErN1aaPR8wucZIox
	rE8tPNiQdJXZBxcpOcVrU5mB9nhHJyZWMahhvkPQS5a2883q3K81opf0EEC7FLvpVwEeXc
	Jz51+cO2Dz/uBSZlMOHn2sjTqizjMtqoO88EY6YC6O0+eULeD31zzSOs5MA7ge9DdXv+Zz
	EKmOtnRzvkEvO87aEfKZ3IlcNU+BEgt6unqkiq/+ZvvsYsEGroL+9xggcZZWWg==
ARC-Authentication-Results: i=1;
	rspamd-659dcc87c8-bpmfx;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Dime-Squirrel: 5930acdc1970caf7_1703206627108_2173055487
X-MC-Loop-Signature: 1703206627108:48005016
X-MC-Ingress-Time: 1703206627108
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.113.243.205 (trex/6.9.2);
	Fri, 22 Dec 2023 00:57:07 +0000
Received: from p5b0ed5dc.dip0.t-ipconnect.de ([91.14.213.220]:41740 helo=[192.168.0.100])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rGTqZ-0004iC-0p;
	Fri, 22 Dec 2023 00:57:04 +0000
Message-ID: <bf5726d2a30996d06204b17d05daec9c77b7d769.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>, Andrei
	Borzenkov <arvidjaar@gmail.com>
Cc: kreijack@inwind.it, linux-btrfs@vger.kernel.org
Date: Fri, 22 Dec 2023 01:56:58 +0100
In-Reply-To: <aa69e84f-d466-457d-9b29-47043c2aef53@suse.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
	 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
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

On Fri, 2023-12-22 at 11:23 +1030, Qu Wenruo wrote:
> But the problem comes on why defrag doesn't work.
> I'll look into this during the holiday season, but I strongly believe
> it's the PREALLOC inode flag.
> We should take it seriously now.

Oh and keep in mind that - as I've hopefully had mentioned in the
beginning - this is all on 6.1.55 (Debian stable)-

Thanks,
Chris.

