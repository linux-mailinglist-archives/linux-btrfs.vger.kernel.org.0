Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4B13EA0F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhHLIrj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 04:47:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:57627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234835AbhHLIrg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 04:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628758028;
        bh=WetOnGMQHvdqRFYMGpdVS1pazwzm1gdhzzdR6TUFvcA=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=Wnfn1rQZ2HqgHP2NVHw3W6VkihayBM8lrmBZ4+4Cq5yXZ8QqFDYZR2Osen6B39HqR
         PDF5SI/JGVKe6sSwxop3CsWFfJjUHU7FKnPD6m+wQ1w5MDyl+DC8Yalll8xJ8rQCeV
         HCatVL0IIpKIDS8frdj1E9RdiQqBL6HFr+zssw4Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XTv-1n9Lre1KNN-014Ttp; Thu, 12
 Aug 2021 10:47:07 +0200
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210812081546.20724-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs-progs: Replace OPEN_CTREE_NO_BLOCK_GROUPS with
 OPEN_CTREE_PARTIAL
Message-ID: <567acd9f-7eaa-3bca-b098-f601dae9dece@gmx.com>
Date:   Thu, 12 Aug 2021 16:47:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812081546.20724-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SWj9x5n+epB6vURqr9QB3/DK8eWqHMQkvko1Zy6P1wOXpbbObRM
 6Z/6UaFpt/47x7axCWQnoKJDSr+vb9dt/5/pnB7m7JaovN5MBS6RKnvskcp8JQbyRMXx/GQ
 iZejeK1UfcnGI2v3PUg+UsGxS943Mnp/AzHUovJ7TFpbur8nWBBkHPU1h90TpKt1e11yxPk
 gh2rYzJQlsMJdgQUrMr7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SUvWsNebVIs=:/wojX4vcEkp3QfUEvcUEQP
 Excul89/eiuxBKkvwgG1NdzBQuvb9gUN7JzhapWNX0TyGYdVY9moydVjtwkN5AI+VsqEI0t7o
 IDYRALX6TEnIVT1JDk8OzeZZvDb1jzeqnqYrMr/4jxjGu66+0c6LWmRNAXLw4TXu1jHMkDkgR
 YhEEgZhFgBG4J/+N7bN89igNo2t5osXdNN1SlEDpABat7a+mOf9rhfxipGzDjw24XkewDg93Q
 ZusQ6FOIsK4MzDwqlg+bwnrklb3DPUkq/WCOXpa7bihyKPn71BYl1uhrKNUwjbC61hcdL7TxJ
 alW7mGmLSriJddgyDPpwrOr4r1JHbRXB7VMJcy8jprfzpJG17qPg4K2CXmuS2B6XrQd/rqCSl
 ysgNDPsWfDoQ8m5oHM7csO+05623A9WBOkCYiAkafJy6oF/Uw+fqS5ekksk+c9JnHTGKSDQxJ
 RDlOP2fyHjRg9H29137p5qlFiMHkjcLy0Bk5OTrt//9vbXHgVnh58mrBwjVe07FfOWJ1guqmC
 JDB32lU8I//TtFfjMNGq/l9VHOXUzONjYlyKgZrnx8/E+2CRN8gyIG7BCMDkFQM6k5fwV/Toq
 ww+MpOqVtdkprIpFzmubNfIau96w9irzM3ngBHz9uK+c0mY6Zxcy5RQHdlY+o2y4tUorlEI9I
 491zd9EW+sP2pIB7+rmNV8gaSV3xM4rnVKnf8DzNl6Ti/H3QbZJ/cKgbLX1NnF6oRdIpWqBC9
 NDe037+04j/i43c3mQl+5rTxRbCDk6VyhGjaLwDD4BXzhBXC3GWNe+8T28y/fYeDsuYfIHQT2
 fPuF3l6NijArB4A+2ugJruJKtnIs9eguvZjvjYsMDDyMNdQHE2AETapfmNoiLmpc8GkbXROMs
 Drcc60UYmvO/jgIUKlp8g5Ttp7JffS5jkgc1LqMfR8GeUEXQxUjHxiD6RjrjhJGPP/77Cmv8P
 TK5cpiuQW13hunGlYwIYmf21lzYSFA+xTHppRDVbyN5hhohWFOK3Z7rQN8FL5za7csdZQO4ic
 XFwAr6coa/PoZvcHj1rUgsy/ga2+LHF85uN8QHBF6biUF9dbp1X+kxAfz2GgAMhWjAGluRpdB
 oEGUMayFpde/69jle6IJQA0EBDiMn38djWxrS0KLd6JM3rfh/tBMoFaVQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/12 =E4=B8=8B=E5=8D=884:15, Nikolay Borisov wrote:
