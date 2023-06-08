Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57E5727B03
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 11:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjFHJQq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 05:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjFHJQp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 05:16:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E12E46
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 02:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686215797; x=1686820597; i=quwenruo.btrfs@gmx.com;
 bh=gjIIWm0n13Vw+dfNM+rucDQ4zVsefhErOO+DA2NnSCs=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=ZORT4ueB0qb2h1g41u8GkSkvZJ1N2k0E/tQrDstcABQ5t0FTg/lahcIDfi8CTbc0m2FXnJc
 mJNzAOnq7qT8K6ejCcWAlyajj9D97e9Aai4ZX7+H82+SDS9meubZfkKrZF7py+Cb/o+GNFy6L
 SucqMuCSS7qJOGNLPJuuLr75cs+Eqms+cHB1v6vqn0UA2fdhyvM/4sGW+/QDeEQvFtTE7sWfh
 8+cerXIjYxMac9Q2ZHper/ENiSI9Nw5QoYSoG/0IuhrlCYaVYS3Ho5EssPm/yXRxItNLXpREd
 vhkyZfvt5S0zu0Irks+GINlnaF8WNVqxFgQwpucHCoPj6ZJt9LbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO24-1pnGGb0ZXk-00om92; Thu, 08
 Jun 2023 11:16:37 +0200
Message-ID: <d8faba01-76a7-4401-bab9-483fd909139b@gmx.com>
Date:   Thu, 8 Jun 2023 17:16:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 12/13] btrfs: do not BUG_ON() on tree mod log failures at
 insert_ptr()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <bd2831e141daa59bfba8b0dc24d839090b63d87f.1686164822.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <bd2831e141daa59bfba8b0dc24d839090b63d87f.1686164822.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5WhexBtxdBQYyU69nh9clRHaG0jevtaOOQIyKn91Qb+e+LmylC2
 ZCwc51EeRRKGhYALZfm9sgf6+70MmfFg8MspWOI4oyMKYD9Ukt1xcSdPqzVyIwBztydaPvp
 oTeDeeO1yFHD05rm2qWfCYDoOzB8TmGH4nyDU2T8wOkmxwAqI06idFO5ocaJNj6KbQnhI2+
 m/7IgvpeLkJyisRH5ygpw==
UI-OutboundReport: notjunk:1;M01:P0:CwoMft30+wo=;DUtzyMeQm0q055bcd+KIwmAPw/E
 15bDcheh3Luj8+P7VN9qB0vlyftHrPNon3SEMECMhvEKVpyTzTFulAwgdJy7p81QLZhMkgdA4
 65B5nVcp1yaSRORucMz+J9/NCmBX8/BqdR2C/xXZJQldtOfdMnf4prRmpEB6SVuQBlLd+qxuE
 6AEns2a5P+I7maraoh2T3sSDNCSqiuq4q6c1Z9QuLBPC7w8WN8tXpn0poP5Pv7mpxhezOWHh9
 XawO0nonBzxEOFeLHMB+g/7dn4O01RlKtHcHYK1smkpogTUo7Mdmixe/BSrf9Bk/xnYEeiiGe
 XDZ9lZB9C3DadBK21dR/jIlWq9Z0PFsfq/Ro3dx/YbWdpLgFuaK85TDg701X4jcOeuUXVoWEG
 dx465pLSWpKRySaAO6LMcZkDMjpCTwvWN+WSx7j45gk8UcXP/a83JfXHI3h6Cyn6c5HOJA5WK
 hViNTt7yky/2AsWGXLC7egN8842ClA0ZI/139Rc2xpnTF0vETi3u2pF3UPKsyqOXfm6LpH6pq
 kXZ+7zv4d+QsCIQRQxS1C+ZMUofe4WM2nP0t09hdPhvdOmOwslG0SH/7IFo+/CispQR5xGddC
 DTHCBKrfr5MB/n5+t07rjGfkmSnQlu0MXCnCtzvZR/GDZ0YXuUUWeYPi2MiE/FeqEIVJ+lh25
 kTrufivdJS27rG/guLMLBI35YTQ4jIGMA6nVJa2GUjAZRPhXC+KMmtJmjWA4j0+OgF4qiY4R2
 QwH6MjbFqRl8JXLC3L9Agw4LG2T+6mbewjh7l5Al2Keo/NHC2xWYXrnoWhc+d3qG77870nNEA
 Wo8558MhVm5tZtVzkhsonRvb6OqMLPdDnZTyadamnCdhOznHa4Wyz2JOjZA1qEckT4OA/fhiQ
 TWqk5ExMMDK3H85Q8Tk9yScFHkFfARaUkGU2TWZpBsJWWZIR8dCirX3XWRbokjqKCh8lpR0a0
 3tQYCYT+4/Bx5ljd+QufwegFNNs=
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



