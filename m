Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7698583308
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 21:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiG0TJX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiG0TIt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 15:08:49 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754DA474CB
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 11:48:02 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id E35E35D7;
        Wed, 27 Jul 2022 18:47:59 +0000 (UTC)
Date:   Wed, 27 Jul 2022 23:47:58 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: auto enable discard=async when possible
Message-ID: <20220727234758.33232508@nvm>
In-Reply-To: <20220727150158.GT13489@suse.cz>
References: <20220727150158.GT13489@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 27 Jul 2022 17:01:58 +0200
David Sterba <dsterba@suse.com> wrote:

> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1503,6 +1503,7 @@ enum {
>  	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 28),
>  	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 29),
>  	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
> +	BTRFS_MOUNT_NODISCARD			= (1UL << 31),
>  };
>  
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3fac429cf8a4..8f8e33219d4d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3767,6 +3767,20 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
>  	}
>  
> +	/*
> +	 * For devices supporting discard turn on discard=async automatically,
> +	 * unless it's already set or disabled. This could be turned off by
> +	 * nodiscard for the same mount.
> +	 */
> +	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
> +	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
> +	      btrfs_test_opt(fs_info, NODISCARD)) &&
> +	    fs_info->fs_devices->discardable) {
> +		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
> +				"auto enabling discard=async");
> +	      btrfs_clear_opt(fs_info->mount_opt, NODISCARD);

Spaces are used in the above line instead of a 2nd TAB.

Also I am probably clueless, but it seems the condition just checked that
NODISCARD was not set, so what is the purpose of also clearing it?

Thanks

-- 
With respect,
Roman
