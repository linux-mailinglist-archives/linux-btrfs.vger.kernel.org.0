Return-Path: <linux-btrfs+bounces-3587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D90E088B948
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 05:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F54B234DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 04:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B344129E77;
	Tue, 26 Mar 2024 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janeirl.dev header.i=@janeirl.dev header.b="RqaH44X0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hSAfEP1e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C96129A99
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 04:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426174; cv=none; b=ieB5U/WKF9KVLTEwR251J4Q4ahZPBZGaz4bM/+cjvTZB4KComr6svFDXfbIB5Y8yaODvjAOLN4jx0naHfHbZu5CVB8AXCD2AbRnzoijacp1gbaN7eMNn0Tvn7NPNmSHWcY4PAtvQD26QXHH7vTNsubx6sBYuCkRAu98MYUo8aCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426174; c=relaxed/simple;
	bh=L9qySehZN+MMWWJsIFTamd8pC7ol7MOFzHtgr2Ir9ac=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=WlSG9rxqVLAQXs6mKRjphqHN9xc7ofZjvVVLscPOykx30aOmMV0fK1Jsqh8738nof8asIcDs11Ig/LxQ2PQGEsRrOKpFQi/C3Li34zHBZzO9EiXy+LZ0ktfzO7M8aZ4uKdpLah5HT6JDU70KPTgMFvPwSeN/VsC0jNRVKBy1wWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=janeirl.dev; spf=pass smtp.mailfrom=janeirl.dev; dkim=pass (2048-bit key) header.d=janeirl.dev header.i=@janeirl.dev header.b=RqaH44X0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hSAfEP1e; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=janeirl.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janeirl.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 51E6E3200A3C
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:09:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Mar 2024 00:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janeirl.dev; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711426170;
	 x=1711512570; bh=AUGmur8YRty+gODAt7DKBOsWO5FR7XvAzHqapjDIHic=; b=
	RqaH44X0wXCGTWDRYgjtxBgTNEF1grjRKYxrF28oIngdRrchw5TAgTxb/NTzMgyC
	jc8LpeBgTX5WiGCYVUasNFN9U8mJBqQfcbju99gB355e4MYrTR1/6NAbfSFW96PJ
	UZEUJzJvaKixAQ/Fi/Wh65m8KbstOVrMSCYqsY0QyYVwgySZSxZimjDoutXmYFLV
	Ooh2PF0vyuqFWX1qVq/5IRHT2v1WpcQZBRnqLtS0PribzJsN7wwlBPllqkxnsHY1
	unnZV6XrWBpeiKPcybzGh5R3MOOQtsZBM9ZW3sQgQtqVzkBhxS1vAhKFwRv7M5Be
	AB5qSOwkGYicDDhdogrHTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711426170; x=
	1711512570; bh=AUGmur8YRty+gODAt7DKBOsWO5FR7XvAzHqapjDIHic=; b=h
	SAfEP1eGU8L/c7s8nl6Tl2xu1IJZBlGkVQ1DhWuYc9hzus9ShJj1mjocnVAbFeAb
	udsSEXaY169xelk573IMbDtsUVhtekGFlxXxx2kKdrcCO5bToJ56nHGTxaaRetVr
	3eNI8WTqb5W/rYG17eIAaS5yjY0L5o6Ygc1hp94U/IhqUBr4Q5C8csA+bYfYo05+
	LimVqcDBgwo8E1CQuq9QrejQsRSWLRy+kB28sM1Key5ZT9rNOkVGpO5VBFGrkw2G
	yRCdenw5qHDfzylMZ/8UVqizAIVh2Vqwk+kDhAxtO6cYWpYBYR0L1oN524ZBVLB4
	l4deGHNZ8jGrR3tbtpdOw==
X-ME-Sender: <xms:ekoCZr7NedKeDuXV87Ppuussm6yShQwxmbgXpUl94d8-QFVzlzB0yw>
    <xme:ekoCZg5q08P1EF6B1oUkFCcRfFx8d1GuIeP6hwhiVZp3iyTTlFTmWSZNl2WmFVFhC
    8DD79o8L0eI86Mn1kI>
