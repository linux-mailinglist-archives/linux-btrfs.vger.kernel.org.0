Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014C36272EB
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 23:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiKMW2V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 17:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiKMW2T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 17:28:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA14AF016
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 14:28:17 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeR1-1oPjTK471v-00Vib4; Sun, 13
 Nov 2022 23:28:06 +0100
Message-ID: <78007fd7-1ff2-f214-90a4-f4fdc5eea3ed@gmx.com>
Date:   Mon, 14 Nov 2022 06:28:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/3] btrfs: move struct btrfs_tree_parent_check out of
 disk-io.h
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20221113162416.883652-1-hch@lst.de>
 <20221113162416.883652-2-hch@lst.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221113162416.883652-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+IP7FmNdJfHIRbHZYxP9VRKMy0EmUS5B+yFyeiOTz1hvRc6uq0M
 maS4en2qjPTq3QX9oCq8L6IbX99sL1aibF1W6taY6zHOsCfk5r7xNQqYkTfWNcrq89aa1Ss
 8SP9iKVinZ5CVv42+5VjmI6J6h0jnQw9rWwuZmUl7rwG1uvcshq81plCoeCdDxXBEcK1hKJ
 wfBl5e57xfTCa4hYdm0eg==
UI-OutboundReport: notjunk:1;M01:P0:E+8XC/dQSjw=;BUjVLLD9lhTp+zYo71zSE7haJAL
 uNmP49RYQewlxDMGyaZjS2poY8wtld43Wpn4FFH+OmA2PxC7+av77J206ydGFpSBuc+d/mORe
 18t25nLyU5juQIdzGndrXD61wEBbpV2e8hpScr2a+XIpOF5rKpHtrMB9i0D+L0OymULvS60C3
 0OfCL2rtukDC/O/SZboFAp7cQind2qxAcUyvdjt2rRbEGFwLBSzBwK2reQHyUcTUAaeEUq5Ib
 n9lU+Z57R8P4Urwt2d6uG+lGqk7O2FUioJ1f00FpIBtX7esk6HEb4nNCbyfyDiM7Sw2cJc1dn
 1NcXWpI4lqG1/aVNQqeAcVKUqj5Ejrqy/kFGrnRvy5CH56W/eKpRQD7OeN2funaRc934ppvOM
 Y1NF2utYINlJK7Zp5SSyiSMnCD8NuLybDaESACehBnE64irhvcYS759zLlz1+tAQtOFGWV/o+
 dWElFckMi9lVe2VW2HNlbjdEAFj/CNkS9TJ7RA0CJ6xLscs1luLDn27kyvS+EwnUJFdsdZMGo
 NFoWoMzv7/C1IKoUvgHYrMWX9QUjO4u5uiugzF29KB8khOib11rRqtBV8psOEJfJRduGBHzK1
 WmzRYTfYstZRGrKTVHTE0hlLuwx9yhrbDIWENT07oro9tpw6PlF0RDhLHLu1yJ75vT1rnMMEo
 UHhqou7qzB2CWG3wZsyMKPEZL3Su+uoKXnAYrq/jmFmpwMor8hZjGmR3oTc7xr65BIq9OCrtc
 jr0EzalTVxQkrATHI+DxeJT8Ly+2a8CQV+p/0e8Ip5Yj9DmpfGQnejSHh78uNx0q101aeSBhD
 5c934A42YADGo8Toalg1XreuCcVwlNXPZeZCjdqSXjkfYbBn6JshHaiLOzpBjxELJFlo2Iyya
 rjAKTXzxVxcNW/FDLthzHONSwXhJEK5semybDgABUW9eTEISavGFH8bJtUqh/1NGItQi+XHgy
 /7tDER7g6XBmsASwbWQlLQre7GE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/14 00:24, Christoph Hellwig wrote:
