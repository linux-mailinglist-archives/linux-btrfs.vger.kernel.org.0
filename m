Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A6531065E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 09:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhBEIHS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 03:07:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:47774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231526AbhBEIGz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 03:06:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612512368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=H80M80adGynsn62BUi0i4xZOgnqkAvTklc959wEWSUg=;
        b=thHvCgCz+xj7J6Gw4FTUzBDnrs3Ux0f8hZA1y7D2JDxd8qL8IbOr9kwHXgakUgscrYXffy
        5vGGHqGUBuKw3Rd5wCvyvY6U8FiZiMdHbH2FE8gXOewqka3kwZEJNUK5rNDLRJuu65woIT
        3oHnlIGrOnb7/xelWdlhvLGhetRFRFI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92CF0B05C;
        Fri,  5 Feb 2021 08:06:08 +0000 (UTC)
Subject: Re: [PATCH 2/5] btrfs: initial fsverity support
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Eric Biggers <ebiggers@kernel.org>
References: <cover.1612475783.git.boris@bur.io>
 <88389022bd9f264f215c9d85fe48214190402fd6.1612475783.git.boris@bur.io>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b3e49ee9-2910-7971-9ba7-54207625078d@suse.com>
Date:   Fri, 5 Feb 2021 10:06:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <88389022bd9f264f215c9d85fe48214190402fd6.1612475783.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.02.21 г. 1:21 ч., Boris Burkov wrote:
> From: Chris Mason <clm@fb.com>
> 
> Add support for fsverity in btrfs. To support the generic interface in
> fs/verity, we add two new item types in the fs tree for inodes with
> verity enabled. One stores the per-file verity descriptor and the other
> stores the Merkle tree data itself.
> 
> Verity checking is done at the end of IOs to ensure each page is checked
> before it is marked uptodate.
> 
> Verity relies on PageChecked for the Merkle tree data itself to avoid
> re-walking up shared paths in the tree. For this reason, we need to
> cache the Merkle tree data. Since the file is immutable after verity is
> turned on, we can cache it at an index past EOF.
> 
> Use the new inode compat_flags to store verity on the inode item, so
> that we can enable verity on a file, then rollback to an older kernel
> and still mount the file system and read the file.
> 
> Signed-off-by: Chris Mason <clm@fb.com>
> ---
>  fs/btrfs/Makefile               |   1 +
>  fs/btrfs/btrfs_inode.h          |   1 +
>  fs/btrfs/ctree.h                |  12 +-
>  fs/btrfs/extent_io.c            |   5 +-
>  fs/btrfs/file.c                 |   6 +
>  fs/btrfs/inode.c                |  28 +-
>  fs/btrfs/ioctl.c                |  14 +-
>  fs/btrfs/super.c                |   1 +
>  fs/btrfs/verity.c               | 527 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/btrfs_tree.h |   8 +
>  10 files changed, 587 insertions(+), 16 deletions(-)
>  create mode 100644 fs/btrfs/verity.c
> 

<snip>

> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> new file mode 100644
> index 000000000000..6f3dbaee81b7
> --- /dev/null
> +++ b/fs/btrfs/verity.c
> @@ -0,0 +1,527 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Facebook.  All rights reserved.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/slab.h>
> +#include <linux/rwsem.h>
> +#include <linux/xattr.h>
> +#include <linux/security.h>
> +#include <linux/posix_acl_xattr.h>
> +#include <linux/iversion.h>
> +#include <linux/fsverity.h>
> +#include <linux/sched/mm.h>
> +#include "ctree.h"
> +#include "btrfs_inode.h"
> +#include "transaction.h"
> +#include "disk-io.h"
> +#include "locking.h"
> +
> +/*
> + * Just like ext4, we cache the merkle tree in pages after EOF in the page
> + * cache.  Unlike ext4, we're storing these in dedicated btree items and
> + * not just shoving them after EOF in the file.  This means we'll need to
> + * do extra work to encrypt them once encryption is supported in btrfs,
> + * but btrfs has a lot of careful code around i_size and it seems better
> + * to make a new key type than try and adjust all of our expectations
> + * for i_size.
> + *
> + * fs verity items are stored under two different key types on disk.
> + *
> + * The descriptor items:
> + * [ inode objectid, BTRFS_VERITY_DESC_ITEM_KEY, offset ]
> + *
> + * These start at offset 0 and hold the fs verity descriptor.  They are opaque
> + * to btrfs, we just read and write them as a blob for the higher level
> + * verity code.  The most common size for this is 256 bytes.
> + *
> + * The merkle tree items:
> + * [ inode objectid, BTRFS_VERITY_MERKLE_ITEM_KEY, offset ]
> + *
> + * These also start at offset 0, and correspond to the merkle tree bytes.
> + * So when fsverity asks for page 0 of the merkle tree, we pull up one page
> + * starting at offset 0 for this key type.  These are also opaque to btrfs,
> + * we're blindly storing whatever fsverity sends down.
> + *
> + * This file is just reading and writing the various items whenever
> + * fsverity needs us to.
> + */

