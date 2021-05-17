Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B52382B59
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 13:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhEQLn3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 07:43:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:37466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231681AbhEQLn2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 07:43:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B7F3AD1B;
        Mon, 17 May 2021 11:42:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C3279DAF1B; Mon, 17 May 2021 13:39:37 +0200 (CEST)
Date:   Mon, 17 May 2021 13:39:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: zoned: fix compressed writes
Message-ID: <20210517113937.GM7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1620824721.git.johannes.thumshirn@wdc.com>
 <52c1251218441dfeec909b34069d654aa45311c1.1620824721.git.johannes.thumshirn@wdc.com>
 <20210512144213.GS7604@twin.jikos.cz>
 <PH0PR04MB741608A91B3171D58DA902EF9B2D9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB74168343747A058F5F53D8309B2D9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74168343747A058F5F53D8309B2D9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 17, 2021 at 11:21:49AM +0000, Johannes Thumshirn wrote:
> On 17/05/2021 09:07, Johannes Thumshirn wrote:
> >>> +	if (use_append) {
> >>> +		struct extent_map *em;
> >>> +		struct map_lookup *map;
> >>> +
> >>> +		em = btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);
> >> The caller already does the em lookup, so this is duplicate, allocating
> >> memory, taking locks and doing a tree lookup. All happening on write out
> >> path so this seems heavy.
> > Right, I did not check this, sorry. Is it OK to add another patch as 
> > preparation swapping some of the parameters to btrfs_submit_compressed_write()
> > from the em? Otherwise btrfs_submit_compressed_write() will have 10 parameters
> > which sounds awefull.
> > 
> 
> Actually I can't do that. The caller does calls create_io_em() while this patch
> needs to call brtfs_get_chunk_map(). The 'em' returned by create_io_em() does not
> have em->map_lookup populated and we need the stripe's block device from 
> em->map_lookup.
> 
> So it looks like we need to live with the additional memory allocation and locks.

Ok then, it's limited to zoned mode so the allocation won't affect
regular mode.