> Move struct btrfs_tree_parent_check out of disk-io.h so that volumes.h
> an various .c files don't have to include disk-io.h just for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/backref.c      |  1 +
>   fs/btrfs/disk-io.h      | 30 +-----------------------------
>   fs/btrfs/parent-check.h | 36 ++++++++++++++++++++++++++++++++++++
>   fs/btrfs/print-tree.c   |  1 +
>   fs/btrfs/qgroup.c       |  1 +
>   fs/btrfs/tree-mod-log.c |  1 +
>   fs/btrfs/volumes.h      |  2 +-
>   7 files changed, 42 insertions(+), 30 deletions(-)
>   create mode 100644 fs/btrfs/parent-check.h
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 55c072ba67471..9496aa93a8dcc 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -19,6 +19,7 @@
>   #include "accessors.h"
>   #include "extent-tree.h"
>   #include "relocation.h"
> +#include "parent-check.h"
>   
>   /* Just arbitrary numbers so we can be sure one of these happened. */
>   #define BACKREF_FOUND_SHARED     6
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 03fe4154ffb83..363935cfc0844 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -25,37 +25,9 @@ static inline u64 btrfs_sb_offset(int mirror)
>   	return BTRFS_SUPER_INFO_OFFSET;
>   }
>   
> -/* All the extra info needed to verify the parentness of a tree block. */
> -struct btrfs_tree_parent_check {
> -	/*
> -	 * The owner check against the tree block.
> -	 *
> -	 * Can be 0 to skip the owner check.
> -	 */
> -	u64 owner_root;
> -
> -	/*
> -	 * Expected transid, can be 0 to skip the check, but such skip
> -	 * should only be utlized for backref walk related code.
> -	 */
> -	u64 transid;
> -
> -	/*
> -	 * The expected first key.
> -	 *
> -	 * This check can be skipped if @has_first_key is false, such skip
> -	 * can happen for case where we don't have the parent node key,
> -	 * e.g. reading the tree root, doing backref walk.
> -	 */
> -	struct btrfs_key first_key;
> -	bool has_first_key;
> -
> -	/* The expected level. Should always be set. */
> -	u8 level;
> -};
> -
>   struct btrfs_device;
>   struct btrfs_fs_devices;
> +struct btrfs_tree_parent_check;
>   
>   void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info);
>   void btrfs_init_fs_info(struct btrfs_fs_info *fs_info);
> diff --git a/fs/btrfs/parent-check.h b/fs/btrfs/parent-check.h
> new file mode 100644
> index 0000000000000..333f23ea28e25
> --- /dev/null
> +++ b/fs/btrfs/parent-check.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef BTRFS_PARENT_CHECK_H
> +#define BTRFS_PARENT_CHECK_H
> +
> +#include <uapi/linux/btrfs_tree.h>
> +
> +/* All the extra info needed to verify the parentness of a tree block. */
> +struct btrfs_tree_parent_check {
> +	/*
> +	 * The owner check against the tree block.
> +	 *
> +	 * Can be 0 to skip the owner check.
> +	 */
> +	u64 owner_root;
> +
> +	/*
> +	 * Expected transid, can be 0 to skip the check, but such skip
> +	 * should only be utlized for backref walk related code.
> +	 */
> +	u64 transid;
> +
> +	/*
> +	 * The expected first key.
> +	 *
> +	 * This check can be skipped if @has_first_key is false, such skip
> +	 * can happen for case where we don't have the parent node key,
> +	 * e.g. reading the tree root, doing backref walk.
> +	 */
> +	struct btrfs_key first_key;
> +	bool has_first_key;
> +
> +	/* The expected level. Should always be set. */
> +	u8 level;
> +};
> +
> +#endif /* BTRFS_PARENT_CHECK_H */
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index 1469aa55ad482..00d5da5f3c333 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -8,6 +8,7 @@
>   #include "disk-io.h"
>   #include "print-tree.h"
>   #include "accessors.h"
> +#include "parent-check.h"
>   
>   struct root_name_map {
>   	u64 id;
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 05e79f7b4433a..365482ad0421b 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -28,6 +28,7 @@
>   #include "accessors.h"
>   #include "extent-tree.h"
>   #include "root-tree.h"
> +#include "parent-check.h"
>   
>   /*
>    * Helpers to access qgroup reservation
> diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
> index 779ad44d285f8..5b91a2a88a398 100644
> --- a/fs/btrfs/tree-mod-log.c
> +++ b/fs/btrfs/tree-mod-log.c
> @@ -5,6 +5,7 @@
>   #include "disk-io.h"
>   #include "fs.h"
>   #include "accessors.h"
> +#include "parent-check.h"
>   
>   struct tree_mod_root {
>   	u64 logical;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index efa6a3d48cd8d..bcf544849b6d5 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -11,7 +11,7 @@
>   #include <linux/btrfs.h>
>   #include "async-thread.h"
>   #include "messages.h"
> -#include "disk-io.h"
> +#include "parent-check.h"
>   
>   #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
>   
