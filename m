Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85539727722
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjFHGOo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjFHGOn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:14:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D45E11A
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686204876; x=1686809676; i=quwenruo.btrfs@gmx.com;
 bh=b4RTDzFZDDmWDeysXnmmxJdskdYn/Ilnhyh/71AJDoo=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=JWax+2nSNEj4gtawppujuZCDuLF3DyjIr9SnMu/fNySlEVYucGzWw+FEdGTGRekTE4XP3QK
 KmLAa0ZxH2orRyLdR83uTenE8y+6vf+H6nCTerclE+09nM7i2vsygLUWzy5QDAcpK+eE9HS7H
 9VSqendURlL6E/djzhpokEjW/O9/QAEn2QIEZEfRhr8GfR2z7QG+zbNxhm+IDX5cCaIzbaBXI
 bwrStPZuNRyOY3a89x2nx5slWWz9DHq950nhY8pZVQzyV4PV1r2oPNIk2oxTnmCK3RI7aoZAo
 FkJSqy93CizorGdMKayq1dGOwEcgUHkxXkq57DOOVvxBLnQernuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowGU-1pp5vR13Ne-00qPgM; Thu, 08
 Jun 2023 08:14:35 +0200
Message-ID: <ed6225ca-2580-de48-4d2e-bf637ead2993@gmx.com>
Date:   Thu, 8 Jun 2023 14:14:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/7] btrfs-progs: rename struct open_ctree_flags to
 open_ctree_args
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1686202417.git.anand.jain@oracle.com>
 <d6b012af9307b8ff71a3715e2e3d5cc58fafbee4.1686202417.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <d6b012af9307b8ff71a3715e2e3d5cc58fafbee4.1686202417.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JX0qvVvkAV+hAigJS1C8zc4RLLPtAynyElDk8vffo5Dbwl11Hq5
 DdeowPG3UU6IbSUKhW+tX2FOxBvEI9GWMI8lCsGUT9jyyHAosxAn5hsVFImOWFQb7UcKkNz
 +ZZibUzjvLDhJz+Gwn3MfqX7HsN+vTFi7elC/XBTNpjQUU3J6vVN/ZblTT3UaTYGCqafivH
 Eh2r3GXVOOhePBYoVmXbQ==
UI-OutboundReport: notjunk:1;M01:P0:WJQHETR+UJQ=;VBUzHHw/bIzKk/vqKPgTRwjJU9M
 tw/uJEOHbO9hbLdHtrO9fqq7QoOaJu3rPBl/zI5kUT30xZOkKgZsIUJBkel+0lOdThWFXOg8E
 20gEbnLiKq8tiNc7mUiKe/m8Qrpo6eXcIe2zWbj1AJgd7tcRCEjoxOvVkkzO/7ip4Taua4mw1
 GnO2IviX4rV7eQmS35nFDELZFqhHL5gCbUW27nOA6onyJ+/U5T1g1O45uhv8WZyEVX0RbwSIQ
 jn+4izX7wJg8GOIkb5PjtJ+UD4arKWTU3Jsu05ASa0AqPYng3/V4m49MB1k40u4a2Ypxpw82/
 ziHn7qEi0KerLijY0TBa94LACl/gncPda/xiyJdoQvcFlG4IFrYW5+x6SYYxXphXbKWfKNAoa
 gygyK7kwJE0+YcAOzw3IkpzGnMKuQfxRkuV98qcQrE+ZHk1DZo2/ggyBNEm2Jd44KkI0ePQgk
 zXxMhePAO3SdvZw51SX7+tdGtptoT2Z7MM11KO5U2QvcejO5aXJ4RH2AlVdDAdAHQGDcmY87N
 TQfEINRH9hmxtZb9nxdw+WRwTjvwFpyCTeTTctC+yTCPym9nhsX5mQRH5Mo/exgy4jXQfY0jU
 u0B5iWmjFI0kiYOy1C+LMo384k9IercC/QheIbrAK6PAsUO7RBHMWt3roqTrTwVwGYMd15oX5
 CXAzxjH/M4KKPMPbMjtQtVlxulBGabxWgFTXfBsSS3pJewtrlK/364MSvbR0gQNzi8y7P23pK
 2SDYJ9imLlWa7mvgLNT8fdVXJ1KsDuI1ZNEGFjLgCOMyLaEWDQl2NHSN/VFQ75zffA4o4JNC+
 6fdnDLEOtaNvOkeYrG0xbenLfnAVaA58LvjEGfwMO4FlEH3CbD52bglk+px4bk2/57XR3JcwY
 wNrQxENGN1wzJncEFB8IWZZg/6/5NuTm63Y1l5tZdUIoiJcC6+VSEXfICvSy7IvnDyN+gNUbW
 4dNfVja5NZonovdivlmDaRWDgCs=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 14:01, Anand Jain wrote:
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

