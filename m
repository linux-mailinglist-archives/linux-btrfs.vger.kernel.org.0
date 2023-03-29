Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076856CF79D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjC2Xo7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjC2Xo4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:44:56 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475D559EF
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680133495; x=1711669495;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u0GDcNaX/W8JMXWCJKoDWEVkmUM3b9b6zaDxlqDnkVw=;
  b=gfvR3k16eb42cA9Mc5YUdTM9xPJR/F+Ev04Ml7yRvHznPOI7jLq+YeEI
   4syEv5IwD19HAoQeGvlJnSi1HeqKAWmqPxMLsiJ/izfLK6RcNC9a7othl
   m15dMIEL34EP0mSbT7Hl/LsHjVjwJK0V2SEuEByFF/62fpmQxYsn8GlX2
   w/7LUNqbHfuotPDClWTd2gGqb+64uQH0f9/+gy+GPmnyFVtGTAS4vrdnB
   H2z8f2NvmWnv4eXjgoXx3HHDq4Q7e9Sh+gJWAlfKV1hoD9s/67W/vFctk
   AC1WjA+DeEYbPmDdOmA2wLVELhS0xFgQjqFxtvrOVLm+TTQ9wKBkbztOh
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="231809208"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:44:54 +0800
IronPort-SDR: rKCFGBoIJlfvSQhpBjd8XncLw7nNcTjy8PGO4/nUACOYq5nnjRGpgh4UB4eghBuJWZlvZigj1L
 7zETrZapFcOFLUuNc/AuCveSh9E95GYmpix2fn2b2wKrGJr9Aq9IpDVHDfZCzGPj0MpIg514jQ
 NcUlvQOYPPN1wKLYG7qVWePv1hPisBH5hke6BY34kKBfhwJ9ATVcxO7PXZkedzaNQfSMaU3imE
 01J88j4huKThchT1AnCn/Vjv9Qf5S0x1Uwd2XL687RxEouunQpdRFvLPIaQR7UUccqcgEQsrVc
 pdk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:55:22 -0700
IronPort-SDR: 7cbCYf3QeRR/OoOf1NoOb73qqId5nrwV4t2eSa2xW5SAzosSsqPG7CHK3EknwUvIR9paX3C/tN
 pe+s165gAiXfPbxSCSamjUU/yjf0n+w4iML4N31bDTF3n820DaBJKRGz5hTpihXyvyF7mUyyfb
 qYZ+4xtTzTu0+DgI27HrfxlJG4EkpCcG2Vo2ZVCn3C/P18MYihlZV/TIVXhQZYezF8yuYF2KwB
 1QujLFHEBLIrSHLk3NdC9n264mGkHJtkscfMPKUdv/czIHyhwl1DvcyW2JSHUrWZ1j8ikk03Yr
 koE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:44:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn37T5bKBz1RtVn
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:44:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680133492; x=1682725493; bh=u0GDcNaX/W8JMXWCJKoDWEVkmUM3b9b6zaD
        xlqDnkVw=; b=sWgVImUIxq+wWv1IY/OzgZBxlMgwl6baNfK+TqDv/z9uGO4/lCt
        F80WbSTE4+zUj8V0KSvVsrvpDkaRwb4xUc4WvzxbBWL84Hn8V4HQomFckjQyxrY1
        X0XkISOSqW9QYHF6QugDBdkke58q7tb92oKEEHYiT6JSunUei+AHzcz8Sr8d1rgM
        XQE7xIDgFbTnJY20sa1jEv3CUu36WQYI/MhUDV8/3hBMQEryT+U76F6ZujWyaxcY
        Laa1jGoGfx5a4Yhez4KqWdpv/xoDLd+woYRyn3dDBSFt37g9Zj2KS3TC+gfCG56r
        o+X+Ideih0iowjTzWAbWUDYhNczPHD7idUA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LByi99X5-6ah for <linux-btrfs@vger.kernel.org>;
        Wed, 29 Mar 2023 16:44:52 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn37P0nXXz1RtVm;
        Wed, 29 Mar 2023 16:44:48 -0700 (PDT)
Message-ID: <7441afa8-3e60-79cf-66c7-4ddb692c1bcd@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:44:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 17/19] md: raid1: check if adding pages to resync bio
 fails
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <e2f96e539befa4f9d57f19ff1fc26cfc0d109435.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e2f96e539befa4f9d57f19ff1fc26cfc0d109435.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/30/23 02:06, Johannes Thumshirn wrote:
> Check if adding pages to resync bio fails and if bail out.
> 
> As the comment above suggests this cannot happen, WARN if it actually
> happens.
> 
> This way we can mark bio_add_pages as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  drivers/md/raid1-10.c |  7 ++++++-
>  drivers/md/raid10.c   | 12 ++++++++++--
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index e61f6cad4e08..c21b6c168751 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -105,7 +105,12 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
>  		 * won't fail because the vec table is big
>  		 * enough to hold all these pages
>  		 */
> -		bio_add_page(bio, page, len, 0);
> +		if (WARN_ON(!bio_add_page(bio, page, len, 0))) {

Not sure we really need the WARN_ON here...
Nevertheless,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


> +			bio->bi_status = BLK_STS_RESOURCE;
> +			bio_endio(bio);
> +			return;
> +		}
> +
>  		size -= len;
>  	} while (idx++ < RESYNC_PAGES && size > 0);
>  }
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 6c66357f92f5..5682dba52fd3 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3808,7 +3808,11 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>  			 * won't fail because the vec table is big enough
>  			 * to hold all these pages
>  			 */
> -			bio_add_page(bio, page, len, 0);
> +			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
> +				bio->bi_status = BLK_STS_RESOURCE;
> +				bio_endio(bio);
> +				goto giveup;
> +			}
>  		}
>  		nr_sectors += len>>9;
>  		sector_nr += len>>9;
> @@ -4989,7 +4993,11 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
>  			 * won't fail because the vec table is big enough
>  			 * to hold all these pages
>  			 */
> -			bio_add_page(bio, page, len, 0);
> +			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
> +				bio->bi_status = BLK_STS_RESOURCE;
> +				bio_endio(bio);
> +				return sectors_done; /* XXX: is this correct? */
> +			}
>  		}
>  		sector_nr += len >> 9;
>  		nr_sectors += len >> 9;

-- 
Damien Le Moal
Western Digital Research

