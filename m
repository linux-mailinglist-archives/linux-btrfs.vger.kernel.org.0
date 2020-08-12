Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB8C242586
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 08:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHLGiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 02:38:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:34266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgHLGiX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 02:38:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51738AC12;
        Wed, 12 Aug 2020 06:38:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57A35DA81B; Wed, 12 Aug 2020 08:37:20 +0200 (CEST)
Date:   Wed, 12 Aug 2020 08:37:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v4] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
Message-ID: <20200812063720.GV2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <20200731112911.115665-1-wqu@suse.com>
 <20200731140807.GM3703@twin.jikos.cz>
 <9ec86d30-96b5-2e80-969e-158342c273ab@gmx.com>
 <20200811072234.GK2026@twin.jikos.cz>
 <8796039b-d0b1-a129-3b01-a260a051154b@gmx.com>
 <20200812061016.GT2026@twin.jikos.cz>
 <2fd35a06-ba26-173d-1b72-e41243b78068@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fd35a06-ba26-173d-1b72-e41243b78068@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 12, 2020 at 02:33:33PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/8/12 下午2:10, David Sterba wrote:
> > On Tue, Aug 11, 2020 at 03:42:31PM +0800, Qu Wenruo wrote:
> >>>> CHUNK_TRIMMED and CHUNK_ALLOCATED.
> >>>>
> >>>> Thus what we're doing is to clear all utilized bits.
> >>>
> >>> Which is true for now, adding a new bit would change that.
> >>
> >> Yep, that's also why I had the comment here.
> >
> > The comment is not enough to make the code future proof, as we really
> > want do clear all bits in the range beyond device->total_size and that
> > works only if we specify them all (clear_state_bit).
> >
> > Either we can define a bitmask of all the bits next to their definition
> > (slightly more error prone if we forget to add that manually), or pass a
> > all ones to the clear_extent_bit. Though this is a bit uncommon, with a
> > comment I'd prefer this option.
> 
> OK, I'd go that (u64)-1 as clear_bits direction, with updated comment.

Hold, on, I'm sending out v5 that I'm about to commit.
