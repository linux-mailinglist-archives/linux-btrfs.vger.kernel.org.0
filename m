Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3E34F1C5C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382259AbiDDV0i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379308AbiDDQ6B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 12:58:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772963B3EC
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 09:56:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 330F9210DC;
        Mon,  4 Apr 2022 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649091363;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KloOBxSbQT0TxqPGI8Q3ipgs0Fa/b5Jpx69E18og7cU=;
        b=Yr3scrTg4S2e5SOjsN2kucQPF5B6aBE/+L73IXdw+W738GpEnsSb6nO483ZySxyAhKQAdl
        SEljpJlZG8ilLpeCQDh2d8E5nxdLecygusPbz3zXKdciLQQIZUp8zLTbU7ISliWaErDjAU
        lqE/kLl3C5apcI0+fOq06qB3NLFEZ0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649091363;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KloOBxSbQT0TxqPGI8Q3ipgs0Fa/b5Jpx69E18og7cU=;
        b=By3+ofTRuL/7BFcSMkf1999p6CrwOeznIO4uB1MA1jM8eGkCKLTgix0fqHZHUUWdCGaFwL
        dVC5qXQZqT/PRaCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 295B2A3B83;
        Mon,  4 Apr 2022 16:56:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 607B4DA80E; Mon,  4 Apr 2022 18:52:02 +0200 (CEST)
Date:   Mon, 4 Apr 2022 18:52:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stefan Roesch <shr@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v1 2/3] btrfs: expose chunk size in sysfs.
Message-ID: <20220404165201.GT15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stefan Roesch <shr@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220208193122.492533-1-shr@fb.com>
 <20220208193122.492533-3-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208193122.492533-3-shr@fb.com>
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

On Tue, Feb 08, 2022 at 11:31:21AM -0800, Stefan Roesch wrote:
> This adds a new sysfs entry in /sys/fs/btrfs/<uuid>/allocation/<block
> type>/chunk_size. This allows to query the chunk size and also set the
> chunk size.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  fs/btrfs/sysfs.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index beb7f72d50b8..ca337117f15b 100644
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
> @@ -708,6 +710,81 @@ static ssize_t btrfs_space_info_show_##field(struct kobject *kobj,	\
>  }									\
>  BTRFS_ATTR(space_info, field, btrfs_space_info_show_##field)
>  
> +/*
> + * Return space info chunk size.
> + */

Comment not necessary.

> +static ssize_t btrfs_chunk_size_show(struct kobject *kobj,
> +				     struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_space_info *sinfo = to_space_info(kobj);
> +
> +	return sysfs_emit(buf, "%llu\n", atomic64_read(&sinfo->chunk_size));
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

What's the reason for such error message? I would end up in the system
log without any context so it does not bring any value to user nor does
it tell what wen wrong.

Checking other functions, there's no such check in most of them and I
don't think it's needed, the filesystem can't be unmounted with open
file references to sysfs.

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

Same as the error message above.

Also I'm not sure there could be a NULL space_info, it's one of the core
data structures used all the time.

> +		return -EPERM;
> +	}
> +
> +	/* System block type must not be changed. */
> +	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
> +		return -EINVAL;

This would probably be EPERM, EINVAL is for invalid values (like out of
range).

> +
> +	ret = kstrtoull(buf, 10, &val);

As this is supposed to be used by humans, it's better to use memparse
that also translates the K/M/G suffix so it's easy to write '256M' etc.

> +	if (ret)
> +		return ret;
> +
> +	val = min(val, BTRFS_MAX_DATA_CHUNK_SIZE);
> +
> +	/*
> +	 * Limit stripe size to 10% of available space.
> +	 */
> +	val = min(div_factor(fs_info->fs_devices->total_rw_bytes, 1), val);
> +
> +	/* Must be multiple of 256M. */
> +	val &= ~(SZ_256M - 1);

Where does this requirement come from?

> +
> +	/* Must be at least 256M. */
> +	if (val < SZ_256M)
> +		return -EINVAL;
> +
> +	btrfs_update_space_info_chunk_size(space_info, val);
> +
> +	return val;
> +}
> +
>  SPACE_INFO_ATTR(flags);
>  SPACE_INFO_ATTR(total_bytes);
>  SPACE_INFO_ATTR(bytes_used);
> @@ -718,6 +795,8 @@ SPACE_INFO_ATTR(bytes_readonly);
>  SPACE_INFO_ATTR(bytes_zone_unusable);
>  SPACE_INFO_ATTR(disk_used);
>  SPACE_INFO_ATTR(disk_total);
> +BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show,
> +	      btrfs_chunk_size_store);
>  
>  /*
>   * Allocation information about block group types.
> @@ -735,6 +814,7 @@ static struct attribute *space_info_attrs[] = {
>  	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
>  	BTRFS_ATTR_PTR(space_info, disk_used),
>  	BTRFS_ATTR_PTR(space_info, disk_total),
> +	BTRFS_ATTR_PTR(space_info, chunk_size),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(space_info);
> @@ -1099,6 +1179,20 @@ static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj)
>  	return to_fs_devs(kobj)->fs_info;
>  }
>  
> +/*
> + * Get btrfs sysfs kobject.
> + */
> +static inline struct kobject *get_btrfs_kobj(struct kobject *kobj)
> +{
> +	while (kobj) {
> +		if (kobj->ktype == &btrfs_ktype)
> +			return kobj;
> +		kobj = kobj->parent;
> +	}
> +
> +	return NULL;
> +}

There's the to_fs_info helper to get fs_info from any kobj, why is
get_btrfs_kobj needed to traverse back?
