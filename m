Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94C06F6FBC
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 18:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEDQRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 12:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEDQRS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 12:17:18 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36759D5
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 09:17:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3BD06320098E;
        Thu,  4 May 2023 12:17:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 04 May 2023 12:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683217032; x=1683303432; bh=pT
        FRDzAWtfs516fyuqArRVrNxTrARZOK6IlMg8tAmIE=; b=KNfDGevU8fnyyWfc+1
        dx7O4bH0PUUazWXJCPH4rg9H/x/MaNsBb5S/lpI4U1mypfRl7gQG5NXEByUoOwpi
        KgMMcAG40gaXEm+RM29VccWu6NqMS+37uk+wNwkT1qstt2MvTFHoExrHUn+8sgY+
        mAbjAMtzqAvW0QLfCfRGcFBtSRR4r5/sxljVilBnCWYc5tCpLHpyTWlXTF5J5Lc/
        xY/V2H9emb47oPQF1CXaKlIeHU4e/atsbPKb6zEj+ueQ1YOBZ/a8fKhp8VAWLgLr
        9leSeoIReR0/eWjYbdgbkmU5RsSsYpCbUpb6bCxeeMjAjHVzybXcqzb8x1hA5xyj
        pNpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683217032; x=1683303432; bh=pTFRDzAWtfs51
        6fyuqArRVrNxTrARZOK6IlMg8tAmIE=; b=gto1EmIJeGk57mDJUQDvZT8m0QZT6
        TpW27jKi73leQKaMYN6UJ3eVeJlRH0FzVhXuSzaEEhMz0bIxS/4hx5dazYkhUZ8/
        ikxXtHv2xI76ZHQRWXNMyv3wgWnHPfisOtVstYVY8LZ0EBB5ykyAOCqY4X7uQFVP
        sWDu+8239uptFI1iMKGSokmfeIwANZj1m2dV1MhPAxrPgENKnvLU1RCALf0sXqkV
        Iu8iaJtNqlYIHgChRp49OlMdQ3ypA8P52hT1bzxdiiubjX3JOHzX5i/jK+0cvyOx
        4ALhkHm3ZpefqOUb+Cv6TJ7jWMJMrv7E1ycd7EVbqlws70yBeaFqMcskg==
X-ME-Sender: <xms:iNpTZB_2bq_NRDaQhWIo_ZXjQcdo_vhuEoDB4sTtaXgrBJWLfLfrrg>
    <xme:iNpTZFvB6HFYZkEdwoNaTaYCF5CASquj_9imupnxH8-eL37TciO43h160W0vQESjd
    xsxo_2hAp1u5FvG0rY>
X-ME-Received: <xmr:iNpTZPBtFr8QHVNqYAMwdhcn9JUZfXwwBMm_v7MC1O5VZSVWHMP7-zW3NGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeftddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvve
    eiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:iNpTZFfbdUG6xDBFleW249LkIrlX-67o_k2wl2jyNOuBixWvj8Nhew>
    <xmx:iNpTZGNStqQpCDs9yqgJUVBDfFVpy0PcUc-4SAa7rq_hhqsU6gHmyw>
    <xmx:iNpTZHmi0D2fqpPzx1qon45sU2z5lL8aG12PMpO0tYH93_JoOjRbYg>
    <xmx:iNpTZI1aVnu_PWMuS2_WN596oi57Kid1SLXDyfVhj3Pu3LVDILg5sA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 May 2023 12:17:10 -0400 (EDT)
Date:   Thu, 4 May 2023 09:17:03 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/9] btrfs: track original extent subvol in a new inline
 ref
Message-ID: <ZFPaf/la4nhbWK7q@devvm9258.prn0.facebook.com>
References: <cover.1683075170.git.boris@bur.io>
 <7a4b78e240d2f26eb3d7be82d4c0b8ddaa409519.1683075170.git.boris@bur.io>
 <c10a17cb-506a-2540-eb19-c79c6c00f788@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10a17cb-506a-2540-eb19-c79c6c00f788@gmx.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 03, 2023 at 11:17:12AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/5/3 08:59, Boris Burkov wrote:
> > In order to implement simple quota groups, we need to be able to
> > associate a data extent with the subvolume that created it. Once you
> > account for reflink, this information cannot be recovered without
> > explicitly storing it. Options for storing it are:
> > - a new key/item
> > - a new extent inline ref item
> > 
> > The former is backwards compatible, but wastes space, the latter is
> > incompat, but is efficient in space and reuses the existing inline ref
> > machinery, while only abusing it a tiny amount -- specifically, the new
> > item is not a ref, per-se.
> 
> Even we introduce new extent tree items, we can still mark the fs compat_ro.
> 
> As long as we don't do any writes, we can still read the fs without any
> compatibility problem, and the enable/disable should be addressed by
> btrfstune/mkfs anyway.

