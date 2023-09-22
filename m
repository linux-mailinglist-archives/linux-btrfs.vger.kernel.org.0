Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32687ABBA9
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjIVWMw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjIVWMw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:12:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70F719A
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695420760; x=1696025560; i=quwenruo.btrfs@gmx.com;
 bh=uSPp3rwXzvpFUvmXaA9NJBd7U+cAIiotyFZBqS6RKy4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=aeYc3A8471e4gc19TTaXEqHIsu8FsJndkx/vriUB+mBYmyOHk44UySdZ7SRRKpKRvZVZXUeRKmS
 TTc+g8YrHXIbFP4zkAVqQTxcZRbuh7XG1TgKavL20RW/62t8RVcOwTOMAA8EEj+UkGcuHMUDk/kTC
 xQ3raJMvn0NwJqpuFkmNp/uLp/c+kj5S3ZXoI85c2luMz02devFJoBQ7ttFkggUUf7s5BPSt8KWlI
 3jtyBB9/PSepwU/uJ13raCDtmQl57/P81lZRLIggZ5Y3g9xBkVpXPzA14Rx7UY34Ma0Ukd7/Q5BoN
 EFbVgVrhttD5XTA7qR8Nzy6oKVr0B22WBpfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mirna-1rMQzL2DIK-00eqZr; Sat, 23
 Sep 2023 00:12:40 +0200
Message-ID: <1a66c704-caf0-4773-aa0d-860e37ed5a20@gmx.com>
Date:   Sat, 23 Sep 2023 07:42:38 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: move btrfs_defrag_root() to defrag.{c,h}
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <9474fc4f5eca4a1e7bb38dd1cd2bd01537c4315a.1695335503.git.fdmanana@suse.com>
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
In-Reply-To: <9474fc4f5eca4a1e7bb38dd1cd2bd01537c4315a.1695335503.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cg7/L05QGXAKb2MCjKScVh+jXUfzIqjIO6wTLMETrSjZ1gTGyvG
 ZvrsteZHB8ib7zsYZx5zKIZsedHyKjrAGUnwNscJBbzCfrTjNr1UQg9CZ7wACiiySpNk4XW
 6uiYhwhnIhjo68WLPa6PaUcLl/7UmVPdGEuMfB5GIXDqMJ6rmxfuEkqQ5p3r+9rVyHSaHBl
 bwgqihFIJo1WljxcRHMhg==
UI-OutboundReport: notjunk:1;M01:P0:RCdEiAOnVmg=;cajYUgACg1GIHZcMsPOhWUM5Jeh
 uZVQtbT3t9vZorkwr5IeD75ohKxQcWZmsg7IXX0fMglnkXqp1rrJE4VkIqaT/+A0xrBD+GRLS
 7ep+ceWOnzVshM2wqmLQhbe/cjYxquhWxI135lIOrZ+bLrShq9g69n1Ff5lN3qmbfxELvfVre
 Jp2zXwun1Om6CG4MHPKA0knncQzdIwNVSWi9drmYWsd8as2dADePk1Fg4TdL3jBk/ZiqQ5tKk
 InLX2Ca/9tehyV7xMxvOj/+c1xL6HAERGEDOZkaIp+cVY0h9qUV1MIPivLBFS7B4G/ApbXAF2
 S9b5IeuoIVa0IqqjMwnxiUTgT4lQQaTkQ2I8rk4BITfVK+BXnpxAErKMiVHthCSIoN3cfMzoF
 qpK5ExWfMyHLER3ysATzTK3i+Mv9q/uaKSoPi4jhSE6Wt8s6qi5QCym8d0yKcTFYITRSYEGOR
 4KjlO1PD+oNTdmG8N1qrCSw3lh1Bt/uR/EKAVzsFdG7PewtBZPZD7UkAEJiAGjhBLWKsnSq6v
 8gsIWbGXBuXNjrvCStdswCYPIbYmhFy+3Ej2nmhTJ9HUYM1fLjchD2T9/+DAYBQj8854OgXTx
 0e2LmHajWFEfPVUPVZAdZ0/+PRaWNmp0d66o8CiO2WU7euKfUY9yDrbaGgV5GIfH88uqH+aT2
 nSf46T7zFcb+pkTRO1ram+M78JQgRjJ/kriMbEe0JxIlPUq68wbNSrFZHvhPVzOotSu/fOwlE
 SSjVccnc4ed/1EU/vVLRBgv5QGdCxJ4G9U6k7b3ZJ+wPRqYLs42StU2p0e9kJ4/QrEH+2/vRl
 MXskDfsVeCewgzKAK2+CxNWk9ovIz+vDVuledMoWTk5WDBZ8TgUBx2hvGZD2e/bknRSuM8O7s
 GiD14E6kcdMO+I7VvYdjOHzyLUlKuO6w6SqcafP9PBOoNQpo4h3LZczvfzvhCNQnhDMqxrnFK
 kQt58FCWJzLfhOEUOlwCPudnpko=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 20:07, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The btrfs_defrag_root() function does not really belong in the
