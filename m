Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AC81A8DF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 23:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634079AbgDNVny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 17:43:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:39836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634069AbgDNVno (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 17:43:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8494DAC7F;
        Tue, 14 Apr 2020 21:43:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 29471DA823; Tue, 14 Apr 2020 23:43:00 +0200 (CEST)
Date:   Tue, 14 Apr 2020 23:43:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: Move on-disk structure definition to
 btrfs_tree.h
Message-ID: <20200414214300.GW5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200408070608.41099-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408070608.41099-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 08, 2020 at 03:06:08PM +0800, Qu Wenruo wrote:
> These structures all are on-disk format. Move them to btrfs_tree.h
> 
> This allows us to sync the header to different projects, who need to
> read btrfs filesystem, like U-boot, grub.
> 
> With this modification, all on-disk format is definite in btrfs_tree.h,
> and can be easily synced to other projects.
> 
> This move includes:
> - btrfs magic
>   It's a surprise that it's not even definied in btrfs_tree.h

There was no need for it so far, blkid has its own definition and f_type
in stat provides the raw bytes. I don't find it surprising :)

> - tree block max level
>   Move it before btrfs_header definition.
> 
> - tree block backref revision
> - btrfs_header structure
> - btrfs_root_backup structure
> - btrfs_super_block structure
> - BTRFS_FEATURE_* flags
> - BTRFS_(FSID|UUID|LABEL)_SIZE macros
> - BTRFS_MAX_METADATA_BLOCKSIZE macro
> - BTRFS_NAME_LEN macro
> 
> - btrfs_item structure
> - btrfs_leaf structure
> - btrfs_key_ptr structure
> - btrfs_node structure
> 
> - btrfs_dev_stat_values
>   Since on-disk format btrfs_dev_stats_item needs it.
> 
> - BTRFS_INODE_* flags
> - BTRFS_QGROUP_LIMIT_* flags
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add the reason why we move the code
> 
> v3:
> - Move more flags/enum shared with ioctl to btrfs_btree.h
>   This makes ioctl header to rely on btree_btree.h.
>   But this makes btrfs_tree.h completely self-consistent.
>   This problem is mostly exposed when syncing the header to btrfs-progs.
> ---
>  fs/btrfs/ctree.h                | 246 ------------------------
>  include/uapi/linux/btrfs.h      |  74 +------
>  include/uapi/linux/btrfs_tree.h | 329 +++++++++++++++++++++++++++++++-
>  3 files changed, 327 insertions(+), 322 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 8aa7b9dac405..4d787d749315 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -49,8 +49,6 @@ extern struct kmem_cache *btrfs_free_space_bitmap_cachep;
>  struct btrfs_ordered_sum;
>  struct btrfs_ref;
>  
> -#define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
> -
>  /*
>   * Maximum number of mirrors that can be available for all profiles counting
>   * the target device of dev-replace as one. During an active device replace
> @@ -62,22 +60,8 @@ struct btrfs_ref;
>   */
>  #define BTRFS_MAX_MIRRORS (4 + 1)
>  
> -#define BTRFS_MAX_LEVEL 8
> -
>  #define BTRFS_OLDEST_GENERATION	0ULL
>  
> -/*
> - * the max metadata block size.  This limit is somewhat artificial,
> - * but the memmove costs go through the roof for larger blocks.
> - */
> -#define BTRFS_MAX_METADATA_BLOCKSIZE 65536

So lots of comments and defines get moved, please take the opportunity
to actually unify the formatting to the current preferred style.
