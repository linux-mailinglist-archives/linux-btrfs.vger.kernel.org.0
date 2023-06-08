Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B07727AB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 11:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjFHJDB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 05:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbjFHJCz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 05:02:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ECE2D48
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 02:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686214965; x=1686819765; i=quwenruo.btrfs@gmx.com;
 bh=etKIUExxGUUUg9gb4YAoU4MDZjA5ZVFDlOu3dhK+P+M=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=qy+fjikPB84vYqUCCKCtaIXktrkziLPVuMdrNospICOCW66kV1Wj5Va0yftZjCzhwmtnRTy
 UKNgaAML82r3OHBJua+LRzhhfPAY8fvc2BaY8XSU2E/bRqRfp7Kxvj2KA8NfciFj+NEwgOWt4
 0bT7JBMSqBREDqDORn09q0zF1k3WPwwFdxuK4cMA1cDcBblsaDSiksBRgqW6YFXZTX5BPGvFW
 CEx8ltWBER1T+xJEaTOEPlvSk4mAI/UHSDwvTP1gltfPSzkJ9DWY7z9+ktcA0EQXa4uZZO62w
 Sa/MHp2qvwYjnDtpsONdIzSXo06e0zMmGqVy9Bxj+xnF3yJomKNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdebB-1pXZfo0u6j-00Zdg1; Thu, 08
 Jun 2023 11:02:45 +0200
Message-ID: <4c9456f8-1ea5-a5b5-855a-65d3c9ffdf1d@gmx.com>
Date:   Thu, 8 Jun 2023 17:02:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 10/13] btrfs: do not BUG_ON() on tree mod log failures at
 push_nodes_for_insert()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <3dfd1a4c01795433444b45268da1ae75563642c1.1686164820.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3dfd1a4c01795433444b45268da1ae75563642c1.1686164820.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EpHrm9oTos+m0+aW4GUOi9GYJkAGKabTA+w7tifvjfM9Pn6kay+
 Q8o+qyGhXWQcehy0CiyHuLS1DkSRaSHQJkEzOs6VihQljmb+UpaZLsfJhkwck6HSLhAmsD8
 FIMvrrIDg4E6N9owCdiIEx6QJTwQjj8brJxpsonKrrkPBpNhd96cMjNqAOeDvndCcP8rzS3
 tRjHjfwvBtky3JlrVCp3Q==
UI-OutboundReport: notjunk:1;M01:P0:7FYc7soxr2g=;XfDjkKqIxaKMkvFodeTxcYSanX9
 kn+bMmUbOsQbR2v/Ddz9PKtlk/6lsRfX7ggaQZKxghrd6DByPvKqFp88EORLQ5PyZy1KFBbeT
 4oZvxn3MZcWTsqtlfmd+vnT80zYfQnJ6USgJDOTCRLBfysyLjsGfEa8y0b0626zGJOrIC5JVd
 xae8xOp+WNmW6zNDLywLybq1mBeqd43dNFfhbQ2FSHQLBgRTOGmnKO7gse0IV0Unk+nzJU977
 cknj5jnNImP+mi2qLDQ88fLPLcBaBjVw6Y5doh8gY6TWpITC4rEAtWigjVhxXAN0kIpwcMit5
 46O3thuilLIj5HiemdZ/N8a17VJIv03VCwTf/XO4dG5soin1uIAzTUcMTQwTBcNmGBX4LaEtD
 v+6Jj6wgXbD+B1cZ+pu9dNE/oUUCluSemdH5gStV8bfbWMc0wcjpiVDv0JVAGw0AUZq2dNhOw
 3gSM7KBTBwOrNZPLYADcGFwucLOFgzxGRk2JbXR7+V5bMLnM0EJdjRli3DDrvry4Jf8Ubw1G8
 S6aFTn4PtTWMLweqJJwGcCUwsAyHw4sPs6ChJCRPK9xuL+SiMsqa6NFWzbBCCS6LyJMBLezue
 qXSLPCYXhymmX0bFhre7DDzV/wtNlpream96gpLWHpCBONTAQ9wwetBLSh2ur38N6Vurk69Gk
 u2ux/Hwmem1+9JcLhiezWFwqUNJ+4jgPMDa5B74E2dDtQCOctl53bvIuFlVquIJz5RxjfEWEm
 VZWbc1k8oco66zdhNJBf5Fa2tZxOUXvlhOcuZtLsYQCiCXm/i2cPlpE+MP1djDN7X778J0Qa5
 QwJ4qWBiE0Mv9FD32EJ9enqo4rfKNzmvMaN5+W6gh6eAkGQTuPr/svoiWEKiz09fcYN5dyFXl
 rzDC0FHHvZHYHAxX4e1HyNCUkKtt3lZEAradmQQ70rI7JngxTQ5ePs5luOAFX8ZsIkqPmPeCN
 4HKj4ydZUsVVtGUPEQyJqL5WzRA=
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
> At push_nodes_for_insert(), instead of doing a BUG_ON() in case we fail =
to
> record tree mod log operations, do a transaction abort and return the
> error to the caller. There's really no need for the BUG_ON() as we can
> release all resources in this context, and we have to abort because othe=
r
> future tree searches that use the tree mod log (btrfs_search_old_slot())
> may get inconsistent results if other operations modify the tree after
> that failure and before the tree mod log based search.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/ctree.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 2971e7d70d04..e3c949fa136f 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1300,7 +1300,12 @@ static noinline int push_nodes_for_insert(struct =
btrfs_trans_handle *trans,
>   			btrfs_node_key(mid, &disk_key, 0);
>   			ret =3D btrfs_tree_mod_log_insert_key(parent, pslot,
>   					BTRFS_MOD_LOG_KEY_REPLACE);
> -			BUG_ON(ret < 0);
> +			if (ret < 0) {
> +				btrfs_tree_unlock(left);
> +				free_extent_buffer(left);

I'm not sure if we only need to unlock and free @left.

As just lines below, we have a two branches which one unlock and free @mid=
.

Thanks,
Qu

> +				btrfs_abort_transaction(trans, ret);
> +				return ret;
> +			}
>   			btrfs_set_node_key(parent, &disk_key, pslot);
>   			btrfs_mark_buffer_dirty(parent);
>   			if (btrfs_header_nritems(left) > orig_slot) {
> @@ -1355,7 +1360,12 @@ static noinline int push_nodes_for_insert(struct =
btrfs_trans_handle *trans,
>   			btrfs_node_key(right, &disk_key, 0);
>   			ret =3D btrfs_tree_mod_log_insert_key(parent, pslot + 1,
>   					BTRFS_MOD_LOG_KEY_REPLACE);
> -			BUG_ON(ret < 0);
> +			if (ret < 0) {
> +				btrfs_tree_unlock(right);
> +				free_extent_buffer(right);
> +				btrfs_abort_transaction(trans, ret);
> +				return ret;
> +			}
>   			btrfs_set_node_key(parent, &disk_key, pslot + 1);
>   			btrfs_mark_buffer_dirty(parent);
>
