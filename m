Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C4425170
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 16:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfEUOD7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 10:03:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:58394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728375AbfEUOD6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 10:03:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B922AAF8E;
        Tue, 21 May 2019 14:03:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AB455DA86B; Tue, 21 May 2019 16:04:54 +0200 (CEST)
Date:   Tue, 21 May 2019 16:04:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 07/13] btrfs: add common checksum type validation
Message-ID: <20190521140453.GA15290@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190516084803.9774-1-jthumshirn@suse.de>
 <20190516084803.9774-8-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516084803.9774-8-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 16, 2019 at 10:47:57AM +0200, Johannes Thumshirn wrote:
> Currently btrfs is only supporting CRC32C as checksumming algorithm. As
> this is about to change provide a function to validate the checksum type in
> the superblock against all possible algorithms.
> 
> This makes adding new algorithms easier as there are fewer places to adjust
> when adding new algorithms.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/disk-io.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 663efce22d98..ab13282d91d2 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -356,6 +356,16 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
>  	return ret;
>  }
>  
> +static bool btrfs_supported_super_csum(struct btrfs_super_block *sb)
> +{
> +	switch (btrfs_super_csum_type(sb)) {
> +	case BTRFS_CSUM_TYPE_CRC32:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /*
>   * Return 0 if the superblock checksum type matches the checksum value of that
>   * algorithm. Pass the raw disk superblock data.
> @@ -368,6 +378,12 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
>  	u16 csum_type = btrfs_super_csum_type(disk_sb);
>  	int ret = 0;
>  
> +	if (!btrfs_supported_super_csum(disk_sb)) {
> +		btrfs_err(fs_info, "unsupported checksum algorithm %u",
> +			  csum_type);
> +		ret = 1;

This can be direct 'return 1;', otherwise ok.

Reviewed-by: David Sterba <dsterba@suse.com>
