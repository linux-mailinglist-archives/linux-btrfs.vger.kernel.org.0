Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67D4B0618
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 01:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfIKXje (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 19:39:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:35479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfIKXje (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 19:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568245146;
        bh=jWkhHoYN2sdo/ngFGaXihO9HkNduht/kf6XZtmXhoZw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fkhyqBtvfEMyG5ESZIblRoSA06J2ueEaJDjp1/5VJP4bBaMj+2s60fuvDqk8uYgwP
         J18lG9AjQuLGBIVqscuNdMSFOq7SMq6+1KptUhgI70GmaKqHNl6J1cxr5eSKNcaOHE
         A9I55lpKpOOMNkQidBnVCpwXNuO9QYJTBCmamQM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Meg8W-1hk5lh3pm4-00OEWU; Thu, 12
 Sep 2019 01:39:06 +0200
Subject: Re: [PATCH] btrfs: volumes: Allow missing devices to be writeable
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190829071731.11521-1-wqu@suse.com>
 <20190911171748.GI2850@twin.jikos.cz>
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
Message-ID: <2e291872-bf36-5db8-9d3a-4540e6e1ae7f@gmx.com>
Date:   Thu, 12 Sep 2019 07:39:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190911171748.GI2850@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="smJDr7zOljyebEJV1REDz24NVmJ9rYKJh"
X-Provags-ID: V03:K1:iSixsqxSA3LkJILjyqcuKSOlo21aiqgPb8iqNSKN/+PeQLNsx3a
 pj9dkp/8uXMB4qyM4bgvMKb0ZhtavAIkMUrfmZOzcAp+8eVjfBU12Gapv7yIBY2G26MLe8S
 iTAhLWplsp0uygfslyzq3r8/GB7bO7tFT+/VrocB026d6ukO2GgGem/lVBVdbCMyVYAP3Uv
 /zx2FUYdZqYVZERjglyxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JvH5qRGScSg=:JgS8+Kh5STT1lWB8tsW+2y
 HEcVGU7HG92aVvonXG+d9mbbLo81rbaKlQ7YEqXKJ9XAI/wf1IwqVC8x2Eo6mykRAZg45l5aX
 C5tKkmS/v6GJzQKRPMF4ecDLdDGXQ1FzKsbilq9Jbre26pVK4WZ+pksqN6wsDvnTg0v1qGvjw
 1XBegM+UpJCigJeer0L5p/niZsHwiYBaDRYfVuM7wvq0EZkFu6V7XI3XyWkdL96Og9hDQlYA0
 LSgFv1D7KARQ+wgGXZn3RY/b6uZvtEQfrBz7LhNrdXVW5sKtjsdMZqEHgMCFbPIy8QepNsdTP
 JdVt2et1HRY4f9gBi2QWO1MdWwCVHvcYG51VSjBxSGQjuxVQRaTL989gzruF/0JlE6vYn38ip
 5o0X3cnEKMoTlwJyNnPWALNEMVbnMV0FRQcQsJQreYsj+7+GQF4i0hLJYLoz9h1Mqn2euoVPf
 /rNVUSypvYJGQ3W/vD4EDR9Nk67NrXl9X8sWDO/tK9cmenBkrxIaoUK+tXKlFnSh785DeglA1
 rTyvppA2JXFbijTsm0DmidaA+ElcogBdHq8vwfzmcio4k3UWNsL+k8GGCuWPFNLvEC2y3IAW8
 Uu2U8PiieoSQDgFuJJ1da3ML4c0watAwRqHrO43I8mJdXP5jwV85Q6TY0VfDR5RQaBEcqCCU/
 sYtSrURj2XZgpfjk409espx+Qag2HO2b/vOXOg1SV99+sUn+WXCzurDQ7Bx0gDeU/+i+B7Z0v
 bTDergs5L7y9v4BVNctE6N4sc18ainaUOoiVWJCAyqO1cH2POtb26bo1YoGNloe3cisSTWIez
 hrWqSoOd7IzXph6Q9n7xEz97JLdHLRfjrbbe1aJ0q2OPblDEkQ/A5zcFqI7IX5g1Dg2gOD8sj
 aLHU003Nrq4Y/XoFRAZGYQyKLGuwTMIeC0V/jqDmbWMK1oT7ICijL4H2kBVbTrnjFKAt2oV7V
 f/iiDh3IOphawx1cklDqlYLscsF/gas0MZ6cVMCZ/v2c5AaIDVYzQFlN+aEtbfE/G+8f5ay03
 +HIc2u+aWK3XCkHY1YNOKnWMNXBxyNcoyLaUaTOfLqWb3jGhrlDzSZgbSyJ1lhcDa2OP49A3N
 dxUEDsb/ijTjgF2M2MOM6gGuesO+VBbHxXjQJiyxK9c9AnT9K49ktVm9AxnFF834PM1wwt5bZ
 3jEfwLeHmRJEOkcqLcrSqtwj6vaPUipTn/yc4cdk5hd0NJYiGq+k9p/RUGF8rNKpWoFDtf5WV
 fdraoZ5C1yNXCdiN1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--smJDr7zOljyebEJV1REDz24NVmJ9rYKJh
Content-Type: multipart/mixed; boundary="05mHBW1T0n4bh5ontkZvxGpJR8dd0Waw9"

--05mHBW1T0n4bh5ontkZvxGpJR8dd0Waw9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/12 =E4=B8=8A=E5=8D=881:17, David Sterba wrote:
> On Thu, Aug 29, 2019 at 03:17:31PM +0800, Qu Wenruo wrote:
>> [BUG]
>> There is a long existing bug that degraded mounted btrfs can allocate =
new
>> SINGLE/DUP chunks on a RAID1 fs:
>>   #!/bin/bash
>>
>>   dev1=3D/dev/test/scratch1
>>   dev2=3D/dev/test/scratch2
>>   mnt=3D/mnt/btrfs
>>
>>   umount $mnt &> /dev/null
>>   umount $dev1 &> /dev/null
>>   umount $dev2 &> /dev/null
>>
>>   dmesg -C
>>   mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
>>
>>   wipefs -fa $dev2
>>
>>   mount -o degraded $dev1 $mnt
>>   btrfs balance start --full $mnt
>>   umount $mnt
>>   echo "=3D=3D=3D chunk after degraded mount =3D=3D=3D"
>>   btrfs ins dump-tree -t chunk $dev1 | grep stripe_len.*type
>>
>> The result fs will have chunks with SINGLE and DUP only:
>>   =3D=3D=3D chunk after degraded mount =3D=3D=3D
>>                   length 33554432 owner 2 stripe_len 65536 type SYSTEM=

>>                   length 1073741824 owner 2 stripe_len 65536 type DATA=

>>                   length 1073741824 owner 2 stripe_len 65536 type DATA=
|DUP
>>                   length 219676672 owner 2 stripe_len 65536 type METAD=
ATA|DUP
>>                   length 33554432 owner 2 stripe_len 65536 type SYSTEM=
|DUP
>>
>> This behavior greatly breaks the RAID1 tolerance.
>>
>> Even with missing device replaced, if the device with DUP/SINGLE chunk=
s
>> on them get missing, the whole fs can't be mounted RW any more.
>> And we already have reports that user even can't mount the fs as some
>> essential tree blocks got written to those DUP chunks.
>>
>> [CAUSE]
>> The cause is pretty simple, we treat missing devices as non-writable.
>> Thus when we need to allocate chunks, we can only fall back to single
>> device profiles (SINGLE and DUP).
>>
>> [FIX]
>> Just consider the missing devices as WRITABLE, so we allocate new chun=
ks
>> on them to maintain old profiles.
>=20
> I'm not sure this is the best way to fix it, it makes the meaning of
> rw_devices ambiguous. A missing device is by definition not readable no=
r
> writeable.
>=20
> This should be tracked separatelly, ie. counting real devices that can
> be written and devices that can be considered for allocation (with a
> documented meaning that even missing devices are included).
>=20
Indeed this sounds much better.

I'd go that direction.

Thanks,
Qu


--05mHBW1T0n4bh5ontkZvxGpJR8dd0Waw9--

--smJDr7zOljyebEJV1REDz24NVmJ9rYKJh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl15hZUACgkQwj2R86El
/qj9tAgAl9n94gT6bt7HZwM6WUxvwzEQwkEcPi2h6gbNaLtTR0R3p/oJj4H100jn
LLJjIpVFRaaMcgNzmyvK+XXQVNqB8Wr+a2n2J5bpjVX0A3GiXN9JbDmtvuHenf/T
XnO4nrbFpDhHSL9PYyHoWr1dFQNChfpltrwkdvrB1IMLBXTcnYDyiCAFdLtNds73
u+vKDs4gGP9PvmRL/kdsz2ThtdtTfD+kIBcCLHSvLN+G0pkIeVTbN8IB06damtca
UniDM2IakelhLDB5V/EevGWA70HLyPp3Zpm1bnlKRGEDHY9/50G2o+5/YiWxzjIn
X05BlOBjEDArBVf5y4XWeiqUwmZP4w==
=cSSJ
-----END PGP SIGNATURE-----

--smJDr7zOljyebEJV1REDz24NVmJ9rYKJh--
