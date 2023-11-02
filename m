Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087C97DFC03
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 22:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjKBVdR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 17:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBVdP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 17:33:15 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA625187
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 14:33:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1CBE65C01D3;
        Thu,  2 Nov 2023 17:33:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 02 Nov 2023 17:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1698960789; x=1699047189; bh=w6
        6NbE6Js3BxEUkyUrap5EFfr5svTI2q473gN9bEcfo=; b=BdT4mza//7Cd4rdGoH
        TTphYio4Tj2BMKWCMwkAbKJhiHjib/Hcwmlh7pGrTx+VOmY6wfnBuXE6izpJoz5j
        FsQ2LUoXirjPFeQe2J4J1P0jbHMNKOY+X2js1zjZ073IkHQ1jaCXVHWt8MD6Ybsd
        NgbkUMc01e8DdH2fcaJiu3uakRtR6aouVz8KR6VidK5LIlU7DTdRfij3dd9g4xr9
        yoQRWrq8PRkaKZtPFEU6PmMCaLKAQfnTPlMCMWSJXjBOkLNungNPHGKKD6SFLGlq
        hiRnEPF7xReluUFbCYcjsTvnc28kMiPvETJTFU9Vjz3FzfWFkkOfg9F4dj3p9v2Q
        haqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698960789; x=1699047189; bh=w66NbE6Js3BxE
        UkyUrap5EFfr5svTI2q473gN9bEcfo=; b=GP4t6Z7fGuCg/WJYVQ0pbyEaP1oBB
        sZIAA9M3ndSa7q23xPJhAlEWd0ltJntmHe0A5DniZbSIe9IpibGE9+oclOJfNWBt
        UWUdw06gvDJQjeNV4+sOxDATpyAk5rxIW2+FzOUc7Ss8i+tqhi1Uszk7PJY9xxVG
        t0GfTv80TRnK2IRnY7SRP7tENRqFOF0kH5buUQJwcUiLNbNCeh0Z1hUGczEi1VCS
        PHqu09YqLTVy5rfkLJf2eBhzIt4GTjx6KBnaKIHnGStqVMTHbBGytSu7cObfxLFv
        OL0z30ySmmqWFgoH1W8nwnBpWWlrw+7Sfz2bP65a57TsrMjIHUbIb+uIQ==
X-ME-Sender: <xms:lBVEZSGruuRh-E2693ahRIc8B1WON1rI716h7cINiDhP2DD1yfGr3Q>
    <xme:lBVEZTWfnMFa5KEOqaZM2QJ8lTccZ3Fic-4X2g9t-BYlajFz5zwwZMNE7mKkT6eBt
    2Hrzj3jja29Rjg9Pfs>
X-ME-Received: <xmr:lBVEZcK_9dglc1hA8NHcPHTupRv29cv6zWGi1dEENu_VY0WzZP2V96OkoxPEuZPuHi3w0PaJ7jhU1WWDsWs2IOtPXTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtiedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epleffgeevgeetueegledtueeluddtudekhefhudeuheegfeevieehteevieejueetnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:lBVEZcFdpnINTwN9M7ONEDdP1sIvoAldtkIm4klxkSy9NVPUHvBPZg>
    <xmx:lBVEZYUVQVFyhoIeNhD8P0OegM-igRajHG8MLmqt7atc_r_D8hB1cA>
    <xmx:lBVEZfNDjr_zIn5CorhXx79qqWKePVY0VswZSNR5mdkThjBuNrCcvg>
    <xmx:lRVEZTcA6aK7Trgd09m2TN_LAnH0fmNmD8F6s0FmOq5dSkBrq_DsPQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 17:33:08 -0400 (EDT)
