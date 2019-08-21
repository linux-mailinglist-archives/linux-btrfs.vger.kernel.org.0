Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3FC97E04
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfHUPDX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 11:03:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:50748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727918AbfHUPDX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 11:03:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06ED3B622
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 15:03:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C84E0DA7DB; Wed, 21 Aug 2019 17:03:47 +0200 (CEST)
Date:   Wed, 21 Aug 2019 17:03:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: Refactor run_delalloc_nocow
Message-ID: <20190821150346.GK18575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190805144708.5432-2-nborisov@suse.com>
 <20190821074203.22329-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821074203.22329-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 21, 2019 at 10:42:03AM +0300, Nikolay Borisov wrote:
> Of the 22 (!!!) local variables declared in this function only 9 have
> function-wide context.

That's the evolution of code :)

> Of the remaining 13, 12 are needed in the main
> while loop of the function and 1 is needed in a tiny if branch, only in
> case we have prealloc extent. This commit reduces the lifespan of every
> variable to its bare minimum. It also renames the 'nolock'boolean to
> freespace_inode to clearly indicate its purpose.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> V2: 
>  * Don't add comment before assignment of prev_check
> 
>  fs/btrfs/inode.c | 61 ++++++++++++++++++++++--------------------------
>  1 file changed, 28 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ee582a36653d..fc6a8f9abb40 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1310,30 +1310,18 @@ static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
>   */
>  static noinline int run_delalloc_nocow(struct inode *inode,
>  				       struct page *locked_page,
> -			      u64 start, u64 end, int *page_started, int force,
> -			      unsigned long *nr_written)
> +				       const u64 start, const u64 end,
> +				       int *page_started, int force,
> +				       unsigned long *nr_written)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
> -	struct extent_buffer *leaf;
>  	struct btrfs_path *path;
> -	struct btrfs_file_extent_item *fi;
> -	struct btrfs_key found_key;
> -	struct extent_map *em;
> -	u64 cow_start;
> -	u64 cur_offset;
> -	u64 extent_end;
> -	u64 extent_offset;
> -	u64 disk_bytenr;
> -	u64 num_bytes;
> -	u64 disk_num_bytes;
> -	u64 ram_bytes;
> -	int extent_type;
> +	u64 cow_start = (u64)-1;
> +	u64 cur_offset = start;
>  	int ret;
> -	int type;
> -	int nocow;
> -	int check_prev = 1;
> -	bool nolock;
> +	bool check_prev = true;
> +	bool freespace_inode = btrfs_is_free_space_inode(BTRFS_I(inode));

You add 'const' to the parameters, I added one here too.

Reviewed-by: David Sterba <dsterba@suse.com>
