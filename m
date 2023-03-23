Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4DB6C6D4D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 17:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjCWQWd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 12:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjCWQWb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 12:22:31 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0322748A
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 09:22:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A252A320091D;
        Thu, 23 Mar 2023 12:22:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 Mar 2023 12:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679588549; x=1679674949; bh=7F
        Scu8l0SfbxOH5Y3sIiI9IwpYbpkuO3ijP040lhNtY=; b=eyhl6qVCCGv/O0kOWy
        t7dBwHtGNv5CK+IyWyRb0o5ZVZU6ZnZ7B5ZWyH2FoRsFsSSNSJeZDVF0agjJmJAg
        WK+XPhs0nHA1ZMyBjN4Iy/Fpa1EPt9XfUHcNMDTqGTPE90kGBHV97S5SRiAb0KUZ
        WabSb62D6pZCpGVhqyomFLzGZ0ZbmfIyFMT10zeNqBuTEsCxQkMeyvTLfbfYG7wp
        1Qk1yne/0S7NGuafZ5xWG7jUqFbn3iIlCUtHpQE2qv59I7GzqwVhDrKqb45/JAet
        J7ZvhcvZ+yCENfDfCsW6A+BS8f16cEtp0KXVaivJmkrOzpms1CrlUnbG00OASzaH
        9K/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679588549; x=1679674949; bh=7FScu8l0SfbxO
        H5Y3sIiI9IwpYbpkuO3ijP040lhNtY=; b=a1HYtefJaQR+4l8dPKh1jzIBXo8km
        LC453RwDXXw8xCVUHAQ6otCwq8Qz1pXXXDc7rOUDTPYc2Yum8wcKxvCTM7UeL89n
        g/bZh90IlrIgsPthfHthbdIy1pv/uYooufmEe3fYfv8xB2OOkUTgpRzz9t0fWJ3c
        PHfx1utGrmQO0QsX+RseQBHe9KbT8r6AidDaznVjMgYrfiajex1aE/I60eRhnmUU
        Iis2aPJuQjIUFL/wYN1EvmDDPDn4v/v5v4g/3fSIjzGYz1LFjFi8Kkdo8VWHQ5Dd
        hL5j9Rs1xaXTbu19eCkRorcZS6EdQLpI2tu3n3IlGzmpbnNKX97w+mE7g==
X-ME-Sender: <xms:xXwcZH7rUAiLQ9eGrkMPgReU_vMS4pvmqlRi2V1R48IJg66QfgJ1-Q>
    <xme:xXwcZM6UJeKlbHv67ZD5gQ4IG_LQLEr8zX6A5BwdDXLIvTHLAvbud3nbctWivQnHo
    xmL9y9M4AHH-e9y6b8>
X-ME-Received: <xmr:xXwcZOfH-dabhEsKFi5fq4o3-J4pfL3zimwWkT3tZMsixMcETAgEb2yv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:xXwcZIITy9EsMX5e3kiDnd4WkJXI1LF4ZNfMJCDwGpMuc2yEzxPKoA>
    <xmx:xXwcZLLeGbtCxl2SvSP4nEtknompvzYTmmO4gaHjBm-8wwmk0DpTDg>
    <xmx:xXwcZBxaFhFghjrJB5PlXYk6TmFhjK5WrEzg8VlsV48m8mXIStcLKA>
    <xmx:xXwcZBhNbNfu0INnsQt1RCnNTN-6eGG8oF7sA8Q0pc8U56O_iBHkGQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 12:22:28 -0400 (EDT)
Date:   Thu, 23 Mar 2023 09:22:27 -0700
From:   Boris Burkov <boris@bur.io>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v5 4/5] btrfs: fix crash with non-zero pre in
 btrfs_split_ordered_extent
Message-ID: <20230323162227.GB8070@zen>
References: <cover.1679512207.git.boris@bur.io>
 <b8c66eeedfcea2c068befcd40de6a95cf5d64d7b.1679512207.git.boris@bur.io>
 <20230323083608.m2ut2whbk2smjjpu@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323083608.m2ut2whbk2smjjpu@naota-xeon>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 08:36:08AM +0000, Naohiro Aota wrote:
