Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E636AF2ACA
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2019 10:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfKGJe7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Nov 2019 04:34:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:55391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733221AbfKGJe7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Nov 2019 04:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573119213;
        bh=q4NX93qorjnw8uHMeOqzg6C+PSSU+c4eplf5ENyITZ4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SR9e5O6tK0HXJ4LxOHYGPq8eI1WvW4mv16DCPriRybzzAhJ1HTqh2tMx9Lg202gqf
         wr1kB3ibrHs/vdUN0d69RoQH9aLEyxI/FexbaRMqJikvCC6X6AXTkEmTeMb8AaAo/Q
         ieNYtB0XIp44xn70ubMcxFRtqmSzbJ7f0hCZ5aos=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOREc-1iI9Uw0Qve-00PtXV; Thu, 07
 Nov 2019 10:33:32 +0100
Subject: Re: [PATCH 1/3] btrfs: volumes: Refactor device holes gathering into
 a separate function
To:     Johannes Thumshirn <jthumshirn@suse.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191107062710.67964-2-wqu@suse.com>
 <77bcec95-5e72-092c-66f5-a0b3b6e08049@suse.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <1f48aaa9-60b3-5f77-3dcc-26fb4e360cee@gmx.com>
Date:   Thu, 7 Nov 2019 17:33:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <77bcec95-5e72-092c-66f5-a0b3b6e08049@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XDsfTkXCNGAjhihFEJtnH7TEPX6jSoctC"
X-Provags-ID: V03:K1:VyJaG7d9wjk0pLmIkb4xIPvCFE0BgV7H2nIcNzvUccek83qh3IC
 waf22TFyLRfNlRICML5A2v3Rrp4u3ddaaql4eTz0Zenyz2G1EuGbKLEpgFQok7fKIIT9VGK
 /zUS2A4+OtHSFgZApVPWOKskwt91gE0U8T7PC/bFAFZxUXvWJ/zAUa+OQy4kEKLjOhZqk6j
 9b8T8KtqCaScFUZuFr/pg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q9J+dEkfzD4=:bxrMh6gi1clJlZk3xeBtEk
 CTp59/5RMLxpNb3c6BMKJlYr3iWD94VmifM3fnWddDF4z83+CYCm2Uyd3xqrTPYDrMmOsXL7U
 xXLCwc1V6gLswgVVUYMjcrLwtDy2Nso0zg9pc0U1wsbhIS33FnIHOp/3JIjmVJZxZNYueS20N
 phHKNAolZREJQBzzRhI9k9ckbRA9Ds646XxIfOHu6s8a5ZSL7kIDSdBl4uPqgj9SLFxf9GTSG
 4IM8BHXM0mSEuIQiIVt5MznqD2uivVGOYVOueKpX/6iENBHsdn5fKPGcg0UD5p+Ly6Tu/PAxL
 3VHZRTfdsUOCMq8/IWZ2rUmb8SLBYIsZxOP0DgVqAr+/vgmSddObUOQkVs8jZEIlyvYElDvgv
 idiillIArcLs8nboIMiDyFyLzR8Nid3manJgUPTp1j337hk6LhRKG4GRIoxccAi0a3llyGCkV
 UjLPwU2KuR9yV48BqX2lv+ts4+FkF9gdlVWp7MjSsMTfpOacaf9EN4tEa83OULuXEoYTwzPaK
 riIHzdus40siYhy7/q4R8yAoSb0AEAmU7YPAzNrwQ+Fz3fHSsd/vUVr/OSxNraabqxUl0PfvT
 oW4j2Bxk+/E9Ktu+6KSPi+wW4bSTdNEqC/xbLwIdtZHk/z2AJJYHAhaCqL1N/erqMxzV7Z516
 IbIH8LmRJlZ3+P4snkdnpPRyVHedqLud+sMvFOU7uuu4jFly2Vu6gVlazlZJqSvsZkHArisAz
 cvkpywlrycO6jgbJ1ByZL0QpT39J35hweOU9K3lgL0Bvc2rKz8vvuEJ5/E5FDKJXPvgk2/sU3
 9aUTe3zMEpFvGXfvgYJUeI1nn2azIhSSUhHaHo0mOkpP4c/DSAjPHSW+UYmoNoe4u5nMrwxli
 WcLLMhKeBCEsecIgdJCvmQQ2kdYcKy9HtSPWUmHGi74GIHFqvBrqxJTn9sr2xttEvUcrZtBbK
 qlHGDYLtZgfoHl6NqdICB6P7IUFMqaNCZORAdNiMKdlQwAEuFEPFmL8NPp3uZrSGteoekAhlf
 dDYUO5Dw8V04xkMMcIhGU9D/ZhpYRkmLWITb/BHjeDTU03Q2VsLRRS3jsSq+nEFdncDJHpLpv
 rfzTjqJQlDim+pX4fntJ5IwZPsSzFYlrtJkLj9Vln43bdfs5aH81eIb4BjzXy3Jvq9GOZfxc6
 co9n+B2JxEYDW8EAxznZsUoz6dqBMRLVXJNOYgLpt7eTZ4rE3W9OTocjArLUev5WIZR7BPB+1
 +EDX9f0oHLulIDKn4uzkXLArbs0TqZ8MmTUbtoAOFxfrpz2W0m1FwsDsC/X8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XDsfTkXCNGAjhihFEJtnH7TEPX6jSoctC
