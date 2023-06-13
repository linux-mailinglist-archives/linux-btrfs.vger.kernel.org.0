Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F3172DFDB
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241877AbjFMKkk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240655AbjFMKkh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:40:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDE792
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686652824; x=1687257624; i=quwenruo.btrfs@gmx.com;
 bh=hoplYu6cYfR+Rhehi19T1IenGW+z7VqvuSbrZ/jNwZ4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=mus4TY67vMQ+IKdYTJxs8uhYoA1nSaOSmYsQhTa1PZun5mh9hcAnXCmdPL1cdm5IKESNb8F
 7nQOBvrAbjUjfyTQjLvmDFMnL4u3Rqe6PMS5iCOm3jPTVrkoYKILj+e7SFnoQc+ez9pEQ8d8Q
 va+jrbx344zqimmW+98F1pfii6rV2UCEI8FJ+oZBTuMOiUc5nJysVzid9LZjRTPDB38rVzETW
 NAw8K1O6k2//Dx9snKsdXaBX0VmzCIdrgh0IFQ8P1cDAgC5wN5twFXFrAiUrkqAKxGya9LMhv
 0gOXSCV4jhcwy+SZRvwwgCGg4m8X6zwf+b7Fr6cjKxzeE1ED3GPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlTC-1pkRH71GEA-00jn2C; Tue, 13
 Jun 2023 12:40:23 +0200
Message-ID: <59c4c3e9-3253-dc6d-f79a-566d5fcc40f9@gmx.com>
Date:   Tue, 13 Jun 2023 18:40:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/6] btrfs-progs: rename struct open_ctree_flags to
 open_ctree_args
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1686484067.git.anand.jain@oracle.com>
 <452c6fb3507f8e9b864efbcfccc8a759040f356e.1686484067.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <452c6fb3507f8e9b864efbcfccc8a759040f356e.1686484067.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jHoEPFLmKxjSrFAjPs2+RbaCRrn6QeuvYPuvVnvw7lptgNPaGRq
 wpMzvsE8NkiPh8nZETKk3lw4zJUts9HQHsDT/34TSo7YMrI+SIIRWFB3ovFW3+qaORneqxf
 aYMdhV1CiTQGaFsxs1JEjhpmgHokIYB/azu4OKEkhdTcvj6LdMwDeVUGDE1G+oTnFPczlfK
 o5eSmACt2dzUm5AqsIiuA==
