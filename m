Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C310A166358
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 17:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgBTQly (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 11:41:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:44094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgBTQly (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 11:41:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 47CF8B1E8;
        Thu, 20 Feb 2020 16:41:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 99A45DA70E; Thu, 20 Feb 2020 17:41:34 +0100 (CET)
Date:   Thu, 20 Feb 2020 17:41:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ethanwu <ethanwu@synology.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: improve normal backref walking
Message-ID: <20200220164134.GA2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ethanwu <ethanwu@synology.com>,
        linux-btrfs@vger.kernel.org
References: <20200207093818.23710-1-ethanwu@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207093818.23710-1-ethanwu@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 07, 2020 at 05:38:14PM +0800, ethanwu wrote:
> Btrfs has two types of data backref.
> For BTRFS_EXTENT_DATA_REF_KEY type of backref, we don't have the
> exact block number. Therefore, we need to call resolve_indirect_refs.
> It uses btrfs_search_slot to locate the leaf block. Then
> we need to walk through the leaves to search for the EXTENT_DATA items
> that have disk bytenr matching the extent item(add_all_parents).
> 
> When resolving indirect refs, we could take entries that don't
> belong to the backref entry we are searching for right now.
> For that reason when searching backref entry, we always use total
> refs of that EXTENT_ITEM rather than individual count.
> 
> For example:
> item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize
>   extent refs 24 gen 7302 flags DATA
>   shared data backref parent 394985472 count 10 #1
>   extent data backref root 257 objectid 260 offset 1048576 count 3 #2
>   extent data backref root 256 objectid 260 offset 65536 count 6 #3
>   extent data backref root 257 objectid 260 offset 65536 count 5 #4
> 
> For example, when searching backref entry #4, we'll use total_refs
> 24, a very loose loop ending condition, instead of total_refs = 5.
> 
> But using total_refs=24 is not accurate. Sometimes, we'll never find
> all the refs from specific root.
> As a result, the loop keeps on going until we reach the end of that inode.
> 
> The first 3 patches, handle 3 different types refs we might encounter.
> These refs do not belong to the normal backref we are searching, and
> hence need to be skipped.
> 
> The last patch changes the total_refs to correct number so that we could
> end loop as soon as we find all the refs we want.
> 
> btrfs send uses backref to find possible clone sources, the following
> is a simple test to compare the results with and without this patch
> 
> btrfs subvolume create /volume1/sub1
> for i in `seq 1 163840`; do dd if=/dev/zero of=/volume1/sub1/file bs=64K count=1 seek=$((i-1)) conv=notrunc oflag=direct 2>/dev/null; done
> btrfs subvolume snapshot /volume1/sub1 /volume1/sub2
> for i in `seq 1 163840`; do dd if=/dev/zero of=/volume1/sub1/file bs=4K count=1 seek=$(((i-1)*16+10)) conv=notrunc oflag=direct 2>/dev/null; done
> btrfs subvolume snapshot -r /volume1/sub1 /volume1/snap1
> time btrfs send /volume1/snap1 | btrfs receive /volume2
> 
> without this patch
> real 69m48.124s
> user 0m50.199s
> sys  70m15.600s
> 
> with this patch
> real    1m59.683s
> user    0m35.421s
> sys     2m42.684s

This is too good to be left only in the cover letter and lost in the
mailinglist, so I copied that to the 4th patch that puts all the things
together and the explanation is very useful. Also the numbers show a
significant improvement.

I've moved the patchset from a topic branch to misc-next for wider
testing. The test failure I reported is not directly caused by these
changes but it's still something to watch for. The target merge is 5.7
so there's plenty of time to test, backreferences are the corner stone
of btrfs so this must work 100%.

Thanks.
