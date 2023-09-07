Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416C797F78
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjIGX7e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIGX7c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:59:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5189D
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694131165; x=1694735965; i=quwenruo.btrfs@gmx.com;
 bh=2mmn5iu6eG8e9nOLClBZSft6YvRN/9oOkwh0BPfA0pY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=stNeUEn3DjhfjtLVa9krImjZm6UhgdnmN9C+fl/DorCt3QxshnFTl7YOBpAKRNYsYZLWryT
 21DGV2WD03atAUgwt4HfhzbkJ/qajHZ2FuQdQTj6qFBpeEI4s+xApPqgnhvh7uH3UYojgiPv3
 9l1SflxaSjj8maUb68oKyfRv9JghILMTUtDQ5yti/Lh+QyPET6Mbi5SO9Hg1R1aNxGyYlogD0
 II4xn+0pVk+oFoaM9mwePNhBzySj5o4WtbhbhYjJOL0VqNVkXaZv0I6okw1o4nFVdr3R4Vle5
 rcTq4n7VTgi8sGpGvqsJJeM46dLbARCF7fzBLavwJwnEISoZgaLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0XD2-1pkOT30a5E-00wTn4; Fri, 08
 Sep 2023 01:59:25 +0200
Message-ID: <b6612277-290c-4b4f-a9c0-b1cb841ba1dc@gmx.com>
Date:   Fri, 8 Sep 2023 07:59:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] btrfs: reduce arguments of helpers space accounting
 root item
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1694126893.git.dsterba@suse.com>
 <ec9f787e9b36be2e8240734d74f1fff4f68c78c9.1694126893.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <ec9f787e9b36be2e8240734d74f1fff4f68c78c9.1694126893.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gDGxcWVETomOzaWlGHsSYhrdvtkDiFDyA7aAgdODlBBMD5XUKe1
 +3s2bdwwtZp54KgWvQ2+cwclyOQd/WKsUN5spENHWS1kYmO8Xw+FqS4aRNg6lV+0rgfBnUJ
 EtwIWqdVxYjXDDJ2z+qwq8h7g/bvgrSQNFGxruLh6Exb2KAow2f37P6srx1qgQM2Cd3v4ub
 0IKBqi/HUhfLBsSA5ttXA==
UI-OutboundReport: notjunk:1;M01:P0:1bqvpVWnzX0=;kqjWa7klbzM03W8V6q0Yji8Mfb9
 n0ReD6CyQnM1+h6HhxjVh9l2xLWn8mPTxIRGldkv8+EnVysNHhr5V364rOgPnOemwUDxuyP02
 Ah8NAqmiSoIoP99qh9qiTxQZDqMvtKsXhdSTuA5T1Q3JCW7Lk4gtlt0HCnjZmry2yBhYYvtyM
 xmcIYpP1D+nn3t0TRJsApZmZ1gf399x7gKXqe/Si0y6YlfXfRSi0Q2G8EIX20rF2QNaAZ6YAU
 QTVrst/lQ3J5qIDhCfkjYtP4b3aMC5d0naJAxwDHaRH4rOeRBj+3kIGsM72aS+WPtzpqSeLvT
 bd6lODoKhF8qv6PkUhlwQIRlh2JkIES2Aucj+JZvJIkE98+p028djBiAFwqf75x36ycVyQUdS
 xlFapvjuhGmoQrVPHgKAOil7cQvi21CZRtmR42jAgavAWXOtQ6xFP9+Akp1NNkWw6J2wDDtV4
 1XJuM3v4jsW5HmPZswB0L1u7feROzwlVdspHnkWI5Y2FkLJ/P+o2RQzN1mBQaW/0EUVBvHFj/
 FZRRSylh5PbNVlYFu/q1n0FVzpHhlTPLDCDga4w1S+jhQ+x22Ke3F58j5ir3Gv8TGGTMmSzjk
 J6axKe44jrxF+nQDQ47IVnMKQVrJxOdDKpxJqCPIlhx5lH9LNrhGwmkPYFSzBA7Y4+vmLcV0u
 4MvnajNDgJv4B4N+d9E5m9ftHQpNdtG54OBlXIRiZ4wEQp0PTXnXXrjZHpKZmNAxpkP7mIiGi
 IMEqRkN+pu/nQ4dy49K7F4tpflMB75V4Gigq72kapEQs4rbyL6qMVlXi2X88k3KTvkWpduV21
 oFIt9ivvNGAUJkeJPQjhyXGo3NYfQXeZIunDEWRi3BSEVJvfVWRycpvcmQMECp2a41iXE9dhO
 3DHwnSBvgKc0+cprAKSjSmiWGlCJ8KW89ciuidTzGoKvzbxNg9WB74yV51SERzkmB7hklOMVh
 cYB4YhTwwd4gMlMyc3iAhl6lQSM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/8 07:09, David Sterba wrote:
