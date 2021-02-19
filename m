Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8975A31F9E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 14:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhBSN0e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 08:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBSN0d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 08:26:33 -0500
X-Greylist: delayed 367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Feb 2021 05:25:53 PST
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A832CC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 05:25:53 -0800 (PST)
Received: from tux.applied-asynchrony.com (p5ddd734e.dip0.t-ipconnect.de [93.221.115.78])
        by mail.itouring.de (Postfix) with ESMTPSA id 3B1973E7F;
        Fri, 19 Feb 2021 14:19:01 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id C5404F0161B;
        Fri, 19 Feb 2021 14:18:59 +0100 (CET)
Subject: Re: error in backport of 'btrfs: fix possible free space tree
 corruption with online conversion'
To:     Wang Yugui <wangyugui@e16-tech.com>, josef@toxicpanda.com
Cc:     linux-btrfs@vger.kernel.org
References: <20210219111741.95DD.409509F4@e16-tech.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <d07905be-f714-3cbd-01c7-d348ea13c07e@applied-asynchrony.com>
Date:   Fri, 19 Feb 2021 14:18:59 +0100
MIME-Version: 1.0
In-Reply-To: <20210219111741.95DD.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-02-19 04:17, Wang Yugui wrote:
> Hi, Josef Bacik
> 
> We noticed an error in 5.10.x backport of 'btrfs: fix possible free
> space tree corruption with online conversion'
> 
> It is wrong in 5.10.13, but right in 5.11.
> 
> 5.10.13
> @@ -146,6 +146,9 @@ enum {
>   	BTRFS_FS_STATE_DEV_REPLACING,
>   	/* The btrfs_fs_info created for self-tests */
>   	BTRFS_FS_STATE_DUMMY_FS_INFO,
> +
> +	/* Indicate that we can't trust the free space tree for caching yet */
> +	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
>   };
> 
> the usage sample of this enum:
> set_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
> 
> 
> 5.11
> enum{
> ..
>      /* Indicate that the discard workqueue can service discards. */
>      BTRFS_FS_DISCARD_RUNNING,
> 
>      /* Indicate that we need to cleanup space cache v1 */
>      BTRFS_FS_CLEANUP_SPACE_CACHE_V1,
> 
>      /* Indicate that we can't trust the free space tree for caching yet */
>      BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
> };
> 
> the usage sample of this enum:
> set_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
> 

Out of curiosity I decided to check how this happened, but don't see it.
Here is the commit that went into 5.10.13 and it looks correct to me:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=2175bf57dc9522c58d93dcd474758434a3f05c57

The patch that went into 5.10 looks identical to the original commit in 5.11.
What tree are you looking at?

-h
