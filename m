Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AAC40B532
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 18:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhINQrN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 12:47:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57796 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhINQrN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 12:47:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 36F1F2212E;
        Tue, 14 Sep 2021 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631637955;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/YTAK7nOkBeBOzoLXJ0YIU3zuxbZ4Hw9p/8TJGsT0+c=;
        b=IBJoyx1kAyQ/l/z9bCteuJPLsKVEllkMVaYlIGdaSZvG2EsN7bfDUQhQoQcrpRicANii9A
        DmdiGtWiZym7UMLJMQ9eaCErjrqqMbOfLsPNZbIYBHmSQosxxo4rEt48U5XacwphlOGj+s
        442AOQx8KrnfA1maGc7msI8aofY/SxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631637955;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/YTAK7nOkBeBOzoLXJ0YIU3zuxbZ4Hw9p/8TJGsT0+c=;
        b=FB5wlTn7lLh5iiUe225oKPThv7zZus4/ygwV0uTMLSRN6XgHvlDnq7PLolXJgXhCyeAGS7
        1RGxV856+egNKgAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 30912A3B9F;
        Tue, 14 Sep 2021 16:45:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E72CFDA781; Tue, 14 Sep 2021 18:45:46 +0200 (CEST)
Date:   Tue, 14 Sep 2021 18:45:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] btrfs: remove btrfs_bio_alloc() helper
Message-ID: <20210914164546.GG9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210914012543.12746-1-wqu@suse.com>
 <20210914012543.12746-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914012543.12746-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 14, 2021 at 09:25:42AM +0800, Qu Wenruo wrote:
>  			comp_bio->bi_end_io = end_compressed_bio_read;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1aed03ef5f49..5ef7c506aee6 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3121,16 +3121,19 @@ static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
>  }
>  
>  /*
> - * The following helpers allocate a bio. As it's backed by a bioset, it'll
> - * never fail.

This note should stay, it's not obvious why we don't need to handle the
allocation failure.

> We're returning a bio right now but you can call btrfs_io_bio
> - * for the appropriate container_of magic
> + * Allocate a btrfs_io_bio, with @nr_iovecs as maxinum iovecs.

                                                  maximum

> + *
> + * If @nr_iovecs is 0, it will use BIO_MAX_VECS as @nr_iovces instead.
> + * This behavior is to provide a fail-safe default value.
>   */
> -struct bio *btrfs_bio_alloc(u64 first_byte)
> +struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
>  {
>  	struct bio *bio;
>  
> -	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &btrfs_bioset);
> -	bio->bi_iter.bi_sector = first_byte >> 9;
> +	ASSERT(nr_iovecs <= BIO_MAX_VECS);
> +	if (nr_iovecs == 0)
> +		nr_iovecs = BIO_MAX_VECS;
> +	bio = bio_alloc_bioset(GFP_NOFS, nr_iovecs, &btrfs_bioset);
>  	btrfs_io_bio_init(btrfs_io_bio(bio));
>  	return bio;
>  }
