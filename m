Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704314CAECA
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 20:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbiCBTfV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 14:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241112AbiCBTfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 14:35:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39BFC1C8B;
        Wed,  2 Mar 2022 11:34:36 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 76FE61F37E;
        Wed,  2 Mar 2022 19:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646249675;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBQVkO6FKMFBJ+tYsMWeTsWw0G/n9BU6P02UAvlYSYc=;
        b=ZgoeB+R44KO7nrWiiDJRIPHV/BVmVc0gNGBz8+40feaGZQZ1acMs4MWQLJ9jpIdWpDQNdM
        4qMFGW3WnLIubPun3AQD6cGkLM559Mp43SAu1w+sIs2+paPjrplOwCLOFWtLAqQd46cmnB
        NmD30JcgbEzxWR5ewwya6KOTCE44JtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646249675;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBQVkO6FKMFBJ+tYsMWeTsWw0G/n9BU6P02UAvlYSYc=;
        b=JWKNzmmD5vQhotMi/fHxuFcnThuKpF/J+bAr1Vq6D+cgOkg6jcPvSZ6YAMskFKv9IuMFkt
        t5fFwmtXag61qHAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 135AAA3B84;
        Wed,  2 Mar 2022 19:34:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08187DA80E; Wed,  2 Mar 2022 20:30:42 +0100 (CET)
Date:   Wed, 2 Mar 2022 20:30:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: add lockdep_assert_held to need_preemptive_reclaim
Message-ID: <20220302193042.GV12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Niels Dossche <dossche.niels@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220228225215.16552-1-dossche.niels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228225215.16552-1-dossche.niels@gmail.com>
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

On Mon, Feb 28, 2022 at 11:52:16PM +0100, Niels Dossche wrote:
> In a previous patch I extended the locking for member accesses of
> space_info.

A reference to another patch would be by a subject or a specific commit
id (not applicable in this case) or you can write it without any
reference if the change is standalone. The changelog should describe the
reason for the change, user visible effects, what can go wrong etc.

> It was then suggested to also add a lockdep assertion for
> space_info->lock to need_preemptive_reclaim.
> 
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> ---
>  fs/btrfs/space-info.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 294242c194d8..5464bd168d5b 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -734,9 +734,13 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
>  {
>  	u64 global_rsv_size = fs_info->global_block_rsv.reserved;
>  	u64 ordered, delalloc;
> -	u64 thresh = div_factor_fine(space_info->total_bytes, 90);
> +	u64 thresh;
>  	u64 used;
>  
> +	lockdep_assert_held(&space_info->lock);
> +
> +	thresh = div_factor_fine(space_info->total_bytes, 90);

I'm not sure this is necessary, as this is not locking where the
initialization would have to be inside. The lockdep assertion is just a
warning, so it does not matter where the intialization is done, I'd
prefer to keep it as is.
