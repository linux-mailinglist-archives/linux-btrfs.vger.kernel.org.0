Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDBD7DFB80
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 21:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjKBU1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 16:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjKBU1F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 16:27:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100EE186
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 13:26:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B3675219C1;
        Thu,  2 Nov 2023 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698956817;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ni53vIIU+gBAXhFYzUsGQbhFi9HbbC6FZUS7ML7VznU=;
        b=kLYnbU6Wg2uFeKpYmxsvxrsL3ZEDNlKHHJetvyD8ySYZ+BrpWf5Ibb/M6CcsIzGjtg5NN/
        pGQft7/8t7NxfdnsvxTb7sK3oqxAb6L3bMIa32RaVGTjbYceNZZbir7Fq9N83RHXPoa1jJ
        7HiZ6czpgM0W1+863XUQi2m8fKWUBBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698956817;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ni53vIIU+gBAXhFYzUsGQbhFi9HbbC6FZUS7ML7VznU=;
        b=zv5YGE+H9VOTv667QL2SQ1O3+tGOq6EEMKCJAKMUuPok01x/WYURtdzmEBK4ToxKbFif/X
        YuMW42a4l5FXfNBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83D13138EC;
        Thu,  2 Nov 2023 20:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HDwoHxEGRGVMOAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 02 Nov 2023 20:26:57 +0000
Date:   Thu, 2 Nov 2023 21:19:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Message-ID: <20231102201958.GJ11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
 <20231102190720.GA113907@zen.localdomain>
 <d69a339c-0cc2-4168-ac90-f6c1b91517b4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d69a339c-0cc2-4168-ac90-f6c1b91517b4@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