The description of on-disk items should ideally be documented in
https://github.com/btrfs/btrfs-dev-docs/blob/master/tree-items.txt

> +
> +/*
> + * drop all the items for this inode with this key_type.  Before
> + * doing a verity enable we cleanup any existing verity items.
> + *
> + * This is also used to clean up if a verity enable failed half way
> + * through
> + */
> +static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)
> +{

You should ideally be using btrfs_truncate_inode_items as it also
implements throttling policies and keeps everything in one place. If for
any reason that interface is not sufficient I'd rather see it refactored
and broken down in smaller pieces than just copying stuff around, this
just increments the maintenance burden.

<snip>

> +
> +/*
> + * helper function to insert a single item.  Returns zero if all went
> + * well
> + */

Also given that we are aiming at improving the overall state of the code
please document each parameter properly. Also the name is somewhat
terse. For information about the the preferred style please refer to

https://btrfs.wiki.kernel.org/index.php/Development_notes#Coding_style_preferences
and search for "Comments:"

> +static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
> +			   const char *src, u64 len)

This function should be moved to inode-item.c as it seems generic
enough. SOmething like write_inode_generic_bytes or something like that.

<snip>

> +
> +/*
> + * helper function to read items from the btree.  This returns the number
> + * of bytes read or < 0 for errors.  We can return short reads if the
> + * items don't exist on disk or aren't big enough to fill the desired length
> + *
> + * Since we're potentially copying into page cache, passing dest_page
> + * will make us kmap_atomic that page and then use the kmap address instead
> + * of dest.
> + *
> + * pass dest == NULL to find out the size of all the items up to len bytes
> + * we'll just do the tree walk without copying anything
> + */

dittor re documenting function.

> +static ssize_t read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
> +			  char *dest, u64 len, struct page *dest_page)
> +{
> +	struct btrfs_path *path;
> +	struct btrfs_root *root = inode->root;
> +	struct extent_buffer *leaf;
> +	struct btrfs_key key;
> +	u64 item_end;
> +	u64 copy_end;
> +	u64 copied = 0;
> +	u32 copy_offset;
> +	unsigned long copy_bytes;
> +	unsigned long dest_offset = 0;
> +	void *data;
> +	char *kaddr = dest;
> +	int ret;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	if (dest_page)
> +		path->reada = READA_FORWARD;
> +
> +	key.objectid = btrfs_ino(inode);
> +	key.offset = offset;
> +	key.type = key_type;
> +
> +	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	if (ret < 0) {
> +		goto out;
> +	} else if (ret > 0) {
> +		ret = 0;
> +		if (path->slots[0] == 0)
> +			goto out;
> +		path->slots[0]--;
> +	}
> +
> +	while (len > 0) {
> +		leaf = path->nodes[0];
> +		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +
> +		if (key.objectid != btrfs_ino(inode) ||
> +		    key.type != key_type)
> +			break;
> +
> +		item_end = btrfs_item_size_nr(leaf, path->slots[0]) + key.offset;
> +
> +		if (copied > 0) {
> +			/*
> +			 * once we've copied something, we want all of the items
> +			 * to be sequential
> +			 */
> +			if (key.offset != offset)
> +				break;
> +		} else {
> +			/*
> +			 * our initial offset might be in the middle of an
> +			 * item.  Make sure it all makes sense
> +			 */
> +			if (key.offset > offset)
> +				break;
> +			if (item_end <= offset)
> +				break;
> +		}
> +
> +		/* desc = NULL to just sum all the item lengths */

nit: typo - dest instead of desc

<snip>

> +
> +/*
> + * fsverity calls this to ask us to setup the inode for enabling.  We
> + * drop any existing verity items and set the in progress bit
> + */
> +static int btrfs_begin_enable_verity(struct file *filp)
> +{
> +	struct inode *inode = file_inode(filp);
> +	int ret;
> +
> +	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &BTRFS_I(inode)->runtime_flags))
> +		return -EBUSY;
> +
> +	/*
> +	 * ext4 adds the inode to the orphan list here, presumably because the
> +	 * truncate done at orphan processing time will delete partial
> +	 * measurements.  TODO: setup orphans
> +	 */

Any plans when orphan support is going to be implemented?

> +	set_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &BTRFS_I(inode)->runtime_flags);
> +	ret = drop_verity_items(BTRFS_I(inode), BTRFS_VERITY_DESC_ITEM_KEY);
> +	if (ret)
> +		goto err;
> +
> +	ret = drop_verity_items(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY);
> +	if (ret)
> +		goto err;

