Return-Path: <linux-btrfs+bounces-12221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F26A5D6A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 07:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C2C3A178C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 06:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0302A1E7C28;
	Wed, 12 Mar 2025 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLNmR1S3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421AA1CA9C;
	Wed, 12 Mar 2025 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762533; cv=none; b=jJeQAfUPolI0HnLhfH92+kj39uI3bkMRrxUaLdWwxmPTskYvv4DUXzeh/9UW74uE4rOM+SrBLsCFfEmzXL5qTxa/d6qJfAxOtU+pegNMJPV5A7yYp3DNry0gyD5bXQSHZ5kP8Sx9MWexNnvXPezJHnewGIRXWNodvjAz+1bC8oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762533; c=relaxed/simple;
	bh=KOGDNs/PVyHGWJZgE2a5B/atUWquZRHoJf8vfvekNqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTiERh7kQJbf0vLd1dgbsaM8+dqgQFGzrbepyVQHw0ZyClMMW3BVDeVPfSZbAw/IxTnLq0As+aB91Wap5OJem7clNEYk1Ra7B8w1i3lAyOuR+iGT4UuopRZ4mq6KuKcL+e7fOGMePEHTJMhDLUI2dYAKtU89pwVu+maBUUgDhqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLNmR1S3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E44C4CEEB;
	Wed, 12 Mar 2025 06:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741762532;
	bh=KOGDNs/PVyHGWJZgE2a5B/atUWquZRHoJf8vfvekNqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GLNmR1S3XmZsAoYaahDVsASWtVJ+BkSEktiikymh6SD2jZYVDyzOmRJ6yex1qYZNv
	 Iz7KVSdMKW+VQBunuIamd2kxBYj74urBp+Vck74UZMyabUmq+dRV2HnnZLTvppZyxV
	 CjdqM6rf8jO7ksJ3ja+HZgTWoXcrt0CK9ySLU4rTlvUiaZCVGHFOA5kitjgaRRpWRQ
	 5G2LBPIXqbFwo0r7HumgLHioV2udLC0DyJ0tNfyklwiIQSRnnZAkMWtUf246smohbd
	 J7JohNNpjzalZMPcNIGpeg/i+6/da6fKepgnk+aBmw488P5MXLXKOBgFZT/arAUIJY
	 kCYJ0RG9zlIaA==
Message-ID: <dfa516c7-2a4f-45c5-a184-0b0e64336c38@kernel.org>
Date: Wed, 12 Mar 2025 15:55:31 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: introduce zone capacity helper
To: Christoph Hellwig <hch@infradead.org>, Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org
References: <cover.1741596325.git.naohiro.aota@wdc.com>
 <335b0d7cd8c0e7492332273a330807a8130e213e.1741596325.git.naohiro.aota@wdc.com>
 <Z9EbSZh-OtLGttoB@infradead.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Z9EbSZh-OtLGttoB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 14:27, Christoph Hellwig wrote:
> On Wed, Mar 12, 2025 at 10:31:03AM +0900, Naohiro Aota wrote:
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +static inline unsigned int disk_zone_capacity(struct gendisk *disk, sector_t pos)
> 
> Overly long line.
> 
>> +{
>> +	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
>> +
>> +	if (pos + zone_sectors >= get_capacity(disk))
>> +		return disk->last_zone_capacity;
>> +	return disk->zone_capacity;
> 
> But I also don't understand how pos plays in here.  Maybe add a
> kerneldoc comment describing what the function is supposed to do?

The last zone can be smaller than all other zones, hence we have
disk->zone_capacity and disk->last_zone_capacity. Pos is a sector used to
indicate the zone for which you want the capacity.

But yes, agreed, a kernel doc would be nice to clarify that.


-- 
Damien Le Moal
Western Digital Research

