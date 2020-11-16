Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E242B54A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 23:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKPWxS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 17:53:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:36536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgKPWxR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 17:53:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3CAA8AC22;
        Mon, 16 Nov 2020 22:53:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A412CDA6E3; Mon, 16 Nov 2020 23:51:30 +0100 (CET)
Date:   Mon, 16 Nov 2020 23:51:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 10/24] btrfs: introduce a helper to determine if the
 sectorsize is smaller than PAGE_SIZE
Message-ID: <20201116225129.GU6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-11-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-11-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:35PM +0800, Qu Wenruo wrote:
> Just to save us several letters for the incoming patches.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 99955b6bfc62..93de6134c65c 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3660,6 +3660,11 @@ static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
>  	return signal_pending(current);
>  }
>  
> +static inline bool btrfs_is_subpage(struct btrfs_fs_info *fs_info)
> +{
> +	return (fs_info->sectorsize < PAGE_SIZE);

I'm not convinced we want to obscure the simple check, saving a few
letters does not sound like a compelling argument. Nothing wrong to have
'sectorsize < PAGE_SIZE' in conditions.
