Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A82315620
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 19:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhBIShi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 13:37:38 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58485 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233336AbhBISW7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 13:22:59 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 1F7FCB1E;
        Tue,  9 Feb 2021 12:57:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 09 Feb 2021 12:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=h
        Uw+IQ1SvA7G+VWOcC963YW6YgVElpXyK6K3rG2GtBc=; b=mzIqr78Gfw0/WIWjK
        oz2xqqscS8wqTQ4J9Tcx7ACUPGVR379DtWgkQ30iDCo+duvQ2xo4VslGzxhkYmB6
        ABFDh3HAmT31X9USxCcnrv94OiPKssMhwtdJGp1gAM0QeJGfgVgWMz4mjHqW5zRo
        fT393N69MB8xKs2685QK6jOxpYdqkAHEETZTf3pE9rnqm3aEBLTZ56CKAzUTeKKT
        zuUgzTCXcgeJ1eL4laFQLRDVZPqmai2MYAk1UB8gNG2jbQluHOTvoWJWLG+ng/ho
        crV0tT0NoIUtXUvw6BfmZM6DSp4l6TF3KUVn19Ttc45wrOuklP7iloQ2C+L/ugoQ
        +PQXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=hUw+IQ1SvA7G+VWOcC963YW6YgVElpXyK6K3rG2Gt
        Bc=; b=Wix08oPtQ/iDYZa47od2OaUhAvfoBx0LyXutuPIMtlIZ2KZGI7jJqbzcA
        r6UIXDOnGJK2AR/7/Kjx0nwk9DmtCX2JErmrMu4TzFx1Xe37L6Ujd/ygxM0sSmQ4
        xUeuYcaC1dVMhvFACPRl7nUElT3khqckyXwpWiZGmbBU1iCdwAO6MdVVqRepTrTw
        FyjMXPAVO/jekxMkzB6/cweYJfqTarxb/83K2DdnYCqAe+WshXtb/G3x6G5JYjMZ
        3W+2LnAvQx/Kf1wgQcqssh/FxnLR54c1bd33UI2yB7ERV3lD3SEWM5lE+edxRlP8
        mZtYoqPNwOaWX+iOHkP6dt5DoUOTw==
X-ME-Sender: <xms:-cwiYLSjWpdPzJ_gdwrlHnlSRSjjdRcwh3nUMqOYN2RI5_8a3D-FyA>
    <xme:-cwiYMyHkSoBnO-8USVgTjedxJRrHAFSQgy55_la5FiG7tc2QnfVz0SEWR1Bjemfw
    Mhp_qyMxC1kr17T5Qs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheehgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjggfsehtkeertddtreejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epjeethffhuefftdehieeiffetueellefflefgteevvdevjeehgeevfeegtdfgffdtnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppeduie
    efrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:-cwiYA1yaO-b-AZE0MiKqxwYdMa_o2e_h7G-oFK-zHf5KMCmJyABxw>
    <xmx:-cwiYLCpz3R2R-nEfpGM4HaTRQpJW3pQZJrkqQju8sWPiuyrEZ7_lA>
    <xmx:-cwiYEgkY5nGw8Uu7thpjZHcKTEXA5sIGxkSaDXboO_nXgeesMkD7g>
    <xmx:-cwiYAY78PoJLHzgZJ1xaXV7ekBItGXI1iqCJeKruOTOyI9Frqdl7A>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id A57401080063;
        Tue,  9 Feb 2021 12:57:12 -0500 (EST)
Date:   Tue, 9 Feb 2021 09:57:10 -0800
From:   Boris Burkov <boris@bur.io>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 2/5] btrfs: initial fsverity support
Message-ID: <20210209175710.GA2670499@devbig008.ftw2.facebook.com>
References: <cover.1612475783.git.boris@bur.io>
 <88389022bd9f264f215c9d85fe48214190402fd6.1612475783.git.boris@bur.io>
 <b3e49ee9-2910-7971-9ba7-54207625078d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3e49ee9-2910-7971-9ba7-54207625078d@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 05, 2021 at 10:06:07AM +0200, Nikolay Borisov wrote:
