Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CAB382801
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 11:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhEQJRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 05:17:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:39324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235905AbhEQJQ1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 05:16:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F991AF19;
        Mon, 17 May 2021 09:15:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C946ADAF1B; Mon, 17 May 2021 11:12:37 +0200 (CEST)
Date:   Mon, 17 May 2021 11:12:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: zoned: fix compressed writes
Message-ID: <20210517091237.GE7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1620824721.git.johannes.thumshirn@wdc.com>
 <52c1251218441dfeec909b34069d654aa45311c1.1620824721.git.johannes.thumshirn@wdc.com>
 <20210512144213.GS7604@twin.jikos.cz>
 <PH0PR04MB741608A91B3171D58DA902EF9B2D9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741608A91B3171D58DA902EF9B2D9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 17, 2021 at 07:07:04AM +0000, Johannes Thumshirn wrote:
> On 12/05/2021 16:44, David Sterba wrote:
> > On Wed, May 12, 2021 at 11:01:40PM +0900, Johannes Thumshirn wrote:
> >> +	if (use_append) {
> >> +		struct extent_map *em;
> >> +		struct map_lookup *map;
> >> +
> >> +		em = btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);
> > 
> > The caller already does the em lookup, so this is duplicate, allocating
> > memory, taking locks and doing a tree lookup. All happening on write out
> > path so this seems heavy.
> 
> Right, I did not check this, sorry. Is it OK to add another patch as 
> preparation swapping some of the parameters to btrfs_submit_compressed_write()
> from the em?

That would be another prep patch for the fix, I can't say now if this
would be still suitable for stable.

> Otherwise btrfs_submit_compressed_write() will have 10 parameters
> which sounds awefull.

In case the fix would have to be in one patch, extending the parameters
to 10 would be acceptable, if followed by reduction cleanup (that won't
have to be backported).

If you check the only caller of btrfs_submit_compressed_write, four
parameters are from async_extent, and two are async_chunk, where
async_extent = list_entry(async_chunk->extents.next, ...) so that should
be easy to reduce.
