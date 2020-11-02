Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222462A2C32
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 14:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgKBN5B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 08:57:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:59884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgKBNzs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 08:55:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AD30AC3F;
        Mon,  2 Nov 2020 13:55:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4EF00DA7D2; Mon,  2 Nov 2020 14:54:09 +0100 (CET)
Date:   Mon, 2 Nov 2020 14:54:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix build warning due to u64 devided by u32 for
 32bit arch
Message-ID: <20201102135409.GA6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201102073114.66750-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102073114.66750-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 02, 2020 at 03:31:14PM +0800, Qu Wenruo wrote:
> [BUG]
> When building the kernel with subpage preparation patches, 32bit arches
> will complain about the following linking error:
> 
>    ld: fs/btrfs/extent_io.o: in function `release_extent_buffer':
>    fs/btrfs/extent_io.c:5340: undefined reference to `__udivdi3'
> 
> [CAUSE]
> For 32bits, dividing u64 with u32 need to call div_u64(), not directly
> call u64 / u32.
> 
> [FIX]
> Instead of calling the div_u64() macros, here we introduce a helper,
> btrfs_sector_shift(), to calculate the sector shift, and we just do bit
> shift to avoid executing the expensive division instruction.

Division is expensive but ilog2 does not come without a cost either.
It's implemented as bsrl+cmov, which can be also considered expensive
for frequent use.

> The sector_shift may be better cached in btrfs_fs_info, but so far there
> are only very limited callers for that, thus the fs_info::sector_shift
> can be there for further cleanup.
> 
> David, can this patch be folded into the offending commit?
> The patch is small enough, and doesn't change btrfs_fs_info.
> Thus should be OK to fold.

I have sent my series cleaning up the simple shifts, for the sectorsize
shift in particular see

https://lore.kernel.org/linux-btrfs/b38721840b8d703a29807b71460464134b9ca7e1.1603981453.git.dsterba@suse.com/

> Fixes: ef57afc454fb ("btrfs: extent_io: make btrfs_fs_info::buffer_radix to take sector size devided values")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h     |  5 +++++
>  fs/btrfs/extent_io.c | 14 +++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 8a83bce3225c..eb282af985f5 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3489,6 +3489,11 @@ static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
>  	return !!(btrfs_super_compat_ro_flags(disk_super) & flag);
>  }
>  
> +static inline u8 btrfs_sector_shift(struct btrfs_fs_info *fs_info)
> +{
> +	return ilog2(fs_info->sectorsize);

This has a runtime cost of calculating the the ilog2 each time we use
it.

> +}
> +
>  /* acl.c */
>  #ifdef CONFIG_BTRFS_FS_POSIX_ACL
>  struct posix_acl *btrfs_get_acl(struct inode *inode, int type);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 80b35885004a..3452019aef79 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5129,10 +5129,10 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
>  					 u64 start)
>  {
>  	struct extent_buffer *eb;
> +	u8 sector_shift = btrfs_sector_shift(fs_info);

And each use needs a temporary variable, where u8 generates worse
assembly and also potentially needs stack space.
