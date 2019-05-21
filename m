Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE1225191
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfEUOKR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 10:10:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59632 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727941AbfEUOKR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 10:10:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DDADAFB6;
        Tue, 21 May 2019 14:10:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1AB3DA86B; Tue, 21 May 2019 16:11:13 +0200 (CEST)
Date:   Tue, 21 May 2019 16:11:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 10/13] btrfs: add boilerplate code for directly
 including the crypto framework
Message-ID: <20190521141113.GC15290@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190516084803.9774-1-jthumshirn@suse.de>
 <20190516084803.9774-11-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516084803.9774-11-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 16, 2019 at 10:48:00AM +0200, Johannes Thumshirn wrote:
> Add boilerplate code for directly including the crypto framework.
> 
> This helps us flipping the switch for new algorithms.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ctree.h   | 11 +++++++++++
>  fs/btrfs/disk-io.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2ec742db2001..0624057423d4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -73,6 +73,7 @@ struct btrfs_ref;
>  
>  /* four bytes for CRC32 */
>  static const int btrfs_csum_sizes[] = { 4 };
> +static char *btrfs_csum_names[] = { "crc32c" };
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
> @@ -2452,6 +2455,14 @@ static inline int btrfs_super_csum_size(const struct btrfs_super_block *s)
>  	return btrfs_csum_sizes[t];
>  }
>  
> +static inline char *btrfs_super_csum_name(const struct btrfs_super_block *s)
> +{
> +	u16 t = btrfs_super_csum_type(s);

Please don't use single letter variables, 'sb' and 'type' are fine.

> +static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info,
> +				struct btrfs_super_block *sb)
> +{
> +	struct crypto_shash *csum_shash;
> +	const char *csum_name = btrfs_super_csum_name(sb);
> +
> +	csum_shash = crypto_alloc_shash(csum_name, 0, 0);
> +
> +	if (IS_ERR(csum_shash)) {
> +		btrfs_err(fs_info, "error allocating %s hash for checksum\n",

No newline for the btrfs_* message helpers

> +			  csum_name);
> +		return PTR_ERR(csum_shash);
> +	}
> +
> +	fs_info->csum_shash = csum_shash;
> +
> +	return 0;
> +}
> +
> +static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
> +{
> +	crypto_free_shash(fs_info->csum_shash);
> +}
> +
>  static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
>  			    struct btrfs_fs_devices *fs_devices)
>  {
> @@ -2819,6 +2844,14 @@ int open_ctree(struct super_block *sb,
>  		goto fail_alloc;
>  	}
>  
> +

Extra newline

> +	ret = btrfs_init_csum_hash(fs_info, (struct btrfs_super_block *)
> +							   bh->b_data);

It would be better to avoid the cast and only pass the type, I don't see
anything else the init function would need from the sb.