> On Wed, Mar 22, 2023 at 12:11:51PM -0700, Boris Burkov wrote:
> > if pre != 0 in btrfs_split_ordered_extent, then we do the following:
> > 1. remove ordered (at file_offset) from the rb tree
> > 2. modify file_offset+=pre
> > 3. re-insert ordered
> > 4. clone an ordered extent at offset 0 length pre from ordered.
> > 5. clone an ordered extent for the post range, if necessary.
> > 
> > step 4 is not correct, as at this point, the start of ordered is already
> > the end of the desired new pre extent. Further this causes a panic when
> > btrfs_alloc_ordered_extent sees that the node (from the modified and
> > re-inserted ordered) is already present at file_offset + 0 = file_offset.
> > 
> > We can fix this by either using a negative offset, or by moving the
> > clone of the pre extent to after we remove the original one, but before
> > we modify and re-insert it. The former feels quite kludgy, as we are
> > "cloning" from outside the range of the ordered extent, so opt for the
> > latter, which does have some locking annoyances.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/ordered-data.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > index 4bebebb9b434..d14a3fe1a113 100644
> > --- a/fs/btrfs/ordered-data.c
> > +++ b/fs/btrfs/ordered-data.c
> > @@ -1161,6 +1161,17 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered,
> >  	if (tree->last == node)
> >  		tree->last = NULL;
> >  
> > +	if (pre) {
> > +		spin_unlock_irq(&tree->lock);
> > +		oe = clone_ordered_extent(ordered, 0, pre);
> > +		ret = IS_ERR(oe) ? PTR_ERR(oe) : 0;
> > +		if (!ret && ret_pre)
> > +			*ret_pre = oe;
> > +		if (ret)
> > +			goto out;
> 
> How about just "return ret;"?
> 
> > +		spin_lock_irq(&tree->lock);
> 
> I'm concerned about the locking too. Before this spin_lock_irq() is taken,
> nothing in the ordered extent range in the tree. So, maybe, someone might
> insert or lookup that range in the meantime, and fail? Well, this function
> is called under the IO for this range, so it might be OK, though...
> 
> So, I considered another approach that factoring out some parts of
> btrfs_add_ordered_extent() and use them to rewrite
> btrfs_split_ordered_extent().
> 
> btrfs_add_ordered_extent() is doing three things:
> 
> 1. Space accounting
>    - btrfs_qgroup_free_data() or btrfs_qgroup_release_data()
>    - percpu_counter_add_batch(...)
> 2. Allocating and initializing btrfs_ordered_extent
> 3. Adding the btrfs_ordered_extent entry to trees, incrementing OE counter
>    - tree_insert(&tree->tree, ...)
>    - list_add_tail(&entry->root_extent_list, &root->ordered_extents);
>    - btrfs_mod_outstanding_extents(inode, 1);
> 
> For btrfs_split_ordered_extent(), we don't need to do #1 above as it was
> already done for the original ordered extent. So, if we factor #2 to a
> function e.g, init_ordered_extent(), we can rewrite clone_ordered_extent()
> to return a cloned OE (doing #2), and also rewrite
> btrfs_split_ordered_extent() o do #3 as following:
> 
> /* clone_ordered_extent() now returns new ordered extent. */
> /* It is not inserted into the trees, yet. */
> static struct btrfs_ordered_extent *clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
> 				u64 len)
> {
> 	struct inode *inode = ordered->inode;
> 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
> 	u64 file_offset = ordered->file_offset + pos;
> 	u64 disk_bytenr = ordered->disk_bytenr + pos;
> 	unsigned long flags = ordered->flags & BTRFS_ORDERED_TYPE_FLAGS;
> 
> 	WARN_ON_ONCE(flags & (1 << BTRFS_ORDERED_COMPRESSED));
> 	return init_ordered_extent(BTRFS_I(inode), file_offset, len, len,
> 				   disk_bytenr, len, 0, flags,
> 				   ordered->compress_type);
> }
> 
> int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
> 				u64 post)
> {
> ...
> 	/* clone new OEs first */
> 	if (pre)
> 		pre_oe = clone_ordered_extent(ordered, 0, pre);
> 	if (post)
> 		post_oe = clone_ordered_extent(ordered, ordered->disk_num_bytes - post, ost);
> 	/* check pre_oe and post_oe */
> 
> 	spin_lock_irq(&tree->lock);
> 	/* remove original OE from tree */
> 	...
> 
> 	/* modify the original OE params */
> 	ordered->file_offset += pre;
> 	...
> 
> 	/* Re-insert the original OE */
> 	node = tree_insert(&tree->tree, ordered->file_offset, &ordered->rb_node);
> 	...
> 
> 	/* Insert new OEs */
> 	if (pre_oe)
> 		node = tree_insert(...);
> 	...
> 	spin_unlock_irq(&tree->lock);
> 
> 	/* And, do the root->ordered_extents and outstanding_extents works */
> 	...
> }
> 
> With this approach, no one can see the intermediate state that an OE is
> missing for some area in the original OE range.

I like this solution, I think it is nice to split it up so that three
steps are separate. i.e., initialize the two new OEs with the old state,
then modify the middle OE with the new state and re-insert the new OEs
together. And everything after the initialization can be under the lock.

However, based on Christoph's response, I would lean towards getting rid
of the three way split altogether. I would love to hear your thoughts in
that thread as well, before committing to that, though.

If we do keep the three way split, then I will definitely implement your
idea here, I think it's nicer than the weird lock dropping/re-taking
stuff I was doing.

Thanks,
Boris

> 
> > +	}
> > +
> >  	ordered->file_offset += pre;
> >  	ordered->disk_bytenr += pre;
> >  	ordered->num_bytes -= (pre + post);
> > @@ -1176,18 +1187,13 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered,
> >  
> >  	spin_unlock_irq(&tree->lock);
> >  
> > -	if (pre) {
> > -		oe = clone_ordered_extent(ordered, 0, pre);
> > -		ret = IS_ERR(oe) ? PTR_ERR(oe) : 0;
> > -		if (!ret && ret_pre)
> > -			*ret_pre = oe;
> > -	}
> > -	if (!ret && post) {
> > +	if (post) {
> >  		oe = clone_ordered_extent(ordered, pre + ordered->disk_num_bytes, post);
> >  		ret = IS_ERR(oe) ? PTR_ERR(oe) : 0;
> >  		if (!ret && ret_post)
> >  			*ret_post = oe;
> >  	}
> > +out:
> >  	return ret;
> >  }
> >  
> > -- 
> > 2.38.1
> > 
