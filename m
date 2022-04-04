Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2C04F1C53
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381453AbiDDV0a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379409AbiDDRIU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 13:08:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B7640A22
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 10:06:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8268B210DC;
        Mon,  4 Apr 2022 17:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649091982;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1CJ89gIRo48g6SWtvWGMjSm5IME6e0tMC6msLQPQwSs=;
        b=m+WwDHTkxPalCnDqHT8K59L48zEJzcUrO4u4hj0imjIkgz5fFCJXWkHvmbDWejfgtDVcMo
        ys3YOUNEcpp4PJw+32lbUup3owAzVw8CzuKigSsbhMb9PUErU8TgTYq0lX7CihVKb+5fwi
        urrkUFQhoxOvi0+MXrazrI9s31Uqy1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649091982;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1CJ89gIRo48g6SWtvWGMjSm5IME6e0tMC6msLQPQwSs=;
        b=da0B0U1CaxAqZ/+cUjwddLpirvar044qahqbwfozskawQw5xOHbqu3la0IIqv6iXud5ZXw
        s2NI28KpwRDmcYBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 73E0DA3B82;
        Mon,  4 Apr 2022 17:06:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8D27CDA80E; Mon,  4 Apr 2022 19:02:21 +0200 (CEST)
Date:   Mon, 4 Apr 2022 19:02:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stefan Roesch <shr@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v1 3/3] btrfs: add force_chunk_alloc sysfs entry to force
 allocation
Message-ID: <20220404170221.GU15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stefan Roesch <shr@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220208193122.492533-1-shr@fb.com>
 <20220208193122.492533-4-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208193122.492533-4-shr@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 08, 2022 at 11:31:22AM -0800, Stefan Roesch wrote:
> This adds the force_chunk_alloc sysfs entry to be able to force a
> storage allocation. This is a debugging and test feature and is
> enabled with the CONFIG_BTRFS_DEBUG configuration option.
> 
> It is stored at
> /sys/fs/btrfs/<uuid>/allocation/<block_type>/force_chunk_alloc.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  fs/btrfs/sysfs.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index ca337117f15b..4f4f038bc261 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -62,6 +62,10 @@ struct raid_kobject {
>  	.store	= _store,						\
>  }
>  
> +#define BTRFS_ATTR_W(_prefix, _name, _store)			        \
> +	static struct kobj_attribute btrfs_attr_##_prefix##_##_name =	\
> +			__INIT_KOBJ_ATTR(_name, 0200, NULL, _store)
> +
>  #define BTRFS_ATTR_RW(_prefix, _name, _show, _store)			\
>  	static struct kobj_attribute btrfs_attr_##_prefix##_##_name =	\
>  			__INIT_KOBJ_ATTR(_name, 0644, _show, _store)
> @@ -785,6 +789,54 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
>  	return val;
>  }
>  
> +#ifdef CONFIG_BTRFS_DEBUG
> +/*
> + * Request chunk allocation with current chunk size.
> + */
> +static ssize_t btrfs_force_chunk_alloc_store(struct kobject *kobj,
> +					     struct kobj_attribute *a,
> +					     const char *buf, size_t len)
> +{
> +	struct btrfs_space_info *space_info = to_space_info(kobj);
> +	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
> +	struct btrfs_trans_handle *trans;
> +	unsigned long val;
> +	int ret;
> +
> +	if (!fs_info) {
> +		pr_err("couldn't get fs_info\n");
> +		return -EPERM;
> +	}

Same comments as in patch 1

> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (sb_rdonly(fs_info->sb))
> +		return -EROFS;
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val == 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Allocate new chunk.
> +	 */
> +	trans = btrfs_start_transaction(fs_info->tree_root, 0);

Starting transaction from sysfs callbacks is not considered safe due to
potentially heavy operations going on, taking locks etc. and should be
done in the follwing way:

	btrfs_set_pending(fs_info, COMMIT);
	wake_up_process(fs_info->transaction_kthread);

> +	if (!trans)
> +		return PTR_ERR(trans);
> +	ret = btrfs_force_chunk_alloc(trans, space_info->flags);

Similar here, check the function, it does a lot of things, this is not
safe from sysfs context.

This will need to be done somewhere early in the transaction commit
after setting a new pending bit here in sysfs, like the
btrfs_set_pending(..., COMMIT) does.

> +	btrfs_end_transaction(trans);
> +
> +	if (ret == 1)
> +		return len;
> +
> +	return -ENOSPC;
> +}
> +#endif
> +
>  SPACE_INFO_ATTR(flags);
>  SPACE_INFO_ATTR(total_bytes);
>  SPACE_INFO_ATTR(bytes_used);
