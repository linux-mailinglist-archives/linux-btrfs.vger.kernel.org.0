Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D92F51278A
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 01:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiD0Xe5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 19:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiD0Xe4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 19:34:56 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8CB26F1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 16:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651102303; x=1682638303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gLrzp6duhkPkV6taMyjQM6C7cL2l+fGNVwimG4CXPYA=;
  b=UxwxbAqsimwtwGRnt2pWvurMD3DKCoV4txQE4Qikvpz85X7zOij+G24A
   dYV++q3vdl/S2zGz6mPwlw3o1/RtH7HvwCa8ouDXOzPy5ELiBfrGDraa5
   0IEkT469+4ei67t8VBwIsBWL/yl4idrCL8X5+UMrjkWDN7PpE8s48Oelk
   dKvPifu1CsGXUvSNt9jqMqul96gf8TVr+kGYhrqXORkDwY1Ul++seufeB
   A/JxKLXZLOAx/MnYVHvYl+cijAIq2sAxagbSzApTmD7WDYoJAKe05MPUl
   XYGG4e2PKccIJv7SwaS6GVdic4zJzXC/F+hBMZqGIb/GzXxXUbWLc+b4N
   A==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; 
   d="scan'208";a="197843993"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 07:31:41 +0800
IronPort-SDR: WC3xqj/i1fDStqykZatKQAumujtxV17FQRuASiwylN7BE9YtckSSdmY4xoTwRTPLe59jckFmvt
 fX+LGk4tXshWtWeBBBoAurPWSetioBR0V/x8MNvPktLI81a9Byt3YCM+6gG3we8V71H+tBoA7A
 kFAvO5HHePUMRcpLH1fCRYI1wALeYDvoDWo8Hz2tVAoiPzlpCFzNKW/H19BJ483S4vAkSyayhy
 T1KdN//m94Fzff3jNVmIZVTmeaTbZ2068Oav5nJ/pF3Imt0PkLPWWwBbPXLGtSfCew33tOCik6
 nrfmuXfUbKCSftKs+MFtq2zd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 16:01:50 -0700
IronPort-SDR: Deb1R+yMkHIGB3Rg8VIcWOQ9j+AY/CteLHRKXLVxWX4uR4o5ot6y5fgU0O+kg2HsuT5+ZC4mau
 UXuo2smF/fDCYxsGEHrLM0BxPAkyBUCnV/xGdulU6WtmfeOLkgn+GD8jLrkHbLTBFDPoluxmv6
 9V8HvDyGQklbHqNKRYGOG4ZkiPCUGbw7/L/fbYPQlIKjdh+aEJZOt7HNNsYjf9OnBpzhFELHe7
 tGm74Mw4yUodw7afY7ShKkTSLisC6xXqbau+zLWAk+1m9LPTyheXyV71F9yfdd5FGVT5dWXq7L
 HBw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 16:31:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpZlJ6c5Jz1SVp0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 16:31:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651102299; x=1653694300; bh=gLrzp6duhkPkV6taMyjQM6C7cL2l+fGNVwi
        mG4CXPYA=; b=PdTQSxxj3EOLpYEGcnBYVKUPguXiBCCpr5ymI7+k28TTGz3mfSs
        KbvC8k3lhS5m6XprU6x/phnhFmDH5Zdpl9mtNhPvxWLwoLZA79RJ39tzK0T66DJg
        cQ1J9s5aD6mTMKCIx7SKO/H0j3TVPipsOior8762yACFqgZPSPwSaryNVkrWfY9P
        vFK6Qn1Dlh6ebNdzrLYEPjfHxjH1TIuA8nWpktFuNYhAu/AUjrulRyzZmZH+ftr1
        f82lyX/KB3APT/Gb/yPBy31svE2vEO1vB1f3Yyd5uBMXra+42NUkawZ+Cd66ga7/
        bklmIOigH4dlDMngOOGM9ReZ0ePeHAN6LGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IS1Zum5izB9b for <linux-btrfs@vger.kernel.org>;
        Wed, 27 Apr 2022 16:31:39 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpZlB5PzJz1Rvlc;
        Wed, 27 Apr 2022 16:31:34 -0700 (PDT)
Message-ID: <652c33b5-1d85-e356-05b9-7bd84b768143@opensource.wdc.com>
Date:   Thu, 28 Apr 2022 08:31:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 03/16] block: add bdev_zone_no helper
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
 <CGME20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38@eucas1p2.samsung.com>
 <20220427160255.300418-4-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427160255.300418-4-p.raghav@samsung.com>
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
> Many places in the filesystem for zoned devices open code this function
> to find the zone number for a given sector with power of 2 assumption.
> This generic helper can be used to calculate zone number for a given
> sector in a block device
> 
> This helper internally uses blk_queue_zone_no to find the zone number.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  include/linux/blkdev.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f8f2d2998afb..55293e0a8702 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1392,6 +1392,15 @@ static inline bool bdev_zone_aligned(struct block_device *bdev, sector_t sec)
>  	return false;
>  }
>  
> +static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (q)

q is never NULL. So this can be simplified to:

	return blk_queue_zone_no(bdev_get_queue(bdev), sector);

> +		return blk_queue_zone_no(q, sec);
> +	return 0;
> +}
> +
>  static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);


-- 
Damien Le Moal
Western Digital Research
