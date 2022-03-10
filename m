Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59CD4D51E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 20:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242855AbiCJTSz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 14:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343520AbiCJTSt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 14:18:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA85D4EA3D
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 11:17:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5B15821122;
        Thu, 10 Mar 2022 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646939865;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qIhlMC7nMj+2ccbL6AvU0v/LSULDtHZgGTtjwi7Ko7Y=;
        b=hIIHx1KL825cM/OheVdicr1rYI8dIC5GAN2YOHxiyzvC5lhh/pRMazG8XBgTr/aKI1vAZN
        VXVwJyqfl9aMVbIqrr11YuSZEqRyIgyGrHvMlAb1L6zjL5J5RJug0GF25hEA1vWkX3auet
        mq++mfDu47QFIHrSA64kNb1byKKP728=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646939865;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qIhlMC7nMj+2ccbL6AvU0v/LSULDtHZgGTtjwi7Ko7Y=;
        b=90O46RGHc9PSQe96TEwVlhhAaLYSsrBBkOQUVqjxfQKZHhwngfAcAbohj7VXga6OSohsnb
        dlIKWpzDScEZ8WBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 52637A3B81;
        Thu, 10 Mar 2022 19:17:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 187C1DA7E1; Thu, 10 Mar 2022 20:13:49 +0100 (CET)
Date:   Thu, 10 Mar 2022 20:13:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/3] btrfs: make nodesize >= PAGE_SIZE case to reuse
 the non-subpage routine
Message-ID: <20220310191348.GC12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220113052210.23614-1-wqu@suse.com>
 <20220113052210.23614-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113052210.23614-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 13, 2022 at 01:22:09PM +0800, Qu Wenruo wrote:
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -4,6 +4,7 @@
>  #define BTRFS_SUBPAGE_H
>  
>  #include <linux/spinlock.h>
> +#include "btrfs_inode.h"
>  
>  /*
>   * Extra info for subpapge bitmap.
> @@ -74,6 +75,30 @@ enum btrfs_subpage_type {
>  	BTRFS_SUBPAGE_DATA,
>  };
>  
> +static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
> +				    struct page *page)

This is static inline and increases the size of the module by 3K, it
does not need to be inline as it's not in any perf critical code.

> +{
> +	if (fs_info->sectorsize >= PAGE_SIZE)
> +		return false;

Eventually the function can be split into two, making the check above
inline and the rest a normal function.

> +
> +	/*
> +	 * Only data pages (either through DIO or compression) can have no
> +	 * mapping. And if page->mapping->host is data inode, it's subpage.
> +	 * As we have ruled our sectorsize >= PAGE_SIZE case already.
> +	 */
> +	if (!page->mapping || !page->mapping->host ||
> +	    is_data_inode(page->mapping->host))
> +		return true;
> +
> +	/*
> +	 * Now the only remaining case is metadata, which we only go subpage
> +	 * routine if nodesize < PAGE_SIZE.
> +	 */
> +	if (fs_info->nodesize < PAGE_SIZE)
> +		return true;
> +	return false;
> +}
> +
>  void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sectorsize);
>  int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
>  			 struct page *page, enum btrfs_subpage_type type);
