Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D974B26A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 08:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfFSGxJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 02:53:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:58928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfFSGxJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 02:53:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1286BAF97;
        Wed, 19 Jun 2019 06:53:07 +0000 (UTC)
Subject: Re: [PATCH][v2] btrfs: run delayed iput at unlink time
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20190618145918.12641-1-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d5797b9a-6f54-591c-027e-f49aa168c941@suse.com>
Date:   Wed, 19 Jun 2019 09:53:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618145918.12641-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.06.19 г. 17:59 ч., Josef Bacik wrote:
> We have been seeing issues in production where a cleaner script will end
> up unlinking a bunch of files that have pending iputs.  This means they
> will get their final iput's run at btrfs-cleaner time and thus are not
> throttled, which impacts the workload.
> 
> Since we are unlinking these files we can just drop the delayed iput at
> unlink time.  We are already holding a reference to the inode so this
> will not be the final iput and thus is completely safe to do at this
> point.  Doing this means we are more likely to be doing the final iput
> at unlink time, and thus will get the IO charged to the caller and get
> throttled appropriately without affecting the main workload.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

That looks a lot nicer and the explanation is sufficient.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
> v1->v2:
> - consolidate the delayed iput run into a helper.
> 
>  fs/btrfs/inode.c | 40 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 33380f5e2e8a..c311bf6d52f4 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3326,6 +3326,28 @@ void btrfs_add_delayed_iput(struct inode *inode)
>  		wake_up_process(fs_info->cleaner_kthread);
>  }
>  
> +static void run_delayed_iput_locked(struct btrfs_fs_info *fs_info,
> +				    struct btrfs_inode *inode)
> +{
> +	list_del_init(&inode->delayed_iput);
> +	spin_unlock(&fs_info->delayed_iput_lock);
> +	iput(&inode->vfs_inode);
> +	if (atomic_dec_and_test(&fs_info->nr_delayed_iputs))
> +		wake_up(&fs_info->delayed_iputs_wait);
> +	spin_lock(&fs_info->delayed_iput_lock);
> +}
> +
> +static void btrfs_run_delayed_iput(struct btrfs_fs_info *fs_info,
> +				   struct btrfs_inode *inode)
> +{
> +	if (!list_empty(&inode->delayed_iput)) {
> +		spin_lock(&fs_info->delayed_iput_lock);
> +		if (!list_empty(&inode->delayed_iput))
> +			run_delayed_iput_locked(fs_info, inode);
> +		spin_unlock(&fs_info->delayed_iput_lock);
> +	}
> +}
> +
>  void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
>  {
>  
> @@ -3335,12 +3357,7 @@ void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
>  
>  		inode = list_first_entry(&fs_info->delayed_iputs,
>  				struct btrfs_inode, delayed_iput);
> -		list_del_init(&inode->delayed_iput);
> -		spin_unlock(&fs_info->delayed_iput_lock);
> -		iput(&inode->vfs_inode);
> -		if (atomic_dec_and_test(&fs_info->nr_delayed_iputs))
> -			wake_up(&fs_info->delayed_iputs_wait);
> -		spin_lock(&fs_info->delayed_iput_lock);
> +		run_delayed_iput_locked(fs_info, inode);
>  	}
>  	spin_unlock(&fs_info->delayed_iput_lock);
>  }
> @@ -4045,6 +4062,17 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
>  		ret = 0;
>  	else if (ret)
>  		btrfs_abort_transaction(trans, ret);
> +
> +	/*
> +	 * If we have a pending delayed iput we could end up with the final iput
> +	 * being run in btrfs-cleaner context.  If we have enough of these built
> +	 * up we can end up burning a lot of time in btrfs-cleaner without any
> +	 * way to throttle the unlinks.  Since we're currently holding a ref on
> +	 * the inode we can run the delayed iput here without any issues as the
> +	 * final iput won't be done until after we drop the ref we're currently
> +	 * holding.
> +	 */
> +	btrfs_run_delayed_iput(fs_info, inode);
>  err:
>  	btrfs_free_path(path);
>  	if (ret)
> 
