Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551843A5FD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 12:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhFNKTD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 06:19:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45900 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhFNKTC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 06:19:02 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BD9A1FD33;
        Mon, 14 Jun 2021 10:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623665819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wVkZRseJCqwcfKVL1n437+jCRaIQ+gB1ySnu1udt+s=;
        b=PyOb2tjh03HRplQzsPeFQm7tqizYB9uwfc6VbbVH4XVQHyAWLITUF23ZjzOZzMpNdxCVJO
        q3082So55kY0F/hI4wlTJ6y1UEXd//qJn5GIybxGyLUlUxelGSDpBeIv2nOtFZ/wB5T3sv
        weu3Jo0wIwR+jLc+rYOOosk0606KDIU=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 138A7118DD;
        Mon, 14 Jun 2021 10:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623665819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wVkZRseJCqwcfKVL1n437+jCRaIQ+gB1ySnu1udt+s=;
        b=PyOb2tjh03HRplQzsPeFQm7tqizYB9uwfc6VbbVH4XVQHyAWLITUF23ZjzOZzMpNdxCVJO
        q3082So55kY0F/hI4wlTJ6y1UEXd//qJn5GIybxGyLUlUxelGSDpBeIv2nOtFZ/wB5T3sv
        weu3Jo0wIwR+jLc+rYOOosk0606KDIU=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id fKllApssx2C8ZgAALh3uQQ
        (envelope-from <nborisov@suse.com>); Mon, 14 Jun 2021 10:16:59 +0000
Subject: Re: [PATCH 3/4] fs: add a filemap_fdatawrite_wbc helper
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1623419155.git.josef@toxicpanda.com>
 <b7ce962335474c7b0e96849cd9fb650b1138cbb3.1623419155.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <83038b23-71df-962c-167f-db0b21b83025@suse.com>
Date:   Mon, 14 Jun 2021 13:16:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b7ce962335474c7b0e96849cd9fb650b1138cbb3.1623419155.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.06.21 г. 16:53, Josef Bacik wrote:
> Btrfs sometimes needs to flush dirty pages on a bunch of dirty inodes in
> order to reclaim metadata reservations.  Unfortunately most helpers in
> this area are too smart for us
> 
> 1) The normal filemap_fdata* helpers only take range and sync modes, and
>    don't give any indication of how much was written, so we can only
>    flush full inodes, which isn't what we want in most cases.
> 2) The normal writeback path requires us to have the s_umount sem held,
>    but we can't unconditionally take it in this path because we could
>    deadlock.
> 3) The normal writeback path also skips inodes with I_SYNC set if we
>    write with WB_SYNC_NONE.  This isn't the behavior we want under heavy
>    ENOSPC pressure, we want to actually make sure the pages are under
>    writeback before returning, and if another thread is in the middle of
>    writing the file we may return before they're under writeback and
>    miss our ordered extents and not properly wait for completion.
> 4) sync_inode() uses the normal writeback path and has the same problem
>    as #3.
> 
> What we really want is to call do_writepages() with our wbc.  This way
> we can make sure that writeback is actually started on the pages, and we
> can control how many pages are written as a whole as we write many
> inodes using the same wbc.  Accomplish this with a new helper that does
> just that so we can use it for our ENOSPC flushing infrastructure.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  include/linux/fs.h |  2 ++
>  mm/filemap.c       | 29 ++++++++++++++++++++++++-----
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c3c88fdb9b2a..aace07f88b73 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2886,6 +2886,8 @@ extern int filemap_fdatawrite_range(struct address_space *mapping,
>  				loff_t start, loff_t end);
>  extern int filemap_check_errors(struct address_space *mapping);
>  extern void __filemap_set_wb_err(struct address_space *mapping, int err);
> +extern int filemap_fdatawrite_wbc(struct address_space *mapping,
> +				  struct writeback_control *wbc);
>  
>  static inline int filemap_write_and_wait(struct address_space *mapping)
>  {
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 66f7e9fdfbc4..0408bc247e71 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -376,6 +376,29 @@ static int filemap_check_and_keep_errors(struct address_space *mapping)
>  		return -ENOSPC;
>  	return 0;
>  }
> +/**
> + * filemap_fdatawrite_wbc - start writeback on mapping dirty pages in range
> + * @mapping:	address space structure to write
> + * @wbc:	the writeback_control controlling the writeout
> + *
> + * This behaves the same way as __filemap_fdatawrite_range, but simply takes the

That's not true, because __filemap_fdatawrite_range will only issue
writeback in case of PAGECACHE_TAG_DIRTY && the inode's bdi having
BDI_CAP_WRITEBACK. So I think those checks should also be moved to
fdatawrite_wbc.

In fact what would be good for readability since we have a bunch of
__filemap_fdatawrite functions is to have each one call your newly
introduced helper and have their body simply setup the correct
writeback_control structure. Alternative right now one has to chase up
to 3-4 levels of (admittedly very short) functions. I.E

filemap_fdatawrite->__filemap_fdatawrite->__filemap_fdatawrite_range->filemap_fdatawrite_wbc

which is somewhat annoying. Instead I propose having

filemap_fdatawrite->filemap_fdatawrite_wbc
filemap_flush->filemap_fdatawrite_wbc etc...


> + * writeback_control as an argument to allow the caller to have more flexibility
> + * over the writeout parameters, and with no checks around whether the mapping
> + * has dirty pages or anything, it simply calls writepages.
> + *
> + * Return: %0 on success, negative error code otherwise.
> + */
> +int filemap_fdatawrite_wbc(struct address_space *mapping,
> +			   struct writeback_control *wbc)
> +{
> +	int ret;
> +
> +	wbc_attach_fdatawrite_inode(wbc, mapping->host);
> +	ret = do_writepages(mapping, wbc);
> +	wbc_detach_inode(wbc);
> +	return ret;
> +}
> +EXPORT_SYMBOL(filemap_fdatawrite_wbc);
>  
>  /**
>   * __filemap_fdatawrite_range - start writeback on mapping dirty pages in range
> @@ -397,7 +420,6 @@ static int filemap_check_and_keep_errors(struct address_space *mapping)
>  int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
>  				loff_t end, int sync_mode)
>  {
> -	int ret;
>  	struct writeback_control wbc = {
>  		.sync_mode = sync_mode,
>  		.nr_to_write = LONG_MAX,
> @@ -409,10 +431,7 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
>  	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
>  		return 0;
>  
> -	wbc_attach_fdatawrite_inode(&wbc, mapping->host);
> -	ret = do_writepages(mapping, &wbc);
> -	wbc_detach_inode(&wbc);
> -	return ret;
> +	return filemap_fdatawrite_wbc(mapping, &wbc);
>  }
>  
>  static inline int __filemap_fdatawrite(struct address_space *mapping,
> 
