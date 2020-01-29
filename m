Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A9114CDE0
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 17:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgA2QCJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 11:02:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:42404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgA2QCJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 11:02:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6CBBDAD06;
        Wed, 29 Jan 2020 16:02:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1393DA730; Wed, 29 Jan 2020 17:01:47 +0100 (CET)
Date:   Wed, 29 Jan 2020 17:01:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
Message-ID: <20200129160147.GI3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
 <20200116142928.GX3929@twin.jikos.cz>
 <40ff2d8d-eb3b-1c90-ea19-618e5c058bcc@gmx.com>
 <20200117140231.GF3929@twin.jikos.cz>
 <f1f1a2ab-ed09-d841-6a93-a44a8fb2312f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f1a2ab-ed09-d841-6a93-a44a8fb2312f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 10:16:45PM +0800, Qu Wenruo wrote:
> >> But this behavior itself is not accurate.
> >>
> >> We have global reservation, which is normally always larger than the
> >> immediate number 4M.
> > 
> > The global block reserve is subtracted from the metadata accounted from
> > the block groups. And after that, if there's only little space left, the
> > check triggers. Because at this point any new metadata reservation
> > cannot be satisfied from the remaining space, yet there's >0 reported.
> 
> OK, then we need to do over-commit calculation here, and do the 4M
> calculation.
> 
> The quick solution I can think of would go back to Josef's solution by
> exporting can_overcommit() to do the calculation.
> 
> 
> But my biggest problem is, do we really need to do all these hassle?

As far as I know we did not ask for it, it's caused by limitations of
the public interfaces (statfs).

> My argument is, other fs like ext4/xfs still has their inode number
> limits, and they don't report 0 avail when  that get exhausted.
> (Although statfs() has such report mechanism for them though).

Maybe that's also the perception of what "space" is for users. The data
and metadata distinction is an implementation detail. So if 'df' tells
me there's space I should be able to create new files, right? Or write
more data, but still looking at the same number of free space.

For ext2 or ext3 it should be easier to see if it's possible to create
new inodes, the values of 'df -i' are likely accurate because of the
mkfs-time preallocation.

Newer features on ext4 and xfs allow dynamic creation of inodes, you can
find guesswork regarding the f_files estimates.

I vaguely remember that it's possible to get ENOSPC on ext4 by
exhausting metadata yet statfs will still tell you there's free space.
This is confusing too.
