Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40FB3C14BB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhGHN74 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 09:59:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58760 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhGHN74 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 09:59:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 439C32226F;
        Thu,  8 Jul 2021 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625752633;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBopWsalYr8uuXUviHdUzLNft6gtAlhMYkdCJFgk5Y8=;
        b=pcEASNZE7G5UZWlH6icFFmeSUhXTPPnyEaHwa8XJCiUNNOjk0AsDttDJ7HpIVccTkUCObZ
        f/IL1jiEhkJLdV+RliaptDQCIQpZkd79pr82gUtRiHDpml2f8hxk0Lct/Qdw/K8Qkmzgdg
        dfT1WxMSoEXrFVjFXrI+aFp45hWAWxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625752633;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBopWsalYr8uuXUviHdUzLNft6gtAlhMYkdCJFgk5Y8=;
        b=ppuOYMYu1I0tANCEp2VO0msrX329XX8ktufPZtdGcEIV3TZbooomux/UmWNnKg2rBWWjaY
        oDeNJiWIxs6HU6Dg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 14694A3BA0;
        Thu,  8 Jul 2021 13:57:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE2F9DAF79; Thu,  8 Jul 2021 15:54:38 +0200 (CEST)
Date:   Thu, 8 Jul 2021 15:54:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 3/3] btrfs: drop unnecessary ASSERT from
 btrfs_submit_direct()
Message-ID: <20210708135438.GA2610@twin.jikos.cz>
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
>  	u64 logical;
>  	int ret;
>  	blk_status_t status;
> @@ -8255,9 +8255,13 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
>  			status = errno_to_blk_status(ret);
>  			goto out_err_em;
>  		}
> -		ASSERT(geom.len <= INT_MAX);
>  
> -		clone_len = min_t(int, submit_len, geom.len);
> +		/*
> +		 * min()'s result is always capped by bio.bi_iter.bi_size
> +		 * which is unsigned int. So the implicit casting it to
> +		 * unsigned int is safe.
> +		 */
> +		clone_len = min(submit_len, geom.len);

I'd rather rely on explicit casts and asserts than a comment stating
what should happen. submit_len ang geom.len are both u64 and cast to u32
clone_len.

I think submit_len should be u32 too (to copy the bio.bi_size) to match
the types used for the purpose and also clone_len.
