Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861E83F12D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 07:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhHSFnY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 01:43:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:56147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhHSFnY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 01:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629351763;
        bh=tfaWysZt3tOagGBkLkLgrm3i6dbgxtQrNXq8pWODf+w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=GKAY4blMagPLhABXT2VGzjXfpF6Ab7t72cs/EJ8vZSNDd5gsNwFkpKPD/Fs+AxtNw
         PG4Wety+yNFHFKkv9Wf8eG0EF2kgheqp1I7X9OheRBu7X1iN3+S2HYDnmzAp3lE6Qq
         qgN4jG2/L8HAWhDrtlAPQDVqOICkcATRwDCqimWw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3UZ6-1mH8mu26ra-000aaT; Thu, 19
 Aug 2021 07:42:43 +0200
Subject: Re: [PATCH v2 02/12] btrfs-progs: do not infinite loop on corrupt
 keys with lowmem mode
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
 <aaaf2cadf66d9e573e2dbcc3e8fab7984ce42f99.1629322156.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <05f2cfc1-ab2f-0e92-13ef-488a9e7d716c@gmx.com>
Date:   Thu, 19 Aug 2021 13:42:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <aaaf2cadf66d9e573e2dbcc3e8fab7984ce42f99.1629322156.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:meZbJgR4zmc82VLbaCeZoNj1tw/Q/qhmONQ3inEKcQ/9L9gUwlb
 orT0p333m1f86RtWZ/j5/MAAcs/ET8M2KPPbbONSWAUwSVOsSpruPyBSS2oHFWO7j/JRvcg
 ZWDKBQlDUe0NubN68z4PRKRZXcOyalpXUx0NcE5DyPggdYqpAsQbwCriW0hKZ1aHZcPaX/2
 bkAn/ceKljKBV49GALANw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KB0LqBF2raM=:SlF31Ld76W8zgSUz17YmhT
 fgqlCisJhtJyR5CRDiccEx7GtWsn/3nBrI3h9tFy8uhqoXTq0L0QP4BpUrXLHE7ku4hTFsO/e
 la+qoY05QsVCR4MiuSvThnW5mxDKplYeus5Z009pWZeig7ZJzritwn991mb3yoHf6l/ZKIfFS
 w1TluPhhpJ/zPaP5mo53w0ePXtxHEgdXaQPTMJRw/UvQq6kcz/RAN9d1gvGcC/UNYyqpeidYr
 U4Pd6F0bIXMTmov9QOmZWvcfd4g16VWJ27xivokb8zF1yAKmlIkPvxUW1NR9TBw8NDmdmzgLi
 czy0rfTq0BerbHKX57gRxhYxm5R5QpXlPsCVuc/zg87Uw0SGF5IC4JrBAKOPekm45il+aoa2g
 UH2gPDpFAV1GYeEo32TM8bPmJdtsQM59Xn42N5RSPCThXe1Tw34JX419Qk3NicGmLCyJEAxR1
 myF/zTDgzh6U1kVXFbjm1UU4pNx9be2sgr/ixUTn5FuK+iFltYWIEEn9QmE6Gx74rZ8MinkHv
 zpmhHZgNKJUepLzj1NUlbnGJQpiMMCAr3XDQlU6y39TOKNGeXohafI3f2q0WjjGXfQIdEhmgq
 SYx9A4XnFEetECmhyQ1sAsMUWLgzEGzPuGdvklxtk0y7OpZsnM9JvZTArgXQAnszWKsd42IYx
 m5kaYguRcxX6njrrIwq962zuu1MPKHTBd3B4zgpAMLVi///THq3JxqAlqg5KBwyBSFvMVLo+3
 dfTT2g2swgEcpRR08Oih1BCHrGA3C48K+h9IgX4tCiQoJFYHzB+eBFnSNymfkSoS4lw48WvwU
 qqn8hgpc/Qgb9t3tVBkv8vbl9piDH2D4eYeEyV/M63/jYbWZipvpmKtOx9Eo6/X4ROPb3ULzu
 Pe8wDcP9dsXIjzDOcb9z+rA6DFF1wjW9ialvX4JefNLfYN1613UF5JYoaexjYgGEd83rbva+T
 K4FvmBw3lPwZ21EsCSFvTv0sEazRh6as7VdFpWU00QDAi3PeRWLprpNchtp1d3UKTtT838RF5
 tBOJz3o8qbFJmFnmwIgj+XWC9fQmFngvdW3DQ6aTY41dZnlddmVV2kbnbSKoRH0hCurSuyvns
 KcBZSi3h1RobzlZCHlsTXYphwujCdtqS6LKrrko3md7UGA3MT96mvhGRQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8A=E5=8D=885:33, Josef Bacik wrote:
> By enabling the lowmem checks properly I uncovered the case where test
> 007 will infinite loop at the detection stage.  This is because when
> checking the inode item we will just btrfs_next_item(), and because we
> ignore check tree block failures at read time we don't get an -EIO from
> btrfs_next_leaf.  Generally what check usually does is validate the
> leaves/nodes as we hit them, but in this case we're not doing that.  Fix
> this by checking the leaf if we move to the next one and if it fails
> bail.  This allows us to pass the 007 test with lowmem.

Doesn't this mean btrfs_next_item() is not doing what it should do?

Normally we would expect btrfs_next_item() to return -EIO other than
manually checking the returned leaf.

Thanks,
Qu
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   check/mode-lowmem.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index 323e66bc..7fc7d467 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -2675,6 +2675,15 @@ static int check_inode_item(struct btrfs_root *ro=
ot, struct btrfs_path *path)
>   	while (1) {
>   		btrfs_item_key_to_cpu(path->nodes[0], &last_key, path->slots[0]);
>   		ret =3D btrfs_next_item(root, path);
> +
> +		/*
> +		 * New leaf, we need to check it and see if it's valid, if not
> +		 * we need to bail otherwise we could end up stuck.
> +		 */
> +		if (path->slots[0] =3D=3D 0 &&
> +		    btrfs_check_leaf(gfs_info, NULL, path->nodes[0]))
> +			ret =3D -EIO;
> +
>   		if (ret < 0) {
>   			/* out will fill 'err' rusing current statistics */
>   			goto out;
>
