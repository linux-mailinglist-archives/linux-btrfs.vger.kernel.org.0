Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8506B7B380A
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjI2QhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjI2QhT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 12:37:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC047BE
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Sep 2023 09:37:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 624FF1F390;
        Fri, 29 Sep 2023 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696005435;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y5Vm5mo8x1Oycw4/P4lGYt4V4T8mcPfyFq+vYE3ml64=;
        b=JXNCirhhiuIXvITqVvv4UYwE/1k3dasrqymWnzo/rMnFFqKbDvKgUgPML4qyDJQn6YdOz0
        3IUtn4UwIBNKE5ADSVTY/+GtRST3aj8EFumQ1YhRTYeROnk8JO1PCP6GAgX0Jmi/ZlChQb
        pdMiIfwC3PN2t1wg+nFYtXjmcUELzCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696005435;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y5Vm5mo8x1Oycw4/P4lGYt4V4T8mcPfyFq+vYE3ml64=;
        b=GrAIKFsmZusQBdtmkd6T7OwGeiS/iWBcMPfGGmB6zgXEBNNd3DN36anpfNeDe+BJlcgdbw
        9qaHWZf422gaKABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 258DF1390A;
        Fri, 29 Sep 2023 16:37:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NVBgCDv9FmWXVwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 29 Sep 2023 16:37:15 +0000
Date:   Fri, 29 Sep 2023 18:30:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/3] btrfs: increase ->free_chunk_space in
 btrfs_grow_device
Message-ID: <20230929163035.GH13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695836511.git.josef@toxicpanda.com>
 <c94cdbf63118d14cfc0f95827cd67d8be1bae068.1695836511.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c94cdbf63118d14cfc0f95827cd67d8be1bae068.1695836511.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 27, 2023 at 01:47:00PM -0400, Josef Bacik wrote:
> My overcommit patch exposed a bug with btrfs/177.  The problem here is

Which patch is that?

> that when we grow the device we're not adding to ->free_chunk_space, so
> subsequent allocations can cause ->free_chunk_space to wrap, which
> causes problems in can_overcommit because we add this to ->total_bytes,
> which causes the counter to wrap and gives us an unexpected ENOSPC.
> 
> Fix this by properly updating ->free_chunk_space with the new available
> space in btrfs_grow_device.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/volumes.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 907ea775f4e4..1aedd15d1db7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2932,6 +2932,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
>  	btrfs_set_super_total_bytes(super_copy,
>  			round_down(old_total + diff, fs_info->sectorsize));
>  	device->fs_devices->total_rw_bytes += diff;
> +	atomic64_add(diff, &fs_info->free_chunk_space);
>  
>  	btrfs_device_set_total_bytes(device, new_size);
>  	btrfs_device_set_disk_total_bytes(device, new_size);
> -- 
> 2.41.0
