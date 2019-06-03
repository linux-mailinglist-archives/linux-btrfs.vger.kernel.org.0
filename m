Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4425C33529
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 18:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfFCQmI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 12:42:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:53868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727188AbfFCQmI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 12:42:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B1A1AE79;
        Mon,  3 Jun 2019 16:42:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7A78FDA85E; Mon,  3 Jun 2019 18:42:57 +0200 (CEST)
Date:   Mon, 3 Jun 2019 18:42:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v4 10/13] btrfs: add boilerplate code for directly
 including the crypto framework
Message-ID: <20190603164255.GQ15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190603145859.7176-1-jthumshirn@suse.de>
 <20190603145859.7176-11-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603145859.7176-11-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 04:58:56PM +0200, Johannes Thumshirn wrote:
> Add boilerplate code for directly including the crypto framework.
> 
> This helps us flipping the switch for new algorithms.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> ---
> - Remove stray newline (David)
> - Directly pass in csum_type to btrfs_init_csum_hash() (David)
> - Don't use single letter variables (David)
> ---
>  fs/btrfs/ctree.h   | 10 ++++++++++
>  fs/btrfs/disk-io.c | 46 +++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2ec742db2001..8b635ca370f5 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -73,6 +73,7 @@ struct btrfs_ref;
>  
>  /* four bytes for CRC32 */
>  static const int btrfs_csum_sizes[] = { 4 };
> +static char *btrfs_csum_names[] = { "crc32c" };

constified

>  
>  #define BTRFS_EMPTY_DIR_SIZE 0
>  
> @@ -1165,6 +1166,8 @@ struct btrfs_fs_info {
>  	spinlock_t ref_verify_lock;
>  	struct rb_root block_tree;
>  #endif
> +
> +	struct crypto_shash *csum_shash;
>  };
>  
>  static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
> @@ -2452,6 +2455,13 @@ static inline int btrfs_super_csum_size(const struct btrfs_super_block *s)
>  	return btrfs_csum_sizes[t];
>  }
>  
> +static inline char *btrfs_super_csum_name(u16 csum_type)

and here too

Reviewed-by: David Sterba <dsterba@suse.com>