> There are two helpers to increase used bytes of root items that add or
> subtract one node size, we don't need to pass the argument for that.
> Rename the function so it matches the root item member that gets
> changed.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 792f9e3afad8..6d18f6d5a8b3 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -947,19 +947,19 @@ int btrfs_bin_search(struct extent_buffer *eb, int=
 first_slot,
>   	return 1;
>   }
>
> -static void root_add_used(struct btrfs_root *root, u32 size)
> +static void root_add_used_bytes(struct btrfs_root *root)
>   {
>   	spin_lock(&root->accounting_lock);
>   	btrfs_set_root_used(&root->root_item,
> -			    btrfs_root_used(&root->root_item) + size);
> +		btrfs_root_used(&root->root_item) + root->fs_info->nodesize);
>   	spin_unlock(&root->accounting_lock);
>   }
>
> -static void root_sub_used(struct btrfs_root *root, u32 size)
> +static void root_sub_used_bytes(struct btrfs_root *root)
>   {
>   	spin_lock(&root->accounting_lock);
>   	btrfs_set_root_used(&root->root_item,
> -			    btrfs_root_used(&root->root_item) - size);
> +		btrfs_root_used(&root->root_item) - root->fs_info->nodesize);
>   	spin_unlock(&root->accounting_lock);
>   }
>
> @@ -1075,7 +1075,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   		/* once for the path */
>   		free_extent_buffer(mid);
>
> -		root_sub_used(root, mid->len);
> +		root_sub_used_bytes(root);
>   		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
>   		/* once for the root ptr */
>   		free_extent_buffer_stale(mid);
> @@ -1145,7 +1145,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   				right =3D NULL;
>   				goto out;
>   			}
> -			root_sub_used(root, right->len);
> +			root_sub_used_bytes(root);
>   			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
>   					      0, 1);
>   			free_extent_buffer_stale(right);
> @@ -1203,7 +1203,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   			mid =3D NULL;
>   			goto out;
>   		}
> -		root_sub_used(root, mid->len);
> +		root_sub_used_bytes(root);
>   		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
>   		free_extent_buffer_stale(mid);
>   		mid =3D NULL;
> @@ -2937,7 +2937,6 @@ static noinline int insert_new_root(struct btrfs_t=
rans_handle *trans,
>   			   struct btrfs_root *root,
>   			   struct btrfs_path *path, int level)
>   {
> -	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	u64 lower_gen;
>   	struct extent_buffer *lower;
>   	struct extent_buffer *c;
> @@ -2960,7 +2959,7 @@ static noinline int insert_new_root(struct btrfs_t=
rans_handle *trans,
>   	if (IS_ERR(c))
>   		return PTR_ERR(c);
>
> -	root_add_used(root, fs_info->nodesize);
> +	root_add_used_bytes(root);
>
>   	btrfs_set_header_nritems(c, 1);
>   	btrfs_set_node_key(c, &lower_key, 0);
> @@ -3104,7 +3103,7 @@ static noinline int split_node(struct btrfs_trans_=
handle *trans,
>   	if (IS_ERR(split))
>   		return PTR_ERR(split);
>
> -	root_add_used(root, fs_info->nodesize);
> +	root_add_used_bytes(root);
>   	ASSERT(btrfs_header_level(c) =3D=3D level);
>
>   	ret =3D btrfs_tree_mod_log_eb_copy(split, c, 0, mid, c_nritems - mid)=
;
> @@ -3857,7 +3856,7 @@ static noinline int split_leaf(struct btrfs_trans_=
handle *trans,
>   	if (IS_ERR(right))
>   		return PTR_ERR(right);
>
> -	root_add_used(root, fs_info->nodesize);
> +	root_add_used_bytes(root);
>
>   	if (split =3D=3D 0) {
>   		if (mid <=3D slot) {
> @@ -4530,7 +4529,7 @@ static noinline int btrfs_del_leaf(struct btrfs_tr=
ans_handle *trans,
>   	 */
>   	btrfs_unlock_up_safe(path, 0);
>
> -	root_sub_used(root, leaf->len);
> +	root_sub_used_bytes(root);
>
>   	atomic_inc(&leaf->refs);
>   	btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
