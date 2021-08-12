Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63E33EA406
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 13:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbhHLLul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 07:50:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:35079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236091AbhHLLul (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 07:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628769001;
        bh=PQQliEN+YQGg33pjXlmuO0CBK8FdL/o3ElpfoDl0Q9k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EXvTxP+n8zULx7P/Q++4UfgNDmkVM2ubccpzjPhP0y9c6kvDa7iG2lK5UYjy8DFDt
         dPtkKy9OTTLk6persDOF7suNt/01fQsenf3J8uArnrIIfzzl7kiJofOpM1RAIGzsKF
         l9RNaLcXI3dyCbrQKYBX2q1+ViOHU0Tgu09kU8Z8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvrB-1mjvCn3DQr-00hJz0; Thu, 12
 Aug 2021 13:50:01 +0200
Subject: Re: [PATCH v2] btrfs-progs: Replace OPEN_CTREE_NO_BLOCK_GROUPS with
 OPEN_CTREE_PARTIAL
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210812112019.27621-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ff289fca-0a09-c0a8-fd9e-f59f487464ee@gmx.com>
Date:   Thu, 12 Aug 2021 19:49:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812112019.27621-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8tSAWDXeYAYTA7CWLjy2kq66inbT+0Kl8J4z0AJhLVkZ710HVf0
 VCQroVFbIhDubj2EnKksVYY6igbUIThk1jbaY4+De0pP9bL8e7W6g//r68CoXKbMtLNIzKd
 FUUcXGi5y/m9gmx7NY0E5WQZNgp7+ax9I2jI4DeIW2KC1SOMles5Acp3FuEajR8Ofaxdz0p
 f176Krv0NGIzEf2cJDdQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S6mT/ZP0ozE=:ackElekACW85o1cQ20QPXD
 QtY3c2x6v8uwihjakXhn5f7M3O5lR7PodsjEDxXHOx0Gp8dwtgcvNiC8HKT7+KAL85U/0y3Ky
 moz3ttushDOffGtN2/tyqcaMKOmBE+BaNyi1ucNvUDukGzjpCpq/t7TfrlPokDnu4ta7Dc0FP
 Mwz+oNCqQGrewek7JLMYL7cA9mdV1f1LI71f/CmJijmG4uz9ypPqg6mEkSz8AEi+gkmwTGmJS
 h8LCk0ghU+sy54XcJLUvVg5dIxrxVm02tMtQkBOxQPM0hHsNGg7UoP9T5rUjjp/M9bUCR7rmh
 6geUeu/laZ3GRVhpvYcelIBZs1sbwk5B3D5M3dIJ0mUC6CzES0r5GBpsamUdW+Wptf3ePTART
 Cb0MWqtTYJVzxxWGfnkCCu1mz5EDQcqq5PHe5ijKyR/nDmxzmJJLVS9UqqBa149S/Ex0EYiij
 RTxL1uEP7KIXbjzBOU7VpDsJt/71OPYG6Hylt1uF3kYHLXqh0E594xaaXo18v2ZQaVV8S0Gsz
 Y9cMbELmfLOVqgE3ALWJjupSldGXZ+ub2vCWuWrM7npZb6vqg070zNGT5oql5Nd6ioGGlIY/T
 ugYbhedSslOWKtzlkzf9csUAJncmEtDY1Eg25Ufr3vR9uzcz5zS0q8I5yuDrA9Y/X7eVSje+m
 81P4SeahQfYv/h35p5fm9c+IEQajVqYPH4CSlfSbGMw0JmkwL/ujv83p3xvwJyoMaEaxPLHzl
 +nksFFlu+uFKg3hAnFTrS3EcTjovKBiIKEd3Tmgs3tsYSOmHmfjWLo48RTv5G/ZD7yXkkIrEE
 FiqGlWxQDdGiJgS07pygptoDniAN87ANV88BTFL33hm0x3QF+7OhXKzFiUOQs/DPAoc3pSxx5
 7TtmfIuEPOqVqXFW57dEtzy5eGBb+jBQVL4HxA6AcuYHRFEBxmzqU//VDzf3nVMjykJpo/QkF
 M6Ypxhv/lB9F8QZQ1HnNx/IQ/N21QyRznM4vGJvXLV4boTQ7Ui8Qjo8luPRI0o2HzyJOW4LAe
 2Qq34+maq28SqKuP/l5xjo5tNcj6niAmAoBg1OjUtF87dj/BcLBumaAuqkHEamLStsyTtAC9d
 2FxicawNs0fHr9epOm+rzaG/1TSORKQNkiqamlzLft4c04DnluZwWQfFA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/12 =E4=B8=8B=E5=8D=887:20, Nikolay Borisov wrote:
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
> extent tree is corrupted. This allows to eliminate OPEN_CTREE_NO_BLOCK_G=
ROUPS
> and replace its usage with OPEN_CTREE_PARTIAL, since it's sufficient to =
check
> only for the extent tree's extent buffer's uptodate state, which is cont=
rolledi
> by OPEN_CTREE_PARTIAL. Additionally to retain the existing semantics, if=
 an
> error is encountered while reading any of the block groups, simply free =
the
> block group caches and clearing the uptodate flag on the extent root's n=
ode.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> V2:
> * Handle the case where we encounter an error on a child node of the ext=
en tree
>    while opening the fs with PARTIAL flag. In this case simply delete an=
y block groups
>    read.
>
>   check/main.c             |  2 +-
>   cmds/inspect-dump-tree.c |  2 +-
>   cmds/rescue.c            |  4 ++--
>   cmds/restore.c           |  2 +-
>   kernel-shared/disk-io.c  | 15 ++++++++++-----
>   kernel-shared/disk-io.h  |  7 ++++---
>   6 files changed, 19 insertions(+), 13 deletions(-)
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
> index 84990a521178..dfa4576c6371 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -1044,8 +1044,7 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs=
_info, u64 root_tree_bytenr,
>
>   	fs_info->generation =3D generation;
>   	fs_info->last_trans_committed =3D generation;
> -	if (extent_buffer_uptodate(fs_info->extent_root->node) &&
> -	    !(flags & OPEN_CTREE_NO_BLOCK_GROUPS)) {
> +	if (extent_buffer_uptodate(fs_info->extent_root->node)) {
>   		ret =3D btrfs_read_block_groups(fs_info);
>   		/*
>   		 * If we don't find any blockgroups (ENOENT) we're either
> @@ -1053,9 +1052,15 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *f=
s_info, u64 root_tree_bytenr,
>   		 * anything else is error
>   		 */
>   		if (ret < 0 && ret !=3D -ENOENT) {
> -			errno =3D -ret;
> -			error("failed to read block groups: %m");
> -			return ret;
> +			if (!(flags & OPEN_CTREE_PARTIAL)) {
> +				errno =3D -ret;
> +				error("failed to read block groups: %m");
> +				return ret;
> +			} else {
> +				btrfs_free_block_groups(fs_info);
> +				clear_extent_buffer_uptodate(
> +						fs_info->extent_root->node);
> +			}
>   		}
>   	}
>
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