> transaction.{c,h} module and as we have a defrag.{c,h} nowadays,
> move it to there instead. This also allows to stop exporting
> btrfs_defrag_leaves(), so we can make it static.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/defrag.c      | 44 ++++++++++++++++++++++++++++++++++++++++--
>   fs/btrfs/defrag.h      |  2 +-
>   fs/btrfs/transaction.c | 39 -------------------------------------
>   fs/btrfs/transaction.h |  1 -
>   4 files changed, 43 insertions(+), 43 deletions(-)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index f2ff4cbe8656..53544787c348 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -343,8 +343,8 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs=
_info)
>    * better reflect disk order
>    */
>
> -int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
> -			struct btrfs_root *root)
> +static int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
> +			       struct btrfs_root *root)
>   {
>   	struct btrfs_path *path =3D NULL;
>   	struct btrfs_key key;
> @@ -460,6 +460,46 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *=
trans,
>   	return ret;
>   }
>
> +/*
> + * Defrag a given btree.
> + * Every leaf in the btree is read and defragged.
> + */
> +int btrfs_defrag_root(struct btrfs_root *root)
> +{
> +	struct btrfs_fs_info *info =3D root->fs_info;
> +	int ret;
> +
> +	if (test_and_set_bit(BTRFS_ROOT_DEFRAG_RUNNING, &root->state))
> +		return 0;
> +
> +	while (1) {
> +		struct btrfs_trans_handle *trans;
> +
> +		trans =3D btrfs_start_transaction(root, 0);
> +		if (IS_ERR(trans)) {
> +			ret =3D PTR_ERR(trans);
> +			break;
> +		}
> +
> +		ret =3D btrfs_defrag_leaves(trans, root);
> +
> +		btrfs_end_transaction(trans);
> +		btrfs_btree_balance_dirty(info);
> +		cond_resched();
> +
> +		if (btrfs_fs_closing(info) || ret !=3D -EAGAIN)
> +			break;
> +
> +		if (btrfs_defrag_cancelled(info)) {
> +			btrfs_debug(info, "defrag_root cancelled");
> +			ret =3D -EAGAIN;
> +			break;
> +		}
> +	}
> +	clear_bit(BTRFS_ROOT_DEFRAG_RUNNING, &root->state);
> +	return ret;
> +}
> +
>   /*
>    * Defrag specific helper to get an extent map.
>    *
> diff --git a/fs/btrfs/defrag.h b/fs/btrfs/defrag.h
> index 5305f2283b5e..5a62763528d1 100644
> --- a/fs/btrfs/defrag.h
> +++ b/fs/btrfs/defrag.h
> @@ -12,7 +12,7 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *=
trans,
>   			   struct btrfs_inode *inode, u32 extent_thresh);
>   int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
>   void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
> -int btrfs_defrag_leaves(struct btrfs_trans_handle *trans, struct btrfs_=
root *root);
> +int btrfs_defrag_root(struct btrfs_root *root);
>
>   static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info=
)
>   {
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 240dad25fa16..c05c2cd84688 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1564,45 +1564,6 @@ static noinline int commit_fs_roots(struct btrfs_=
trans_handle *trans)
>   	return 0;
>   }
>
> -/*
> - * defrag a given btree.
> - * Every leaf in the btree is read and defragged.
> - */
> -int btrfs_defrag_root(struct btrfs_root *root)
> -{
> -	struct btrfs_fs_info *info =3D root->fs_info;
> -	struct btrfs_trans_handle *trans;
> -	int ret;
> -
> -	if (test_and_set_bit(BTRFS_ROOT_DEFRAG_RUNNING, &root->state))
> -		return 0;
> -
> -	while (1) {
> -		trans =3D btrfs_start_transaction(root, 0);
> -		if (IS_ERR(trans)) {
> -			ret =3D PTR_ERR(trans);
> -			break;
> -		}
> -
> -		ret =3D btrfs_defrag_leaves(trans, root);
> -
> -		btrfs_end_transaction(trans);
> -		btrfs_btree_balance_dirty(info);
> -		cond_resched();
> -
> -		if (btrfs_fs_closing(info) || ret !=3D -EAGAIN)
> -			break;
> -
> -		if (btrfs_defrag_cancelled(info)) {
> -			btrfs_debug(info, "defrag_root cancelled");
> -			ret =3D -EAGAIN;
> -			break;
> -		}
> -	}
> -	clear_bit(BTRFS_ROOT_DEFRAG_RUNNING, &root->state);
> -	return ret;
> -}
> -
>   /*
>    * Do all special snapshot related qgroup dirty hack.
>    *
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index efc4fa9e2bd8..de58776de307 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -246,7 +246,6 @@ struct btrfs_trans_handle *btrfs_attach_transaction_=
barrier(
>   int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid);
>
>   void btrfs_add_dead_root(struct btrfs_root *root);
> -int btrfs_defrag_root(struct btrfs_root *root);
>   void btrfs_maybe_wake_unfinished_drop(struct btrfs_fs_info *fs_info);
>   int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info);
>   int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
