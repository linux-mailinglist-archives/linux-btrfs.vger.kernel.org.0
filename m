Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDD25393BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345538AbiEaPQk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbiEaPQj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:16:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B31DC00
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:16:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE87521C3D;
        Tue, 31 May 2022 15:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654010196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=334pva7nKmhthfR8FHlYwfDBglkdOLQHHYyQTkIoI74=;
        b=frNw/G1nna/ChjDLOXV9zDQ6Z9SUVOwmVxUPIpqmm2kEpXFHRLKLILex4X4mBcwpB0ctDv
        PdczSZarwyxY+itwkgM5en77Lm5ZqwkFo9dXu1US10vWDX5MlRp2yLxsj2sA6sDaTivuYB
        xujoRiGtOf9gKIPgXqM3bVE7jzhjWbs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FCFD13AA2;
        Tue, 31 May 2022 15:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /IApJFQxlmJ4SAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 31 May 2022 15:16:36 +0000
Message-ID: <9036075a-08b3-5830-1773-fddcf03438ae@suse.com>
Date:   Tue, 31 May 2022 18:16:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] btrfs: balance btree dirty pages and delayed items
 after a rename
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1654009356.git.fdmanana@suse.com>
 <06a51882e0ce06794248a10f5c1c70b987dab62f.1654009356.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <06a51882e0ce06794248a10f5c1c70b987dab62f.1654009356.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31.05.22 г. 18:06 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A rename operation modifies a subvolume's btree, to remove the old dir
> item, add the new dir item, remove an inode ref and add a new inode ref.
> It can also create the delayed inode for the inodes involved in the
> operation, and it creates two delayed dir index items, one to delete
> the old name and another one to add the new name.
> 
> However we are neither balancing the btree dirty pages nor the delayed
> items after a rename, which can result in accumulation of too many
> btree dirty pages and delayed items, specially if a task is doing a
> series of rename operations (for example it can happen for package
> installations/upgrades through the zypper tool).
> 
> So just call btrfs_btree_balance_dirty() after a rename, just like we
> do for every other system call that results on modifying a btree and
> adding delayed items.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

I guess that would manifest mostly in rename-heavy workloads. In any 
case it looks good.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>   fs/btrfs/inode.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ba913ea6f4d1..06d5bfa84d38 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9546,15 +9546,21 @@ static int btrfs_rename2(struct user_namespace *mnt_userns, struct inode *old_di
>   			 struct dentry *old_dentry, struct inode *new_dir,
>   			 struct dentry *new_dentry, unsigned int flags)
>   {
> +	int ret;
> +
>   	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
>   		return -EINVAL;
>   
>   	if (flags & RENAME_EXCHANGE)
> -		return btrfs_rename_exchange(old_dir, old_dentry, new_dir,
> -					  new_dentry);
> +		ret = btrfs_rename_exchange(old_dir, old_dentry, new_dir,
> +					    new_dentry);
> +	else
> +		ret = btrfs_rename(mnt_userns, old_dir, old_dentry, new_dir,
> +				   new_dentry, flags);
>   
> -	return btrfs_rename(mnt_userns, old_dir, old_dentry, new_dir,
> -			    new_dentry, flags);
> +	btrfs_btree_balance_dirty(BTRFS_I(new_dir)->root->fs_info);
> +
> +	return ret;
>   }
>   
>   struct btrfs_delalloc_work {
