Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B5B68DD7B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 16:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjBGP5u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 10:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjBGP5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 10:57:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC09083ED
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 07:57:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F29637536;
        Tue,  7 Feb 2023 15:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675785410;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YPUGJNZmuPeWIBT095lRCRV1spME5GjZt1Rjr+nt3t8=;
        b=sNIZYa10NYPsqEsbjbbHubUJINuTwB+SMzAYiuY1xJ8ELAK47WL3WWOk+f/f2U7dPEy4rI
        +Iala7OdQEOLMinZydFyQCL/MNNO7gUbTwBxxPE7oGyBuaXDsrLnzlKS2cvnfr5pBqfNje
        +UN2/hUFWkJWKNN3tnhLPyazdHTgu8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675785410;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YPUGJNZmuPeWIBT095lRCRV1spME5GjZt1Rjr+nt3t8=;
        b=TcMr9r8NaMJlY30DjgTF9U8eYl29/Tu3tHoWSXq6We/UxoTEgJSyOjUGVwCQ0ZAHiv8cqu
        ewBqf4Ay+dHESzDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 735F2139ED;
        Tue,  7 Feb 2023 15:56:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o7VDG8J04mOgNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 07 Feb 2023 15:56:50 +0000
Date:   Tue, 7 Feb 2023 16:51:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: add size class stats to sysfs
Message-ID: <20230207155101.GH28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5c4fcf99c1486e6c2c2c45f11ade73d40f153021.1674856476.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c4fcf99c1486e6c2c2c45f11ade73d40f153021.1674856476.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 27, 2023 at 01:56:50PM -0800, Boris Burkov wrote:
> Make it possible to see the distribution of size classes for block
> groups. Helpful for testing and debugging the allocator w.r.t. to size
> classes.
> 
> The new stats can be found at the path:
> /sys/fs/btrfs/<uid>/allocation/<bg-type>/size_class
> but they will only be non-zero for bg-type = data.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> - add sysfs path to commit message
> - unsigned counter types
> - labeled stat-per-line output format
> 
>  fs/btrfs/sysfs.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 108aa3876186..639f3842f99d 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -9,6 +9,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/completion.h>
>  #include <linux/bug.h>
> +#include <linux/list.h>
>  #include <crypto/hash.h>
>  #include "messages.h"
>  #include "ctree.h"
> @@ -778,6 +779,40 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
>  	return len;
>  }
>  
> +static ssize_t btrfs_size_classes_show(struct kobject *kobj,
> +				       struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_space_info *sinfo = to_space_info(kobj);
> +	struct btrfs_block_group *bg;
> +	u32 none = 0;
> +	u32 small = 0;
> +	u32 medium = 0;
> +	u32 large = 0;
> +
> +	for (int i = 0; i < BTRFS_NR_RAID_TYPES; ++i) {
> +		list_for_each_entry(bg, &sinfo->block_groups[i], list) {

Some locking is needed, you can eventually lock only iteration of one
sinfo and not the whole for cycle. Otherwise looks good.

> +			if (!btrfs_block_group_should_use_size_class(bg))
> +				continue;
> +			switch (bg->size_class) {
> +			case BTRFS_BG_SZ_NONE:
> +				none++;
> +				break;
> +			case BTRFS_BG_SZ_SMALL:
> +				small++;
> +				break;
> +			case BTRFS_BG_SZ_MEDIUM:
> +				medium++;
> +				break;
> +			case BTRFS_BG_SZ_LARGE:
> +				large++;
> +				break;
> +			}
> +		}
> +	}
> +	return sysfs_emit(buf, "none %u\nsmall %u\nmedium %u\nlarge %u\n",
> +			  none, small, medium, large);
> +}
> +
>  #ifdef CONFIG_BTRFS_DEBUG
>  /*
>   * Request chunk allocation with current chunk size.
> @@ -835,6 +870,7 @@ SPACE_INFO_ATTR(bytes_zone_unusable);
>  SPACE_INFO_ATTR(disk_used);
>  SPACE_INFO_ATTR(disk_total);
>  BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show, btrfs_chunk_size_store);
> +BTRFS_ATTR(space_info, size_classes, btrfs_size_classes_show);
>  
>  static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
>  						     struct kobj_attribute *a,
> @@ -887,6 +923,7 @@ static struct attribute *space_info_attrs[] = {
>  	BTRFS_ATTR_PTR(space_info, disk_total),
>  	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
>  	BTRFS_ATTR_PTR(space_info, chunk_size),
> +	BTRFS_ATTR_PTR(space_info, size_classes),
>  #ifdef CONFIG_BTRFS_DEBUG
>  	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
>  #endif
> -- 
> 2.38.1
