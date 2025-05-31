Return-Path: <linux-btrfs+bounces-14345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFCFAC99F7
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 May 2025 10:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68235189F229
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 May 2025 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145AF2367AE;
	Sat, 31 May 2025 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="bPjHMrAF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out1.mxs.au (h1.out1.mxs.au [110.232.143.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9554A1D
	for <linux-btrfs@vger.kernel.org>; Sat, 31 May 2025 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748678988; cv=none; b=F+U+vYX0mJeYS+Pr/SCiQZMQxsWQn0zvWJaQVFT7sivpMlO/ccqFJvz/NQgkfmMoqoMTXkqtF13XPAD2iEoFgNkVyz3BGT+cT6ev69T93+wr66prh6peMh5sszMC10LCn7OK6QUQF4Un4PUoJtZL+b1EXGF86rroKwB8svie/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748678988; c=relaxed/simple;
	bh=IsLBOljMED5NvILYaHzUSQDAtZLgbUx3EDUEMexpaTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tz4v7IMWewLz065d7+zNudMpdHHo3EKP1nYjemrGgV6gm+9IfiVPnqBLeXrBc1r2KgAtgxU7Uely4thldLA4hetsyZWRiLOO4WezSW2DkV0rpJbcMVeHKZlks6Cayeb8Y3y8lDQkJtLwOXcPwhc4COzTerhNqD4aavCpz8GtkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=bPjHMrAF; arc=none smtp.client-ip=110.232.143.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out1.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id 80eec104-3df6-11f0-ad0b-00163c39b365
	for <linux-btrfs@vger.kernel.org>;
	Sat, 31 May 2025 18:08:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1WD+qiKQ5IPxqTcQMR0JN3FqDzTd6Uej6uMtBd/xCMk=; b=bPjHMrAFuJHRd0KeBwVpnJSvLL
	OXRUq4s+3ZrBeDFoRwg6gL11ywiIKiMX4W94psofYQdrFKfK8eZdE04DuLvfSBhFT3F7JrwZz7Atr
	lit2m8OWPHg9DskXr1Kzbr1HVPTiHLMUK7/u7m9H3L36MG9Hdi3sjXdEPjehGPCMSwgKe+XwbUs11
	4fvPu5v/baKrsOztI9wUFS/AXgrY1AYbFHFBaGBcJ/U2drxQhdhjXKQW7p+Dq0qiAgAZRpFDKX1Na
	3h3d0srMvEDkg+zJ+cHB2o/JgxXvNZLAIf18u/d3j53QAC1wyNgWv4z8RR+A7DZUXBOvToyoCCEkU
	QD6cwaBA==;
Received: from [159.196.20.165] (port=60416 helo=[192.168.2.2])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <btrfs@edcint.co.nz>)
	id 1uLHHZ-00000002Fu0-1qqV;
	Sat, 31 May 2025 18:09:33 +1000
Message-ID: <5de3840d-70c5-48cb-a7c0-7db17e789e95@edcint.co.nz>
Date: Sat, 31 May 2025 18:09:31 +1000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Portable HDD Keeps Going Read Only
To: Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <83a43be7-7058-4099-80d9-07749cf77a8d@edcint.co.nz>
 <CAPjX3FcqJ-cNMjVia_gYmBZwDhQVxPEOhYYQUzL31m7momByEQ@mail.gmail.com>
Content-Language: en-US
From: Matthew Jurgens <btrfs@edcint.co.nz>
In-Reply-To: <CAPjX3FcqJ-cNMjVia_gYmBZwDhQVxPEOhYYQUzL31m7momByEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: default@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: default@edcint.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 29/05/2025 9:08 pm, Daniel Vacek wrote:
> On Thu, 29 May 2025 at 04:08, Matthew Jurgens <btrfs@edcint.co.nz> wrote:
>> I have a portable HDD that I just use for backups (so I can lose the
>> data on this drive if I need to).
>>
>> It keeps going read only. Sometimes at mount time and other times after
>> a small amount of usage.
>>
>> The dmesg and btrfs check output is large so I have made them available
>> at this link https://www.edcint.co.nz/tmp/btrfs_portable_hdd/ (I tried
>> to attach them to the email but it seems it never got delivered to the
>> mailing list).
> It did hit the ML. You may have missed Qu's answer:
>
> https://lore.kernel.org/linux-btrfs/3d1c4611-d385-4d31-96de-3a617e02c94c@gmx.com/T/#t

I ran a mem test and 4 rounds all passed. I have had some intermittent 
RAM issues in the past (with other RAM though), so I'll keep running it 
a bit.

I can happily rebuild this drive but just wondering if there is anything 
else that's needed from it before I do so?


