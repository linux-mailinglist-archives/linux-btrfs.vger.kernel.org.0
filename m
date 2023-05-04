Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4086F687B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 11:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjEDJl1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 05:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjEDJl0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 05:41:26 -0400
Received: from out28-65.mail.aliyun.com (out28-65.mail.aliyun.com [115.124.28.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B13846BF;
        Thu,  4 May 2023 02:41:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04631398|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.181023-0.00372716-0.81525;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.SXnHuql_1683193277;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.SXnHuql_1683193277)
          by smtp.aliyun-inc.com;
          Thu, 04 May 2023 17:41:18 +0800
Date:   Thu, 04 May 2023 17:41:20 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fdmanana@kernel.org
Subject: Re: [PATCH] btrfs: fix backref walking not returning all inode refs
Cc:     linux-btrfs@vger.kernel.org, git@vladimir.panteleev.md,
        Filipe Manana <fdmanana@suse.com>, stable@vger.kernel.org
In-Reply-To: <77994dd9ede2084d45dd0a36938c67de70d8e859.1683123587.git.fdmanana@suse.com>
References: <77994dd9ede2084d45dd0a36938c67de70d8e859.1683123587.git.fdmanana@suse.com>
Message-Id: <20230504174118.4D5F.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> From: Filipe Manana <fdmanana@suse.com>
> 
> When using the logical to ino ioctl v2, if the flag to ignore offsets of
> file extent items (BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET) is given, the
> backref walking code ends up not returning references for all file offsets
> of an inode that point to the given logical bytenr. This happens since
> kernel 6.2, commit 6ce6ba534418 ("btrfs: use a single argument for extent
> offset in backref walking functions"), as it mistakenly skipped the search
> for file extent items in a leaf that point to the target extent if that
> flag is given. Instead it should only skip the filtering done by
> check_extent_in_eb() - that is, it should not avoid the calls to that
> function.
> 
> So fix this by always calling check_extent_in_eb() and have this function
> do the filtering only if an extent offset is given and the flag to ignore
> offsets is not set.
> Fixes: 6ce6ba534418 ("btrfs: use a single argument for extent offset in backref walking functions")
> Reported-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> Link: https://lore.kernel.org/linux-btrfs/CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com/
> Tested-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> CC: stable@vger.kernel.org # 6.2+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

fstests(btrfs/299) will fail with this patch.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/05/04

> ---
>  fs/btrfs/backref.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index e54f0884802a..8e61be3fe9a8 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -45,7 +45,9 @@ static int check_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
>  	int root_count;
>  	bool cached;
>  
> -	if (!btrfs_file_extent_compression(eb, fi) &&
> +	if (!ctx->ignore_extent_item_pos &&
> +	    ctx->extent_item_pos > 0 &&
> +	    !btrfs_file_extent_compression(eb, fi) &&
>  	    !btrfs_file_extent_encryption(eb, fi) &&
>  	    !btrfs_file_extent_other_encoding(eb, fi)) {
>  		u64 data_offset;
> @@ -552,13 +554,10 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
>  				count++;
>  			else
>  				goto next;
> -			if (!ctx->ignore_extent_item_pos) {
> -				ret = check_extent_in_eb(ctx, &key, eb, fi, &eie);
> -				if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP ||
> -				    ret < 0)
> -					break;
> -			}
> -			if (ret > 0)
> +			ret = check_extent_in_eb(ctx, &key, eb, fi, &eie);
> +			if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP || ret < 0)
> +				break;
> +			else if (ret > 0)
>  				goto next;
>  			ret = ulist_add_merge_ptr(parents, eb->start,
>  						  eie, (void **)&old, GFP_NOFS);
> -- 
> 2.35.1


