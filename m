Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1565946C356
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 20:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbhLGTMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 14:12:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33440 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhLGTL7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 14:11:59 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 09F071FE00;
        Tue,  7 Dec 2021 19:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638904108;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cduJetc6ehyOTdiBfQfGJY5qLmC8KPho1Pe6NdChO5c=;
        b=nGNgT1z2xRFnrSPGebTV2AhzJAkqZze9gZb9Bmn0XsFrKyozKFFXW5n5snjhZ7pUo+nZz3
        Mb67s6tCtlr50Ku+Y9Zd18noFrj/nyDqvqs4VVYEDIlnO8iVoRiEPiyocBHamDi7a9Kw6v
        M61o5TBfA/bHqo4e3ZQsC3juEpSDUmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638904108;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cduJetc6ehyOTdiBfQfGJY5qLmC8KPho1Pe6NdChO5c=;
        b=wE/EHWJ5sbzKwMz6Z+LylnaSxfEhUmQ1R2FTLBkHUGIVEXUrSAm5bS+zT10ZFC4hdgIBM6
        dCLaYulEVTrJ7EDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CB686A3B81;
        Tue,  7 Dec 2021 19:08:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 25B7BDA799; Tue,  7 Dec 2021 20:08:12 +0100 (CET)
Date:   Tue, 7 Dec 2021 20:08:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 1/4] btrfs: zoned: encapsulate inode locking for zoned
 relocation
Message-ID: <20211207190812.GC28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1638886948.git.johannes.thumshirn@wdc.com>
 <b1d1bab106ddc4456224c0bf1c1bfcfaea4844b7.1638886948.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1d1bab106ddc4456224c0bf1c1bfcfaea4844b7.1638886948.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 07, 2021 at 06:28:34AM -0800, Johannes Thumshirn wrote:
> Encapsulate the inode lock needed for serializing the data relocation
> writes on a zoned filesystem into a helper.
> 
> This streamlines the code reading flow and hides special casing for
> zoned filesystems.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent_io.c |  8 ++------
>  fs/btrfs/zoned.h     | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1a67f4b3986b..cc27e6e6d6ce 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5184,8 +5184,6 @@ int extent_writepages(struct address_space *mapping,
>  		      struct writeback_control *wbc)
>  {
>  	struct inode *inode = mapping->host;
> -	const bool data_reloc = btrfs_is_data_reloc_root(BTRFS_I(inode)->root);
> -	const bool zoned = btrfs_is_zoned(BTRFS_I(inode)->root->fs_info);
>  	int ret = 0;
>  	struct extent_page_data epd = {
>  		.bio_ctrl = { 0 },
> @@ -5197,11 +5195,9 @@ int extent_writepages(struct address_space *mapping,
>  	 * Allow only a single thread to do the reloc work in zoned mode to
>  	 * protect the write pointer updates.
>  	 */
> -	if (data_reloc && zoned)
> -		btrfs_inode_lock(inode, 0);
> +	btrfs_zoned_data_reloc_lock(inode);
>  	ret = extent_write_cache_pages(mapping, wbc, &epd);
> -	if (data_reloc && zoned)
> -		btrfs_inode_unlock(inode, 0);
> +	btrfs_zoned_data_reloc_unlock(inode);
>  	ASSERT(ret <= 0);
>  	if (ret < 0) {
>  		end_write_bio(&epd, ret);
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 4344f4818389..e3eaf03a3422 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -8,6 +8,7 @@
>  #include "volumes.h"
>  #include "disk-io.h"
>  #include "block-group.h"
> +#include "btrfs_inode.h"
>  
>  /*
>   * Block groups with more than this value (percents) of unusable space will be
> @@ -354,4 +355,20 @@ static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
>  	spin_unlock(&fs_info->treelog_bg_lock);
>  }
>  
> +static inline void btrfs_zoned_data_reloc_lock(struct inode *inode)

All internal API should use struct btrfs_inode, applied with the
following diff:

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5195,9 +5195,9 @@ int extent_writepages(struct address_space *mapping,
         * Allow only a single thread to do the reloc work in zoned mode to
         * protect the write pointer updates.
         */
-       btrfs_zoned_data_reloc_lock(inode);
+       btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
        ret = extent_write_cache_pages(mapping, wbc, &epd);
-       btrfs_zoned_data_reloc_unlock(inode);
+       btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
        ASSERT(ret <= 0);
        if (ret < 0) {
                end_write_bio(&epd, ret);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index e3eaf03a3422..a7b4cd6dd9f4 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -355,20 +355,20 @@ static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
        spin_unlock(&fs_info->treelog_bg_lock);
 }
 
-static inline void btrfs_zoned_data_reloc_lock(struct inode *inode)
+static inline void btrfs_zoned_data_reloc_lock(struct btrfs_inode *inode)
 {
-       struct btrfs_root *root = BTRFS_I(inode)->root;
+       struct btrfs_root *root = inode->root;
 
        if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
-               btrfs_inode_lock(inode, 0);
+               btrfs_inode_lock(&inode->vfs_inode, 0);
 }
 
-static inline void btrfs_zoned_data_reloc_unlock(struct inode *inode)
+static inline void btrfs_zoned_data_reloc_unlock(struct btrfs_inode *inode)
 {
-       struct btrfs_root *root = BTRFS_I(inode)->root;
+       struct btrfs_root *root = inode->root;
 
        if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
-               btrfs_inode_unlock(inode, 0);
+               btrfs_inode_unlock(&inode->vfs_inode, 0);
 }
 
 #endif
