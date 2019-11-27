Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775D510B30A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 17:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfK0QPj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 11:15:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:38612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726514AbfK0QPj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 11:15:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15893AFF3;
        Wed, 27 Nov 2019 16:15:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DBA03DA733; Wed, 27 Nov 2019 17:15:34 +0100 (CET)
Date:   Wed, 27 Nov 2019 17:15:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        fdmanana@suse.com
Subject: Re: [PATCH 1/3] btrfs: Don't discard unwritten extents
Message-ID: <20191127161534.GV2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, fdmanana@suse.com
References: <20191121120331.29070-1-nborisov@suse.com>
 <20191121120331.29070-2-nborisov@suse.com>
 <20191127160600.GU2734@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127160600.GU2734@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 27, 2019 at 05:06:00PM +0100, David Sterba wrote:
> On Thu, Nov 21, 2019 at 02:03:29PM +0200, Nikolay Borisov wrote:
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -4169,8 +4169,6 @@ static int __btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
> >  		if (ret)
> >  			goto out;
> >  	} else {
> > -		if (btrfs_test_opt(fs_info, DISCARD))
> > -			ret = btrfs_discard_extent(fs_info, start, len, NULL);
> >  		btrfs_add_free_space(cache, start, len);
> >  		btrfs_free_reserved_bytes(cache, len, delalloc);
> >  		trace_btrfs_reserved_extent_free(fs_info, start, len);
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 0ac0f5b33003..5d80fe030e79 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -3250,10 +3250,15 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
> >  		if ((ret || !logical_len) &&
> >  		    clear_reserved_extent &&
> >  		    !test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
> > -		    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags))
> > +		    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
> >  			btrfs_free_reserved_extent(fs_info,
> >  						   ordered_extent->start,
> >  						   ordered_extent->disk_len, 1);
> > +			if (ret && btrfs_test_opt(fs_info, DISCARD))
> > +				btrfs_discard_extent(fs_info,
> > +				ordered_extent->start, ordered_extent->disk_len,
> > +				NULL);
> 
> This brings back vague memories of misplaced discard (in
> finish_ordered_io), that was quite hard to catch. I can't find the fix
> though. Filipe, is it the same issue?

Closest to what I thought are dcc82f4783ad9 "Btrfs: fix log tree
corruption when fs mounted with -o discard" or 678886bdc6378 "Btrfs: fix
fs corruption on transaction abort if device supports discard".
