Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B36E42FB69
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 14:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfE3MGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 08:06:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:51809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfE3MGX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 08:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559217955;
        bh=I3fdQ5p8VvGTFN9ttA8aClWqxrrWgsF3cdoN8SVkoG0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Fi0p/bBvFdaHhMFauQNMd8qkP4XRfpu0KZHh74n1J50aCDMf7savs+tXSogkG6jVe
         k6BjJcujkm37O+d234XLIZTiDffMaoXC7aIz/Rild7JjFUC6OS3OGvOk7TP4cxptGs
         Hhwkl+XdqG8pgMyX+NLoMnvT93J9VpUP+F9IQW4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MVvi4-1h86zi0xhY-00X6uz; Thu, 30
 May 2019 14:05:55 +0200
Subject: Re: [PATCH] btrfs: trim: Check the range passed into to prevent
 overflow
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190528082154.6450-1-wqu@suse.com>
 <20190530120402.GD15290@twin.jikos.cz>
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
Message-ID: <868c3ccc-36aa-62ab-d15d-50a03ecc8b25@gmx.com>
Date:   Thu, 30 May 2019 20:05:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530120402.GD15290@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y9KyCbbDtS7cexVM7ndHRnuqD8EbDfPl9"
X-Provags-ID: V03:K1:WETHXJfyILfA+Pr4U8Mr0Y5Mb88g6rRYQFCmcKBNUZmrIE6nymj
 apsmhw6t6W0Oq2oxTGnXVHqIHHuspKtynAYGqP+VOHVZkCwFyx3lictkfIvjJVXOWW5uRLF
 fKDi7iHcdeKFXENFyWm7JNDQjSr8IXEEvrswb8nygbzqCld2cqSBMxyaJOKbcoIl1sdx4L2
 WAVdJyOEbbl2FS5cE6hcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gEf+SqusCnQ=:G6hOQKwL9o0ciJFpQoA8bo
 3pWtpW/97awhLcZft9PRhGJ9zIXc/tY4b75++OBB7SXsh74mjFj1qDyg0NRseAPOZeGPxqAmM
 zPFq7H3NovPSeV179QP6+6P9CI3QczmH7cvPhfu/20YPwWIa2TWBMLbwxHl57B5SglGmhWacO
 NTZ7173TZTBzA4uLvoKf1VVrHW3JJ/3QxOh0rxmlIv4IjcAJNNQPmzmoVq01PIPEihV/6mfh0
 Ri/RFqEmVUwOiRvAVnWnlJylPuqMnezO+O7mWZXEI0vpuMhZZQc6uBVlAx1DQJuE+w8L7zNR+
 opJlfsp3KR18UeMVdfdsNXVJ4Dx/UKj52qDkRtlS8WRrdnES3IPmLdr8ty9fCDmgmm/nqVTib
 Xc1cHQOssfJngIzqApa+y3o3lpoyulKzpBgfLqfPxH7p/5klkMReQIk3b/UnfmPrDULuP7kBT
 O6nkCHmxt38NgXMd6ONtFJHbmPI/Id93VO8/NszmTSJWdrmFn7gTUEB/sOFps7cS8gv5qz+MT
 NqsRbUim2sgeYHeVj9BiZ07F5gpxnJdo758BL5E2wf/aNjUHOsGmtt5IIRWBK/a8gClqGhHcZ
 zA+CiwYtAWSmXR/iiYA9ksyRECWvpT5tO+1VWCo5CoW6MZYdVaDvhzo9d5S9dk1+Ef1eiJRZf
 v+Efqvwdpc7BUTKI8ROcyiDxxc71Rc00+YTMFkc9AedFWVYTOIaJFo26ToJUGjhuf5sH5GeLp
 2bstC+pOXoYgfH1pEVor0HMReWCCjka1qY4g0LYjgUzMUvLzNQMJeyAHgExSHJjjUEVlijnMi
 aoqebtyZcooDFYLm0pl/+hC/86D6GWqkeSXHfQlnkwd1I8IQNLZJp41EHg6QJf7SJr1WNBkWb
 tX4vsXuDOQ8LzXsSMBtP8QkwEUl0IFetal9S5bRKGlugrombg/LK8Z6iwSo39p0LrgEg1j6Po
 13HJHOn4ov1QHkCDA5MW5NhkUmRZBZHI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y9KyCbbDtS7cexVM7ndHRnuqD8EbDfPl9
Content-Type: multipart/mixed; boundary="6sDzKEwyAJIv1RYCIBAex1vwxMugMm9DH";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <868c3ccc-36aa-62ab-d15d-50a03ecc8b25@gmx.com>
Subject: Re: [PATCH] btrfs: trim: Check the range passed into to prevent
 overflow
References: <20190528082154.6450-1-wqu@suse.com>
 <20190530120402.GD15290@twin.jikos.cz>
In-Reply-To: <20190530120402.GD15290@twin.jikos.cz>

--6sDzKEwyAJIv1RYCIBAex1vwxMugMm9DH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/30 =E4=B8=8B=E5=8D=888:04, David Sterba wrote:
> On Tue, May 28, 2019 at 04:21:54PM +0800, Qu Wenruo wrote:
>> Normally the range->len is set to default value (U64_MAX), but when it=
's
>> not default value, we should check if the range overflows.
>>
>> And if overflows, return -EINVAL before doing anything.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> The range support of TRIM will be reverted so this patch won't be
> needed.

No, this patch is an independent one.

The objective is to behavior the same when @range->start + @range->len
overflows when @range->len is not default value (U64MAX).

With the trim range patch reverted, we should still detect overflow and
return -EINVAL to meet the new generic/260 check.

So please still include this patch.

Thanks,
Qu


--6sDzKEwyAJIv1RYCIBAex1vwxMugMm9DH--

--y9KyCbbDtS7cexVM7ndHRnuqD8EbDfPl9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzvxx0ACgkQwj2R86El
/qiimwf9GZOizDC/9E1TuYEj7c8I7nGgyFrY9XEksJzP83vSrywJyQNp/Kw9W9ig
gwTvdKH5KpxQlgqxpC6JgcyEP9AMYusGhIsLgtXvpP/xK+7Z2e4tdlgJCx8P7NEi
FwxSn5x4yXqmvNF7oRJPKuY/k5AkKIboy3XjMbog3sg8Rw3nLappXELlk95lSGsg
pdk3GZh8Trr00IE8g5MFw6J/QE7wNt6UOVfH07M05tNxI39Xw1hg5R43cjBp/N5I
GKHjxjjwcxaXiRT4fHvUVvA8/BAH7CJklKuhBZxOxZwZLow289/Yuf/+DmptKL9z
RJNdYW86L5SxtoXlsMRdwHOXffLNPg==
=OtE9
-----END PGP SIGNATURE-----

--y9KyCbbDtS7cexVM7ndHRnuqD8EbDfPl9--
