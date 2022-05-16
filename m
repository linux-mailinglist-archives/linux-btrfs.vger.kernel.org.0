Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F271528651
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244244AbiEPOCe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbiEPOCb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:02:31 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A186939147
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652709748; x=1684245748;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xGZDTf4qfj90dVVU9I5TmSQhq50AE4kFyxK7baB8oU4=;
  b=QkQnpM5rjVj/kjQJ/eJlfNFoz+rm00JNIHwWeGeV+lpeh34hd/2hoO/N
   SS3w9jlZHFwA+WAxYp35FFGJAafNUOzZVsYu5ahs5gNK45NRjRoIMP5va
   aqojjKWqPXwQ1+UaYRuq3wOmaP0ofkwGf6L+++UjpS8OuoAGBsBhj78TX
   DUxQwK2Xp32XUr8LOj1LUKo6MVa9F4ipmEUIka1bXj9xzB8kCDZL/7edj
   JPFpcTvAXXGK//hNZrKDKHoBvJYc4z1hrVpDe2+ugkM740vd4NpMP8kT5
   sV9X6WiSOOyvwWyqiuwJ1lIX9YmOnCr/G7BmkG8hbeTvBaljm99Nf9OVr
   A==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205306643"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:02:27 +0800
IronPort-SDR: 5ROg4Xe8Q1s6JctcEvU6SBqHnFDAAeBwB0FqoGtwSf9OQUmxKOzfww2RJ5fiQaaYsQM93JYIpK
 ShAlduWuxlwwUOJ2xLbj43KVXx7ZiDwyY6CV2umE48dPL3xFEJrbzazju/LAUpxxmuazmOVIhe
 bZ1+iUyEp0NmIIk7MOQZyfihtrrq1fvXi/FRvegn4FRVPWpVrE3St7Iy1Ytq9c3e7T03ceFUDl
 glPhcoHLtRZ8hlGGrpVPW5ErC+RR3VBWrLQIcIFXyPge48ij/OINitZ3YPj9eipvzfMc+xepBa
 Xcj11XcACfi9c4jPAEp4SkYO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:28:10 -0700
IronPort-SDR: weWNCZBK54o8zSd71ikqDep/HzNYYB2x8KYARkezouH35AEyzfAb5rh8a3xvSPdACFWEJCLsat
 iw5c0LELGDeWQaJH6LF2HdVL2UMEqwFVEDrKq6yKhuWB1xiGocq8J8AUzFq8qNKnNkR2/hZQYy
 oMAy0lVl1xqAf1o6c9VaRZHc/8duM6NuZng+e09pazA/f0RSBioTtnAG1bNksIZ6CkgVdFlwrT
 z1cWnapw0c79oz6qsGwLT1gH7DWXEXtHnvL5nU+UWc9GrzepMzN3uMzzUzFVVdULxp+fq6huAy
 +zY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 07:02:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L21Cl5SVrz1Rwrw
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:02:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652709746; x=1655301747; bh=xGZDTf4qfj90dVVU9I5TmSQhq50AE4kFyxK
        7baB8oU4=; b=g5HXP5sVUntwSPqraDrwqbiwWoKzSlQz5eNpRQMVQIm31yD1VDg
        9nKU8IqEjHhBNcYQkJHPtfI+YGNRAJ1c1TBWaoYboTZtwJDFX0QG6G9RVr3V92bH
        gJlWbxjzteqSKP2s+7Tz2p1QjT0NOALTmlP/K6iaRYXzn7Jvqx5HYaPe2xenCINW
        tHr3uJtFcizoAIokoF0obIBVu4Y2c8vOxgbIeaw5PcYy3hjrCm+/ZaHJ1rnxnTzG
        PgoUgPdgugkirbK3x/Lq9lJFjztDGzmQFz7LaH2HCUhiemtIQ8/BgxtT6D1qMsqK
        yWagoXwtYZMjv4sNn1AtbIa+DXOcQHhVt7w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GN4DsPFcMmH7 for <linux-btrfs@vger.kernel.org>;
        Mon, 16 May 2022 07:02:26 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L21Cb6yPlz1Rvlc;
        Mon, 16 May 2022 07:02:19 -0700 (PDT)
Message-ID: <501aba4d-f4a3-8a4d-ec2a-99c7319b6a4d@opensource.wdc.com>
Date:   Mon, 16 May 2022 16:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 03/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, dsterba@suse.com, jaegeuk@kernel.org,
        hch@lst.de
Cc:     jiangbo.365@bytedance.com, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, bvanassche@acm.org,
        Chris Mason <clm@fb.com>, matias.bjorling@wdc.com,
        gost.dev@samsung.com, Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        jonathan.derrick@linux.dev, Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
References: <20220516133921.126925-1-p.raghav@samsung.com>
 <CGME20220516133926eucas1p15c7ba425b67ce4ac824c6bd3263e2dd4@eucas1p1.samsung.com>
 <20220516133921.126925-4-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516133921.126925-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022/05/16 15:39, Pankaj Raghav wrote:
> Remove the condition which disallows non-power_of_2 zone size ZNS drive
> to be updated and use generic method to calculate number of zones
> instead of relying on log and shift based calculation on zone size.
> 
> The power_of_2 calculation has been replaced directly with generic
> calculation without special handling. Both modified functions are not
> used in hot paths, they are only used during initialization &
> revalidation of the ZNS device.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/host/zns.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4d..65d2aa68a 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  	}
>  
>  	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
> -	if (!is_power_of_2(ns->zsze)) {
> -		dev_warn(ns->ctrl->device,
> -			"invalid zone size:%llu for namespace:%u\n",
> -			ns->zsze, ns->head->ns_id);
> -		status = -ENODEV;
> -		goto free_data;
> -	}
>  
>  	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> @@ -128,8 +121,13 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
>  				   sizeof(struct nvme_zone_descriptor);
>  
> +	/*
> +	 * Division is used to calculate nr_zones with no special handling
> +	 * for power of 2 zone sizes as this function is not invoked in a
> +	 * hot path
> +	 */

Comment not very useful.

>  	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 div64_u64(get_capacity(ns->disk), ns->zsze));
>  
>  	bufsize = sizeof(struct nvme_zone_report) +
>  		nr_zones * sizeof(struct nvme_zone_descriptor);
> @@ -182,6 +180,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	int ret, zone_idx = 0;
>  	unsigned int nz, i;
>  	size_t buflen;
> +	u64 remainder = 0;
>  
>  	if (ns->head->ids.csi != NVME_CSI_ZNS)
>  		return -EINVAL;
> @@ -197,7 +196,14 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>  	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>  
> -	sector &= ~(ns->zsze - 1);
> +	/*
> +	 * rounddown the sector value to the nearest zone size. roundown macro
> +	 * provided in math.h will not work for 32 bit architectures.
> +	 * Division is used here with no special handling for power of 2
> +	 * zone sizes as this function is not invoked in a hot path
> +	 */

Please simplify this to:

	/* Round down the sector value to the nearest zone start */

> +	div64_u64_rem(sector, ns->zsze, &remainder);
> +	sector -= remainder;
>  	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>  		memset(report, 0, buflen);
>  


-- 
Damien Le Moal
Western Digital Research
