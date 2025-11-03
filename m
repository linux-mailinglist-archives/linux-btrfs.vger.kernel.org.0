Return-Path: <linux-btrfs+bounces-18534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE4BC2A464
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 08:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0AA3AFECD
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 07:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C5D29D28B;
	Mon,  3 Nov 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXgqXUKr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB472505A5;
	Mon,  3 Nov 2025 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154299; cv=none; b=szGrH+LcCOZHuv90q+rft+bxmJEz9HQPoz4X7fKOuM2fTs+jowEtghZ9niM0lsW2zKQzcmFZ3uHSbHd79nFCarPElKSfuxWUDPt6G4fhqxAoXWjprnvnc4tqt0FeIn1BDU6+aDZdOs/n8tBTyCSz/2vrKMRvvSOlrHhk+ysYSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154299; c=relaxed/simple;
	bh=vlAqAmTDh4Z/QVBO24ytbjpGSmt0U77g+FzG3aQu5i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GVuq8zjUzJwLV6xsPsZ1RqgITd4O1NzYG+TqfRAKmkXmCCaWgYMC51iX+bGcnKWuSHBXLhpFlcqPTdPvQxzHfM113DP6rTy7it3bCL643TsG9gAbB+DHGpc9kqMp/qwNRV6jchVxe9KZjwfNwMoQGYT0yhYavlWod2GKUpyhYjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXgqXUKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E082C116B1;
	Mon,  3 Nov 2025 07:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154298;
	bh=vlAqAmTDh4Z/QVBO24ytbjpGSmt0U77g+FzG3aQu5i4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=sXgqXUKrx4uv7eCDDbOTW1FX2EPok9okwx0Lrr6XBQ45+D708jWbU21sZDvabs/hn
	 qvNvsMevjEkOo6P3J42RSOQ3Ac+pQ5EdatTBhtEwIUWGGrBBq20xe3q6xxFFsJNKul
	 /8fHCp3TUL/EkkGaTHHAsONSBNYkj8+xxoX+y49HwtFgaCqvyAbc+/FfzYtRjHwDSZ
	 gAuXGCMs1NkkiH83gyEO+vnrejyB8h3zyAACvbXKd1oLdL+P7gTfjX8PJox2wBwNln
	 TWVE+b2XT2lo4y1t4cK//cuvil16uW/0WrZZAuJVZhSMMX8d6tnb/t/8nekeQqT4jb
	 GMfwQhjssGKGQ==
Message-ID: <7a8d31de-f1bb-468f-8a44-2787f0080dcf@kernel.org>
Date: Mon, 3 Nov 2025 16:18:14 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] block: introduce blkdev_report_zones_cached()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-10-dlemoal@kernel.org>
 <4287484a-3a3d-4f50-9c5b-7a901458bfbc@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4287484a-3a3d-4f50-9c5b-7a901458bfbc@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 06:53, Bart Van Assche wrote:
> On 10/30/25 11:13 PM, Damien Le Moal wrote:
>> Introduce the function blkdev_report_zones_cached() to provide a fast
>> report zone built using the blkdev_get_zone_info() function, which gets
>> zone information from a disk zones_cond array or zone write plugs.
>> For a large capacity SMR drive, such fast report zone can be completed
>> in a few millioseconds compared to several seconds completion times
>> when the report zone is obtained from the device.
> 
> millioseconds -> milliseconds
> 
> Does retrieving the cached zone information really require multiple
> milliseconds instead of only a few microseconds?

There are over 100,000 zones on large capacity SMR HDDs. And I have models with
smaller zone size that have over 200,000 zones. So yes, a few milliseconds are
needed on normal (read not super fast) CPUs.


-- 
Damien Le Moal
Western Digital Research

