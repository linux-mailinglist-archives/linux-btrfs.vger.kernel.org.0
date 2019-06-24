Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD2751901
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 18:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbfFXQuF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 12:50:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:58230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728651AbfFXQuF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 12:50:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9576AE74;
        Mon, 24 Jun 2019 16:50:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8410A1E2F23; Mon, 24 Jun 2019 18:50:03 +0200 (CEST)
Date:   Mon, 24 Jun 2019 18:50:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/9] blkcg, writeback: Implement wbc_blkcg_css()
Message-ID: <20190624165003.GO32376@quack2.suse.cz>
References: <20190615182453.843275-1-tj@kernel.org>
 <20190615182453.843275-4-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615182453.843275-4-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat 15-06-19 11:24:47, Tejun Heo wrote:
> Add a helper to determine the target blkcg from wbc.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/writeback.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index b8f5f000cde4..800ee031e88a 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -11,6 +11,7 @@
>  #include <linux/flex_proportions.h>
>  #include <linux/backing-dev-defs.h>
>  #include <linux/blk_types.h>
> +#include <linux/blk-cgroup.h>
>  
>  struct bio;
>  
> @@ -93,6 +94,16 @@ static inline int wbc_to_write_flags(struct writeback_control *wbc)
>  	return 0;
>  }
>  
> +static inline struct cgroup_subsys_state *
> +wbc_blkcg_css(struct writeback_control *wbc)
> +{
> +#ifdef CONFIG_CGROUP_WRITEBACK
> +	if (wbc->wb)
> +		return wbc->wb->blkcg_css;
> +#endif
> +	return blkcg_root_css;
> +}
> +
>  /*
>   * A wb_domain represents a domain that wb's (bdi_writeback's) belong to
>   * and are measured against each other in.  There always is one global
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
