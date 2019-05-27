Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFE82B944
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 18:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfE0Q41 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 12:56:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfE0Q41 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 12:56:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D919BAC5A;
        Mon, 27 May 2019 16:56:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A07AFDA86B; Mon, 27 May 2019 18:57:20 +0200 (CEST)
Date:   Mon, 27 May 2019 18:57:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 06/13] btrfs: format checksums according to type for
 printing
Message-ID: <20190527165719.GN15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190522081910.7689-1-jthumshirn@suse.de>
 <20190522081910.7689-7-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522081910.7689-7-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 22, 2019 at 10:19:03AM +0200, Johannes Thumshirn wrote:
> Add a small helper for btrfs_print_data_csum_error() which formats the
> checksum according to it's type for pretty printing.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/btrfs_inode.h | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index d5b438706b77..f0a757eb5744 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -337,22 +337,42 @@ static inline void btrfs_inode_resume_unlocked_dio(struct btrfs_inode *inode)
>  	clear_bit(BTRFS_INODE_READDIO_NEED_LOCK, &inode->runtime_flags);
>  }
>  
> +static inline void btrfs_csum_format(struct btrfs_super_block *sb,
> +				     u32 csum, u8 *cbuf)
> +{
> +	size_t size = btrfs_super_csum_size(sb) * 8;
> +
> +	switch (btrfs_super_csum_type(sb)) {
> +	case BTRFS_CSUM_TYPE_CRC32:
> +		snprintf(cbuf, size, "0x%08x", csum);
> +		break;
> +	default: /* can't happen -  csum type is validated at mount time */
> +		break;
> +	}
> +}
> +
>  static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,
>  		u64 logical_start, u32 csum, u32 csum_expected, int mirror_num)
>  {
>  	struct btrfs_root *root = inode->root;
> +	struct btrfs_super_block *sb = root->fs_info->super_copy;
> +	u8 cbuf[BTRFS_CSUM_SIZE];
> +	u8 ecbuf[BTRFS_CSUM_SIZE];
> +
> +	btrfs_csum_format(sb, csum, cbuf);
> +	btrfs_csum_format(sb, csum_expected, ecbuf);

cbuf is 32 bytes (BTRFS_CSUM_SIZE) for the binary representation, while
you want reserve the space for the string representation, which is 2x
the size in bytes + "0x" prefix but that can be moved to the printk
format string.

So, the above is fine for crc32c the string will fit there, but with
sha256 this will cause buffer overflow, by 32 * 2 + 2 - 32 = 30 bytes.
Gotcha.

I think the helper is not needed at all, the format "%*phN" can be used
for crc32c too without the intermediate buffers. For better readability,
some macros can be added like

	"this is wrong csum " CSUM_FORMAT " end of string",
	CSUM_FORMAT_VALUE(csum_size, csum_bytes)

with CSUM_FORMAT "0x%*phN" and
CSUM_FORMAT_VALUE(size, bytes)	size, bytes

ie. just for the explict requirement of the variable length required by
"*".
