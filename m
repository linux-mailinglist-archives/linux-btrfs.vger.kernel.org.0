Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3041D39B640
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 11:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFDJzv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 05:55:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:55985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFDJzv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Jun 2021 05:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622800431;
        bh=irXtl0CIzyUINKDsI204IL7KdP/RR2cfgn3sUcLfuX8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=en7oX06jgLCn/yWveNEXksyx1JpG/jB6tt4IeB1km/CWVelln5pT0eJHy++5+3JB7
         dbgAX3lkM0E896eXCUZxKFuYfH5LJ7S3CB2r949zVM4bVrE98sdHOdiqTZL2hbWG3M
         3U6PdKxwyrMRT1lGapetAG+iSghWlCFtrIySm1M0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MStCY-1lxFT6135q-00UNHB; Fri, 04
 Jun 2021 11:53:50 +0200
Subject: Re: [PATCH RFC] btrfs: support other sectorsizes in
 _scratch_mkfs_blocksized
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, dsterba@suse.com
References: <2c3054e5b93f023cabd003ab4006d5f18ef3d484.1622717162.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <35c6ff63-ccbc-9efe-37f5-fa0da0ed2924@gmx.com>
Date:   Fri, 4 Jun 2021 17:53:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <2c3054e5b93f023cabd003ab4006d5f18ef3d484.1622717162.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7EMG9yDs1/TbXm9dIeCjgeR4EMkZkNx6PVVSoGwKfcXb/k90+AF
 m5SR3Nke81Kz2k2N0iNWvoZh0VRW8L9z0AMaPj8cJzgGXuitbfN0nlRyb+WQmGKcMH6AGJO
 1FI0EivB9iEvwwAYKtahkPCzUjbSWjJib5b1yH/KcJhRLRL/igQySAO5zbpZTNafCZClW14
 kh0UHNUdndV75khzNxLgA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RRbKZrtp3Dg=:UQehbutl3ZrMaSksnVOQIi
 vsAcyiZkKEnkDusodTRfuq02hiBZdQfqTSfQm1zJsh1RO5TNWMeacWmuvufqjy2gWCPsbmDXD
 lrUISpsz+97vKZDHJAOzYlr5dYnFnBJvhvetkEL/DwVJ6804vFCEMONtuvTTUfr1pdOZieWIl
 zycKbIWByQlaaZlMhlu5AYbPP1GfoABhQ9vM5iDUDgixxo70ZEs4JWNjRBD4uS1Q/cuGBdkKr
 lKM8XfRl5GnSukEEDQQz/GgJb7ARFAdMlW4kt4g2Cv4/M5uLCZl1muBixoDmq8RmTSkLUhTbF
 /U69mCG68lXmv/RW0PwYsC6eN8jfgxpNNSeKmZs6z7mjkC7weBv1Up0kbOyvR94mXcw4+nG4N
 DdWomRfc3nghb5IcbV9/XZmIbVix9KZOVI0B/2oLzMplAtgzN8nQkHe1JhaFMTFvR03dHJnhT
 U6lxbKpIcdFLTEL/Wymrc8V6EaPZr69aWtZR1Eo93MDywt6hamA4PpUo5La9Aqh1yZ8Zhxc2p
 hoPZq+WToTYnnBGRdH/DRqlYiOO8Fj38w7rRsPNd8BKnyDHDNo4I1Tb2n0oAH7pfCHVBwfF/z
 QzFDpi0sgcAUjcstM5iExftCGAoVqUOapDiSbSHekTE5GJ8sik8mpRSj3bPh3PztKeJv00KqE
 GKO1o9ZvzOedlTX5TXQmuGsUJNmb1exPHrqte+uCSvLiYFAWPl2lvZ0jIDaIFuArdnSW/MQ+u
 7QfsUnIRjfYxpTh1Keiv2HwAisE7m3k4dN0oUKFUdnoGP5v5wsahyQ+rVvjUMLRw2o64eiCmd
 eJEbvKO52c4zWsNOsdfhR7923zAZCBcCB+FWR9frWOkfIwMyEpQGuW7+ESSKehuR/KpXcKaru
 kM7fpTwc6csQQ4dajhQ0lwZjXViUCFpMF5/KDbVW9HcPFJjQRTVPwwDd1PKLQwUwIdNorxvys
 ZFfYVbKclBHck/2/ZAPH7VLFGf4bq5Jm7MH7KMqo3JNT1VW1MwpQvl8aV9oIh0vj7Q7brXK2W
 gu8SwTYptYCz7ATM4UkSUu0QanGRpgUoveiXhIz0eex/mBYKgO46RqrPOXG22oKh4H+PyLDag
 8Xj3tacBVJBMlK3mcdTYLkBes4dfJFRSY0f1eUdSLPyh/Xh6xc3G1APQw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/4 =E4=B8=8B=E5=8D=885:36, Anand Jain wrote:
> When btrfs supports sectorsize !=3D pagesize it can run these test cases
> now,
> generic/205 generic/206 generic/216 generic/217 generic/218 generic/220
> generic/222 generic/227 generic/229 generic/238
>
> This change is backward compatible for kernels without non pagesize
> sectorsize support.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> RFC: Are we ok with this patch?

Awesome! I forgot those tests.

But unfortunately, those tests are still skipped due to the fixed
supported sectorsize.

Those tests uses PAGE_SIZE / 4, but we only support PAGE_SIZE / 16 yet
for 64K page size.

But I still believe this fix is appreciated for the future subpage
support. (Yep, we will support other sector size, along with different
PAGE_SIZE in not so far future).


>       fstests completed on first 19 patches of subpage support (results =
I
>       need to review yet) on arch64, with pagesize=3D64k.
>       Subpage RW support tests are still pending.
>
>   common/rc | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/common/rc b/common/rc
> index 919028eff41c..b4c1d5f285f7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1121,6 +1121,13 @@ _scratch_mkfs_blocksized()
>       fi
>
>       case $FSTYP in
> +    btrfs)
> +	grep -q $blocksize /sys/fs/btrfs/supported_sectorsizes
> +	if [ $? ]; then
> +		_notrun "$FSTYP does not support sectorsize=3D$blocksize yet"
> +	fi

Can't we merge the the if with grep by:
	if grep -q $blocksize /sys/fs/btrfs/supported_sectorsizes; then

Thanks,
Qu
> +	_scratch_mkfs $MKFS_OPTIONS --sectorsize=3D$blocksize
> +	;;
>       xfs)
>   	_scratch_mkfs_xfs $MKFS_OPTIONS -b size=3D$blocksize
>   	;;
>
