Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1CC25172
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 16:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfEUOFO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 10:05:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:58658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbfEUOFN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 10:05:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CAB25AFA1;
        Tue, 21 May 2019 14:05:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 930B0DA86B; Tue, 21 May 2019 16:06:10 +0200 (CEST)
Date:   Tue, 21 May 2019 16:06:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] btrfs: check for supported superblock checksum
 type before checksum validation
Message-ID: <20190521140610.GB15290@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190516084803.9774-1-jthumshirn@suse.de>
 <20190516084803.9774-9-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516084803.9774-9-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 16, 2019 at 10:47:58AM +0200, Johannes Thumshirn wrote:
> Now that we have factorerd out the superblock checksum type validation, we
> can check for supported superblock checksum types before doing the actual
> validation of the superblock read from disk.
> 
> This leads the path to further simplifications of btrfs_check_super_csum()
> later on.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  fs/btrfs/disk-io.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index ab13282d91d2..74937effaed4 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2822,6 +2822,14 @@ int open_ctree(struct super_block *sb,
>  		goto fail_alloc;
>  	}
>  
> +	if (!btrfs_supported_super_csum((struct btrfs_super_block *)
> +					bh->b_data)) {
> +		btrfs_err(fs_info, "unsupported checksum algorithm");

The other error message printed the value and I think we should print
also the maximum. That's future proof once we have more algos.