A slightly higher-level question:

In drop_verity_items you are doing transaction-per-item, so what happens
during a crash and only some of the items being deleted? Is this fine,
presumably that'd make the file unreadable? I.e what should be the
granule of atomicity when dealing with verity items - all or nothing or
per-item is sufficient?

> +
> +	return 0;
> +
> +err:
> +	clear_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &BTRFS_I(inode)->runtime_flags);
> +	return ret;
> +
> +}
> +
> +/*
> + * fsverity calls this when it's done with all of the pages in the file
> + * and all of the merkle items have been inserted.  We write the
> + * descriptor and update the inode in the btree to reflect it's new life
> + * as a verity file
> + */
> +static int btrfs_end_enable_verity(struct file *filp, const void *desc,
> +				  size_t desc_size, u64 merkle_tree_size)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct inode *inode = file_inode(filp);
> +	struct btrfs_root *root = BTRFS_I(inode)->root;
> +	int ret;
> +
> +	if (desc != NULL) {

Redundant check as the descriptor can never be null as per enable_verity.

> +		/* write out the descriptor */
> +		ret = write_key_bytes(BTRFS_I(inode),
> +				      BTRFS_VERITY_DESC_ITEM_KEY, 0,
> +				      desc, desc_size);
> +		if (ret)
> +			goto out;
> +
> +		/* update our inode flags to include fs verity */
> +		trans = btrfs_start_transaction(root, 1);
> +		if (IS_ERR(trans)) {
> +			ret = PTR_ERR(trans);
> +			goto out;
> +		}
> +		BTRFS_I(inode)->compat_flags |= BTRFS_INODE_VERITY;
> +		btrfs_sync_inode_flags_to_i_flags(inode);
> +		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
> +		btrfs_end_transaction(trans);
> +	}
> +
> +out:
> +	if (desc == NULL || ret) {

Just checking for ret is sufficient.

> +		/* If we failed, drop all the verity items */
> +		drop_verity_items(BTRFS_I(inode), BTRFS_VERITY_DESC_ITEM_KEY);
> +		drop_verity_items(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY);
> +	}
> +	clear_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &BTRFS_I(inode)->runtime_flags);
> +	return ret;
> +}
> +
> +/*
> + * fsverity does a two pass setup for reading the descriptor, in the first pass
> + * it calls with buf_size = 0 to query the size of the descriptor,
> + * and then in the second pass it actually reads the descriptor off
> + * disk.
> + */
> +static int btrfs_get_verity_descriptor(struct inode *inode, void *buf,
> +				       size_t buf_size)
> +{
> +	ssize_t ret = 0;
> +
> +	if (!buf_size) {

nit: since buf_size is a numeric size checking for buf_size == 0 is more
readable.

> +		return read_key_bytes(BTRFS_I(inode),
> +				     BTRFS_VERITY_DESC_ITEM_KEY,
> +				     0, NULL, (u64)-1, NULL);
> +	}
> +
> +	ret = read_key_bytes(BTRFS_I(inode),
> +			     BTRFS_VERITY_DESC_ITEM_KEY, 0,
> +			     buf, buf_size, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret != buf_size)
> +		return -EIO;
> +
> +	return buf_size;
> +}
> +
> +/*
> + * reads and caches a merkle tree page.  These are stored in the btree,
> + * but we cache them in the inode's address space after EOF.
> + */
> +static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
> +					       pgoff_t index,
> +					       unsigned long num_ra_pages)
> +{
> +	struct page *p;
> +	u64 start = index << PAGE_SHIFT;
> +	unsigned long mapping_index;
> +	ssize_t ret;
> +	int err;
> +
> +	/*
> +	 * the file is readonly, so i_size can't change here.  We jump
> +	 * some pages past the last page to cache our merkles.  The goal
> +	 * is just to jump past any hugepages that might be mapped in.
> +	 */
> +	mapping_index = (i_size_read(inode) >> PAGE_SHIFT) + 2048 + index;

So what does this magic number 2048 mean, how was it derived? Perhaps
give it a symbolic name either via a local const var or via a define,
something like

#define INODE_VERITY_EOF_OFFSET 2048 or something along those lines.

If the file is RO then why do you need to add such a large offset, it's
not clear what the hugepages issue is.

<snip>
