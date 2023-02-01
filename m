Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA43685D66
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Feb 2023 03:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjBACid (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Jan 2023 21:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBACic (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Jan 2023 21:38:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8AE3D920;
        Tue, 31 Jan 2023 18:38:29 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPGVx-1ozbP62fFd-00Pcr0; Wed, 01
 Feb 2023 03:38:22 +0100
Message-ID: <cfdd4a6d-2856-e534-76e3-7c1fdf386ea2@gmx.com>
Date:   Wed, 1 Feb 2023 10:38:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202302011022199155711@zte.com.cn>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] Btrfs: fix compile error about uninitialized variable
In-Reply-To: <202302011022199155711@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QGL2j2hTzpM8LWBS3SIUrUZcZBCvcWDrw04pO9zBLaQr/DLratY
 Xqaufe77Y7agk8ImP8ddruZQx3OwA8YZFtHXEg28e4lsbDkHtGmQlUrpbk7eN7ZpxJrHJry
 061vSRSr63bA1kywboV+1MDgUfOj+a77tXxt2+AAzXuVRrvXtqB5Og2oHWRZHOejC1WSrgm
 BsL2yf382Mshuywoh5FVQ==
UI-OutboundReport: notjunk:1;M01:P0:xHqkUquyQkA=;7J5pwOH4q7jy6oEHgbtlGlwTQw0
 xwA6f2+jZGEhIGRx8VhqC94O3kig7XfZdyQPw3oWOXt3Zv9lCNEfc25J1hTBUbD7Pj6MyG2Mb
 o3+KJ13eJT5fII0lcwNO8Ov6NS1F7CaTfUcUsc6zyZrE/ud2sDk3OjZbDkigCW9LHqeICNlkJ
 Lr+gjD99JgpI26oLOV/8PeM4O/g4D2zCaVIIH2wOzH3GV6YvEGkpOu9ymZFPwWj2BeLj7zU9v
 o7+pCo5p1THJm8hbPTArCW98QJv/yNBCxmGZy/3+Zy+lfRZzz7oTN16tTn70L5DInrl9cDENc
 0xot4sIuO/6r60lK+7f9nEQx8P4ql4me3EB6gmzr46/kdMHTupSv1duKOb7IAb4boemvE5HZV
 O4kJ1ykBYpjvYCXDH8DB0NtulM03tJkwOr3NUAE1+KSqyxtN8PS2cmjUzXRZkA0e0Qx/T4Ojq
 Zcwqz4aRE2CD028C1EcVmG1T4bmK72GV2noqKjjVizY9nwCvz4T+bbaf3XlaTTGJMvZfXhPhS
 ymeUg/4ZWy4KjYbOkv1O2//7nx4anyGg04svJoPTJpFmbK0Qi+/MaQysO/khnkV/ThtWGfZB/
 loUc6KUVrToPknohNxJ1cR+fQVqWjnno2qsU61/Il4lf1YmxXOO70M9adDohQNU4RIgfDFGam
 1HZYrNLOejIhpUglB0iR2aM701UzdNnpWGS7I73g5ZIC6LPgLjtYaloE64u//yOSvvlt6u61X
 FysfmCUlFG2Eev/16R5f+LGs8AN/VOmDKtFl2XSsL4wvUXQT/BMP3JGG6idPOBGcL7TulOnYy
 dDW/LLivabSQxowtuw/LiF1E34foTVCs5ikkJKtf8WqqALTsI1MHcuPr1cPFgnQPpmWIKnb5u
 OWPM0E62xIbta4nRFGq8NHMVXR4OZKMW9mww7GPGJAUPsf61fs24iclSg8VQcaH59GMOdKrJi
 vI4Qr56ZkyMKbqospzUIOmzOAIQ=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/1 10:22, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> fs/btrfs/tree-log.c:6166:6: note: 'last_range_start' was declared here
> fs/btrfs/volumes.c:2598:27: note: 'seed_devices' was declared here
> fs/btrfs/send.c:1909:13: error: 'right_gen' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Have you really dig into the code?

When @right_gen is not initialized, we have @right_ret assigned to -ENOENT.

Thus all later code checking @right_gen would not be executed, and this 
is a false alert.

You should explain this is a false alert first.

Secondly it's easy to just stick a "= 0" to whatever compiler complains 
in this case, but since it's a false alert, you really need to explain 
your compiler version to see if it's really better to fix in the code 
other than your compiler.

> 
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   fs/btrfs/send.c     | 2 +-
>   fs/btrfs/tree-log.c | 2 +-
>   fs/btrfs/volumes.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index c3146ce84156..3c9f2d30065d 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -1875,7 +1875,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
>   	int left_ret;
>   	int right_ret;
>   	u64 left_gen;
> -	u64 right_gen;
> +	u64 right_gen = 0;
>   	struct btrfs_inode_info info;
> 
>   	ret = get_inode_info(sctx->send_root, ino, &info);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 200cea6e49e5..b91fa398b814 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6163,7 +6163,7 @@ static int log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
>   {
>   	struct btrfs_root *log = inode->root->log_root;
>   	const struct btrfs_delayed_item *curr;
> -	u64 last_range_start;
> +	u64 last_range_start = 0;
>   	u64 last_range_end = 0;
>   	struct btrfs_key key;
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 83cb2db43779..1298569cf8b5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2595,7 +2595,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	struct block_device *bdev;
>   	struct super_block *sb = fs_info->sb;
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> -	struct btrfs_fs_devices *seed_devices;
> +	struct btrfs_fs_devices *seed_devices = NULL;
>   	u64 orig_super_total_bytes;
>   	u64 orig_super_num_devices;
>   	int ret = 0;
