Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 882A1149551
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 12:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAYLfu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jan 2020 06:35:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:46166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgAYLfu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 06:35:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6C8E0ACF0;
        Sat, 25 Jan 2020 11:35:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 50BC1DA730; Sat, 25 Jan 2020 12:35:31 +0100 (CET)
Date:   Sat, 25 Jan 2020 12:35:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fdmanana@gmail.com, dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for
 dev-replace
Message-ID: <20200125113531.GR3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20200123235820.20764-1-wqu@suse.com>
 <20200124144409.GM3929@twin.jikos.cz>
 <CAL3q7H5+pTzLM7=5gxORWi6CcPB1YGR8=8bVUWeogq8a2rno-Q@mail.gmail.com>
 <a76b187d-678e-1b02-b388-2ab12b9c221c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76b187d-678e-1b02-b388-2ab12b9c221c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 25, 2020 at 08:36:14AM +0800, Qu Wenruo wrote:
> >> The purpose seems to be to catch generic error codes other than
> >> EINPROGRESS and ECNACELED, I don't see much point printing a warning in
> >> that case. But it' a new ENOSPC problem, likely caused by the
> >> read-only status switching.
> >>
> >> My test devices are 12G, there's full log of the test to see at which
> >> phase it happened.
> > 
> > It passes for me on 20G devices, haven't tested with 12G however
> > (can't afford to reboot any of my vms now).
> 
> 5G for all scratch devices, and failed to reproduce it.
> (The full run before submitting the patch also failed to reproduce it)

5G is not actually enough to run some of the tests that require at least
10G of free space (so the block device needs to be a bit larger).

> > I think that happens because before this patch we ignored ENOSPC
> > errors, when trying to set a block group to RO, for device replace and
> > scrub.
> > But with this patch we don't ignore ENOSPC for device replace anymore
> > - this is actually correct because if we ignore we can corrupt nocow
> > writes (including writes into prealloc extents).
> > 
> > Now if it's a real ENOSPC situation or just a bug in the space
> > management code, it's a different thing to look at.
> 
> I tend to take a middle land of the problem.
> 
> For current stage, the WARN_ON() is indeed overkilled, at least for ENOSPC.
> 
> But on the other handle, the full RO of a block group for scrub/replace
> is also a little overkilled.
> Just as Filipe mentioned, we only want to kill nocow writes into a block
> group, but still allow COW writes.
> 
> It looks like something like mark_block_group_nocow_ro() in the future
> could reduce the possibility if not fully kill it.

Yeah this sounds doable.

> It looks like changing the WARN_ON(ret) to WARN_ON(ret != -ENOSPC) would
> be needed for this patch as a quick fix.

I'll remove the warning completely, as a separate patch.
