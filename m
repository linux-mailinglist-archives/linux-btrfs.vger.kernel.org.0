Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D71972F0CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 02:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbjFNALb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 20:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjFNALa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 20:11:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E131AD
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686701483; x=1687306283; i=quwenruo.btrfs@gmx.com;
 bh=zAjoBWAyfC9E/xzh1Y1xjEmwTn+m4eUhCXk73zISLNk=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=Tka0b23DPuFS/Y9m/Ukrd7R+tZjxuXdVbWK0AsYuLsxRWOeQx7Tkvov/fWfK0dckfHepP+6
 uf93XULnxHzFAFUSbr6Z5pZxbz+rQcUSumCz6o0cNHAy439FBulMwoCJXRCKji+zBU+4zkb56
 TUv5pLczTZBC/4fjoBOSidouh8aEicOLQ+ejFc0KxVZc/4bxD2NHn/QEb51PvrmirOhRgeY7B
 a8VSqYMk3C0QzLCME9TDFC6EBewANPd/wsTx2SM41H2/2elezx44ns3RCe0a1pn62hHw8cSo4
 5sG4D50caHfZxNZHA/smOaC3fdly8BiL2WEQxWtKBEvzpExG+wHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mBQ-1pzZVG2EJg-0137Ei; Wed, 14
 Jun 2023 02:11:23 +0200
Message-ID: <dfe42519-b336-93ca-5843-aee959af24c4@gmx.com>
Date:   Wed, 14 Jun 2023 08:11:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: do not BUG_ON after failure to migrate space
 during truncation
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <ef45ecc23ffac44258794dfebaedd30e2db27a45.1686672418.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ef45ecc23ffac44258794dfebaedd30e2db27a45.1686672418.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4fJI1ElFLHuXabZ5Tn1/GPKPQiJ3VM0tJs9trayiY1K5GKw8EjZ
 QbDErGlr4JiP2qmyEQcj0nq2jYeucoyJmrftODkSyoWp9AAhx4irr3fFmcgN/MpPFZnNBov
 l2P/qpiFfrLWQSG5ktCLoR6iZztM3nNnwyniin/37Q1zhGOZcTV4jkKK7xcFgP9hPVkL/gr
 ODJ30mK2bZ4EkqEF7/Mfg==
UI-OutboundReport: notjunk:1;M01:P0:KISmfo2ZHVg=;BkDPo/5+aXgRhO2sWcICGpkpuy4
 Nf5FqGIPqgyZ6XsVx9R2WoPqsvODXvs3oWslqeyRFfKKQc2wJM1H5R6V+jDGl1DyMgq1ArIi/
 Cq8TYaW5VJx+I13UF4clSw4kaopxC9++H7VWO1daYZujr71zjkvTQhxIhGKDADOfdt/loUlfw
 fFGzpB7NSp9XY+A6+ON0CiGnCLAAUNZyyfn+KdHsLj6EyufaRTz1AMhNL1EdhvrtrksVLnO0L
 SAuzYcSqSjcT0ftBhm/olKjMFBQJ47JFTkzC9sT0m8vH+o6tu1X/2DzQMGuqqc31g+bPU9ZVn
 Gp8lZbh68/R66ktwk4YkjD9CpF3IbLOV3GXyWac4df6w9arqjr4RSKVqbyzq3nPH8fSAFFgZJ
 LuWkHy7gZXcEL9k0slbSuDZCh7VxmYRJHUVUYyQC6Pg8wFSc2xB7+yXOMXmqX4TKO99uTrxap
 yMSrWy1QjSAtd1wnhF2B9IPAv843S8onLY8SRfwScNX2QPL9ZNVMlJol/rz9I0pagnW6UOEE+
 O6OFhQ0X632tiXxxQnby0BtIZoAl6e4usTJMxe/L4XGRQy+S8caAsNA1oiMj2aLXpypXVlOK4
 FMBuT5qIqkdxAThgNOC7dZIIQgu31l2cY/S1HLqDwV7jPim87JYdjvOnDhUCqF7x85AlxiITB
 6eEWWSAiBqa6F6gBe804fZzhi1CIrI5l1GdQMfFjZ2ojmru+MTDHtv3FTolMNITsqLrUNzPH7
 SYuexpZNEIDbKwLVtOwzs2gd4/Dh+utqDHfKFFXMteZ3lNBV+tsOmBcDFdUcHCHuoPKqeZolH
 6LXgL3Em6/5JhBhyubku58UEwNmPy/t77DzTUTx5HuDe/kgGrmWnAWrpCXJPM6uqMyWq4LZBN
 GcQt40NdGMQWz3BXK5Y8KGyhvSnTCXRHkEKN9ExGN5cEZczrhw4y2ilNHH83rse65kNQxG+vo
 8495cQ==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/14 00:07, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> During truncation we reserve 2 metadata units when starting a transactio=
n
> (reserved space goes to fs_info->trans_block_rsv) and then attempt to
> migrate 1 unit (min_size bytes) from fs_info->trans_block_rsv into the
> local block reserve. If we ever fail we trigger a BUG_ON(), which should
> never happen, because we reserved 2 units. However if we happen to fail
> for some reason, we don't need to be so dire and hit a BUG_ON(), we can
> just error out the truncation and, since this is highly unexpected,
> surround the error check with WARN_ON(), to get an informative stack
> trace and tag the branh as 'unlikely'. Also make the 'min_size' variable
> const, since it's not supposed to ever change and any accidental change
> could possibly make the space migration not so unlikely to fail.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 094664d9262b..c57623cb1a78 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8335,7 +8335,7 @@ static int btrfs_truncate(struct btrfs_inode *inod=
e, bool skip_writeback)
>   	int ret;
>   	struct btrfs_trans_handle *trans;
>   	u64 mask =3D fs_info->sectorsize - 1;
> -	u64 min_size =3D btrfs_calc_metadata_size(fs_info, 1);
> +	const u64 min_size =3D btrfs_calc_metadata_size(fs_info, 1);
>
>   	if (!skip_writeback) {
>   		ret =3D btrfs_wait_ordered_range(&inode->vfs_inode,
> @@ -8392,7 +8392,15 @@ static int btrfs_truncate(struct btrfs_inode *ino=
de, bool skip_writeback)
>   	/* Migrate the slack space for the truncate to our reserve */
>   	ret =3D btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, rsv,
>   				      min_size, false);
> -	BUG_ON(ret);
> +	/*
> +	 * We have reserved 2 metadata units when we started the transaction a=
nd
> +	 * min_size matches 1 unit, so this should never fail, but if it does,
> +	 * it's not critical we just fail truncation.
> +	 */
> +	if (WARN_ON(ret)) {
> +		btrfs_end_transaction(trans);
> +		goto out;
> +	}
>
>   	trans->block_rsv =3D rsv;
>
> @@ -8440,7 +8448,14 @@ static int btrfs_truncate(struct btrfs_inode *ino=
de, bool skip_writeback)
>   		btrfs_block_rsv_release(fs_info, rsv, -1, NULL);
>   		ret =3D btrfs_block_rsv_migrate(&fs_info->trans_block_rsv,
>   					      rsv, min_size, false);
> -		BUG_ON(ret);	/* shouldn't happen */
> +		/*
> +		 * We have reserved 2 metadata units when we started the
> +		 * transaction and min_size matches 1 unit, so this should never
> +		 * fail, but if it does, it's not critical we just fail truncation.
> +		 */
> +		if (WARN_ON(ret))
> +			break;
> +
>   		trans->block_rsv =3D rsv;
>   	}
>
