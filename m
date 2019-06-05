Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF7A3595E
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 11:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfFEJNQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 05:13:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:58985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfFEJNQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 05:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559725989;
        bh=LNOdrhMlZON41BA3+i1GdKZP6LBMvjmVw88xJUcpW8c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UkkkfV0urhC8F7EDD+r7x1Yc52xoYUTKdrV/foO6SrLPpcWylb1UGe5jaBLmofarC
         QI1av0iLSjuVWCiIgdJdQrWGOFZqY74uM7vXHsl9mfp+urvdy0v/eUv00S3RzrP/ok
         wsJ0ifQxSmtMinBCVTvDPj/mYzp0MGlyoBGQrTOk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mn2aD-1goPuV36JD-00k429; Wed, 05
 Jun 2019 11:13:09 +0200
Subject: Re: [PATCH 1/4] btrfs: Document __etree_search
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190603100602.19362-1-nborisov@suse.com>
 <20190603100602.19362-2-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <4a7aba23-6068-3d84-3bab-4b8da5b60eaa@gmx.com>
Date:   Wed, 5 Jun 2019 17:13:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603100602.19362-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JPd42eCkEj9CBNScIIK1yXtCPUVHUeq2mLO9gGBq+181dZjtftP
 m1vfITiF20RmgOWQMGB8pZNeFkUwELe0Crvl5q95SBRsDcFa3BDXTLa2ed6bhrP0lRAd/TZ
 2/C6w1CISZuEET0rjeDV5XbLSzB5IfFeWQ/LlG/klg907T058xja2m+IepexwPwHueB0LR6
 m+ebWlEU6EGaW9WTq5WMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C4/AmmVf470=:Ipl8KfjL0m0+kfVdEbmvjM
 WSY0Zqe+onArCzElgAgMRe+gjB2qOR27BuLSj5joA+LGb61wQHKliE9GFGYi6DRYwIDLVuEcn
 Pla8Jj/sk5kbMLFagyiH15YI60QIzaXhI6UT1tcsidYpygR9m36y86T8lvtZJXL6qdO4Lgl3U
 amMEg/zCDhxqtBt7S8vRyIUiA/ppGtTFfpEEXv7n/JDlTZvXHwbkSEXI4mMWmzGMfQSqAcqIr
 GzN6I9BG9xpE/otiTXCjrvpF6ET3D8x1qAyDLHxFG+xEIENiVi3zXGQjXj+Nf8rV8E+7nci39
 eb81JiQU0v1eunEhvWgQLKbMhd/piWHb8ur3tHc4k6NTy5shfWoHcBHKuYxgQE120np4AMiSY
 TpVnfMrm1YemEXtsaRVyzfsxzqxe40gCcytv68ZB081mnkkDHK795aAxUjc8GuI+Wq5wRMT7A
 v/qVW4YvwFcGS7aUk4BgP2ghCl31A8GrOlCMDUosI5JhpylbdLsTljrWlNa7bh+Nmh3Vgdy2o
 JniMSKn9J6hKnBDetF8P014mGMJK+Crp5eUO3qwotTnSkOU3tW6xQt0GwgX9TOaocfXE39tbO
 5ww2w53Sx8Z/Lp4c8XC3L2gVDDwUZLesIOFakZ8ZLpxQjPh8YezaqUU90wkqC6dEqjc2EO5Mv
 P2/cTwgmatHSFekRdfCJ/wfObzaUDG3T1Pwg8QgTkUIgCKR7XKPF6/DiW9O0N0f7FWtg7sgIo
 hbdts490yvERnpLqtLQr7e/vkHgscoewcIYuUvy32Df9EeCj/kmR2ztlpbblVgP5el3GOaAmS
 1pGUxyfE/KpyvXEakypBK+Kgt1NygCV873bRV7wnVxVMlF60Mlq/mCXsm+HeErmBVqJHipRda
 LlcxVus/gjYFhnLC2/mjGyQOl1RW5ZGDwYUKwBvRytBn+D6AyByD+ngZmru4iJruqotsp7Uu/
 MNfn14lx3m4wl6rXJaJgT7fXfeb/pe6GpDgCdPu3/qU3DBFk1ZbVa
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/6/3 =E4=B8=8B=E5=8D=886:05, Nikolay Borisov wrote:
> The function has a lot of return values and specific conventions making
> it cumbersome to understand what's returned. Have a go at documenting
> its parameters and return values.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

The idea is pretty good, will help later readers.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a small nitpick inlined below.

> ---
>  fs/btrfs/extent_io.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e56afb826517..d5979558c96f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -359,6 +359,22 @@ static struct rb_node *tree_insert(struct rb_root *=
root,
>  	return NULL;
>  }
>
> +/**
> + * __etree_search - searches @tree for an entry that contains @offset. =
Such
> + * entry would have entry->start <=3D offset && entry->end >=3D offset.
> + *
> + * @offset - offset that should fall within an entry in @tree
> + * @next_ret - pointer to the first entry whose range ends after @offse=
t
> + * @prev - pointer to the first entry whose range begins before @offset
> + * @p_ret - pointer where new node should be anchored (used when insert=
ing an
> + *	    entry in the tree)
> + * @parent_ret - points to entry which would have been the parent of th=
e entry,
> + * containing @offset
> + *
> + * This function returns a pointer to the entry that contains @offset b=
yte
> + * address.

it would be better to mention when found, the remaining pointers are
untouched.

> If no such entry exists, then NULL is returned and the other
> + * pointer arguments to the function are filled.
> + */
>  static struct rb_node *__etree_search(struct extent_io_tree *tree, u64 =
offset,
>  				      struct rb_node **next_ret,
>  				      struct rb_node **prev_ret,
>
