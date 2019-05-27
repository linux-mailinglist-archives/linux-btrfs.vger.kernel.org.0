Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FCE2B953
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfE0RJ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 13:09:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbfE0RJ1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 13:09:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FF67ACBC;
        Mon, 27 May 2019 17:09:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 50960DA84F; Mon, 27 May 2019 19:10:21 +0200 (CEST)
Date:   Mon, 27 May 2019 19:10:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [RFC PATCH v3 13/13] btrfs: add sha256 as another checksum
 algorithm
Message-ID: <20190527171021.GO15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190522081910.7689-1-jthumshirn@suse.de>
 <20190522081910.7689-14-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522081910.7689-14-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 22, 2019 at 10:19:10AM +0200, Johannes Thumshirn wrote:
> Now that we everything in place, we can add SHA-256 as another checksum
> algorithm.
> 
> SHA-256 was taken as it was the cryptographically strongest algorithm that
> can fit into the 32 Bytes we have left.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> ---
> changes to v2:
> - Add pre dependency on sha256
> Changes to v1:
> - Select SHA-256 in KConfig
> - Minimalize switch() in btrfs_supported_super_csum() (Nikolay)
> - Use enum for new on-disk checksum type (Nikolay/David)
> - Format SHA256 using sprintf()'s hexdump mode
> ---
>  fs/btrfs/Kconfig                | 1 +
>  fs/btrfs/btrfs_inode.h          | 3 +++
>  fs/btrfs/ctree.h                | 4 ++--
>  fs/btrfs/disk-io.c              | 1 +
>  fs/btrfs/super.c                | 1 +
>  include/uapi/linux/btrfs_tree.h | 6 ++++--
>  6 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index 212b4a854f2c..2521a24f74be 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -4,6 +4,7 @@ config BTRFS_FS
>  	tristate "Btrfs filesystem support"
>  	select CRYPTO
>  	select CRYPTO_CRC32C
> +	select CRYPTO_SHA256
>  	select ZLIB_INFLATE
>  	select ZLIB_DEFLATE
>  	select LZO_COMPRESS
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index e79fd9129075..125bc7f3b871 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -346,6 +346,9 @@ static inline void btrfs_csum_format(struct btrfs_super_block *sb,
>  	case BTRFS_CSUM_TYPE_CRC32:
>  		snprintf(cbuf, size, "0x%08x", *(u32 *)csum);
>  		break;
> +	case BTRFS_CSUM_TYPE_SHA256:
> +		snprintf(cbuf, size, "%*phN", (int)size / 8, csum);

This seems to print the buffer in the host order ('h', other formats use
that). I wonder if there needs to be some caution about endianity here.
Ideally we won't need to care and just use the right format that will
printk handle transparently for us.
