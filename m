Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF87512797
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 01:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiD0XlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 19:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiD0Xkx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 19:40:53 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890CB57157
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 16:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651102659; x=1682638659;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yHKaW5zTI9WZN6XlbM6WV522YA4NJP0ufKH9fAehyOY=;
  b=GUwIB4rkeIaC4kQIe9/HB4V6e+2y7GoLu6KUJIibnzQbienhIF9KJXRI
   M651jBfcOKAVb0yacCJZnmHHtux5BMJJBrPqEN5kDp3uRnLAuBKKfJAVA
   SEwZk37g2Mc0Se5gMD6gnLLPeeixWorH4i5dF2cQZbCkljlmo9U7t4X5B
   1a+ivDSUZGkWXLfQKElx7kzbAz7hcS+QKjIcMdqR0BPGfpa/vMK4iNLpx
   Sho3/YGWs4d4wGG87aXxRVqRzgoi5lQqz0NsurnMYnDkEaa0CtNFh5Hi6
   Bmufqeaj91ZVMkvWW7HFz1XEDj55OQP1kWQZzYvluwgNOtvWGh6bDhIwI
   w==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; 
   d="scan'208";a="203872995"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 07:37:35 +0800
IronPort-SDR: m0vgXTGmEq+XJa+WrdQwHXvSJto/idmtPtM334xdcFTPCkAfHHxfLl/V16L5Aoh2x9EhVfxBue
 wrZ6LBX6oJESYiOjwzGz7vP+jgJ3IStGkRfPQgNnlXDSHPYpfOP6RdRJqS7MWEUy4PboBanOxq
 Pc/yGrsbjJXuaWLihFjZLMhWw4i7hgzgE/s1AgZl/Ic6oljERj2G211ZnHknRap2wtLLFKpb/5
 5sJIacgrsr4bsoJ1TaIe3i27K+Eyx/NDEZKCyQD1hjF0V2LOFj2tmKGz+fKciXq6ici+NxOAzi
 63LlQFfNz7aq4arkE68pBG/f
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 16:07:45 -0700
IronPort-SDR: IT2QHnPH3O35T4RyJooIaO+iCUiT8EW5c4DnaJ2e6GjM0uWx6rYWIf8gGbmKgz6ovgCVkFTe+V
 ACouniwbxyFKbVI+uL9EbtYAR0QqCDKnc037/+P3EsALHxje0ie5GK9liO4nGUtae5jsC8HcKV
 vkk/7H/XLE1W3/D8adrqZtGkv4ASgvI7Iwj64SIOzCnmlayrwFImLIe2WnPYNKHuECELP6yAlV
 bPOdcEHyiGM40u+tSsSAnjwFZwycZyUaeIacQprP4zVosK3cjx312DwjuNvlQdS2p84wBEkS14
 RnE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 16:37:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpZt725HJz1SVpD
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 16:37:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651102654; x=1653694655; bh=yHKaW5zTI9WZN6XlbM6WV522YA4NJP0ufKH
        9fAehyOY=; b=omMAaNcAu4C2yHYQb1NClkSwg2xHp13YAJ2SJFHQcpzAm7KwKtr
        LoyEbaprBAqXCi8vJVE8STd2nWRh72RwP+tsxCLdjrW122FhlORiBAJ8dnK+srl9
        3w1eKFOkpl1sQiG+Jw/wdu7z2ERwVaBSZVfkOkvF99qQqSEXxFfHnln0i40KAU/Z
        Rgsaekp7gheGMuCzGRy7neZeHEpBkYADsxKlKyaPXvPrCEfGYZfBs8AldO5KdA8A
        Widzt5gxXgMgTajwk3U2C0i7oJEtbBMNJ39YP0YWgmM6yf9XrjjBtapx0eQ1JfGG
        dk7Riq4IhGTM4HZ/ocUmEc8dhcniKD7mQgw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0Kn7mIyU_lfj for <linux-btrfs@vger.kernel.org>;
        Wed, 27 Apr 2022 16:37:34 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpZt05KG9z1Rvlc;
        Wed, 27 Apr 2022 16:37:28 -0700 (PDT)
Message-ID: <eeb86052-399c-a79b-32ab-1ed1b2d05e07@opensource.wdc.com>
Date:   Thu, 28 Apr 2022 08:37:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 04/16] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
        naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        johannes.thumshirn@wdc.com
Cc:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        clm@fb.com, gost.dev@samsung.com, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
        jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
        kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a@eucas1p1.samsung.com>
 <20220427160255.300418-5-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427160255.300418-5-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/28/22 01:02, Pankaj Raghav wrote:
> Convert the calculations on zone size to be generic instead of relying on
> power_of_2 based logic in the block layer using the helpers wherever
> possible.
> 
> The only hot path affected by this change for power_of_2 zoned devices
> is in blk_check_zone_append() but the effects should be negligible as the
> helper blk_queue_zone_aligned() optimizes the calculation for those
> devices. Note that the append path cannot be accessed by direct raw access
> to the block device but only through a filesystem abstraction.
> 
> Finally, remove the check for power_of_2 zone size requirement in
> blk-zoned.c
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-core.c  |  3 +--
>  block/blk-zoned.c | 12 ++++++------
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 937bb6b86331..850caf311064 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -634,8 +634,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  		return BLK_STS_NOTSUPP;
>  
>  	/* The bio sector must point to the start of a sequential zone */
> -	if (pos & (blk_queue_zone_sectors(q) - 1) ||
> -	    !blk_queue_zone_is_seq(q, pos))
> +	if (!blk_queue_zone_aligned(q, pos) || !blk_queue_zone_is_seq(q, pos))

blk_queue_zone_aligned() is a little confusing since "aligned" is also
used for write-pointer aligned. I would rename this helper

blk_queue_is_zone_start()

or something like that.


>  		return BLK_STS_IOERR;
>  
>  	/*
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 1dff4a8bd51d..f7c7c3bd148d 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -288,10 +288,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>  		return -EINVAL;
>  
>  	/* Check alignment (handle eventual smaller last zone) */
> -	if (sector & (zone_sectors - 1))
> +	if (!blk_queue_zone_aligned(q, sector))
>  		return -EINVAL;
>  
> -	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
> +	if (!blk_queue_zone_aligned(q, nr_sectors) && end_sector != capacity)
>  		return -EINVAL;
>  
>  	/*
> @@ -489,14 +489,14 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>  	 * smaller last zone.
>  	 */
>  	if (zone->start == 0) {
> -		if (zone->len == 0 || !is_power_of_2(zone->len)) {
> -			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
> -				disk->disk_name, zone->len);
> +		if (zone->len == 0) {
> +			pr_warn("%s: Invalid zoned device size",
> +				disk->disk_name);

The message is weird now. Please change it to "Invalid zone size".

Also, the entire premise of this patch series is that it is hard for
people to support the unusable sectors between zone capacity and zone end
for drives with a zone capacity smaller than the zone size.

Yet, here you do not check that zone capacity == zone size for drives that
do not have a zone size equal to a power of 2 number of sectors. This
means that we can still have drives with ZC < ZS AND ZS not equal to a
power of 2. So from the point of view of your arguments, no gains at all.
Any thoughts on this ?

>  			return -ENODEV;
>  		}
>  
>  		args->zone_sectors = zone->len;
> -		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
> +		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
>  	} else if (zone->start + args->zone_sectors < capacity) {
>  		if (zone->len != args->zone_sectors) {
>  			pr_warn("%s: Invalid zoned device with non constant zone size\n",


-- 
Damien Le Moal
Western Digital Research
