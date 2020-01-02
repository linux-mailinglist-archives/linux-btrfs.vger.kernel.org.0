Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7BF12E8FE
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgABQ4O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:56:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:60882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgABQ4O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 11:56:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A33CBAAA6;
        Thu,  2 Jan 2020 16:56:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 685F7DA790; Thu,  2 Jan 2020 17:56:04 +0100 (CET)
Date:   Thu, 2 Jan 2020 17:56:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/6] btrfs-progs: extent-tree: Fix a by-one error in
 exclude_super_stripes()
Message-ID: <20200102165603.GL3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191218011942.9830-1-wqu@suse.com>
 <20191218011942.9830-7-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218011942.9830-7-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 18, 2019 at 09:19:42AM +0800, Qu Wenruo wrote:
> [BUG]
> For certain btrfs images, a BUG_ON() can be triggered at open_ctree()
> time:
>   Opening filesystem to check...
>   extent_io.c:158: insert_state: BUG_ON `end < start` triggered, value 1
>   btrfs(+0x2de57)[0x560c4d7cfe57]
>   btrfs(+0x2e210)[0x560c4d7d0210]
>   btrfs(set_extent_bits+0x254)[0x560c4d7d0854]
>   btrfs(exclude_super_stripes+0xbf)[0x560c4d7c65ff]
>   btrfs(btrfs_read_block_groups+0x29d)[0x560c4d7c698d]
>   btrfs(btrfs_setup_all_roots+0x3f3)[0x560c4d7c0b23]
>   btrfs(+0x1ef53)[0x560c4d7c0f53]
>   btrfs(open_ctree_fs_info+0x90)[0x560c4d7c11a0]
>   btrfs(+0x6d3f9)[0x560c4d80f3f9]
>   btrfs(main+0x94)[0x560c4d7b60c4]
>   /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7fd189773ee3]
>   btrfs(_start+0x2e)[0x560c4d7b635e]
> 
> [CAUSE]
> This is caused by passing @len == 0 to add_excluded_extent(), which
> means one revsere mapped range is just out of the block group range,
> normally means a by-one error.
> 
> [FIX]
> Fix the boundary check on the reserve mapped range against block group
> range.
> If a reverse mapped super block starts at the end of the block group, it
> doesn't cover so we don't need to bother the case.
> 
> Issue: #210
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  extent-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/extent-tree.c b/extent-tree.c
> index 6288c8a3..7ba80375 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -3640,7 +3640,7 @@ int exclude_super_stripes(struct btrfs_fs_info *fs_info,
>  		while (nr--) {
>  			u64 start, len;
>  
> -			if (logical[nr] > cache->key.objectid +
> +			if (logical[nr] >= cache->key.objectid +
>  			    cache->key.offset)

Do we have the same problem in kernel? The code does ">".
