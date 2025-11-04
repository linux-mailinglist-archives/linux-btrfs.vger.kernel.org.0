Return-Path: <linux-btrfs+bounces-18687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB6C32FD6
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 22:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E473B442F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 21:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B032F290B;
	Tue,  4 Nov 2025 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHU1/+Nx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC812DC332;
	Tue,  4 Nov 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289995; cv=none; b=irQNeiCW7QHjzMyo7UsYl0he8AOwy/fp7uBRHHt69wtwOzmaY2akBZT8Xhe++0aR9wPIq6FKwgvt6S4sXcm/ihw6E4VOO07Blg0SnYz8X6WsRR5qbWOe8q26fAcCMQTSiAvfmWQAnc2KpgV+nGmhrFr0zdZGDVehYLDaFc6QHiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289995; c=relaxed/simple;
	bh=ZbevVTsyzkuKwdQrJJOdeX7YrKTFidZKoeeACl1fcI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcEAerHKbbGyTveBqCmiDbBptyRalprb/7xrp943wfO7LNV76/Y9kmhrG4orRwd6bTgxQZ1Hqc/ZAN5hmlGz55+gJyVTbbRiCq7hRk6zx3/g75zsWQjMQFaLUdC5QHGf+gF7oO+bfWQ7ka2Ryii4uEZoxRWDX/+g+BBllNLGUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHU1/+Nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA585C116B1;
	Tue,  4 Nov 2025 20:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762289994;
	bh=ZbevVTsyzkuKwdQrJJOdeX7YrKTFidZKoeeACl1fcI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aHU1/+NxHTGcstCciKvN0HOtfqbZvcKPFHaJAIxHidNwzrAUH57pju/VvROjFT57e
	 9rImaFQb4z8LuzRklIxZLJF2VrGAH+JLi7zsSFkq1D6Np4PjBtNYScd1PR0ri1TAtO
	 C8/TJ5vEMM3KUaF2iZ2FJtiFVDHMxidEJ0H/ZcmFov1S5b28kv2BMp+H+YUgVLxQEb
	 fODPu/xN0+jxDzu5/ZHF6J2R+epjSqAVdQcC4nlJyvr175SaM5q8EYEdPQE5eXwQUE
	 yVevNDW2NW1iLpxmhZ7XasSauPf7KOKeLRcqsgrgXv3zRMqhAJjr+vy5jphrmBIYO6
	 gnqNNZ4ccEsBQ==
Message-ID: <9f899cd8-7187-4878-b294-337d964c9587@kernel.org>
Date: Wed, 5 Nov 2025 05:59:51 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Introduce cached report zones
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104144158.GA27416@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251104144158.GA27416@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 23:41, Christoph Hellwig wrote:
> I just threw this into my xfstests setup, and it seems this version
> is broken somehow.  Running on emulated ZNS devices with XFS I get
> a lot of failures with warnings like this:
> 
> [   30.068652] XFS (nvme1n1): empty zone 1 has non-zero used counter (0x1).
> 
> [   49.316873] XFS (nvme0n1): empty zone 2 has non-zero used counter (0x10).
> 
> so it seems like it's not tracking WPs correctly, probably when using
> zone append and unmount/remounting.

Aouch ! I totally missed that !

First problem, trivial, I am missing this in the xfs patch:

diff --git a/fs/xfs/libxfs/xfs_zones.c b/fs/xfs/libxfs/xfs_zones.c
index b0791a71931c..b40f71f878b5 100644
--- a/fs/xfs/libxfs/xfs_zones.c
+++ b/fs/xfs/libxfs/xfs_zones.c
@@ -95,6 +95,7 @@ xfs_zone_validate_seq(
        case BLK_ZONE_COND_IMP_OPEN:
        case BLK_ZONE_COND_EXP_OPEN:
        case BLK_ZONE_COND_CLOSED:
+       case BLK_ZONE_COND_ACTIVE:
                return xfs_zone_validate_wp(zone, rtg, write_pointer);
        case BLK_ZONE_COND_FULL:
                return xfs_zone_validate_full(zone, rtg, write_pointer);

Second problem is a little more subtle: when disk_insert_zone_wplug() is called
from blk_revalidate_disk_zones() callback for a non empty zone, the zone
condition is set to BLK_ZONE_COND_NOT_WP if we do not have a disk zones_cond
array. But we never have that on the first call to blk_revalidate_disk_zones()
since that function sets it at the end of the revalidation. So we need this
change to also avoid mount errors after a reboot for an FS with partially
written zones:

 diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index bf6495f0d49f..bba64b427082 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -527,12 +527,20 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
                        return false;
                }
        }
+
+       /*
+        * Set the zone condition: if we do not yet have a zones_cond array
+        * attached to the disk, then this is a zone write plug insert from the
+        * first call to blk_revalidate_disk_zones(), in which case the zone is
+        * necessarilly in the active condition.
+        */
        zones_cond = rcu_dereference_check(disk->zones_cond,
                                lockdep_is_held(&disk->zone_wplugs_lock));
        if (zones_cond)
                zwplug->cond = zones_cond[zwplug->zone_no];
        else
-               zwplug->cond = BLK_ZONE_COND_NOT_WP;
+               zwplug->cond = BLK_ZONE_COND_ACTIVE;
+
        hlist_add_head_rcu(&zwplug->node, &disk->zone_wplugs_hash[idx]);
        atomic_inc(&disk->nr_zone_wplugs);
        spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);

I will integrate these fixes in v5 and resend.




-- 
Damien Le Moal
Western Digital Research

