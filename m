Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45F5201EB
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 18:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbiEIQJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbiEIQJf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 12:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2875E25B071
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652112339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oeFX2E5ey4pZOwmjvDjcnRprgKudS5nUCFFZ6mjCjw4=;
        b=O2iOyWvHQECbahVRCR3auxpkAXjIms3CLRAk9aCWOL5T5OTpFLoBMhdYq++ssMdDbROcn2
        4TJplDqs1Qfb8Jf0GfVNfwesdJUbm04Q9YTB93Juk+0FiR8Rk0USdGs6t4aBG3vVdbldbX
        KI7iiQythNFaLgijQo9QcsUDHuWIwzI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-Mql2WsPuNtC38M89KK2VQA-1; Mon, 09 May 2022 12:05:38 -0400
X-MC-Unique: Mql2WsPuNtC38M89KK2VQA-1
Received: by mail-qt1-f198.google.com with SMTP id n4-20020ac85b44000000b002f3940d55eeso12467423qtw.19
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 09:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oeFX2E5ey4pZOwmjvDjcnRprgKudS5nUCFFZ6mjCjw4=;
        b=JNXuLDpPBTLmQIKPlL9slEazlRwfdDAGy4mNEqGL4hP53kVI/jKMTZ0ZfQlHkneKLp
         6bpsAq7aMDyGQX7zLQg86Ch294FlgFXFMdHqNe0Lhn58WWlVgklS29n9YoiwF92P/K0e
         HRxcyCwpp0h9YHh4HXFTyH9Z1KHx3lmJyFk2P0ok9KQj4gg9tXajybUbggObuPrAc443
         PkQYdK3WexheBn3StHmCws9EBSiFOGJuhMPkYoouMv+5lgEijg5hD/BH+REDXS6oks9F
         NyYuHveCB3OlVPKl6Mho39Wxz9Tv8gL+IpJ7z/cxj3lSByXp7OgAWI2MzfgDm1vxHBn+
         xnIA==
X-Gm-Message-State: AOAM532FCEyp3c5goYHPwDMyjgxukK3Ewes8Zzi5pKhcdg8Hr9cejffA
        rh7Rr/01tZyuI8Shh5HHVc9iUdYQ7BLM6PSx1W9ntuo8RtDr2G2JSa8Og9bvNUk/ysg4p+PRBo/
        YpQ36ndwGvdrwmzSilAI+Zw==
X-Received: by 2002:ad4:5504:0:b0:456:35e0:1968 with SMTP id az4-20020ad45504000000b0045635e01968mr13785943qvb.126.1652112337401;
        Mon, 09 May 2022 09:05:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb2Vrd1ITeAGMSA0ykyWFDZQi/Pj9RpII0I7NdSUoTuyX2v0W9UQn5F/cD9u0YFL4E+wPA+Q==
X-Received: by 2002:ad4:5504:0:b0:456:35e0:1968 with SMTP id az4-20020ad45504000000b0045635e01968mr13785891qvb.126.1652112337165;
        Mon, 09 May 2022 09:05:37 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id x14-20020ac8538e000000b002f3bbad9e37sm7663441qtp.91.2022.05.09.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 09:05:36 -0700 (PDT)
Date:   Mon, 9 May 2022 12:05:35 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        jaegeuk@kernel.org, hare@suse.de, dsterba@suse.com,
        axboe@kernel.dk, hch@lst.de, snitzer@kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, Luis Chamberlain <mcgrof@kernel.org>,
        gost.dev@samsung.com, Josef Bacik <josef@toxicpanda.com>,
        linux-nvme@lists.infradead.org, jiangbo.365@bytedance.com,
        Jens Axboe <axboe@fb.com>, Chris Mason <clm@fb.com>,
        dm-devel@redhat.com, linux-btrfs@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>, jonathan.derrick@linux.dev,
        linux-fsdevel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Keith Busch <kbusch@kernel.org>, matias.bjorling@wdc.com,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 11/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Message-ID: <Ynk7z4FhE2zTrzZh@redhat.com>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a@eucas1p1.samsung.com>
 <20220506081105.29134-12-p.raghav@samsung.com>
 <7f1bd653-6f75-7c0d-9a82-e8992b1476e4@opensource.wdc.com>
 <26ccce4c-da31-4e53-b71f-38adaea852a2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ccce4c-da31-4e53-b71f-38adaea852a2@samsung.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 09 2022 at  7:03P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> >> ---
> >>  drivers/md/dm-zone.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> >> index 3e7b1fe15..27dc4ddf2 100644
> >> --- a/drivers/md/dm-zone.c
> >> +++ b/drivers/md/dm-zone.c
> >> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
> >>  	struct request_queue *q = md->queue;
> >>  	unsigned int noio_flag;
> >>  	int ret;
> >> +	struct block_device *bdev = md->disk->part0;
> >> +	sector_t zone_sectors;
> >> +	char bname[BDEVNAME_SIZE];
> >> +
> >> +	zone_sectors = bdev_zone_sectors(bdev);
> >> +
> >> +	if (!is_power_of_2(zone_sectors)) {
> >> +		DMWARN("%s: %s only power of two zone size supported\n",
> >> +		       dm_device_name(md),
> >> +		       bdevname(bdev, bname));
> >> +		return 1;
> > 
> > return -EINVAL;
> > 
> > The error propagates to dm_table_set_restrictions() so a proper error code must
> > be returned.
> > 
> Good point. I will add this in the next rev.

Also, DMWARN already provides the trailing newline, so please remove
the above newline.

