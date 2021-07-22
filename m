Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0D63D1B97
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 04:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhGVBZA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 21:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229932AbhGVBY7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 21:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626919534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E+YMc/wxbNi5MWP7hujgK9VTZ4gXb9QxZrNQFu14HLQ=;
        b=J21il5HtCkrQjM9B5Fd2vrC7SM5RwLU1nw37UINNkfR7Panp1UYxcMC7okqPdVGDqtckyn
        aPvm2sexAygBwjC+2xV7fbJ+jQ5FF+u4Drp3a4TJUlSYQPd+grEF09XG+XPDxHpwL3QIx7
        fsO08V2rWYaSH48b4eCjnXHJ3EtMG7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-PlLkKXRpMR-pK_SDFnb5Kw-1; Wed, 21 Jul 2021 22:05:33 -0400
X-MC-Unique: PlLkKXRpMR-pK_SDFnb5Kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23EBB107ACF5;
        Thu, 22 Jul 2021 02:05:32 +0000 (UTC)
Received: from T590 (ovpn-13-66.pek2.redhat.com [10.72.13.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BAA46091B;
        Thu, 22 Jul 2021 02:05:24 +0000 (UTC)
Date:   Thu, 22 Jul 2021 10:05:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/8] block: delay freeing the gendisk
Message-ID: <YPjSX0aPvP9oBwo1@T590>
References: <20210721153523.103818-1-hch@lst.de>
 <20210721153523.103818-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721153523.103818-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 05:35:16PM +0200, Christoph Hellwig wrote:
> blkdev_get_no_open acquires a reference to the block_device through
> the block device inode and then tries to acquire a device model
> reference to the gendisk.  But at this point the disk migh already
> be freed (although the race is free).  Fix this by only freeing the
> gendisk from the whole device bdevs ->free_inode callback as well.
> 
> Fixes: 22ae8ce8b892 ("block: simplify bdev/disk lookup in blkdev_get")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