> When OPEN_CTREE_PARTIAL is used errors in loading the extent/csum/log
> trees are turned into non-fatal ones and those roots are initialized
> with dummy root nodes, which don't have uptodate flag set on the
> respective extent buffer. On the other hand reading block groups during
> mount is predicated on OPEN_CTREE_NO_BLOCK_GROUPS being unset and
> the extent tree's root extent buffer to have the uptodate flag set to
> true. Furthermore, OPEN_CTREE_NO_BLOCK_GROUP is used when there is a
> high chance the filesystem being opened can be damaged, similarly to
> OPEN_CTREE_PARTIAL.
>
> Considering this logic, it's not possible to load block groups when both
> OPEN_CTREE_NO_BLOCK_GROUPS and OPEN_CTREE_PARTIAL are passed and the
> extent tree is corrupted. This allows to eliminate
> OPEN_CTREE_NO_BLOCK_GROUPS and replace its usage with
> OPEN_CTREE_PARTIAL, since it's sufficient to check only for the extent
> tree's extent buffer's uptodate state, which is controlled by
> OPEN_CTREE_PARTIAL.

There is still some differences between PARTIAL and NO_BLOCK_GROUPS.

The major one is, how we handle partially corrupted extent tree (aka,
some leaves are corrupted, but extent tree root is still OK).

In that case, NO_BLOCK_GROUPS will skip the block group item search
completely, thus continue to mount, just with empty block group cache tree=
.

While PARTIAL will still try to do the block group item search, and if
it hits -EIO, it errors out with -EIO and abort open_ctree().

To merge both, we need to enhance the error handling of
btrfs_read_block_groups() and make sure all call sites utilizing PARTIAL
are OK with partially populated block group cache.

 From a quick glance, I haven't seen obvious call sites that require
block group items while still passes PARTIAL.

Thus I'm fine to merge the two options, but as mentioned, we still need
to change the error handling of btrfs_read_block_groups() in that case.

Thanks,
Qu

