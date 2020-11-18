Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D09D2B81F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 17:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgKRQ3u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 11:29:50 -0500
Received: from twin.jikos.cz ([91.219.245.39]:35394 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbgKRQ3t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 11:29:49 -0500
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 0AIGTi7H020297
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 18 Nov 2020 17:29:45 +0100
Received: (from dave@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) id 0AIGTiwc020294;
        Wed, 18 Nov 2020 17:29:44 +0100
Date:   Wed, 18 Nov 2020 17:29:44 +0100
From:   David Sterba <dave@jikos.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 22/24] btrfs: scrub: support subpage data scrub
Message-ID: <20201118162944.GC17322@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-23-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-23-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:47PM +0800, Qu Wenruo wrote:
> @@ -1781,8 +1781,9 @@ static int scrub_checksum_data(struct scrub_block *sblock)
>  	struct scrub_ctx *sctx = sblock->sctx;
>  	struct btrfs_fs_info *fs_info = sctx->fs_info;
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> -	u8 csum[BTRFS_CSUM_SIZE];
>  	struct scrub_page *spage;
> +	u32 sectorsize = fs_info->sectorsize;
> +	u8 csum[BTRFS_CSUM_SIZE];
>  	char *kaddr;
>  
>  	BUG_ON(sblock->page_count < 1);
> @@ -1794,11 +1795,15 @@ static int scrub_checksum_data(struct scrub_block *sblock)
>  
>  	shash->tfm = fs_info->csum_shash;
>  	crypto_shash_init(shash);
> -	crypto_shash_digest(shash, kaddr, PAGE_SIZE, csum);
> +
> +	/*
> +	 * In scrub_pages() and scrub_pages_for_parity() we ensure
> +	 * each spage only contains just one sector of data.
> +	 */
> +	crypto_shash_digest(shash, kaddr, sectorsize, csum);

Temporary variable is not needed for single use (sectorsize).
