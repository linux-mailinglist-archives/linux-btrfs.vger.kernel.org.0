Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCCE33F29C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 15:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhCQO37 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 10:29:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:49298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231854AbhCQO3s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 10:29:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E05BAD74;
        Wed, 17 Mar 2021 14:29:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6A654DA6E2; Wed, 17 Mar 2021 15:27:45 +0100 (CET)
Date:   Wed, 17 Mar 2021 15:27:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: remove outdated WARN_ON in direct IO
Message-ID: <20210317142745.GS7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <44b2ec9c1acbaf8c0e13ef882e2340477bac379e.1615971432.git.johannes.thumshirn@wdc.com>
 <20210317105156.GO7604@twin.jikos.cz>
 <PH0PR04MB74162ADE333CCD6A943802A09B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416C9EB06CEE0A47D66FE7E9B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416C9EB06CEE0A47D66FE7E9B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 17, 2021 at 01:22:11PM +0000, Johannes Thumshirn wrote:
> On 17/03/2021 14:20, Johannes Thumshirn wrote:
> > On 17/03/2021 11:54, David Sterba wrote:
> >> On Wed, Mar 17, 2021 at 05:57:31PM +0900, Johannes Thumshirn wrote:
> >>> In btrfs_submit_direct() there's a WAN_ON_ONCE() that will trigger if
> >>> we're submitting a DIO write on a zoned filesystem but are not using
> >>> REQ_OP_ZONE_APPEND to submit the IO to the block device.
> >>>
> >>> This is a left over from a previous version where btrfs_dio_iomap_begin()
> >>> didn't use btrfs_use_zone_append() to check for sequential write only
> >>> zones.
> >>
> >> I can't identify the patch where this got changed. I've landed on
> >> 544d24f9de73 ("btrfs: zoned: enable zone append writing for direct IO")
> >> but that adds the btrfs_use_zone_append, the append flag and also the
> >> warning.
> >>
> > 
> > It is an oversight from the development phase. In v11 (I think) I've added
> > 08f455593fff ("btrfs: zoned: cache if block group is on a sequential zone")
> > and forgot to remove the WARN_ON_ONCE() for 544d24f9de73 ("btrfs: zoned: 
> > enable zone append writing for direct IO").
> > 
> > When developing auto relocation I got hit by the WARN as a block groups
> > where relocated to conventional zone and the dio code calls
> > btrfs_use_zone_append() introduced by 08f455593fff to check if it can use
> > zone append (a.k.a. if it's a sequential zone) or not and sets the appropriate
> > flags for iomap.
> > 
> > I've never hit it in testing before, as I was relying on emulation to test
> > the conventional zones code but this one case wasn't hit, because on emulation
> > fs_info->max_zone_append_size is 0 and the WARN doesn't trigger either.
> 
> I just realized that explanation should have gone into the commit message, do you
> want me to resend with a more elaborate commit message?

I'll append the explanation above to the changelog, no need to resend
unless you want to add/adjust something. Thanks.
