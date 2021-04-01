Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35377351D23
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 20:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhDAS1G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 14:27:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:47176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234482AbhDASNV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 14:13:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA64EB217;
        Thu,  1 Apr 2021 18:13:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 59610DA790; Thu,  1 Apr 2021 20:11:11 +0200 (CEST)
Date:   Thu, 1 Apr 2021 20:11:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 05/13] btrfs: introduce helpers for subpage dirty
 status
Message-ID: <20210401181111.GC7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210325071445.90896-6-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325071445.90896-6-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 25, 2021 at 03:14:37PM +0800, Qu Wenruo wrote:
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -20,6 +20,7 @@ struct btrfs_subpage {
>  	spinlock_t lock;
>  	u16 uptodate_bitmap;
>  	u16 error_bitmap;
> +	u16 dirty_bitmap;
>  	union {
>  		/*
>  		 * Structures only used by metadata
> @@ -87,5 +88,19 @@ bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
>  
>  DECLARE_BTRFS_SUBPAGE_OPS(uptodate);
>  DECLARE_BTRFS_SUBPAGE_OPS(error);
> +DECLARE_BTRFS_SUBPAGE_OPS(dirty);
> +
> +/*
> + * Extra clear_and_test function for subpage dirty bitmap.
> + *
> + * Return true if we're the last bits in the dirty_bitmap and clear the
> + * dirty_bitmap.
> + * Return false otherwise.
> + *
> + * NOTE: Callers should manually clear page dirty for true case, as we have
> + * extra handling for tree blocks.
> + */

I've moved the function comment to subpage.c

> +bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
> +		struct page *page, u64 start, u32 len);
>  
>  #endif
> -- 
> 2.30.1
