Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE12FF97
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 17:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfE3Pso (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 11:48:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:56368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfE3Pso (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 11:48:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 761C9AD17;
        Thu, 30 May 2019 15:48:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6846ADA85E; Thu, 30 May 2019 17:49:37 +0200 (CEST)
Date:   Thu, 30 May 2019 17:49:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 08/13] btrfs: check for supported superblock checksum
 type before checksum validation
Message-ID: <20190530154937.GI15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190522081910.7689-1-jthumshirn@suse.de>
 <20190522081910.7689-9-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522081910.7689-9-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 22, 2019 at 10:19:05AM +0200, Johannes Thumshirn wrote:
> Now that we have factorerd out the superblock checksum type validation, we
> can check for supported superblock checksum types before doing the actual
> validation of the superblock read from disk.
> 
> This leads the path to further simplifications of btrfs_check_super_csum()
> later on.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> ---
> Changes to v2:
> - Print on-disk checksum type if we encounter an unsupported type (David)
> ---
>  fs/btrfs/disk-io.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 594583273782..f541d3c15d99 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2821,6 +2821,16 @@ int open_ctree(struct super_block *sb,
>  		goto fail_alloc;
>  	}
>  
> +	if (!btrfs_supported_super_csum((struct btrfs_super_block *)
> +					bh->b_data)) {

Previous patch changed this to u16

> +		btrfs_err(fs_info, "unsupported checksum algorithm: %d",

that's %u

> +			  btrfs_super_csum_type((struct btrfs_super_block *)
> +						bh->b_data));
> +		err = -EINVAL;
> +		brelse(bh);
> +		goto fail_alloc;
> +	}
> +
>  	/*
>  	 * We want to check superblock checksum, the type is stored inside.
>  	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
> -- 
> 2.16.4
