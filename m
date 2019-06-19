Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 501D34BAEA
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 16:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfFSOOM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 10:14:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:45430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbfFSOOM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 10:14:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56A84AD33;
        Wed, 19 Jun 2019 14:14:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D07CDA88C; Wed, 19 Jun 2019 16:14:59 +0200 (CEST)
Date:   Wed, 19 Jun 2019 16:14:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.de>,
        David Sterba <DSterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reorder struct btrfs_key for better alignment
Message-ID: <20190619141458.GG8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.de>, David Sterba <DSterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190618141514.17322-1-dsterba@suse.com>
 <6ba5daa9-735b-1cdd-fdd7-9c1a60277d46@suse.de>
 <20190619133919.GF8917@twin.jikos.cz>
 <2f911663-067c-e895-4da5-9fe4b5c1cc35@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f911663-067c-e895-4da5-9fe4b5c1cc35@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 19, 2019 at 09:50:58PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/6/19 下午9:39, David Sterba wrote:
> > On Wed, Jun 19, 2019 at 09:37:39AM +0800, Qu Wenruo wrote:
> >>>  struct btrfs_key {
> >>>  	__u64 objectid;
> >>> -	__u8 type;
> >>>  	__u64 offset;
> >>> +	__u8 type;
> >>>  } __attribute__ ((__packed__));
> >>
> >> And why not remove the packed attribute?
> > 
> > Because of this (stack usage changes):
> 
> That's expected as long as we're using btrfs_key on stack.

And that's in many functions.

> But if we're using btrfs_key on stack and follow the packed feature,
> then adjacent on stack memory is not accessed aligned, which could cause
> (unobvious) performance drop.

No, the placement of local variables is up to the compiler and does not
necessarily follow the same order as teh definition, some of the
variables can be completely optimized out etc. And the types must be
accessed according to the type alignments, so one packed structure does
not cause a disaster.

> If the unaligned memory access is really causing some performance even
> on stack memory, then I'd say the bump in stack memory usage is acceptable.

Unaligned access overhead depends on architecture, and there's almost
none on intel, so the packed key makes no difference regarding speed.

I consider the bump in stack consumption high enough to stick to the
packing, given that it's still ok from the performance POV.

> If not, then the idea of default -Waddress-of-packed-member makes no sense.

Yeah, I start to think that it's causing more harm than good.
