Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD47D4B120C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 16:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243747AbiBJPtU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 10:49:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiBJPtT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 10:49:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F9B72
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 07:49:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D29FF60C73
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 15:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5042C004E1;
        Thu, 10 Feb 2022 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644508159;
        bh=b7Xgsb7BHdyldtROLny0lLDNpcroQ5/pR5yYJCp7FaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaltLHNKHhygiehynu6Rs16WunAphgt9GzJVkkQ+JHMGn2J96PubPVPW8MDL1AbU6
         kOQIvSaP6h3OkBK5fRLBCaJvxNMMh+XIJVU5BsgwBRD6E1IHySN3gmfWQRQFELDAUJ
         GSlGwhglOWfL8zhPvUPSzyaUebGnp38fX+IPs+AJ4fkw+/1ztIuMrC701Z91DUZKPP
         f9JMpDaFgPQh+B7QY046elVz2vXuq8r9QUOWO8/gM1RT8pB0GqCYRs6xRE8/WZV4vo
         HpkNlObscB+Cj5vuY0hhNxw5DlLW3XU/0N8sk9brViRMhI1BmXqNm3iALcjcSw68tT
         GGUAty2GAOt9Q==
Date:   Thu, 10 Feb 2022 15:49:16 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: defrag: don't use merged extent map for
 their generation check
Message-ID: <YgUz/N4PowPusbZJ@debian9.Home>
References: <cover.1644301903.git.wqu@suse.com>
 <fe880742bbee1e1c219c7b468300724a3336107d.1644301903.git.wqu@suse.com>
 <YgPhzFA3230j2mlf@debian9.Home>
 <6b0f23dd-1808-609c-3f97-17f58a4f4688@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b0f23dd-1808-609c-3f97-17f58a4f4688@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 08:40:22AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/9 23:46, Filipe Manana wrote:
> > On Tue, Feb 08, 2022 at 02:36:31PM +0800, Qu Wenruo wrote:
> > > For extent maps, if they are not compressed extents and are adjacent by
> > > logical addresses and file offsets, they can be merged into one larger
> > > extent map.
> > > 
> > > Such merged extent map will have the higher generation of all the
> > > original ones.
> > > 
> > > This behavior won't affect fsync code, as only extents read from disks
> > > can be merged.
> > 
> > That is not true. An extent created by a write can be merged after a
> > fsync runs and logs the extent. So yes, extent maps created by writes
> > can be merged, but only after an fsync.
> 
> Or, if there is no fsync(), the em will never be mergeable, unless evicted
> and re-read.
> 
> In setup_extent_mapping() if @modified is true, we call
> "list_move(&em->list, &tree->modified_extents)".
> 
> So it means such em will not be merged, as try_merge_map() needs the
> em::list to be empty.
> 
> Then check when em::list is deleted, there are two paths to remove em::list:
> 
> - remove_extent_mapping()
> 
> - btrfs_log_inode()/btrfs_log_changed_extents()
> 
> This explains why under my test cases which only use sync(), those extent
> maps never get merged, unless removed and read from tree again.
> 
> I'm wondering now if this is expected behavior?

Yes, it's expected.

