Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E239F140C24
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAQOKx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:10:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:37466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgAQOKx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:10:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0E626B9C0;
        Fri, 17 Jan 2020 14:10:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3478CDA871; Fri, 17 Jan 2020 15:10:37 +0100 (CET)
Date:   Fri, 17 Jan 2020 15:10:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
Message-ID: <20200117141037.GG3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
 <20200116142928.GX3929@twin.jikos.cz>
 <40ff2d8d-eb3b-1c90-ea19-618e5c058bcc@gmx.com>
 <a8e81e58-8d9d-789c-de33-c213f6a894e6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8e81e58-8d9d-789c-de33-c213f6a894e6@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 09:32:49AM +0800, Qu Wenruo wrote:
> On 2020/1/17 上午8:54, Qu Wenruo wrote:
> > On 2020/1/16 下午10:29, David Sterba wrote:
> >> On Wed, Jan 15, 2020 at 11:41:28AM +0800, Qu Wenruo wrote:
> >>> [BUG]
> >>> When there are a lot of metadata space reserved, e.g. after balancing a
> >>> data block with many extents, vanilla df would report 0 available space.
> >>>
> >>> [CAUSE]
> >>> btrfs_statfs() would report 0 available space if its metadata space is
> >>> exhausted.
> >>> And the calculation is based on currently reserved space vs on-disk
> >>> available space, with a small headroom as buffer.
> >>> When there is not enough headroom, btrfs_statfs() will report 0
> >>> available space.
> >>>
> >>> The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
> >>> reservations if we have pending tickets"), we allow btrfs to over commit
> >>> metadata space, as long as we have enough space to allocate new metadata
> >>> chunks.
> >>>
> >>> This makes old calculation unreliable and report false 0 available space.
> >>>
> >>> [FIX]
> >>> Don't do such naive check anymore for btrfs_statfs().
> >>> Also remove the comment about "0 available space when metadata is
> >>> exhausted".
> >>
> >> This is intentional and was added to prevent a situation where 'df'
> >> reports available space but exhausted metadata don't allow to create new
> >> inode.
> > 
> > But this behavior itself is not accurate.
> > 
> > We have global reservation, which is normally always larger than the
> > immediate number 4M.
> > 
> > So that check will never really be triggered.
> > 
> > Thus invalidating most of your argument.
> >>
> >> If it gets removed you are trading one bug for another. With the changed
> >> logic in the referenced commit, the metadata exhaustion is more likely
> >> but it's also temporary.
> 
> Furthermore, the point of the patch is, current check doesn't play well
> with metadata over-commit.

The recent overcommit updates broke statfs in a new way and left us
almost nothing to make it better.

> If it's before v5.4, I won't touch the check considering it will never
> hit anyway.
> 
> But now for v5.4, either:
> - We over-commit metadata
>   Meaning we have unallocated space, nothing to worry

Can we estimate how much unallocated data are there? I don't know how,
and "nothing to worry" always worries me.

> - No more space for over-commit
>   But in that case, we still have global rsv to update essential trees.
>   Please note that, btrfs should never fall into a status where no files
>   can be deleted.

Of course, the global reserve is there for last resort actions and will
be used for deletion and updating essential trees. What statfs says is
how much data is there left for the user. New files, writing more data
etc.

> Consider all these, we're no longer able to really hit that case.
> 
> So that's why I'm purposing deleting that. I see no reason why that
> magic number 4M would still work nowadays.

So, the corner case that resulted in the guesswork needs to be
reevaluated then, the space reservations and related updates clearly
affect that. That's out of 5.5-rc timeframe though.
