Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA06B0B4B
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 15:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjCHOdv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 09:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjCHOdp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 09:33:45 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894469AFC5
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Mar 2023 06:33:34 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 15A8167373; Wed,  8 Mar 2023 15:33:31 +0100 (CET)
Date:   Wed, 8 Mar 2023 15:33:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Message-ID: <20230308143330.GB14929@lst.de>
References: <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com> <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com> <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com> <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com> <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com> <ZACsVI3mfprrj4j6@infradead.org> <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com> <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com> <ZAIBQ0hzLTjOIYcr@infradead.org> <e9e7820b-9cf3-8361-cf3c-e4d59baa5b21@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e7820b-9cf3-8361-cf3c-e4d59baa5b21@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 08, 2023 at 09:11:54AM +0000, Johannes Thumshirn wrote:
> @@ -393,10 +378,12 @@ static void btrfs_orig_write_end_io(struct bio *bio)
>                 stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>  
>         if (btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
> +               struct btrfs_ordered_extent *oe;
> +
> +               oe = btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
> +               btrfs_get_bioc(bioc);
> +               oe->bioc = bioc;
> +               btrfs_put_ordered_extent(oe);


> +       } else if (ordered_extent->bioc) {
> +               ret = btrfs_add_ordered_stripe(ordered_extent->bioc);
> +               btrfs_put_bioc(ordered_extent->bioc);
> +               if (ret)
> +                       goto out;

Given that btrfs_add_ordered_stripe only really builds the
btrfs_ordered_stripe structure and inserts it into the tree,
can't we just allocate the btrfs_ordered_stripe structure
in the end_io handler and have the ordered_extent point to it?

Also if you don't to split the ordered_extent for each bio,
you could instead have a list of btrfs_ordered_stripes in the
ordered_extent and then process all of them in the ordered_extent
completion handling.
