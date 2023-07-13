Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA44752C10
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 23:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjGMVXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 17:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjGMVWr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 17:22:47 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD322D78
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 14:22:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 88B4E320090D;
        Thu, 13 Jul 2023 17:22:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 13 Jul 2023 17:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1689283357; x=1689369757; bh=6G
        uWvW1iT/7r1lYU7jUK3dv2xbA4ZNLdobaOwADnPFQ=; b=k2oRDeiLHYK5bpQbT3
        bGfmnAp2fP7JXWd9w1IcSTZ6sRmFLeHGA4xbOhT6hvewheMk5/AEBl1CWtdzwxmI
        1+V+58jiG/Zpow4oFqCVK145Gl0HN3MRDYljoTtHCviRTIgKCQ000fUThs6GgH+X
        KLK8vYzeVJrSjmO4WKfGMw4tlXbYf8SzfnrcD9PIsiYjoUSSRR9R7Cb2IAslady0
        P6dZllmzhWDwzxQFnnxuNtk5WmRXu/CE/ph4tpIxkYF8BkjD2R4ZTnGYWqgArBfd
        RZE4humIpGq4awXzr7ZX4G2WtO40N3RO1QL5//BwWRnH479kqPp7tEmgRoI5OerG
        Te0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689283357; x=1689369757; bh=6GuWvW1iT/7r1
        lYU7jUK3dv2xbA4ZNLdobaOwADnPFQ=; b=kPyYMDcsPU0BS9kS06axiD7SU3miB
        cl+VsZ1GGeAQ8MdRlciD5oRYk1UJAc+zrRLcFCb4jxqz4Z64YKLinLZtKYsPJX9V
        Lx3H25ZjRF/MMpBsD8ZZ+fSGqRARUzcFvZ+F4dkvm6eWvMKnzpn61FOKoQ5mvzS4
        FtS+H2uz8/etWOdllADz6cQzS8X1n42gFRnz2UOm82Ytsc41SMsSfpfu2ql7B7cq
        lbOtgBG6DQzV4CW+pEHOYb6t08XSv5F4El8T8aNPwnaji3PmHgMiTHyVf4cBNdT7
        WH0A5+fHh293+UZZseEUXdEhItqKe6rxPzMwGs/dnRabaXHDlOB+cFRzw==
X-ME-Sender: <xms:HGuwZLMVJblIGTfHLo_7M8aH05HWuotGSUrPeANIZrOKcemHLbMjsA>
    <xme:HGuwZF8rQ6lQ2bdmb-EkZpGmPbmN_iqfEQBZoOAu_3RaDVKgx69BBoFWUISl9aqui
    hvwXMhIR-Y3vO8Nplo>
X-ME-Received: <xmr:HGuwZKQphb9hlhvMU6ZPD1kmQs_J9Nhuh_es5chHrKHgyLelvKjCFcarlsEk06ii-iqdj7rX4TBvoF0ItQe_Jb7N04M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdduheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:HGuwZPt-Lw8Poz8z_cRdb9vXIRrYQwh8_xWM7XP5EBfe9jYLMZfhnQ>
    <xmx:HGuwZDdX9hgJ-S5HnaxFa6h1VdVjNT3UBqZnSKs38MLjnf8XCOD7OQ>
    <xmx:HGuwZL0o2YxkhTmNu0g98B8SUt3Wuc-IH7USyO3aHj_whyfj0IAohw>
    <xmx:HWuwZLFOm8-Pu8q6vAGEuazkRFYNsZ9D-_jr2gmDEN-78WDHfuUfnw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jul 2023 17:22:36 -0400 (EDT)
Date:   Thu, 13 Jul 2023 14:21:17 -0700
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 10/18] btrfs: track owning root in btrfs_ref
Message-ID: <20230713212117.GA2629298@zen>
References: <cover.1688597211.git.boris@bur.io>
 <2a1725b60a1978c03c67a93c55c8c52b76d7f046.1688597211.git.boris@bur.io>
 <20230713165825.GJ207541@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713165825.GJ207541@perftesting>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 13, 2023 at 12:58:25PM -0400, Josef Bacik wrote:
> On Wed, Jul 05, 2023 at 04:20:47PM -0700, Boris Burkov wrote:
> > While data extents require us to store additional inline refs to track
> > the original owner on free, this information is available implicitly for
> > metadata. It is found in the owner field of the header of the tree
> > block. Even if other trees refer to this block and the original ref goes
> > away, we will not rewrite that header field, so it will reliably give the
> > original owner.
> > 
> > In addition, there is a relocation case where a new data extent needs to
> > have an owning root separate from the referring root wired through
> > delayed refs.
> > 
> > To use it for recording simple quota deltas, we need to wire this root
> > id through from when we create the delayed ref until we fully process
> > it. Store it in the generic btrfs_ref struct of the delayed ref.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/delayed-ref.c |  7 ++++---
> >  fs/btrfs/delayed-ref.h | 13 +++++++++++--
> >  fs/btrfs/extent-tree.c | 19 ++++++++++++-------
> >  fs/btrfs/file.c        | 10 +++++-----
> >  fs/btrfs/inode-item.c  |  2 +-
> >  fs/btrfs/relocation.c  | 16 +++++++++-------
> >  fs/btrfs/tree-log.c    |  3 ++-
> >  7 files changed, 44 insertions(+), 26 deletions(-)
> > 
> > diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> > index f0bae1e1c455..49c320f2334b 100644
> > --- a/fs/btrfs/delayed-ref.c
> > +++ b/fs/btrfs/delayed-ref.c
> > @@ -840,7 +840,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
> >  static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
> >  				    struct btrfs_delayed_ref_node *ref,
> >  				    u64 bytenr, u64 num_bytes, u64 ref_root,
> > -				    int action, u8 ref_type)
> > +				    int action, u8 ref_type, u64 owning_root)
> >  {
> >  	u64 seq = 0;
> >  
> > @@ -857,6 +857,7 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
> >  	ref->action = action;
> >  	ref->seq = seq;
> >  	ref->type = ref_type;
> > +	ref->owning_root = owning_root;
> >  	RB_CLEAR_NODE(&ref->ref_node);
> >  	INIT_LIST_HEAD(&ref->add_list);
> >  }
> > @@ -915,7 +916,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
> >  
> >  	init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
> >  				generic_ref->tree_ref.ref_root, action,
> > -				ref_type);
> > +				ref_type, generic_ref->owning_root);
> >  	ref->root = generic_ref->tree_ref.ref_root;
> >  	ref->parent = parent;
> >  	ref->level = level;
> > @@ -989,7 +990,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
> >  	else
> >  	        ref_type = BTRFS_EXTENT_DATA_REF_KEY;
> >  	init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
> > -				ref_root, action, ref_type);
> > +				ref_root, action, ref_type, ref_root);
> >  	ref->root = ref_root;
> >  	ref->parent = parent;
> >  	ref->objectid = owner;
> > diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> > index a71eff78469c..336c33c28191 100644
> > --- a/fs/btrfs/delayed-ref.h
> > +++ b/fs/btrfs/delayed-ref.h
> > @@ -32,6 +32,12 @@ struct btrfs_delayed_ref_node {
> >  	/* seq number to keep track of insertion order */
> >  	u64 seq;
> >  
> > +	/*
> > +	 * root which originally allocated this extent and owns it for
> > +	 * simple quota accounting purposes.
> > +	 */
> > +	u64 owning_root;
> > +
> >  	/* ref count on this data structure */
> >  	refcount_t refs;
> >  
> > @@ -239,6 +245,7 @@ struct btrfs_ref {
> >  #endif
> >  	u64 bytenr;
> >  	u64 len;
> > +	u64 owning_root;
> >  
> >  	/* Bytenr of the parent tree block */
> >  	u64 parent;
> > @@ -278,16 +285,18 @@ static inline u64 btrfs_calc_delayed_ref_bytes(const struct btrfs_fs_info *fs_in
> >  }
> >  
> >  static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
> > -				int action, u64 bytenr, u64 len, u64 parent)
> > +				int action, u64 bytenr, u64 len, u64 parent, u64 owning_root)
> >  {
> >  	generic_ref->action = action;
> >  	generic_ref->bytenr = bytenr;
> >  	generic_ref->len = len;
> >  	generic_ref->parent = parent;
> > +	generic_ref->owning_root = owning_root;
> >  }
> >  
> >  static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
> > -				int level, u64 root, u64 mod_root, bool skip_qgroup)
> > +				int level, u64 root, u64 mod_root,
> > +				bool skip_qgroup)
> >  {
> >  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
> >  	/* If @real_root not set, use @root as fallback */
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 041f2eb153d7..fa53f7cbd84a 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -2410,7 +2410,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
> >  			num_bytes = btrfs_file_extent_disk_num_bytes(buf, fi);
> >  			key.offset -= btrfs_file_extent_offset(buf, fi);
> >  			btrfs_init_generic_ref(&generic_ref, action, bytenr,
> > -					       num_bytes, parent);
> > +					       num_bytes, parent, ref_root);
> >  			btrfs_init_data_ref(&generic_ref, ref_root, key.objectid,
> >  					    key.offset, root->root_key.objectid,
> >  					    for_reloc);
> > @@ -2424,7 +2424,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
> >  			bytenr = btrfs_node_blockptr(buf, i);
> >  			num_bytes = fs_info->nodesize;
> >  			btrfs_init_generic_ref(&generic_ref, action, bytenr,
> > -					       num_bytes, parent);
> > +					       num_bytes, parent, ref_root);
> >  			btrfs_init_tree_ref(&generic_ref, level - 1, ref_root,
> >  					    root->root_key.objectid, for_reloc);
> >  			if (inc)
> > @@ -3242,7 +3242,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
> >  	int ret;
> >  
> >  	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
> > -			       buf->start, buf->len, parent);
> > +			       buf->start, buf->len, parent, btrfs_header_owner(buf));
> >  	btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
> >  			    root_id, 0, false);
> >  
> > @@ -4699,12 +4699,16 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
> >  				     struct btrfs_key *ins)
> >  {
> >  	struct btrfs_ref generic_ref = { 0 };
> > +	u64 root_objectid = root->root_key.objectid;
> > +	u64 owning_root = root_objectid;
> > +
> > +	BUG_ON(root_objectid == BTRFS_TREE_LOG_OBJECTID);
> >  
> 
> This is a duplicate check of what's checked below.  Also we don't want to add
> new BUG_ON()'s, we want to add ASSERT()'s.  Thanks,

Oops. I just meant to use root_objectid instead of
root->root_key.objectid and somehow left in the old line, my bad.

I assume we don't want to change these existing BUG_ONs to ASSERTs
without specific justification, though.

> 
> Josef