Thanks.
> 
> Thanks,
> Qu
> 
> > 
> > > 
> > > But this brings a problem for autodefrag, as it relies on accurate
> > > extent_map::generation to determine if one extent should be defragged.
> > > 
> > > For merged extent maps, their higher generation can mark some older
> > > extents to be defragged while the original extent map doesn't meet the
> > > minimal generation threshold.
> > > 
> > > Thus this will cause extra IO.
> > > 
> > > So solve the problem, here we introduce a new flag, EXTENT_FLAG_MERGED, to
> > > indicate if the extent map is merged from one or more ems.
> > > 
> > > And for autodefrag, if we find a merged extent map, and its generation
> > > meets the generation requirement, we just don't use this one, and go
> > > back to defrag_get_extent() to read em from disk.
> > 
> > Instead of saying from disk, I would say from the subvolume btree. That
> > may or may not require reading a leaf, and any nodes in the path from the
> > root to the leaf, from disk.
> > 
> > > 
> > > This could cause more read IO, but should result less defrag data write,
> > > so in the long run it should be a win for autodefrag.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   fs/btrfs/extent_map.c |  2 ++
> > >   fs/btrfs/extent_map.h |  8 ++++++++
> > >   fs/btrfs/ioctl.c      | 14 ++++++++++++++
> > >   3 files changed, 24 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> > > index 5a36add21305..c28ceddefae4 100644
> > > --- a/fs/btrfs/extent_map.c
> > > +++ b/fs/btrfs/extent_map.c
> > > @@ -261,6 +261,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
> > >   			em->mod_len = (em->mod_len + em->mod_start) - merge->mod_start;
> > >   			em->mod_start = merge->mod_start;
> > >   			em->generation = max(em->generation, merge->generation);
> > > +			set_bit(EXTENT_FLAG_MERGED, &em->flags);
> > >   			rb_erase_cached(&merge->rb_node, &tree->map);
> > >   			RB_CLEAR_NODE(&merge->rb_node);
> > > @@ -278,6 +279,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
> > >   		RB_CLEAR_NODE(&merge->rb_node);
> > >   		em->mod_len = (merge->mod_start + merge->mod_len) - em->mod_start;
> > >   		em->generation = max(em->generation, merge->generation);
> > > +		set_bit(EXTENT_FLAG_MERGED, &em->flags);
> > >   		free_extent_map(merge);
> > >   	}
> > >   }
> > > diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> > > index 8e217337dff9..d2fa32ffe304 100644
> > > --- a/fs/btrfs/extent_map.h
> > > +++ b/fs/btrfs/extent_map.h
> > > @@ -25,6 +25,8 @@ enum {
> > >   	EXTENT_FLAG_FILLING,
> > >   	/* filesystem extent mapping type */
> > >   	EXTENT_FLAG_FS_MAPPING,
> > > +	/* This em is merged from two or more physically adjacent ems */
> > > +	EXTENT_FLAG_MERGED,
> > >   };
> > >   struct extent_map {
> > > @@ -40,6 +42,12 @@ struct extent_map {
> > >   	u64 ram_bytes;
> > >   	u64 block_start;
> > >   	u64 block_len;
> > > +
> > > +	/*
> > > +	 * Generation of the extent map, for merged em it's the highest
> > > +	 * generation of all merged ems.
> > > +	 * For non-merged extents, it's from btrfs_file_extent_item::generation.
> > 
> > Missing the (u64)-1 special case, a temporary value set when writeback starts
> > and changed when the ordered extent completes.
> > 
> > > +	 */
> > >   	u64 generation;
> > >   	unsigned long flags;
> > >   	/* Used for chunk mappings, flag EXTENT_FLAG_FS_MAPPING must be set */
> > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > index fb4c25e5ff5f..3a5ada561298 100644
> > > --- a/fs/btrfs/ioctl.c
> > > +++ b/fs/btrfs/ioctl.c
> > > @@ -1169,6 +1169,20 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
> > >   	em = lookup_extent_mapping(em_tree, start, sectorsize);
> > >   	read_unlock(&em_tree->lock);
> > > +	/*
> > > +	 * We can get a merged extent, in that case, we need to re-search
> > > +	 * tree to get the original em for defrag.
> > > +	 *
> > > +	 * If @newer_than is 0 or em::geneartion < newer_than, we can trust
> > 
> > em::geneartion -> em::generation
> > 
> > > +	 * this em, as either we don't care about the geneartion, or the
> > 
> > geneartion, -> generation
> > 
> > The rest looks fine.
> > Thanks.
> > 
> > > +	 * merged extent map will be rejected anyway.
> > > +	 */
> > > +	if (em && test_bit(EXTENT_FLAG_MERGED, &em->flags) &&
> > > +	    newer_than && em->generation >= newer_than) {
> > > +		free_extent_map(em);
> > > +		em = NULL;
> > > +	}
> > > +
> > >   	if (!em) {
> > >   		struct extent_state *cached = NULL;
> > >   		u64 end = start + sectorsize - 1;
> > > -- 
> > > 2.35.0
> > > 
> > 
> 
