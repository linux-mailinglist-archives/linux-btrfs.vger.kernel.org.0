Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56476727A7F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjFHIxn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 04:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjFHIxm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 04:53:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C15FE50
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686214415; x=1686819215; i=quwenruo.btrfs@gmx.com;
 bh=BozCwfQLwb5xwWHsagALGjhcK2uzu0/c9+f6Z9Ly5nY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=J0waiy+hRTQRcsFYd4f8tPX9WQiiPhotzOMsZMYijN+vd63duIuLWxPEgtkyRd4wKq8l5Kk
 EfIxtMqhFtA74lOvJ277El9qY0kS6GDuqLw07oS7SSEaI6piDJAF+UJ/n4WXc1GyHnXcU/9VO
 cYLZhJj9FFanshXRxkH+sHcjKczBNGQkI/TDdkneLfrEUfmxlkzoWxPQVjiA1pyfnWOYrDf0K
 /X5aTHRjQRhp1LzCIFcLzB+z0hXm/typpOhOspvjM/HrW64a94/0/hQzQTyEYHaMlDE6YxO/x
 gxhVKDcHX/6S+G47uclnqolwmCSIVFFzyVr86ys8QK1DAkJYC8YA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQMuX-1qSxPb361J-00MM1F; Thu, 08
 Jun 2023 10:53:35 +0200
Message-ID: <1f8c848c-3f2d-212e-8861-fca79575373c@gmx.com>
Date:   Thu, 8 Jun 2023 16:53:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 06/13] btrfs: rename enospc label to out at
 balance_level()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <4da7393afeffff23420fb2eafa27db99f882c39c.1686164811.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <4da7393afeffff23420fb2eafa27db99f882c39c.1686164811.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QdfdsktVs2/k5W+QoCLJCxmNc75Mj2gCRqCqaJPmF1HB3buOzOV
 +7Bfz5DdtQrkQKy0f7j6abVuOrhwXmCaDbKgplzWW2xhXO9dqxpFtT7PlqwjyL197SEp9jg
 f2YIsc84kB97M/yeiXsvZ91NA9jWqzbk6nNohOvlmMZmG7mHqI3h55BJTO8/EeZrROYfhcV
 gSGW2AvQKVPvAfvxVU4lA==
