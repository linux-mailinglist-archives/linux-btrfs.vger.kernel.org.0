Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D5B72DFDE
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbjFMKla (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242002AbjFMKlR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:41:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12045171A
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686652863; x=1687257663; i=quwenruo.btrfs@gmx.com;
 bh=+tlY1oX/kBYB0n4T4ofoVnDt3f5qwr7r/fF9le978yg=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=jGvSxWU5k5qtgo37R/7x2b4MibXfRKk4gXy3T9GgGOI7lKSZoRYdU1hg9QrhQk87q+4lIz8
 A7I4IlOU3RLyafYaL7v2gi29mnK6plTfwGPXo07uvIxCfHeICAb6Q29v86RWzII8H3ZBBAayT
 OncZRyzHYRqWSvnbPmlgAtj4OHnZElGwQEsAZEblRKshqPyWV5AdTwxU5Ew492EERaYCgGpfy
 qZ+7STMZMwwygrrCc9oAmMIUsjSTxggm0Ew9niMQHAI3FE6lnex6H5gXsYAb4UpzysvQ7ZLPN
 TvNG+e1vlALnxqwoOsrf1QL4U29fa5RkedkuCG2YL0b/9zc8zoSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbzyJ-1pZghc00Eh-00dVez; Tue, 13
 Jun 2023 12:41:03 +0200
Message-ID: <8fe992a2-540d-c1e5-31c7-a41565e46986@gmx.com>
Date:   Tue, 13 Jun 2023 18:41:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/6] btrfs-progs: drop open_ctree_flags in
 cmd_inspect_dump_tree
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1686484067.git.anand.jain@oracle.com>
 <672f8622c658d14a2168598c4bb51cae1bbadf7e.1686484067.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <672f8622c658d14a2168598c4bb51cae1bbadf7e.1686484067.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IrTgGF2vLVfq82oeuvrMW35HYcfbYu+yV9tvkb9X2kT4KNAn/Lb
 qGQBgllgI8wkaKNkzkcAm1GtQuZvNl+E3hQ2JOgw8D5y/PIScXEiywcXL8sjwWoOh49NVlU
 XoxLi/Iz52jHRD6+sSDp446taNLA5QrgEOyejpX1ItrGCRtbB09MTcC455Izf+n/GrrgmuH
 sYMk0Be7OcsakZ70oyDZQ==
UI-OutboundReport: notjunk:1;M01:P0:D+VcShtq6ZQ=;WDFhlUuPClvmEpngkZQ6RMFpNJX
 T2dBJsksKS5Xz6Sv3WRl/FEWGBr4HDUvKT4KjwWaXYmcIrkMUWcwZWVQqU90QWOp8ibEKHI9Z
 aMzHoF052nDUDh7sqlwej1WOg83Yh29/B9/vkLZfSmOG5at+Gpvc+FLN51TWORHlbGwLgrDdH
 YeCjMJjV0TNPLcxmMag8m0dKo/X2D+wsYFOjJZ1Y9ajAkSGFhHOSSpIYqpEJYUJMCnKmWpvgq
 qpoQsivNC6s21NjzW/yI5Eq/9S8Be2dXTqRJtt/vPF8/UVEQG6RdKMd3JH3VVqZAk4gshH66m
 jcxmczCGQMLXsWM3uZ3KLSilBNo/RY1aN8dNhVrHQRLO3UcFqWA3XNOAf8gsj3AGVH8wMXY7H
 NC4Y1Bv93gtQWZ0hQwB01cQukPZ7xBhnFwp6jg7lDSrrnJCnoBzA7LV0nR5b3THKrbSBhw30v
 o8/PTiNWTeO7EKG7c8B7f6QvuKQVkGTvt9oYyJ2v71oLCODISNS0KgUSFppNh05QQj9IOSPB7
 PRdOrH1GWN+WISgg79zmlMEvhP1cineUz+24aeTLeoqKepG9un+JHJ85fEUUmW+ZdNHBQ/xAK
 kQtJzoAFfSwGMffz4oWo0yMI86r5tR9Q1rK32/4QgDafWlFJLwZNPA8W1tdfIKZAzdfcei+xX
 6ckv1zTNYzupRQDlh8lO2ALIR5jiE5lQGKXi6LbahMMpVIMxnyogTXGclzKAYSvetiiyGkLt3
 z5yy5S2kTacQEyTQZBg8kKXfo0/3X3ZfkdgpnCxWsOyoyBLTRVhVoHp0YVLlRGucfnDWcvkzA
 rFiqH9hXSdMur3g4LN2yMVDFBouWivki/FiKzBuPS9/oTDeYJzVfEo1bHUPMw7UEPPMQeYnpc
 GV4xMv8PK55yVXnQVLuC7FAQbLzPnVnbMUu+J9DcsIpu7W4GcQEzoeMYme8SN93blkTF33/BQ
 O+rYHtKviAF5dvwZYevZp6DKMCA=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/13 18:26, Anand Jain wrote:
> Local variable open_ctree_flags carries the flags whose final update is
> for the locally declared struct variable oca_flags. Just use oca.flags
> directly.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   cmds/inspect-dump-tree.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
> index 4c65f55db014..1d2a785ac5c3 100644
> --- a/cmds/inspect-dump-tree.c
> +++ b/cmds/inspect-dump-tree.c
> @@ -328,7 +328,6 @@ static int cmd_inspect_dump_tree(const struct cmd_st=
ruct *cmd,
>   	bool root_backups =3D false;
>   	int traverse =3D BTRFS_PRINT_TREE_DEFAULT;
>   	int dev_optind;
> -	unsigned open_ctree_flags;
>   	u64 block_bytenr;
>   	struct btrfs_root *tree_root_scan;
>   	u64 tree_id =3D 0;
> @@ -346,8 +345,8 @@ static int cmd_inspect_dump_tree(const struct cmd_st=
ruct *cmd,
>   	 * And we want to avoid tree-checker, which can rejects the target tr=
ee
>   	 * block completely, while we may be debugging the problem.
>   	 */
> -	open_ctree_flags =3D OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS |
> -			   OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
> +	oca.flags =3D OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS |
> +					OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
>   	cache_tree_init(&block_root);
>   	optind =3D 0;
>   	while (1) {
> @@ -400,7 +399,7 @@ static int cmd_inspect_dump_tree(const struct cmd_st=
ruct *cmd,
>   			 * If only showing one block, no need to fill roots
>   			 * other than chunk root
>   			 */
> -			open_ctree_flags |=3D __OPEN_CTREE_RETURN_CHUNK_ROOT;
> +			oca.flags |=3D __OPEN_CTREE_RETURN_CHUNK_ROOT;
>   			block_bytenr =3D arg_strtou64(optarg);
>   			ret =3D dump_add_tree_block(&block_root, block_bytenr);
>   			if (ret < 0)
> @@ -437,10 +436,10 @@ static int cmd_inspect_dump_tree(const struct cmd_=
struct *cmd,
>   			traverse =3D BTRFS_PRINT_TREE_BFS;
>   			break;
>   		case GETOPT_VAL_NOSCAN:
> -			open_ctree_flags |=3D OPEN_CTREE_NO_DEVICES;
> +			oca.flags |=3D OPEN_CTREE_NO_DEVICES;
>   			break;
>   		case GETOPT_VAL_HIDE_NAMES:
> -			open_ctree_flags |=3D OPEN_CTREE_HIDE_NAMES;
> +			oca.flags |=3D OPEN_CTREE_HIDE_NAMES;
>   			break;
>   		case GETOPT_VAL_CSUM_HEADERS:
>   			csum_mode |=3D BTRFS_PRINT_TREE_CSUM_HEADERS;
> @@ -493,7 +492,6 @@ static int cmd_inspect_dump_tree(const struct cmd_st=
ruct *cmd,
>   	pr_verbose(LOG_DEFAULT, "%s\n", PACKAGE_STRING);
>
>   	oca.filename =3D argv[optind];
> -	oca.flags =3D open_ctree_flags;
>   	info =3D open_ctree_fs_info(&oca);
>   	if (!info) {
>   		error("unable to open %s", argv[optind]);