X-ME-Received: <xmr:ekoCZicUlTJioQkHT8OyTIIK_t23BnVkOaNTSlT1OgsmNIdbHbNRyWmaBtHL9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduvddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuhffvfhgjtgfgsehtje
    ertddtvdejnecuhfhrohhmpehjrghnvgcuoehjrghnvgesjhgrnhgvihhrlhdruggvvheq
    necuggftrfgrthhtvghrnhepteetheelueelueffueffteeugedvveekieefffeukefgje
    ekkeetteffvddutdeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepjhgrnhgvsehjrghnvghirhhlrdguvghv
X-ME-Proxy: <xmx:ekoCZsIKbCQHPMeV7LlYjOvAYRba5fCj3UGmjE-1fjej75CFDj_bvA>
    <xmx:ekoCZvKkxvYDTUspjoGo-IHExWpq8F-xiCSy23JMsTcZysKMjhWXHw>
    <xmx:ekoCZlxDxPaWUN3TW5YzFFOWHTxAGkos5D01OLFgBGu-skkJgrzhJQ>
    <xmx:ekoCZrLngrkeJY_Yqr0GOGMhETIzRMMxlUhgRvkCBkqwLA66JBALbw>
    <xmx:ekoCZhzvq2cnvk8puSDjNV2nl7F3xIxlpx76UCtvkIqXahnJzexblw>
Feedback-ID: i1dd94664:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:09:30 -0400 (EDT)
Message-ID: <43720730-b1fd-4779-8514-20eda1dff0a3@janeirl.dev>
Date: Mon, 25 Mar 2024 23:09:30 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs forced readonly
Content-Language: en-US
From: jane <jane@janeirl.dev>
To: linux-btrfs@vger.kernel.org
References: <bdcc14cf-7e12-4ae7-92c6-a4924158ea64@janeirl.dev>
Autocrypt: addr=jane@janeirl.dev; keydata=
 xjMEZeKRahYJKwYBBAHaRw8BAQdAYS3oxazk/RB/rP81eq6GHz5mn1QS2BfExAyUzlkwLfbN
 F2phbmUgPGphbmVAamFuZWlybC5kZXY+wpMEExYKADsWIQSdlFPoH1SmI13YJgssV4x7AIWS
 7QUCZeKRagIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCRAsV4x7AIWS7fhfAPkB
 BKCxXe+a//ZCvLpVpm71p3Ls8C9w4JpzVhv+VLPptAD/bFMPDwy/gsGutKZpqEbuXrChZdC8
 h486RLqVM/mu2g/OOARl4pFqEgorBgEEAZdVAQUBAQdAh80bOWoxVHzTn+qvTrp7w5AkBhlR
 E4GdqwxEuxUgb1IDAQgHwngEGBYKACAWIQSdlFPoH1SmI13YJgssV4x7AIWS7QUCZeKRagIb
 DAAKCRAsV4x7AIWS7dH/AQCBdLPYxyaLodqqPqFQfSBVkgtSTkeD/06aV9MDUE7DvgEAoruN
 Te2J0Tkw6rblOGsE3/bADQhA69u6wCcZ51oyRgo=
In-Reply-To: <bdcc14cf-7e12-4ae7-92c6-a4924158ea64@janeirl.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/24 23:00, jane wrote:
> btrfs-scrub output:
> UUID:             8b26e8c1-2566-4991-a0c4-e64da9a46607
> Scrub started:    Mon Mar 25 22:59:39 2024
> Status:           running

apologies i pasted the unfinished output. the finished one's here:
UUID:             8b26e8c1-2566-4991-a0c4-e64da9a46607
Scrub started:    Mon Mar 25 23:03:21 2024
Status:           finished
Duration:         0:05:27
Total to scrub:   115.05GiB
Rate:             360.29MiB/s
Error summary:    no errors found

