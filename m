Return-Path: <linux-btrfs+bounces-18606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2BBC2EBA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 02:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B433C4E44FF
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 01:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3574921D3E6;
	Tue,  4 Nov 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKyaruMa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613DC48CFC;
	Tue,  4 Nov 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219208; cv=none; b=GDOVYQxPAuUnGEgOcxVdAMGuT4qsWzsdnD+94grM714ymxdzqxttKHOswC2xkIJX6QQ8YOfEuGesZn4x+SHNSjzZfLzLJXSMqMXh+0EOn1EIX3IOWZz3ng5JYz0OKVwHe3EMVPY637UBukdeBKvsoIvFlGvyrLAIfzQry6Ta+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219208; c=relaxed/simple;
	bh=B9r9ZwP9Zh5rBTzvhh3Jm+fmjQMtHYtUw8GVnM21l5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t45xXowiwPDogZf25eG/pbC9iHMqqs8eYXikj+zLy5Kv8oeQgLQ/Kt2KOVH2VuOoUnl3PZZ0vRLFMZpa0y5DC/LAble03lDPmXcB4f2yNFyOMW1cU9SieUUysZsOsLkGCHtALAuM5UFVVSNcokjlLB8szPL+tbznivQALEZ0kYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKyaruMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD839C4CEE7;
	Tue,  4 Nov 2025 01:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762219207;
	bh=B9r9ZwP9Zh5rBTzvhh3Jm+fmjQMtHYtUw8GVnM21l5A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DKyaruManSVZUbUf1gEWKFtbuu2E7kerKWb9JMaAkt4sznVdpIut1bvM4I2R67YHB
	 7nw9TQLSIi5fHY4eWEMmds9v+KxxDIaCcuOdT+9KGgdrmb9az4YW0Ewb9LwuwARJvh
	 7zKksVg4QndgEvOhRVKWC3bZDeesfmYFIzxJMeJG6ACGmYd/Tlv5po1NGdP8WKqBk9
	 obl6t4bx4qf3RnNVLD078RVyEZL/x0wX175TOCO2WHG+dmnyt/ug0dlYWj0aVfDEXc
	 x/X5PuVtpHISFb/mMIsohchwin4IbSqoV3GCvFjxSadfPW5YjGsyf/7gGBzSmpG/G1
	 mZLof6jfwIKsA==
Message-ID: <97535dde-5902-4f2f-951c-3470d26158da@kernel.org>
Date: Tue, 4 Nov 2025 10:20:04 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Jens Axboe
 <axboe@kernel.dk>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@wdc.com>, hch <hch@lst.de>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-12-dlemoal@kernel.org>
 <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
 <0154c2a8-a3ed-45d3-8f8a-1581106212fb@kernel.org>
 <a6d95da9-afdc-4885-bcc7-246d6d133ba7@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a6d95da9-afdc-4885-bcc7-246d6d133ba7@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 10:01, Bart Van Assche wrote:
> On 11/3/25 4:15 PM, Damien Le Moal wrote:
>> The old one is needed to allow getting the precise imp open, exp open, closed
>> conditions, if the user cares about these. E.g. Zonefs does because of the
>> (optional) explicit zone open done on file open.
> 
> How about adding the above information in include/uapi/linux/blkzoned.h?

I did.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research

