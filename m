Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2F31E134E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 19:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbgEYRP3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 13:15:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388230AbgEYRP3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 13:15:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DF876AD09;
        Mon, 25 May 2020 17:15:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32068DA72D; Mon, 25 May 2020 19:14:30 +0200 (CEST)
Date:   Mon, 25 May 2020 19:14:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH rfc v3] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
Message-ID: <20200525171430.GX18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20200319203913.3103-1-kreijack@libero.it>
 <20200319203913.3103-2-kreijack@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319203913.3103-2-kreijack@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'll start with the data structures

On Thu, Mar 19, 2020 at 09:39:13PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> +struct btrfs_chunk_info_stripe {
> +	__u64 devid;
> +	__u64 offset;
> +	__u8 dev_uuid[BTRFS_UUID_SIZE];
> +};
> +
> +struct btrfs_chunk_info {
> +	/* logical start of this chunk */
> +	__u64 offset;
> +	/* size of this chunk in bytes */
> +	__u64 length;
> +
> +	__u64 stripe_len;
> +	__u64 type;
> +
> +	/* 2^16 stripes is quite a lot, a second limit is the size of a single
> +	 * item in the btree
> +	 */
> +	__u16 num_stripes;
> +
> +	/* sub stripes only matter for raid10 */
> +	__u16 sub_stripes;
> +
> +	struct btrfs_chunk_info_stripe stripes[1];
> +	/* additional stripes go here */
> +};

This looks like a copy of btrfs_chunk and stripe, only removing items
not needed for the chunk information. Rather than copying the
unnecessary fileds like dev_uuid in stripe, this should be designed for
data exchange with the usecase in mind.

The format does not need follow the exact layout that kernel uses, ie.
chunk info with one embedded stripe and then followed by variable length
array of further stripes. This is convenient in one way but not in
another one. Alternatively each chunk can be emitted as a single entry,
duplicating part of the common fields and adding the stripe-specific
ones. This is for consideration.

I've looked at my old code doing the chunk dump based on the search
ioctl and found that it also allows to read the chunk usage, with one
extra search to the block group item where the usage is stored. As this
is can be slow, it should be optional. Ie. the main ioctl structure
needs flags where this can be requested.
