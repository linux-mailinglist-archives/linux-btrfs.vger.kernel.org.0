Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2272669528C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 22:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBMVBY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 16:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBMVBX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 16:01:23 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E0665A1
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 13:01:19 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4PFxb21PDPz1s94m;
        Mon, 13 Feb 2023 22:01:18 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4PFxb20Y12z1qqlR;
        Mon, 13 Feb 2023 22:01:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id 8MnN-JW_uRqB; Mon, 13 Feb 2023 22:01:17 +0100 (CET)
X-Auth-Info: Occ07ParaKeaalaL/0UlRBo/JiOBU0OoPEdk9cRLiUKJzsTxiuhaHEi1oM4TfXrU
Received: from igel.home (aftr-82-135-86-52.dynamic.mnet-online.de [82.135.86.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 13 Feb 2023 22:01:17 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 220BC2C1B31; Mon, 13 Feb 2023 22:01:17 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: limit the mapped length to the original length
References: <99e2c01bb0366af9aec7522f7109c74b09c5509d.1676248644.git.wqu@suse.com>
X-Yow:  I'm GLAD I remembered to XEROX all my UNDERSHIRTS!!
Date:   Mon, 13 Feb 2023 22:01:17 +0100
In-Reply-To: <99e2c01bb0366af9aec7522f7109c74b09c5509d.1676248644.git.wqu@suse.com>
        (Qu Wenruo's message of "Mon, 13 Feb 2023 08:37:59 +0800")
Message-ID: <87pmadjn4y.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Feb 13 2023, Qu Wenruo wrote:

> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4aaaeab663f5..7d4095d9ca88 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -956,6 +956,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
>  	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
>  	struct cache_extent *ce;
>  	struct map_lookup *map;
> +	u64 orig_len = *length;
>  	u64 offset;
>  	u64 stripe_offset;
>  	u64 *raid_map = NULL;
> @@ -1047,6 +1048,7 @@ again:
>  	} else {
>  		*length = ce->size - offset;
>  	}
> +	*length = min_t(u64, *length, orig_len);
>  
>  	if (!multi_ret)
>  		goto out;

I can confirm that this fixes the issue.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
