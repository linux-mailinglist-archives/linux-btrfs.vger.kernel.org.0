Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511B81F5D39
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 22:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgFJUad (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 16:30:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:35814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgFJUac (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 16:30:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A4E9B033;
        Wed, 10 Jun 2020 20:30:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EA1E8DA794; Wed, 10 Jun 2020 22:30:23 +0200 (CEST)
Date:   Wed, 10 Jun 2020 22:30:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kreijack@inwind.it
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH rfc v3] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
Message-ID: <20200610203023.GL27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kreijack@inwind.it,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200319203913.3103-1-kreijack@libero.it>
 <20200319203913.3103-2-kreijack@libero.it>
 <20200525171430.GX18421@twin.jikos.cz>
 <f1a34303-3b1a-dcda-8e67-458b3522e863@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1a34303-3b1a-dcda-8e67-458b3522e863@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 26, 2020 at 10:19:35PM +0200, Goffredo Baroncelli wrote:
> On 5/25/20 7:14 PM, David Sterba wrote:
> > I'll start with the data structures
> > 
> > On Thu, Mar 19, 2020 at 09:39:13PM +0100, Goffredo Baroncelli wrote:
> >> From: Goffredo Baroncelli <kreijack@inwind.it>
> >> +struct btrfs_chunk_info_stripe {
> >> +	__u64 devid;
> >> +	__u64 offset;
> >> +	__u8 dev_uuid[BTRFS_UUID_SIZE];
> >> +};
> >> +
> >> +struct btrfs_chunk_info {
> >> +	/* logical start of this chunk */
> >> +	__u64 offset;
> >> +	/* size of this chunk in bytes */
> >> +	__u64 length;
> >> +
> >> +	__u64 stripe_len;
> >> +	__u64 type;
> >> +
> >> +	/* 2^16 stripes is quite a lot, a second limit is the size of a single
> >> +	 * item in the btree
> >> +	 */
> >> +	__u16 num_stripes;
> >> +
> >> +	/* sub stripes only matter for raid10 */
> >> +	__u16 sub_stripes;
> >> +
> >> +	struct btrfs_chunk_info_stripe stripes[1];
> >> +	/* additional stripes go here */
> >> +};
> > 
> > This looks like a copy of btrfs_chunk and stripe, only removing items
> > not needed for the chunk information. Rather than copying the
> > unnecessary fileds like dev_uuid in stripe, this should be designed for
> > data exchange with the usecase in mind.
> 
> There are two clients for this api:
> - btrfs fi us
> - btrfs dev us
> 
> We can get rid of:
> 	- "offset" fields (2x)
> 	- "uuid" fields
> 
> However the "offset" fields can be used to understand where a logical map
> is on the physical disks. I am thinking about a graphical tool to show this
> mapping, which doesn't exits yet -).
> The offset field may be used as key to get further information (like the chunk
> usage, see below)
> 
> Regarding the UUID field, I agree it can be removed because it is redundant (there
> is already the devid)

Offset is ok. I had something like this:

struct dump_chunks_entry {
       u64 devid;
       u64 start;
       u64 lstart;
       u64 length;
       u64 flags;
       u64 used;
};

This selects the most interesting data from the CHUNK_ITEM, except the
'used' member, see below.

> > The format does not need follow the exact layout that kernel uses, ie.
> > chunk info with one embedded stripe and then followed by variable length
> > array of further stripes. This is convenient in one way but not in
> > another one. Alternatively each chunk can be emitted as a single entry,
> > duplicating part of the common fields and adding the stripe-specific
> > ones. This is for consideration.
> > 
> > I've looked at my old code doing the chunk dump based on the search
> > ioctl and found that it also allows to read the chunk usage, with one
> > extra search to the block group item where the usage is stored. As this
> > is can be slow, it should be optional. Ie. the main ioctl structure
> > needs flags where this can be requested.
> 
> This info could be very useful. I think to something like a balance of
> chunks which are near filled (or near empty). The question is if we
> should have a different ioctl.

I was not proposing a new ioctl but designing the data exchange format
to optionally provide a way to pass more information, like the usage.
The reference to search ioctl was merely to point out that there's one
more search for BLOCK_GROUP_ITEM where the 'used' is stored. As this is
potentially expensive, it won't be filled by default.

The structure above does not capture all the chunk data. We could pack
more such structures into one ioctl call. I think that num_stripes is
missing from there as this would make possible the raid56 calculations
but otherwise it should be it.
