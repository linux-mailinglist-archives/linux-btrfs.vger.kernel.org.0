Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84448D842
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 13:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiAMMxQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 07:53:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51448 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiAMMxP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 07:53:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7ED1E210E9;
        Thu, 13 Jan 2022 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642078394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYY0jmwUj0iYMLLKGpDY7q8D3L/QHhK9aXA+u0bKdwo=;
        b=VUEcXtDtGGfgOmHw+aDE4ZUtONOKMcF3kFy3KFypacor6lJaefbJ7RaJn0INsXJL3jAqVa
        di0p1GtGvRb2WoXzh4vRWLlH8qtSFhp3ynvhzfMAOx/9pskT1q5vRBMo23czuG+iWwKZ5b
        jhZ/uJwemZ22MtVkYEc8NedVBLPZwoQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D6A013FB3;
        Thu, 13 Jan 2022 12:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 97AUBLog4GGbTgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 13 Jan 2022 12:53:14 +0000
Subject: Re: [PATCH] btrfs: fix deadlock between quota disable and qgroup
 rescan worker
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220113104029.902200-1-shinichiro.kawasaki@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <fa15b470-c2ad-152a-9398-17bf65be4eba@suse.com>
Date:   Thu, 13 Jan 2022 14:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113104029.902200-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.01.22 г. 12:40, Shin'ichiro Kawasaki wrote:
> Quota disable ioctl starts a transaction before waiting for the qgroup
> rescan worker completes. However, this wait can be infinite and results
> in deadlock because of circular dependency among the quota disable
> ioctl, the qgroup rescan worker and the other task with transaction such
> as block group relocation task.

<snip>

> Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  fs/btrfs/ctree.h  |  2 ++
>  fs/btrfs/qgroup.c | 20 ++++++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b4a9b1c58d22..fe275697e3eb 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -145,6 +145,8 @@ enum {
>  	BTRFS_FS_STATE_DUMMY_FS_INFO,
>  
>  	BTRFS_FS_STATE_NO_CSUMS,
> +	/* Quota is in disabling process */
> +	BTRFS_FS_STATE_QUOTA_DISABLING,
>  };
>  
>  #define BTRFS_BACKREF_REV_MAX		256
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 8928275823a1..6f94da4896bc 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1188,6 +1188,17 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
>  	if (!fs_info->quota_root)
>  		goto out;
> +	/*
> +	 * Request qgroup rescan worker to complete and wait for it. This wait
> +	 * must be done before transaction start for quota disable since it may
> +	 * deadlock with transaction by the qgroup rescan worker.
> +	 */
> +	if (test_and_set_bit(BTRFS_FS_STATE_QUOTA_DISABLING,
> +			     &fs_info->fs_state)) {
> +		ret = -EBUSY;
> +		goto busy;
> +	}
> +	btrfs_qgroup_wait_for_completion(fs_info, false);

Actually you don't need to introduce a separate flag to have this logic,
simply clear QUOTA_ENABLED, do the wait, start the transaction - in case
of failure i.e not able to get a trans handle just set QUOTA_ENABLED
again. Still, moving QUOTA_ENABLED check in rescan_should_stop would be
useful as well.

>  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>  
>  	/*
> @@ -1212,7 +1223,6 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
>  		goto out;
>  
>  	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> -	btrfs_qgroup_wait_for_completion(fs_info, false);
>  	spin_lock(&fs_info->qgroup_lock);
>  	quota_root = fs_info->quota_root;
>  	fs_info->quota_root = NULL;
> @@ -1244,6 +1254,8 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
>  	btrfs_put_root(quota_root);
>  
>  out:
> +	clear_bit(BTRFS_FS_STATE_QUOTA_DISABLING, &fs_info->fs_state);
> +busy:
>  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>  	if (ret && trans)
>  		btrfs_end_transaction(trans);
> @@ -3277,7 +3289,8 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
>  			err = PTR_ERR(trans);
>  			break;
>  		}
> -		if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
> +		if (test_bit(BTRFS_FS_STATE_QUOTA_DISABLING,
> +			     &fs_info->fs_state)) {
>  			err = -EINTR;
>  		} else {
>  			err = qgroup_rescan_leaf(trans, path);
> @@ -3378,6 +3391,9 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
>  			btrfs_warn(fs_info,
>  				   "qgroup rescan is already in progress");
>  			ret = -EINPROGRESS;
> +		} else if (test_bit(BTRFS_FS_STATE_QUOTA_DISABLING,
> +				    &fs_info->fs_state)) {
> +			ret = -EBUSY;
>  		} else if (!(fs_info->qgroup_flags &
>  			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
>  			btrfs_warn(fs_info,
> 