Date:   Thu, 2 Nov 2023 14:34:30 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Message-ID: <20231102213430.GA123227@zen.localdomain>
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
 <20231102190720.GA113907@zen.localdomain>
 <d69a339c-0cc2-4168-ac90-f6c1b91517b4@gmx.com>
 <20231102203529.GA119621@zen.localdomain>
 <12595173-fdc6-4e49-9e37-e97a6b7e8606@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12595173-fdc6-4e49-9e37-e97a6b7e8606@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 03, 2023 at 07:35:48AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/3 07:05, Boris Burkov wrote:
> > On Fri, Nov 03, 2023 at 06:47:59AM +1030, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2023/11/3 05:37, Boris Burkov wrote:
> > > > On Tue, Oct 24, 2023 at 12:41:11PM +1030, Qu Wenruo wrote:
> > > > > [BUG]
> > > > > There is a bug report that ntfs2btrfs had a bug that it can lead to
> > > > > transaction abort and the filesystem flips to read-only.
> > > > > 
> > > > > [CAUSE]
> > > > > For inline backref items, kernel has a strict requirement for their
> > > > > ordered, they must follow the following rules:
> > > > > 
> > > > > - All btrfs_extent_inline_ref::type should be in an ascending order
> > > > > 
> > > > > - Within the same type, the items should follow a descending order by
> > > > >     their sequence number
> > > > > 
> > > > >     For EXTENT_DATA_REF type, the sequence number is result from
> > > > >     hash_extent_data_ref().
> > > > >     For other types, their sequence numbers are
> > > > >     btrfs_extent_inline_ref::offset.
> > > > > 
> > > > > Thus if there is any code not following above rules, the resulted
> > > > > inline backrefs can prevent the kernel to locate the needed inline
> > > > > backref and lead to transaction abort.
> > > > > 
> > > > > [FIX]
> > > > > Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added the
> > > > > ability to detect such problems.
> > > > > 
> > > > > For kernel, let's be more noisy and be more specific about the order, so
> > > > > that the next time kernel hits such problem we would reject it in the
> > > > > first place, without leading to transaction abort.
> > > > > 
> > > > > Link: https://github.com/kdave/btrfs-progs/pull/622
> > > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > > > ---
> > > > >    fs/btrfs/tree-checker.c | 38 ++++++++++++++++++++++++++++++++++++++
> > > > >    1 file changed, 38 insertions(+)
> > > > > 
> > > > > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > > > > index a416cbea75d1..981ad301d29d 100644
> > > > > --- a/fs/btrfs/tree-checker.c
> > > > > +++ b/fs/btrfs/tree-checker.c
> > > > > @@ -31,6 +31,7 @@
> > > > >    #include "inode-item.h"
> > > > >    #include "dir-item.h"
> > > > >    #include "raid-stripe-tree.h"
> > > > > +#include "extent-tree.h"
> > > > > 
> > > > >    /*
> > > > >     * Error message should follow the following format:
> > > > > @@ -1276,6 +1277,8 @@ static int check_extent_item(struct extent_buffer *leaf,
> > > > >    	unsigned long ptr;	/* Current pointer inside inline refs */
> > > > >    	unsigned long end;	/* Extent item end */
> > > > >    	const u32 item_size = btrfs_item_size(leaf, slot);
> > > > > +	u8 last_type = 0;
> > > > > +	u64 last_seq = U64_MAX;
> > > > >    	u64 flags;
> > > > >    	u64 generation;
> > > > >    	u64 total_refs;		/* Total refs in btrfs_extent_item */
> > > > > @@ -1322,6 +1325,17 @@ static int check_extent_item(struct extent_buffer *leaf,
> > > > >    	 *    2.2) Ref type specific data
> > > > >    	 *         Either using btrfs_extent_inline_ref::offset, or specific
> > > > >    	 *         data structure.
> > > > > +	 *    All above inline items should follow the order:
> > > > > +	 *
> > > > > +	 *    - All btrfs_extent_inline_ref::type should be in an ascending
> > > > > +	 *      order
> > > > > +	 *
> > > > > +	 *    - Within the same type, the items should follow a descending
> > > > > +	 *      order by their sequence number
> > > > > +	 *      The sequence number is determined by:
> > > > > +	 *      * btrfs_extent_inline_ref::offset for all types  other than
> > > > > +	 *        EXTENT_DATA_REF
> > > > > +	 *      * hash_extent_data_ref() for EXTENT_DATA_REF
> > > > >    	 */
> > > > >    	if (unlikely(item_size < sizeof(*ei))) {
> > > > >    		extent_err(leaf, slot,
> > > > > @@ -1403,6 +1417,7 @@ static int check_extent_item(struct extent_buffer *leaf,
> > > > >    		struct btrfs_extent_inline_ref *iref;
> > > > >    		struct btrfs_extent_data_ref *dref;
> > > > >    		struct btrfs_shared_data_ref *sref;
> > > > > +		u64 seq;
> > > > >    		u64 dref_offset;
> > > > >    		u64 inline_offset;
> > > > >    		u8 inline_type;
> > > > > @@ -1416,6 +1431,7 @@ static int check_extent_item(struct extent_buffer *leaf,
> > > > >    		iref = (struct btrfs_extent_inline_ref *)ptr;
> > > > >    		inline_type = btrfs_extent_inline_ref_type(leaf, iref);
> > > > >    		inline_offset = btrfs_extent_inline_ref_offset(leaf, iref);
> > > > > +		seq = inline_offset;
> > > > >    		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > end)) {
> > > > >    			extent_err(leaf, slot,
> > > > >    "inline ref item overflows extent item, ptr %lu iref size %u end %lu",
> > > > > @@ -1446,6 +1462,10 @@ static int check_extent_item(struct extent_buffer *leaf,
> > > > >    		case BTRFS_EXTENT_DATA_REF_KEY:
> > > > >    			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
> > > > >    			dref_offset = btrfs_extent_data_ref_offset(leaf, dref);
> > > > > +			seq = hash_extent_data_ref(
> > > > > +					btrfs_extent_data_ref_root(leaf, dref),
> > > > > +					btrfs_extent_data_ref_objectid(leaf, dref),
> > > > > +					btrfs_extent_data_ref_offset(leaf, dref));
> > > > >    			if (unlikely(!IS_ALIGNED(dref_offset,
> > > > >    						 fs_info->sectorsize))) {
> > > > >    				extent_err(leaf, slot,
> > > > > @@ -1475,6 +1495,24 @@ static int check_extent_item(struct extent_buffer *leaf,
> > > > >    				   inline_type);
> > > > >    			return -EUCLEAN;
> > > > >    		}
> > > > > +		if (inline_type < last_type) {
> > > > > +			extent_err(leaf, slot,
> > > > > +				   "inline ref out-of-order: has type %u, prev type %u",
> > > > > +				   inline_type, last_type);
> > > > > +			return -EUCLEAN;
> > > > > +		}
> > > > > +		/* Type changed, allow the sequence starts from U64_MAX again. */
> > > > > +		if (inline_type > last_type)
> > > > > +			last_seq = U64_MAX;
> > > > > +		if (seq > last_seq) {
> > > > > +			extent_err(leaf, slot,
> > > > > +"inline ref out-of-order: has type %u offset %llu seq 0x%llx, prev type %u seq 0x%llx",
> > > > > +				   inline_type, inline_offset, seq,
> > > > > +				   last_type, last_seq);
> > > > > +			return -EUCLEAN;
> > > > > +		}
> > > > > +		last_type = inline_type;
> > > > > +		last_seq = seq;
> > > > >    		ptr += btrfs_extent_inline_ref_size(inline_type);
> > > > >    	}
> > > > >    	/* No padding is allowed */
> > > > > --
> > > > > 2.42.0
> > > > > 
> > > > 
> > > > I believe this breaks simple quotas EXTENT_OWNER_REF_KEY items which
> > > > have type 188 but come in before the other inline items.
> > > 
> > > Does it mean EXTENT_OWNER_REF_KEY is another odd ball, which doesn't
> > > follow the existing type/inline ref order?
> > 
> > Yes, I suppose it does. I didn't see that invariant documented anywhere,
> > so I apologize for breaking it. It does seem like a valuable invariant
> > to keep the inline items sorted.
> 
> Not a big deal, in fact we all hit the same situation, and that's why
> we're adding tree-checker, kinda like a slightly better documented
> on-disk format.

+1, Love "documenting" via tree-checker :)

> 
> > 
> > If it's possible at this stage to change the type number to be 170 or
> > something, I think that would fix it, and would be a much less intrusive
> > change than pushing the owner ref item to the back of the inline refs,
> > which would complicate parsing a lot more, IMO.
> 
> I believe this is much better solution.

Agreed. I hope it's possible! Dave, can you weigh in on whether this
exact change can be done at this point? You suggested upthread that it
should be, but I just want to be sure.

> 
> Especially we have EXPERIMENTAL flags for btrfs-progs, thus it should
> give us quite some period to tweak the on-disk format.
> 
> Although even I submitted a tree-checker for this, I'm not a fan of the
> existing weird ordering thing for inlined backrefs at all.
> 
> I'd prefer to have no order at all (it's not that bad, since the
> backrefs are already inlined, but can still bring small perf drop), or
> fully ordered (type and seq follow the same ascending or descending order).
> 
> But this needs a on-disk format change, and even we introduced such
> change it would still take a long time to deprecate the existing order.
> 
> So I'm afraid we would stick to the existing order.

+1

> 
> > 
> > OTOH, in general, the parsing has to have special cases for the owner ref
> > inline item since it is per extent, not per ref, so I don't see why it
> > couldn't just skip it here too.
> 
> Yeah, it's not hard to do in the code, but for the sake of consistency,
> I'd really prefer it to follow some existing order, even if the existing
> one is already weird...
> 

"Existing order is owner ref, then weird hash/type order for the rest" :P

> 
> 
> Another thing to mention is, that EXTENT_OWNER_REF seems to be inlined
> only, has no keyed version.
> 
> I have already come upon a rare corner case:
> 
>   What if an EXTENT_ITEM is already so large that it can not add a new
>   inline ref?
> 
> I guess this can only be a problem for converting, as for now squota can
> only be enabled at mkfs time, thus the new EXTENT_OWNER_REF can always
> be inlined.

It's a good point, but the answer is slightly subtler. You can enable
squota on a live fs, it just doesn't/can't do the O(extents)
conversion for existing extents. The owner ref is created for all *new*
extent items, but when creating an extent item, you dictate the item
size which leaves enough room for the inline refs (including the owner
ref).

> 
> Thanks,
> Qu
> 
> > 
> > e.g., this works to fix it:
> > 
> > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > index 50fdc69fdddf..62150419c6d4 100644
> > --- a/fs/btrfs/tree-checker.c
> > +++ b/fs/btrfs/tree-checker.c
> > @@ -1496,6 +1496,9 @@ static int check_extent_item(struct extent_buffer *leaf,
> >   				   inline_type);
> >   			return -EUCLEAN;
> >   		}
> > +
> > +		if (last_type == BTRFS_EXTENT_OWNER_REF_KEY)
> > +			goto next;
> >   		if (inline_type < last_type) {
> >   			extent_err(leaf, slot,
> >   				   "inline ref out-of-order: has type %u, prev type %u",
> > @@ -1512,6 +1515,7 @@ static int check_extent_item(struct extent_buffer *leaf,
> >   				   last_type, last_seq);
> >   			return -EUCLEAN;
> >   		}
> > +next:
> >   		last_type = inline_type;
> >   		last_seq = seq;
> >   		ptr += btrfs_extent_inline_ref_size(inline_type);
> > 
> > > 
> > > If so, can we fix it in the kernel first?
> > > 
> > > Thanks,
> > > Qu
> > > > 
> > > > For a repro, btrfs/301 (available in the master fstests branch) fails
> > > > with the patch but passes without it.
