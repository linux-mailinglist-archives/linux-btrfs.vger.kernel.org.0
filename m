Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22A54BB9D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 14:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiBRNKf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 08:10:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiBRNKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 08:10:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE163253BDE;
        Fri, 18 Feb 2022 05:10:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7BBD11F37F;
        Fri, 18 Feb 2022 13:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645189814;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1JlFxuUX2jYEpN7LRjICgbNOHYKr0FMLJ/vNPXX2b/U=;
        b=z4fVxXPuw0f6uc2eukxJR1Wew1zDHTNY7X7eEEgRuhUWUxeDZQ98fZptur359cHZrl6dl4
        d8ZpONw5LmnWScpGPPyEgkBsnMtzhjdrnH3b87+E3cxFTRAQ+byIyP3NOu9EjaA+Ito5rY
        cKKT2ZL+S30ol5XDgeUxkv8BETyBbR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645189814;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1JlFxuUX2jYEpN7LRjICgbNOHYKr0FMLJ/vNPXX2b/U=;
        b=cnjSx/5Gzt/joRIUQbkLAXJ2pgOS+AwnCVFi+95JtZugVJgSwsvNsXAYiyOm4cOkiubrIC
        9448VWjM0cAyZPCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6896EA3B83;
        Fri, 18 Feb 2022 13:10:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CD392DA829; Fri, 18 Feb 2022 14:06:28 +0100 (CET)
Date:   Fri, 18 Feb 2022 14:06:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] btrfs: Fix non-kernel-doc comment
Message-ID: <20220218130628.GS12643@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220218101345.125518-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218101345.125518-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 06:13:45PM +0800, Jiapeng Chong wrote:
> Fixes the following W=1 kernel build warning:
> 
> fs/btrfs/ioctl.c:1789: warning: This comment starts with '/**', but
> isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Entry point to file defragmentation.
> 
> fs/btrfs/extent_map.c:390: warning: This comment starts with '/**', but
> isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Add new extent map to the extent tree.
> 
> fs/btrfs/block-group.c:1743: warning: This comment starts with '/**',
> but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
>  * Map a physical disk address to a list of logical addresses.
> 
> fs/btrfs/extent_io.c:4923: warning: This comment starts with '/**', but
> isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Walk the list of dirty pages of the given address space and write all
>  * of them.
> 
> fs/btrfs/file-item.c:625: warning: This comment starts with '/**', but
> isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Calculate checksums of the data contained inside a bio.
> 
> fs/btrfs/inode.c:3430: warning: This comment starts with '/**', but
> isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Wait for flushing all delayed iputs
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/btrfs/block-group.c | 2 +-
>  fs/btrfs/extent_io.c   | 2 +-
>  fs/btrfs/extent_map.c  | 2 +-
>  fs/btrfs/file-item.c   | 2 +-
>  fs/btrfs/inode.c       | 2 +-
>  fs/btrfs/ioctl.c       | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c22d287e020b..884002e510ec 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1739,7 +1739,7 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
>  	write_sequnlock(&fs_info->profiles_lock);
>  }
>  
> -/**
> +/*
>   * Map a physical disk address to a list of logical addresses
>   *
>   * @fs_info:       the filesystem

We'd actually like the kdoc script to check the argument list.