UI-OutboundReport: notjunk:1;M01:P0:huWUakXzE0E=;FFLT9otpw7HIpSnVA0TNZER6sr9
 wrhL6tvfxo9c1AEOxSJtaIAgqk2sz0ShtuVDpnpg2z4gO+zrw94rQUFuGl6madjpUWzIuagcH
 b8GeBKA2TD5UsGH1lHg1zVNsYNKsFkpmug/c5VfcGHw0tB3FrqYVYQoK5uAFHXanAqXUmi7wS
 N4gpXHLuQysGFU1RqMgG2hKac1erQGW1I2OwSGXsVPpLWMBXzJc5116MslWWyeWi+fB1LKOEh
 G+wrn/PJJwB7ZeNioFxtNJlehRmp9VlZArfhxMEwx8Eq5RRQqEkdFzAkAUitdg6Lgs+R+7OGP
 2Y+Om2n0FUFUchS1bZu8B+8EtXKJJ1z1BoyCr+GyH0/G+D5cSwzwUDcuwWA3DrWLtGYDfcAto
 QjzkshFZpqhlt1+5kUfy5LdTAMtEHd+4BOmyqBTn81DfUOBSKgfnfe42SuKQEtSd7Olxqxx+A
 6XdYVupO2fCiGjzGuFzE398jyWXot7APCSMMJZdMf/lg+Z6yNln/jbE5RJ9Z4XdikV4s8GZBH
 vKrGMeZ/5G4qyoU+4KQa2511Iq0mwVJ4FpmcRu/nXyDb+exkMC+2IoiPKqeOdZPBUy+kwodbX
 z301edR84Kn7RJgQGc7rd3qGVodxAJGfagChDIl16hmfdyU0HPsfTgdFskKelXrNw1/hfDFlT
 IUqGsZ0LLOdeES8I7odzxhPtn7wqiQsIVs9xUq81gVTBVolUTZfWubSyPtp7LxVl/Ul9cWP9X
 v7swsT3VN5fVoZynJyxtdZAZb6hs6H91q+mRhAw51Sj6ACywkWpFTwxVQMcAFYnAVTFv91Ow8
 c7BOVqi2wdUtn1zIVzRtibM7ngHyQdFrKUhS6AFnEvV7Jm9/FrYNeCwP6yud2qkNCrc/zBVS2
 iZ/KcwV1fbzx4w+8b6gyxd5Vsiam20jpJMjy21V7m91Jb/mhjaA9Pe7SkzkyfbyY22uIFA2kT
 H3pK5E7NReVQQgNXyWE0qP7EKmA=
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
> At balance_level() we have this 'enospc' label where we jump to in case
> we get an error at several places. However that error is certainly not
> -ENOSPC in call cases, it can be -EIO or -ENOMEM when reading a child
> extent buffer for example, or -ENOMEM when trying to record tree mod log
> operations. So to make this less confusing, rename the label to 'out'.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ctree.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index d60b28c6bd1b..e98f9e205e25 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1041,7 +1041,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   		if (IS_ERR(child)) {
>   			ret =3D PTR_ERR(child);
>   			btrfs_handle_fs_error(fs_info, ret, NULL);
> -			goto enospc;
> +			goto out;
>   		}
>
>   		btrfs_tree_lock(child);
> @@ -1050,7 +1050,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   		if (ret) {
>   			btrfs_tree_unlock(child);
>   			free_extent_buffer(child);
> -			goto enospc;
> +			goto out;
>   		}
>
>   		ret =3D btrfs_tree_mod_log_insert_root(root->node, child, true);
> @@ -1058,7 +1058,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   			btrfs_tree_unlock(child);
>   			free_extent_buffer(child);
>   			btrfs_abort_transaction(trans, ret);
> -			goto enospc;
> +			goto out;
>   		}
>   		rcu_assign_pointer(root->node, child);
>
> @@ -1087,7 +1087,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   		if (IS_ERR(left)) {
>   			ret =3D PTR_ERR(left);
>   			left =3D NULL;
> -			goto enospc;
> +			goto out;
>   		}
>
>   		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
> @@ -1096,7 +1096,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   				       BTRFS_NESTING_LEFT_COW);
>   		if (wret) {
>   			ret =3D wret;
> -			goto enospc;
> +			goto out;
>   		}
>   	}
>
> @@ -1105,7 +1105,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   		if (IS_ERR(right)) {
>   			ret =3D PTR_ERR(right);
>   			right =3D NULL;
> -			goto enospc;
> +			goto out;
>   		}
>
>   		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
> @@ -1114,7 +1114,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   				       BTRFS_NESTING_RIGHT_COW);
>   		if (wret) {
>   			ret =3D wret;
> -			goto enospc;
> +			goto out;
>   		}
>   	}
>
> @@ -1149,7 +1149,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   					BTRFS_MOD_LOG_KEY_REPLACE);
>   			if (ret < 0) {
>   				btrfs_abort_transaction(trans, ret);
> -				goto enospc;
> +				goto out;
>   			}
>   			btrfs_set_node_key(parent, &right_key, pslot + 1);
>   			btrfs_mark_buffer_dirty(parent);
> @@ -1168,12 +1168,12 @@ static noinline int balance_level(struct btrfs_t=
rans_handle *trans,
>   		if (!left) {
>   			ret =3D -EROFS;
>   			btrfs_handle_fs_error(fs_info, ret, NULL);
> -			goto enospc;
> +			goto out;
>   		}
>   		wret =3D balance_node_right(trans, mid, left);
>   		if (wret < 0) {
>   			ret =3D wret;
> -			goto enospc;
> +			goto out;
>   		}
>   		if (wret =3D=3D 1) {
>   			wret =3D push_node_left(trans, left, mid, 1);
> @@ -1198,7 +1198,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   						    BTRFS_MOD_LOG_KEY_REPLACE);
>   		if (ret < 0) {
>   			btrfs_abort_transaction(trans, ret);
> -			goto enospc;
> +			goto out;
>   		}
>   		btrfs_set_node_key(parent, &mid_key, pslot);
>   		btrfs_mark_buffer_dirty(parent);
> @@ -1225,7 +1225,7 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   	if (orig_ptr !=3D
>   	    btrfs_node_blockptr(path->nodes[level], path->slots[level]))
>   		BUG();
> -enospc:
> +out:
>   	if (right) {
>   		btrfs_tree_unlock(right);
>   		free_extent_buffer(right);
