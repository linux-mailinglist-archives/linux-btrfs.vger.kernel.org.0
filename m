Return-Path: <linux-btrfs+bounces-3648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FB288D53E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 04:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2468F1C241B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 03:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DE322F02;
	Wed, 27 Mar 2024 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janeirl.dev header.i=@janeirl.dev header.b="GHFhllo2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IZjhtTc1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBE1BF31
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511562; cv=none; b=M4ynk9yexuiV/TlfZ7dIxSrprU+BTC1GvZZIgxE7X3cYDPEtj+inSaQSv5zvjTf/nxWy5gPZd5hyXoOAJYjPyDE21mEsCZxLpv0+ptFxKKg/YAC55lkck4tuNqcRSxqhg6/8khA2QA2k0wyeGg95Ja4t5c2DJ6MCep795H0ku5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511562; c=relaxed/simple;
	bh=Xh+CVKq4Z5QNNTchqbDV7IGXxWkvhB0rFNLVGPCSaoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bIF7T2t2yW8jLfdW+ZNatOnzL47+s+7IVIq4HEodu3zQmFFZqrWAZSfVCAUOzLQVk8TKbALr10GpiKnF9wIvAr0LDvrJvR6iEEoN8C3cqPFgs+VaF37Vr7bwStTY93/GhcCIE2ZTf1Kge328+wG/sYACBhT0InESwnRfEMjutOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=janeirl.dev; spf=pass smtp.mailfrom=janeirl.dev; dkim=pass (2048-bit key) header.d=janeirl.dev header.i=@janeirl.dev header.b=GHFhllo2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IZjhtTc1; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=janeirl.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janeirl.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id CB4DE5C0056;
	Tue, 26 Mar 2024 23:52:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 23:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janeirl.dev; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711511558;
	 x=1711597958; bh=VPC+SctGDynO7rfRnaRzPprg0ouxvkuGyv8epKLaDD0=; b=
	GHFhllo2EhRPDvejItOPfQf+QXDaLzZPMQr0aFqQRo9wV4DmlWHwF1HfZTleHsD7
	HtwnEEMeXzAT/Rtp3bHJXh8+gtn7HBQet1W6RS6uGYZ5lycrqwED7DyXq54CRTvE
	Ok/w/28CPiSYxOLUQdzzm0mBnKR+HSexbGskTzaVnTlLe7TzF7N9S+5TfyeV1nC2
	nQlmb2TgSXJd74CNn4ORlNtv+aUzeobfDqiA6io0duTqAR6WUzUrznIpOFuNvdyT
	8dBxw1uVncTpRF0VBkdAzi0iyE/lNwh0xifea9+1BqCOJvKclTHHhUWNS662qPwH
	7aaMUAFjG+xGxJRVL+26tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711511558; x=
	1711597958; bh=VPC+SctGDynO7rfRnaRzPprg0ouxvkuGyv8epKLaDD0=; b=I
	ZjhtTc1VYvPKglRZ1N/8OkksHbAOf6ifPTULTJljs4NIrDi4JKhueB+zgqd70Z2K
	kakiGwO8H8XuLzy0K4lPQuBsQJQCdRJaD9YJe4Fx/+99uu0dHlEtI0xdlUFC+9oG
	qISNcjiy1z/KMaTYXK+kzas/vm8zDVd9NxRlmWdBpKZ2fM8AzA7oM5Zg/kOlqTF4
	HF7cOE3ZTFPWUe/rsIyXtV4ellhMD+YvkGxc4EKX2XmoVO3mlryuhVoQo2uNBCBW
	MgyFYtUk618uetyQ8V9WuM8dQwhAu/LNSG+3WArnr9bdG1bH5GvGwzq4RhjVBvTK
	0kcrh992UPIEITDwcYYeQ==
X-ME-Sender: <xms:BpgDZpmZ905xT5TQdeKPrPDKYLvS7357IKgsGt-sdBdXXH6TQIYoPw>
    <xme:BpgDZk34baIrk6EcRVyiVp-5Ar5yeUYBi_H9BZQWwkNXLFlfhuSGzzmpXHGrnU_b3
    -AmK8QjDtqZ6emjGoM>
X-ME-Received: <xmr:BpgDZvo-RJr7IlIgPDuXaitXRSdT4PP9EdTD9DEE3rKW8uJ5wL4Y4pArn0Ot6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomhepjhgrnhgv
    uceojhgrnhgvsehjrghnvghirhhlrdguvghvqeenucggtffrrghtthgvrhhnpeffkefhff
    ehhffgvddtfeeujeetieelueffjefhtdefgfejueehtdegheejveekgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrghnvgesjhgrnhgvih
    hrlhdruggvvh
X-ME-Proxy: <xmx:BpgDZpnY_h5MMZw1e-UtgFPJfPpZ3ZNz808I3fZ7XDhrN51eIrvTPQ>
    <xmx:BpgDZn1za8ATzmh-YTToyu_sjx9TRI-oJzCmsCQj9XgSUtN5EsW96A>
    <xmx:BpgDZosWpdWhc9nKFfUfY6f-ZtJRSEH-iLAKUmCL1O3yL4gRysia9w>
    <xmx:BpgDZrUMTQ5a7zbGdfbp5N_KbTDZvFR3xXCmtGwNC9pS1AFSIZ1RFg>
    <xmx:BpgDZg_-1LelDIBINJVN_wr7O9y7KPNHLLd2u4OJiajtFXBg46Q-8A>
Feedback-ID: i1dd94664:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 23:52:38 -0400 (EDT)
Message-ID: <bec7763e-3906-41b7-a4b4-5edfde94613d@janeirl.dev>
Date: Tue, 26 Mar 2024 22:52:37 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs forced readonly
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <bdcc14cf-7e12-4ae7-92c6-a4924158ea64@janeirl.dev>
 <43137d1c-86d1-44b7-affb-d1080cc1ff56@suse.com>
Content-Language: en-US
From: jane <jane@janeirl.dev>
Autocrypt: addr=jane@janeirl.dev; keydata=
 xjMEZeKRahYJKwYBBAHaRw8BAQdAYS3oxazk/RB/rP81eq6GHz5mn1QS2BfExAyUzlkwLfbN
 F2phbmUgPGphbmVAamFuZWlybC5kZXY+wpMEExYKADsWIQSdlFPoH1SmI13YJgssV4x7AIWS
 7QUCZeKRagIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCRAsV4x7AIWS7fhfAPkB
 BKCxXe+a//ZCvLpVpm71p3Ls8C9w4JpzVhv+VLPptAD/bFMPDwy/gsGutKZpqEbuXrChZdC8
 h486RLqVM/mu2g/OOARl4pFqEgorBgEEAZdVAQUBAQdAh80bOWoxVHzTn+qvTrp7w5AkBhlR
 E4GdqwxEuxUgb1IDAQgHwngEGBYKACAWIQSdlFPoH1SmI13YJgssV4x7AIWS7QUCZeKRagIb
 DAAKCRAsV4x7AIWS7dH/AQCBdLPYxyaLodqqPqFQfSBVkgtSTkeD/06aV9MDUE7DvgEAoruN
 Te2J0Tkw6rblOGsE3/bADQhA69u6wCcZ51oyRgo=
In-Reply-To: <43137d1c-86d1-44b7-affb-d1080cc1ff56@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/24 23:19, Qu Wenruo wrote:
> Please run memtest to make sure your hardware memory is correct, and
> replace the DIMM if possible.
> 
> After all of this, "btrfs check --repair" should be able to repair it.

thank you so much for your help!

jane