> 
> 
> On 5.02.21 г. 1:21 ч., Boris Burkov wrote:
> > From: Chris Mason <clm@fb.com>
> > 
> > Add support for fsverity in btrfs. To support the generic interface in
> > fs/verity, we add two new item types in the fs tree for inodes with
> > verity enabled. One stores the per-file verity descriptor and the other
> > stores the Merkle tree data itself.
> > 
> > Verity checking is done at the end of IOs to ensure each page is checked
> > before it is marked uptodate.
> > 
> > Verity relies on PageChecked for the Merkle tree data itself to avoid
> > re-walking up shared paths in the tree. For this reason, we need to
> > cache the Merkle tree data. Since the file is immutable after verity is
> > turned on, we can cache it at an index past EOF.
> > 
> > Use the new inode compat_flags to store verity on the inode item, so
> > that we can enable verity on a file, then rollback to an older kernel
> > and still mount the file system and read the file.
> > 
> > Signed-off-by: Chris Mason <clm@fb.com>
> > ---
> >  fs/btrfs/Makefile               |   1 +
> >  fs/btrfs/btrfs_inode.h          |   1 +
> >  fs/btrfs/ctree.h                |  12 +-
> >  fs/btrfs/extent_io.c            |   5 +-
> >  fs/btrfs/file.c                 |   6 +
> >  fs/btrfs/inode.c                |  28 +-
> >  fs/btrfs/ioctl.c                |  14 +-
> >  fs/btrfs/super.c                |   1 +
> >  fs/btrfs/verity.c               | 527 ++++++++++++++++++++++++++++++++
> >  include/uapi/linux/btrfs_tree.h |   8 +
> >  10 files changed, 587 insertions(+), 16 deletions(-)
> >  create mode 100644 fs/btrfs/verity.c
> > 
> 
> <snip>
> 
> > diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> > new file mode 100644
> > index 000000000000..6f3dbaee81b7
> > --- /dev/null
> > +++ b/fs/btrfs/verity.c
> > @@ -0,0 +1,527 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 Facebook.  All rights reserved.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/fs.h>
> > +#include <linux/slab.h>
> > +#include <linux/rwsem.h>
> > +#include <linux/xattr.h>
> > +#include <linux/security.h>
> > +#include <linux/posix_acl_xattr.h>
> > +#include <linux/iversion.h>
> > +#include <linux/fsverity.h>
> > +#include <linux/sched/mm.h>
> > +#include "ctree.h"
> > +#include "btrfs_inode.h"
> > +#include "transaction.h"
> > +#include "disk-io.h"
> > +#include "locking.h"
> > +
> > +/*
> > + * Just like ext4, we cache the merkle tree in pages after EOF in the page
> > + * cache.  Unlike ext4, we're storing these in dedicated btree items and
> > + * not just shoving them after EOF in the file.  This means we'll need to
> > + * do extra work to encrypt them once encryption is supported in btrfs,
> > + * but btrfs has a lot of careful code around i_size and it seems better
> > + * to make a new key type than try and adjust all of our expectations
> > + * for i_size.
> > + *
> > + * fs verity items are stored under two different key types on disk.
> > + *
> > + * The descriptor items:
> > + * [ inode objectid, BTRFS_VERITY_DESC_ITEM_KEY, offset ]
> > + *
> > + * These start at offset 0 and hold the fs verity descriptor.  They are opaque
> > + * to btrfs, we just read and write them as a blob for the higher level
> > + * verity code.  The most common size for this is 256 bytes.
> > + *
> > + * The merkle tree items:
> > + * [ inode objectid, BTRFS_VERITY_MERKLE_ITEM_KEY, offset ]
> > + *
> > + * These also start at offset 0, and correspond to the merkle tree bytes.
> > + * So when fsverity asks for page 0 of the merkle tree, we pull up one page
> > + * starting at offset 0 for this key type.  These are also opaque to btrfs,
> > + * we're blindly storing whatever fsverity sends down.
> > + *
> > + * This file is just reading and writing the various items whenever
> > + * fsverity needs us to.
> > + */
> 
> The description of on-disk items should ideally be documented in
> https://github.com/btrfs/btrfs-dev-docs/blob/master/tree-items.txt
> 
> > +
> > +/*
> > + * drop all the items for this inode with this key_type.  Before
> > + * doing a verity enable we cleanup any existing verity items.
> > + *
> > + * This is also used to clean up if a verity enable failed half way
> > + * through
> > + */
> > +static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)
> > +{
> 
> You should ideally be using btrfs_truncate_inode_items as it also
> implements throttling policies and keeps everything in one place. If for
> any reason that interface is not sufficient I'd rather see it refactored
> and broken down in smaller pieces than just copying stuff around, this
> just increments the maintenance burden.
> 
> <snip>
> 
> > +
> > +/*
> > + * helper function to insert a single item.  Returns zero if all went
> > + * well
> > + */
> 
> Also given that we are aiming at improving the overall state of the code
> please document each parameter properly. Also the name is somewhat
> terse. For information about the the preferred style please refer to
> 
> https://btrfs.wiki.kernel.org/index.php/Development_notes#Coding_style_preferences
> and search for "Comments:"
> 
> > +static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
> > +			   const char *src, u64 len)
> 
> This function should be moved to inode-item.c as it seems generic
> enough. SOmething like write_inode_generic_bytes or something like that.
> 
> <snip>
> 

