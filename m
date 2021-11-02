Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3B0443473
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 18:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhKBRTj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 13:19:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35144 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhKBRTj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 13:19:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7782C218F7;
        Tue,  2 Nov 2021 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635873423;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCtMmyZJTYTX87Ov05fhuUTzu5u3vmGO9IvnYagqXR0=;
        b=qu/vLZDhfMFWCBTlLp4VvjHulNchS8tv7LxsCSSMbFmO8qzrqVMEVslxt+ZxdtrjQIWnPP
        7zL1HGQWKjR/Nkgg/g5R5DPoNEW8tV15GRk7iU9XPShtRgE56jthb5anT+f3MozHJazaMD
        LKYrb5beVDIzpBKpr/JwuGN/a6grkhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635873423;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCtMmyZJTYTX87Ov05fhuUTzu5u3vmGO9IvnYagqXR0=;
        b=h8lhaNbHv6Cnslj0Ek+ALprJBc5FkBveQWn9qhFthN+DoIFMxfjA+0/DPKpw1TDDrhSBcu
        8ENiYDdEqdv+yyAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7057E2C144;
        Tue,  2 Nov 2021 17:17:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 295D9DA7A9; Tue,  2 Nov 2021 18:16:27 +0100 (CET)
Date:   Tue, 2 Nov 2021 18:16:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Message-ID: <20211102171627.GT20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20211027052859.44507-1-wqu@suse.com>
 <20211027052859.44507-3-wqu@suse.com>
 <20211029141059.GC20319@twin.jikos.cz>
 <6b69f8a6-2769-1a5e-630b-76421529b2a7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b69f8a6-2769-1a5e-630b-76421529b2a7@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 30, 2021 at 07:38:49AM +0800, Qu Wenruo wrote:
> On 2021/10/29 22:11, David Sterba wrote:
> > On Wed, Oct 27, 2021 at 01:28:59PM +0800, Qu Wenruo wrote:
> >> +#define BTRFS_RAID_SHIFT	(ilog2(BTRFS_BLOCK_GROUP_RAID0) - 1)
> >> +
> >>   enum btrfs_raid_types {
> >> -	BTRFS_RAID_RAID10,
> >> -	BTRFS_RAID_RAID1,
> >> -	BTRFS_RAID_DUP,
> >> -	BTRFS_RAID_RAID0,
> >> -	BTRFS_RAID_SINGLE,
> >> -	BTRFS_RAID_RAID5,
> >> -	BTRFS_RAID_RAID6,
> >> -	BTRFS_RAID_RAID1C3,
> >> -	BTRFS_RAID_RAID1C4,
> >> +	BTRFS_RAID_SINGLE  = 0,
> >> +	BTRFS_RAID_RAID0   = ilog2(BTRFS_BLOCK_GROUP_RAID0 >> BTRFS_RAID_SHIFT),
> >> +	BTRFS_RAID_RAID1   = ilog2(BTRFS_BLOCK_GROUP_RAID1 >> BTRFS_RAID_SHIFT),
> >> +	BTRFS_RAID_DUP     = ilog2(BTRFS_BLOCK_GROUP_DUP >> BTRFS_RAID_SHIFT),
> >> +	BTRFS_RAID_RAID10  = ilog2(BTRFS_BLOCK_GROUP_RAID10 >> BTRFS_RAID_SHIFT),
> >> +	BTRFS_RAID_RAID5   = ilog2(BTRFS_BLOCK_GROUP_RAID5 >> BTRFS_RAID_SHIFT),
> >> +	BTRFS_RAID_RAID6   = ilog2(BTRFS_BLOCK_GROUP_RAID6 >> BTRFS_RAID_SHIFT),
> >> +	BTRFS_RAID_RAID1C3 = ilog2(BTRFS_BLOCK_GROUP_RAID1C3 >> BTRFS_RAID_SHIFT),
> >> +	BTRFS_RAID_RAID1C4 = ilog2(BTRFS_BLOCK_GROUP_RAID1C4 >> BTRFS_RAID_SHIFT),
> >
> > Please use const_ilog2 in case all the terms in the expression are
> > constants that can be evaluated at the enum definition time.
> 
> Why? Kernel ilog2() is already handling the constants.
> 
> That's the biggest difference between kernel ilog2() and btrfs-progs
> ilog2().
> 
> Only in btrfs-progs we need const_ilog2().
> 
> In fact, the comment of kernel ilog2() already shows this:
> 
> /**
>   * ilog2 - log base 2 of 32-bit or a 64-bit unsigned value
>   * @n: parameter
>   *
>   * constant-capable log of base 2 calculation
>   * - this can be used to initialise global variables from constant
> data, hence
>   * the massive ternary operator construction
>   *
>   * selects the appropriately-sized optimised version depending on sizeof(n)
>   */

Right, ilog2 is fine.

> > I agree that deriving the indexes from the flags is safe but all the
> > magic around that scares me a bit.
> 
> That's indeed a little concerning.
> 
> That's why I spare no code to make it as hard as possible to break, like
> all the explicit definition of each BTRFS_RAID_* number.

Yeah, as somebody else commented adding a wrapper for the definitions
may be more explicit, ie. the part

	ilog2(BTRFS_BLOCK_GROUP_RAID1C4 >> BTRFS_RAID_SHIFT)

hiding that it's ilog2 and doing the shift

	DEFINE_IT(BTRFS_BLOCK_GROUP_RAID1C4)

using a macro should be all fine for the enum so it's all compile-time
constant.

> To me the only possible problem in the future is someone adding two or
> more profiles in one go, and possibly corrupt the BTRFS_NR_RAID_TYPES.

I may have two more profiles to add, I'll add them one by one anyway as
it's the cleaner.
