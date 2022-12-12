Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017CB64A819
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 20:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiLLT1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 14:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiLLT1k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 14:27:40 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B18FB92
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 11:27:38 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h16so9887868qtu.2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 11:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRPkKe+aMW3ChQqTlBMf++WGbvWM2YlRDJO80nM3qkM=;
        b=VQLim/uT6XYApfCfaAT+VUdtzEPmp3vpYA2yMc/2LdVU16j6SdqyGZTfSQafO/B8vz
         N3V9RUpdr0KoCxB17h48fxqkv+R4pt3/vxTmHBfN8tj11ZCDLpUVpZQXb3uJ5LhIHjZg
         HpFpPkS62d7fqFabgpoUR1NLSlegtJ3SXrH4fykZ4P+h2CgsxsHy+AR+Vt6Hh45y6Sf7
         /vepOu7iih9s4nnXSmbgemzScf9CShlr7eR2xifkH4rg0bXVJ/06xbHvKbOEfGdr3fV+
         HKUu6yUI/vTLflz/rp6bPobOyd0Uw+Qs46RnfPA0utKxlIf+qZmlmlZ4LwUs+S+ssRGQ
         Q4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRPkKe+aMW3ChQqTlBMf++WGbvWM2YlRDJO80nM3qkM=;
        b=vHkP6F34fsJBRXWLfWH4V02sMQHRTCS52q4LyWyfxEWKWeaj1TpiHa+OlXhC4Bf3Gn
         VmtjpvQ2BetHG/Et51dDqYQQMKxcT0KxrUxnvmfRRp4OWCYuXpRayQ1sVkXiCLAQ7auj
         Z18GtZWqYQOjCnoLKU817mRID0rxTTwDY3EBeP8T06XS+L64BqYSJEo4PlFoP8Nkq6x0
         OJOl1iKmfL/i5sJ6wPVjjMr3wOkbqU82QeRnr5XpWjhPCbUtb5ADNXfIrYLSSUlJWLKB
         DV47i0AdjgdUqBvVpgpwrkbsktUpde+7lLNW/gsvmHNO274mvvoqsOhK+63uxUoqt6hS
         yfAQ==
X-Gm-Message-State: ANoB5pmfhhBZYddDZHuxgHOVAMuyFCTXAiJpNvpQEUp8AuItrPun8jHJ
        a94GIrCH70Ww42ySMOM3M5fnWg==
X-Google-Smtp-Source: AA0mqf42a6pOVfbQ1m5QC6cqAc7otbigV5VoIiodO5GcOh5SoqfWFp+zAn6kUBhyBIvm10jSgjNpUA==
X-Received: by 2002:a05:622a:248c:b0:3a5:8508:16dc with SMTP id cn12-20020a05622a248c00b003a5850816dcmr24098164qtb.27.1670873257044;
        Mon, 12 Dec 2022 11:27:37 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id e3-20020ac81303000000b003a580cd979asm6149715qtj.58.2022.12.12.11.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 11:27:36 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:27:35 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Message-ID: <Y5eAp1+zNz2bv9dD@localhost.localdomain>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
 <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 07, 2022 at 06:22:12AM -0800, Johannes Thumshirn wrote:
> Add support for inserting stripe extents into the raid stripe tree on
> completion of every write that needs an extra logical-to-physical
> translation when using RAID.
> 
> Inserting the stripe extents happens after the data I/O has completed,
> this is done to a) support zone-append and b) rule out the possibility of
> a RAID-write-hole.
> 
> This is done by creating in-memory ordered stripe extents, just like the
> in memory ordered extents, on I/O completion and the on-disk raid stripe
> extents get created once we're running the delayed_refs for the extent
> item this stripe extent is tied to.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/Makefile           |   3 +-
>  fs/btrfs/bio.c              |  30 +++++-
>  fs/btrfs/bio.h              |   2 +
>  fs/btrfs/delayed-ref.c      |   5 +-
>  fs/btrfs/disk-io.c          |   3 +
>  fs/btrfs/extent-tree.c      |  49 +++++++++
>  fs/btrfs/fs.h               |   3 +
>  fs/btrfs/inode.c            |   6 ++
>  fs/btrfs/raid-stripe-tree.c | 195 ++++++++++++++++++++++++++++++++++++
>  fs/btrfs/raid-stripe-tree.h |  69 +++++++++++++
>  fs/btrfs/volumes.c          |   5 +-
>  fs/btrfs/volumes.h          |  12 +--
>  fs/btrfs/zoned.c            |   4 +
>  13 files changed, 376 insertions(+), 10 deletions(-)
>  create mode 100644 fs/btrfs/raid-stripe-tree.c
>  create mode 100644 fs/btrfs/raid-stripe-tree.h
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 555c962fdad6..63236ae2a87b 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -31,7 +31,8 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>  	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
>  	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
>  	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
> -	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o
> +	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
> +	   raid-stripe-tree.o
>  
>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 4ccbc120e869..b60a50165703 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -15,6 +15,7 @@
>  #include "rcu-string.h"
>  #include "zoned.h"
>  #include "file-item.h"
> +#include "raid-stripe-tree.h"
>  
>  static struct bio_set btrfs_bioset;
>  static struct bio_set btrfs_clone_bioset;
> @@ -350,6 +351,21 @@ static void btrfs_raid56_end_io(struct bio *bio)
>  	btrfs_put_bioc(bioc);
>  }
>  
> +static void btrfs_raid_stripe_update(struct work_struct *work)
> +{
> +	struct btrfs_bio *bbio =
> +		container_of(work, struct btrfs_bio, raid_stripe_work);
> +	struct btrfs_io_stripe *stripe = bbio->bio.bi_private;
> +	struct btrfs_io_context *bioc = stripe->bioc;
> +	int ret;
> +
> +	ret = btrfs_add_ordered_stripe(bioc);
> +	if (ret)
> +		bbio->bio.bi_status = errno_to_blk_status(ret);
> +	btrfs_orig_bbio_end_io(bbio);
> +	btrfs_put_bioc(bioc);
> +}
> +
>  static void btrfs_orig_write_end_io(struct bio *bio)
>  {
>  	struct btrfs_io_stripe *stripe = bio->bi_private;
> @@ -372,6 +388,15 @@ static void btrfs_orig_write_end_io(struct bio *bio)
>  	else
>  		bio->bi_status = BLK_STS_OK;
>  
> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
> +		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +
> +	if (btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
> +		INIT_WORK(&bbio->raid_stripe_work, btrfs_raid_stripe_update);
> +		schedule_work(&bbio->raid_stripe_work);
> +		return;
> +	}
> +
>  	btrfs_orig_bbio_end_io(bbio);
>  	btrfs_put_bioc(bioc);
>  }
> @@ -383,7 +408,9 @@ static void btrfs_clone_write_end_io(struct bio *bio)
>  	if (bio->bi_status) {
>  		atomic_inc(&stripe->bioc->error);
>  		btrfs_log_dev_io_error(bio, stripe->dev);
> -	}
> +	} else if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> + 	}

Whitespace error here.  Thanks,

Josef
