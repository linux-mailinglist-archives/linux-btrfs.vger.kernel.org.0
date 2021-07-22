Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EC63D1C06
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 04:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhGVCGq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 22:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229932AbhGVCGp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 22:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626922040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jwzE0vHI/rCdSa5s/04LOGn224KncNKRA39uN9p98So=;
        b=i5ZvIKfANf9f7iFeF/cdsj4RW74WSp2LvMxZRObbBpJRwXHyeyQ8fNKFKcRMW9DNkgWItf
        g+MB34ujGXx/NIqxuGAkLq7/46Z2BNBh5ygtWHs6O3MQ03o0hya0MuAwYslOxu1ySENx7h
        0O1jJ1Vewr/nX3rPwmSvaFdR0ibSqL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-i3vioKGeOA6EMuR4vlIe7w-1; Wed, 21 Jul 2021 22:47:19 -0400
X-MC-Unique: i3vioKGeOA6EMuR4vlIe7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E72071005D57;
        Thu, 22 Jul 2021 02:47:17 +0000 (UTC)
Received: from T590 (ovpn-13-66.pek2.redhat.com [10.72.13.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D0BA60C5F;
        Thu, 22 Jul 2021 02:47:12 +0000 (UTC)
Date:   Thu, 22 Jul 2021 10:47:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/8] block: grab a device model reference in
 blkdev_get_no_open
Message-ID: <YPjcLDXYKbN1yl22@T590>
References: <20210721153523.103818-1-hch@lst.de>
 <20210721153523.103818-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721153523.103818-4-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 05:35:18PM +0200, Christoph Hellwig wrote:
> Opening a block device needs to ensure it is fully present instead of
> just the allocated memory.  Switch from an inode reference as obtained
> by bdget to a full device model reference.
> 
> In fact we should not use inode references for anything in the block
> layer.  There are three users left, two can be trivially removed
> and the third (xen-blkfront) is a complete mess that needs more
> attention.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/block_dev.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9ef4f1fc2cb0..24a6970f3623 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1342,9 +1342,16 @@ struct block_device *blkdev_get_no_open(dev_t dev)
>  		goto bdput;
>  	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
>  		goto put_disk;
> -	if (!try_module_get(bdev->bd_disk->fops->owner))
> +	if (!try_module_get(disk->fops->owner))
>  		goto put_disk;
> +
> +	/* switch to a device model reference instead of the inode one: */
> +	if (!kobject_get_unless_zero(&bdev->bd_device.kobj))

If bdev->bd_device.kobj is grabbed in every open, getting disk reference might
be moved into add_partition, and drop it in part_release(). Then we can avoid
extra disk reference in open/close().

Not mention two disk references are actually grabbed in case of opening disk.

Thanks,
Ming