I'll definitely improve the comments, thanks for that tip.

As for making it generic, I played with that yesterday and ran into a
couple of snags.

The biggest was that read_key_bytes is written to intelligently handle
the exact three cases verity cares about: dest=NULL for getting the
sizes, dest is a buffer for getting the descriptor, and dest is a dummy
and dest_page is a page for getting the Merkle items.

I am not certain that this is the general pattern we would expect future
customers of this generic read to follow. In fact, Chris already
mentioned wanting to see if we could figure out how to avoid the
"full read to get size" thing.  I tried a few simple refactors to clean
up the interface, but couldn't figure out a really nice way to
optionally do the late kmap_atomic.

With all that said, unless people insist, I think I would skip making
both of these generic, though I do think write_key_bytes is a decent
candidate (though I probably wouldn't make anything about it specific to
inodes either?)

> > +
> > +/*
> > + * helper function to read items from the btree.  This returns the number
> > + * of bytes read or < 0 for errors.  We can return short reads if the
> > + * items don't exist on disk or aren't big enough to fill the desired length
> > + *
> > + * Since we're potentially copying into page cache, passing dest_page
> > + * will make us kmap_atomic that page and then use the kmap address instead
> > + * of dest.
> > + *
> > + * pass dest == NULL to find out the size of all the items up to len bytes
> > + * we'll just do the tree walk without copying anything
> > + */
> 
> dittor re documenting function.
> 
> > +static ssize_t read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
> > +			  char *dest, u64 len, struct page *dest_page)
> > +{
> > +	struct btrfs_path *path;
> > +	struct btrfs_root *root = inode->root;
> > +	struct extent_buffer *leaf;
> > +	struct btrfs_key key;
> > +	u64 item_end;
> > +	u64 copy_end;
> > +	u64 copied = 0;
> > +	u32 copy_offset;
> > +	unsigned long copy_bytes;
> > +	unsigned long dest_offset = 0;
> > +	void *data;
> > +	char *kaddr = dest;
> > +	int ret;
> > +
> > +	path = btrfs_alloc_path();
> > +	if (!path)
> > +		return -ENOMEM;
> > +
> > +	if (dest_page)
> > +		path->reada = READA_FORWARD;
> > +
> > +	key.objectid = btrfs_ino(inode);
> > +	key.offset = offset;
> > +	key.type = key_type;
> > +
> > +	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> > +	if (ret < 0) {
> > +		goto out;
> > +	} else if (ret > 0) {
> > +		ret = 0;
> > +		if (path->slots[0] == 0)
> > +			goto out;
> > +		path->slots[0]--;
> > +	}
> > +
> > +	while (len > 0) {
> > +		leaf = path->nodes[0];
> > +		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> > +
> > +		if (key.objectid != btrfs_ino(inode) ||
> > +		    key.type != key_type)
> > +			break;
> > +
> > +		item_end = btrfs_item_size_nr(leaf, path->slots[0]) + key.offset;
> > +
> > +		if (copied > 0) {
> > +			/*
> > +			 * once we've copied something, we want all of the items
> > +			 * to be sequential
> > +			 */
> > +			if (key.offset != offset)
> > +				break;
> > +		} else {
> > +			/*
> > +			 * our initial offset might be in the middle of an
> > +			 * item.  Make sure it all makes sense
> > +			 */
> > +			if (key.offset > offset)
> > +				break;
> > +			if (item_end <= offset)
> > +				break;
> > +		}
> > +
> > +		/* desc = NULL to just sum all the item lengths */
> 
> nit: typo - dest instead of desc
> 
> <snip>
> 
> > +
> > +/*
> > + * fsverity calls this to ask us to setup the inode for enabling.  We
> > + * drop any existing verity items and set the in progress bit
> > + */
> > +static int btrfs_begin_enable_verity(struct file *filp)
> > +{
> > +	struct inode *inode = file_inode(filp);
> > +	int ret;
> > +
> > +	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &BTRFS_I(inode)->runtime_flags))
> > +		return -EBUSY;
> > +
> > +	/*
> > +	 * ext4 adds the inode to the orphan list here, presumably because the
> > +	 * truncate done at orphan processing time will delete partial
> > +	 * measurements.  TODO: setup orphans
> > +	 */
> 
> Any plans when orphan support is going to be implemented?
> 

I'm going to attempt to do it for V2, thanks for calling it out.

> > +	set_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &BTRFS_I(inode)->runtime_flags);
> > +	ret = drop_verity_items(BTRFS_I(inode), BTRFS_VERITY_DESC_ITEM_KEY);
> > +	if (ret)
> > +		goto err;
> > +
> > +	ret = drop_verity_items(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY);
> > +	if (ret)
> > +		goto err;
> 
> A slightly higher-level question:
> 
> In drop_verity_items you are doing transaction-per-item, so what happens
> during a crash and only some of the items being deleted? Is this fine,
> presumably that'd make the file unreadable? I.e what should be the
> granule of atomicity when dealing with verity items - all or nothing or
> per-item is sufficient?
> 
> > +
> > +	return 0;
> > +
> > +err:
> > +	clear_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &BTRFS_I(inode)->runtime_flags);
> > +	return ret;
> > +
> > +}
> > +
> > +/*
> > + * fsverity calls this when it's done with all of the pages in the file
> > + * and all of the merkle items have been inserted.  We write the
> > + * descriptor and update the inode in the btree to reflect it's new life
> > + * as a verity file
> > + */
> > +static int btrfs_end_enable_verity(struct file *filp, const void *desc,
> > +				  size_t desc_size, u64 merkle_tree_size)
> > +{
> > +	struct btrfs_trans_handle *trans;
> > +	struct inode *inode = file_inode(filp);
> > +	struct btrfs_root *root = BTRFS_I(inode)->root;
> > +	int ret;
> > +
> > +	if (desc != NULL) {
> 
> Redundant check as the descriptor can never be null as per enable_verity.
> 
> > +		/* write out the descriptor */
> > +		ret = write_key_bytes(BTRFS_I(inode),
> > +				      BTRFS_VERITY_DESC_ITEM_KEY, 0,
> > +				      desc, desc_size);
> > +		if (ret)
> > +			goto out;
> > +
> > +		/* update our inode flags to include fs verity */
> > +		trans = btrfs_start_transaction(root, 1);
> > +		if (IS_ERR(trans)) {
> > +			ret = PTR_ERR(trans);
> > +			goto out;
> > +		}
> > +		BTRFS_I(inode)->compat_flags |= BTRFS_INODE_VERITY;
> > +		btrfs_sync_inode_flags_to_i_flags(inode);
> > +		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
> > +		btrfs_end_transaction(trans);
> > +	}
> > +
> > +out:
> > +	if (desc == NULL || ret) {
> 
> Just checking for ret is sufficient.
> 
> > +		/* If we failed, drop all the verity items */
> > +		drop_verity_items(BTRFS_I(inode), BTRFS_VERITY_DESC_ITEM_KEY);
> > +		drop_verity_items(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY);
> > +	}
> > +	clear_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &BTRFS_I(inode)->runtime_flags);
> > +	return ret;
> > +}
> > +
> > +/*
> > + * fsverity does a two pass setup for reading the descriptor, in the first pass
> > + * it calls with buf_size = 0 to query the size of the descriptor,
> > + * and then in the second pass it actually reads the descriptor off
> > + * disk.
> > + */
> > +static int btrfs_get_verity_descriptor(struct inode *inode, void *buf,
> > +				       size_t buf_size)
> > +{
> > +	ssize_t ret = 0;
> > +
> > +	if (!buf_size) {
> 
> nit: since buf_size is a numeric size checking for buf_size == 0 is more
> readable.
> 
> > +		return read_key_bytes(BTRFS_I(inode),
> > +				     BTRFS_VERITY_DESC_ITEM_KEY,
> > +				     0, NULL, (u64)-1, NULL);
> > +	}
> > +
> > +	ret = read_key_bytes(BTRFS_I(inode),
> > +			     BTRFS_VERITY_DESC_ITEM_KEY, 0,
> > +			     buf, buf_size, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (ret != buf_size)
> > +		return -EIO;
> > +
> > +	return buf_size;
> > +}
> > +
> > +/*
> > + * reads and caches a merkle tree page.  These are stored in the btree,
> > + * but we cache them in the inode's address space after EOF.
> > + */
> > +static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
> > +					       pgoff_t index,
> > +					       unsigned long num_ra_pages)
> > +{
> > +	struct page *p;
> > +	u64 start = index << PAGE_SHIFT;
> > +	unsigned long mapping_index;
> > +	ssize_t ret;
> > +	int err;
> > +
> > +	/*
> > +	 * the file is readonly, so i_size can't change here.  We jump
> > +	 * some pages past the last page to cache our merkles.  The goal
> > +	 * is just to jump past any hugepages that might be mapped in.
> > +	 */
> > +	mapping_index = (i_size_read(inode) >> PAGE_SHIFT) + 2048 + index;
> 
> So what does this magic number 2048 mean, how was it derived? Perhaps
> give it a symbolic name either via a local const var or via a define,
> something like
> 
> #define INODE_VERITY_EOF_OFFSET 2048 or something along those lines.
> 
> If the file is RO then why do you need to add such a large offset, it's
> not clear what the hugepages issue is.
> 
> <snip>

Thanks for the review!
Boris
