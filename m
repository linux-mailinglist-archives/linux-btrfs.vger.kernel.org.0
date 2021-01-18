Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D192FAD8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 23:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbhARWt2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 17:49:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:41008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732440AbhARWtY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 17:49:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3DF2AC63;
        Mon, 18 Jan 2021 22:48:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78EB6DA7CF; Mon, 18 Jan 2021 23:46:47 +0100 (CET)
Date:   Mon, 18 Jan 2021 23:46:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4 03/18] btrfs: introduce the skeleton of btrfs_subpage
 structure
Message-ID: <20210118224647.GK6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116071533.105780-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 16, 2021 at 03:15:18PM +0800, Qu Wenruo wrote:
> For btrfs subpage support, we need a structure to record extra info for
> the status of each sectors of a page.
> 
> This patch will introduce the skeleton structure for future btrfs
> subpage support.
> All subpage related code would go to subpage.[ch] to avoid populating
> the existing code base.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/Makefile  |  3 ++-
>  fs/btrfs/subpage.c | 39 +++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/subpage.h | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+), 1 deletion(-)
>  create mode 100644 fs/btrfs/subpage.c
>  create mode 100644 fs/btrfs/subpage.h
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 9f1b1a88e317..942562e11456 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -11,7 +11,8 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>  	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
>  	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
>  	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
> -	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o
> +	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
> +	   subpage.o
>  
>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> new file mode 100644
> index 000000000000..c6ab32db3995
> --- /dev/null
> +++ b/fs/btrfs/subpage.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "subpage.h"
> +
> +int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page)
> +{
> +	struct btrfs_subpage *subpage;
> +
> +	/*
> +	 * We have cases like a dummy extent buffer page, which is not
> +	 * mappped and doesn't need to be locked.
> +	 */
> +	if (page->mapping)
> +		ASSERT(PageLocked(page));
> +	/* Either not subpage, or the page already has private attached */
> +	if (fs_info->sectorsize == PAGE_SIZE || PagePrivate(page))
> +		return 0;
> +
> +	subpage = kzalloc(sizeof(*subpage), GFP_NOFS);
> +	if (!subpage)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&subpage->lock);
> +	attach_page_private(page, subpage);
> +	return 0;
> +}
> +
> +void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page)
> +{
> +	struct btrfs_subpage *subpage;
> +
> +	/* Either not subpage, or already detached */
> +	if (fs_info->sectorsize == PAGE_SIZE || !PagePrivate(page))
> +		return;
> +
> +	subpage = (struct btrfs_subpage *)detach_page_private(page);
> +	ASSERT(subpage);
> +	kfree(subpage);
> +}
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> new file mode 100644
> index 000000000000..96f3b226913e
> --- /dev/null
> +++ b/fs/btrfs/subpage.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BTRFS_SUBPAGE_H
> +#define BTRFS_SUBPAGE_H
> +
> +#include <linux/spinlock.h>
> +#include "ctree.h"

So subpage.h would pull the whole ctree.h, that's not very nice. If
anything, the .c could include ctree.h because there are lots of the
common structure and function definitions, but not the .h. This creates
unnecessary include dependencies.

Any pointer type you'd need in structures could be forward declared.

> +
> +/*
> + * Since the maximum page size btrfs is going to support is 64K while the
> + * minimum sectorsize is 4K, this means a u16 bitmap is enough.
> + *
> + * The regular bitmap requires 32 bits as minimal bitmap size, so we can't use
> + * existing bitmap_* helpers here.
> + */
> +#define BTRFS_SUBPAGE_BITMAP_SIZE	16
> +
> +/*
> + * Structure to trace status of each sector inside a page.
> + *
> + * Will be attached to page::private for both data and metadata inodes.
> + */
> +struct btrfs_subpage {
> +	/* Common members for both data and metadata pages */
> +	spinlock_t lock;
> +};
> +
> +int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
> +void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
> +
> +#endif /* BTRFS_SUBPAGE_H */
> -- 
> 2.30.0
