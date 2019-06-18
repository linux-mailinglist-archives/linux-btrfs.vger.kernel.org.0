Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789284A1CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 15:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfFRNNf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 09:13:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:45408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfFRNNf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 09:13:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B9D8B011
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:13:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D5B7DA871; Tue, 18 Jun 2019 15:14:22 +0200 (CEST)
Date:   Tue, 18 Jun 2019 15:14:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs-progs: Remove unnecessary fallthrough
 attribute in test_num_disk_vs_raid()
Message-ID: <20190618131422.GN19057@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190617075936.12113-1-wqu@suse.com>
 <20190617075936.12113-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617075936.12113-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Even though this is a simple fix, the warning should be here and the
versio that triggered it.

On Mon, Jun 17, 2019 at 03:59:35PM +0800, Qu Wenruo wrote:
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  utils.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/utils.c b/utils.c
> index 0b271517551b..2709ced97f97 100644
> --- a/utils.c
> +++ b/utils.c
> @@ -1928,7 +1928,6 @@ int test_num_disk_vs_raid(u64 metadata_profile, u64 data_profile,
>  		__attribute__ ((fallthrough));
>  	case 1:
>  		allowed |= BTRFS_BLOCK_GROUP_DUP;
> -		__attribute__ ((fallthrough));
>  	}
>  
>  	if (dev_cnt > 1 && profile & BTRFS_BLOCK_GROUP_DUP) {
> -- 
> 2.22.0
