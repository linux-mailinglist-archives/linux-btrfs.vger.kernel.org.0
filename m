Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80F43F17E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 13:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhHSLUo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 07:20:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46180 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhHSLUn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 07:20:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D295921FBB;
        Thu, 19 Aug 2021 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629372006;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SccBdJ2SIUABgBnT/j1dYApTODg63ef+/EQ1d8O7BAE=;
        b=ljMpK/O/KlFGdyBDlarKHKaMFpIKm+RSaksZMLci+Jr4rpattxltMS3da77CfGpNhp0EBd
        G8S0DNBbFgo9yWlUe0GTO5YHFRWMATDzM3ldilZkU4LzkHYXoCB7ADggtf9NAMq8OCxMzW
        FI9AeEP0GkFg6D52BG0mG0P+BniW3b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629372006;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SccBdJ2SIUABgBnT/j1dYApTODg63ef+/EQ1d8O7BAE=;
        b=Wfho/rLxwyQ/WaB9924vcGX7SwyrLg8pJKElN8xQ+vUznriNRxg5CmkzF3rxWvRhjYzdHK
        SwwQXXByqyBCtvCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 48648A3B9E;
        Thu, 19 Aug 2021 11:19:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 95AACDA72C; Thu, 19 Aug 2021 13:17:09 +0200 (CEST)
Date:   Thu, 19 Aug 2021 13:17:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH] btrfs: prevent falloc to mix inline and regular
 extents
Message-ID: <20210819111709.GC5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210811054505.186828-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811054505.186828-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 11, 2021 at 01:45:05PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> The following script can create a fs with mixed inline and regular
> extents:
> 
>  mkfs.btrfs -f -s 4k $dev
>  mount $dev $mnt -o nospace_cache
> 
>  xfs_io -f -c "pwrite 0 1k" -c "sync" \
> 	-c "falloc 0 4k" -c "pwrite 4k 4k" $mnt/file
>  umount $mnt
> 
> It will result the following file extents layout:
> 
>         item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
>                 index 2 namelen 4 name: file
>         item 6 key (257 EXTENT_DATA 0) itemoff 14824 itemsize 1045
>                 generation 8 type 0 (inline)
>                 inline extent data size 1024 ram_bytes 1024 compression 0 (none)
>         item 7 key (257 EXTENT_DATA 4096) itemoff 14771 itemsize 53
>                 generation 8 type 1 (regular)
>                 extent data disk byte 13631488 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
> 
> Which mixes inline and regular extents.
> 
> Without above falloc operation, we would get proper regular extent only
> layout.
> 
> [CAUSE]
> Normally we rely on btrfs_truncate_block() to convert the inline extent
> to regular extent.
> 
> For example, if without falloc(), at the 2nd pwrite, we will call
> btrfs_truncate_block() to zero the tailing part of the inline extent,
> then at writeback time, we find the isize is larger than inline
> threshold and will not create inline extent, but write back the first
> sector as regular extent.
> 
> While in falloc, although we also call btrfs_truncate_block(), it's
> called before we enlarge the inode size.
> 
> And we start writeback of the range immediately, with inode size
> unchanged.
> 
> This means, we just re-create an inline extent inside btrfs_fallocate().
> 
> [FIX]
> Only call btrfs_truncate_block() after we have updated inode size inside
> btrfs_fallocate().
> 
> By this later writeback will properly writeback the first sector as
> regular extent.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> 
> There is a long existing discussion on whether we should allow mixing
> inline and regular extents.
> 
> I totally understand the idea that mixing such extents won't cause
> anything wrong, the existing kernel can handle them pretty well, and no
> data corruption or whatever.
> 
> But since it's really not that simple to create such mixed extents
> (except the method mentioned above), I really don't believe that's the
> expected behavior.
> 
> Thus even it's not a big deal, I still want to prevent such mixed
> extents.

I agree, it's rather obscure and I don't think it was intentional. That
it works is fine and we'll have to keep it like that but not creating
the mixed extents should be the default.
