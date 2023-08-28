Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F678A7F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjH1Imy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 04:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjH1ImV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 04:42:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C5CE5
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693212131; x=1693816931; i=quwenruo.btrfs@gmx.com;
 bh=vRIzK+INdZcXP5avjPHwt68Xj4N+fMpXjxL4sCQNQXs=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=YEm6qriX6t4db5/wso2xCsZt8IxmAAomnhdCp4xeb858ZVEIruyjfJAbV2nFI/tFkXbtIA/
 +jxM/w+8UOA5cYpk4npYRLdRAXvPHIMARukPJSvp9C24SF0NaKktRX6t5ugXLYWVGngJk3sx4
 2Php5cahbAztY8k0KKnBBzXY4xE2J4jWzo38AMdMgQ9+aXYYmqly4Yskz/QgMyJTwN2FNY9fZ
 hVaUxNYkdEe+79qWHP22TgGFEWH0BIzqv6LDwbK18ckmR/QX84tit/s2guGRWtC/OLd8bHGJt
 wP1kn601v6aOe77LIl5JJQKNryVBazUMxNVHRDGpM8QPtp/fbFYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbox-1qLsQS0M8J-00P2Kx; Mon, 28
 Aug 2023 10:42:11 +0200
Message-ID: <74ce2e98-97ed-4f3a-9929-ec5b92fb5dcc@gmx.com>
Date:   Mon, 28 Aug 2023 16:42:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] btrfs: remove BUG() after failure to insert
 delayed dir index item
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1693209858.git.fdmanana@suse.com>
 <ee7caf888c95075685cd068d6e78f96be283b4b5.1693209858.git.fdmanana@suse.com>
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
In-Reply-To: <ee7caf888c95075685cd068d6e78f96be283b4b5.1693209858.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zmPE1JCFKTyCLx51MIcpbS984deK7d2tUpHt3NXFO1jMkJ32R7A
 jDrt2RuJks1BGRL0kVl4DMYZszdYv5dKVc48HZtDc4NUaDnmGwMeRwCsQU3RcmqTuSdSMoI
 vB3fipBrzsE2DjfFlqBHfcvvwr8Xn7tnvSsprW0nu2xZHSMRGLUkLmT55FxzuMj5Ntyv0Ue
 K21wes8c37GLURlHgos2Q==
UI-OutboundReport: notjunk:1;M01:P0:+cNX+b/pPQs=;UBez0STSxwCU1ogUAC64fpUFyUn
 G/HrNTdquV8KqJbfL8eSePc2bBpebrccLvGNkTXxNwUHRe2wXdqgmCJXAO7jUND1gfjY9mwy9
 6qAdxXQYMGwigaBJ3AkuV4YOLocLpgeQawT2+8fs7kCQFfGDamkmeFmYqVjcNV6fioUdc7GwP
 p6zfrgH3eVn3JKDItaJmrxt7mYrvC+Z38ivNkUPSiigkpHaCSsgOCS0+CtZokhHB7gi9PeRg3
 WkkL8r/omLh9JPwqlR8EWH0aWpKIXFU33r3NOQyWNWptyUMfsfIKJPB13S2jXWJEuCyxXCwbW
 hKlHYb+k1VJh9iICtv6/66lko9TXOJ2PqXU3A3xnQCyUbV96nudvC0KUPJRzZ6dVFGZa66hFD
 yd4Q1/gW1uRwP74gvv4Kgu9P80zMTlW26zH8kwRopFWtLWuP3gY8F56iE90deP0CgIJWJ8+tH
 FMbcR2uzQ1zc97iRcu7Ssg0H5ZAcVR/Vsc1RU0BrEXYvrxZ81CwlU6PW5Y8g5Cff6NWZSQFah
 g2zCaHJqsg2udR/PpVKkPGGwunnbTuiRphlYPwX7yPlt+0rHPAnUOkmcag64eIslbH7wj4zJa
 4bgA0NB9YcP+sW/l+cf1beAIV2rEYmmVQRLuVDGAL67jx+eVjnD0y93er2yyN1aiTA3TKcNYX
 Uoi72h9YOs3E9Mn32c/amGr9ab6E1dKLRV+AUHMD0B2LVokTZIy01ED7tYnwssRiQT1AwDI4O
 h186QCJbGiQ/8bZ4M53fFznm9FU18KYbSKk9zp95WEa/YGgVTzvqhmAdIuUgEUSLpImdVmC29
 GTz6yWy4xFD8uJqp0S4FNFIzdZ6FqM6WNZoPeC9vdEcOFoAiQ5HArXe/yfLjzTcGYnZ7zNJaw
 t7MkfYI9OXUfHLy7/kjz4fUTZcY+t6lOmkU99eOeEdFGZ3v4YLjEKQDgCd9EBtIWqzYsERB2o
 7bfBDnrK9Es4PDVw83kSEvwfV78=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/28 16:06, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Instead of calling BUG() when we fail to insert a delayed dir index item
