Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A4145B28
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 18:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAVRw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 12:52:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:58376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729009AbgAVRwx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 12:52:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CC0E6ACD9;
        Wed, 22 Jan 2020 17:52:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DA558DA730; Wed, 22 Jan 2020 18:52:35 +0100 (CET)
Date:   Wed, 22 Jan 2020 18:52:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     damenly.su@gmail.com
Cc:     linux-btrfs@vger.kernel.org, Su Yue <Damenly_Su@gmx.com>
Subject: Re: [PATCH V2 00/10] unify origanization structure of block group
 cache
Message-ID: <20200122175235.GC3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org, Su Yue <Damenly_Su@gmx.com>
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218051849.2587-1-Damenly_Su@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 18, 2019 at 01:18:39PM +0800, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
> 
> In progs, block group caches are stored in btrfs_fs_info::block_group_cache
> whose type is cache_extent. All block group caches adding/finding/freeing
> are done in the misleading set/clear_extent_bits ways. However, kernel
> side uses red-black tree structure in btrfs_fs_info directly. The
> latter's structure is more reasonable and intuitive.
> 
> This patchset transforms structure of block group caches from cache_extent
> to red-black tree and list.
> 
> patch[1] handles error to avoid warning after reform.
> patch[2-6] are about rb tree reform things in preparation.
> patch[7-8] are about dirty block groups linked in transaction in preparation.
> patch[9] does replace works in action.
> patch[10] does cleanup.
> 
> This patchset passed progs tests and did not cause any regression.
> 
> ---
> Changelog:
> v2:
>    Adjust block group cache tree seach and lookup functions to
>    progs behaviors.
>    Use rbtree_postorder_for_each_entry_safe() in patch[9] (Qu WenRuo).
>    Add reviewed-by tags.
> 
> Su Yue (10):
>   btrfs-progs: handle error if btrfs_write_one_block_group() failed
>   btrfs-progs: block_group: add rb tree related memebers
>   btrfs-progs: port block group cache tree insertion and lookup
>     functions
>   btrfs-progs: reform the function block_group_cache_tree_search()
>   btrfs-progs: adjust ported block group lookup functions in kernel
>     version
>   btrfs-progs: abstract function btrfs_add_block_group_cache()
>   block-progs: block_group: add dirty_bgs list related memebers
>   btrfs-progs: pass @trans to functions touch dirty block groups
>   btrfs-progs: reform block groups caches structure
>   btrfs-progs: cleanups after block group cache reform

As the patches were reviewed by Qu, I've added them to devel. I've
folded patch 5 to 4 as suggested. Thanks.
