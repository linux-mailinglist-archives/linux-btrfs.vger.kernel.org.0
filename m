Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F3195AC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 17:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgC0QME (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Mar 2020 12:12:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:51330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbgC0QME (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Mar 2020 12:12:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7812AABF6;
        Fri, 27 Mar 2020 16:12:02 +0000 (UTC)
Date:   Fri, 27 Mar 2020 11:11:58 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/9] btrfs: Use ->iomap_end() instead of btrfs_dio_data
Message-ID: <20200327161158.wuycoyjkcfw24lt4@fiona>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
 <20200326210254.17647-6-rgoldwyn@suse.de>
 <20200327081640.GB24827@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327081640.GB24827@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On  1:16 27/03, Christoph Hellwig wrote:
> On Thu, Mar 26, 2020 at 04:02:50PM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Use iomap->iomap_end() to check for failed or incomplete writes and call
> > __endio_write_update_ordered(). We don't need btrfs_dio_data anymore so
> > remove that. The bonus is we don't abuse current->journal_info anymore.
> > 
> > A new structure btrfs_iomap is used to keep a count of submitted I/O
> > for writes.
> 
> I don't think you need a new structure.  As writes are limited to a
> size_t (aka long) you can just case iomap->private.  That is a little
> ugly, but we can just switch the private field to an union, something
> like the patch below.  If I'm missing a reason why it has to be 64-bit
> even on 32-bit kernels we can also grow the size a little on 32-bit
> kernels, but right now I don't think that is needed unless I'm missing
> something.

This would be an better approach as opposed to allocating and
deallocating. I was trying not to disrupt the iomap code ;)
Yes, 32-bits works just as well.

> 
> ---
> From e496cd3db3e7420050be19c5fe68e4675f5a2abc Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 27 Mar 2020 09:14:34 +0100
> Subject: iomap: turn iomap->private into an union
> 
> Make using the union a little easier for scalar values.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/iomap.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8b09463dae0d..61fea687d93d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -85,7 +85,10 @@ struct iomap {
>  	struct block_device	*bdev;	/* block device for I/O */
>  	struct dax_device	*dax_dev; /* dax_dev for dax operations */
>  	void			*inline_data;
> -	void			*private; /* filesystem private */
> +	union {				/* filesystem private data */
> +		void		*ptr;
> +		uintptr_t	uint;
> +	} private;
>  	const struct iomap_page_ops *page_ops;
>  };
>  


Thanks. Will include this.

-- 
Goldwyn
