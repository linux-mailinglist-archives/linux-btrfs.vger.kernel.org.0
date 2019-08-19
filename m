Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79506923C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 14:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfHSMtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 08:49:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40125 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfHSMtO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 08:49:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id e8so1679440qtp.7
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2019 05:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lnOyCihbswSgaR0AX9qKaa6NaITWD5Bk1K3kEB3w3YE=;
        b=HdXweM0R8ZwMrDbj6E+O54uO2wL3HP6rQt3zrxNg+cTSuNY+8eu1TtmwNvoy2ska5l
         DH0RTX8JR5gUIZ69ByeNFBIvvGwzmG0Xv+14KoJP8y4P4T2BVMoJAedGJYJmqlJYNkmm
         s8Hbq+3XoT5ABZqMfxSSDHEMydMNS6dRJubEVG6JVidMFkH3XVYNIia8YUOaW7vk/zXe
         EJF25sDwVHScl9RDWCX+dDOT+VZsm28ddVp6Vx9lijG6mpIeQsurSf/vacu1ic+oMavk
         aHXmSPrrnJDTU/gZ/c/aiwc8goPJ/48UO6LNfE1pngNMjD6gCEjw2Jx9O9wB2BDxRZ3H
         LpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lnOyCihbswSgaR0AX9qKaa6NaITWD5Bk1K3kEB3w3YE=;
        b=nehjkgiJPEFDJeEphff7v+msubkGYZdVK55tHI6ps3tMiLnI900uP1QVccMxk90fHZ
         UxTObprKZMU0LSrUY4Uxyx4vsrDwrg260bxqRqgwoNwu/ypw8tBMMAby1yUFt+9G4zFa
         3kAe+YoOucZ7+MUff/7SHDjzaheQU4lnN7/H+CwSir/mLW1kV3wsogCiCaVXJkfGKMB2
         5yitbPpzEEVaqpCp5P93uRJl96eoISzhAKN3hMt1RgcwPV/ysb9Jtzmk/nEZ3BfgNdDv
         HS+GhtXqGpxWMHzYWbFHgxEEJlVdwDYbR4ZDi4Qv1ZMQb/NwIzl0TmLJ72U5KLanRL3W
         UiXw==
X-Gm-Message-State: APjAAAU75ML7Il+sLmb5whX6DD0ATqLIijhWYD+ZIqA8OI8Ee0+d7JVH
        551eznsFPsYtsN01VTZ+/cU2gw==
X-Google-Smtp-Source: APXvYqzH5J9OasEV23C4fh9IAssehnu0y8AmYHcfzWWtcFmt2iyuts+fmILKHTHOqaSuFxpr0302RA==
X-Received: by 2002:ac8:5346:: with SMTP id d6mr8457752qto.333.1566218953451;
        Mon, 19 Aug 2019 05:49:13 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d37sm2475354qtb.80.2019.08.19.05.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 05:49:12 -0700 (PDT)
Date:   Mon, 19 Aug 2019 08:49:11 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: only reserve metadata_size for inodes
Message-ID: <20190819124910.doqc32q3lx2ifvnt@MacBook-Pro-91.local>
References: <20190816150600.9188-1-josef@toxicpanda.com>
 <20190816150600.9188-3-josef@toxicpanda.com>
 <ed6ab402-9ada-e408-4451-38fe00a887be@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed6ab402-9ada-e408-4451-38fe00a887be@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 19, 2019 at 12:17:07PM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.08.19 г. 18:05 ч., Josef Bacik wrote:
> > Historically we reserved worst case for every btree operation, and
> > generally speaking we want to do that in cases where it could be the
> > worst case.  However for updating inodes we know the inode items are
> > already in the tree, so it will only be an update operation and never an
> > insert operation.  This allows us to always reserve only the
> > metadata_size amount for inode updates rather than the
> > insert_metadata_size amount.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> This alleviates some of the reservation pressure so :
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>, however one small nit
> below.
> 
> > ---
> >  fs/btrfs/delalloc-space.c | 15 ++++++++++++---
> >  fs/btrfs/delayed-inode.c  |  2 +-
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
> > index 2412be4a3de2..b8111ebdc92a 100644
> > --- a/fs/btrfs/delalloc-space.c
> > +++ b/fs/btrfs/delalloc-space.c
> > @@ -251,9 +251,16 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
> >  
> >  	lockdep_assert_held(&inode->lock);
> >  	outstanding_extents = inode->outstanding_extents;
> > -	if (outstanding_extents)
> > +
> > +	/*
> > +	 * Insert size for the number of outstanding extents, 1 normal size for
> > +	 * updating the inode.
> > +	 */
> > +	if (outstanding_extents) {
> >  		reserve_size = btrfs_calc_insert_metadata_size(fs_info,
> > -						outstanding_extents + 1);
> > +						outstanding_extents);
> > +		reserve_size += btrfs_calc_metadata_size(fs_info, 1);
> > +	}
> >  	csum_leaves = btrfs_csum_bytes_to_leaves(fs_info,
> >  						 inode->csum_bytes);
> >  	reserve_size += btrfs_calc_insert_metadata_size(fs_info,
> > @@ -278,10 +285,12 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
> >  {
> >  	u64 nr_extents = count_max_extents(num_bytes);
> >  	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, num_bytes);
> > +	u64 inode_update = btrfs_calc_metadata_size(fs_info, 1);
> >  
> >  	/* We add one for the inode update at finish ordered time */
> 
> This comment becomes somewhat outdated and should be removed/reworded.
> Perhaps put above *meta_reserve += inode_update.
> 

Yup I'll update this so it's fixed in the next version.  Thanks,

Josef
