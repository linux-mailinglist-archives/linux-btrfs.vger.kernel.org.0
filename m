Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23E37B2031
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 16:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjI1OxX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 10:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1OxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 10:53:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E49519E
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 07:53:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40572aeb673so102395745e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695912794; x=1696517594; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lmw/w1R5XcVqSMLmLc6RNJptInDeF/Ct0Qx9KNVNHoU=;
        b=Ey67ML4FpfuHHjGU7OvGCgFHTZ/WmoV5wyWefhzy7dd3WUd0fwN64YUflkbYYe+rDL
         /nIsMrro7y5yGvbam8av3Mm+jWWdm4KEn4rPgYL+YXf88XpIGRbMnPCoE0SD1OxpCEgv
         vABnvQ62CZrbGj6/FdXgfm4m1WeWiizdVGMsHOoqf1fC4PL7/CCTg2jf46f1e5fpU0bj
         bbKV3lBeVyJ7tnl1U9mmrma9PaNfZHNvPcxO0Rab8LQPAYFzErLhWwCQHbRURANrX64q
         /LjwpseHDqy/6vv5pPsytbPB81R6CyWXLmlT3XiNR/CEzCVk6VFquJvnLTXmYMbjhArK
         wasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695912794; x=1696517594;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lmw/w1R5XcVqSMLmLc6RNJptInDeF/Ct0Qx9KNVNHoU=;
        b=ph0BaHnKPrWNizl9sAIMtp5IGISMqFabwxKHUzxCX1BDAvSWbotpbqIb9pG/Z1PVsl
         G9mXwfJRpYDjTQLMYb8Fu49kI3oJ/LeDvRMl8pVqmY3D411qESqqnGO2ooMRdY4hHAYG
         U0DC/yaM/QSrY5cq7usZ0O9s0wzzMBmEuikuOn/ylMfVu//Qke+KjbAo3YV607nBUdTu
         1JeJRNCyiE1yRuff90HItpECrBeGlpsd4K5j4zlKzzT26kTy65zj9V7J9THmxe8/OOTj
         rOx78yxHVTPfTUSlt+IraTrldRTTWSB2GgyYCkJEE8/HpLVMPjIDg5+eYe7V5xnxt5Lj
         MyEw==
X-Gm-Message-State: AOJu0Yyesss8BjoXdrKLcOuftswFB792vbHFTNXrG3Ak0CVZSdLkgWpH
        AyXn/TOOlVM2j3h4lN6Z9/YVvsZOqI81FQ==
X-Google-Smtp-Source: AGHT+IFzf6qGpbgxfhTt5Pq2lqnjk/BW8JzGGmqdLQm/WoMi1RKOYL8Mnblm05zH4/10cV2CmY9CEA==
X-Received: by 2002:a1c:7c05:0:b0:403:cc79:44f3 with SMTP id x5-20020a1c7c05000000b00403cc7944f3mr1657041wmc.19.1695912793483;
        Thu, 28 Sep 2023 07:53:13 -0700 (PDT)
Received: from [192.168.1.121] (athedsl-161999.home.otenet.gr. [85.75.176.109])
        by smtp.googlemail.com with ESMTPSA id t21-20020a7bc3d5000000b00405c7591b09sm8095572wmj.35.2023.09.28.07.53.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Sep 2023 07:53:12 -0700 (PDT)
Subject: Re: [PATCH] btrfs-progs: fix failed resume due to bad search
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <840a9a762a3a0b8365d79dd7c23d812d95761dcf.1695855009.git.wqu@suse.com>
From:   Konstantinos Skarlatos <k.skarlatos@gmail.com>
Message-ID: <fc926390-38ea-f764-4377-25576b872b31@gmail.com>
Date:   Thu, 28 Sep 2023 17:53:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <840a9a762a3a0b8365d79dd7c23d812d95761dcf.1695855009.git.wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu, thanks for your patch. I just tried it on a clean btrfs-progs 
tree with my filesystem:

❯ ./btrfstune --convert-to-block-group-tree /dev/sda
[1]    796483 segmentation fault (core dumped)  ./btrfstune 
--convert-to-block-group-tree /dev/sda

Sep 28 17:46:17 elsinki kernel: btrfstune[796483]: segfault at 
ffffffffff000f2f ip 0000564b6c2107aa sp 00007ffdc8ad25c8 error 5 in 
btrfstune[564b6c1d1000+5b000] likely on CPU 3 (core 2, socket 0)
Sep 28 17:46:17 elsinki kernel: Code: ff 48 8b 34 24 48 8d 3d 5a d8 01 
00 b8 00 00 00 00 e8 5a 37 00 00 48 8b 33 bf 0a 00 00 00 e8 1d 0c fc ff 
eb a8 e8 86 0a fc ff <48> 8b 4f 20 48 8b 56 08 48 89 c8 48 03 47 28 48 
89 c7 b8 01 00 00
Sep 28 17:46:17 elsinki systemd[1]: Created slice Slice 
/system/systemd-coredump.
Sep 28 17:46:17 elsinki systemd[1]: Started Process Core Dump (PID 
796493/UID 0).
Sep 28 17:46:21 elsinki systemd-coredump[796494]: [🡕] Process 796483 
(btrfstune) of user 0 dumped core.

                                                   Stack trace of thread 
796483:
                                                   #0 0x0000564b6c2107aa 
n/a (/root/btrfs-progs/btrfstune + 0x4d7aa)
                                                   ELF object binary 
architecture: AMD x86-64
Sep 28 17:46:21 elsinki systemd[1]: systemd-coredump@0-796493-0.service: 
Deactivated successfully.
Sep 28 17:46:21 elsinki systemd[1]: systemd-coredump@0-796493-0.service: 
Consumed 4.248s CPU time.