I don't think this is a big deal.

Any LSP server and compiler can handle it correct.

Furthermore the rename would make a lot of @ocf variables loses its
meaning. (The patch doesn't rename it to oca).

To me, the better solution would be remove local variable
open_ctree_flags completely, and do all the flags setting using
ocf.flags instead.

Thanks,
Qu
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   btrfs-find-root.c        | 2 +-
>   check/main.c             | 2 +-
>   cmds/filesystem.c        | 2 +-
>   cmds/inspect-dump-tree.c | 2 +-
>   cmds/rescue.c            | 4 ++--
>   cmds/restore.c           | 2 +-
>   image/main.c             | 4 ++--
>   kernel-shared/disk-io.c  | 8 ++++----
>   kernel-shared/disk-io.h  | 4 ++--
>   mkfs/main.c              | 2 +-
>   10 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/btrfs-find-root.c b/btrfs-find-root.c
> index 398d7f216ee7..52041d82c182 100644
> --- a/btrfs-find-root.c
> +++ b/btrfs-find-root.c
> @@ -335,7 +335,7 @@ int main(int argc, char **argv)
>   	struct btrfs_find_root_filter filter =3D {0};
>   	struct cache_tree result;
>   	struct cache_extent *found;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args ocf =3D { 0 };
>   	int ret;
>
>   	/* Default to search root tree */
> diff --git a/check/main.c b/check/main.c
> index 7542b49f44f5..f7a2d446370a 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9983,7 +9983,7 @@ static int cmd_check(const struct cmd_struct *cmd,=
 int argc, char **argv)
>   {
>   	struct cache_tree root_cache;
>   	struct btrfs_root *root;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args ocf =3D { 0 };
>   	u64 bytenr =3D 0;
>   	u64 subvolid =3D 0;
>   	u64 tree_root_bytenr =3D 0;
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 47fd2377f5f4..c9e641b2fa9a 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -636,7 +636,7 @@ static int map_seed_devices(struct list_head *all_uu=
ids)
>   	fs_uuids =3D btrfs_scanned_uuids();
>
>   	list_for_each_entry(cur_fs, all_uuids, list) {
> -		struct open_ctree_flags ocf =3D { 0 };
> +		struct open_ctree_args ocf =3D { 0 };
>
>   		device =3D list_first_entry(&cur_fs->devices,
>   						struct btrfs_device, dev_list);
> diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
> index bfc0fff148dd..35920d14b7e9 100644
> --- a/cmds/inspect-dump-tree.c
> +++ b/cmds/inspect-dump-tree.c
> @@ -317,7 +317,7 @@ static int cmd_inspect_dump_tree(const struct cmd_st=
ruct *cmd,
>   	struct btrfs_disk_key disk_key;
>   	struct btrfs_key found_key;
>   	struct cache_tree block_root;	/* for multiple --block parameters */
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args ocf =3D { 0 };
>   	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
>   	int ret =3D 0;
>   	int slot;
> diff --git a/cmds/rescue.c b/cmds/rescue.c
> index 5551374d4b75..aee5446e66d0 100644
> --- a/cmds/rescue.c
> +++ b/cmds/rescue.c
> @@ -233,7 +233,7 @@ static int cmd_rescue_fix_device_size(const struct c=
md_struct *cmd,
>   				      int argc, char **argv)
>   {
>   	struct btrfs_fs_info *fs_info;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args ocf =3D { 0 };
>   	char *devname;
>   	int ret;
>
> @@ -368,7 +368,7 @@ static int cmd_rescue_clear_uuid_tree(const struct c=
md_struct *cmd,
>   				      int argc, char **argv)
>   {
>   	struct btrfs_fs_info *fs_info;
> -	struct open_ctree_flags ocf =3D {};
> +	struct open_ctree_args ocf =3D {};
>   	char *devname;
>   	int ret;
>
> diff --git a/cmds/restore.c b/cmds/restore.c
> index 9fe7b4d2d07d..aa78d0799c4a 100644
> --- a/cmds/restore.c
> +++ b/cmds/restore.c
> @@ -1216,7 +1216,7 @@ static struct btrfs_root *open_fs(const char *dev,=
 u64 root_location,
>   {
>   	struct btrfs_fs_info *fs_info =3D NULL;
>   	struct btrfs_root *root =3D NULL;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args ocf =3D { 0 };
>   	u64 bytenr;
>   	int i;
>
> diff --git a/image/main.c b/image/main.c
> index 50c3f2ca7db5..9e460e7076e7 100644
> --- a/image/main.c
> +++ b/image/main.c
> @@ -2795,7 +2795,7 @@ static int restore_metadump(const char *input, FIL=
E *out, int old_restore,
>
>   	/* NOTE: open with write mode */
>   	if (fixup_offset) {
> -		struct open_ctree_flags ocf =3D { 0 };
> +		struct open_ctree_args ocf =3D { 0 };
>
>   		ocf.filename =3D target;
>   		ocf.flags =3D OPEN_CTREE_WRITES | OPEN_CTREE_RESTORE |
> @@ -3223,7 +3223,7 @@ int BOX_MAIN(image)(int argc, char *argv[])
>
>   	 /* extended support for multiple devices */
>   	if (!create && multi_devices) {
> -		struct open_ctree_flags ocf =3D { 0 };
> +		struct open_ctree_args ocf =3D { 0 };
>   		struct btrfs_fs_info *info;
>   		u64 total_devs;
>   		int i;
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index 442d3af8bc01..3b709b2c0f7f 100644
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
args *ocf)
>   {
>   	struct btrfs_fs_info *fs_info;
>   	struct btrfs_super_block *disk_super;
> @@ -1608,7 +1608,7 @@ out:
>   	return NULL;
>   }
>
> -struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_flags *ocf)
> +struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *ocf)
>   {
>   	int fp;
>   	int ret;
> @@ -1646,7 +1646,7 @@ struct btrfs_root *open_ctree(const char *filename=
, u64 sb_bytenr,
>   			      unsigned flags)
>   {
>   	struct btrfs_fs_info *info;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args ocf =3D { 0 };
>
>   	/* This flags may not return fs_info with any valid root */
>   	BUG_ON(flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR);
> @@ -1665,7 +1665,7 @@ struct btrfs_root *open_ctree_fd(int fp, const cha=
r *path, u64 sb_bytenr,
>   				 unsigned flags)
>   {
>   	struct btrfs_fs_info *info;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args ocf =3D { 0 };
>
>   	/* This flags may not return fs_info with any valid root */
>   	if (flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR) {
> diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
> index 3a31667967cc..93572c4297ad 100644
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
> +struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *ctree_=
args);
>   int close_ctree_fs_info(struct btrfs_fs_info *fs_info);
>   static inline int close_ctree(struct btrfs_root *root)
>   {
> diff --git a/mkfs/main.c b/mkfs/main.c
> index a31b32c644c9..23db58b7186d 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -990,7 +990,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	struct btrfs_root *root;
>   	struct btrfs_fs_info *fs_info;
>   	struct btrfs_trans_handle *trans;
> -	struct open_ctree_flags ocf =3D { 0 };
> +	struct open_ctree_args ocf =3D { 0 };
>   	int ret =3D 0;
>   	int close_ret;
>   	int i;
