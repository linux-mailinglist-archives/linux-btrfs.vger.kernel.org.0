Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CF062A06E
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 18:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiKOReR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 12:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiKOReO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 12:34:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10B9186FC;
        Tue, 15 Nov 2022 09:34:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 955D122ACD;
        Tue, 15 Nov 2022 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668533648;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QDUOe6qx/ITECWfExxKR6UHSqNkvVa8qB8JyT77HML4=;
        b=oe+1hJ5PadI0DQYx0jMDpWIebMOMPLbCcrnm9JG0uhCfA1isvIYzCfN4kwrsgkJ5/tem/9
        4Cs/mICZ4I6Rzy5b9Nimdwak0UqOffoF0BUTwa8j331+XptM+bUSrl9m+EdJdq6C9FIHH9
        dBSxeZLwDRH4zGXxqGw4raFIYgAU6Ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668533648;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QDUOe6qx/ITECWfExxKR6UHSqNkvVa8qB8JyT77HML4=;
        b=K6I53FWEjfDWU3tc2jw2RyDc3Y2OHtdph65NlYK+vM0DNz+qli94DJej15Hp4GtkSAzxsk
        1VTSsngLM3hNqtAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5279613A91;
        Tue, 15 Nov 2022 17:34:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l54hE5DNc2P/WQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 15 Nov 2022 17:34:08 +0000
Date:   Tue, 15 Nov 2022 18:33:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxiaoxu5@huawei.com, yanaijie@huawei.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com
Subject: Re: [PATCH v4 2/3] btrfs: qgroup: introduce
 btrfs_update_quoto_limit() helper
Message-ID: <20221115173342.GL5824@suse.cz>
Reply-To: dsterba@suse.cz
References: <20221115171709.3774614-1-chenxiaosong2@huawei.com>
 <20221115171709.3774614-3-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115171709.3774614-3-chenxiaosong2@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 16, 2022 at 01:17:08AM +0800, ChenXiaoSong wrote:
> No functional changed. Just simplify the code.

Please write some description of the change, like "factor out quota
limit update that also marks qgroup as inconsistent if it fals".

> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>  fs/btrfs/qgroup.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index d0480b9c6c86..ca609a70d067 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1677,6 +1677,19 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>  	return ret;
>  }
>  
> +static int btrfs_update_quoto_limit(struct btrfs_trans_handle *trans,

Typo 'quoto' and it should rather be qgroup as the limit is related to a
qgroup, quota is usually in connection with the whole subsystem.

> +				    struct btrfs_qgroup *qgroup,
> +				    struct btrfs_fs_info *fs_info)
> +{
> +	int ret = update_qgroup_limit_item(trans, qgroup);
> +	if (ret) {
> +		qgroup_mark_inconsistent(fs_info);
> +		btrfs_info(fs_info, "unable to update quota limit for %llu",
> +			   qgroup->qgroupid);
> +	}
> +	return ret;
> +}
> +
>  int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
>  		       struct btrfs_qgroup_limit *limit)
>  {
> @@ -1742,13 +1755,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
>  
>  	spin_unlock(&fs_info->qgroup_lock);
>  
> -	ret = update_qgroup_limit_item(trans, qgroup);
> -	if (ret) {
> -		qgroup_mark_inconsistent(fs_info);
> -		btrfs_info(fs_info, "unable to update quota limit for %llu",
> -		       qgroupid);
> -	}
> -
> +	ret = btrfs_update_quoto_limit(trans, qgroup, fs_info);
>  out:
>  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>  	return ret;
> @@ -2824,9 +2831,7 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
>  		ret = update_qgroup_info_item(trans, qgroup);
>  		if (ret)
>  			qgroup_mark_inconsistent(fs_info);
> -		ret = update_qgroup_limit_item(trans, qgroup);
> -		if (ret)
> -			qgroup_mark_inconsistent(fs_info);
> +		ret = btrfs_update_quoto_limit(trans, qgroup, fs_info);
>  		spin_lock(&fs_info->qgroup_lock);
>  	}
>  	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> @@ -2953,14 +2958,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>  		dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
>  		dstgroup->rsv_excl = inherit->lim.rsv_excl;
>  
> -		ret = update_qgroup_limit_item(trans, dstgroup);
> -		if (ret) {
> -			qgroup_mark_inconsistent(fs_info);
> -			btrfs_info(fs_info,
> -				   "unable to update quota limit for %llu",
> -				   dstgroup->qgroupid);
> +		ret = btrfs_update_quoto_limit(trans, dstgroup, fs_info);
> +		if (ret)
>  			goto unlock;
> -		}
>  	}
>  
>  	if (srcid) {
> -- 
> 2.31.1
> 