Content-Type: multipart/mixed; boundary="efayYiVKHv7kQ4P8zXvcnjm9neMfh3JOU"

--efayYiVKHv7kQ4P8zXvcnjm9neMfh3JOU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/7 =E4=B8=8B=E5=8D=885:20, Johannes Thumshirn wrote:
> On 07/11/2019 07:27, Qu Wenruo wrote:
>> +static int gather_dev_holes(struct btrfs_fs_info *info,
>> +			    struct btrfs_device_info *devices_info,
>> +			    int *index, struct list_head *list,
>> +			    int max_nr_devs, u64 stripe_size, int dev_stripes)
>> +{
>=20
> Hi Qu,
>=20
> What do you think of
>=20
> static int gather_dev_holes(struct btrfs_fs_info *info,
> 			    int *index,	u64 stripe_size,
>                             int dev_stripes)
> {
> 	struct btrfs_fs_devices *fs_devices =3D info->fs_devices;
> 	struct btrfs_device *device;
> 	int ret;
> 	int ndevs =3D 0;
>=20
> 	list_for_each_entry(device, &fs_devices->alloc_list,
> 			    dev_alloc_list) {
>=20
> [...]
>=20
>=20
> btrfs_device_info can be derived from btrfs_fs_info, and *list and
> max_nr_devs can be derived from btrfs_device_info.
>=20
> This reduces the number of arguments by 3 and we don't need to pass tha=
t
> odd 'struct list_head *list' which isn't really clear from the type wha=
t
> it is referring to.

The objective of this refactor is to accept different list, not only
fs_devices->alloc_list, but also later fs_devices->missing_list.

So I'm afraid it's not that easy to reduce the number of paramters.

Thanks,
Qu

>=20
>=20
> Byte,
> 	Johannes
>=20


--efayYiVKHv7kQ4P8zXvcnjm9neMfh3JOU--

--XDsfTkXCNGAjhihFEJtnH7TEPX6jSoctC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3D5OMACgkQwj2R86El
/qgoCAf/au28is6+uRJSpfTT4pRsHtxFTLL+Wpl40SYKTgwsi+sNu1Z9roDHtL9+
TQwiXAPmbQFBd0xWSPnLTSV8zmtws3msjExs8d9OsudgCVuFs8zuJm6zkVUFNC6F
/GoGT/ODG04tYs1zVsL3AfYBXkMFm8lxz9xnddaKadlSx/YjoIYFw0tN6R5pR70p
ya7jkvDnuvE6TkANQF2mrYTW8PnhMQxkI+74G+GaRTHeGhViJs/YsR3gNlksHsW1
woqAuksVw1KsEV5Q3astVpM3fj0RZkqRNMzjsNLK17thpiDBeRE2ZdHE7Cm/0w+y
Mgc2vBy/prfqY7mkRY6jY9w3J65+fw==
=qbgz
-----END PGP SIGNATURE-----

--XDsfTkXCNGAjhihFEJtnH7TEPX6jSoctC--
