Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC1695ABF
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 08:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBNHmm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 02:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBNHml (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 02:42:41 -0500
Received: from out28-85.mail.aliyun.com (out28-85.mail.aliyun.com [115.124.28.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A5919F2A
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 23:42:39 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.154639|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0177594-0.000677656-0.981563;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.RLh8uIC_1676360556;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.RLh8uIC_1676360556)
          by smtp.aliyun-inc.com;
          Tue, 14 Feb 2023 15:42:36 +0800
Date:   Tue, 14 Feb 2023 15:42:36 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs-progs: fsfeatures: remove the EXPERIMENTAL flags for block group tree runtime feature
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <11d75f3cce7b1f9f265e08580cca293984ad68d8.1676358661.git.wqu@suse.com>
References: <11d75f3cce7b1f9f265e08580cca293984ad68d8.1676358661.git.wqu@suse.com>
Message-Id: <20230214154235.9A8C.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> This block group tree support is already in the v6.1 kernel, and I know
> some adventurous users are already recompiling their progs to take
> advantage of the new feature.
> 
> Especially the block group tree feature would reduce the mount time from
> several minutes to several seconds for one of my friend.
> (Of course, he is doing an offline convert using btrfstune)

Should we add support to btrfstune in this patch too?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/02/14

> I see now reason to hide this feature behind experimental flags.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/fsfeatures.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 169e47e92582..ddd9c9419e84 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -175,7 +175,6 @@ static const struct btrfs_feature mkfs_features[] = {
>  		.desc		= "support zoned devices"
>  	},
>  #endif
> -#if EXPERIMENTAL
>  	{
>  		.name		= "block-group-tree",
>  		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
> @@ -185,7 +184,6 @@ static const struct btrfs_feature mkfs_features[] = {
>  		VERSION_NULL(default),
>  		.desc		= "block group tree to reduce mount time"
>  	},
> -#endif
>  #if EXPERIMENTAL
>  	{
>  		.name		= "extent-tree-v2",
> @@ -228,7 +226,6 @@ static const struct btrfs_feature runtime_features[] = {
>  		VERSION_TO_STRING2(default, 5,15),
>  		.desc		= "free space tree (space_cache=v2)"
>  	},
> -#if EXPERIMENTAL
>  	{
>  		.name		= "block-group-tree",
>  		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
> @@ -238,7 +235,6 @@ static const struct btrfs_feature runtime_features[] = {
>  		VERSION_NULL(default),
>  		.desc		= "block group tree to reduce mount time"
>  	},
> -#endif
>  	/* Keep this one last */
>  	{
>  		.name		= "list-all",
> -- 
> 2.39.1


