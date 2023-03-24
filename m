Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65CE6C7596
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 03:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjCXCZW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 22:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCXCZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 22:25:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637A411666;
        Thu, 23 Mar 2023 19:25:19 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N79yG-1qXgLg40TM-017XMf; Fri, 24
 Mar 2023 03:25:01 +0100
Message-ID: <78422b96-52ed-b48a-27d0-1cfaa89a6608@gmx.com>
Date:   Fri, 24 Mar 2023 10:24:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: fix uninitialized variable warning
Content-Language: en-US
To:     Genjian <zhanggenjian123@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20230324020838.67149-1-zhanggenjian@kylinos.cn>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230324020838.67149-1-zhanggenjian@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QqK/Xz23cMvJ+r46o8s3zpfF8oN0QRaQPfEUON4j5o5FpMQJ08H
 gDLfgq/jEdn1ogi0lLgvLEgYLef2dF58o+nm6lCHqljD/3zZ+v+p3TWdGE6u4BX+/uXGHtx
 3TLp8nITRb87LXLdx9QDDcojGbEVQjigWcNbVSQ1AM/S1+bYAr4lEfFNvQ+eFHeX+hKlwj/
 BZqVegAu8uKzMRXr1fz0A==
UI-OutboundReport: notjunk:1;M01:P0:nbNjYr7ve7I=;rSjiTbALrvFjkrKvdg3v3wYPfu6
 Ha1wdw5YvydYdJksnE8HVxg5oZ1ixn3ZKA7R0QnsMIKEgG5RM8nZzgYUrzr6ozlc0pOXuSEfb
 2un7apN0t/xSyb+YSApMoRP82+N+/ZX2PU+dOIBRBLUw8eHkxxOyOapO0dSUHvqp3Y3xqDdWZ
 6JCEbQLwigoV6P3/KLqb58ob71jWKqfoPotfmQbLmgPuZeFzBA6PiH0A2SAFECPZ31jB1AmKK
 P9L+Hws6byuseelZ9ksHjphvnxHi5hxhawGM6imq9OY/jLgscEAF0k8L4VY3Qez+1T9EZux0N
 g8cEgMRQT6rcP9+S9zEBR3++6hu3buloIaKCNQWEKvK2Swd9uIXjSWCWVNt9nKxEFVkRhcdq6
 8LEFUe6jA18xoqmTUZGqLpGv+r/hvT0xas6zaXhuSbejrS/zhH/VzKSMYgMsZxbmElhKnVu10
 USQgL54d9+CfUWFluGLU89obqLahslYxdEIPWQDIKP3MDUCoFLXVuAKd6/o3rhBs1Ao0gpyL8
 OdV4Dlat4Y0XTTYyverNuFfxHzKwLPoN14KFYgp+hLX5Kaeyb9kfb3UpmSEXsLWh8HDYRq9tN
 7/lzPyspX6B8/a5oAFNhWL+dWfnq6EcXd1BGr8BLEsFAhAarWG2yTS06fJQzQSYj1n9FGgyQ/
 +lbZR2kgmO5zuf4Ezradt9qX5mnkgYHxwUu8KM5JKMwWGcxxoN8zqghbHlwD9wbDNYTPynfNE
 Bd7IxBS2yr5AOgd5m4fMeEGkuyArYNtwdThQ0TBpBErfHPL3E1kUoqu8BVlrXNQ3umb//W7bg
 afesJM1w6Dnhq/yc+UrVr0Yl6qL3J9AF8zoSU3hVxJD5W8VoH9ckKOuUF9wLWsP1Dch9moOuq
 Iqkdywa57oba/9xjcAQaj0MzEjPNXI2ay2gJkJ8r28A83PozU57QIu9oMV9nYzcRqBN17nVWu
 iph6FGE05rG3aBSeS7UHjmsqKr0=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/24 10:08, Genjian wrote:
> From: Genjian Zhang <zhanggenjian@kylinos.cn>
> 
> compiler warning:

Compiler version please.

> 
> ../fs/btrfs/volumes.c: In function ‘btrfs_init_new_device’:
> ../fs/btrfs/volumes.c:2703:3: error: ‘seed_devices’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   2703 |   btrfs_setup_sprout(fs_info, seed_devices);
>        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ../fs/btrfs/send.c: In function ‘get_cur_inode_state’:
> ../include/linux/compiler.h:70:32: error: ‘right_gen’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     70 |   (__if_trace.miss_hit[1]++,1) :  \
>        |                                ^
> ../fs/btrfs/send.c:1878:6: note: ‘right_gen’ was declared here
>   1878 |  u64 right_gen;
>        |      ^~~~~~~~~
> 
> Initialize the uninitialized variables.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> ---
>   fs/btrfs/send.c    | 2 +-
>   fs/btrfs/volumes.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index e5c963bb873d..af2e153543a5 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -1875,7 +1875,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
>   	int left_ret;
>   	int right_ret;
>   	u64 left_gen;
> -	u64 right_gen;
> +	u64 right_gen = 0;

IIRC this is not my first time explaining why this is a false alert.

Thus please report your compiler version first.

Thanks,
Qu
>   	struct btrfs_inode_info info;
>   
>   	ret = get_inode_info(sctx->send_root, ino, &info);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7823168c08a6..7163c98e47be 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2609,7 +2609,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	struct block_device *bdev;
>   	struct super_block *sb = fs_info->sb;
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> -	struct btrfs_fs_devices *seed_devices;
> +	struct btrfs_fs_devices *seed_devices = NULL;
>   	u64 orig_super_total_bytes;
>   	u64 orig_super_num_devices;
>   	int ret = 0;
