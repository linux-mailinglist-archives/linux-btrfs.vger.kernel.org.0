Return-Path: <linux-btrfs+bounces-181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F9B7F0153
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 18:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33514280E52
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB751944C;
	Sat, 18 Nov 2023 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="X1jARLvj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tVSSptA7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858A3194
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Nov 2023 09:36:31 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 213095C016A;
	Sat, 18 Nov 2023 12:36:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 18 Nov 2023 12:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1700328989; x=1700415389; bh=gm+oFRDbhUNgKJWAhonNmnxc3/a+HcpCrai
	K+haGbU8=; b=X1jARLvj5ULda4xKGVf/r78tRR4KV4gHbQPil5BZMN6mz6uqRru
	dTFIG0iQEvnRmsv7aSxojyNiMdhthYxvZ8ZPjoVWsMUgeclpq4Q4iO+wFu2jWac7
	MmGsHUd/wVicBwjV2MhwYNGweBGA6CPvvfTtgY67N4/SAJbqKLILZiCsoIVg+5f+
	5gjvrGqOk6z5RMaYf/g5nbiDSEEv9DILbC6IqK0wtJSiogN6fzjZKwjtq4jcc01x
	QHjvahr3Yq3V4gE0hwjzdQyOKRloHcrKThdnhSoMN3DS8PtbUOJM3cXHq3Equokz
	CxTLzCd/3hp7CaO2ApYWf1Nw7HfpRUAVAeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700328989; x=
	1700415389; bh=gm+oFRDbhUNgKJWAhonNmnxc3/a+HcpCraiK+haGbU8=; b=t
	VSSptA7sERhOuLpp1i3/IKyAHAN9gzEKCjMIBJBcnxjzPCIE9ymqdR4fRrDG6g4/
	sUiGpJkEfLMy2xi3cAjPlIi1ySEtdf1/s7P80aWnyh5LvGJ/RAzD0h/PUiLOKBqL
	Qrb7SFRL5yqzIUxm4GQ+hfwhvUGGVIiQt5uYAm+TCZ5t5/xvBUU+q4JAcnMhDIgZ
	3YOM19mz3LlaXQk43DpYs1g04RA15jCuyRVdK9W4nJLR0F8konbfEgQI6OiWWUnZ
	YBQMPMzYT6kO0idQ5k2GcBh4Q74HPf9B/JNM0tvvxZV9WhLLoI6Fw5TeL7Vi7Ikg
	z+DOpABuB38XgB6Md+WIA==
X-ME-Sender: <xms:HPZYZUt13oqSso0hPcq3XRNL_UfNFFhx96vf8A8aw-JkZt3aV1aBEQ>
    <xme:HPZYZRdvM3EYmDIH-EmaY0UwD4il5aTM6-6OawaowKHuVXBDevZQX1qPmjwnEYjw2
    cYT8ywomCtk67N1aw>
X-ME-Received: <xmr:HPZYZfxOSbuCnrWYPIBqy9k5xylhU0hr1n2hwthQoXTrjirvCcftRslWL5Dp-EQrxYG--Ze_pMBzfFcKg4TvfzEANsU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegvddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuhffvfhfkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeftvghm
    ihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecuggftrf
    grthhtvghrnhepleeukedthfegieevfeekkeeggfffvdeifffftdelgfekveekveethffg
    udejhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:HPZYZXN1YDiqayfQMYhO5lDqM0SnLUeahO5to2QteMJOCqVTNIhDGQ>
    <xmx:HPZYZU8Y3-aY31Ovymv6QYI8HoFCMbgy6qNVb3hhJ3JflLQh771xEw>
    <xmx:HPZYZfXvjigS7cJje6RYPOscAPNcCtB4YkVa31DV8xeY5v1v6UT3dw>
    <xmx:HfZYZZHPOsOqAfrwnArozC67xaVa5oIIZzbO51Sq47e2gDkRs_aj3A>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Nov 2023 12:36:28 -0500 (EST)
Subject: Re: checksum errors but files are readable and no disk errors
From: Remi Gauvin <remi@georgianit.com>
To: kreijack@inwind.it, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
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
 <CA+H1V9xqZT7L0tj3JTyJscXLKw-tpSE0qNULbg4hn0wYq4fhxw@mail.gmail.com>
 <CA+H1V9xA8_3-BYkhR2ip0v1_-bKxWY1hHW1kRwoxhaCNu88PYQ@mail.gmail.com>
 <95096727-a472-4c0b-a16d-de53b0f66ff6@libero.it>
 <60fb34fb-ebfe-408b-b787-c62c6a1b5cd9@app.fastmail.com>
Message-ID: <b77ace10-e8de-6fdf-712e-91cecfeadc08@georgianit.com>
Date: Sat, 18 Nov 2023 12:36:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <60fb34fb-ebfe-408b-b787-c62c6a1b5cd9@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US

On 2023-11-18 11:33 a.m., remi@georgianit.com wrote:
>
> But this thread wasn't about performance.  It was about BTRFS CSUM being in such bad state, turning it off (at least for some files) is the only suggestion for preventing spurious errors.
>
I'm sorry.. I was extrapolating a bit too much.  The error in question
was a known side effect and not really a problem.  I still suggest that
disabling COW on BTRFS raid for important files is a bad idea.


