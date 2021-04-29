Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04BC36EC4F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 16:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhD2OYJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 10:24:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:34146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240246AbhD2OYJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 10:24:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F61CB05C;
        Thu, 29 Apr 2021 14:23:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5659DDA795; Thu, 29 Apr 2021 16:20:55 +0200 (CEST)
Date:   Thu, 29 Apr 2021 16:20:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs-progs: refactor and generalize
 chunk/dev_extent allocation
Message-ID: <20210429142055.GW7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 06, 2021 at 05:05:42PM +0900, Naohiro Aota wrote:
> This is the userland counterpart of the following series.
> 
> https://lore.kernel.org/linux-btrfs/20200225035626.1049501-1-naohiro.aota@wdc.com/
> 
> This series refactors chunk allocation and device_extent allocation
> functions and make them generalized to be able to implement other
> allocation policy easily.
> 
> On top of this series, we can simplify userland side of the zoned series as
> adding a new type of chunk allocator and extent allocator for zoned block
> devices. Furthermore, we will be able to implement and test some other
> allocator in the idea page of the wiki e.g. SSD caching, dedicated metadata
> drive, chunk allocation groups, and so on.
> 
> This series also fixes a bug of calculating the stripe size in DUP profile,
> and cleans up the code.
> 
> * Refactoring chunk/dev_extent allocator
> 
> Two functions are separated from find_free_dev_extent_start().
> dev_extent_search_start() decides the starting position of the search.
> dev_extent_hole_check() checks if a hole found is suitable for device
> extent allocation.
> 
> Split some parts of btrfs_alloc_chunk() into three functions.
> init_alloc_chunk_policy() initializes the parameters of an allocation.
> decide_stripe_size() decides the size of chunk and device_extent. And,
> create_chunk() creates a chunk and device extents.
> 
> * Patch organization
> 
> Patches 1 and 2 refactor find_free_dev_extent_start().
> 
> Patches 3 to 6 refactor btrfs_alloc_chunk() by moving the code into three
> other functions.
> 
> Patch 7 uses create_chunk() to simplify btrfs_alloc_data_chunk().
> 
> Patch 8 fixes a bug of calculating stripe size in DUP profile.
> 
> Patches 9 to 12 clean up btrfs_alloc_chunk() code by dropping unnecessary
> parameters, and using better macro/variable name to clarify the meaning.
> 
> 
> Naohiro Aota (12):
>   btrfs-progs: introduce chunk allocation policy
>   btrfs-progs: refactor find_free_dev_extent_start()
>   btrfs-progs: convert type of alloc_chunk_ctl::type
>   btrfs-progs: consolidate parameter initialization of regular allocator
>   btrfs-progs: factor out decide_stripe_size()
>   btrfs-progs: factor out create_chunk()
>   btrfs-progs: rewrite btrfs_alloc_data_chunk() using create_chunk()
>   btrfs-progs: fix to use half the available space for DUP profile
>   btrfs-progs: use round_down for allocation calcs
>   btrfs-progs: drop alloc_chunk_ctl::stripe_len
>   btrfs-progs: simplify arguments of chunk_bytes_by_type()
>   btrfs-progs: rename calc_size to stripe_size

Added to devel, thanks.
