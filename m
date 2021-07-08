Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC93C15A2
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 17:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhGHPFn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 11:05:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39898 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHPFm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 11:05:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E82C6223A2;
        Thu,  8 Jul 2021 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625756579;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s7svOdl1dyaQudT56UEzPVpdl7IHV8NCKI9xBqMlKwk=;
        b=h8Lbh8TCGl6QsYXT8QBA1V4OooH5EO3rRyHlK+pEhpyMMaIIvQxHk1f9Ghm1r5ygxeEKMt
        mIyCSdNOufgANpIQRdQ+1hoT2bqpn9FB4V3Gk1k5oCBIiWS0HQGCQVx8Mt4zUa/wqnR7Zu
        jje1/5pT720Hu8SOS9HIpq4yrQVHeeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625756579;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s7svOdl1dyaQudT56UEzPVpdl7IHV8NCKI9xBqMlKwk=;
        b=7RdbX1wQJhm3CcuVoeaOHzGc6cAtVR/I9cgm9biIDFYz+LgqvGyobbZcEyb1Jx40sDbViT
        HzuX4IpzmlKxrDCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DFE3AA3B88;
        Thu,  8 Jul 2021 15:02:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AAE02DAF7A; Thu,  8 Jul 2021 17:00:25 +0200 (CEST)
Date:   Thu, 8 Jul 2021 17:00:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 2/3] btrfs: fix argument type of btrfs_bio_clone_partial()
Message-ID: <20210708150025.GE2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210708131057.259327-1-naohiro.aota@wdc.com>
 <20210708131057.259327-3-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708131057.259327-3-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 08, 2021 at 10:10:56PM +0900, Naohiro Aota wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> The offset and can never be negative use unsigned int instead of int type
> for them.
> 
> Tested-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  fs/btrfs/extent_io.c | 3 ++-
>  fs/btrfs/extent_io.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1f947e24091a..082f135bb3de 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3153,7 +3153,8 @@ struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
>  	return bio;
>  }
>  
> -struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
> +struct bio *btrfs_bio_clone_partial(struct bio *orig, unsigned int offset,
> +				    unsigned int size)
>  {
>  	struct bio *bio;
>  	struct btrfs_io_bio *btrfs_bio;
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 62027f551b44..f78b365b56cf 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -280,7 +280,8 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
>  struct bio *btrfs_bio_alloc(u64 first_byte);
>  struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
>  struct bio *btrfs_bio_clone(struct bio *bio);
> -struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size);
> +struct bio *btrfs_bio_clone_partial(struct bio *orig, unsigned int offset,
> +				    unsigned int size);

This is passed to bio_trim that you change to take sector_t, should this
be the same?

>  
>  int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
>  		      u64 length, u64 logical, struct page *page,
> -- 
> 2.32.0
