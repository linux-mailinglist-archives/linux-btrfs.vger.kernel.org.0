Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EE82125BA
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgGBOKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:10:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbgGBOKd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 10:10:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6899ADBB;
        Thu,  2 Jul 2020 14:10:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5A776DA781; Thu,  2 Jul 2020 16:10:16 +0200 (CEST)
Date:   Thu, 2 Jul 2020 16:10:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/10] btrfs: Remove fail label in check_compressed_csum
Message-ID: <20200702141016.GR27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-8-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702134650.16550-8-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 04:46:47PM +0300, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/compression.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 2f30bf4127f8..48ceab7be0fe 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -178,7 +178,6 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
> -	int ret;
>  	struct page *page;
>  	unsigned long i;
>  	char *kaddr;
> @@ -204,15 +203,12 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
>  			if (btrfs_io_bio(bio)->dev)
>  				btrfs_dev_stat_inc_and_print(btrfs_io_bio(bio)->dev,
>  					BTRFS_DEV_STAT_CORRUPTION_ERRS);
> -			ret = -EIO;
> -			goto fail;
> +			return -EIO;

Ok, that one looks obvious.
