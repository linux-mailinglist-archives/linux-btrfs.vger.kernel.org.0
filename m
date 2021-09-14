Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF74B40A246
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 03:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhINBDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 21:03:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:46679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236261AbhINBDi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 21:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631581339;
        bh=8cTdXr/ott1Oos3ab+gX5wzfDlrjHm3jq2KtPXGWWkU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Sg+TMhniko7bQDVg0MmPTfb/UeL2T2UjxN3/CSlCj+qDrqTp2c/BzAS5+7TUJ57to
         oqxxC+yotGOLEUOzO7o4TqSLCQQAEOUGqvavbUb96B9/ee5ESxyqoCEr/md/ixeQFb
         oiMj2CJFdxyxekwd40v5BUOEIubTy2GyZIlqUwqY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmDEm-1mqAqw3x3I-00iFBg; Tue, 14
 Sep 2021 03:02:19 +0200
Subject: Re: [PATCH 3/8] btrfs-progs: Remove fs_info argument from
 leaf_data_end
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210913131729.37897-1-nborisov@suse.com>
 <20210913131729.37897-4-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <88dda6c7-02a3-796e-39be-a121634ac1bd@gmx.com>
Date:   Tue, 14 Sep 2021 09:02:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913131729.37897-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uHYOpJP0zPQg9V6x3+aliEd5GyZuTpFj42lO8CBtz2aDUOBPSOC
 Gy5xgfBjhE+NN7O2a1AfjCGm2rhB/c2lZUgkKJjz9GIlknb+oDLUaRx4FwP9XviftzPjHVL
 P28jlK3o2RStmxkctCkRquxu23B3eA91xHv73RBeuPmGKjPAcpP74KS8jsno6+hANKD2Qd1
 quMjxiJgH7A5l/VNasw3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9PgCjjuQpFk=:ZuuJnBMXJv67PQvjRnVEqM
 UQOpQcTa98olTyyF5ybhSSWkwNjnXUnGnwQmjHynKPj4Ygms5pMkQjTiZMtGbxkoPXICiaxE6
 xCdimb21u4XB3J6iIGhJfryVEK3MjfkmWPggeXsbQraZLR+5nSSLeMjmJwGUCZDwDlXP+PeLk
 3LAuSq87DPeThgn0YtoJgyu+US0FSVtDp3eZWNysOks7MLe5AhksetO1HhPfC98T1BmrWqQwX
 TZcmEyTZVYI21MbMEVGRBEtoMtMvoyYlK7RmPrrfmp2Z0huOeEbQoOYPZpuo9afBM0EHC/nXv
 Emw+3ghwwCkLhKce7M/Klxlxxca0tvkgzc4UMqFwdVdjH4zV+XTCEFfROqwlTIPOSNgV3GCXB
 yoNAPRPNlqGUfgUcjNZGp6GmAQM9+QixJJx7/c4NmXd1cX+o2PxG4sBjhK4x48na/HH51dKNh
 HgiFpmCTd+WRsidTGVPkbN2YLg2hxDQopmTcF8hEpOQO4LINMF3keJX7CM6lW0aMGAj2NLfO1
 +KqEVLyzDj4kgqHvqdLfJDz3l9Jhpg6DOSMP/Cz1e9Sz/53ojxy3i9lTWh5uLu9P9KaBIbpvn
 RsSjyS/2V+VYmqYdb9L79Q+XHelb3HUv5FfggE6MN6SqIEPJCNZ6BJCZv5TTKsGkM6v6IK+8j
 2FzW7uMwzcpdrEjRX111BCAPKYhrGn0UeZ9gVTkJnByJhgmzn+8yA0TYmdzD5aQ4ftMt93U3v
 PW4VbEHYzgB2F1z1/dbSPdZtwnb1mDS86LgRqGyHHeBaeYFQ/CRZZvOrZu/0wR359ARJpIDM2
 6cliNIT8tKNDFK3PBuxHwLAONluz/SPqxM1WIXYPpuV8ta5i8IEHj7ttxf4Y4W1z3pMmq6kgz
 2zuk8iXbjmk18uGSa0aWn2mtGk9G2BGaUo621QEOWJgyOymsVnJ2+6RN3OtQFgrQxuCvZmcAL
 /U/2jjNok/Vf115rxWwdDKGYfldH8pV18UORO7H6Qe3P+QyhIHJewhXmYSXfEyaRrdRf94VcZ
 SM9MqOVX+fD6WjzXjvR43ryTXylB6ZJoobrG5AmbaSS/f8BePyOYmyeLFlDU9Kz2Hws96B2VA
 87/SX6ZUtxCDH4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/13 =E4=B8=8B=E5=8D=889:17, Nikolay Borisov wrote:
