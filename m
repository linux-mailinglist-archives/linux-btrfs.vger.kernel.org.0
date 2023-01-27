Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D20067E6C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 14:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjA0Nch (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 08:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbjA0Nce (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 08:32:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1E88243E
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:32:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 55D5221F0E;
        Fri, 27 Jan 2023 13:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674826349;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dF62+hL4WCxRjxoQCSfF/J/jkTbINOUWeS2V7L3mpD4=;
        b=BbucDDK5qRTz/YOBHpxrI41OKtLcuf7wefUeS0I0+7aFewgjWrVC3aqbgWhFf7KzxCaYON
        bu3u6s+jCxTduBbnEv7t906IO9LbcY2vE0/Sfealm3vL5ouG68rhASlkgyQP59OXMcxN7c
        HNCnpFBzaxTf8JQi/dH3LQQTlqK3q1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674826349;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dF62+hL4WCxRjxoQCSfF/J/jkTbINOUWeS2V7L3mpD4=;
        b=DrTORnS26zPR2ybKcyRfe9WZCOs9LhVqBxFvlKQxnQ+TaL8UsQp71oAxrOIfEzqpAz0O52
        Ap8II6bC9tv5kjDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EB51138E3;
        Fri, 27 Jan 2023 13:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1B+OCm3S02NkJQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 27 Jan 2023 13:32:29 +0000
Date:   Fri, 27 Jan 2023 14:26:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: fix size class loading logic
Message-ID: <20230127132646.GB11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1c4c25be5fa66e14ae772f134045f64cf1fb74a6.1674686119.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c4c25be5fa66e14ae772f134045f64cf1fb74a6.1674686119.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 25, 2023 at 02:37:41PM -0800, Boris Burkov wrote:
> This is an incremental patch fixing bugs in:
> btrfs: load block group size class when caching

Folded to the patch, thanks.

> The commit message should be:
> btrfs: load block group size class when caching
> 
> Since the size class is an artifact of an arbitrary anti fragmentation
> strategy, it doesn't really make sense to persist it. Furthermore, most
> of the size class logic assumes fresh block groups. That is of course
> not a reasonable assumption -- we will be upgrading kernels with
> existing filesystems whose block groups are not classified.
> 
> To work around those issues, implement logic to compute the size class
> of the block groups as we cache them in. To perfectly assess the state
> of a block group, we would have to read the entire extent tree (since
> the free space cache mashes together contiguous extent items) which
> would be prohibitively expensive for larger file systems with more
> extents.
> 
> We can do it relatively cheaply by implementing a simple heuristic of
> sampling a handful of extents and picking the smallest one we see. In
> the happy case where the block group was classified, we will only see
> extents of the correct size. In the unhappy case, we will hopefully find
> one of the smaller extents, but there is no perfect answer anyway.
> Autorelocation will eventually churn up the block group if there is
> significant freeing anyway.
> 
> There was no regression in mount performance at end state of the fsperf
> test suite, and the delay until the block group is marked cached is
> minimized by the constant number of extent samples.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> v2: just commit message stuff to make it a nicer incremental fixup
> patch. Also, drop the sysfs patch since it isn't a fixup.
> 
>  fs/btrfs/block-group.c | 56 ++++++++++++++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 73e1270b3904..45ccb25c5b1f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -638,7 +656,8 @@ static int sample_block_group_extent_item(struct btrfs_block_group *block_group,
>   *
>   * Returns: 0 on success, negative error code on error.
>   */
> -static int load_block_group_size_class(struct btrfs_block_group *block_group)
> +static int load_block_group_size_class(struct btrfs_caching_control *caching_ctl,
> +				       struct btrfs_block_group *block_group)
>  {
>  	struct btrfs_key key;
>  	int i;
> @@ -646,11 +665,11 @@ static int load_block_group_size_class(struct btrfs_block_group *block_group)
>  	enum btrfs_block_group_size_class size_class = BTRFS_BG_SZ_NONE;
>  	int ret;
>  
> -	if (btrfs_block_group_should_use_size_class(block_group))
> +	if (!btrfs_block_group_should_use_size_class(block_group))

Though this change was in the "btrfs: don't use size classes for zoned
file systems".

>  		return 0;
>  
>  	for (i = 0; i < 5; ++i) {
> -		ret = sample_block_group_extent_item(block_group, i, 5, &key);
> +		ret = sample_block_group_extent_item(caching_ctl, block_group, i, 5, &key);
>  		if (ret < 0)
>  			goto out;
>  		if (ret > 0)
