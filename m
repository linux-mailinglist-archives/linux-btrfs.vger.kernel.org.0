Return-Path: <linux-btrfs+bounces-173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05EE7EFB8B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 23:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCF21C20AF4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 22:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B116E46535;
	Fri, 17 Nov 2023 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="HtGDp2si";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wNJJvE71"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8092FD4D
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 14:43:52 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 218675C01B1
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 17:43:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 17 Nov 2023 17:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1700261030; x=1700347430; bh=vph3+VEBQuD8BntEMwGK8EvDXD2r2yCr9wq
	znBQY0RA=; b=HtGDp2siUJ3obwGYGPzPh57Q/upA2Ks4+N2BbVa3EHbZysdaGF/
	TYWJ/e9faYfQz1DsTdtBILMk0VsLQlOK7ZL2gWYo07MG0cDEj287V/Cb6NroyUk5
	AKICbq2iFx+lXNMMUizaYhitpSzU8xpo3D3A+N44RqRnqziI/4HiwoF+fXJYf/Tk
	AFRBwZu3RRGpU6KiGIvSx6/79iGpWIZetEn8RJlRFm15u5Tm1E9Md8ytOr/ymX3V
	8AChciqmQmJ4H56tRfFw2VBspJ7CmLyVfY85O2Ya8WulnGdf5v8NrR5CZMzejDfU
	qUmXUs4mDViSofrLI6iwCpZ+aNKUfc8/kpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700261030; x=
	1700347430; bh=vph3+VEBQuD8BntEMwGK8EvDXD2r2yCr9wqznBQY0RA=; b=w
	NJJvE71nSeK/uYpaJf6ym8nXuef46UdQwRfVrXUMYY4glbtK2nDZk5A++EBd3xdz
	RV7pkCK1IhMNcrj3yKz4C+WItg1ZrPXK+NCYcZELcvGVi24+pWz7sqwwjqPQd2KQ
	MEvOFz59rzUSPgPX9tsfkzxH1NmIgOV0BpJoHCAbSglQsFyJJDzdIkvBRphJZ4Vs
	e7NWGQLmNrzgXDIR31ybi+WgtinoT/0GLLSRSi7Bw220O98+rqE3uJkZoqKCtLN9
	cJ939EEAm6+5dFyRWLm8vnX0USU0h0dZafT67CQpPUHOni0YjDfMtc+5JcUjjVkB
	517W39gADASnUmevdX5cw==
X-ME-Sender: <xms:pexXZbVR36dOWiaXgeZJZwo1jpkHWXDvpylarWPtLGzLW0nWDvw-9w>
    <xme:pexXZTmEUK5E7FcAvMN_nS-8-_xO1VRVUrdqB9qZQaZUujXg40F2S4sTnWjoJCZBB
    woT0UW7GHfrM3saGA>
X-ME-Received: <xmr:pexXZXba_9ifbRMb6DnfthFiv9GvnDBGxBUdsopgtt3PMDoUKXJpzDkNOFR9WQKaQOxgGuN-ytgNg3aBekGDTKTUXks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegtddgudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesth
    ekredttdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhr
    ghhirghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpefhtdeuheegveehtedtheejff
    fgteffueduteehhfevffetvefhvdffudduudeivdenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtoh
    hm
X-ME-Proxy: <xmx:pexXZWV04UCJbeo13AgE8DSf9HbO6FwEwacdxzKXD1SpAWpPNGJVkQ>
    <xmx:pexXZVkR8U3J9Spm6XoZ6UDm5HXYihZ0wTGf7juWmRDXMR_pXQicAw>
    <xmx:pexXZTf1LHIaW_O3DO1y_4AmMrxQnaGSff1SzmR60o4VU2_SHpcWrg>
    <xmx:puxXZTSlgW2PuCHvXBXtlXUMZrX7QfMXeYmh0tmuHzW_LkmrpRHN9A>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 17:43:49 -0500 (EST)
Subject: Re: checksum errors but files are readable and no disk errors
To: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
 <59b6ad3e-c16e-4a29-abd4-4d6f57047155@libero.it>
 <65b3acc5-0aff-a7e8-142b-4ad40c60f3dd@georgianit.com>
 <4bf1d0d4-6fc3-434f-8166-7a628d48d52f@libero.it>
 <9f955c4a-82be-98cc-6f61-ee5469c32ba2@georgianit.com>
 <cecd43db-da2c-4558-b343-4faabacdf0d8@inwind.it>
From: Remi Gauvin <remi@georgianit.com>
Message-ID: <5e4b13ab-2b8b-7115-be9c-c7f332982407@georgianit.com>
Date: Fri, 17 Nov 2023 17:43:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cecd43db-da2c-4558-b343-4faabacdf0d8@inwind.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US

On 2023-11-17 5:00 p.m., Goffredo Baroncelli wrote:
> I think that we should put everything in the right order:
>
> - COW:
>     preserve data and metadata even after an unclean shutdown
>
> - BTRFS with NOCOW:
>     preserve metadata even after an unclean shutdown
>     data may be wrong
>     depending by which disk is read, the data may be different 

 

But what happens, for example, in the case of a virtual machine image,
an automatic filesystem repair on the guest reads data that looks good,
but a later read runs into corrupt or incomplete data?

I admit that I do not understand the intricacies of how this plays out
in the read world.  Maybe the reason no one seems to care about this
issue is that it is unlikely to ever actually be an issue in reality...
(although, in the artificial tests I have done by disconnecting drives,
it is a *big* issue).  It just seems really bizarre to me to that you
can have a raid implementation that doesn't keep mirrors synchronized,
and has no mechanism to synchronize them, (other than user manually
starting a full balance operation.)



