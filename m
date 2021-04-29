Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB436F0E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 22:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhD2UGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 16:06:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:59756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232539AbhD2UGV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 16:06:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84CAEADE2;
        Thu, 29 Apr 2021 20:05:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2A44BDA7D2; Thu, 29 Apr 2021 22:03:10 +0200 (CEST)
Date:   Thu, 29 Apr 2021 22:03:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/7] btrfs: take into account global rsv in
 need_preemptive_reclaim
Message-ID: <20210429200310.GB7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1619631053.git.josef@toxicpanda.com>
 <febdf6d9ff9efc92034ed688d61b38a9b53a5abf.1619631053.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <febdf6d9ff9efc92034ed688d61b38a9b53a5abf.1619631053.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 28, 2021 at 01:38:44PM -0400, Josef Bacik wrote:
> Global rsv can't be used for normal allocations, and for very full file
> systems we can decide to try and async flush constantly even though
> there's really not a lot of space to reclaim.  Deal with this by
> including the global block rsv size in the "total used" calculation.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 33edab17af0d..e341f995a7dd 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -792,12 +792,14 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
>  static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
>  				    struct btrfs_space_info *space_info)
>  {
> +	u64 global_rsv_size = fs_info->global_block_rsv.reserved;
>  	u64 ordered, delalloc;
>  	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
>  	u64 used;
>  
>  	/* If we're just plain full then async reclaim just slows us down. */
> -	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
> +	if ((space_info->bytes_used + space_info->bytes_reserved +
> +	     global_rsv_size) >= thresh)

That's an extra variable for one time use. Do you have plans to use it
in further patches? Regarding readability, it has to be put on a
separate line anyway so there's space for the whole identifier bit if
you intend to use it then it's ok to keep it.
