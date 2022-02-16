Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4214D4B9352
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 22:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiBPVl4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 16:41:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiBPVlz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 16:41:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBE71ADAE
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 13:41:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D059F2112A;
        Wed, 16 Feb 2022 21:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645047700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=58f8n9MP0qpX/i7+ps2nI1Rnr9LNH3hwRU4OKYHZJ2E=;
        b=doJoX4bN9uy+YB8OjdqxdI5Va2hck0aDw823+XoK6OxwF2npl6jB+wkcouUILU/lLxf7LQ
        JXZEGfp2N+RLDm4SKAmqqvNrAxwj+WjzwK1YbCrqK5Du9rZHkQKHuF+kaG47Ey6M6VmfAl
        v5S6CMYVWxk0LUZwtangtTm5kdBTPLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645047700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=58f8n9MP0qpX/i7+ps2nI1Rnr9LNH3hwRU4OKYHZJ2E=;
        b=z65hhzWFW69u/L/YpscT9zE+8pcga3VyvOIJkhYjJJCzCq6dTExNTkx9m7kOqaYU9QszBw
        my1uiequVdw0sVCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C9737A3B87;
        Wed, 16 Feb 2022 21:41:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 106BDDA823; Wed, 16 Feb 2022 22:37:55 +0100 (CET)
Date:   Wed, 16 Feb 2022 22:37:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: remove the cross file system checks from remap
Message-ID: <20220216213755.GR12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <ef6f142a8be5bb8a3d2ac2643cc01870038f11b9.1645041975.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6f142a8be5bb8a3d2ac2643cc01870038f11b9.1645041975.git.josef@toxicpanda.com>
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

On Wed, Feb 16, 2022 at 03:06:26PM -0500, Josef Bacik wrote:
> This is handled in the generic VFS helper, we do not need to duplicate
> this inside of btrfs.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/reflink.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index a3930da4eb3f..4425030e09cb 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -771,10 +771,6 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  
>  		if (btrfs_root_readonly(root_out))
>  			return -EROFS;
> -
> -		if (file_in->f_path.mnt != file_out->f_path.mnt ||
> -		    inode_in->i_sb != inode_out->i_sb)
> -			return -EXDEV;

Should the super block check be at least an assert?
