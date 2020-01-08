Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC651345A3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 16:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgAHPEy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 10:04:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:59066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgAHPEy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 10:04:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7942FAD2C;
        Wed,  8 Jan 2020 15:04:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 095E5DA791; Wed,  8 Jan 2020 16:04:41 +0100 (CET)
Date:   Wed, 8 Jan 2020 16:04:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 1/3] btrfs: Introduce per-profile available space
 facility
Message-ID: <20200108150441.GG3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20200106061343.18772-1-wqu@suse.com>
 <20200106061343.18772-2-wqu@suse.com>
 <20200106143242.GG3929@twin.jikos.cz>
 <9c2308bb-c3ae-d502-4b27-f8dbedc25d1a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c2308bb-c3ae-d502-4b27-f8dbedc25d1a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 07, 2020 at 10:13:43AM +0800, Qu Wenruo wrote:
> >> +	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
> >> +			       GFP_NOFS);
> > 
> > Calling kcalloc is another potential slowdown, for the statfs
> > considerations.
> 
> That's also what we did in statfs() before, so it shouldn't cause extra
> problem.
> Furthermore, we didn't use calc_one_profile_avail() directly in statfs()
> directly.
> 
> Although I get your point, and personally speaking the memory allocation
> and extra in-memory device iteration should be pretty fast compared to
> __btrfs_alloc_chunk().
> 
> Thus I don't think this memory allocation would cause extra trouble,
> except the error handling mentioned below.

Right, current statfs also does allocation via
btrfs_calc_avail_data_space, so it's the same as before.

> [...]
> >> +			ret = calc_per_profile_avail(fs_info);
> > 
> > Adding new failure modes
> 
> Another solution I have tried is make calc_per_profile_avail() return
> void, ignoring the ENOMEM error, and just set the affected profile to 0
> available space.
> 
> But that method is just delaying ENOMEM, and would cause strange
> pre-profile values until next successful update or mount cycle.
> 
> Any idea on which method is less worse?

Better to return the error than wrong values in this case. As the
numbers are sort of a cache and the mount cycle to get them fixed is not
very user friendly, we need some other way. As this is a global state, a
bit in fs_info::flags can be set and full recalculation attempted at
some point until it succeeds. This would leave the counters stale for
some time but I think still better than if they're suddenly 0.
