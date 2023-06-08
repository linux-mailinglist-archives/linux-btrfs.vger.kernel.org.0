Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F82727B2A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjFHJZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 05:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjFHJZz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 05:25:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877FAE50
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686216348; x=1686821148; i=quwenruo.btrfs@gmx.com;
 bh=6dOQdv4BGBJ06O73w6vo1CqvZuB6nYZVd8Lv0zyEeXc=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=C5nqUZBYVDVCtHjfv4X4MLJs/5GFQB39dkmPC4hWFf7AFlD/X34h5j1bs/EMXVYFqR4ygZi
 3hVfjz0TJixUPHW8c7Yd3d1wuBb/ugQYPJCNh7cArMBqmcOwyJRmg7COP6TvezF4kDy8g5i+c
 0zQpYywL7Y7bugdoSmxkpzZuO00etr3NCjyY6TbZsoJIsagnN5WjokvsMCMI4Y/wr3UBxwOfa
 6w4X0mQVHfF/GSIzSzjjWtyCCSvwjOhs82ESur/OFlcj/cAUA27VearTg/6T+R5FGuORhpYyV
 oYOqF/43nJVA7ij1NG3cSAtO6rQ8h4XUoS/SLB0k4ziqi5otFk4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Fnj-1qCwWa3xod-006Nce; Thu, 08
 Jun 2023 11:25:48 +0200
Message-ID: <32aa233d-31ff-632a-22a3-9d91b4420537@gmx.com>
Date:   Thu, 8 Jun 2023 17:25:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <8cb7f172ba4c37685955b891ba91f57aa3daea76.1686164800.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 01/13] btrfs: add missing error handling when logging
 operation while COWing extent buffer
In-Reply-To: <8cb7f172ba4c37685955b891ba91f57aa3daea76.1686164800.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9ds8s6ma/z8WV4OSSRzwuEycvbLko+pYrFNZtuvhZKtNtn+7XV4
 Ki9QKWaSuozhacZqSDagsR4BFmhXSodCf0jxCjY+mubYv7KEsL06LP5+U499PrpjyzJscv/
 /2xygYFcUT8lraDa7/uOPULNfnHB/504MpA+qEM3KQ44voHrTkK5NCzUxUfipq8Zn1qtkxN
 Vs3/BRhJdfkNk/bgysHZQ==
UI-OutboundReport: notjunk:1;M01:P0:VkGUppbEUUg=;HOjbb70sgtCmpByuwBh8uy9S2Kl
 TOhlnrvx1Elduca4GK34jaPD5CPd+spsQdakip2MV9nYkj4QYO0VaVK0MLid8ENh3RtwQSLp2
 6Kl6NtU2cAICmNzYy7KQhIbGv5o5lrVjwIEKsX4KO+PTEh3IbCx8IDiPvrBVjjm5axH4M0ECr
 /XnL9o0wQhhBJ3Khv8tgOGTjVJvqaEl3rraNivWNcbscbA+gQ3Rwmr6zKzdLxcYGmJ6rzhL6j
 mxSt05semtgPI8ClekffNM81vUGj/Ckf4SMceQXxJYUlcOsOZo+JY7GpDPBsU4/AGHtPjJCE7
 2rKFbsp/ARgFWEMScESqim6zi62UQFstsUf0XFya7p6o+ryDcPyO+YJrmtKJgM0MtkKIWTEvN
 LeQO4vcP/P0hduW2mFE93VKaOF3yQQkPYR+KlxWUOEG2LMDjndUsrUHeuABiLCTuAwX14iwnB
 eehutMV9HIaDiYGz6c/FMUoSbW6m5r05GKpuQCa77pWutkBxse3MhUGYM/zhREmht/VpCFSgs
 bFUEbgik2OXYE44wQTzUrjPrpJt1sDb8jc9dpKaxpoDwzEOoLADl+iFYXxwOQfdahpiZqDP0A
 1uP/x9bhVfn3s4P7cn6ZqrJZewnQ1Lx6kdXMeBKhl2jUMzvEgcuGfhkFAFmxj4APqDeh/70lZ
 FtiM55Oq7gMgfwZG5IC3OnJ9PFuWbq5rj4bVjIE9Hm3gTtNkSMOzaRoD+3Dp4BUqEX74WsoJ5
 ZBq36Fm0HzPebNx4LJcF16p1pWPgJ72swo1DwJrRS4YTxCDRugJ4mfZ7quA1g3WJ1DqDxko+W
 K6Akx4u+kR8SP9yTx+jRfXagu1UhFc47cJHKFSCE1hJJ6nPjbFoJwOY+mIISlJlL2qbqC9Caf
 lnIuQEBo9pFIDeSvCRli3Ha1T3udiJEJiDsliDFKpNGJLe9TsnhQFQJSiybJShuFN9DrAwKn8
 AnGULsOtUICI5uJvC4DoCh/nrYQ=
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
> When COWing an extent buffer that is not the root node, we need to log i=
n
> the tree mod log that we replaced a pointer in the parent node, otherwis=
e
> a tree mod log user doing a search on the b+tree can return incorrect
> results (that miss something). We are doing the call to
> btrfs_tree_mod_log_insert_key() but we totally ignore its return value.
>
> So fix this by adding the missing error handling, resulting in a
> transaction abort and freeing the COWed extent buffer.
>
> Fixes: f230475e62f7 ("Btrfs: put all block modifications into the tree m=
od log")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ctree.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 385524224037..7f7f13965fe9 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -595,8 +595,14 @@ static noinline int __btrfs_cow_block(struct btrfs_=
trans_handle *trans,
>   		add_root_to_dirty_list(root);
>   	} else {
>   		WARN_ON(trans->transid !=3D btrfs_header_generation(parent));
> -		btrfs_tree_mod_log_insert_key(parent, parent_slot,
> -					      BTRFS_MOD_LOG_KEY_REPLACE);
> +		ret =3D btrfs_tree_mod_log_insert_key(parent, parent_slot,
> +						    BTRFS_MOD_LOG_KEY_REPLACE);
> +		if (ret) {
> +			btrfs_tree_unlock(cow);
> +			free_extent_buffer(cow);
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
>   		btrfs_set_node_blockptr(parent, parent_slot,
>   					cow->start);
>   		btrfs_set_node_ptr_generation(parent, parent_slot,
