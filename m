Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FA23D2464
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhGVMb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 08:31:56 -0400
Received: from verein.lst.de ([213.95.11.211]:34274 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231924AbhGVMbz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 08:31:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1757668D06; Thu, 22 Jul 2021 15:12:28 +0200 (CEST)
Date:   Thu, 22 Jul 2021 15:12:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/9] block: unhash the whole device inode earlier
Message-ID: <20210722131227.GA27213@lst.de>
References: <20210722075402.983367-1-hch@lst.de> <20210722075402.983367-4-hch@lst.de> <YPkqHjNQpgvbUgBr@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPkqHjNQpgvbUgBr@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 04:19:42PM +0800, Ming Lei wrote:
> >  		goto bdput;
> > -	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
> > +	if (disk->flags & GENHD_FL_HIDDEN)
> 
> But del_gendisk() can be called just between bdget() and checking GENHD_FL_UP.
> 
> And not see difference by moving remove_inode_hash() with disk open_mutex held.


The difference is not about having the open_mutex held, but about doing
it earlier.

The only check that matters is the GENHD_FL_UP check in blkdev_get_by_dev.
The earlier check just reduces the amount of work we're doing for a disk
already being delete.  With the early unhash there is no need for that
check as we won't even find the inode for a disk in del_gendisk.  We still
need the non-racy check under the lock, but the patch doesn't touch that
one.

Maybe I need to split this into two patches and improve the commit log.
