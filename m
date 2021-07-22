Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027193D1FEC
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 10:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhGVIBN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 04:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230427AbhGVIBM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 04:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626943307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wQ7KNhki+kDafU3RnLTISr/t4/c7pKh5QiqdUWMdWz0=;
        b=QQH/DVUVvMFV4nPg9v6mriKyWpAOOZi3h1wYGQPAKOS4V2fGZSss54Wa0xcL9kTTAUzCL3
        PKLM53ttqZGs0Xb8/Z1vhyZDszuUe5Dn7RVCUcvfeqncLE7xAx2NycN8+AL6uymnpsIe7M
        mAVeT9DXWWaqTqMlYY88AlWvvvByMHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-M27gx_IUNYunUTX-MC8Log-1; Thu, 22 Jul 2021 04:41:44 -0400
X-MC-Unique: M27gx_IUNYunUTX-MC8Log-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CD2E804141;
        Thu, 22 Jul 2021 08:41:42 +0000 (UTC)
Received: from T590 (ovpn-13-219.pek2.redhat.com [10.72.13.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08EC169CBC;
        Thu, 22 Jul 2021 08:41:33 +0000 (UTC)
Date:   Thu, 22 Jul 2021 16:41:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: change the refcounting for partitions
Message-ID: <YPkvONK78vIEMrMI@T590>
References: <20210722075402.983367-1-hch@lst.de>
 <20210722075402.983367-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722075402.983367-6-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 09:53:58AM +0200, Christoph Hellwig wrote:
> Instead of acquiring an inode reference on open make sure partitions
> always hold device model references to the disk while alive, and switch
> open to grab only a device model reference to the opened block device.
> If that is a partition the disk reference is transitively held by the
> partition already.
> ---
>  block/partitions/core.c |  9 ++++++-
>  fs/block_dev.c          | 60 ++++++++++++++++-------------------------
>  2 files changed, 31 insertions(+), 38 deletions(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 09c58a110a89..4f7a1a9cd544 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -261,6 +261,7 @@ static void part_release(struct device *dev)
>  {
>  	if (MAJOR(dev->devt) == BLOCK_EXT_MAJOR)
>  		blk_free_ext_minor(MINOR(dev->devt));
> +	put_disk(dev_to_bdev(dev)->bd_disk);
>  	bdput(dev_to_bdev(dev));
>  }
>  
> @@ -349,9 +350,13 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
>  	if (xa_load(&disk->part_tbl, partno))
>  		return ERR_PTR(-EBUSY);
>  
> +	/* ensure we always have a reference to the whole disk */
> +	get_device(disk_to_dev(disk));
> +
> +	err = -ENOMEM;
>  	bdev = bdev_alloc(disk, partno);
>  	if (!bdev)
> -		return ERR_PTR(-ENOMEM);
> +		goto out_put_disk;
>  
>  	bdev->bd_start_sect = start;
>  	bdev_set_nr_sectors(bdev, len);
> @@ -420,6 +425,8 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
>  	device_del(pdev);
>  out_put:
>  	put_device(pdev);
> +out_put_disk:
> +	put_disk(disk);

put_disk() is only needed for failure of bdev_alloc(). Once bdev->bd_device
is initialized, the disk reference will be dropped via part_release().

Thanks,
Ming

