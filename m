Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902DB4E6899
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 19:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352594AbiCXSZK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 14:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiCXSZJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 14:25:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97018CCD9;
        Thu, 24 Mar 2022 11:23:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8A1F5210F4;
        Thu, 24 Mar 2022 18:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648146215;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5huxXi8OoqhvQXUgQMDKb0oQVXSd7yjT4jvQnm+x+dc=;
        b=swlicSYoQn/QprqtZsdfOi0wCfolM2xCkqtGW9U74hBplWw/DjNlqn3T8UZyTSiMhT6pOT
        kyMMM2yO0I//xPovecUAU+K7S+0eY7g3RokB95WFMHi+Le/nJJPFp6vFbD3vsihsGGP9Oh
        PjD+e+nvU+qqGVx3bRuWG3zkxXHdz+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648146215;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5huxXi8OoqhvQXUgQMDKb0oQVXSd7yjT4jvQnm+x+dc=;
        b=NVCjOa/yt5/RjhQD9RzlqNmSMzplxexATDB9qqHvJV3NHrNju+OeN9oHmKCgP5C7hqD+wz
        PZ8TP17mGBtNlnBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7DDCAA3B87;
        Thu, 24 Mar 2022 18:23:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AAED9DA7F3; Thu, 24 Mar 2022 19:19:40 +0100 (CET)
Date:   Thu, 24 Mar 2022 19:19:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: fix possible use-after-free bug in error
 handling code of btrfs_get_root_ref()
Message-ID: <20220324181940.GK2237@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jia-Ju Bai <baijiaju1990@gmail.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220324134454.15192-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324134454.15192-1-baijiaju1990@gmail.com>
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

On Thu, Mar 24, 2022 at 06:44:54AM -0700, Jia-Ju Bai wrote:
> In btrfs_get_root_ref(), when btrfs_insert_fs_root() fails,
> btrfs_put_root() will be called to possibly free the memory area of
> the variable root. However, this variable is then used again in error
> handling code after "goto fail", when ret is not -EEXIST.
> 
> To fix this possible bug, btrfs_put_root() is only called when ret is 
> -EEXIST for "goto again".
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  fs/btrfs/disk-io.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b30309f187cf..126f244cdf88 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1850,9 +1850,10 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
>  
>  	ret = btrfs_insert_fs_root(fs_info, root);
>  	if (ret) {
> -		btrfs_put_root(root);
> -		if (ret == -EEXIST)
> +		if (ret == -EEXIST) {
> +			btrfs_put_root(root);

I think this fix is correct, though it's not that clear. If you look how
the code changed, there was the unconditional put and then followed by a
free:

8c38938c7bb0 ("btrfs: move the root freeing stuff into btrfs_put_root")

Here it's putting twice where one will be the final free.

And then the whole refcounting gets updated in

4785e24fa5d2 ("btrfs: don't take an extra root ref at allocation time")

which could be removing the wrong put, I'm not yet sure.
