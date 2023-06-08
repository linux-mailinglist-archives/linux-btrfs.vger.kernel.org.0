Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C04727A7D
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 10:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjFHIxE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 04:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjFHIxD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 04:53:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27028E61
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 01:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686214376; x=1686819176; i=quwenruo.btrfs@gmx.com;
 bh=ty4FqdEen2xzE4hV7I0K4+d09Lp/y1EoAncB1PPI0xw=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=uNeeRnfobJ0CMveJ1Qe9QMTqrBVkSurH6pCMwZ44rtaXN0TU4EpDaPl5vQM0tq/d07MTBUC
 97rgnQLVtsIiBB+GUpgx02mJ9g6cvYq3pw+R4+NA2qK5pJo3d9Ex039fvcpEKl1hxbmMwwIY2
 YWmd9rBQ0FH4wDWj/YDH3fVOSJKfHrNXhp7Pqz9nKm6/lexqLiO/+FK8mKCQNcZ0bH7uhSBRW
 2l+9+ofZsVulKw3o29DxvaeTUYULDw3gi+wYmwnV6URK7O6uQaWmOVymJFMKfZHy9Q4UjMS1c
 5EHW4FAczoW73w/5qoxi532Rj5LoLqMOb88dtuhBRzp0M8PcyhhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRCOK-1qUKPb1eBI-00NB8y; Thu, 08
 Jun 2023 10:52:56 +0200
Message-ID: <b5489eca-6908-a585-6585-8337d6db3ca8@gmx.com>
Date:   Thu, 8 Jun 2023 16:52:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 05/13] btrfs: do not BUG_ON() on tree mod log failure at
 balance_level()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <4d83a67f420c7e8f6ceb4535ab5431fde9ecc82f.1686164810.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <4d83a67f420c7e8f6ceb4535ab5431fde9ecc82f.1686164810.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EzxnL8cGeZLOjdK1W2gzUjlNyMTYEuu+DmeSeuHwjKtOOi46Hwo
 +qSWP4dg1AhBrWHfMMauc5SKIQc7WMKZDA4Ti6dVkYD+QH31XlV7tRyDgdfSsjxD20TE1wq
 3OHnQBwu/0UjMMoB7ctZlci/TSYLRs+3SuPrtbXrrWiGp6LWO6zUv6NrRLHVTh+qM5nN+/i
 Rw2rT1E7enE60bdZfXrNw==
UI-OutboundReport: notjunk:1;M01:P0:ktiZTDQpUdQ=;gUOrhrBW7ptLTdK/AqzIn0XW/Rk
 wXY+hEVa2Hglyc0scskTHyovRMTvODoCQhRCabQcUmabICMVf1cIgJzadEGvbvzehZARWlyj8
 N1Ljqj/RtIetPId6+OOyCrhql4+wqPIvUth2tSdvGCSA+OwUUgWwYKT6FOokDw5wkItqEXORy
 md88TFP0co6twbU9KpQ1Sn8yasxJj63p4nkjgh23cao9ggx5F5m/2py3uSXbUIilWeXEQRzbh
 ilkgnxN3WiRrvxPzg9c3g0hRrFxsTgbEC67RoGMN9K5ZmykIy7kQtI5ArAe7HMPlNwi4h6xTF
 RedPYoV56nhMO7/87aXnF8dMLk1ZCv5lPZMwJF3KXGs+XvZUHMLqVTsAqzND64928ARIHtShw
 cFl8i9uJh/OOcW1CEcqe5CrZkv1mdfAULvUUEIAigLGFZlKK4icEANdMXpZST3S6B2mVx+rR0
 4LYBEMtvViofairnsm0dMHn8rTHMp01Lg8S+P8bs3wngcuTcMASy5PYyVif4c7sQUtEDsQEjR
 vNSp0UeKyFub/3pHThgRoXdrj2t+4ioBmQ3mD/YR6eDMugV9Qz8ZBkzOBYvgL4P+OQQY1q5zB
 5cMiFaZmuikQ+6/rIKJ5Uc98Megjnomiqbj+FDUm9u8W2jCmMVvOkMLqasVCTqztZdwUqgOso
 IPGHaI3iGptO501bDOA+W8w63JqPjHqgxSD3VwhNFmR9tBPLHxb0yxA0J4gckdiyWRzopvihs
 C5PSDIOK64SFPi97Aj9bKIn1LDkTXT6DygQ+xycxz0Y5T7zo/xzSzdR0SON8CKIEZuydTCKeZ
 lqRGdfY0b38ixZeOwDFZQZQmrIM8faMKSduMa4gF8+zR1tw9Zk9lba7iMKjvR4karzUHTKBJB
 9yFQUTNIXWwvCz271FNz7w4qP1fSIt1eunxV5WzYZ2ZUsyWO8BJRIQDCRxeFgd1GHztxJ/wPq
 dsDTw+6nvLpWPscXX+sOE8G3E5o=
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
> At balance_level(), instead of doing a BUG_ON() in case we fail to recor=
d
> tree mod log operations, do a transaction abort and return the error to
> the callers. There's really no need for the BUG_ON() as we can release
> all resources in this context, and we have to abort because other future
> tree searches that use the tree mod log (btrfs_search_old_slot()) may ge=
t
> inconsistent results if other operations modify the tree after that
> failure and before the tree mod log based search.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ctree.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index d6c29564ce49..d60b28c6bd1b 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1054,7 +1054,12 @@ static noinline int balance_level(struct btrfs_tr=
ans_handle *trans,
>   		}
>
>   		ret =3D btrfs_tree_mod_log_insert_root(root->node, child, true);
> -		BUG_ON(ret < 0);
> +		if (ret < 0) {
> +			btrfs_tree_unlock(child);
> +			free_extent_buffer(child);
> +			btrfs_abort_transaction(trans, ret);
> +			goto enospc;
> +		}
>   		rcu_assign_pointer(root->node, child);
>
>   		add_root_to_dirty_list(root);
> @@ -1142,7 +1147,10 @@ static noinline int balance_level(struct btrfs_tr=
ans_handle *trans,
>   			btrfs_node_key(right, &right_key, 0);
>   			ret =3D btrfs_tree_mod_log_insert_key(parent, pslot + 1,
>   					BTRFS_MOD_LOG_KEY_REPLACE);
> -			BUG_ON(ret < 0);
> +			if (ret < 0) {
> +				btrfs_abort_transaction(trans, ret);
> +				goto enospc;
> +			}
>   			btrfs_set_node_key(parent, &right_key, pslot + 1);
>   			btrfs_mark_buffer_dirty(parent);
>   		}
> @@ -1188,7 +1196,10 @@ static noinline int balance_level(struct btrfs_tr=
ans_handle *trans,
>   		btrfs_node_key(mid, &mid_key, 0);
>   		ret =3D btrfs_tree_mod_log_insert_key(parent, pslot,
>   						    BTRFS_MOD_LOG_KEY_REPLACE);
> -		BUG_ON(ret < 0);
> +		if (ret < 0) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto enospc;
> +		}
>   		btrfs_set_node_key(parent, &mid_key, pslot);
>   		btrfs_mark_buffer_dirty(parent);
>   	}