> >> [BUG]
> >> There is a bug report that ntfs2btrfs had a bug that it can lead to
> >> transaction abort and the filesystem flips to read-only.
> >>
> >> [CAUSE]
> >> For inline backref items, kernel has a strict requirement for their
> >> ordered, they must follow the following rules:
> >>
> >> - All btrfs_extent_inline_ref::type should be in an ascending order
> >>
> >> - Within the same type, the items should follow a descending order by
> >>    their sequence number
> >>
> >>    For EXTENT_DATA_REF type, the sequence number is result from
> >>    hash_extent_data_ref().
> >>    For other types, their sequence numbers are
> >>    btrfs_extent_inline_ref::offset.
> >>
> >> Thus if there is any code not following above rules, the resulted
> >> inline backrefs can prevent the kernel to locate the needed inline
> >> backref and lead to transaction abort.
> >>
> >> [FIX]
> >> Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added the
> >> ability to detect such problems.
> >>
> >> For kernel, let's be more noisy and be more specific about the order, so
> >> that the next time kernel hits such problem we would reject it in the
> >> first place, without leading to transaction abort.
> >>
> >> Link: https://github.com/kdave/btrfs-progs/pull/622
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/tree-checker.c | 38 ++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 38 insertions(+)
> >>
> >> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> >> index a416cbea75d1..981ad301d29d 100644
> >> --- a/fs/btrfs/tree-checker.c
> >> +++ b/fs/btrfs/tree-checker.c
> >> @@ -31,6 +31,7 @@
> >>   #include "inode-item.h"
> >>   #include "dir-item.h"
> >>   #include "raid-stripe-tree.h"
> >> +#include "extent-tree.h"
> >>
> >>   /*
> >>    * Error message should follow the following format:
> >> @@ -1276,6 +1277,8 @@ static int check_extent_item(struct extent_buffer *leaf,
> >>   	unsigned long ptr;	/* Current pointer inside inline refs */
> >>   	unsigned long end;	/* Extent item end */
> >>   	const u32 item_size = btrfs_item_size(leaf, slot);
> >> +	u8 last_type = 0;
> >> +	u64 last_seq = U64_MAX;
> >>   	u64 flags;
> >>   	u64 generation;
> >>   	u64 total_refs;		/* Total refs in btrfs_extent_item */
> >> @@ -1322,6 +1325,17 @@ static int check_extent_item(struct extent_buffer *leaf,
> >>   	 *    2.2) Ref type specific data
> >>   	 *         Either using btrfs_extent_inline_ref::offset, or specific
> >>   	 *         data structure.
> >> +	 *    All above inline items should follow the order:
> >> +	 *
> >> +	 *    - All btrfs_extent_inline_ref::type should be in an ascending
> >> +	 *      order
> >> +	 *
> >> +	 *    - Within the same type, the items should follow a descending
> >> +	 *      order by their sequence number
> >> +	 *      The sequence number is determined by:
> >> +	 *      * btrfs_extent_inline_ref::offset for all types  other than
> >> +	 *        EXTENT_DATA_REF
> >> +	 *      * hash_extent_data_ref() for EXTENT_DATA_REF
> >>   	 */
> >>   	if (unlikely(item_size < sizeof(*ei))) {
> >>   		extent_err(leaf, slot,
> >> @@ -1403,6 +1417,7 @@ static int check_extent_item(struct extent_buffer *leaf,
> >>   		struct btrfs_extent_inline_ref *iref;
> >>   		struct btrfs_extent_data_ref *dref;
> >>   		struct btrfs_shared_data_ref *sref;
> >> +		u64 seq;
> >>   		u64 dref_offset;
> >>   		u64 inline_offset;
> >>   		u8 inline_type;
> >> @@ -1416,6 +1431,7 @@ static int check_extent_item(struct extent_buffer *leaf,
> >>   		iref = (struct btrfs_extent_inline_ref *)ptr;
> >>   		inline_type = btrfs_extent_inline_ref_type(leaf, iref);
> >>   		inline_offset = btrfs_extent_inline_ref_offset(leaf, iref);
> >> +		seq = inline_offset;
> >>   		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > end)) {
> >>   			extent_err(leaf, slot,
> >>   "inline ref item overflows extent item, ptr %lu iref size %u end %lu",
> >> @@ -1446,6 +1462,10 @@ static int check_extent_item(struct extent_buffer *leaf,
> >>   		case BTRFS_EXTENT_DATA_REF_KEY:
> >>   			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
> >>   			dref_offset = btrfs_extent_data_ref_offset(leaf, dref);
> >> +			seq = hash_extent_data_ref(
> >> +					btrfs_extent_data_ref_root(leaf, dref),
> >> +					btrfs_extent_data_ref_objectid(leaf, dref),
> >> +					btrfs_extent_data_ref_offset(leaf, dref));
> >>   			if (unlikely(!IS_ALIGNED(dref_offset,
> >>   						 fs_info->sectorsize))) {
> >>   				extent_err(leaf, slot,
> >> @@ -1475,6 +1495,24 @@ static int check_extent_item(struct extent_buffer *leaf,
> >>   				   inline_type);
> >>   			return -EUCLEAN;
> >>   		}
> >> +		if (inline_type < last_type) {
> >> +			extent_err(leaf, slot,
> >> +				   "inline ref out-of-order: has type %u, prev type %u",
> >> +				   inline_type, last_type);
> >> +			return -EUCLEAN;
> >> +		}
> >> +		/* Type changed, allow the sequence starts from U64_MAX again. */
> >> +		if (inline_type > last_type)
> >> +			last_seq = U64_MAX;
> >> +		if (seq > last_seq) {
> >> +			extent_err(leaf, slot,
> >> +"inline ref out-of-order: has type %u offset %llu seq 0x%llx, prev type %u seq 0x%llx",
> >> +				   inline_type, inline_offset, seq,
> >> +				   last_type, last_seq);
> >> +			return -EUCLEAN;
> >> +		}
> >> +		last_type = inline_type;
> >> +		last_seq = seq;
> >>   		ptr += btrfs_extent_inline_ref_size(inline_type);
> >>   	}
> >>   	/* No padding is allowed */
> >> --
> >> 2.42.0
> >>
> >
> > I believe this breaks simple quotas EXTENT_OWNER_REF_KEY items which
> > have type 188 but come in before the other inline items.
> 
> Does it mean EXTENT_OWNER_REF_KEY is another odd ball, which doesn't
> follow the existing type/inline ref order?
> 
> If so, can we fix it in the kernel first?

It's still time to do such changes.
