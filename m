Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FE6242536
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 08:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgHLGLW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 02:11:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:53746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgHLGLT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 02:11:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E46CAC12;
        Wed, 12 Aug 2020 06:11:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EAEF0DA81B; Wed, 12 Aug 2020 08:10:16 +0200 (CEST)
Date:   Wed, 12 Aug 2020 08:10:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v4] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
Message-ID: <20200812061016.GT2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <20200731112911.115665-1-wqu@suse.com>
 <20200731140807.GM3703@twin.jikos.cz>
 <9ec86d30-96b5-2e80-969e-158342c273ab@gmx.com>
 <20200811072234.GK2026@twin.jikos.cz>
 <8796039b-d0b1-a129-3b01-a260a051154b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8796039b-d0b1-a129-3b01-a260a051154b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 11, 2020 at 03:42:31PM +0800, Qu Wenruo wrote:
> >> CHUNK_TRIMMED and CHUNK_ALLOCATED.
> >>
> >> Thus what we're doing is to clear all utilized bits.
> >
> > Which is true for now, adding a new bit would change that.
> 
> Yep, that's also why I had the comment here.

The comment is not enough to make the code future proof, as we really
want do clear all bits in the range beyond device->total_size and that
works only if we specify them all (clear_state_bit).

Either we can define a bitmask of all the bits next to their definition
(slightly more error prone if we forget to add that manually), or pass a
all ones to the clear_extent_bit. Though this is a bit uncommon, with a
comment I'd prefer this option.

> >>> But I still have doubts about just clearing the range, why are there any
> >>> device->alloc_state entries at all after device is shrunk?
> >>
> >> Because the alloc_state is mostly only utilized by trim facility, thus
> >> existing functions won't bother clearing/setting it.
> >>
> >> In this particular case, previous fstrim run would set the CHUNK_TRIMMED
> >> bit for all unallocated range (except the super reserve).
> >> Then shrink doesn't clear the exceed range, and cause problem.
> >
> > So the unallocated range on a device is also represented in the
> > alloc_state tree?
> 
> If the unallocated range has been trimmed, then it has an state, with
> CHUNK_TRIMMED bit set.

To clarify my previous doubts: I was talking about the slack space (ie.
space beyond device->total_size up to block device size), 'unallocated'
is ambiguous and confusing here.

The missing bit about clearing the whole range lies inside
clear_state_bit that deletes all state tracking once all bits are
dropped.