Unfortunately, I don't believe compat_ro is possible with this design.
Because of how inline ref items are implemented, there is a lot of code
that makes assumptions about the extent item size, and the inline ref
item size based on their type. The best example that definitely breaks
things rather than maybe just warning is check_extent in tree-checker.c

With a new unparseable ref item inserted in the sequence of refs, that
code will either overflow or detect padding. The size calculation comes
up 0, etc. Perhaps there is a clever way to trick it, but I have not
seen it yet.

I was able to make it compat_ro by introducing an entirely new item for
the owner ref, but that comes with a per extent disk usage tradeoff that
is fairly steep for storing just a single u64.

> 
> Thanks,
> Qu
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/accessors.h            |  4 +++
> >   fs/btrfs/backref.c              |  3 ++
> >   fs/btrfs/extent-tree.c          | 50 +++++++++++++++++++++++++--------
> >   fs/btrfs/print-tree.c           | 12 ++++++++
> >   fs/btrfs/ref-verify.c           |  3 ++
> >   fs/btrfs/tree-checker.c         |  3 ++
> >   include/uapi/linux/btrfs_tree.h |  6 ++++
> >   7 files changed, 70 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> > index ceadfc5d6c66..aab61312e4e8 100644
> > --- a/fs/btrfs/accessors.h
> > +++ b/fs/btrfs/accessors.h
> > @@ -350,6 +350,8 @@ BTRFS_SETGET_FUNCS(extent_data_ref_count, struct btrfs_extent_data_ref, count, 3
> >   BTRFS_SETGET_FUNCS(shared_data_ref_count, struct btrfs_shared_data_ref, count, 32);
> > +BTRFS_SETGET_FUNCS(extent_owner_ref_root_id, struct btrfs_extent_owner_ref, root_id, 64);
> > +
> >   BTRFS_SETGET_FUNCS(extent_inline_ref_type, struct btrfs_extent_inline_ref,
> >   		   type, 8);
> >   BTRFS_SETGET_FUNCS(extent_inline_ref_offset, struct btrfs_extent_inline_ref,
> > @@ -366,6 +368,8 @@ static inline u32 btrfs_extent_inline_ref_size(int type)
> >   	if (type == BTRFS_EXTENT_DATA_REF_KEY)
> >   		return sizeof(struct btrfs_extent_data_ref) +
> >   		       offsetof(struct btrfs_extent_inline_ref, offset);
> > +	if (type == BTRFS_EXTENT_OWNER_REF_KEY)
> > +		return sizeof(struct btrfs_extent_inline_ref);
> >   	return 0;
> >   }
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index e54f0884802a..8cd8ed6c572f 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -1128,6 +1128,9 @@ static int add_inline_refs(struct btrfs_backref_walk_ctx *ctx,
> >   						       count, sc, GFP_NOFS);
> >   			break;
> >   		}
> > +		case BTRFS_EXTENT_OWNER_REF_KEY:
> > +			WARN_ON(!btrfs_fs_incompat(ctx->fs_info, SIMPLE_QUOTA));
> > +			break;
> >   		default:
> >   			WARN_ON(1);
> >   		}
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 5cd289de4e92..b9a2f1e355b7 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -363,9 +363,13 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
> >   				     struct btrfs_extent_inline_ref *iref,
> >   				     enum btrfs_inline_ref_type is_data)
> >   {
> > +	struct btrfs_fs_info *fs_info = eb->fs_info;
> >   	int type = btrfs_extent_inline_ref_type(eb, iref);
> >   	u64 offset = btrfs_extent_inline_ref_offset(eb, iref);
> > +	if (type == BTRFS_EXTENT_OWNER_REF_KEY && btrfs_fs_incompat(fs_info, SIMPLE_QUOTA))
> > +		return type;
> > +
> >   	if (type == BTRFS_TREE_BLOCK_REF_KEY ||
> >   	    type == BTRFS_SHARED_BLOCK_REF_KEY ||
> >   	    type == BTRFS_SHARED_DATA_REF_KEY ||
> > @@ -374,26 +378,25 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
> >   			if (type == BTRFS_TREE_BLOCK_REF_KEY)
> >   				return type;
> >   			if (type == BTRFS_SHARED_BLOCK_REF_KEY) {
> > -				ASSERT(eb->fs_info);
> > +				ASSERT(fs_info);
> >   				/*
> >   				 * Every shared one has parent tree block,
> >   				 * which must be aligned to sector size.
> >   				 */
> > -				if (offset &&
> > -				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
> > +				if (offset && IS_ALIGNED(offset, fs_info->sectorsize))
> >   					return type;
> >   			}
> >   		} else if (is_data == BTRFS_REF_TYPE_DATA) {
> >   			if (type == BTRFS_EXTENT_DATA_REF_KEY)
> >   				return type;
> >   			if (type == BTRFS_SHARED_DATA_REF_KEY) {
> > -				ASSERT(eb->fs_info);
> > +				ASSERT(fs_info);
> >   				/*
> >   				 * Every shared one has parent tree block,
> >   				 * which must be aligned to sector size.
> >   				 */
> >   				if (offset &&
> > -				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
> > +				    IS_ALIGNED(offset, fs_info->sectorsize))
> >   					return type;
> >   			}
> >   		} else {
> > @@ -403,7 +406,7 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
> >   	}
> >   	btrfs_print_leaf((struct extent_buffer *)eb);
> > -	btrfs_err(eb->fs_info,
> > +	btrfs_err(fs_info,
> >   		  "eb %llu iref 0x%lx invalid extent inline ref type %d",
> >   		  eb->start, (unsigned long)iref, type);
> >   	WARN_ON(1);
> > @@ -912,6 +915,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
> >   		}
> >   		iref = (struct btrfs_extent_inline_ref *)ptr;
> >   		type = btrfs_get_extent_inline_ref_type(leaf, iref, needed);
> > +		if (type == BTRFS_EXTENT_OWNER_REF_KEY) {
> > +			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
> > +			ptr += btrfs_extent_inline_ref_size(type);
> > +			continue;
> > +		}
> >   		if (type == BTRFS_REF_TYPE_INVALID) {
> >   			err = -EUCLEAN;
> >   			goto out;
> > @@ -1708,6 +1716,8 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
> >   		 node->type == BTRFS_SHARED_DATA_REF_KEY)
> >   		ret = run_delayed_data_ref(trans, node, extent_op,
> >   					   insert_reserved);
> > +	else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY)
> > +		ret = 0;
> >   	else
> >   		BUG();
> >   	if (ret && insert_reserved)
> > @@ -2275,6 +2285,7 @@ static noinline int check_committed_ref(struct btrfs_root *root,
> >   	struct btrfs_extent_item *ei;
> >   	struct btrfs_key key;
> >   	u32 item_size;
> > +	u32 expected_size;
> >   	int type;
> >   	int ret;
> > @@ -2301,10 +2312,17 @@ static noinline int check_committed_ref(struct btrfs_root *root,
> >   	ret = 1;
> >   	item_size = btrfs_item_size(leaf, path->slots[0]);
> >   	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
> > +	expected_size = sizeof(*ei) + btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY);
> > +
> > +	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
> > +	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
> > +	if (btrfs_fs_incompat(fs_info, SIMPLE_QUOTA) && type == BTRFS_EXTENT_OWNER_REF_KEY) {
> > +		expected_size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
> > +		iref = (struct btrfs_extent_inline_ref *)(iref + 1);
> > +	}
> >   	/* If extent item has more than 1 inline ref then it's shared */
> > -	if (item_size != sizeof(*ei) +
> > -	    btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY))
> > +	if (item_size != expected_size)
> >   		goto out;
> >   	/*
> > @@ -2316,8 +2334,6 @@ static noinline int check_committed_ref(struct btrfs_root *root,
> >   	     btrfs_root_last_snapshot(&root->root_item)))
> >   		goto out;
> > -	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
> > -
> >   	/* If this extent has SHARED_DATA_REF then it's shared */
> >   	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
> >   	if (type != BTRFS_EXTENT_DATA_REF_KEY)
> > @@ -4572,6 +4588,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
> >   	struct btrfs_root *extent_root;
> >   	int ret;
> >   	struct btrfs_extent_item *extent_item;
> > +	struct btrfs_extent_owner_ref *oref;
> >   	struct btrfs_extent_inline_ref *iref;
> >   	struct btrfs_path *path;
> >   	struct extent_buffer *leaf;
> > @@ -4583,7 +4600,10 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
> >   	else
> >   		type = BTRFS_EXTENT_DATA_REF_KEY;
> > -	size = sizeof(*extent_item) + btrfs_extent_inline_ref_size(type);
> > +	size = sizeof(*extent_item);
> > +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> > +		size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
> > +	size += btrfs_extent_inline_ref_size(type);
> >   	path = btrfs_alloc_path();
> >   	if (!path)
> > @@ -4604,8 +4624,16 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
> >   	btrfs_set_extent_flags(leaf, extent_item,
> >   			       flags | BTRFS_EXTENT_FLAG_DATA);
> > +
> >   	iref = (struct btrfs_extent_inline_ref *)(extent_item + 1);
> > +	if (btrfs_fs_incompat(fs_info, SIMPLE_QUOTA)) {
> > +		btrfs_set_extent_inline_ref_type(leaf, iref, BTRFS_EXTENT_OWNER_REF_KEY);
> > +		oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
> > +		btrfs_set_extent_owner_ref_root_id(leaf, oref, root_objectid);
> > +		iref = (struct btrfs_extent_inline_ref *)(oref + 1);
> > +	}
> >   	btrfs_set_extent_inline_ref_type(leaf, iref, type);
> > +
> >   	if (parent > 0) {
> >   		struct btrfs_shared_data_ref *ref;
> >   		ref = (struct btrfs_shared_data_ref *)(iref + 1);
> > diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> > index b93c96213304..1114cd915bd8 100644
> > --- a/fs/btrfs/print-tree.c
> > +++ b/fs/btrfs/print-tree.c
> > @@ -80,12 +80,20 @@ static void print_extent_data_ref(struct extent_buffer *eb,
> >   	       btrfs_extent_data_ref_count(eb, ref));
> >   }
> > +static void print_extent_owner_ref(struct extent_buffer *eb,
> > +				   struct btrfs_extent_owner_ref *ref)
> > +{
> > +	WARN_ON(!btrfs_fs_incompat(eb->fs_info, SIMPLE_QUOTA));
> > +	pr_cont("extent data owner root %llu\n", btrfs_extent_owner_ref_root_id(eb, ref));
> > +}
> > +
> >   static void print_extent_item(struct extent_buffer *eb, int slot, int type)
> >   {
> >   	struct btrfs_extent_item *ei;
> >   	struct btrfs_extent_inline_ref *iref;
> >   	struct btrfs_extent_data_ref *dref;
> >   	struct btrfs_shared_data_ref *sref;
> > +	struct btrfs_extent_owner_ref *oref;
> >   	struct btrfs_disk_key key;
> >   	unsigned long end;
> >   	unsigned long ptr;
> > @@ -159,6 +167,10 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
> >   			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
> >   				     offset, eb->fs_info->sectorsize);
> >   			break;
> > +		case BTRFS_EXTENT_OWNER_REF_KEY:
> > +			oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
> > +			print_extent_owner_ref(eb, oref);
> > +			break;
> >   		default:
> >   			pr_cont("(extent %llu has INVALID ref type %d)\n",
> >   				  eb->start, type);
> > diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> > index 95d28497de7c..9edc87eaff1f 100644
> > --- a/fs/btrfs/ref-verify.c
> > +++ b/fs/btrfs/ref-verify.c
> > @@ -485,6 +485,9 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
> >   			ret = add_shared_data_ref(fs_info, offset, count,
> >   						  key->objectid, key->offset);
> >   			break;
> > +		case BTRFS_EXTENT_OWNER_REF_KEY:
> > +			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
> > +			break;
> >   		default:
> >   			btrfs_err(fs_info, "invalid key type in iref");
> >   			ret = -EINVAL;
> > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > index e2b54793bf0c..27d4230a38a8 100644
> > --- a/fs/btrfs/tree-checker.c
> > +++ b/fs/btrfs/tree-checker.c
> > @@ -1451,6 +1451,9 @@ static int check_extent_item(struct extent_buffer *leaf,
> >   			}
> >   			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
> >   			break;
> > +		case BTRFS_EXTENT_OWNER_REF_KEY:
> > +			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
> > +			break;
> >   		default:
> >   			extent_err(leaf, slot, "unknown inline ref type: %u",
> >   				   inline_type);
> > diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> > index ab38d0f411fa..424c7f342712 100644
> > --- a/include/uapi/linux/btrfs_tree.h
> > +++ b/include/uapi/linux/btrfs_tree.h
> > @@ -226,6 +226,8 @@
> >   #define BTRFS_SHARED_DATA_REF_KEY	184
> > +#define BTRFS_EXTENT_OWNER_REF_KEY	190
> > +
> >   /*
> >    * block groups give us hints into the extent allocation trees.  Which
> >    * blocks are free etc etc
> > @@ -783,6 +785,10 @@ struct btrfs_shared_data_ref {
> >   	__le32 count;
> >   } __attribute__ ((__packed__));
> > +struct btrfs_extent_owner_ref {
> > +	u64 root_id;
> > +} __attribute__ ((__packed__));
> > +
> >   struct btrfs_extent_inline_ref {
> >   	__u8 type;
> >   	__le64 offset;
> 
