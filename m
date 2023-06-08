Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C194727B10
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjFHJUG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 05:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjFHJUF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 05:20:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4191B19B
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686215997; x=1686820797; i=quwenruo.btrfs@gmx.com;
 bh=4mYR9sLi/6+0oCBqh8E4xP3mL652OJcoN6W8gss18hU=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=cnAN/ig2P0VoIcaSGeVEQw62QEphuoiDY93OCN09Okqve14P/WTXvkjqHt/8VfFduy9Yhqa
 gKNy14tUiDjkFbJaYlXM6J7F9XorGeL7MZFTfDF6tWjfO4yGDcqncOHgLZXVbeQXaV6D34+cz
 C6A2nYQBpYziGq0fynI//RqP0NTlotrd+r4DQokmCzmAXXBcJ8UwfGLskWNlGeiyVMV5UiNpF
 0DUF19MkFQEXDILD/KU1BH83OlGMp4huwa9AAFBijcMFWtF6MXxF6BKCR9ilXQSl2X1/VBPmq
 aC/8Fi2uhz2PqsVRJD+ag3x4CSEQ4Iz0+U9unC2e97ANgZp8C7QQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N49lD-1py52T2oD3-0103pv; Thu, 08
 Jun 2023 11:19:57 +0200
Message-ID: <f7377d30-33cf-7caf-34f0-a7aa971fd99a@gmx.com>
Date:   Thu, 8 Jun 2023 17:19:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 13/13] btrfs: do not BUG_ON() on tree mod log failures at
 btrfs_del_ptr()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <7890b37a787a3dd59a6eadf0ae78092c46a7f9ca.1686164823.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <7890b37a787a3dd59a6eadf0ae78092c46a7f9ca.1686164823.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b9G0b+MS84IUgP3clB0PmUQ/qf3ofcPTzNiXNkiHa1+tvJVYvhT
 DMbwWy42uObVo4xgITirzG1vMzfz6BKcHqqgWWLecRFec3SoCEozmua7sQ6Xd4QslMIjGgG
 P//vQWQF+xemOajHuYxeW9ct107xk3nr9+oH2bRsMpNpGKxwKMY87PJItgyaBXf3t99HO0n
 O+0t+2ql13i0ZejKHHz3Q==
UI-OutboundReport: notjunk:1;M01:P0:sk2JFZYYe/A=;fpcZb2LTIMIQiuou3QjrtXp9xn8
 XnINQ03Vzsqoxl8f+Ng2azBClPpZqFBQSA7t/26pHnxjeVwu2lOK0kogJjwj75GhDXaukZoRS
 aZwyATxHsFdIW5NNXM20A0Q8Aj120LbHnflAT/WpxbApFhr1RGrXbIp+ih806mw8vSByfSwPb
 Bk5V8oN5VFIwIDpdJePlariLN4cC/M2jKaWKe8CCe83P0BYl7Kc+lQtzdm654ZsAOcIWGSNPW
 QQt2r2p9NFzF17bT3/40s4LVLPVMxBKtZxuuyR3FWQ61tBLDgifFRG22iLsVwXWa96iR9EdIy
 SpA3IyDIQMQjLj5QUxD7PCmKnzzQskGKfxDQWaF5h5jFLTk6/8kw0EjVi91shwaayhpoOKnWq
 AR9vmtvSyJef5X7rOnBt3l1PWUNf9YjXntogGp41vaGEzXKu2EI6ZN+8BZRsUMoHK509Zy9Fb
 SyRcBJqGlQZPqZzkTvUTYxcxF7lGza79q3hxvYxt2tS1pIGSphmWyt0fF5MI0aU4N/VN2nmCE
 +J1YW389G0wolJoiNKZbnaT1jxSXL4qhKS9apOlYYL3IPT6GD1AkyapcaPu0+jjjwKbhWGJft
 KEBEkq/zM9482rM1b4auZpfKUbag6+ybnsoEtWUghYYU6jUW/1WKR5hvEgFVr+/DZUQR+SYCJ
 8YN9uHhga5409dYDtkcD21vMVT9BPrPx3V6FX66lUk9du019a24xewTvag/7AHv47XCfNmX1X
 icnULiSJT1ex/Flhr/33SULvxRcLBBKFqhfP5g8Z16uWF3S/rIDTffSaqI6LcbB5H3jhAVNSy
 ORxSCm5wELKEosuOZ6hPC76B+QEWZ5XVcJFp7629wVzjNmIYLI1T1Vp154/JSiyUCh2bq7K5E
 un0yu07nN+rGi/kC2CM8lih2Dn23siIPpYgIx4NC5GfwlcgJZ4gWxCe/1+931O61Qd3N248bW
 Wj03Jh3uaEYUm8MtnV1xoj2D/FU=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 03:24, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> At btrfs_del_ptr(), instead of doing a BUG_ON() in case we fail to recor=
