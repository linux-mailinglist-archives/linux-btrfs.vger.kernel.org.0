Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935353EE7D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 09:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhHQHzk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 03:55:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50632 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbhHQHzj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 03:55:39 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10D7521E1C;
        Tue, 17 Aug 2021 07:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629186906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gtybRWIMxmqyyRlcEUA9AyVxO0u20D/NS5QIOJTjwKo=;
        b=NKVFyaYkHP01180Ym6o8u75bBo3BJH3P5ZunG86l6uVY4IdmLW/90P38BDuwcqHlMC5q0b
        ZK4WuXRU8DiWfIMRGJje7PT4gZffubG7odoexK2UOB+ZjfcADmZQH+/rO8SZtgZ2iB5so6
        5k+lb4RHUMxhNDILCnz9e/Ovpbd0YT8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E10AD13318;
        Tue, 17 Aug 2021 07:55:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ZBplNFlrG2GpcAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 17 Aug 2021 07:55:05 +0000
Subject: Re: [PATCH v2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with
 proper error handling
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210816235540.9475-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <8babcc1b-2456-8632-7b56-f9867d333a0d@suse.com>
Date:   Tue, 17 Aug 2021 10:55:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816235540.9475-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.08.21 г. 2:55, Qu Wenruo wrote:
> There is a BUG_ON() in btrfs_csum_one_bio() to catch code logic error.
> 
> It has indeed caught several bugs during subpage development.
> 
> But the BUG_ON() itself will bring down the whole system which is
> sometimes overkilled.
> 
> Replace it with a WARN() and exit gracefully, so that it won't crash the
> whole system while we can still catch the code logic error.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Re-send as an independent patch
> - Add WARN() to catch the code logic error
> ---
>  fs/btrfs/file-item.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 2673c6ba7a4e..7f58d80a480f 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -665,7 +665,18 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
>  
>  		if (!ordered) {
>  			ordered = btrfs_lookup_ordered_extent(inode, offset);
> -			BUG_ON(!ordered); /* Logic error */
> +			/*
> +			 * The bio range is not covered by any ordered extent,
> +			 * must be a code logic error.
> +			 */
> +			if (unlikely(!ordered)) {
> +				WARN(1, KERN_WARNING
> +		"no ordered extent for root %llu ino %llu offset %llu\n",
> +				     inode->root->root_key.objectid,
> +				     btrfs_ino(inode), offset);
> +				kvfree(sums);
> +				return BLK_STS_IOERR;
> +			}

nit: How about :

if (WARN_ON(!ordered)  {
btrfs_err(foo)
}

That way you get the unlikely(!ordered) 'for free' and the code is
somewhat cleaner IMO.

While at it I also have to say the structure of the inner loop is rather
iffy, because it's really if/else with an implicit 'else'. How about
converting it to https://paste.ubuntu.com/p/kyWsRrkzWq/

>  		}
>  
>  		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,
> 
