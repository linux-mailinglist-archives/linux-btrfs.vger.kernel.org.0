Return-Path: <linux-btrfs+bounces-12215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622EEA5D421
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 02:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EF0189A54E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 01:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707D314AD2D;
	Wed, 12 Mar 2025 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7kejlOI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8DEA31;
	Wed, 12 Mar 2025 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741743755; cv=none; b=MDHFiGaEF3kMYERX8hYAObAGxhFjAK496gooXsiKuZ+HLupntZxLAdfQoFAT17mAAol417qPTQtLqHrZen/825JhXlAiHa5vPb+QYijg6vwDDIKcs9ZidOGrpowKRjS2Gz330lFP0beb7KAehldQGR3gpctTOZLaBeOIxO+G2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741743755; c=relaxed/simple;
	bh=3I2NSd10nb8UgajO5wul55ZpQTxv4QnEQa+84unQAt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBe5Io6Ts4IlETmoz+QXXpr3wmytxam3yrlS58b3SMHwXjwkJo5JqIoJXCkzIaMZV50BXtrxue77IqInPJFpQw9HB71lt5jKWAiUdh5buWuDYiWIrjh5aFAd8dRmDuOMFY32d0HjwNAaYFspnCe/EaN3ihMBD+jL0FGjgSZ0eTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7kejlOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77006C4CEEE;
	Wed, 12 Mar 2025 01:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741743755;
	bh=3I2NSd10nb8UgajO5wul55ZpQTxv4QnEQa+84unQAt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N7kejlOIbPa6wMpP7C+uSwMw2gOzN5mMDpovvum/gqS0ZQ13aPXH24RXrOlUa6FR2
	 dkdZ+M3GC1dvQEQY2GoedZeDYfm3+w/2L/jCeKX8JgpOvS5GLfgXyxN7ILvrISWsgz
	 76pS0fg+6ZmHSX28lWAZ1LbRLkWRJEiJzhHtVNCW4SR/8YUSwEosbKHEXi9PFgUxSS
	 na4afJSfINTQpg+UeRVcHPlbIDKj4R2bxLrA9jwzqR2ipu008GJdv0biPzB9ObY3DK
	 HgjAxUzwBpgOBXmCPWpKP49dxwDAZknyUcood2jmGvxbqeF56oQqNhG+2x0NXvTK2Q
	 5BmHGoqga8cPQ==
Message-ID: <ba23e5fc-bf55-4e2c-a839-56d2d87a2529@kernel.org>
Date: Wed, 12 Mar 2025 10:42:33 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: zoned: skip reporting zone for new block group
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <cover.1741596325.git.naohiro.aota@wdc.com>
 <ec6b55668686f77593f12c579832886294fc7310.1741596325.git.naohiro.aota@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ec6b55668686f77593f12c579832886294fc7310.1741596325.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 10:31, Naohiro Aota wrote:
> There is a potential deadlock if we do report zones in an IO context. When one
> process do a report zones and another process freezes the block device, the
> report zones side cannot allocate a tag because the freeze is already started.
> This can thus result in new block group creation to hang forever, blocking the
> write path.

+Shin'ichiro

blktest has a failing test case due to a lockdep splat triggered by this. Would
be good to add that information (with the splat) here.

> 
> Thankfully, a new block group should be created on empty zones. So, reporting
> the zones is not necessary and we can set the write pointer = 0 and load the
> zone capacity from the block layer using bdev_zone_capacity() helper.
> 
> CC: stable@vger.kernel.org # 6.13+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

With that fixed, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

