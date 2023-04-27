Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160F46F0509
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbjD0Lbl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 07:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbjD0Lbk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 07:31:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE65EE4
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 04:31:38 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3HU-1q30LE0cRM-00FQHU; Thu, 27
 Apr 2023 13:31:32 +0200
Message-ID: <3578dba0-f7f3-ddb0-1e42-12bb193fa472@gmx.com>
Date:   Thu, 27 Apr 2023 19:31:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] btrfs: make btrfs_free_device() static
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1682528751.git.fdmanana@suse.com>
 <9182a6f15c0d7ea2395e9c9588eb8fa31d4525f9.1682528751.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9182a6f15c0d7ea2395e9c9588eb8fa31d4525f9.1682528751.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hQGascaguk3Com945dZCOJL5mzCT1+rFEYIoBrWi2DDrLzw3+48
 P1E0Hrnoa00DHDVH/eTvbmbp/F7OS5c0vyeC0aIaj6UYj2bYuGJXgymZyVRM+U/Y31Jvf0t
 vgpH4iG1a1fY9k0nnK8DrlA4mKqMPFQO/6aD6iznpin9Uq33jffdT+ETd669YTAlSJAcUNE
 Eyb1mHwJD7mWT92fLF5lw==
UI-OutboundReport: notjunk:1;M01:P0:+AoMi6dd3GU=;L+pbHjIu8fFxh6n6fi6MMV7ei/n
 U9ruQ780yni3LV9RnFjE/QEsbKmUiVraXC7Wmj6P3JKItdg5hlW0FNJ8NfyT6xV7QtSbbXGCe
 +YRnyl6J8RAFCnyd0EBxptqeLHZipXDqwAlWELqHMSMvvnlGYEWu5QQ9kQ0Akpt2ZX3XtjOqV
 XDLlHkMbcYpu6DgF9wcrWuUReuvpqdcl3srRusYiq5J92u/vLTjWeMhQ/3H+g1gKxx5M8Fs3i
 W5mHD7YZbZ8iwJv5mcQoHGL9n3S1NLnkFSWh3XL+Z8bs4NnaywVAfB9qr1131juYbNdfUyhvL
 IwhsTyf4JPiAQ9i+PkxK21MnmpFmRrM9jQIlbPbnJjoA0LyjXftXp0M6jUr6qvcVn7kKfgefe
 zCNDrIYyEv27NT29xl17dkXd6ybDVYj7fvbWJd4KQMQa6DqAyH4jm9axUKB5FeQ8emJaZb+x2
 IJw/ZX195apa+hNXD1MmUHc619vpnPn2mmdJg6Vlj8DJXcD7yjKqdt0CQRGfPcyasTxuI/EAW
 ptiPlaKjj7QaBFWxyMqJgCXkQDQqx6Kf9zUK3DKC1pUYliTSt93FC1qx1IsapmyxX7bu5DWeG
 yZHOEwqXQE3Lsgbr3wX1WSU5a40d+B5BXWuBL8Wl+ddMUTcm/QXQmCpbf6v8kIGVojSj3qVnm
 8jqjlserUnE9KMvv+X3Wq58iC9VmvQyqgGThYnuKaMEi8GTjl0LzLiaLoFhvPnBXUJUtymUUv
 IOaV5m0Z0zwnEHmlbI9w7iHA5j9sS1y4XRtYdgTG+9+lARyeXkU4n4FC0RjclkCs36Np/q+i/
 eIkBmd+APbc8W/NOnnAPUUy4UPgx57ESmoT9PwsR2dqe8s46k2gMM54TCdHx/vQX4feNvgmZO
 a2W1eSCnbJTJmyb5EOXBKxOG1uuVOqZeWBgoBOV0PdI2l84u2+FPWGbR1dN9AI2pWqQucT/Fa
 Cma12wWciO/R1VzaExRvS/W6z+M=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/27 01:13, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The function btrfs_free_device() is never used outside of volumes.c, so
> make it static and remove its prototype declaration at volumes.h.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 2 +-
>   fs/btrfs/volumes.h | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 841e799dece5..1a7620680f50 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -391,7 +391,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
>   	return fs_devs;
>   }
>   
> -void btrfs_free_device(struct btrfs_device *device)
> +static void btrfs_free_device(struct btrfs_device *device)
>   {
>   	WARN_ON(!list_empty(&device->post_commit_list));
>   	rcu_string_free(device->name);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index bf47a1a70813..5cbbee32748c 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -617,7 +617,6 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
>   					const u64 *devid, const u8 *uuid,
>   					const char *path);
>   void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
> -void btrfs_free_device(struct btrfs_device *device);
>   int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>   		    struct btrfs_dev_lookup_args *args,
>   		    struct block_device **bdev, fmode_t *mode);
