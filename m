Return-Path: <linux-btrfs+bounces-16134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443D1B2AF7C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 19:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181B52A34ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 17:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E253570C8;
	Mon, 18 Aug 2025 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="eud7GKR2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oblu2zJd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6183019D8
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538391; cv=none; b=V1eyZ6OLOT2M5uALMZ01SJiBYjWxrUVWp6ag6tfcvPPZD2FQCqHAFbAxsAOVMkSvUFvvh41iGYnjEQ17/NVDHjTvzCaSN27TVh/qFZP85M0StOsAMZ2Tmhe8DMkCAzsm1nZ6yK1Vt6EPN0x6Qnv7UD56dRLTkgzlMdSTdxbyf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538391; c=relaxed/simple;
	bh=otBF0/SAZSUePMrBt4PSIZs9k3UTLfbfasNkWxijHA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLbAD96cbLOnN6gWSxChAsFK4/AFgANQxrEQ8+Uw+d6ph+WsYEvbEeKIi7Vsk+7AUW4R3DaSW0e2WFNeq2sclL7Qef6PCNgnRwEVrQt+rfPdrxUNZb2wRPXneogP+VAT9TepR6XEBEKPB81UpXb2SyWHPIRcv1xVXVwrSvwe2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=eud7GKR2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oblu2zJd; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03A567A0114;
	Mon, 18 Aug 2025 13:33:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 18 Aug 2025 13:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755538387; x=1755624787; bh=XFiMSPpTn3
	8n8fzw3blRYd5W/fnrGX402Ic4PkYqm58=; b=eud7GKR2Uv9p+LBVCAv5r7PiC2
	G08YcJC6W1rk5hojUz6fxhq70NfVk5ZLlKbXjlV9k0UtMAXLDqcCVkDu0nYii6bK
	yUmA3E1wYbMypEym4uftQ7av1ZsKXwwqxvKEgf2zmngkp4oumIQ73nAMOjCh4y5S
	IRAwiLJw7EtfQUmHNY3yayKeAQagwlH8vzGEF4fQ6Dz7k9zUJSPkjiWYyGNDzAr5
	zNCv0iPNktR4dHKiQ2yONuwIjIanf633mTK7jPQNJ12OsACybWAo3tB8XaIsU6eF
	wSGJz6eF0dcYDGkTyx7r9474/s1+UX7p0RN5kyHHfnPJbA3sijj0R+2+RWAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755538387; x=1755624787; bh=XFiMSPpTn38n8fzw3blRYd5W/fnrGX402Ic
	4PkYqm58=; b=Oblu2zJdoA3UXbKkM/RAkeWhOPw9bBZfqOUIqqCofPDQejzwiZt
	dXaJIXdqizJOH0PaWrLta5BB/5C7Cxm9AFf6IUm5eEARqxT/DW2Gv4h+u42EtrRg
	AypetQgHofzzFwSQrl7QAF1z3tMQczw1clmBIlpngpdmh3u8P4rl7vd0Kn+vyO1v
	pG+PLN00RXIDCtDFrdkP/jTCpACclXbi15PXEe92Etg/kWEu6p9RQNnOL6Y/06Ku
	NrgJexdqixJlba19r35wpzQGuUPghXeaWaaFLpyuCQYuzLD59tipgo9zJmogNwOb
	Xde6LAaavIYCpjtMi69hUGmr422NSv2miaA==
X-ME-Sender: <xms:02OjaIkU37M0NQNaWk8X_KYj-4qqem0B_HpMSE8MWP5l346cHnEV_Q>
    <xme:02OjaIDKA_NheK66-PQbRhfqQt5t8kanVX4LSg6Pxn-4bhhB_cPmWhm0IpWyXqjLA
    -ePyCP66CnlXaeRwAU>
X-ME-Received: <xmr:02OjaIeBZrZ9YKb06-pPCWxyNxpSmoJcZCy7q5bq_gF8MhvHVXdSyItMcQayBIDH70VLefeNRG3qIKaLL90TfRkXqDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:02OjaDLuPiZDXyhBajDyuzN8lVfMfMUaF8rQKjgSIoUenYRYQaxpPQ>
    <xmx:02OjaLdCfGKHrZ6hvUUHV3nKqiLuD6ZbVe5Gui1lp032df1afYmU4A>
    <xmx:02OjaK2EIaERAxG4gP2VSqT89KIVRnySC_DMgyuu4hcPgmWQMZ5Ubg>
    <xmx:02OjaEjjxr-xUYYV3l6jx6tENqQUY71XtAaaBgZlVrXQdUV_qXnc9Q>
    <xmx:02OjaEqV3QqIZCnweN7nfbRyCW1oUk9U6rB2SXa38Tnqks5x8cE5zu1z>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 13:33:07 -0400 (EDT)