> ---
>   check/main.c             | 2 +-
>   cmds/inspect-dump-tree.c | 2 +-
>   cmds/rescue.c            | 4 ++--
>   cmds/restore.c           | 2 +-
>   kernel-shared/disk-io.c  | 2 +-
>   kernel-shared/disk-io.h  | 7 ++++---
>   6 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/check/main.c b/check/main.c
> index a88518159830..84dd96fc167a 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -10342,7 +10342,7 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>   			case GETOPT_VAL_INIT_EXTENT:
>   				init_extent_tree =3D 1;
>   				ctree_flags |=3D (OPEN_CTREE_WRITES |
> -						OPEN_CTREE_NO_BLOCK_GROUPS);
> +						OPEN_CTREE_PARTIAL);
>   				repair =3D 1;
>   				break;
>   			case GETOPT_VAL_CHECK_CSUM:
> diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
> index e1c90be7e81f..fca79cd11599 100644
> --- a/cmds/inspect-dump-tree.c
> +++ b/cmds/inspect-dump-tree.c
> @@ -330,7 +330,7 @@ static int cmd_inspect_dump_tree(const struct cmd_st=
ruct *cmd,
>   	 * to inspect fs with corrupted extent tree blocks, and show as many =
good
>   	 * tree blocks as possible.
>   	 */
> -	open_ctree_flags =3D OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS;
> +	open_ctree_flags =3D OPEN_CTREE_PARTIAL;
>   	cache_tree_init(&block_root);
>   	optind =3D 0;
>   	while (1) {
> diff --git a/cmds/rescue.c b/cmds/rescue.c
> index a98b255ad328..7ebe9b6c1e54 100644
> --- a/cmds/rescue.c
> +++ b/cmds/rescue.c
> @@ -194,8 +194,8 @@ static int cmd_rescue_zero_log(const struct cmd_stru=
ct *cmd,
>   		goto out;
>   	}
>
> -	root =3D open_ctree(devname, 0, OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL=
 |
> -			  OPEN_CTREE_NO_BLOCK_GROUPS);
> +	root =3D open_ctree(devname, 0, OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL=
);
> +
>   	if (!root) {
>   		error("could not open ctree");
>   		return 1;
> diff --git a/cmds/restore.c b/cmds/restore.c
> index 39fcc69d8e19..f30d8b7532c0 100644
> --- a/cmds/restore.c
> +++ b/cmds/restore.c
> @@ -1214,7 +1214,7 @@ static struct btrfs_root *open_fs(const char *dev,=
 u64 root_location,
>   		ocf.filename =3D dev;
>   		ocf.sb_bytenr =3D bytenr;
>   		ocf.root_tree_bytenr =3D root_location;
> -		ocf.flags =3D OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS;
> +		ocf.flags =3D OPEN_CTREE_PARTIAL;
>   		fs_info =3D open_ctree_fs_info(&ocf);
>   		if (fs_info)
>   			break;
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index 84990a521178..cc635152c46d 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -1045,7 +1045,7 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs=
_info, u64 root_tree_bytenr,
>   	fs_info->generation =3D generation;
>   	fs_info->last_trans_committed =3D generation;
>   	if (extent_buffer_uptodate(fs_info->extent_root->node) &&
> -	    !(flags & OPEN_CTREE_NO_BLOCK_GROUPS)) {
> +	    !(flags & OPEN_CTREE_PARTIAL)) {
>   		ret =3D btrfs_read_block_groups(fs_info);
>   		/*
>   		 * If we don't find any blockgroups (ENOENT) we're either
> diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
> index 603ff8a3f945..16e13e4f5524 100644
> --- a/kernel-shared/disk-io.h
> +++ b/kernel-shared/disk-io.h
> @@ -32,7 +32,10 @@
>   enum btrfs_open_ctree_flags {
>   	/* Open filesystem for writes */
>   	OPEN_CTREE_WRITES		=3D (1U << 0),
> -	/* Allow to open filesystem with some broken tree roots (eg log root) =
*/
> +	/*
> +	 * Allow to open filesystem with some broken tree roots
> +	 * (eg log root/csum/extent tree)
> +	 */
>   	OPEN_CTREE_PARTIAL		=3D (1U << 1),
>   	/* If primary root pinters are invalid, try backup copies */
>   	OPEN_CTREE_BACKUP_ROOT		=3D (1U << 2),
> @@ -40,8 +43,6 @@ enum btrfs_open_ctree_flags {
>   	OPEN_CTREE_RECOVER_SUPER	=3D (1U << 3),
>   	/* Restoring filesystem image */
>   	OPEN_CTREE_RESTORE		=3D (1U << 4),
> -	/* Do not read block groups (extent tree) */
> -	OPEN_CTREE_NO_BLOCK_GROUPS	=3D (1U << 5),
>   	/* Open all devices in O_EXCL mode */
>   	OPEN_CTREE_EXCLUSIVE		=3D (1U << 6),
>   	/* Do not scan devices */
>
