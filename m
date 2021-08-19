Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0503F1610
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 11:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhHSJVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 05:21:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60816 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHSJVw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 05:21:52 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4BA7E220B4;
        Thu, 19 Aug 2021 09:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629364875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7+WgtxbmEastYbOoF+mRVnkl7yHXN7yAungkM3QqTk=;
        b=dSgrbvnSRtHHh4Aru/tVo5j8nEskuGUVY0/A/1LC1T7+qLvr/Xm5GktHhulpGhwh/mldlo
        DFy9cWEebO6KKr41bXespqIJrtBHTompkPandQQhKkx9qE3iK0h98ZdzirRoCB50E15tD2
        pUPgW9+gVAx/uIVbBCrYEjNriPmb1NA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 062F21340C;
        Thu, 19 Aug 2021 09:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id mLaVOooiHmE9KQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 19 Aug 2021 09:21:14 +0000
Subject: Re: [PATCH] btrfs: sysfs: advertise zoned support among features
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com
References: <20210728165632.11813-1-dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <503a227c-3a73-7332-88b2-cba199fb71e5@suse.com>
Date:   Thu, 19 Aug 2021 12:21:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728165632.11813-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.07.21 г. 19:56, David Sterba wrote:
> We've hidden the zoned support in sysfs under debug config for the first
> releases but now the stability is reasonable, though not all features
> have been implemented.
> 
> As this depends on a config option, the per-filesystem feature won't
> exist as such filesystem can't be mounted. The static feature will print
> 1 when the support is built-in, 0 otherwise.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> The merge target is not set, depends if everybody thinks it's the time
> even though there are still known bugs. We're also waiting for
> util-linux support (blkid, wipefs), so that needs to be synced too.
> 
>  fs/btrfs/sysfs.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index bfe5e27617b0..7ad8f802ab88 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -263,8 +263,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
>  BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
>  BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>  BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
> -/* Remove once support for zoned allocation is feature complete */
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BLK_DEV_ZONED
>  BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>  #endif
>  #ifdef CONFIG_FS_VERITY
> @@ -285,7 +284,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>  	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
>  	BTRFS_FEAT_ATTR_PTR(free_space_tree),
>  	BTRFS_FEAT_ATTR_PTR(raid1c34),
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BLK_DEV_ZONED
>  	BTRFS_FEAT_ATTR_PTR(zoned),
>  #endif
>  #ifdef CONFIG_FS_VERITY
> @@ -384,12 +383,19 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
>  BTRFS_ATTR(static_feature, supported_sectorsizes,
>  	   supported_sectorsizes_show);
>  
> +static ssize_t zoned_show(struct kobject *kobj, struct kobj_attribute *a, char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", IS_ENABLED(CONFIG_BLK_DEV_ZONED));
> +}
> +BTRFS_ATTR(static_feature, zoned, zoned_show);
> +
>  static struct attribute *btrfs_supported_static_feature_attrs[] = {
>  	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
>  	BTRFS_ATTR_PTR(static_feature, supported_checksums),
>  	BTRFS_ATTR_PTR(static_feature, send_stream_version),
>  	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
>  	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
> +	BTRFS_ATTR_PTR(static_feature, zoned),
>  	NULL
>  };

Why isn't the above hunk predicated on CONFIG_BLK_DEV_ZONED the same as
the ATTR_INCOMPAT zoneed bit, but as explained in my earlier email one
of these should go and whichever remains must be predicated on
CONFIG_BLK_DEV_ZONED.
>  
> 
