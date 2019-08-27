Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024989F035
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 18:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfH0Qck (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 12:32:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:60332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730400AbfH0Qck (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 12:32:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10C90AF79
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 16:32:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6767EDA8D5; Tue, 27 Aug 2019 18:33:02 +0200 (CEST)
Date:   Tue, 27 Aug 2019 18:33:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 01/11] btrfs-progs: don't blindly assume crc32c in
 csum_tree_block_size()
Message-ID: <20190827163302.GU2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190826114853.14860-1-jthumshirn@suse.de>
 <20190826114853.14860-2-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826114853.14860-2-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 26, 2019 at 01:48:43PM +0200, Johannes Thumshirn wrote:
> The callers of csum_tree_block_size() blindly assume we're only having
> crc32c as a possible checksum and thus pass in
> btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32] for the size argument of
> csum_tree_block_size().
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  mkfs/common.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mkfs/common.c b/mkfs/common.c
> index caca5e707233..b6e549b19272 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -101,7 +101,7 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
>  	}
>  
>  	/* generate checksum */
> -	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
> +	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);

Where is btrfs_mkfs_config::csum_type defined?