On 2023/6/8 03:24, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> At insert_ptr(), instead of doing a BUG_ON() in case we fail to record
> tree mod log operations, do a transaction abort and return the error to
> the callers. There's really no need for the BUG_ON() as we can release a=
ll
> resources in the context of all callers, and we have to abort because ot=
her
> future tree searches that use the tree mod log (btrfs_search_old_slot())
> may get inconsistent results if other operations modify the tree after
> that failure and before the tree mod log based search.
>
> This implies making insert_ptr() return an int instead of void, and maki=
ng
> all callers check for returned errors.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/ctree.c | 68 ++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 49 insertions(+), 19 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 6e59343034d6..f1fa89ae1184 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2982,10 +2982,10 @@ static noinline int insert_new_root(struct btrfs=
_trans_handle *trans,
>    * slot and level indicate where you want the key to go, and
>    * blocknr is the block the key points to.
>    */
> -static void insert_ptr(struct btrfs_trans_handle *trans,
> -		       struct btrfs_path *path,
> -		       struct btrfs_disk_key *key, u64 bytenr,
> -		       int slot, int level)
> +static int insert_ptr(struct btrfs_trans_handle *trans,
> +		      struct btrfs_path *path,
> +		      struct btrfs_disk_key *key, u64 bytenr,
> +		      int slot, int level)
>   {
>   	struct extent_buffer *lower;
>   	int nritems;
> @@ -3001,7 +3001,10 @@ static void insert_ptr(struct btrfs_trans_handle =
*trans,
>   		if (level) {
>   			ret =3D btrfs_tree_mod_log_insert_move(lower, slot + 1,
>   					slot, nritems - slot);
> -			BUG_ON(ret < 0);
> +			if (ret < 0) {
> +				btrfs_abort_transaction(trans, ret);
> +				return ret;
> +			}
>   		}
>   		memmove_extent_buffer(lower,
>   			      btrfs_node_key_ptr_offset(lower, slot + 1),
> @@ -3011,7 +3014,10 @@ static void insert_ptr(struct btrfs_trans_handle =
*trans,
>   	if (level) {
>   		ret =3D btrfs_tree_mod_log_insert_key(lower, slot,
>   						    BTRFS_MOD_LOG_KEY_ADD);
> -		BUG_ON(ret < 0);
> +		if (ret < 0) {
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
>   	}
>   	btrfs_set_node_key(lower, key, slot);
>   	btrfs_set_node_blockptr(lower, slot, bytenr);
> @@ -3019,6 +3025,8 @@ static void insert_ptr(struct btrfs_trans_handle *=
trans,
>   	btrfs_set_node_ptr_generation(lower, slot, trans->transid);
>   	btrfs_set_header_nritems(lower, nritems + 1);
>   	btrfs_mark_buffer_dirty(lower);
> +
> +	return 0;
>   }
>
>   /*
> @@ -3098,8 +3106,13 @@ static noinline int split_node(struct btrfs_trans=
_handle *trans,
>   	btrfs_mark_buffer_dirty(c);
>   	btrfs_mark_buffer_dirty(split);
>
> -	insert_ptr(trans, path, &disk_key, split->start,
> -		   path->slots[level + 1] + 1, level + 1);
> +	ret =3D insert_ptr(trans, path, &disk_key, split->start,
> +			 path->slots[level + 1] + 1, level + 1);
> +	if (ret < 0) {
> +		btrfs_tree_unlock(split);
> +		free_extent_buffer(split);
> +		return ret;
> +	}
>
>   	if (path->slots[level] >=3D mid) {
>   		path->slots[level] -=3D mid;
> @@ -3576,16 +3589,17 @@ static int push_leaf_left(struct btrfs_trans_han=
dle *trans, struct btrfs_root
>    * split the path's leaf in two, making sure there is at least data_si=
ze
>    * available for the resulting leaf level of the path.
>    */
> -static noinline void copy_for_split(struct btrfs_trans_handle *trans,
> -				    struct btrfs_path *path,
> -				    struct extent_buffer *l,
> -				    struct extent_buffer *right,
> -				    int slot, int mid, int nritems)
> +static noinline int copy_for_split(struct btrfs_trans_handle *trans,
> +				   struct btrfs_path *path,
> +				   struct extent_buffer *l,
> +				   struct extent_buffer *right,
> +				   int slot, int mid, int nritems)
>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>   	int data_copy_size;
>   	int rt_data_off;
>   	int i;
> +	int ret;
>   	struct btrfs_disk_key disk_key;
>   	struct btrfs_map_token token;
>
> @@ -3610,7 +3624,9 @@ static noinline void copy_for_split(struct btrfs_t=
rans_handle *trans,
>
>   	btrfs_set_header_nritems(l, mid);
>   	btrfs_item_key(right, &disk_key, 0);
> -	insert_ptr(trans, path, &disk_key, right->start, path->slots[1] + 1, 1=
);
> +	ret =3D insert_ptr(trans, path, &disk_key, right->start, path->slots[1=
] + 1, 1);
> +	if (ret < 0)
> +		return ret;
>
>   	btrfs_mark_buffer_dirty(right);
>   	btrfs_mark_buffer_dirty(l);
> @@ -3628,6 +3644,8 @@ static noinline void copy_for_split(struct btrfs_t=
rans_handle *trans,
>   	}
>
>   	BUG_ON(path->slots[0] < 0);
> +
> +	return 0;
>   }
>
>   /*
> @@ -3826,8 +3844,13 @@ static noinline int split_leaf(struct btrfs_trans=
_handle *trans,
>   	if (split =3D=3D 0) {
>   		if (mid <=3D slot) {
>   			btrfs_set_header_nritems(right, 0);
> -			insert_ptr(trans, path, &disk_key,
> -				   right->start, path->slots[1] + 1, 1);
> +			ret =3D insert_ptr(trans, path, &disk_key,
> +					 right->start, path->slots[1] + 1, 1);
> +			if (ret < 0) {
> +				btrfs_tree_unlock(right);
> +				free_extent_buffer(right);
> +				return ret;
> +			}
>   			btrfs_tree_unlock(path->nodes[0]);
>   			free_extent_buffer(path->nodes[0]);
>   			path->nodes[0] =3D right;
> @@ -3835,8 +3858,13 @@ static noinline int split_leaf(struct btrfs_trans=
_handle *trans,
>   			path->slots[1] +=3D 1;
>   		} else {
>   			btrfs_set_header_nritems(right, 0);
> -			insert_ptr(trans, path, &disk_key,
> -				   right->start, path->slots[1], 1);
> +			ret =3D insert_ptr(trans, path, &disk_key,
> +					 right->start, path->slots[1], 1);
> +			if (ret < 0) {
> +				btrfs_tree_unlock(right);
> +				free_extent_buffer(right);
> +				return ret;
> +			}
>   			btrfs_tree_unlock(path->nodes[0]);
>   			free_extent_buffer(path->nodes[0]);
>   			path->nodes[0] =3D right;
> @@ -3852,7 +3880,9 @@ static noinline int split_leaf(struct btrfs_trans_=
handle *trans,
>   		return ret;
>   	}
>
> -	copy_for_split(trans, path, l, right, slot, mid, nritems);
> +	ret =3D copy_for_split(trans, path, l, right, slot, mid, nritems);
> +	if (ret < 0)
> +		return ret;

Shouldn't we also call btrfs_free_tree_block() for @right for error?

Or because we have already aborted the trans, there is no longer the
need to add delayed ref for @right?

Thanks,
Qu
>
>   	if (split =3D=3D 2) {
>   		BUG_ON(num_doubles !=3D 0);
