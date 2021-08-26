Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD1E3F8D66
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 19:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbhHZR4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 13:56:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52050 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhHZR4w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 13:56:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8EEC22250;
        Thu, 26 Aug 2021 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630000563;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXfobjmj/8TTZF7uPDNa3J2GdzvCVAHLNKXg65F+XL4=;
        b=JuAq9AKb7FUQFttltQzmR1pgZlbNW9lqmcAx7EQpbdIwAVatTHy6skQKCnzy3yhHo6Cjmh
        3kbP+zDsBj+/aZnb/ATu1zYihKSxFGzDh33jBiJRi5eJP6NT4FRzrwPiXyy4DdKlWYnKJH
        OsUW4G+ixB/Ive/fNDPRmYgU0sQZgbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630000563;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXfobjmj/8TTZF7uPDNa3J2GdzvCVAHLNKXg65F+XL4=;
        b=SVEdE1vZgoJJ+D8TRSWivU6lL/pxcyrkxTZZ3GxTuS4Od6gODd74tRM6M2doRE6b2sp0Jj
        0FW7F1itaYvp4RAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D12CFA3B8B;
        Thu, 26 Aug 2021 17:56:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7E175DA7F3; Thu, 26 Aug 2021 19:53:15 +0200 (CEST)
Date:   Thu, 26 Aug 2021 19:53:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
Subject: Re: [PATCH] btrfs: fix max max_inline for pagesize=64K
Message-ID: <20210826175314.GO3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
References: <bfb8ebd29d6890022ddf74cea37d85798292f6d4.1628346277.git.anand.jain@oracle.com>
 <20210816151026.GE5047@twin.jikos.cz>
 <d418c51c-abc5-d08a-aa20-7781cfe1741c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d418c51c-abc5-d08a-aa20-7781cfe1741c@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 24, 2021 at 01:54:21PM +0800, Anand Jain wrote:
> On 16/08/2021 23:10, David Sterba wrote:
> > On Tue, Aug 10, 2021 at 11:23:44PM +0800, Anand Jain wrote:
> >> The mount option max_inline ranges from 0 to the sectorsize (which is
> >> equal to pagesize). But we parse the mount options too early and before
> >> the sectorsize is a cache from the superblock. So the upper limit of
> >> max_inline is unaware of the actual sectorsize. And is limited by the
> >> temporary sectorsize 4096 (as below), even on a system where the default
> >> sectorsize is 64K.
> > 
> 
> > So the question is what's a sensible value for >4K sectors, which is 64K
> > in this case.
> > 
> > Generally we allow setting values that may make sense only for some
> > limited usecase and leave it up to the user to decide.
> >
> > The inline files reduce the slack space and on 64K sectors it could be
> > more noticeable than on 4K sectors. It's a trade off as the inline data
> > are stored in metadata blocks that are considered more precious.
> >
> > Do you have any analysis of file size distribution on 64K systems for
> > some normal use case like roo partition?
> >
> > I think this is worth fixing so to be in line with constraints we have
> > for 4K sectors but some numbers would be good too.
> 
> Default max_inline for sectorsize=64K is an interesting topic and
> probably long. If time permits, I will look into it.
> Furthermore, we need test cases and a repo that can hold it (and
> also add  read_policy test cases there).
> 
> IMO there is no need to hold this patch in search of optimum default
> max_inline for 64K systems.

Yeah, I'm more interested in some reasonable value, now the default is
2048 but probably it should be sectorsize/2 in general.

> This patch reports and fixes a bug due to which we are limited to test
> max_inline only up to 4K on a 64K pagesize system. Not as our document
> claimed as below.
> -----------------
>   man -s 5 btrfs
>   ::
>          max_inline=bytes
>             (default: min(2048, page size) )
>   ::
> 	In practice, this value is limited by the filesystem block size
> 	(named sectorsize at mkfs time), and memory page size of the
> 	system.
> -----------------
> 
> 
>   more below.
> 
> >>
> >> disk-io.c
> >> ::
> >> 2980         /* Usable values until the real ones are cached from the superblock */
> >> 2981         fs_info->nodesize = 4096;
> >> 2982         fs_info->sectorsize = 4096;
> >>
> >> Fix this by reading the superblock sectorsize before the mount option parse.
> >>
> >> Reported-by: Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >>   fs/btrfs/disk-io.c | 49 +++++++++++++++++++++++-----------------------
> >>   1 file changed, 25 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >> index 2dd56ee23b35..d9505b35c7f5 100644
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -3317,6 +3317,31 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> >>   	 */
> >>   	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
> >>   
> >> +	/*
> >> +	 * flag our filesystem as having big metadata blocks if
> >> +	 * they are bigger than the page size
> > 
> > Please fix/reformat/improve any comments that are in moved code.
> 
>   I think you are pointing to s/f/F and 80 chars long? Will fix.

Yes, already fixed in the committed version in misc-next, thanks.
