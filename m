Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D037DFB99
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 21:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345031AbjKBUeT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 16:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKBUeS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 16:34:18 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161D2138
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 13:34:12 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id DBA675C015E;
        Thu,  2 Nov 2023 16:34:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 02 Nov 2023 16:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1698957248; x=1699043648; bh=rD
        s8gcNQnD5hQOI+n4YWt6b8TS+5sVEuZFV5tc+/GEY=; b=SzmQ/3d4mPRZD41pA9
        kiKr2IHdKVwUs4oF53Qw7WwXlR+RiQpPolsTP/S5BRyPfxM+qNA9C2mzQwplDX1a
        kfCNfOE1wlvCExLakKqfm+KZ/XfDNO7HRTDc4B471Hm6UOCDseB9y559a8l9UOiU
        jTL3vA2XA9gsiJLOLxzxWhfwJAlQtF+XvTkESab00B0obaK2pKFFCyoj/rkiQm9E
        vLN2lCiTG+KOKbOEkbz7XIG/ZzVJg99nrue7vtfcFuhunZyoUAJhYwYXU7WyFs4i
        C3vBjpMsb437kDFpxBoQHiizYaeT//7BKmDZ1DhgJUSLxQF3sdNPOo3ISX9WMPHY
        20qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698957248; x=1699043648; bh=rDs8gcNQnD5hQ
        OI+n4YWt6b8TS+5sVEuZFV5tc+/GEY=; b=SoDz8g/LdwgRC6CNtfZ7EESgtCloS
        yS9MJLqwpNQrjf9jD8SXvuqdJrLl07+y36b3e7MVzQFFEFlFouBxyx+ATOcJTim4
        72VwGe4qHoK030z9nIgtNVyO45dLShzkyVbUOmXJiZz3u7MCPMgO9J++Md106jwy
        Vsz7I32zSWB/mKHF2FIBiTeS/IqC+cqetcxuAIN13FbHoidgQ2t7ePBdXVfJtDzK
        3jEIesRzg8hw6D64U7BPkYWcTvQw0dn1klT3BOdXBQQx1+sm4n0O/xAaSMjpQu00
        fLLV39fLPUJfjsLjcXhQGjuTdv9DIX47y4C/h350dsZLp9SyMxDqa2vqg==
X-ME-Sender: <xms:wAdEZQvSMuuiwUUD1vyIOB6_uYBEfrA4nG3rvIoNBlaF-LloCJBM8A>
    <xme:wAdEZddsc0HqiHrg5UrkaG_yMr8g7nCYlMS2dnddbWuETE4kxYYP0lttmgq3f7qx5
    4wxIQDg9mn-5jZ6XjY>
X-ME-Received: <xmr:wAdEZbzZglEDOc9bz1UmoOpGLdJds2_kTpJonLcRL_sOiFAURjzyd9Oz2RQOGsNmNT8fbEiXLPEwyjmZm-TXBGavT7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtiedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epleffgeevgeetueegledtueeluddtudekhefhudeuheegfeevieehteevieejueetnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:wAdEZTMJiUoHFjV1ilzj2mKt4bJC16J_9x7tiX9xwQMmJB6hQFlgTA>
    <xmx:wAdEZQ-B5MuPR5HHV4K5eaHuYhapi7vK3zunam0wD3ZU9YNOo-7G5A>
    <xmx:wAdEZbUJ-Zgxq7U6SZARI5ZLDVpnH8xjRmdlEsGuC3o3cn-Rf9mN3w>
    <xmx:wAdEZennFtVlU6H7m_XTrSWn2l_Vp1EyIZxsGbBeFlwYU54iVo1flA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 16:34:08 -0400 (EDT)
Date:   Thu, 2 Nov 2023 13:35:29 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Message-ID: <20231102203529.GA119621@zen.localdomain>
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
 <20231102190720.GA113907@zen.localdomain>
 <d69a339c-0cc2-4168-ac90-f6c1b91517b4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d69a339c-0cc2-4168-ac90-f6c1b91517b4@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 03, 2023 at 06:47:59AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/3 05:37, Boris Burkov wrote:
