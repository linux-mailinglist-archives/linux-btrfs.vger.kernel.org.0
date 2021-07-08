Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6644C3C15A9
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 17:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhGHPJD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 11:09:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41968 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHPJB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 11:09:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B88CB21F20;
        Thu,  8 Jul 2021 15:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625756778;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNC4McqW1N+JJw3iWV1XIO3H34DzinunpWM0GQsOtNw=;
        b=0OYrpwPOvnTZHxWpro+F0tpX8NjMuKGNZUToMBXsxG8IXweaiTG6JcJ/rvDQBTIA/3ZgZx
        2mAzqYJ60uviBoMXyh4ucc7IqNDWYSn8QcOwOgOvWTVxKDN4KocaLyzzI/787EkPf5cmhL
        mMSZag/zFriHlW486JeLXhOmaKCzQ0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625756778;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNC4McqW1N+JJw3iWV1XIO3H34DzinunpWM0GQsOtNw=;
        b=bhFj1cZl5ObyJuDqWVIWN4x4JsFGzMa/tvUQAWHaSdlG+1VKqS/X353nLaPWl4GTFCtT55
        i38qf96M9QKzK7CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 87145A3B84;
        Thu,  8 Jul 2021 15:06:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 53063DAF7A; Thu,  8 Jul 2021 17:03:44 +0200 (CEST)
Date:   Thu, 8 Jul 2021 17:03:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 3/3] btrfs: drop unnecessary ASSERT from
 btrfs_submit_direct()
Message-ID: <20210708150344.GF2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210708131057.259327-1-naohiro.aota@wdc.com>
 <20210708131057.259327-4-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708131057.259327-4-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 08, 2021 at 10:10:57PM +0900, Naohiro Aota wrote:
> When on SINGLE block group, btrfs_get_io_geometry() will return "the
> size of the block group - the offset of the logical address within the
> block group" as geom.len. Since we allow up to 8 GB zone size on zoned
> btrfs, we can have up to 8 GB block group, so can have up to 8 GB
> geom.len. With this setup, we easily hit the "ASSERT(geom.len <=
> INT_MAX);".
> 
> The ASSERT looks like to guard btrfs_bio_clone_partial() and bio_trim()
> which both take "int" (now "unsigned int" with the previous patch). So to
> be precise the ASSERT should check if clone_len <= UINT_MAX. But
> actually, clone_len is already capped by bio.bi_iter.bi_size which is
> unsigned int. So the ASSERT is not necessary.
> 
> Drop the ASSERT and properly compare submit_len and geom.len in u64. Then,
> let the implicit casting to convert it to unsigned int.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/inode.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8f60314c36c5..b6cc26dd7919 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8206,8 +8206,8 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
>  	u64 start_sector;
>  	int async_submit = 0;
>  	u64 submit_len;
> -	int clone_offset = 0;
> -	int clone_len;
> +	unsigned int clone_offset = 0;
> +	unsigned int clone_len;

After reading the other patches, clone_offset should be sector_t or u64.
clone_len is fine as u32 as it only gets update from the bio.bi_size,
but later in the code there's

	clone_offset += clone_len;

and clone_offset is passed to btrfs_bio_clone_partial -> bio_trim, that
you've changed to sector_t.
