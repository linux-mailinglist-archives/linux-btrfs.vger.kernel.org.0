Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3662555769F
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 11:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiFWJbg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFWJbf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 05:31:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C394756D
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 02:31:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C753D21E30;
        Thu, 23 Jun 2022 09:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655976693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ych1CI+AOYh4vPZ65T1Xu2ZAY5n9mf1/WLKr0MWjEns=;
        b=M0ERlkX+DzGJP6CGlNA4kiQmcLVBgwAp8x/YSfwB/Q6MIsj5kDKlgzOb/YD4ywnQ5C/9Z4
        eos+baIoEzT1IWTyNFCTRkL3u+iZ3yCX9VA5SuNtH1jlQ451h1oXUQlvDeymgDXyDfZ+It
        BdsvKGDp5FYk2IUanopl0CQ+HNC2/64=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DD3F13461;
        Thu, 23 Jun 2022 09:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +QIAJPUytGJyKAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 23 Jun 2022 09:31:33 +0000
Message-ID: <eb705ec7-c82f-89c2-0ab6-20f3ebd86a33@suse.com>
Date:   Thu, 23 Jun 2022 12:31:33 +0300
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

One more nit, the following hunk should also be added (as per Qu's 
suggestion):

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0af4c03279df..7ae24acd899b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3795,7 +3795,7 @@ int __cold open_ctree(struct super_block *sb, 
struct btrfs_fs_devices *fs_device
         if (fs_info->uuid_root &&
             (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
              fs_info->generation != 
btrfs_super_uuid_tree_generation(disk_super))) {
-               btrfs_info(fs_info, "checking UUID tree");
+               btrfs_debug(fs_info, "checking UUID tree");
                 ret = btrfs_check_uuid_tree(fs_info);
                 if (ret) {
                         btrfs_warn(fs_info,

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
