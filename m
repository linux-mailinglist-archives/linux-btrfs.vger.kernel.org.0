Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20F69D448
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 20:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBTTqE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 14:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBTTqD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 14:46:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA22E047
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 11:46:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB33A338F8;
        Mon, 20 Feb 2023 19:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676922360;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pm1Rb7l/vAH/zxtgtBPt3btbc1HqOZg3IXNW5UmRKQc=;
        b=bX1xextjmkOPb7O3YAqbVsel7GBd9Gs7iO63zNn9ZrcQEh31QpcXYKZka1p0Rc7FFizvs9
        DBUmW652B5URYvYNDkcnJLrxjkcsLwwDkhvtjh/wGIZ7rZj0thafiqbk/DiogwnVDrjtzF
        DbjVas5Tp+6QHw972HOYe2088VYc1zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676922360;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pm1Rb7l/vAH/zxtgtBPt3btbc1HqOZg3IXNW5UmRKQc=;
        b=13IvH30GdVnA/nBEelWh2Q+XVvaPxhQ1TA9+LX5hffZmg9TtXUxcaYi+zH5jqZWPY42Pxk
        6Tsd41b/t5RQOhDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93180134BA;
        Mon, 20 Feb 2023 19:46:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qLs9IvjN82O2TAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Feb 2023 19:46:00 +0000
Date:   Mon, 20 Feb 2023 20:40:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] btrfs: add size class stats to sysfs
Message-ID: <20230220194005.GC10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676494550.git.boris@bur.io>
 <2fff5aa06edf1387677bdb1329359295c6d38506.1676494550.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fff5aa06edf1387677bdb1329359295c6d38506.1676494550.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 12:59:49PM -0800, Boris Burkov wrote:
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
>  fs/btrfs/sysfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 8c5efa5813b3..4926cab2f507 100644
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
> @@ -778,6 +779,47 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
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
> +	down_read(&sinfo->groups_sem);
> +	for (int i = 0; i < BTRFS_NR_RAID_TYPES; ++i) {

The lock in raid_bytes_show would be here, so with

		down_read(&sinfo->groups_sem);

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
and

		up_read(&sinfo->groups_sem);

the conditional check could be avoided completely

> +		if (rwsem_is_contended(&sinfo->groups_sem)) {
> +			up_read(&sinfo->groups_sem);
> +			cond_resched();
> +			down_read(&sinfo->groups_sem);
> +		}
> +	}
> +	up_read(&sinfo->groups_sem);
> +	return sysfs_emit(buf, "none %u\nsmall %u\nmedium %u\nlarge %u\n",
> +			  none, small, medium, large);
> +}
