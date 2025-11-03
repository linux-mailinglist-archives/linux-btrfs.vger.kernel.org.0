Return-Path: <linux-btrfs+bounces-18529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B57C2A234
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 07:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50AE83A5E75
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 06:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA9A28FFFB;
	Mon,  3 Nov 2025 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIiFTEcx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECFF2A1C7;
	Mon,  3 Nov 2025 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149926; cv=none; b=EnY6iGiqr9qP6E415hqJELat+EgOYtk1J1gwBs5FIbbjB8AiQ852l077TAN4Afj9Wke9HqycVXKsKxJJXMDEleLV0j+DTWp5QvJAT21raudVb9HSd7CWTogp5bpCApNPKOsuU9iytUQwf2WO6c80459kBJvfioOxOh28Fm2xxj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149926; c=relaxed/simple;
	bh=nWA8qJYrPGGOaVXd+KfXLqzdVcWq+LCTObq2L0yNLPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FB9sp6f/E2Y/h7JqA7hAA8emKlZLgz5KfIJz2Fa1wvNmX0QzyzAF93tjUsFJhkNe5dNMIw2uicmujAhRAfAPyGu4Po/mc0rWbewaeYukMDGF0SRND0lHTXjs1W3SuT0j8K5mATHZQgAbvCc7GZYUn8O1tP0EKyHhw+BQa4Wyx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIiFTEcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A5CC4CEE7;
	Mon,  3 Nov 2025 06:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762149926;
	bh=nWA8qJYrPGGOaVXd+KfXLqzdVcWq+LCTObq2L0yNLPM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QIiFTEcx51FVNJKpbXtL1eDcqXXbYaxsHDUrIsqQzMTz6V8pP9IsaJnIawZoSyGbS
	 75v6GWjQJ2duN2QVDdw3y4Cw9lImt4Sb/glPO8VdNIlcjCiUVW79X9+C2zNZ0VAGlW
	 XRynqC2H+Maxg1XFUX/ZP32yN4FKTBP/5r4+EpIDLw2XON37n7Pqi8HjK95+7ecxRd
	 y3lYk4wzYtLAzBEJEfPjn0ogID4UVyGri7IgHs3NPh9rqfQK5Z9P4PKrmbHXM/aZuF
	 j2RPquxU46JqgCpBu1OuVBY0mxgVUN/ZaHq01UG5MTV81VLo0UHo2MqjFjv29o3QUl
	 FXSVi0qroaFYA==
Message-ID: <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org>
Date: Mon, 3 Nov 2025 15:05:22 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] block: track zone conditions
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
 <20251031061307.185513-8-dlemoal@kernel.org>
 <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 06:17, Bart Van Assche wrote:
> On 10/30/25 11:13 PM, Damien Le Moal wrote:
>> Implement tracking of the runtime changes to zone conditions using
>> the new cond field in struct blk_zone_wplug. The size of this structure
>> remains 112 Bytes as the new field replaces the 4 Bytes padding at the
>> end of the structure. For zones that do not have a zone write plug, the
>> zones_cond array of a disk is used to track changes to zone conditions,
>> e.g. when a zone reset, reset all or finish operation is executed.
> 
> Why is it necessary to track the condition of sequential zones that do
> not have a zone write plug? Please explain what the use cases are.

Because zones that do not have a zone write plug can be empty OR full.

> 
> The zoned UFS device on my desk has 3420 sequential zones and zero
> conventional zones. If the condition of zones that do not have a zone
> write plug wouldn't be tracked that would save some memory.

That would really be "some"... Not a lot. Your memory usage will be less than a
mem page...

>> +static void blk_zone_set_cond(u8 *zones_cond, unsigned int zno,
>> +			      enum blk_zone_cond cond)
>> +{
>> +	if (!zones_cond)
>> +		return;
>> +
>> +	switch (cond) {
>> +	case BLK_ZONE_COND_IMP_OPEN:
>> +	case BLK_ZONE_COND_EXP_OPEN:
>> +	case BLK_ZONE_COND_CLOSED:
>> +		zones_cond[zno] = BLK_ZONE_COND_ACTIVE;
>> +		return;
>> +	case BLK_ZONE_COND_NOT_WP:
>> +	case BLK_ZONE_COND_EMPTY:
>> +	case BLK_ZONE_COND_FULL:
>> +	case BLK_ZONE_COND_OFFLINE:
>> +	case BLK_ZONE_COND_READONLY:
>> +	default:
>> +		zones_cond[zno] = cond;
>> +		return;
>> +	}
>> +}
>> +
>> +static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
>> +			       enum blk_zone_cond cond)
>> +{
>> +	u8 *zones_cond;
>> +
>> +	rcu_read_lock();
>> +	zones_cond = rcu_dereference(disk->zones_cond);
>> +	if (zones_cond) {
>> +		unsigned int zno = disk_zone_no(disk, sector);
>> +
>> +		/*
>> +		 * The condition of a conventional, readonly and offline zones
>> +		 * never changes, so do nothing if the target zone is in one of
>> +		 * these conditions.
>> +		 */
>> +		switch (zones_cond[zno]) {
>> +		case BLK_ZONE_COND_NOT_WP:
>> +		case BLK_ZONE_COND_READONLY:
>> +		case BLK_ZONE_COND_OFFLINE:
>> +			break;
>> +		default:
>> +			blk_zone_set_cond(zones_cond, zno, cond);
>> +			break;
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +}
> 
> Why does blk_zone_set_cond() accept a zone number as second argument and
> why does disk_zone_set_cond() accept a sector number as second argument?
> The callers of disk_zone_set_cond() can be optimized if its second
> argument would be changed from a sector number into a zone number.

How so ? all the callers have a BIO sector or a zone start sector on hand, not a
zone number. On the other hand, blk_zone_set_cond() is always used in places
where the zone number is already available.

So this calling convention makes sense to me as it is.

-- 
Damien Le Moal
Western Digital Research

