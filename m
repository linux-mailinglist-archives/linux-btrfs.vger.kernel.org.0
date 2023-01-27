Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B54F67E6B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 14:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbjA0N3f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 08:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjA0N3e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 08:29:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0A2757A9
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:29:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 39F8321EF7;
        Fri, 27 Jan 2023 13:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674826169;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=16xSFMUdGNt7z3HOjoCJirfbGuQLNJAffgKwX6DrB8I=;
        b=0pCRyDvviix9IbIN1VppL+Cz5HN5khU5k9cOROB7KOL5v1Jj5Pk1jcIO0qPiDte7kxrBT4
        wcv2m6cBdEu7ClJj0T4oL1/j8oDMnD2uu4X2RoGntH8ZzdXmbHYZeMGuUaMKJyy8aqrWB0
        VQXJ4AwXy2dkO3aJXTixnGGnITY8PH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674826169;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=16xSFMUdGNt7z3HOjoCJirfbGuQLNJAffgKwX6DrB8I=;
        b=2YfjHCokYxi6Ie95i3SCIkC0DQKGwBzSyqZxcRUwSzLXVbhthvioSrWWuW0KAMgiNddR93
        N+vIpUPB/KU3deCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D9F51336F;
        Fri, 27 Jan 2023 13:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ElRnArnR02OoIwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 27 Jan 2023 13:29:29 +0000
Date:   Fri, 27 Jan 2023 14:23:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: add size class stats to sysfs
Message-ID: <20230127132345.GA11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1674679476.git.boris@bur.io>
 <3e95d7d8a42fa8969f415fc03ad999de3d29a196.1674679476.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e95d7d8a42fa8969f415fc03ad999de3d29a196.1674679476.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 25, 2023 at 12:50:33PM -0800, Boris Burkov wrote:
> Make it possible to see the distribution of size classes for block
> groups. Helpful for testing and debugging the allocator w.r.t. to size
> classes.

Please note the sysfs file path.

> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/sysfs.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 108aa3876186..e1ae4d2323d6 100644
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
> @@ -778,6 +779,42 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
>  	return len;
>  }
>  
> +static ssize_t btrfs_size_classes_show(struct kobject *kobj,
> +				       struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_space_info *sinfo = to_space_info(kobj);
> +	struct btrfs_block_group *bg;
> +	int none = 0;
> +	int small = 0;
> +	int medium = 0;
> +	int large = 0;

For simple counters please use unsigned types.

> +	int i;
> +
> +	down_read(&sinfo->groups_sem);

This is a big lock and reading the sysfs repeatedly could block space
reservations. I think RCU works for the block group list and the
size_class is a simple read so the synchronization can be lightweight.

> +	for (i = 0; i < BTRFS_NR_RAID_TYPES; ++i) {

	for (int = 0; ...)

> +		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
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
> +	up_read(&sinfo->groups_sem);
> +	return sysfs_emit(buf, "%d %d %d %d\n", none, small, medium, large);

This is lacks the types in the output, so this should be like

	"none %u\n"
	"small %u\n"
	...

For stats we can group the values in one file.

> +}
> +
>  #ifdef CONFIG_BTRFS_DEBUG
>  /*
>   * Request chunk allocation with current chunk size.
> @@ -835,6 +872,7 @@ SPACE_INFO_ATTR(bytes_zone_unusable);
>  SPACE_INFO_ATTR(disk_used);
>  SPACE_INFO_ATTR(disk_total);
>  BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show, btrfs_chunk_size_store);
> +BTRFS_ATTR(space_info, size_classes, btrfs_size_classes_show);
>  
>  static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
>  						     struct kobj_attribute *a,
> @@ -887,6 +925,7 @@ static struct attribute *space_info_attrs[] = {
>  	BTRFS_ATTR_PTR(space_info, disk_total),
>  	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
>  	BTRFS_ATTR_PTR(space_info, chunk_size),
> +	BTRFS_ATTR_PTR(space_info, size_classes),
>  #ifdef CONFIG_BTRFS_DEBUG
>  	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
>  #endif
> -- 
> 2.38.1