On 28/9/2023 1:50 π.μ., Qu Wenruo wrote:
> [BUG]
> There is a bug report that when converting to bg tree crashed, the
> resulted fs is unable to be resumed.
>
> This problems comes with the following error messages:
>
>    ./btrfstune --convert-to-block-group-tree /dev/sda
>    ERROR: Corrupted fs, no valid METADATA block group found
>    ERROR: failed to delete block group item from the old root: -117
>    ERROR: failed to convert the filesystem to block group tree feature
>    ERROR: btrfstune failed
>    extent buffer leak: start 17825576632320 len 16384
>
> [CAUSE]
> When resuming a interrupted conversion, we go through
> read_converting_block_groups() to handle block group items in both
> extent and block group trees.
>
> However for the block group items in the extent tree, there are several
> problems involved:
>
> - Uninitialized @key inside read_old_block_groups_from_root()
>    Here we only set @key.type, not setting @key.objectid for the initial
>    search.
>
>    Thus if we're unlukcy, we can got (u64)-1 as key.objectid, and exit
>    the search immediately.
>
> - Wrong search direction
>    The conversion is converting block groups in descending order, but the
>    block groups read is in ascending order.
>    Meaning if we start from the last converted block group, we would at
>    most read one block group.
>
> [FIX]
> To fix the problems, this patch would just remove
> read_old_block_groups_from_root() function completely.
>
> As for the conversion, we ensured the block group item is either in the
> old extent or the new block group tree.
> Thus there is no special handling needed reading block groups.
>
> We only need to read all block groups from both trees, using the same
> read_old_block_groups_from_root() function.
>
> Reported-by: Konstantinos Skarlatos <k.skarlatos@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> To Konstantinos:
>
> The bug I fixed here can explain all the failures you hit (the initial
> one and the one after the quick diff).
>
> Please verify if this helps and report back (without the quick diff in
> the original thread).
>
> We may have other corner cases to go, but I believe the patch itself is
> necessary no matter what, as the deleted code is really
> over-engineered and buggy.
> ---
>   kernel-shared/extent-tree.c | 79 +------------------------------------
>   1 file changed, 1 insertion(+), 78 deletions(-)
>
> diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
> index 7022643a9843..4d6bf2b228e9 100644
> --- a/kernel-shared/extent-tree.c
> +++ b/kernel-shared/extent-tree.c
> @@ -2852,83 +2852,6 @@ out:
>   	return ret;
>   }
>   
> -/*
> - * Helper to read old block groups items from specified root.
> - *
> - * The difference between this and read_block_groups_from_root() is,
> - * we will exit if we have already read the last bg in the old root.
> - *
> - * This is to avoid wasting time finding bg items which should be in the
> - * new root.
> - */
> -static int read_old_block_groups_from_root(struct btrfs_fs_info *fs_info,
> -					   struct btrfs_root *root)
> -{
> -	struct btrfs_path path = {0};
> -	struct btrfs_key key;
> -	struct cache_extent *ce;
> -	/* The last block group bytenr in the old root. */
> -	u64 last_bg_in_old_root;
> -	int ret;
> -
> -	if (fs_info->last_converted_bg_bytenr != (u64)-1) {
> -		/*
> -		 * We know the last converted bg in the other tree, load the chunk
> -		 * before that last converted as our last bg in the tree.
> -		 */
> -		ce = search_cache_extent(&fs_info->mapping_tree.cache_tree,
> -			         fs_info->last_converted_bg_bytenr);
> -		if (!ce || ce->start != fs_info->last_converted_bg_bytenr) {
> -			error("no chunk found for bytenr %llu",
> -			      fs_info->last_converted_bg_bytenr);
> -			return -ENOENT;
> -		}
> -		ce = prev_cache_extent(ce);
> -		/*
> -		 * We should have previous unconverted chunk, or we have
> -		 * already finished the convert.
> -		 */
> -		ASSERT(ce);
> -
> -		last_bg_in_old_root = ce->start;
> -	} else {
> -		last_bg_in_old_root = (u64)-1;
> -	}
> -
> -	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
> -
> -	while (true) {
> -		ret = find_first_block_group(root, &path, &key);
> -		if (ret > 0) {
> -			ret = 0;
> -			goto out;
> -		}
> -		if (ret != 0) {
> -			goto out;
> -		}
> -		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
> -
> -		ret = read_one_block_group(fs_info, &path);
> -		if (ret < 0 && ret != -ENOENT)
> -			goto out;
> -
> -		/* We have reached last bg in the old root, no need to continue */
> -		if (key.objectid >= last_bg_in_old_root)
> -			break;
> -
> -		if (key.offset == 0)
> -			key.objectid++;
> -		else
> -			key.objectid = key.objectid + key.offset;
> -		key.offset = 0;
> -		btrfs_release_path(&path);
> -	}
> -	ret = 0;
> -out:
> -	btrfs_release_path(&path);
> -	return ret;
> -}
> -
>   /* Helper to read all block groups items from specified root. */
>   static int read_block_groups_from_root(struct btrfs_fs_info *fs_info,
>   					   struct btrfs_root *root)
> @@ -2989,7 +2912,7 @@ static int read_converting_block_groups(struct btrfs_fs_info *fs_info)
>   		return ret;
>   	}
>   
> -	ret = read_old_block_groups_from_root(fs_info, old_root);
> +	ret = read_block_groups_from_root(fs_info, old_root);
>   	if (ret < 0) {
>   		error("failed to load block groups from the old root: %d", ret);
>   		return ret;
