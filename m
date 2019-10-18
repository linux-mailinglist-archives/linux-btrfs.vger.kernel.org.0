Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8CD2DD58C
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2019 01:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389926AbfJRXfu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 19:35:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727163AbfJRXfu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 19:35:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17E70ADF7
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Oct 2019 23:35:49 +0000 (UTC)
Date:   Fri, 18 Oct 2019 18:35:45 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Do not check for writeback in btrfs_releasepage()
Message-ID: <20191018233545.5kguaw4cjyrcsxwj@fiona>
References: <20191018181544.26515-1-rgoldwyn@suse.de>
 <20191018181544.26515-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018181544.26515-2-rgoldwyn@suse.de>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Scratch this. btrfs_releasepage() is called from btrfs_invalidatepage()
as well. Sorry for the noise.


On 13:15 18/10, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> We check for PageWriteback in try_to_release_page(), the
> sole caller of address_space->releasepage(). We don't need
> to check it again in btrfs_releasepage()
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0f2754eaa05b..10303c2379a9 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8793,7 +8793,7 @@ static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
>  
>  static int btrfs_releasepage(struct page *page, gfp_t gfp_flags)
>  {
> -	if (PageWriteback(page) || PageDirty(page))
> +	if (PageDirty(page))
>  		return 0;
>  	return __btrfs_releasepage(page, gfp_flags);
>  }
> -- 
> 2.16.4
> 

-- 
Goldwyn
