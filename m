Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1070C75C487
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 12:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjGUKVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 06:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGUKVj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 06:21:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AA13C3E
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689934804; x=1690539604; i=quwenruo.btrfs@gmx.com;
 bh=6+sjnTeHWPdQZ5nhsXKtYQmG1rawtUBo5E7bfMJiGqY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=LQSaBGjG7/prQmaLgFk3DM1VewdNPQdMarUKQoAREH8TARwGF9aaNQT4d8PB/7O4endbkpL
 VWQpazKNkmdm6kTSKpaBDU0C1zxrAFDlL0i8PBL7l6cmptxrXBiunRDNHrA/44NccA5BQuiuP
 E0rPszr2kPBEurUgE+DzTYpL4h7mxB1JamCv/e//ulHAPNccuEEDTVVnSIdZI0+tcFdJPhkig
 RzPneIyRLYLUMy1USSZ9L7nk0h/D3VOOtl2uFKEhcXF6fFWfLh/4knFk9N5T2cdK5RY2vx7PL
 /HI8cb7a9kT4p2yoQgtjC4Aimy/ulBY/CekikJEVzK2/i6uAehNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M72sJ-1qGzgC1DKR-008X6v; Fri, 21
 Jul 2023 12:20:04 +0200
Message-ID: <25161be7-27dc-be3a-3215-0e770f729191@gmx.com>
Date:   Fri, 21 Jul 2023 18:20:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] btrfs: check for commit error at
 btrfs_attach_transaction_barrier()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1689932501.git.fdmanana@suse.com>
 <ce368edf9997c7bc4bd1f0a3e7b8c9fd96450db6.1689932501.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ce368edf9997c7bc4bd1f0a3e7b8c9fd96450db6.1689932501.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gX//w87WRIPSCuSlFUOvLlcTpIGvVIQP4y2A2Rq0gWNenIUjJXc
 8CpdZWu89UvYePvFlgdcZCISGt2nBF9aPJT+0sjrhr67ABMKz4MNRvZvVH19YPIG2WS9Gz/
 3GLt0jzDN57RxSPGhBIN6m6qr2y1Vb1p84gY/E9D0kj5dIufezZOHWE1o9k2uw8n2ONaVp9
 /+gY/BSABgN5i7rYsNbUw==
UI-OutboundReport: notjunk:1;M01:P0:P661a7sqxtE=;9sO/EYzZIO/tMwm34zy9oas6W+P
 LDQH8qcBJQOlm+kSQDWAe3eaL6MtZNucr90FYp7uRaTpYkVfUsxTFAVpuu05CB5/qtxu7zDaD
 P37tjEn4Rje/n/j8dv8Aqza3dVH0aSFVYQj5oShvJeNRRftC52zScGZyg1WIGWM4m3samb6iZ
 FGZcUorZmi28+yIQmef6yfyIZt9XhwlkjiIoGqnawPW/Tj4g81LOOCHMBOi4Mpn2QNFCa+w3n
 w6jgXQ5MFG405RBBERG4L8DAoC3+MScY8b203dXki8qzQdLdjC2yCupWUvXpCZkbOLp/QLcG2
 zX12SsopsvTyp1G8rpMIQIbUGe/zYuoKIMiPaYbkIo8YX66T9blUoEpFVru8U59IcFRzP+pHP
 aFNwFhpfZv9L4xaB89vZWjhC5+ZZxRpxH+d1CreOI1twzu82rKWIwx4x/d/3F513w7lWYWUyI
 +v0RxX1Cvu4SfYDNh3VVDIXJoga7xXGOIBDzO+pDVVYVnGzXwsjEjqihoXasJVNQSc9QVSm0T
 1eHZzwgU4L4kxg4qhTPdEY8mYLBmlns8nQi2Ro8DMgkbEwNPoxr2cHEFBMJFHuwgJIenAikOr
 YQX9siPMHb4qSSMzazzTdMcBEPHKSfpSG0l9vZxwz0remiyA3VBI7If47ZC+0Ug992JIiZHZr
 LBsGeSfTZOpaSo1FwSEU3VSz91es1P8itbEVjGYotRqBt7um+fS+BUzfHLVQogCPeMPK4+ynV
 Awfw1V43nHkc8x6sg+YC91J7krN3ZnvgNYyx5SmVor33OKGyXv2MnLw1YsPbACnDtRGhKWeQH
 zW9+aOh40cLINYa9wF6u6x9TwP/4O3/DFEwXLLBhYNvJQ+70JGSqc0k+iGrDhU+b1yMZrRrb4
 tXzHA4CiSAJ0mXgU7E/BAjWxn9qUjUg+cHCiTf8S2cuTvBEhTRoEpMBJd9NFXS+4kN/tPCcZN
 LivQXYS4DONUrAyGX27R7d+MOcQ=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/21 17:49, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> btrfs_attach_transaction_barrier() is used to get a handle pointing to t=
he
> current running transaction if the transaction has not started its commi=
t
> yet (its state is < TRANS_STATE_COMMIT_START). If the transaction commit
> has started, then we wait for the transaction to commit and finish befor=
e
> returning - however we completely ignore if the transaction was aborted
> due to some error during its commit, we simply return ERR_PT(-ENOENT),
> which makes the caller assume everything is fine and no errors happened.
>
> This could make an fsync return success (0) to user space when in fact w=
e
> had a transaction abort and the target inode changes were therefore not
> persisted.
>
> Fix this by checking for the return value from btrfs_wait_for_commit(),
> and if it returned an error, return it back to the caller.
>
> Fixes: d4edf39bd5db ("Btrfs: fix uncompleted transaction")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/transaction.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 8ab85465cdaa..4bb9716ad24a 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -826,8 +826,13 @@ btrfs_attach_transaction_barrier(struct btrfs_root =
*root)
>
>   	trans =3D start_transaction(root, 0, TRANS_ATTACH,
>   				  BTRFS_RESERVE_NO_FLUSH, true);
> -	if (trans =3D=3D ERR_PTR(-ENOENT))
> -		btrfs_wait_for_commit(root->fs_info, 0);
> +	if (trans =3D=3D ERR_PTR(-ENOENT)) {
> +		int ret;
> +
> +		ret =3D btrfs_wait_for_commit(root->fs_info, 0);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
>
>   	return trans;
>   }