d
> tree mod log operations, do a transaction abort and return the error to
> the callers. There's really no need for the BUG_ON() as we can release a=
ll
> resources in the context of all callers, and we have to abort because ot=
her
> future tree searches that use the tree mod log (btrfs_search_old_slot())
> may get inconsistent results if other operations modify the tree after
> that failure and before the tree mod log based search.
>
> This implies btrfs_del_ptr() return an int instead of void, and making a=
ll
> callers check for returned errors.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 46 +++++++++++++++++++++++++++++++++-------------
>   fs/btrfs/ctree.h |  4 ++--
>   2 files changed, 35 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index f1fa89ae1184..7220c8736218 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1135,7 +1135,9 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   		if (btrfs_header_nritems(right) =3D=3D 0) {
>   			btrfs_clear_buffer_dirty(trans, right);
>   			btrfs_tree_unlock(right);
> -			btrfs_del_ptr(root, path, level + 1, pslot + 1);
> +			ret =3D btrfs_del_ptr(trans, root, path, level + 1, pslot + 1);
> +			if (ret < 0)
> +				goto out;
>   			root_sub_used(root, right->len);
>   			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
>   					      0, 1);
> @@ -1184,7 +1186,9 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   	if (btrfs_header_nritems(mid) =3D=3D 0) {
>   		btrfs_clear_buffer_dirty(trans, mid);
>   		btrfs_tree_unlock(mid);
> -		btrfs_del_ptr(root, path, level + 1, pslot);
> +		ret =3D btrfs_del_ptr(trans, root, path, level + 1, pslot);
> +		if (ret < 0)
> +			goto out;
>   		root_sub_used(root, mid->len);
>   		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
>   		free_extent_buffer_stale(mid);
> @@ -4429,8 +4433,8 @@ int btrfs_duplicate_item(struct btrfs_trans_handle=
 *trans,
>    *
>    * This is exported for use inside btrfs-progs, don't un-export it.
>    */
> -void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, in=
t level,
> -		   int slot)
> +int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *=
root,
> +		  struct btrfs_path *path, int level, int slot)
>   {
>   	struct extent_buffer *parent =3D path->nodes[level];
>   	u32 nritems;
> @@ -4441,7 +4445,10 @@ void btrfs_del_ptr(struct btrfs_root *root, struc=
t btrfs_path *path, int level,
>   		if (level) {
>   			ret =3D btrfs_tree_mod_log_insert_move(parent, slot,
>   					slot + 1, nritems - slot - 1);
> -			BUG_ON(ret < 0);
> +			if (ret < 0) {
> +				btrfs_abort_transaction(trans, ret);
> +				return ret;
> +			}
>   		}
>   		memmove_extent_buffer(parent,
>   			      btrfs_node_key_ptr_offset(parent, slot),
> @@ -4451,7 +4458,10 @@ void btrfs_del_ptr(struct btrfs_root *root, struc=
t btrfs_path *path, int level,
>   	} else if (level) {
>   		ret =3D btrfs_tree_mod_log_insert_key(parent, slot,
>   						    BTRFS_MOD_LOG_KEY_REMOVE);
> -		BUG_ON(ret < 0);
> +		if (ret < 0) {
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
>   	}
>
>   	nritems--;
> @@ -4467,6 +4477,7 @@ void btrfs_del_ptr(struct btrfs_root *root, struct=
 btrfs_path *path, int level,
>   		fixup_low_keys(path, &disk_key, level + 1);
>   	}
>   	btrfs_mark_buffer_dirty(parent);
> +	return 0;
>   }
>
>   /*
> @@ -4479,13 +4490,17 @@ void btrfs_del_ptr(struct btrfs_root *root, stru=
ct btrfs_path *path, int level,
>    * The path must have already been setup for deleting the leaf, includ=
ing
>    * all the proper balancing.  path->nodes[1] must be locked.
>    */
> -static noinline void btrfs_del_leaf(struct btrfs_trans_handle *trans,
> -				    struct btrfs_root *root,
> -				    struct btrfs_path *path,
> -				    struct extent_buffer *leaf)
> +static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
> +				   struct btrfs_root *root,
> +				   struct btrfs_path *path,
> +				   struct extent_buffer *leaf)
>   {
> +	int ret;
> +
>   	WARN_ON(btrfs_header_generation(leaf) !=3D trans->transid);
> -	btrfs_del_ptr(root, path, 1, path->slots[1]);
> +	ret =3D btrfs_del_ptr(trans, root, path, 1, path->slots[1]);
> +	if (ret < 0)
> +		return ret;
>
>   	/*
>   	 * btrfs_free_extent is expensive, we want to make sure we
> @@ -4498,6 +4513,7 @@ static noinline void btrfs_del_leaf(struct btrfs_t=
rans_handle *trans,
>   	atomic_inc(&leaf->refs);
>   	btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
>   	free_extent_buffer_stale(leaf);
> +	return 0;
>   }
>   /*
>    * delete the item at the leaf level in path.  If that empties
> @@ -4547,7 +4563,9 @@ int btrfs_del_items(struct btrfs_trans_handle *tra=
ns, struct btrfs_root *root,
>   			btrfs_set_header_level(leaf, 0);
>   		} else {
>   			btrfs_clear_buffer_dirty(trans, leaf);
> -			btrfs_del_leaf(trans, root, path, leaf);
> +			ret =3D btrfs_del_leaf(trans, root, path, leaf);
> +			if (ret < 0)
> +				return ret;
>   		}
>   	} else {
>   		int used =3D leaf_space_used(leaf, 0, nritems);
> @@ -4608,7 +4626,9 @@ int btrfs_del_items(struct btrfs_trans_handle *tra=
ns, struct btrfs_root *root,
>
>   			if (btrfs_header_nritems(leaf) =3D=3D 0) {
>   				path->slots[1] =3D slot;
> -				btrfs_del_leaf(trans, root, path, leaf);
> +				ret =3D btrfs_del_leaf(trans, root, path, leaf);
> +				if (ret < 0)
> +					return ret;
>   				free_extent_buffer(leaf);
>   				ret =3D 0;
>   			} else {
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 5af61480dde6..f2d2b313bde5 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -541,8 +541,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans=
,
>   		      struct extent_buffer **cow_ret, u64 new_root_objectid);
>   int btrfs_block_can_be_shared(struct btrfs_root *root,
>   			      struct extent_buffer *buf);
> -void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, in=
t level,
> -		   int slot);
> +int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *=
root,
> +		  struct btrfs_path *path, int level, int slot);
>   void btrfs_extend_item(struct btrfs_path *path, u32 data_size);
>   void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int fr=
om_end);
>   int btrfs_split_item(struct btrfs_trans_handle *trans,
