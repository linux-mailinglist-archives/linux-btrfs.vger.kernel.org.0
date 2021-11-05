Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7689044615D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 10:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhKEJ3n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 05:29:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49516 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhKEJ3n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 05:29:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 339571FD33;
        Fri,  5 Nov 2021 09:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636104422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7A5SZ/UEbfWRCHafGOxSg/avxB99ir/x5RrH09Q4zA=;
        b=DLRHMH7mFg40NenzB0hetUQ44+ZgujKRG9l244gzrVETXolAcBpkbO2XNuCvkof3FIe9tN
        syxvqiwSOtRefu4YsGWMoglIREVvsnUhy1+1578NUhj7Iuf3KjjAfQSyIfXFljIkujNhtt
        cpH5R8aiGjj9aza4cxidsmFouWE4mx8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0040F13B97;
        Fri,  5 Nov 2021 09:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZHUxOeX4hGG0ZAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 05 Nov 2021 09:27:01 +0000
Subject: Re: [PATCH v4 2/4] btrfs: expose chunk size in sysfs.
To:     Stefan Roesch <shr@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20211029183950.3613491-1-shr@fb.com>
 <20211029183950.3613491-3-shr@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1b9cde85-a7ee-42f9-f7ed-49169757e86a@suse.com>
Date:   Fri, 5 Nov 2021 11:27:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211029183950.3613491-3-shr@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.10.21 г. 21:39, Stefan Roesch wrote:
> This adds a new sysfs entry in /sys/fs/btrfs/<uuid>/allocation/<block
> type>/chunk_size. This allows to query the chunk size and also set the
> chunk size.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  fs/btrfs/sysfs.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index f9eff3b0f77c..3b0bcbc2ed2e 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -21,6 +21,7 @@
>  #include "space-info.h"
>  #include "block-group.h"
>  #include "qgroup.h"
> +#include "misc.h"
>  
>  /*
>   * Structure name                       Path
> @@ -92,6 +93,7 @@ static struct btrfs_feature_attr btrfs_attr_features_##_name = {	     \
>  
>  static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj);
>  static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj);
> +static inline struct kobject *get_btrfs_kobj(struct kobject *kobj);
>  
>  static struct btrfs_feature_attr *to_btrfs_feature_attr(struct kobj_attribute *a)
>  {
> @@ -708,6 +710,67 @@ static ssize_t btrfs_space_info_show_##field(struct kobject *kobj,	\
>  }									\
>  BTRFS_ATTR(space_info, field, btrfs_space_info_show_##field)
>  
> +/*
> + * Return space info chunk size.
> + */
> +static ssize_t btrfs_chunk_size_show(struct kobject *kobj,
> +				     struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_space_info *sinfo = to_space_info(kobj);
> +
> +	return btrfs_show_u64(&sinfo->default_chunk_size, &sinfo->lock, buf);
> +}
> +
> +/*
> + * Store new user supplied chunk size in space info.
> + *
> + * Note: If the new chunk size value is larger than 10% of free space it is
> + *       reduced to match that limit.
> + */
> +static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
> +				      struct kobj_attribute *a,
> +				      const char *buf, size_t len)
> +{
> +	struct btrfs_space_info *space_info = to_space_info(kobj);
> +	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
> +	u64 val;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (!fs_info) {
> +		pr_err("couldn't get fs_info\n");
> +		return -EPERM;
> +	}
> +
> +	if (sb_rdonly(fs_info->sb))
> +		return -EROFS;
> +
> +	if (!fs_info->fs_devices)
> +		return -EINVAL;
> +
> +	if (btrfs_is_zoned(fs_info))
> +		return -EINVAL;
> +
> +	if (!space_info) {
> +		btrfs_err(fs_info, "couldn't get space_info\n");
> +		return -EPERM;
> +	}
> +
> +	ret = kstrtoull(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Limit stripe size to 10% of available space.
> +	 */
> +	val = min(div_factor(fs_info->fs_devices->total_rw_bytes, 1), val);
> +	btrfs_update_space_info_chunk_size(space_info, space_info->flags, val);

I wonder if we need to enforce some sort of alignment i.e 128/256m
otherwise we give the user to give all kinds of funky byte sizes?

<snip>