Date: Mon, 18 Aug 2025 10:33:43 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 01/16] btrfs: add definitions and constants for
 remap-tree
Message-ID: <20250818173343.GA243660@zen.localdomain>
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-2-mark@harmstone.com>
 <20250815235107.GA3042054@zen.localdomain>
 <fa39bbb2-eb85-4f46-a57d-99ae55b8abe6@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa39bbb2-eb85-4f46-a57d-99ae55b8abe6@harmstone.com>

On Mon, Aug 18, 2025 at 06:21:24PM +0100, Mark Harmstone wrote:
> Thanks Boris.
> 
> The funny indentation is artefact of diff: the plus sign at the beginning
> throws off the tabstop in your e-mail client. If you do `git am` it looks
> fine.
> 

Oh yeah, that makes sense, thanks.

> On 16/08/2025 12.51 am, Boris Burkov wrote:
> > On Wed, Aug 13, 2025 at 03:34:43PM +0100, Mark Harmstone wrote:
> > > Add an incompat flag for the new remap-tree feature, and the constants
> > > and definitions needed to support it.
> > > 
> > > Signed-off-by: Mark Harmstone <mark@harmstone.com>
> > 
> > Some formatting nits, but you can add
> > 
> > Reviewed-by: Boris Burkov <boris@bur.io>
> > 
> > > ---
> > >   fs/btrfs/accessors.h            |  3 +++
> > >   fs/btrfs/locking.c              |  1 +
> > >   fs/btrfs/sysfs.c                |  2 ++
> > >   fs/btrfs/tree-checker.c         |  6 ++----
> > >   fs/btrfs/tree-checker.h         |  5 +++++
> > >   fs/btrfs/volumes.c              |  1 +
> > >   include/uapi/linux/btrfs.h      |  1 +
> > >   include/uapi/linux/btrfs_tree.h | 12 ++++++++++++
> > >   8 files changed, 27 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> > > index 99b3ced12805..95a1ca8c099b 100644
> > > --- a/fs/btrfs/accessors.h
> > > +++ b/fs/btrfs/accessors.h
> > > @@ -1009,6 +1009,9 @@ BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
> > >   BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
> > >   			 struct btrfs_verity_descriptor_item, size, 64);
> > > +BTRFS_SETGET_FUNCS(remap_address, struct btrfs_remap, address, 64);
> > > +BTRFS_SETGET_STACK_FUNCS(stack_remap_address, struct btrfs_remap, address, 64);
> > > +
> > >   /* Cast into the data area of the leaf. */
> > >   #define btrfs_item_ptr(leaf, slot, type)				\
> > >   	((type *)(btrfs_item_nr_offset(leaf, 0) + btrfs_item_offset(leaf, slot)))
> > > diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> > > index a3e6d9616e60..26f810258486 100644
> > > --- a/fs/btrfs/locking.c
> > > +++ b/fs/btrfs/locking.c
> > > @@ -73,6 +73,7 @@ static struct btrfs_lockdep_keyset {
> > >   	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
> > >   	{ .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block-group") },
> > >   	{ .id = BTRFS_RAID_STRIPE_TREE_OBJECTID, DEFINE_NAME("raid-stripe") },
> > > +	{ .id = BTRFS_REMAP_TREE_OBJECTID,      DEFINE_NAME("remap-tree") },
> > >   	{ .id = 0,				DEFINE_NAME("tree")	},
> > >   };
> > > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > > index 81f52c1f55ce..857d2772db1c 100644
> > > --- a/fs/btrfs/sysfs.c
> > > +++ b/fs/btrfs/sysfs.c
> > > @@ -291,6 +291,7 @@ BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
> > >   BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
> > >   BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
> > >   BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
> > > +BTRFS_FEAT_ATTR_INCOMPAT(remap_tree, REMAP_TREE);
> > >   #ifdef CONFIG_BLK_DEV_ZONED
> > >   BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
> > >   #endif
> > > @@ -325,6 +326,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
> > >   	BTRFS_FEAT_ATTR_PTR(raid1c34),
> > >   	BTRFS_FEAT_ATTR_PTR(block_group_tree),
> > >   	BTRFS_FEAT_ATTR_PTR(simple_quota),
> > > +	BTRFS_FEAT_ATTR_PTR(remap_tree),
> > >   #ifdef CONFIG_BLK_DEV_ZONED
> > >   	BTRFS_FEAT_ATTR_PTR(zoned),
> > >   #endif
> > > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > > index 0f556f4de3f9..76ec3698f197 100644
> > > --- a/fs/btrfs/tree-checker.c
> > > +++ b/fs/btrfs/tree-checker.c
> > > @@ -912,12 +912,10 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
> > >   			  length, btrfs_stripe_nr_to_offset(U32_MAX));
> > >   		return -EUCLEAN;
> > >   	}
> > > -	if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
> > > -			      BTRFS_BLOCK_GROUP_PROFILE_MASK))) {
> > > +	if (unlikely(type & ~BTRFS_BLOCK_GROUP_VALID)) {
> > >   		chunk_err(fs_info, leaf, chunk, logical,
> > >   			  "unrecognized chunk type: 0x%llx",
> > > -			  ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
> > > -			    BTRFS_BLOCK_GROUP_PROFILE_MASK) & type);
> > > +			  type & ~BTRFS_BLOCK_GROUP_VALID);
> > >   		return -EUCLEAN;
> > >   	}
> > > diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
> > > index eb201f4ec3c7..833e2fd989eb 100644
> > > --- a/fs/btrfs/tree-checker.h
> > > +++ b/fs/btrfs/tree-checker.h
> > > @@ -57,6 +57,11 @@ enum btrfs_tree_block_status {
> > >   	BTRFS_TREE_BLOCK_WRITTEN_NOT_SET,
> > >   };
> > > +
> > > +#define BTRFS_BLOCK_GROUP_VALID	(BTRFS_BLOCK_GROUP_TYPE_MASK | \
> > > +				 BTRFS_BLOCK_GROUP_PROFILE_MASK | \
> > > +				 BTRFS_BLOCK_GROUP_REMAPPED)
> > > +
> > 
> > I think the two next lines should be lined up after the '('
> > 
> > See the masks in include/uapi/linux/btrfs_tree.h
> > 
> > >   /*
> > >    * Exported simply for btrfs-progs which wants to have the
> > >    * btrfs_tree_block_status return codes.
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index fa7a929a0461..e067e9cd68a5 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -231,6 +231,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
> > >   	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
> > >   	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
> > >   	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
> > > +	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");
> > >   	DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
> > >   	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
> > > diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> > > index 8e710bbb688e..fba303ed49e6 100644
> > > --- a/include/uapi/linux/btrfs.h
> > > +++ b/include/uapi/linux/btrfs.h
> > > @@ -336,6 +336,7 @@ struct btrfs_ioctl_fs_info_args {
> > >   #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
> > >   #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
> > >   #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
> > > +#define BTRFS_FEATURE_INCOMPAT_REMAP_TREE	(1ULL << 17)
> > >   struct btrfs_ioctl_feature_flags {
> > >   	__u64 compat_flags;
> > > diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> > > index fc29d273845d..4439d77a7252 100644
> > > --- a/include/uapi/linux/btrfs_tree.h
> > > +++ b/include/uapi/linux/btrfs_tree.h
> > > @@ -76,6 +76,9 @@
> > >   /* Tracks RAID stripes in block groups. */
> > >   #define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
> > > +/* Holds details of remapped addresses after relocation. */
> > > +#define BTRFS_REMAP_TREE_OBJECTID 13ULL
> > > +
> > >   /* device stats in the device tree */
> > >   #define BTRFS_DEV_STATS_OBJECTID 0ULL
> > > @@ -282,6 +285,10 @@
> > >   #define BTRFS_RAID_STRIPE_KEY	230
> > > +#define BTRFS_IDENTITY_REMAP_KEY 	234
> > > +#define BTRFS_REMAP_KEY		 	235
> > > +#define BTRFS_REMAP_BACKREF_KEY	 	236
> > 
> > more funny indenting
> > 
> > > +
> > >   /*
> > >    * Records the overall state of the qgroups.
> > >    * There's only one instance of this key present,
> > > @@ -1161,6 +1168,7 @@ struct btrfs_dev_replace_item {
> > >   #define BTRFS_BLOCK_GROUP_RAID6         (1ULL << 8)
> > >   #define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
> > >   #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
> > > +#define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
> > >   #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
> > >   					 BTRFS_SPACE_INFO_GLOBAL_RSV)
> > > @@ -1323,4 +1331,8 @@ struct btrfs_verity_descriptor_item {
> > >   	__u8 encryption;
> > >   } __attribute__ ((__packed__));
> > > +struct btrfs_remap {
> > > +	__le64 address;
> > > +} __attribute__ ((__packed__));
> > > +
> > >   #endif /* _BTRFS_CTREE_H_ */
> > > -- 
> > > 2.49.1
> > > 
> 