> > On Tue, Oct 24, 2023 at 12:41:11PM +1030, Qu Wenruo wrote:
> > > [BUG]
> > > There is a bug report that ntfs2btrfs had a bug that it can lead to
> > > transaction abort and the filesystem flips to read-only.
> > > 
> > > [CAUSE]
> > > For inline backref items, kernel has a strict requirement for their
> > > ordered, they must follow the following rules:
> > > 
> > > - All btrfs_extent_inline_ref::type should be in an ascending order
> > > 
> > > - Within the same type, the items should follow a descending order by
> > >    their sequence number
> > > 
> > >    For EXTENT_DATA_REF type, the sequence number is result from
> > >    hash_extent_data_ref().
> > >    For other types, their sequence numbers are
> > >    btrfs_extent_inline_ref::offset.
> > > 
> > > Thus if there is any code not following above rules, the resulted
> > > inline backrefs can prevent the kernel to locate the needed inline
> > > backref and lead to transaction abort.
> > > 
> > > [FIX]
> > > Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added the
> > > ability to detect such problems.
> > > 
> > > For kernel, let's be more noisy and be more specific about the order, so
> > > that the next time kernel hits such problem we would reject it in the
> > > first place, without leading to transaction abort.
> > > 
> > > Link: https://github.com/kdave/btrfs-progs/pull/622
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   fs/btrfs/tree-checker.c | 38 ++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 38 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > > index a416cbea75d1..981ad301d29d 100644
> > > --- a/fs/btrfs/tree-checker.c
> > > +++ b/fs/btrfs/tree-checker.c
> > > @@ -31,6 +31,7 @@
> > >   #include "inode-item.h"
> > >   #include "dir-item.h"
> > >   #include "raid-stripe-tree.h"
> > > +#include "extent-tree.h"
> > > 
> > >   /*
> > >    * Error message should follow the following format:
> > > @@ -1276,6 +1277,8 @@ static int check_extent_item(struct extent_buffer *leaf,
> > >   	unsigned long ptr;	/* Current pointer inside inline refs */
> > >   	unsigned long end;	/* Extent item end */
> > >   	const u32 item_size = btrfs_item_size(leaf, slot);
> > > +	u8 last_type = 0;
> > > +	u64 last_seq = U64_MAX;
> > >   	u64 flags;
> > >   	u64 generation;
> > >   	u64 total_refs;		/* Total refs in btrfs_extent_item */
> > > @@ -1322,6 +1325,17 @@ static int check_extent_item(struct extent_buffer *leaf,
> > >   	 *    2.2) Ref type specific data
> > >   	 *         Either using btrfs_extent_inline_ref::offset, or specific
> > >   	 *         data structure.
> > > +	 *    All above inline items should follow the order:
> > > +	 *
> > > +	 *    - All btrfs_extent_inline_ref::type should be in an ascending
> > > +	 *      order
> > > +	 *
> > > +	 *    - Within the same type, the items should follow a descending
> > > +	 *      order by their sequence number
> > > +	 *      The sequence number is determined by:
> > > +	 *      * btrfs_extent_inline_ref::offset for all types  other than
> > > +	 *        EXTENT_DATA_REF
> > > +	 *      * hash_extent_data_ref() for EXTENT_DATA_REF
> > >   	 */
> > >   	if (unlikely(item_size < sizeof(*ei))) {
> > >   		extent_err(leaf, slot,
> > > @@ -1403,6 +1417,7 @@ static int check_extent_item(struct extent_buffer *leaf,
> > >   		struct btrfs_extent_inline_ref *iref;
> > >   		struct btrfs_extent_data_ref *dref;
> > >   		struct btrfs_shared_data_ref *sref;
> > > +		u64 seq;
> > >   		u64 dref_offset;
> > >   		u64 inline_offset;
> > >   		u8 inline_type;
> > > @@ -1416,6 +1431,7 @@ static int check_extent_item(struct extent_buffer *leaf,
> > >   		iref = (struct btrfs_extent_inline_ref *)ptr;
> > >   		inline_type = btrfs_extent_inline_ref_type(leaf, iref);
> > >   		inline_offset = btrfs_extent_inline_ref_offset(leaf, iref);
> > > +		seq = inline_offset;
> > >   		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > end)) {
> > >   			extent_err(leaf, slot,
> > >   "inline ref item overflows extent item, ptr %lu iref size %u end %lu",
> > > @@ -1446,6 +1462,10 @@ static int check_extent_item(struct extent_buffer *leaf,
> > >   		case BTRFS_EXTENT_DATA_REF_KEY:
> > >   			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
> > >   			dref_offset = btrfs_extent_data_ref_offset(leaf, dref);
> > > +			seq = hash_extent_data_ref(
> > > +					btrfs_extent_data_ref_root(leaf, dref),
> > > +					btrfs_extent_data_ref_objectid(leaf, dref),
> > > +					btrfs_extent_data_ref_offset(leaf, dref));
> > >   			if (unlikely(!IS_ALIGNED(dref_offset,
> > >   						 fs_info->sectorsize))) {
> > >   				extent_err(leaf, slot,
> > > @@ -1475,6 +1495,24 @@ static int check_extent_item(struct extent_buffer *leaf,
> > >   				   inline_type);
> > >   			return -EUCLEAN;
> > >   		}
> > > +		if (inline_type < last_type) {
> > > +			extent_err(leaf, slot,
> > > +				   "inline ref out-of-order: has type %u, prev type %u",
> > > +				   inline_type, last_type);
> > > +			return -EUCLEAN;
> > > +		}
> > > +		/* Type changed, allow the sequence starts from U64_MAX again. */
> > > +		if (inline_type > last_type)
> > > +			last_seq = U64_MAX;
> > > +		if (seq > last_seq) {
> > > +			extent_err(leaf, slot,
> > > +"inline ref out-of-order: has type %u offset %llu seq 0x%llx, prev type %u seq 0x%llx",
> > > +				   inline_type, inline_offset, seq,
> > > +				   last_type, last_seq);
> > > +			return -EUCLEAN;
> > > +		}
> > > +		last_type = inline_type;
> > > +		last_seq = seq;
> > >   		ptr += btrfs_extent_inline_ref_size(inline_type);
> > >   	}
> > >   	/* No padding is allowed */
> > > --
> > > 2.42.0
> > > 
> > 
> > I believe this breaks simple quotas EXTENT_OWNER_REF_KEY items which
> > have type 188 but come in before the other inline items.
> 
> Does it mean EXTENT_OWNER_REF_KEY is another odd ball, which doesn't
> follow the existing type/inline ref order?

Yes, I suppose it does. I didn't see that invariant documented anywhere,
so I apologize for breaking it. It does seem like a valuable invariant
to keep the inline items sorted.

If it's possible at this stage to change the type number to be 170 or
something, I think that would fix it, and would be a much less intrusive
change than pushing the owner ref item to the back of the inline refs,
which would complicate parsing a lot more, IMO.

OTOH, in general, the parsing has to have special cases for the owner ref
inline item since it is per extent, not per ref, so I don't see why it
couldn't just skip it here too.

e.g., this works to fix it:

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 50fdc69fdddf..62150419c6d4 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1496,6 +1496,9 @@ static int check_extent_item(struct extent_buffer *leaf,
 				   inline_type);
 			return -EUCLEAN;
 		}
+
+		if (last_type == BTRFS_EXTENT_OWNER_REF_KEY)
+			goto next;
 		if (inline_type < last_type) {
 			extent_err(leaf, slot,
 				   "inline ref out-of-order: has type %u, prev type %u",
@@ -1512,6 +1515,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 				   last_type, last_seq);
 			return -EUCLEAN;
 		}
+next:
 		last_type = inline_type;
 		last_seq = seq;
 		ptr += btrfs_extent_inline_ref_size(inline_type);

> 
> If so, can we fix it in the kernel first?
> 
> Thanks,
> Qu
> > 
> > For a repro, btrfs/301 (available in the master fstests branch) fails
> > with the patch but passes without it.
