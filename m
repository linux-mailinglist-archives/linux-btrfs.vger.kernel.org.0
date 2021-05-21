Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8137B38C830
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 15:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhEUNeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 09:34:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231601AbhEUNep (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 09:34:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61CABAAFD;
        Fri, 21 May 2021 13:33:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D610DDA72C; Fri, 21 May 2021 15:30:45 +0200 (CEST)
Date:   Fri, 21 May 2021 15:30:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Patch v2 05/42] btrfs: refactor submit_extent_page() to make
 bio and its flag tracing easier
Message-ID: <20210521133045.GM7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-6-wqu@suse.com>
 <PH0PR04MB74164E271935D134458F6C289B299@PH0PR04MB7416.namprd04.prod.outlook.com>
 <a08bab53-4240-83ec-897f-23e1083f8ad6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a08bab53-4240-83ec-897f-23e1083f8ad6@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 21, 2021 at 07:26:31PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/5/21 下午7:06, Johannes Thumshirn wrote:
> > On 28/04/2021 01:04, Qu Wenruo wrote:
> >> +static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
> >> +			       struct btrfs_inode *inode)
> >> +{
> >> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> >> +	struct btrfs_io_geometry geom;
> >> +	struct btrfs_ordered_extent *ordered;
> >> +	struct extent_map *em;
> >> +	u64 logical = (bio_ctrl->bio->bi_iter.bi_sector << SECTOR_SHIFT);
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * Pages for compressed extent are never submitted to disk directly,
> >> +	 * thus it has no real boundary, just set them to U32_MAX.
> >> +	 *
> >> +	 * The split happens for real compressed bio, which happens in
> >> +	 * btrfs_submit_compressed_read/write().
> >> +	 */
> >> +	if (bio_ctrl->bio_flags & EXTENT_BIO_COMPRESSED) {
> >> +		bio_ctrl->len_to_oe_boundary = U32_MAX;
> >> +		bio_ctrl->len_to_stripe_boundary = U32_MAX;
> >> +		return 0;
> >> +	}
> >> +	em = btrfs_get_chunk_map(fs_info, logical, fs_info->sectorsize);
> >> +	if (IS_ERR(em))
> >> +		return PTR_ERR(em);
> >> +	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bio),
> >> +				    logical, &geom);
> >> +	if (ret < 0) {
> >> +		free_extent_map(em);
> >> +		return ret;
> >> +	}
> > 
> > I have kmemleak reports on misc-next for each mount and git bisect points to
> > this patch. Aren't we leaking 'em' here?
> 
> Oh, you're completely right!
> 
> > 
> >> +	if (geom.len > U32_MAX)
> >> +		bio_ctrl->len_to_stripe_boundary = U32_MAX;
> >> +	else
> >> +		bio_ctrl->len_to_stripe_boundary = (u32)geom.len;
> >> +
> >> +	if (!btrfs_is_zoned(fs_info) ||
> >> +	    bio_op(bio_ctrl->bio) != REQ_OP_ZONE_APPEND) {
> >> +		bio_ctrl->len_to_oe_boundary = U32_MAX;
> >> +		return 0;
> >> +	}
> >> +
> >> +	ASSERT(fs_info->max_zone_append_size > 0);
> >> +	/* Ordered extent not yet created, so we're good */
> >> +	ordered = btrfs_lookup_ordered_extent(inode, logical);
> >> +	if (!ordered) {
> >> +		bio_ctrl->len_to_oe_boundary = U32_MAX;
> >> +		return 0;
> >> +	}
> >> +
> >> +	bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
> >> +		ordered->disk_bytenr + ordered->disk_num_bytes - logical);
> >> +	btrfs_put_ordered_extent(ordered);
> >> +	return 0;
> >> +}
> > 
> > This hunk makes kmemleak happy again (for the range I've tested):
> 
> David, mind to fold this fix?

Not at all, thanks.
