Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12082B8453
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 20:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKRTCW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 14:02:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:42670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgKRTCW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 14:02:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2FB53B9D3;
        Wed, 18 Nov 2020 19:02:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7BA5ADA701; Wed, 18 Nov 2020 20:00:35 +0100 (CET)
Date:   Wed, 18 Nov 2020 20:00:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 19/24] btrfs: scrub: remove the anonymous structure
 from scrub_page
Message-ID: <20201118190035.GA20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-20-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-20-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:44PM +0800, Qu Wenruo wrote:
> That anonymous structure serve no special purpose, just replace it with
> regular members.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 57ee06d92150..06f6428b97d1 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -71,11 +71,9 @@ struct scrub_page {
>  	u64			physical;
>  	u64			physical_for_dev_replace;
>  	atomic_t		refs;
> -	struct {
> -		unsigned int	mirror_num:8;
> -		unsigned int	have_csum:1;
> -		unsigned int	io_error:1;
> -	};
> +	u8			mirror_num;
> +	int			have_csum:1;
> +	int			io_error:1;

Note that bitfields need to be unsigned. This could be also bool as
there's a bit of space, but this misaligns csum by 1 byte so that's for
more evaluation and another patch.

>  	u8			csum[BTRFS_CSUM_SIZE];
>  
>  	struct scrub_recover	*recover;
> --
