Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF237168446
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 17:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgBUQ7C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 11:59:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:60240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgBUQ7C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 11:59:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F0BA4AFCE;
        Fri, 21 Feb 2020 16:59:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57B82DA70E; Fri, 21 Feb 2020 17:58:43 +0100 (CET)
Date:   Fri, 21 Feb 2020 17:58:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: clear file extent mapping for punch past i_size
Message-ID: <20200221165842.GN2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200220142947.3880392-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220142947.3880392-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 20, 2020 at 09:29:47AM -0500, Josef Bacik wrote:
> In my stress testing we were still seeing some hole's with my patches to
> fix missing hole extents.  Turns out we do not fill in holes during hole
> punch if the punch is past i_size.  I incorrectly assumed this was fine,
> because anybody extending would use btrfs_cont_expand, however there is
> a corner that still can give us trouble.  Start with an empty file and
> 
> fallocate KEEP_SIZE 1m-2m
> 
> We now have a 0 length file, and a hole file extent from 0-1m, and a
> prealloc extent from 1m-2m.  Now
> 
> punch 1m-1.5m
> 
> Because this is past i_size we have
> 
> [HOLE EXTENT][ NOTHING ][PREALLOC]
> [0        1m][1m   1.5m][1.5m  2m]
> 
> with an i_size of 0.  Now if we pwrite 0-1.5m we'll increas our i_size
> to 1.5m, but our disk_i_size is still 0 until the ordered extent
> completes.
> 
> However if we now immediately truncate 2m on the file we'll just call
> btrfs_cont_expand(inode, 1.5m, 2m), since our old i_size is 1.5m.  If we
> commit the transaction here and crash we'll expose the gap.
> 
> To fix this we need to clear the file extent mapping for the range that
> we punched but didn't insert a corresponding file extent for.  This will
> mean the truncate will only get an disk_i_size set to 1m if we crash
> before the finish ordered io happens.
> 
> I've written an xfstest to reproduce the problem and validate this fix.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> - Dave, this needs to be folded into "btrfs: use the file extent tree
>   infrastructure" and the changelog needs to be adjusted since I incorrectly
>   point out that we don't need to clear for hole punch.  We definitely need to
>   clear for the case that we're punching past i_size as we aren't inserting hole
>   file extents.

Ok, folded to the patch. I added the hole puching as 7) and appended
this changelog so it describes the tricky corner case. Let me know if
there are more updates needed. Thanks.
