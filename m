Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7133C436E50
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 01:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJUX3U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 19:29:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:58125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhJUX3T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 19:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634858818;
        bh=KrKaItywiHnUyKHDJshjfWwITaAvfrseoy6pbVE1NWg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=J2+MqPSH6cgKf+3YJ/R/g1qwqsT1w/a2ZTUkgu8wuOoJM2TiJMradunXLRzaln/hv
         GLINrvceSOzHy/KDmUSRuTlo6A3Vd4iBdO68nOrpgRa3dcoaIlinywFuDh3YYgH83R
         tlmwBq983J8UsN0HOVUpwXFuwyxwe9Yt6mV9vKu4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4hzj-1mncub0Buh-011n07; Fri, 22
 Oct 2021 01:26:58 +0200
Message-ID: <b288f28c-45f4-394a-e8a3-a18b06458e7e@gmx.com>
Date:   Fri, 22 Oct 2021 07:26:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/7] btrfs: use btrfs_item_size_nr/btrfs_item_offset_nr
 everywhere
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1634842475.git.josef@toxicpanda.com>
 <b64b018e55c848bcc78b2f8bd8f6db01d0c93685.1634842475.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b64b018e55c848bcc78b2f8bd8f6db01d0c93685.1634842475.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7v6HYmmAKS3499VFKY2T1hPwOuzgZ0ndft4X6NA8L16I7TVtR/c
 XgEHnNaasIuZ0BwboUK6G8RpB33IDTKwfOfsoOCAr4mx+J1PZPCE1cXqw7S4kSoJeP72cFr
 9IRm5q6p9XmRKkPNdwih/4xkI9d+FTp/RU37t0QLoNtiFEozMo0qKbut1+QEzmUwwhPgNe5
 ACJAWaZd6Bp0baF8HE1Sw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HNrKLo45MwE=:BcdMnaaDK/TQpuGmt2s55z
 SojmD/ELDLOjbG0BdGfyQ0/e51+CngpbFke9IZXogab060zjYB1rJLnpKBzkRNRuWi+1UKWdF
 aoW4Y9lXhgLuF+QxOed8Gl5rEqOmi/ieJSxeEn4yT3a2WxROZ4tjQfFvS13tA2sTVIEp0aHfR
 EC6EtdhQhmaRDSYbdc9hPttSodj7VgqI+/by+ma/UwpJ32eLG3GVsJRdra7HyMcZWBhZa65wr
 ZXv1x/Jkp8wi94d7xmkhFPrEvMU+wuzMub6w0tyCOHL7ASfeKceIsiE++yMhsY5oU3bvUUqG3
 RTMPm/PmuqqGEfl/KYwYXHrZZvoJCucVAjXsGPcpRMJavsDmwvh5Sw9+pvk5wrwzdskpJbwY/
 FSFTQrtUFdO8Q0qyUh6YsOnU2IHqIdk5KScuiDTGPovLEZaQxpxTpGacxlTBFNz/2Uj/hIwGG
 rJ3yOWa3Yk2CTyZsObvi7sgQt661n3VM6IJ7Zina9LPv90GuYADD7n790bO6i7BopgHwrJiji
 tA7dkS6ZHHPN9U3H79uNyyzREHCwIBTSm4WkUdoTl7i5jOHYCA2Yhh/ZhPgPWEfJbOoPwb626
 NnOu4tkyysXrBE2+plwBuJ2wgj3qNy2hruvbx/Ki+YGbV2okyn2Tn3RJ09FL5r7NAOs9xdz1M
 Y/HOtep6AENjmix+3i+Lpf6DCxKL9t6M+2U9YBBxMwMBQ1MbpUb85BhxMwWYNKuOhY1NPz89Q
 C+4T6m85zT0g4nvAzRXEnQ/k+D8rMap6hQWIrtvgFooXvjg0aeN8pvq9jQKSe3cC5qaCoaItZ
 TqWOrccGLpFfX9dzCV1rGnXZNSY3CtBT8xkr4TaDj+/mjXcLqJrqOGGixUK+mGsEkp1JHhTIN
 kgvX2uw2VQux9q29DcbSZeWZPyEvoDRAuOVe+lgmFtWMSfAEw0KXEy8j7k6+/fqe+blXzawhr
 cvpH0/1cYCnEpFpVOA7AVg98u2aqQ59FqeBhX8TloEXa13LAZ1AXBr0q/POGZ61Qm+vcu+YiC
 uxXE+00fjT63bWDBMIlaqDrBf/tmYSp5RMFTsZtpnNQr8lYIj8yLStBlTlwYYq5bt4/syVcM/
 ocNkKxv1xwjkSM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/22 02:58, Josef Bacik wrote:
