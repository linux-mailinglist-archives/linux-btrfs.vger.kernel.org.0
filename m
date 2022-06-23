Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EA3557698
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 11:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiFWJ3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 05:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiFWJ3o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 05:29:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE494755A
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 02:29:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 22B6521E39;
        Thu, 23 Jun 2022 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655976582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIN1OYihQQPcOiX/X9uQbaRvm92o3+BHB94FQtKublA=;
        b=Cp9/ts2l4u3z/2qSEeKY0S9aJG+HKvTJTaeyj2OWEXausEM/nfBBU6tRW8q6C5thd/Sc0v
        RCdK/RD0i0HhMo48WFdALM/XK0ki8Dc6fEhFVGYO3VdnJWQcpRm+3vw/Q0q4kNxAHPG8cm
        qVhxS4ihBHrkmNXSfI8KgNUsLiOeRrI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE0B313461;
        Thu, 23 Jun 2022 09:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j1GDN4UytGJGJwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 23 Jun 2022 09:29:41 +0000
Message-ID: <fb4e5491-69d4-828b-2f86-8f2a8cc0c1bb@suse.com>
Date:   Thu, 23 Jun 2022 12:29:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: lower some mount messages level to debug
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220622192803.16233-1-dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220622192803.16233-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.06.22 г. 22:28 ч., David Sterba wrote:
> Change message level from info to debug for the following messages,
> there's no reason to print them for all users as that won't help
> debugging if nearly all filesystems use that.
> 
> - flagging fs with big metadata feature
> 
> Added in commit 727011e07cbd ("Btrfs: allow metadata blocks larger than
> the page size") in 2010 and it's been default for mkfs since 3.12
> (2013).
> 
> - has skinny extents
> 
> Added in 3173a18f7055 ("Btrfs: add a incompatible format change for
> smaller metadata extent refs") in 2013 and default for mkfs since 3.18
> (2014).
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>


> ---
>   fs/btrfs/disk-io.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8592eaf6de53..3d435560980c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3472,8 +3472,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   	 */
>   	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE) {
>   		if (!(features & BTRFS_FEATURE_INCOMPAT_BIG_METADATA))
> -			btrfs_info(fs_info,
> -				"flagging fs with big metadata feature");
> +			btrfs_debug(fs_info, "flagging fs with big metadata feature");
>   		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
>   	}
>   
> @@ -3514,7 +3513,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   		features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
>   
>   	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
> -		btrfs_info(fs_info, "has skinny extents");
> +		btrfs_debug(fs_info, "has skinny extents");
>   
>   	/*
>   	 * mixed block groups end up with duplicate but slightly offset
