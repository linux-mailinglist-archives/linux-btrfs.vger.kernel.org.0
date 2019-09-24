Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF4BC890
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 15:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfIXNGZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 09:06:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:41350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727930AbfIXNGZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 09:06:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6E58B027;
        Tue, 24 Sep 2019 13:06:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B148EDA959; Tue, 24 Sep 2019 15:06:44 +0200 (CEST)
Date:   Tue, 24 Sep 2019 15:06:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 01/12] btrfs-progs: don't blindly assume crc32c in
 csum_tree_block_size()
Message-ID: <20190924130644.GQ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190903150046.14926-1-jthumshirn@suse.de>
 <20190903150046.14926-2-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903150046.14926-2-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 03, 2019 at 05:00:35PM +0200, Johannes Thumshirn wrote:
> The callers of csum_tree_block_size() blindly assume we're only having
> crc32c as a possible checksum and thus pass in
> btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32] for the size argument of
> csum_tree_block_size().
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  mkfs/common.c | 14 +++++++-------
>  mkfs/common.h |  2 ++
>  2 files changed, 9 insertions(+), 7 deletions(-)
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

I don't see where cfg->csum_type is initialized. The tests pass so
there's probably some implicit initialization to 0 that makes it work.
