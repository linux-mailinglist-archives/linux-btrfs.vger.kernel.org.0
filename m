Return-Path: <linux-btrfs+bounces-5973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1E59170F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 21:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEFB1F2228E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3986217C7D3;
	Tue, 25 Jun 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="Xx8e10zh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jW1P2y16"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D017A906
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342729; cv=none; b=tGu+NskySb4J2LdlnTTtmYFR1nSRJrWErZL0UC/ILce8NXimeIRS8j3UxBJdsb7sgWn68Nh9R8jO96G8oMA2fnpj9gW8o3xb34LqACwM/fzx/aRxg4DIwj0WuAA9N0fWNI/H7J/wFRotYUD8TIFkXpeXBqII+LVXHvJDoYZLWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342729; c=relaxed/simple;
	bh=Ptnm3uhthiA+6BsHrBOenZMlFQ8r8/Fxov/fLFR10RI=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CbYrrnIZK+Ax2gt2A6z5OvqzZ7y6D1vULRqGrRUWm4a341s1NB4QQI4VTQRcUFk0gTLUb6f3b7OBWYSP2n1m3IMIyewj+Af+/bNe8ToTzbl8sSNWdc6JBpPw5VDnY0qDiiYqFPPN7Jm6JPkXdYD1eKwKNLGoBfhMvpvUOsN1/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com; spf=pass smtp.mailfrom=georgianit.com; dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b=Xx8e10zh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jW1P2y16; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=georgianit.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 32ABA138014E
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 15:12:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 25 Jun 2024 15:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1719342726;
	 x=1719429126; bh=JdaZ/znPEs0KCt0Wm1b0Onz0KYgD0n3ycVmbpYpQ6HM=; b=
	Xx8e10zhQg3ngsQLlvYEDhJGK1JJ3B9xeBm9tXNNvh2RoZt0RAluX9Gl45vJm+kQ
	6aXSapFAIPtnqcNaM0rBjH/3sMrKvRdE5gFjbyjLOjSHgNoTjhyqdW3wlH5fWPTi
	h5Igh/F4PNKroJuRaJAVB+dJFnZtz4+AR+J0vBJxjLyk/+UuNq9DNmKGN+39ZkWj
	CXT6gJgKFuc8VwxPp5+JKUK69UfueVN6Qc4HcRLE2PO2R5VmIsiFo5Ec7uEoFOi3
	wlrsVgQb7hm6mfs69oA8OtRkUQyzCvNNrYX12EVAMSEfM64INv/8YLLzoMXwdXAk
	VuScCEfWl+wL9z0PpHyNmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719342726; x=
	1719429126; bh=JdaZ/znPEs0KCt0Wm1b0Onz0KYgD0n3ycVmbpYpQ6HM=; b=j
	W1P2y16f7iJwva2ClicMBor72MxmPJBrUqyJi9eLEpcd2dD2Sjs6tVqLJ87DfcxV
	pmNTYDnc9KsuO+SerEqENJhJFIdjPB0Vm6JXAdc+5SgPztTL1RpEnNKsZ/ANu2WI
	RLZDZhmojruk0szE5YsbRrGs6Y/UtSS+d3FcpLKEvPw2QpdYGA0Ddd3Q3qBAOLz7
	HssKtXzbyp4FzYsk5j0WxMOie77NXkwue4FgTW7xE84EC58Qz6JWLaDg962hhKVG
	osIbPtdDQMlv+rLMTtvDZCrvJ+FGL0z1tZE8nCGHnrLqlo+nGTNuX7IUl60crtUU
	PlFSrkDHt6C3+lZYNBneQ==
X-ME-Sender: <xms:hRZ7ZpJ4kA71KIm6UGzQm8feWR8PedyYwhqyhIJttYkvEHLs8RU9ZQ>
    <xme:hRZ7ZlKeZAruOOj3YBaHMlEW-22bd2hy9lfLNij4c2Cz5ZbVrdCLkNvITeibtZE9R
    TLuimU_EMJFJSuE0w>
X-ME-Received: <xmr:hRZ7ZhttDdqZPxgriJsjmZfxoHCZ53ekHjuZ6FGrEVZak-q6ktxtT9aZyT2m1xTr1GSUqPQ4UW-uGlM6zQ6R50LPUFcLxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephfdtueehgeevheettdehjeffgf
    etffeuudethefhveffteevhfdvffduudduiedvnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:hRZ7ZqYihSuEOlkq-h8Rj6G9D9YUfPxvWclOXXvGSVDTghhwz6fLOg>
    <xmx:hRZ7ZgapHEaQdKdt0n_gdV13XuXhcewgkEw73i22Sb-3IQJSma0M1w>
    <xmx:hRZ7ZuD3fSAVDmVdgkYOsMaN4xtcG9ujqLyIV6itKyiPrUAQRB76hQ>
    <xmx:hRZ7ZuZbczeYswOpBDEQpqrGr-AlwfUkBDZe-U33SlkImyGMthZAvA>
    <xmx:hhZ7ZrycA4R4eBsPFyuGOPnLDqPdsChPRPkMohtMrAHR21RyNJkPuk8y>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 15:12:05 -0400 (EDT)
Subject: Re: workaround for buggy GNU df
To: linux-btrfs@vger.kernel.org
References: <20240621065709.GA598391@tik.uni-stuttgart.de>
 <87le2s6gbw.fsf@vps.thesusis.net>
From: Remi Gauvin <remi@georgianit.com>
Message-ID: <4da3947b-5412-ccaa-527d-d2263da7f36d@georgianit.com>
Date: Tue, 25 Jun 2024 15:12:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87le2s6gbw.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US

On 2024-06-25 2:13 p.m., Phillip Susi wrote:
>> The GNU tool df does not work correctly on btrfs, example:
>>
>> root@fex:/test/test/test# df -T phoon.png
>> Filesystem     Type 1K-blocks     Used Available Use% Mounted on
>> -              -     67107840 16458828  47946692  26% /test/test
>>
>> root@fex:/test/test/test# grep /test /proc/mounts || echo nope
>> nope
>>
>> The mountpoint is wrong, the kernel knows the truth.
> How did you get this to happen?
>

Very easy to replicate.  If you call df with a path, it prints the
location of the subvolume in the "Mounted As" column.  No other steps
necessary.


