Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92405127A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 01:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiD0XqE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 19:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiD0XqC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 19:46:02 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D797449927
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 16:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651102969; x=1682638969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b4PQ+YojFt/Da7JedNLqXswRcZ1DtIMcbUQc3b82khE=;
  b=c5RIPV1B+DPLQqOpVAGTQ70MbGy+1t7Lm5otj4WMOLE2NlxdBnLC6V4e
   1xSF2iSnpTsZ7n0SuvnD6/EuIqYkh/O7Z0Nvj/sWTdVVwUpjGs6AQk/a+
   1T06tHBYcvSORiyZQ/LCzt0wUcuPSA5d/cb+mVBhN6O6UVZJQ+7Yafik8
   wJZdWdsrASgWWFtYiK8idGrFxjC5u4kVRluvyWn5RsnAJrfgCQ8EFiAja
   4B+4Hh7HVR8rr5ZZHj7ttD1UOGvagu3PEUTL3zScx8WRnYElT0ozXSB3f
   2wMhPjisOqDjfKXy4SMDGka6B2LvLRiBAgaRJHjfFomMnxwBl1K+VR+JY
   g==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; 
   d="scan'208";a="197844591"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 07:42:49 +0800
IronPort-SDR: U8c8jQgYrID9ROTOZfTkNmbFi2GuUS5TyvgM1ybxT9DEVpqvg9vrMDnNaoRZS/MkRrFhSdy7fB
 HQJBOFBWlhRkG9i83mNMkInEUTu7vDab6A3/ZLinh5Wa6SfgTHCYcETILULIuUQ62u9Adjae5q
 yG92uMPFCqVNdDd1pqF5+I1rxpFd4D+BVKxCVU+67N7l4B5CyBwb8TxnH4fQEKIJzQEG2mvRmH
 4L2wBTV1B5FSV1aLL0Wfnfu9eX6fWlxT0xYTnKu4K+iqw8oBfnbnt6pJj57z3Tmsx6BnfT55MY
 Uwu75DyUdcQ5FB91915uercb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 16:13:41 -0700
IronPort-SDR: Zrm3bXVZWOog909QQ7dQpRMzJNpOksvnCHBa4cKqkOfIirp5Jo4U515oVGomP9ommN/JVDhMxa
 ap7A9E7kiJwx01qTiFmoGmBke70rIT4ESK2wLr49NG0wjSbLLOxxSCInCA6R8xNqYf6cCJ9gJ3
 hTIjJ3tJif3nMqQc5i10RNKGTZiosVPBEdZ5HW/832g4SG8fJ4pojBlP4Gingb/1NQiX8uul4B
 pwnFnR32/bzcye4/H5fuBym5mOaHZXF+Q0fprQq75eNm4fZl6Pd14j0HC3n4+aHSMRiYhD8Xhp
 XbU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 16:42:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kpb0909nXz1SHwl
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 16:42:49 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651102968; x=1653694969; bh=b4PQ+YojFt/Da7JedNLqXswRcZ1DtIMcbUQ
        c3b82khE=; b=aG9U+mpCYTqXLYVrB1nXg30+hvfUJ189J7XQSSmBmeZkvjsxkwu
        zAaurumWJ7fm9SJv5J2FbjspgmG5JAqDow1JiX6iGFfC9Of0kykaaFX4ZDKBNjn7
        c1vaCSsv8uCxbA0qKU1vQr7sjo2GKuQXZlvDLVoxWtDsD0Z1sjM+p8Nwc0CEll4E
        D6XCio2WwJ24l1FBaPYbvh0rG1180xMBAGWn41A2ZxbXvt8f3tjQGcCajxa+bHT1
        FmppUurtfeoO8TjI45cH5MPXNN7fFivo3PY5cobe5YbA6m03HnTor8+NQEiSRl8I
        0/HpjutNT+lHDztsGZq4Q/AuoqjjlZcpVwA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ip0Fx4GxF9BY for <linux-btrfs@vger.kernel.org>;
        Wed, 27 Apr 2022 16:42:48 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kpb025hPwz1Rvlc;
        Wed, 27 Apr 2022 16:42:42 -0700 (PDT)
Message-ID: <2ffc46c7-945f-ba26-90db-737fccd74fdf@opensource.wdc.com>
Date:   Thu, 28 Apr 2022 08:42:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 16/16] dm-zoned: ensure only power of 2 zone sizes are
 allowed
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
 <CGME20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676@eucas1p1.samsung.com>
 <20220427160255.300418-17-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427160255.300418-17-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/28/22 01:02, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Today dm-zoned relies on the assumption that you have a zone size
> with a power of 2. Even though the block layer today enforces this
> requirement, these devices do exist and so provide a stop-gap measure
> to ensure these devices cannot be used by mistake
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-zone.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 57daa86c19cf..221e0aa0f1a7 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>  	struct request_queue *q = md->queue;
>  	unsigned int noio_flag;
>  	int ret;
> +	struct block_device *bdev = md->disk->part0;
> +	sector_t zone_sectors;
> +	char bname[BDEVNAME_SIZE];
> +
> +	zone_sectors = bdev_zone_sectors(bdev);
> +
> +	if (!is_power_of_2(zone_sectors)) {
> +		DMWARN("%s: %s only power of two zone size supported\n",
> +		       dm_device_name(md),
> +		       bdevname(bdev, bname));
> +		return 1;
> +	}

Why ?

See my previous email about still allowing ZC < ZS for non power of 2 zone
size drives. dm-zoned can easily support non power of 2 zone size as long
as ZC == ZS for all zones.

The problem with dm-zoned is ZC < ZS *AND* potentially variable ZC per
zone. That cannot be supported easily (still not impossible, but
definitely a lot more complex).

>  
>  	/*
>  	 * Check if something changed. If yes, cleanup the current resources


-- 
Damien Le Moal
Western Digital Research
