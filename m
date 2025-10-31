Return-Path: <linux-btrfs+bounces-18487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 354F6C26FE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 22:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D05974E99E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50F73164D3;
	Fri, 31 Oct 2025 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MOiAucOt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D40E303A06;
	Fri, 31 Oct 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945494; cv=none; b=DCVpKC0jmjUAy4Xey9xuOGf7wMj7VNMEgMXcJo7CIObXEMtW6dey/+7tgD/2mrwaWSBdexYB9ETVKosFrzbm/Fqw8sleH9H8qnxzI+AF5Z/pq/olo1xTcVxwPoKBNsyDR6ey0ujMX01R+3OLS14TMvEGkYrnTexauLbHaNHX/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945494; c=relaxed/simple;
	bh=HcNP5suCLjRHRXVhgz1ZcKm6OEG2zLosp+uCNUqRda4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KoMmzjx5DVwNgkBJHIBh+pNg3vqKffegiM+mBLCHY6wLfhfEkoCLDDOkmWY4KgxkSSA2ArRCIdz/Edsg7dOf39GiK93bgdd5/FjJnGmlAqads9pQcN/vqKCd5+Quo77N6rZ5LN5xYc2XC9yyp/2u1FNdfyqCrbmR0vmaKy6XIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MOiAucOt; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cyv371rCVzlgqVY;
	Fri, 31 Oct 2025 21:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761945488; x=1764537489; bh=dGFrbsqJ8CKkjY9qga1d96f2
	nx443JSUVFFvLuMecYs=; b=MOiAucOtLaQV5ydR0jMixm2/LO5HKwhCk725AoCq
	kP5jZzcKz9VStvYIXn8A/uppBX7GevrouJXU2OudQtlRy8cZqEuEJRkEKiOmwQ+g
	e4ok5VRdxSfWBu6bJ+UnFaYCKKm7k/mwJC5gg5iwBdVLqnF0h06E4F1Qkw8kp2Hs
	mDWTRMt9ttsGlDL9Hk3V2VFZCT+yiLkmjUCI6TYbT5qmArNtW0y2SGqTjVCyKe8v
	EXZbvV2lwww8UCNufxlCKGXZwThSDpreQ/Gu+PQK2D1mi+hc04iSYLz/MI5i4k9h
	pFG/hWVlWs/phvYJXwwE4jHtxycyc7diQkKBMmExZGRl2A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Zfkrr6N_4YYx; Fri, 31 Oct 2025 21:18:08 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cyv2t1Hg1zlstRG;
	Fri, 31 Oct 2025 21:17:56 +0000 (UTC)
Message-ID: <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
Date: Fri, 31 Oct 2025 14:17:55 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] block: track zone conditions
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 11:13 PM, Damien Le Moal wrote:
> Implement tracking of the runtime changes to zone conditions using
> the new cond field in struct blk_zone_wplug. The size of this structure
> remains 112 Bytes as the new field replaces the 4 Bytes padding at the
> end of the structure. For zones that do not have a zone write plug, the
> zones_cond array of a disk is used to track changes to zone conditions,
> e.g. when a zone reset, reset all or finish operation is executed.

Why is it necessary to track the condition of sequential zones that do
not have a zone write plug? Please explain what the use cases are.

The zoned UFS device on my desk has 3420 sequential zones and zero
conventional zones. If the condition of zones that do not have a zone
write plug wouldn't be tracked that would save some memory.
> +static void blk_zone_set_cond(u8 *zones_cond, unsigned int zno,
> +			      enum blk_zone_cond cond)
> +{
> +	if (!zones_cond)
> +		return;
> +
> +	switch (cond) {
> +	case BLK_ZONE_COND_IMP_OPEN:
> +	case BLK_ZONE_COND_EXP_OPEN:
> +	case BLK_ZONE_COND_CLOSED:
> +		zones_cond[zno] = BLK_ZONE_COND_ACTIVE;
> +		return;
> +	case BLK_ZONE_COND_NOT_WP:
> +	case BLK_ZONE_COND_EMPTY:
> +	case BLK_ZONE_COND_FULL:
> +	case BLK_ZONE_COND_OFFLINE:
> +	case BLK_ZONE_COND_READONLY:
> +	default:
> +		zones_cond[zno] = cond;
> +		return;
> +	}
> +}
> +
> +static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
> +			       enum blk_zone_cond cond)
> +{
> +	u8 *zones_cond;
> +
> +	rcu_read_lock();
> +	zones_cond = rcu_dereference(disk->zones_cond);
> +	if (zones_cond) {
> +		unsigned int zno = disk_zone_no(disk, sector);
> +
> +		/*
> +		 * The condition of a conventional, readonly and offline zones
> +		 * never changes, so do nothing if the target zone is in one of
> +		 * these conditions.
> +		 */
> +		switch (zones_cond[zno]) {
> +		case BLK_ZONE_COND_NOT_WP:
> +		case BLK_ZONE_COND_READONLY:
> +		case BLK_ZONE_COND_OFFLINE:
> +			break;
> +		default:
> +			blk_zone_set_cond(zones_cond, zno, cond);
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +}

Why does blk_zone_set_cond() accept a zone number as second argument and
why does disk_zone_set_cond() accept a sector number as second argument?
The callers of disk_zone_set_cond() can be optimized if its second
argument would be changed from a sector number into a zone number.

Thanks,

Bart.

