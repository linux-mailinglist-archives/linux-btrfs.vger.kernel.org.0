Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2712F83390
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 16:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfHFOHZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 10:07:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:51680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726834AbfHFOHZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Aug 2019 10:07:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95EEFAD43
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2019 14:07:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B378ADA7D7; Tue,  6 Aug 2019 16:07:56 +0200 (CEST)
Date:   Tue, 6 Aug 2019 16:07:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: transaction: Commit transaction more frequently
 for BPF
Message-ID: <20190806140756.GL28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190806082201.22683-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806082201.22683-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 06, 2019 at 04:22:01PM +0800, Qu Wenruo wrote:
> Btrfs has btrfs_end_transaction_throttle() which could try to commit
> transaction when needed.
> 
> However under most cases btrfs_end_transaction_throttle() won't really
> commit transaction, due to the hard timing requirement.
> 
> Now introduce a new error injection point, btrfs_need_trans_pressure(),
> to allow btrfs_should_end_transaction() to return 1 and
> btrfs_end_transaction_throttle() to fallback to
> btrfs_commit_transaction().
> 
> With such more aggressive transaction commit, we can dig deeper into
> cases like snapshot drop.
> Now each reference drop of btrfs_drop_snapshot() will lead to a
> transaction commit, allowing dm-logwrites to catch more details, other
> than one big transaction dropping everything.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/transaction.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 248d535bb14d..2e758957126e 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -10,6 +10,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/blkdev.h>
>  #include <linux/uuid.h>
> +#include <linux/error-injection.h>
>  #include "ctree.h"
>  #include "disk-io.h"
>  #include "transaction.h"
> @@ -781,10 +782,18 @@ void btrfs_throttle(struct btrfs_fs_info *fs_info)
>  	wait_current_trans(fs_info);
>  }
>  

Please put a comment here what's the purpose of the function otherwise
the people who like to delete code will find it and you know what will
happen next.

> +static noinline bool btrfs_need_trans_pressure(struct btrfs_trans_handle *trans)
> +{
> +	return false;
> +}
> +ALLOW_ERROR_INJECTION(btrfs_need_trans_pressure, TRUE);
> +
>  static int should_end_transaction(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  
> +	if (btrfs_need_trans_pressure(trans))
> +		return 1;
>  	if (btrfs_check_space_for_delayed_refs(fs_info))
>  		return 1;
>  
> @@ -845,6 +854,8 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
>  
>  	btrfs_trans_release_chunk_metadata(trans);
>  
> +	if (throttle && btrfs_need_trans_pressure(trans))
> +		return btrfs_commit_transaction(trans);
>  	if (lock && READ_ONCE(cur_trans->state) == TRANS_STATE_BLOCKED) {
>  		if (throttle)
>  			return btrfs_commit_transaction(trans);
> -- 
> 2.22.0
