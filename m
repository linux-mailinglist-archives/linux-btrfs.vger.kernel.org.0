Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE24E92C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiC1KvP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 06:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiC1KvO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 06:51:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D5B41310
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 03:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 77958CE1126
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 10:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F30C004DD;
        Mon, 28 Mar 2022 10:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648464569;
        bh=N4nx8D4JYqFqWIpUVunD06qtzaSflD7nZRVIhkRl3ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=adNSCj131jBETMTwyyHoH7lTm9rsmSn6RysYi95G0T19NunJtpE/hIFhdyx4zaP3w
         jJCJk4AnFZ+HJZJ4Pq1gpa7kwlVNxLRkMezGrADdHq3bhPQ13gnIYGI2PBgQGTRqNV
         O5E99qLdMD0cW7s7/kmKQ502c1JQl7Vkmg0NYnpCrtHqboucktMWHL//wI/zCBWLsN
         P7h7NiXFnvQ7E0EFBFuNyE5IvzJzTa/074trHqO++dNwHPoB1Yapj6DLpE//z9+H4m
         xzkF3ydT3gOR5iP5xTDbGVFq1mEC1JUbXHVVJw3RI6y82F/IKqySDj/dJrAACq0yGD
         aAgE5cNtGBJqQ==
Date:   Mon, 28 Mar 2022 11:49:26 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: Re: [PATCH v3 3/3] btrfs: assert that relocation is protected with
 sb_start_write()
Message-ID: <YkGStsP38F7AdDSW@debian9.Home>
References: <cover.1648448228.git.naohiro.aota@wdc.com>
 <3c5403c65f3aacbba5f4e441b336233f2112f141.1648448228.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c5403c65f3aacbba5f4e441b336233f2112f141.1648448228.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 28, 2022 at 03:29:22PM +0900, Naohiro Aota wrote:
> btrfs_relocate_chunk() initiates new ordered extents.

Just say the relocation of data block groups creates ordered extents.
Saying btrfs_relocate_chunk() is a bit misleading, since the ordered
extents are created way deeper in the call chain.

> They can cause a
> hang when a process is trying to thaw the filesystem.
> 
> We should have called sb_start_write(), so the filesystem is not being
> frozen. Add an ASSERT to check it is protected.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/relocation.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index fdc2c4b411f0..705799b2b207 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3977,6 +3977,10 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>  	if (!bg)
>  		return -ENOENT;
>  
> +	/* Assert we called sb_start_write(), not to race with FS freezing */

Sentences should end with punctuation.
The comment is also a bit vague.

Just say that relocation of data block groups creates ordered extents, and
without sb_start_write() protection, we can deadlock if a fs freeze is started
before the relocation completes, because finishing an ordered extent requires
joining a transaction.

Otherwise it looks good, thanks.


> +	if (bg->flags & BTRFS_BLOCK_GROUP_DATA)
> +		ASSERT(sb_write_started(fs_info->sb));
> +
>  	if (btrfs_pinned_by_swapfile(fs_info, bg)) {
>  		btrfs_put_block_group(bg);
>  		return -ETXTBSY;
> -- 
> 2.35.1
> 
