Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3721C2AC3E1
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 19:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgKISdj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 13:33:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:36780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729542AbgKISdj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 13:33:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84977AC24;
        Mon,  9 Nov 2020 18:33:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9E103DA7D7; Mon,  9 Nov 2020 19:31:57 +0100 (CET)
Date:   Mon, 9 Nov 2020 19:31:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 31/32] btrfs: scrub: support subpage tree block scrub
Message-ID: <20201109183157.GC6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-32-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103133108.148112-32-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 03, 2020 at 09:31:07PM +0800, Qu Wenruo wrote:
> To support subpage tree block scrub, scrub_checksum_tree_block() only
> needs to learn 2 new tricks:
> - Follow scrub_page::page_len
>   Now scrub_page only represents one sector, we need to follow it
>   properly.
> 
> - Run checksum on all sectors
>   Since scrub_page only represents one sector, we need to run hash on
>   all sectors, no longer just (nodesize >> PAGE_SIZE).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 230ba24a4fdf..deee5c9bd442 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1839,15 +1839,21 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
>  	struct scrub_ctx *sctx = sblock->sctx;
>  	struct btrfs_header *h;
>  	struct btrfs_fs_info *fs_info = sctx->fs_info;
> +	u32 sectorsize = sctx->fs_info->sectorsize;
> +	u32 nodesize = sctx->fs_info->nodesize;
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	u8 calculated_csum[BTRFS_CSUM_SIZE];
>  	u8 on_disk_csum[BTRFS_CSUM_SIZE];
> -	const int num_pages = sctx->fs_info->nodesize >> PAGE_SHIFT;
> +	const int num_sectors = nodesize / sectorsize;

You doh't need to declare sectorsize and nodesize just to do this
calculation, also all divisions by sectorsize should be
value >> sectorsize_bits.