> We have this pattern in a lot of places
>
> item =3D btrfs_item_nr(slot);
> btrfs_item_size(leaf, item);
>
> when we could simply use
>
> btrfs_item_size(leaf, slot);
>
> Fix all callers of btrfs_item_size() and btrfs_item_offset() to use the
> _nr variation of the helpers.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Yeah, for such simple structure (only key + offset + size), there is
really no need to use item potiner.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/backref.c                   |  4 +---
>   fs/btrfs/ctree.c                     | 22 +++++++---------------
>   fs/btrfs/dir-item.c                  |  6 ++----
>   fs/btrfs/inode-item.c                |  4 +---
>   fs/btrfs/print-tree.c                |  4 +---
>   fs/btrfs/send.c                      |  8 ++------
>   fs/btrfs/tests/extent-buffer-tests.c | 17 +++++------------
>   fs/btrfs/xattr.c                     |  4 +---
>   8 files changed, 20 insertions(+), 49 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index f735b8798ba1..8066b524916c 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2058,7 +2058,6 @@ static int iterate_inode_refs(u64 inum, struct btr=
fs_root *fs_root,
>   	u64 parent =3D 0;
>   	int found =3D 0;
>   	struct extent_buffer *eb;
> -	struct btrfs_item *item;
>   	struct btrfs_inode_ref *iref;
>   	struct btrfs_key found_key;
>
> @@ -2084,10 +2083,9 @@ static int iterate_inode_refs(u64 inum, struct bt=
rfs_root *fs_root,
>   		}
>   		btrfs_release_path(path);
>
> -		item =3D btrfs_item_nr(slot);
>   		iref =3D btrfs_item_ptr(eb, slot, struct btrfs_inode_ref);
>
> -		for (cur =3D 0; cur < btrfs_item_size(eb, item); cur +=3D len) {
> +		for (cur =3D 0; cur < btrfs_item_size_nr(eb, slot); cur +=3D len) {
>   			name_len =3D btrfs_inode_ref_name_len(eb, iref);
>   			/* path must be released before calling iterate()! */
>   			btrfs_debug(fs_root->fs_info,
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 74c8e18f3720..ec8b1266fd92 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2614,19 +2614,15 @@ static noinline int split_node(struct btrfs_tran=
s_handle *trans,
>    */
>   static int leaf_space_used(struct extent_buffer *l, int start, int nr)
>   {
> -	struct btrfs_item *start_item;
> -	struct btrfs_item *end_item;
>   	int data_len;
>   	int nritems =3D btrfs_header_nritems(l);
>   	int end =3D min(nritems, start + nr) - 1;
>
>   	if (!nr)
>   		return 0;
> -	start_item =3D btrfs_item_nr(start);
> -	end_item =3D btrfs_item_nr(end);
> -	data_len =3D btrfs_item_offset(l, start_item) +
> -		   btrfs_item_size(l, start_item);
> -	data_len =3D data_len - btrfs_item_offset(l, end_item);
> +	data_len =3D btrfs_item_offset_nr(l, start) +
> +		   btrfs_item_size_nr(l, start);
> +	data_len =3D data_len - btrfs_item_offset_nr(l, end);
>   	data_len +=3D sizeof(struct btrfs_item) * nr;
>   	WARN_ON(data_len < 0);
>   	return data_len;
> @@ -2690,8 +2686,6 @@ static noinline int __push_leaf_right(struct btrfs=
_path *path,
>   	slot =3D path->slots[1];
>   	i =3D left_nritems - 1;
>   	while (i >=3D nr) {
> -		item =3D btrfs_item_nr(i);
> -
>   		if (!empty && push_items > 0) {
>   			if (path->slots[0] > i)
>   				break;
> @@ -2706,7 +2700,7 @@ static noinline int __push_leaf_right(struct btrfs=
_path *path,
>   		if (path->slots[0] =3D=3D i)
>   			push_space +=3D data_size;
>
> -		this_item_size =3D btrfs_item_size(left, item);
> +		this_item_size =3D btrfs_item_size_nr(left, i);
>   		if (this_item_size + sizeof(*item) + push_space > free_space)
>   			break;
>
> @@ -2917,8 +2911,6 @@ static noinline int __push_leaf_left(struct btrfs_=
path *path, int data_size,
>   		nr =3D min(right_nritems - 1, max_slot);
>
>   	for (i =3D 0; i < nr; i++) {
> -		item =3D btrfs_item_nr(i);
> -
>   		if (!empty && push_items > 0) {
>   			if (path->slots[0] < i)
>   				break;
> @@ -2933,7 +2925,7 @@ static noinline int __push_leaf_left(struct btrfs_=
path *path, int data_size,
>   		if (path->slots[0] =3D=3D i)
>   			push_space +=3D data_size;
>
> -		this_item_size =3D btrfs_item_size(right, item);
> +		this_item_size =3D btrfs_item_size_nr(right, i);
>   		if (this_item_size + sizeof(*item) + push_space > free_space)
>   			break;
>
> @@ -3500,8 +3492,8 @@ static noinline int split_item(struct btrfs_path *=
path,
>   	BUG_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item));
>
>   	item =3D btrfs_item_nr(path->slots[0]);
> -	orig_offset =3D btrfs_item_offset(leaf, item);
> -	item_size =3D btrfs_item_size(leaf, item);
> +	orig_offset =3D btrfs_item_offset_nr(leaf, path->slots[0]);
> +	item_size =3D btrfs_item_size_nr(leaf, path->slots[0]);
>
>   	buf =3D kmalloc(item_size, GFP_NOFS);
>   	if (!buf)
> diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
> index 7721ce0c0604..7f46c42a26fa 100644
> --- a/fs/btrfs/dir-item.c
> +++ b/fs/btrfs/dir-item.c
> @@ -27,7 +27,6 @@ static struct btrfs_dir_item *insert_with_overflow(str=
uct btrfs_trans_handle
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	int ret;
>   	char *ptr;
> -	struct btrfs_item *item;
>   	struct extent_buffer *leaf;
>
>   	ret =3D btrfs_insert_empty_item(trans, root, path, cpu_key, data_size=
);
> @@ -41,10 +40,9 @@ static struct btrfs_dir_item *insert_with_overflow(st=
ruct btrfs_trans_handle
>   		return ERR_PTR(ret);
>   	WARN_ON(ret > 0);
>   	leaf =3D path->nodes[0];
> -	item =3D btrfs_item_nr(path->slots[0]);
>   	ptr =3D btrfs_item_ptr(leaf, path->slots[0], char);
> -	BUG_ON(data_size > btrfs_item_size(leaf, item));
> -	ptr +=3D btrfs_item_size(leaf, item) - data_size;
> +	ASSERT(data_size <=3D btrfs_item_size_nr(leaf, path->slots[0]));
> +	ptr +=3D btrfs_item_size_nr(leaf, path->slots[0]) - data_size;
>   	return (struct btrfs_dir_item *)ptr;
>   }
>
> diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
> index 37f36ffdaf6b..65111c484d15 100644
> --- a/fs/btrfs/inode-item.c
> +++ b/fs/btrfs/inode-item.c
> @@ -256,7 +256,6 @@ static int btrfs_insert_inode_extref(struct btrfs_tr=
ans_handle *trans,
>   	struct btrfs_path *path;
>   	struct btrfs_key key;
>   	struct extent_buffer *leaf;
> -	struct btrfs_item *item;
>
>   	key.objectid =3D inode_objectid;
>   	key.type =3D BTRFS_INODE_EXTREF_KEY;
> @@ -282,9 +281,8 @@ static int btrfs_insert_inode_extref(struct btrfs_tr=
ans_handle *trans,
>   		goto out;
>
>   	leaf =3D path->nodes[0];
> -	item =3D btrfs_item_nr(path->slots[0]);
>   	ptr =3D (unsigned long)btrfs_item_ptr(leaf, path->slots[0], char);
> -	ptr +=3D btrfs_item_size(leaf, item) - ins_len;
> +	ptr +=3D btrfs_item_size_nr(leaf, path->slots[0]) - ins_len;
>   	extref =3D (struct btrfs_inode_extref *)ptr;
>
>   	btrfs_set_inode_extref_name_len(path->nodes[0], extref, name_len);
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index aae1027bd76a..52370af39afe 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -200,7 +200,6 @@ void btrfs_print_leaf(struct extent_buffer *l)
>   	struct btrfs_fs_info *fs_info;
>   	int i;
>   	u32 type, nr;
> -	struct btrfs_item *item;
>   	struct btrfs_root_item *ri;
>   	struct btrfs_dir_item *di;
>   	struct btrfs_inode_item *ii;
> @@ -224,12 +223,11 @@ void btrfs_print_leaf(struct extent_buffer *l)
>   		   btrfs_leaf_free_space(l), btrfs_header_owner(l));
>   	print_eb_refs_lock(l);
>   	for (i =3D 0 ; i < nr ; i++) {
> -		item =3D btrfs_item_nr(i);
>   		btrfs_item_key_to_cpu(l, &key, i);
>   		type =3D key.type;
>   		pr_info("\titem %d key (%llu %u %llu) itemoff %d itemsize %d\n",
>   			i, key.objectid, type, key.offset,
> -			btrfs_item_offset(l, item), btrfs_item_size(l, item));
> +			btrfs_item_offset_nr(l, i), btrfs_item_size_nr(l, i));
>   		switch (type) {
>   		case BTRFS_INODE_ITEM_KEY:
>   			ii =3D btrfs_item_ptr(l, i, struct btrfs_inode_item);
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index afdcbe7844e0..e15f18dec9a6 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -886,7 +886,6 @@ static int iterate_inode_ref(struct btrfs_root *root=
, struct btrfs_path *path,
>   			     iterate_inode_ref_t iterate, void *ctx)
>   {
>   	struct extent_buffer *eb =3D path->nodes[0];
> -	struct btrfs_item *item;
>   	struct btrfs_inode_ref *iref;
>   	struct btrfs_inode_extref *extref;
>   	struct btrfs_path *tmp_path;
> @@ -918,8 +917,7 @@ static int iterate_inode_ref(struct btrfs_root *root=
, struct btrfs_path *path,
>   	if (found_key->type =3D=3D BTRFS_INODE_REF_KEY) {
>   		ptr =3D (unsigned long)btrfs_item_ptr(eb, slot,
>   						    struct btrfs_inode_ref);
> -		item =3D btrfs_item_nr(slot);
> -		total =3D btrfs_item_size(eb, item);
> +		total =3D btrfs_item_size_nr(eb, slot);
>   		elem_size =3D sizeof(*iref);
>   	} else {
>   		ptr =3D btrfs_item_ptr_offset(eb, slot);
> @@ -1006,7 +1004,6 @@ static int iterate_dir_item(struct btrfs_root *roo=
t, struct btrfs_path *path,
>   {
>   	int ret =3D 0;
>   	struct extent_buffer *eb;
> -	struct btrfs_item *item;
>   	struct btrfs_dir_item *di;
>   	struct btrfs_key di_key;
>   	char *buf =3D NULL;
> @@ -1035,11 +1032,10 @@ static int iterate_dir_item(struct btrfs_root *r=
oot, struct btrfs_path *path,
>
>   	eb =3D path->nodes[0];
>   	slot =3D path->slots[0];
> -	item =3D btrfs_item_nr(slot);
>   	di =3D btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
>   	cur =3D 0;
>   	len =3D 0;
> -	total =3D btrfs_item_size(eb, item);
> +	total =3D btrfs_item_size_nr(eb, slot);
>
>   	num =3D 0;
>   	while (cur < total) {
> diff --git a/fs/btrfs/tests/extent-buffer-tests.c b/fs/btrfs/tests/exten=
t-buffer-tests.c
> index 2a95f7224e18..bbef99175564 100644
> --- a/fs/btrfs/tests/extent-buffer-tests.c
> +++ b/fs/btrfs/tests/extent-buffer-tests.c
> @@ -15,7 +15,6 @@ static int test_btrfs_split_item(u32 sectorsize, u32 n=
odesize)
>   	struct btrfs_path *path =3D NULL;
>   	struct btrfs_root *root =3D NULL;
>   	struct extent_buffer *eb;
> -	struct btrfs_item *item;
>   	char *value =3D "mary had a little lamb";
>   	char *split1 =3D "mary had a little";
>   	char *split2 =3D " lamb";
> @@ -61,7 +60,6 @@ static int test_btrfs_split_item(u32 sectorsize, u32 n=
odesize)
>   	key.offset =3D 0;
>
>   	btrfs_setup_item_for_insert(root, path, &key, value_len);
> -	item =3D btrfs_item_nr(0);
>   	write_extent_buffer(eb, value, btrfs_item_ptr_offset(eb, 0),
>   			    value_len);
>
> @@ -90,8 +88,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 n=
odesize)
>   		goto out;
>   	}
>
> -	item =3D btrfs_item_nr(0);
> -	if (btrfs_item_size(eb, item) !=3D strlen(split1)) {
> +	if (btrfs_item_size_nr(eb, 0) !=3D strlen(split1)) {
>   		test_err("invalid len in the first split");
>   		ret =3D -EINVAL;
>   		goto out;
> @@ -115,8 +112,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32=
 nodesize)
>   		goto out;
>   	}
>
> -	item =3D btrfs_item_nr(1);
> -	if (btrfs_item_size(eb, item) !=3D strlen(split2)) {
> +	if (btrfs_item_size_nr(eb, 1) !=3D strlen(split2)) {
>   		test_err("invalid len in the second split");
>   		ret =3D -EINVAL;
>   		goto out;
> @@ -147,8 +143,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32=
 nodesize)
>   		goto out;
>   	}
>
> -	item =3D btrfs_item_nr(0);
> -	if (btrfs_item_size(eb, item) !=3D strlen(split3)) {
> +	if (btrfs_item_size_nr(eb, 0) !=3D strlen(split3)) {
>   		test_err("invalid len in the first split");
>   		ret =3D -EINVAL;
>   		goto out;
> @@ -171,8 +166,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32=
 nodesize)
>   		goto out;
>   	}
>
> -	item =3D btrfs_item_nr(1);
> -	if (btrfs_item_size(eb, item) !=3D strlen(split4)) {
> +	if (btrfs_item_size_nr(eb, 1) !=3D strlen(split4)) {
>   		test_err("invalid len in the second split");
>   		ret =3D -EINVAL;
>   		goto out;
> @@ -195,8 +189,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32=
 nodesize)
>   		goto out;
>   	}
>
> -	item =3D btrfs_item_nr(2);
> -	if (btrfs_item_size(eb, item) !=3D strlen(split2)) {
> +	if (btrfs_item_size_nr(eb, 2) !=3D strlen(split2)) {
>   		test_err("invalid len in the second split");
>   		ret =3D -EINVAL;
>   		goto out;
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 2837b4c8424d..0f04bb7f3ce4 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -170,7 +170,6 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans,=
 struct inode *inode,
>   		const u16 old_data_len =3D btrfs_dir_data_len(leaf, di);
>   		const u32 item_size =3D btrfs_item_size_nr(leaf, slot);
>   		const u32 data_size =3D sizeof(*di) + name_len + size;
> -		struct btrfs_item *item;
>   		unsigned long data_ptr;
>   		char *ptr;
>
> @@ -196,9 +195,8 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans,=
 struct inode *inode,
>   			btrfs_extend_item(path, data_size);
>   		}
>
> -		item =3D btrfs_item_nr(slot);
>   		ptr =3D btrfs_item_ptr(leaf, slot, char);
> -		ptr +=3D btrfs_item_size(leaf, item) - data_size;
> +		ptr +=3D btrfs_item_size_nr(leaf, slot) - data_size;
>   		di =3D (struct btrfs_dir_item *)ptr;
>   		btrfs_set_dir_data_len(leaf, di, size);
>   		data_ptr =3D ((unsigned long)(di + 1)) + name_len;
>