> into the delayed node's tree, we can just release all the resources we
> have allocated/acquired before and return the error to the caller. This =
is
> fine because all existing call chains undo anything they have done befor=
e
> calling btrfs_insert_delayed_dir_index() or BUG_ON (when creating pendin=
g
> snapshots in the transaction commit path).
>
> So remove the BUG() call and do proper error handling.
>
> This relates to a syzbot report linked below, but does not fix it becaus=
e
> it only prevents hitting a BUG(), it does not fix the issue where someho=
w
> we attempt to use twice the same index number for different index items.
>
> Link: https://lore.kernel.org/linux-btrfs/00000000000036e1290603e097e0@g=
oogle.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/delayed-inode.c | 74 +++++++++++++++++++++++++---------------
>   1 file changed, 47 insertions(+), 27 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index f9dae729811b..eb175ae52245 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1413,7 +1413,29 @@ void btrfs_balance_delayed_items(struct btrfs_fs_=
info *fs_info)
>   	btrfs_wq_run_delayed_node(delayed_root, fs_info, BTRFS_DELAYED_BATCH)=
;
>   }
>
> -/* Will return 0 or -ENOMEM */
> +static void btrfs_release_dir_index_item_space(struct btrfs_trans_handl=
e *trans)
> +{
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	const u64 bytes =3D btrfs_calc_insert_metadata_size(fs_info, 1);
> +
> +	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
> +		return;
> +
> +	/*
> +	 * Adding the new dir index item does not require touching another
> +	 * leaf, so we can release 1 unit of metadata that was previously
> +	 * reserved when starting the transaction. This applies only to
> +	 * the case where we had a transaction start and excludes the
> +	 * transaction join case (when replaying log trees).
> +	 */
> +	trace_btrfs_space_reservation(fs_info, "transaction",
> +				      trans->transid, bytes, 0);

I know this is from the old code, but shouldn't we use "-bytes" instead?

Otherwise looks fine to me.

Thanks,
Qu

> +	btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
> +	ASSERT(trans->bytes_reserved >=3D bytes);
> +	trans->bytes_reserved -=3D bytes;
> +}
> +
> +/* Will return 0, -ENOMEM or -EEXIST (index number collision, unexpecte=
d). */
>   int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
>   				   const char *name, int name_len,
>   				   struct btrfs_inode *dir,
> @@ -1455,6 +1477,27 @@ int btrfs_insert_delayed_dir_index(struct btrfs_t=
rans_handle *trans,
>
>   	mutex_lock(&delayed_node->mutex);
>
> +	/*
> +	 * First attempt to insert the delayed item. This is to make the error
> +	 * handling path simpler in case we fail (-EEXIST). There's no risk of
> +	 * any other task coming in and running the delayed item before we do
> +	 * the metadata space reservation below, because we are holding the
> +	 * delayed node's mutex and that mutex must also be locked before the
> +	 * node's delayed items can be run.
> +	 */
> +	ret =3D __btrfs_add_delayed_item(delayed_node, delayed_item);
> +	if (unlikely(ret)) {
> +		btrfs_err(trans->fs_info,
> +"error adding delayed dir index item, name: %.*s, index: %llu, root: %l=
lu, dir: %llu, dir->index_cnt: %llu, delayed_node->index_cnt: %llu, error:=
 %d",
> +			  name_len, name, index, btrfs_root_id(delayed_node->root),
> +			  delayed_node->inode_id, dir->index_cnt,
> +			  delayed_node->index_cnt, ret);
> +		btrfs_release_delayed_item(delayed_item);
> +		btrfs_release_dir_index_item_space(trans); > +		mutex_unlock(&delayed=
_node->mutex);
> +		goto release_node;
> +	}
> +
>   	if (delayed_node->index_item_leaves =3D=3D 0 ||
>   	    delayed_node->curr_index_batch_size + data_len > leaf_data_size) =
{
>   		delayed_node->curr_index_batch_size =3D data_len;
> @@ -1472,37 +1515,14 @@ int btrfs_insert_delayed_dir_index(struct btrfs_=
trans_handle *trans,
>   		 * impossible.
>   		 */
>   		if (WARN_ON(ret)) {
> -			mutex_unlock(&delayed_node->mutex);
>   			btrfs_release_delayed_item(delayed_item);
> +			mutex_unlock(&delayed_node->mutex);
>   			goto release_node;
>   		}
>
>   		delayed_node->index_item_leaves++;
> -	} else if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
> -		const u64 bytes =3D btrfs_calc_insert_metadata_size(fs_info, 1);
> -
> -		/*
> -		 * Adding the new dir index item does not require touching another
> -		 * leaf, so we can release 1 unit of metadata that was previously
> -		 * reserved when starting the transaction. This applies only to
> -		 * the case where we had a transaction start and excludes the
> -		 * transaction join case (when replaying log trees).
> -		 */
> -		trace_btrfs_space_reservation(fs_info, "transaction",
> -					      trans->transid, bytes, 0);
> -		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
> -		ASSERT(trans->bytes_reserved >=3D bytes);
> -		trans->bytes_reserved -=3D bytes;
> -	}
> -
> -	ret =3D __btrfs_add_delayed_item(delayed_node, delayed_item);
> -	if (unlikely(ret)) {
> -		btrfs_err(trans->fs_info,
> -"error adding delayed dir index item, name: %.*s, index: %llu, root: %l=
lu, dir: %llu, dir->index_cnt: %llu, delayed_node->index_cnt: %llu, error:=
 %d",
> -			  name_len, name, index, btrfs_root_id(delayed_node->root),
> -			  delayed_node->inode_id, dir->index_cnt,
> -			  delayed_node->index_cnt, ret);
> -		BUG();
> +	} else {
> +		btrfs_release_dir_index_item_space(trans);
>   	}
>   	mutex_unlock(&delayed_node->mutex);
>