> The function already takes an extent_buffer which has a reference to
> the owning filesystem's fs_info. This also brings the function in line
> with the kernel's signature.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   kernel-shared/ctree.c | 35 +++++++++++++++--------------------
>   1 file changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
> index 02eb975338e5..77766c2a7931 100644
> --- a/kernel-shared/ctree.c
> +++ b/kernel-shared/ctree.c
> @@ -557,12 +557,11 @@ static int btrfs_comp_keys(struct btrfs_disk_key *=
disk,
>    * this returns the address of the start of the last item,
>    * which is the stop of the leaf data stack
>    */
> -static inline unsigned int leaf_data_end(const struct btrfs_fs_info *fs=
_info,
> -					 const struct extent_buffer *leaf)
> +static inline unsigned int leaf_data_end(const struct extent_buffer *le=
af)
>   {
>   	u32 nr =3D btrfs_header_nritems(leaf);
>   	if (nr =3D=3D 0)
> -		return BTRFS_LEAF_DATA_SIZE(fs_info);
> +		return BTRFS_LEAF_DATA_SIZE(leaf->fs_info);
>   	return btrfs_item_offset_nr(leaf, nr - 1);
>   }
>
> @@ -1980,10 +1979,10 @@ static int push_leaf_right(struct btrfs_trans_ha=
ndle *trans, struct btrfs_root
>   	right_nritems =3D btrfs_header_nritems(right);
>
>   	push_space =3D btrfs_item_end_nr(left, left_nritems - push_items);
> -	push_space -=3D leaf_data_end(fs_info, left);
> +	push_space -=3D leaf_data_end(left);
>
>   	/* make room in the right data area */
> -	data_end =3D leaf_data_end(fs_info, right);
> +	data_end =3D leaf_data_end(right);
>   	memmove_extent_buffer(right,
>   			      btrfs_leaf_data(right) + data_end - push_space,
>   			      btrfs_leaf_data(right) + data_end,
> @@ -1992,8 +1991,7 @@ static int push_leaf_right(struct btrfs_trans_hand=
le *trans, struct btrfs_root
>   	/* copy from the left data area */
>   	copy_extent_buffer(right, left, btrfs_leaf_data(right) +
>   		     BTRFS_LEAF_DATA_SIZE(root->fs_info) - push_space,
> -		     btrfs_leaf_data(left) + leaf_data_end(fs_info, left),
> -		     push_space);
> +		     btrfs_leaf_data(left) + leaf_data_end(left), push_space);
>
>   	memmove_extent_buffer(right, btrfs_item_nr_offset(push_items),
>   			      btrfs_item_nr_offset(0),
> @@ -2130,7 +2128,7 @@ static int push_leaf_left(struct btrfs_trans_handl=
e *trans, struct btrfs_root
>   		     btrfs_item_offset_nr(right, push_items -1);
>
>   	copy_extent_buffer(left, right, btrfs_leaf_data(left) +
> -		     leaf_data_end(fs_info, left) - push_space,
> +		     leaf_data_end(left) - push_space,
>   		     btrfs_leaf_data(right) +
>   		     btrfs_item_offset_nr(right, push_items - 1),
>   		     push_space);
> @@ -2157,13 +2155,12 @@ static int push_leaf_left(struct btrfs_trans_han=
dle *trans, struct btrfs_root
>
>   	if (push_items < right_nritems) {
>   		push_space =3D btrfs_item_offset_nr(right, push_items - 1) -
> -						  leaf_data_end(fs_info, right);
> +						  leaf_data_end(right);
>   		memmove_extent_buffer(right, btrfs_leaf_data(right) +
>   				      BTRFS_LEAF_DATA_SIZE(root->fs_info) -
>   				      push_space,
>   				      btrfs_leaf_data(right) +
> -				      leaf_data_end(fs_info, right),
> -				      push_space);
> +				      leaf_data_end(right), push_space);
>
>   		memmove_extent_buffer(right, btrfs_item_nr_offset(0),
>   			      btrfs_item_nr_offset(push_items),
> @@ -2222,8 +2219,7 @@ static noinline int copy_for_split(struct btrfs_tr=
ans_handle *trans,
>
>   	nritems =3D nritems - mid;
>   	btrfs_set_header_nritems(right, nritems);
> -	data_copy_size =3D btrfs_item_end_nr(l, mid) -
> -		leaf_data_end(root->fs_info, l);
> +	data_copy_size =3D btrfs_item_end_nr(l, mid) - leaf_data_end(l);
>
>   	copy_extent_buffer(right, l, btrfs_item_nr_offset(0),
>   			   btrfs_item_nr_offset(mid),
> @@ -2231,9 +2227,8 @@ static noinline int copy_for_split(struct btrfs_tr=
ans_handle *trans,
>
>   	copy_extent_buffer(right, l,
>   		     btrfs_leaf_data(right) +
> -		     BTRFS_LEAF_DATA_SIZE(root->fs_info) -
> -		     data_copy_size, btrfs_leaf_data(l) +
> -		     leaf_data_end(root->fs_info, l), data_copy_size);
> +		     BTRFS_LEAF_DATA_SIZE(root->fs_info) - data_copy_size,
> +			 btrfs_leaf_data(l) + leaf_data_end(l), data_copy_size);
>
>   	rt_data_off =3D BTRFS_LEAF_DATA_SIZE(root->fs_info) -
>   		      btrfs_item_end_nr(l, mid);
> @@ -2572,7 +2567,7 @@ int btrfs_truncate_item(struct btrfs_root *root, s=
truct btrfs_path *path,
>   		return 0;
>
>   	nritems =3D btrfs_header_nritems(leaf);
> -	data_end =3D leaf_data_end(root->fs_info, leaf);
> +	data_end =3D leaf_data_end(leaf);
>
>   	old_data_start =3D btrfs_item_offset_nr(leaf, slot);
>
> @@ -2661,7 +2656,7 @@ int btrfs_extend_item(struct btrfs_root *root, str=
uct btrfs_path *path,
>   	leaf =3D path->nodes[0];
>
>   	nritems =3D btrfs_header_nritems(leaf);
> -	data_end =3D leaf_data_end(root->fs_info, leaf);
> +	data_end =3D leaf_data_end(leaf);
>
>   	if (btrfs_leaf_free_space(leaf) < data_size) {
>   		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
> @@ -2747,7 +2742,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_ha=
ndle *trans,
>   	leaf =3D path->nodes[0];
>
>   	nritems =3D btrfs_header_nritems(leaf);
> -	data_end =3D leaf_data_end(root->fs_info, leaf);
> +	data_end =3D leaf_data_end(leaf);
>
>   	if (btrfs_leaf_free_space(leaf) < total_size) {
>   		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
> @@ -2940,7 +2935,7 @@ int btrfs_del_items(struct btrfs_trans_handle *tra=
ns, struct btrfs_root *root,
>   	nritems =3D btrfs_header_nritems(leaf);
>
>   	if (slot + nr !=3D nritems) {
> -		int data_end =3D leaf_data_end(root->fs_info, leaf);
> +		int data_end =3D leaf_data_end(leaf);
>
>   		memmove_extent_buffer(leaf, btrfs_leaf_data(leaf) +
>   			      data_end + dsize,
>
