Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B35473597E
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 11:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfFEJPH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 05:15:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:49849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfFEJPH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 05:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559726101;
        bh=oeBmMHN5/J667KE6bWMCWcy+QzOLDz93LHatOTAzjS8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=I7vrGwZZir/JlFZ57ECtgqlv4B/TN6KrtDD5sC5mTasTgDhSd4ExG+abwK1suYbqv
         wNhd/uXQnc9eWkbCAcl4ELAcZkqRNKX59AvmKfsMq0L6zjgQ1ihQHhj/Y0CeUiETdu
         dcGrIBarB+iXBwNoV+ozzRMRC9p1CT7e1G0q1tQ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2f9h-1hYizb2Iil-004Amz; Wed, 05
 Jun 2019 11:15:01 +0200
Subject: Re: [PATCH 3/4] btrfs: Skip first megabyte on device when trimming
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190603100602.19362-1-nborisov@suse.com>
 <20190603100602.19362-4-nborisov@suse.com>
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
Message-ID: <91bf1d48-dea5-45a9-4c0f-7a2fa0b22c98@gmx.com>
Date:   Wed, 5 Jun 2019 17:14:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603100602.19362-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5lsx7HkETZ79A/ZotR+bC9eDN1fwMNBzbESXIVUk665ckdiMyYw
 Cb0JJrufoFaGWQqnWBpHGbfC1TGYcDTLN9YoGGJfzsExfC1pqCmhFkpaQEY4b5xlNyTL6Oy
 sgxBKbx9HeGl72usETf07vwXovz9RckPJjDm4HxQFAxEIKdUbMicXFvWrFGgfDXx4sw/AuH
 FG1Nx2wJ3ZGVeF2VP8ajg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8zWxpF0lhgU=:pX3crKiNMQLXA9L57h2IYY
 auSBjs57eCI75vp4O9A00woHCcGd6cntZidqIwUvjquxauT/fTBLspEYvS1G8BbV/ABUql3RS
 QwlKwKRHJvmrpUXMS3I+FpWDEaEuYzuRAi0ugA6oXgwD/+o/xqYvtOijfbiGhIeqGujAtiygz
 XdFtNugltpkyVTA9Q1/EwPJQiIp+ryX4HpYM//Z8oUPFd+De3fsx1ey2V3/nX/8WAuSboxHrz
 B+RGm8bkWmGIFFdlZNJzJNjWnSmUEBNflLb3XYy6tl17gUWjOINm2vkAmH3lx0cC0teEughGK
 KPa2O6F053jjDp6uViJBwrMOQPsFgNbwFwish5ZbK0IXoZYtiD9y22/EirADTd2Jo4KdNhy0d
 3WPertzGGAaffhn5jTRWpfbmCHJeFlpAvivcc7tfSrNy2oF/8zYLgRE120SHDZ7sGyKMHgvYN
 YPn4jv1rPGutizpgp8NR12OdttR5UNa4m82qr8AwTt7NscoyHaMMdToOqq6VZRcueK0UpYdDC
 Ljh5Bx2x6J6/+HAhDmVNJqPTetLS0AmsyfRvgYWaBsZUF+K1Itgv0ynuhW0B8L0pCqTyub1e3
 akWh7Fn3r25B1fsYoEli26f6RLIUZ3U9gYwHUhf8PvRQ3ltH4dylhpI2gMO/xSzWjma9OKExO
 N70qxsmU9YzO/rdEqEVG6JwSHfAOGsGsed08+xYEB5nPTtRPNxGaNvUuSeynIMvDfAL8rDCMf
 HprvZ5RQK+vb7pRMn9LnNDRQNvql3XnIYs0yXhJAse4XlVBBDzcC0C6tlgwXWyWuAyi0GIfqn
 r/5XWrzG8vXZgatCuIxb5KTl2PiSmkuILxPOsGtspz8TGHLYIuF6JMDbYBpt6X0TTMcSKeXZp
 CSuezcsk/1aUTXkFXlP9R+LWKYSPUbu5OYSbYj4/pY4mK8NVWdBLPYfRrTKiapKuLlqwRJhIn
 miojiG94e8aZtw/WlvEmVYD2G3WQKz+utPuUUPe27iqTRCKpixNET
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/6/3 =E4=B8=8B=E5=8D=886:06, Nikolay Borisov wrote:
> Currently the first megabyte on a device housing a btrfs filesystem is
> exempt from allocation and trimming. Currently this is not a problem
> since 'start' is set to 1m at the beginning of btrfs_trim_free_extents
> and find_first_clear_extent_bit always returns a range that is >=3D star=
t.
> However, in a follow up patch find_first_clear_extent_bit will be
> changed such that it will return a range containing 'start' and this
> range may very well be 0...>=3D1M so 'start'.
>
> Future proof the sole user of find_first_clear_extent_bit by setting
> 'start' after the function is called. No functional changes.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Doesn't that previous patch already address this by:

+	u64 start =3D SZ_1M, len =3D 0, end =3D 0;

Thanks,
Qu


> ---
>  fs/btrfs/extent-tree.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index d8c5febf7636..5a11e4988243 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -11183,6 +11183,10 @@ static int btrfs_trim_free_extents(struct btrfs=
_device *device, u64 *trimmed)
>  		 * to the caller to trim the value to the size of the device.
>  		 */
>  		end =3D min(end, device->total_bytes - 1);
> +
> +		/* Ensure we skip first mb in case we have a bootloader there */
> +		start =3D max_t(u64, start, SZ_1M);
> +
>  		len =3D end - start + 1;
>
>  		/* We didn't find any extents */
>
