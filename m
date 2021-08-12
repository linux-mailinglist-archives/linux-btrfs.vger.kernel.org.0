Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213763EA692
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbhHLO3T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 10:29:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54018 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhHLO3T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 10:29:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2F95822235;
        Thu, 12 Aug 2021 14:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628778533;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NuHThcRUUKeZtfJ9xFXzkJyiUUzCiJMKKn+BOZWo6NY=;
        b=aFGaGJlZjT7syG/hPnVniWEjUvnnjTkCLe9DXlTVaYkokd9d4T48WMVPXknSH/BZ3vPx3/
        lvbSWE7Tyc2Xd8At7MVK/zQY6sLfcJdwdUKhdZlwH4APu7lZkVRgWKU2GVMHEIR7+DKsuj
        qg/WxwX7fNyO4jzVpwetc7YzaDc9H1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628778533;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NuHThcRUUKeZtfJ9xFXzkJyiUUzCiJMKKn+BOZWo6NY=;
        b=xrsr8K2UwI0+7LNPFIpRjwUd6hc70VPCeCnMXaPhqrs5Dw0DDex1uLW44xbfu5lQRRtzFk
        oNOztX7zYf/Z7YDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F1CD6A3F4F;
        Thu, 12 Aug 2021 14:28:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6210EDA733; Thu, 12 Aug 2021 16:25:59 +0200 (CEST)
Date:   Thu, 12 Aug 2021 16:25:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: exclude relocation and page writeback
Message-ID: <20210812142558.GI5047@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <a858fb2ff980db27b3638e92f7d2d7a416b8e81e.1628776260.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a858fb2ff980db27b3638e92f7d2d7a416b8e81e.1628776260.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 12, 2021 at 10:53:49PM +0900, Johannes Thumshirn wrote:
> Relocation in a zoned filesystem can fail with a transaction abort with
> error -22 (EINVAL). This happens because the relocation code assumes that
> the extents we relocated the data to have the same size the source extents
> had and ensures this by preallocating the extents.
> 
> But in a zoned filesystem we can't preallocate the extents as this would
> break the sequential write required rule. Therefore it can happen that the
> writeback process kicks in while we're still adding pages to a
> delallocation range and starts writing out dirty pages.
> 
> This then creates destination extents that are smaller than the source
> extents, triggering the following safety check in get_new_location():
> 
>  1034         if (num_bytes != btrfs_file_extent_disk_num_bytes(leaf, fi)) {
>  1035                 ret = -EINVAL;
>  1036                 goto out;
>  1037         }
> 
> One possible solution to address this problem is to mutually exclude page
> writeback and adding pages to the relocation inode. This ensures, that
> we're not submitting an extent before all needed pages have been added to
> it.
> 
> Introduce a new lock in the btrfs_inode which is only taken *IFF* the
> inode is a data relocation inode on a zoned filesystem to mutually exclude
> relocation's construction of extents and page writeback.
> 
> Fixes: 32430c614844 ("btrfs: zoned: enable relocation on a zoned filesystem")
> Reported-by: David Sterba <dsterba@suse.com>
> Cc: Filipe Manana <fdmanana@suse.com>
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/btrfs_inode.h |  3 +++
>  fs/btrfs/extent_io.c   |  4 ++++
>  fs/btrfs/inode.c       |  1 +
>  fs/btrfs/relocation.c  | 10 +++++++---
>  fs/btrfs/zoned.h       | 27 +++++++++++++++++++++++++++
>  5 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 76ee1452c57b..954e772f18e8 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -231,6 +231,9 @@ struct btrfs_inode {
>  
>  	struct rw_semaphore i_mmap_lock;
>  	struct inode vfs_inode;
> +
> +	/* Protects relocation from page writeback on a zoned FS */
> +	struct mutex relocation_lock;

That's a lot of new bytes for an inode, and just for zoned mode. Is
there another way how to synchronize that? Like some inode state bit and
then waiting on it, using the generic wait queues and API like
wait_var_event?
