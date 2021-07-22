Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423293D1FCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhGVHj3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 03:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230499AbhGVHj2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 03:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626942003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJx9/ClR3r0S8KdItX7u51V0cYMjKw3xJMAyTzm0bzQ=;
        b=Kyuizz7eC01FOc1YbEvQvuQJqNxKkBh1cpBm6/FkE7tXErwXQlGW0hO2mZw6JckhEXNOzD
        vcx8rAQMDbogcS/wPm5ATLt+3rAWsP9qh666RWhuGsC6S6EG++m2hmfQ7887jBSNp/gkcN
        S+U65+ec7Zq69XVKZ6fl0zuU6En/mY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-AsjbECUNOqahM5ouocc35w-1; Thu, 22 Jul 2021 04:19:55 -0400
X-MC-Unique: AsjbECUNOqahM5ouocc35w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35A7D804308;
        Thu, 22 Jul 2021 08:19:54 +0000 (UTC)
Received: from T590 (ovpn-13-219.pek2.redhat.com [10.72.13.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBB4360C9B;
        Thu, 22 Jul 2021 08:19:46 +0000 (UTC)
Date:   Thu, 22 Jul 2021 16:19:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/9] block: unhash the whole device inode earlier
Message-ID: <YPkqHjNQpgvbUgBr@T590>
References: <20210722075402.983367-1-hch@lst.de>
 <20210722075402.983367-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722075402.983367-4-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 09:53:56AM +0200, Christoph Hellwig wrote:
> Unhash the whole device inode early in del_gendisk.  This allows to
> remove the first GENHD_FL_UP check in the open path as we simply
> won't find a just removed inode.  The second non-racy check after
> taking open_mutex is still kept.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c  | 7 +------
>  fs/block_dev.c | 2 +-
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 298ee78c1bda..716f5ca479ad 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -585,6 +585,7 @@ void del_gendisk(struct gendisk *disk)
>  	disk_del_events(disk);
>  
>  	mutex_lock(&disk->open_mutex);
> +	remove_inode_hash(disk->part0->bd_inode);
>  	disk->flags &= ~GENHD_FL_UP;
>  	blk_drop_partitions(disk);
>  	mutex_unlock(&disk->open_mutex);
> @@ -592,12 +593,6 @@ void del_gendisk(struct gendisk *disk)
>  	fsync_bdev(disk->part0);
>  	__invalidate_device(disk->part0, true);
>  
> -	/*
> -	 * Unhash the bdev inode for this device so that it can't be looked
> -	 * up any more even if openers still hold references to it.
> -	 */
> -	remove_inode_hash(disk->part0->bd_inode);
> -
>  	set_capacity(disk, 0);
>  
>  	if (!(disk->flags & GENHD_FL_HIDDEN)) {
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9ef4f1fc2cb0..932f4034ad66 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1340,7 +1340,7 @@ struct block_device *blkdev_get_no_open(dev_t dev)
>  	disk = bdev->bd_disk;
>  	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj))
>  		goto bdput;
> -	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
> +	if (disk->flags & GENHD_FL_HIDDEN)

But del_gendisk() can be called just between bdget() and checking GENHD_FL_UP.

And not see difference by moving remove_inode_hash() with disk open_mutex held.


Thanks,
Ming