UI-OutboundReport: notjunk:1;M01:P0:atHOiOK3qQU=;neC32a3PbBOevqalpuAx98pXozo
 HnI7oO1sw1GepTOEsTMf1ySzQx9hRT6KFpo9GLowCfCvzha2tJbFf8iyrubw49YqloPQKukcW
 C2KSNFoYL5nGg3WIxTISKrp/a9jI6L7QCR2BKcYGvrFOqWv1ygXQat9cVxiAsR6mMUgcf9e5U
 gDoxB/90/pfmqi6VFuSnlYwspUVfNFrVdUIX+ohHi+xb8g4jiXukED2ubIqBsJLhCGLCgpc4I
 65LAAJNBPqhq5/+JeyIJyTmi6LELNNUZ7OOGKgQqcFPoS34nLrGoTdRzhD4AdwwzhbqoUCtRj
 9zZRKl4CuCucjeaf2Vlv9Dp+myA1fSNMyMV+0/3+lnrFrxu3+BVkgeI6WPZLi4jVRv2SZ3o16
 Jh8elqc3ykcyB0OhcDsHrybPSsiageW5FCC6rl0XQfVhyNpHIvBU4ktaHFh1Q0loYJLxCdGlx
 IH9tc5YGU3U5OCtx015KMcCM5tSKFQn7rrenaEs2zMaOwiZqlAUTfPtCicrwTKyXC9+P3D9qR
 MV/rK7owBeXkSViHSOYPDoIjGITZQ7+IPO9Fr7STaTY4FoRCUCcsjZzrAMMjJrEZO2eJ+OOPd
 cNoWy50VAmhHhIkS/JRR4qPU2LJWAWsKtl5jCDRhSYA50NXAtwJYtsrOrbrKOQgy/x12a2Mot
 T6uxf/mcBkY6C9XnhuxnfXP7lDnuwLmsQBoG5QuwwEsf6znUTyCOYthk3fhe7419Q/G4V4vl9
 CfKQ4T+hnR52JEaMNLKPQcT6YFsrgdguLj199f9dSOCtnfvNTr9coH6L+Jgcg9BmWtPRCnpdD
 QN1Hkg1YqpuBaU6RiopOelRZZZWbnjG+97cTsmW3e/IcNVFsYPquTtsDDv8fRii9qLpSkwPlg
 Y6mux1CqhA5DiAcu3GyikS19qpOBKMSG+y7S0L0LOofxZkQJatBhBE0vyHq61jbXv4GVT9cMY
 i/90FMLQ97t04NounV4++ER67Ns=
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
> The struct open_ctree_flags currently holds arguments for
> open_ctree_fs_info(), it can be confusing when mixed with a local variab=
le
> named open_ctree_flags as below in the function cmd_inspect_dump_tree().
>
> 	cmd_inspect_dump_tree()
> 	::
> 	struct open_ctree_flags ocf =3D { 0 };
> 	::
> 	unsigned open_ctree_flags;
>
> So rename struct open_ctree_flags to struct open_ctree_args.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> v3: Also rename struct open_ctree_args' variable to oca.
>
>   btrfs-find-root.c        |  8 +++----
>   check/main.c             | 14 +++++------
>   cmds/filesystem.c        |  8 +++----
>   cmds/inspect-dump-tree.c |  8 +++----
>   cmds/rescue.c            | 16 ++++++-------
>   cmds/restore.c           | 12 +++++-----
>   image/main.c             | 16 ++++++-------
>   kernel-shared/disk-io.c  | 50 ++++++++++++++++++++--------------------
>   kernel-shared/disk-io.h  |  4 ++--
>   mkfs/main.c              |  8 +++----
>   10 files changed, 72 insertions(+), 72 deletions(-)
>
> diff --git a/btrfs-find-root.c b/btrfs-find-root.c
> index 398d7f216ee7..e5a60c2023df 100644
> --- a/btrfs-find-root.c
> +++ b/btrfs-find-root.c
> @@ -335,7 +335,7 @@ int main(int argc, char **argv)
>   	struct btrfs_find_root_filter filter =3D {0};
>   	struct cache_tree result;
>   	struct cache_extent *found;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args oca =3D { 0 };
>   	int ret;
>
>   	/* Default to search root tree */
> @@ -378,9 +378,9 @@ int main(int argc, char **argv)
>   	if (check_argc_min(argc - optind, 1))
>   		return 1;
>
> -	ocf.filename =3D argv[optind];
> -	ocf.flags =3D OPEN_CTREE_CHUNK_ROOT_ONLY | OPEN_CTREE_IGNORE_CHUNK_TRE=
E_ERROR;
> -	fs_info =3D open_ctree_fs_info(&ocf);
> +	oca.filename =3D argv[optind];
> +	oca.flags =3D OPEN_CTREE_CHUNK_ROOT_ONLY | OPEN_CTREE_IGNORE_CHUNK_TRE=
E_ERROR;
> +	fs_info =3D open_ctree_fs_info(&oca);
>   	if (!fs_info) {
>   		error("open ctree failed");
>   		return 1;
> diff --git a/check/main.c b/check/main.c
> index 77bb50a0e21e..2f4fa5ada339 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9983,7 +9983,7 @@ static int cmd_check(const struct cmd_struct *cmd,=
 int argc, char **argv)
>   {
>   	struct cache_tree root_cache;
>   	struct btrfs_root *root;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args oca =3D { 0 };
>   	u64 bytenr =3D 0;
>   	u64 subvolid =3D 0;
>   	u64 tree_root_bytenr =3D 0;
> @@ -10204,12 +10204,12 @@ static int cmd_check(const struct cmd_struct *=
cmd, int argc, char **argv)
>   	if (opt_check_repair)
>   		ctree_flags |=3D OPEN_CTREE_PARTIAL;
>
> -	ocf.filename =3D argv[optind];
> -	ocf.sb_bytenr =3D bytenr;
> -	ocf.root_tree_bytenr =3D tree_root_bytenr;
> -	ocf.chunk_tree_bytenr =3D chunk_root_bytenr;
> -	ocf.flags =3D ctree_flags;
> -	gfs_info =3D open_ctree_fs_info(&ocf);
> +	oca.filename =3D argv[optind];
> +	oca.sb_bytenr =3D bytenr;
> +	oca.root_tree_bytenr =3D tree_root_bytenr;
> +	oca.chunk_tree_bytenr =3D chunk_root_bytenr;
> +	oca.flags =3D ctree_flags;
> +	gfs_info =3D open_ctree_fs_info(&oca);
>   	if (!gfs_info) {
>   		error("cannot open file system");
>   		ret =3D -EIO;
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 47fd2377f5f4..79f3e799250a 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -636,7 +636,7 @@ static int map_seed_devices(struct list_head *all_uu=
ids)
>   	fs_uuids =3D btrfs_scanned_uuids();
>
>   	list_for_each_entry(cur_fs, all_uuids, list) {
> -		struct open_ctree_flags ocf =3D { 0 };
> +		struct open_ctree_args oca =3D { 0 };
>
>   		device =3D list_first_entry(&cur_fs->devices,
>   						struct btrfs_device, dev_list);
> @@ -650,9 +650,9 @@ static int map_seed_devices(struct list_head *all_uu=
ids)
>   		/*
>   		 * open_ctree_* detects seed/sprout mapping
>   		 */
> -		ocf.filename =3D device->name;
> -		ocf.flags =3D OPEN_CTREE_PARTIAL;
> -		fs_info =3D open_ctree_fs_info(&ocf);
> +		oca.filename =3D device->name;
> +		oca.flags =3D OPEN_CTREE_PARTIAL;
> +		fs_info =3D open_ctree_fs_info(&oca);
>   		if (!fs_info)
>   			continue;
>
> diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
> index bfc0fff148dd..4c65f55db014 100644
> --- a/cmds/inspect-dump-tree.c
> +++ b/cmds/inspect-dump-tree.c
> @@ -317,7 +317,7 @@ static int cmd_inspect_dump_tree(const struct cmd_st=
ruct *cmd,
>   	struct btrfs_disk_key disk_key;
>   	struct btrfs_key found_key;
>   	struct cache_tree block_root;	/* for multiple --block parameters */
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args oca =3D { 0 };
>   	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
>   	int ret =3D 0;
>   	int slot;
> @@ -492,9 +492,9 @@ static int cmd_inspect_dump_tree(const struct cmd_st=
ruct *cmd,
>
>   	pr_verbose(LOG_DEFAULT, "%s\n", PACKAGE_STRING);
>
> -	ocf.filename =3D argv[optind];
> -	ocf.flags =3D open_ctree_flags;
> -	info =3D open_ctree_fs_info(&ocf);
> +	oca.filename =3D argv[optind];
> +	oca.flags =3D open_ctree_flags;
> +	info =3D open_ctree_fs_info(&oca);
>   	if (!info) {
>   		error("unable to open %s", argv[optind]);
>   		goto out;
> diff --git a/cmds/rescue.c b/cmds/rescue.c
> index 5551374d4b75..11f351f20ede 100644
> --- a/cmds/rescue.c
> +++ b/cmds/rescue.c
> @@ -233,7 +233,7 @@ static int cmd_rescue_fix_device_size(const struct c=
md_struct *cmd,
>   				      int argc, char **argv)
>   {
>   	struct btrfs_fs_info *fs_info;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args oca =3D { 0 };
>   	char *devname;
>   	int ret;
>
> @@ -254,9 +254,9 @@ static int cmd_rescue_fix_device_size(const struct c=
md_struct *cmd,
>   		goto out;
>   	}
>
> -	ocf.filename =3D devname;
> -	ocf.flags =3D OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
> -	fs_info =3D open_ctree_fs_info(&ocf);
> +	oca.filename =3D devname;
> +	oca.flags =3D OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
> +	fs_info =3D open_ctree_fs_info(&oca);
>   	if (!fs_info) {
>   		error("could not open btrfs");
>   		ret =3D -EIO;
> @@ -368,7 +368,7 @@ static int cmd_rescue_clear_uuid_tree(const struct c=
md_struct *cmd,
>   				      int argc, char **argv)
>   {
>   	struct btrfs_fs_info *fs_info;
> -	struct open_ctree_flags ocf =3D {};
> +	struct open_ctree_args oca =3D {};
>   	char *devname;
>   	int ret;
>
> @@ -387,9 +387,9 @@ static int cmd_rescue_clear_uuid_tree(const struct c=
md_struct *cmd,
>   		ret =3D -EBUSY;
>   		goto out;
>   	}
> -	ocf.filename =3D devname;
> -	ocf.flags =3D OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
> -	fs_info =3D open_ctree_fs_info(&ocf);
> +	oca.filename =3D devname;
> +	oca.flags =3D OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
> +	fs_info =3D open_ctree_fs_info(&oca);
>   	if (!fs_info) {
>   		error("could not open btrfs");
>   		ret =3D -EIO;
> diff --git a/cmds/restore.c b/cmds/restore.c
> index 9fe7b4d2d07d..7a3606457771 100644
> --- a/cmds/restore.c
> +++ b/cmds/restore.c
> @@ -1216,7 +1216,7 @@ static struct btrfs_root *open_fs(const char *dev,=
 u64 root_location,
>   {
>   	struct btrfs_fs_info *fs_info =3D NULL;
>   	struct btrfs_root *root =3D NULL;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args oca =3D { 0 };
>   	u64 bytenr;
>   	int i;
>
> @@ -1228,12 +1228,12 @@ static struct btrfs_root *open_fs(const char *de=
v, u64 root_location,
>   		 * in extent tree. Skip block group item search will allow
>   		 * restore to be executed on heavily damaged fs.
>   		 */
> -		ocf.filename =3D dev;
> -		ocf.sb_bytenr =3D bytenr;
> -		ocf.root_tree_bytenr =3D root_location;
> -		ocf.flags =3D OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS |
> +		oca.filename =3D dev;
> +		oca.sb_bytenr =3D bytenr;
> +		oca.root_tree_bytenr =3D root_location;
> +		oca.flags =3D OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS |
>   			    OPEN_CTREE_ALLOW_TRANSID_MISMATCH;
> -		fs_info =3D open_ctree_fs_info(&ocf);
> +		fs_info =3D open_ctree_fs_info(&oca);
>   		if (fs_info)
>   			break;
>   		pr_stderr(LOG_DEFAULT, "Could not open root, trying backup super\n")=
;
> diff --git a/image/main.c b/image/main.c
> index c175179e1515..42fd2854e9d4 100644
> --- a/image/main.c
> +++ b/image/main.c
> @@ -2795,12 +2795,12 @@ static int restore_metadump(const char *input, F=
ILE *out, int old_restore,
>
>   	/* NOTE: open with write mode */
>   	if (fixup_offset) {
> -		struct open_ctree_flags ocf =3D { 0 };
> +		struct open_ctree_args oca =3D { 0 };
>
> -		ocf.filename =3D target;
> -		ocf.flags =3D OPEN_CTREE_WRITES | OPEN_CTREE_RESTORE |
> +		oca.filename =3D target;
> +		oca.flags =3D OPEN_CTREE_WRITES | OPEN_CTREE_RESTORE |
>   			    OPEN_CTREE_PARTIAL | OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
> -		info =3D open_ctree_fs_info(&ocf);
> +		info =3D open_ctree_fs_info(&oca);
>   		if (!info) {
>   			error("open ctree failed");
>   			ret =3D -EIO;
> @@ -3223,15 +3223,15 @@ int BOX_MAIN(image)(int argc, char *argv[])
>
>   	 /* extended support for multiple devices */
>   	if (!create && multi_devices) {
> -		struct open_ctree_flags ocf =3D { 0 };
> +		struct open_ctree_args oca =3D { 0 };
>   		struct btrfs_fs_info *info;
>   		u64 total_devs;
>   		int i;
>
> -		ocf.filename =3D target;
> -		ocf.flags =3D OPEN_CTREE_PARTIAL | OPEN_CTREE_RESTORE |
> +		oca.filename =3D target;
> +		oca.flags =3D OPEN_CTREE_PARTIAL | OPEN_CTREE_RESTORE |
>   			OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
> -		info =3D open_ctree_fs_info(&ocf);
> +		info =3D open_ctree_fs_info(&oca);
>   		if (!info) {
>   			error("open ctree failed at %s", target);
>   			return 1;
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index 442d3af8bc01..4e7cc381471c 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -1437,7 +1437,7 @@ int btrfs_setup_chunk_tree_and_device_map(struct b=
trfs_fs_info *fs_info,
>   	return 0;
>   }
>
> -static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_=
flags *ocf)
> +static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_=
args *oca)
>   {
>   	struct btrfs_fs_info *fs_info;
>   	struct btrfs_super_block *disk_super;
> @@ -1446,8 +1446,8 @@ static struct btrfs_fs_info *__open_ctree_fd(int f=
p, struct open_ctree_flags *oc
>   	int ret;
>   	int oflags;
>   	unsigned sbflags =3D SBREAD_DEFAULT;
> -	unsigned flags =3D ocf->flags;
> -	u64 sb_bytenr =3D ocf->sb_bytenr;
> +	unsigned flags =3D oca->flags;
> +	u64 sb_bytenr =3D oca->sb_bytenr;
>
>   	if (sb_bytenr =3D=3D 0)
>   		sb_bytenr =3D BTRFS_SUPER_INFO_OFFSET;
> @@ -1491,7 +1491,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int f=
p, struct open_ctree_flags *oc
>   	if (flags & OPEN_CTREE_IGNORE_FSID_MISMATCH)
>   		sbflags |=3D SBREAD_IGNORE_FSID_MISMATCH;
>
> -	ret =3D btrfs_scan_fs_devices(fp, ocf->filename, &fs_devices, sb_byten=
r,
> +	ret =3D btrfs_scan_fs_devices(fp, oca->filename, &fs_devices, sb_byten=
r,
>   			sbflags, (flags & OPEN_CTREE_NO_DEVICES));
>   	if (ret)
>   		goto out;
> @@ -1559,7 +1559,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int f=
p, struct open_ctree_flags *oc
>   	if (fcntl(fp, F_GETFL) & O_DIRECT)
>   		fs_info->zoned =3D 1;
>
> -	ret =3D btrfs_setup_chunk_tree_and_device_map(fs_info, ocf->chunk_tree=
_bytenr);
> +	ret =3D btrfs_setup_chunk_tree_and_device_map(fs_info, oca->chunk_tree=
_bytenr);
>   	if (ret)
>   		goto out_chunk;
>
> @@ -1591,7 +1591,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int f=
p, struct open_ctree_flags *oc
>   			   btrfs_header_chunk_tree_uuid(eb),
>   			   BTRFS_UUID_SIZE);
>
> -	ret =3D btrfs_setup_all_roots(fs_info, ocf->root_tree_bytenr, flags);
> +	ret =3D btrfs_setup_all_roots(fs_info, oca->root_tree_bytenr, flags);
>   	if (ret && !(flags & __OPEN_CTREE_RETURN_CHUNK_ROOT) &&
>   	    !fs_info->ignore_chunk_tree_error)
>   		goto out_chunk;
> @@ -1608,7 +1608,7 @@ out:
>   	return NULL;
>   }
>
> -struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_flags *ocf)
> +struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *oca)
>   {
>   	int fp;
>   	int ret;
> @@ -1616,28 +1616,28 @@ struct btrfs_fs_info *open_ctree_fs_info(struct =
open_ctree_flags *ocf)
>   	int oflags =3D O_RDWR;
>   	struct stat st;
>
> -	ret =3D stat(ocf->filename, &st);
> +	ret =3D stat(oca->filename, &st);
>   	if (ret < 0) {
> -		error("cannot stat '%s': %m", ocf->filename);
> +		error("cannot stat '%s': %m", oca->filename);
>   		return NULL;
>   	}
>   	if (!(((st.st_mode & S_IFMT) =3D=3D S_IFREG) || ((st.st_mode & S_IFMT=
) =3D=3D S_IFBLK))) {
> -		error("not a regular file or block device: %s", ocf->filename);
> +		error("not a regular file or block device: %s", oca->filename);
>   		return NULL;
>   	}
>
> -	if (!(ocf->flags & OPEN_CTREE_WRITES))
> +	if (!(oca->flags & OPEN_CTREE_WRITES))
>   		oflags =3D O_RDONLY;
>
> -	if ((oflags & O_RDWR) && zoned_model(ocf->filename) =3D=3D ZONED_HOST_=
MANAGED)
> +	if ((oflags & O_RDWR) && zoned_model(oca->filename) =3D=3D ZONED_HOST_=
MANAGED)
>   		oflags |=3D O_DIRECT;
>
> -	fp =3D open(ocf->filename, oflags);
> +	fp =3D open(oca->filename, oflags);
>   	if (fp < 0) {
> -		error("cannot open '%s': %m", ocf->filename);
> +		error("cannot open '%s': %m", oca->filename);
>   		return NULL;
>   	}
> -	info =3D __open_ctree_fd(fp, ocf);
> +	info =3D __open_ctree_fd(fp, oca);
>   	close(fp);
>   	return info;
>   }
> @@ -1646,14 +1646,14 @@ struct btrfs_root *open_ctree(const char *filena=
me, u64 sb_bytenr,
>   			      unsigned flags)
>   {
>   	struct btrfs_fs_info *info;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args oca =3D { 0 };
>
>   	/* This flags may not return fs_info with any valid root */
>   	BUG_ON(flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR);
> -	ocf.filename =3D filename;
> -	ocf.sb_bytenr =3D sb_bytenr;
> -	ocf.flags =3D flags;
> -	info =3D open_ctree_fs_info(&ocf);
> +	oca.filename =3D filename;
> +	oca.sb_bytenr =3D sb_bytenr;
> +	oca.flags =3D flags;
> +	info =3D open_ctree_fs_info(&oca);
>   	if (!info)
>   		return NULL;
>   	if (flags & __OPEN_CTREE_RETURN_CHUNK_ROOT)
> @@ -1665,7 +1665,7 @@ struct btrfs_root *open_ctree_fd(int fp, const cha=
r *path, u64 sb_bytenr,
>   				 unsigned flags)
>   {
>   	struct btrfs_fs_info *info;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args oca =3D { 0 };
>
>   	/* This flags may not return fs_info with any valid root */
>   	if (flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR) {
> @@ -1673,10 +1673,10 @@ struct btrfs_root *open_ctree_fd(int fp, const c=
har *path, u64 sb_bytenr,
>   				(unsigned long long)flags);
>   		return NULL;
>   	}
> -	ocf.filename =3D path;
> -	ocf.sb_bytenr =3D sb_bytenr;
> -	ocf.flags =3D flags;
> -	info =3D __open_ctree_fd(fp, &ocf);
> +	oca.filename =3D path;
> +	oca.sb_bytenr =3D sb_bytenr;
> +	oca.flags =3D flags;
> +	info =3D __open_ctree_fd(fp, &oca);
>   	if (!info)
>   		return NULL;
>   	if (flags & __OPEN_CTREE_RETURN_CHUNK_ROOT)
> diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
> index 3a31667967cc..424b953e0363 100644
> --- a/kernel-shared/disk-io.h
> +++ b/kernel-shared/disk-io.h
> @@ -175,7 +175,7 @@ struct btrfs_root *open_ctree(const char *filename, =
u64 sb_bytenr,
>   			      unsigned flags);
>   struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_byte=
nr,
>   				 unsigned flags);
> -struct open_ctree_flags {
> +struct open_ctree_args {
>   	const char *filename;
>   	u64 sb_bytenr;
>   	u64 root_tree_bytenr;
> @@ -183,7 +183,7 @@ struct open_ctree_flags {
>   	unsigned flags;
>   };
>
> -struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_flags *ocf);
> +struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *oca);
>   int close_ctree_fs_info(struct btrfs_fs_info *fs_info);
>   static inline int close_ctree(struct btrfs_root *root)
>   {
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 7acd39ec6531..972ed1112ea6 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -990,7 +990,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	struct btrfs_root *root;
>   	struct btrfs_fs_info *fs_info;
>   	struct btrfs_trans_handle *trans;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args oca =3D { 0 };
>   	int ret =3D 0;
>   	int close_ret;
>   	int i;
> @@ -1569,9 +1569,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		goto error;
>   	}
>
> -	ocf.filename =3D file;
> -	ocf.flags =3D OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER;
> -	fs_info =3D open_ctree_fs_info(&ocf);
> +	oca.filename =3D file;
> +	oca.flags =3D OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER;
> +	fs_info =3D open_ctree_fs_info(&oca);
>   	if (!fs_info) {
>   		error("open ctree failed");
>   		goto error;
