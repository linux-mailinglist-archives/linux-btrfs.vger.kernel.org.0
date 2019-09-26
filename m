Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC1BECDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 09:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbfIZHuf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 03:50:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:48965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729340AbfIZHuf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 03:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569484228;
        bh=6MfDNRptN8K2Bs18EWNLZ3XhmXurEXGGWMbHO3J48fc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ckBUMQgtWZPMxWLBELopSXzlytaTFrnzNywhHviUHM0hlYwxBXxvEBBv1z096PpbS
         ple47qx4GwvAGpa35dZiDNpcfWPEHy9zQYcGifKuaX71WK3MLIC7JAWopcXrvc06ve
         UMPEqnqZcDhYGRUrKxOi2/zfgLaE5ACP0RPY/nOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPXdC-1iZtTd1PrW-00MYJw; Thu, 26
 Sep 2019 09:50:28 +0200
Subject: Re: [PATCH] btrfs: Add regression test for SINGLE profile conversion
To:     Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com, guaneryu@gmail.com
References: <20190926072635.9310-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <6a8d0118-86a6-b187-1183-4e47a260b0a6@gmx.com>
Date:   Thu, 26 Sep 2019 15:50:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190926072635.9310-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a4nSiV5G0p7xE6KTxHb0y26vpeSBRuhmrOTLJwmhUyUSBhZ09T9
 h83EMZLTmEi4LsB/f1fMU5N5zgr8VvE0yvfC5/XT2vCBN2loisKyyv0zjn3LQ4ta3Nbj1/1
 GkoVMMkGJysTEEs0e259W8SeUp56eW1XqqFfuIw/t4PmDVH8i6QcpcnIZ2UMoNdPCiEfjJE
 eDq4UcgYH+1TP5IoVEOKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tTocKF6HpwU=:q2YSiw8oMSLdfD8d01ia2g
 2K5zmpRnn6it+Une+NaUWTNbUFfhLeT1GdybsVlUSwZb0C+nVqJDNUmJh0oVNXOn/TwMFuZ7U
 FtdSH2eHkFMQ9aSbi0o7S5h7Zk6COVPmQFpsIrpMrgp+f7DEgguvMyXCMxOI5yN/13TlMNei7
 +aQKmXmOHcRVF9YVgFq5+jqGdWi7AhYxmTstfzQzcx49ftOBcOjm+QmXTUdmhXRdY9LLqvHMb
 F68gCemcdoE0tYx58odo9bt8HeZ2rAfHkcaENKbMJNmrW4Rv6Imh7tNCfspDzkFV0Kf2ZDtb+
 G7gf+XRdtD0Za4TFyujk49MPtm5xgTyiyhk8OA0jhKYdW9CoVSW9lOrQokVQMJXfkJ99dVaFe
 0cWPVfjvmuaK47bGh3zuYfZI2gx/dwswbNI6RAPKyy9X7LGz6YJUEizfwAuEmo2ZjDbMWSQKG
 wwmlZq1NT280lN+UzIGAqfF3Cfqlciev0x20PrgNmhAuSL9NipUwNtHIZqR+nt/45YYXwPus2
 fXcl02gR9QcAtuuPaQwsFP1XjOpnUIXL1plS9DEUvQkfuUEk6qn5QvXrUhiBKQhi3sFcfBHXB
 0WXtpbHdfcd453bScculMSfOhvJYJ1gDqpIoWLpfQDyQ2/2ebPA6uq8iZQxI3v4ECBg+tYbPx
 SZbzDUzT7uPUYqiEBnqRmQztSQAAEtF5Tv4F7Cx6Mg7Sf0pSqBgkPGpvrRwiz6mululZIWx5k
 korlSBj/TDtNXTIWFg5NaoRcwQqUkrGxwkufpY7AjmViYkmR5WJ7NEngerAFZ0rTyMhma4MmR
 1lHMeQKdJjSULpvRvt/D7a71PA0K1vSfgRUEpHLPNNcTHW0fO5qmUegyoT+AgXdsfVSKPo73o
 FljxE2LCeYWhJTsigAswsUykLdADPFAnvCoBYxMp842hQymZksobGLcHW0RVlO7Kv2Fz+Yent
 F9B/d4bAisQhtPfJXz0VwynL7uCbTHrZupP/QuZcB0hvBg+XEEUnuv1MZhKMn44mXFhHfp1PQ
 BKmd1CKIHC9Fb1ufsoelgtRafTvSEONURfr4S8dzWo+SkkzleVDTbRWPTaKAR02BLnf4Ti41k
 vZ4/L1AauZIEJcc+JsbkbD6926jISAbMTgb3tV5e/JN/A0YKdFoJHZBi142vMUDatUZ7iWt2/
 C+tJl23gYxk7UlUi2mojsmp/mNJSIQS47zwdR8KK8E4PNLn1Z+WW/bFPlV90uiYiVv8P9KKHj
 xEzcUgMkR3Lm5ndkyZDYi9I9O7HKNwmzRBKXan286LXFlF8twsCIbP7YsVa8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/26 =E4=B8=8B=E5=8D=883:26, Nikolay Borisov wrote:
> This is a regression test for the bug fixed by
> 'btrfs: Fix a regression which we can't convert to SINGLE profile'
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  tests/btrfs/194     | 52 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/btrfs/194.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 55 insertions(+)
>  create mode 100755 tests/btrfs/194
>  create mode 100644 tests/btrfs/194.out
>
> diff --git a/tests/btrfs/194 b/tests/btrfs/194
> new file mode 100755
> index 000000000000..8935defd3f5e
> --- /dev/null
> +++ b/tests/btrfs/194
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 194
> +#
> +# Test that block groups profile can be converted to SINGLE. This is a =
regression
> +# test for 'btrfs: Fix a regression which we can't convert to SINGLE pr=
ofile'
> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch_dev_pool 2
> +
> +_scratch_dev_pool_get 2
> +_scratch_pool_mkfs -draid1
> +
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG balance start -dconvert=3Dsingle $SCRATCH_MNT > $seqre=
s.full 2>&1
> +[ $? -eq 0 ] || _fail "Convert failed"
> +
> +_scratch_umount
> +_scratch_dev_pool_put
> +
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
> new file mode 100644
> index 000000000000..7bfd50ffb5a4
> --- /dev/null
> +++ b/tests/btrfs/194.out
> @@ -0,0 +1,2 @@
> +QA output created by 194
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index b92cb12ca66f..6a11eb1b8230 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -196,3 +196,4 @@
>  191 auto quick send dedupe
>  192 auto replay snapshot stress
>  193 auto quick qgroup enospc limit
> +194 auto quick volume balance
>
