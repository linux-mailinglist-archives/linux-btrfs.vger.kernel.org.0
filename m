Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1B266C61
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2019 14:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfGLMSZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jul 2019 08:18:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:41959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfGLMSZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jul 2019 08:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562933903;
        bh=s3cWBnnq5rMzSTv07jM1RKZVkg34fp62KGOBCOH0iRI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=X3rwJz5FdtjnkMiE1bsqATjysUrHXuX2hVh/cJr9aF4WNZSrxRzzvGLKP9k5rp0fI
         XRBwYUHjW1fNr7X1s3XifGudaCmi7YSVqIZuJNNjRyYtjImrwlwe4X1vE1E0VQm8hV
         aPUUD1XShF2hAHsNaHKHLhmDdjXyAzwB0ROjpQRo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp5Q-1hxsxO2D5Y-00YB1x; Fri, 12
 Jul 2019 14:18:23 +0200
Subject: Re: [BUG] Kernel 5.2: mount fails with can't read superblock on
 /dev/sdb1 (kernel 5.1.16 and 4.19 is fine)
To:     mangoblues@gmail.com, linux-btrfs@vger.kernel.org
References: <CABDitb8iKge1Ut41qxQSG2ep1ozp2Veieha072eANqn_L_LCNw@mail.gmail.com>
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
Message-ID: <c8ddfed7-bdae-4405-5bec-082b261e07cb@gmx.com>
Date:   Fri, 12 Jul 2019 20:18:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CABDitb8iKge1Ut41qxQSG2ep1ozp2Veieha072eANqn_L_LCNw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rMVIOjWIznr4FNxxRkRL5LWyWcjEVKSq5"
X-Provags-ID: V03:K1:7SyMGScac7+/mx3HHrv/xO/sqQaEY3aRJPDomHxVfHCCOf2bEFR
 cTv/+lRLP/yYJ3CgtnHRbUW6uWnypwhCeBMK8Wn7JEnNJPdvREvx39paUY4zheOx5WyvpSc
 xEu9qf3I2CjK/yy93u4SwaGJktDR9Bh90mCdEnlGP5sDSX08+MOLe78bqGg1WvZAN8Aq9D/
 C0rv++j1algdMX75ouR2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9y6r+s+bIQw=:Hy7WVQiH184WWsaKQOnEot
 2bM55vqeTCX6I8+YEk8ABEMFFE0F7hzg3631Sc32Phw8wBAv2hEpLu/u/aGvCfv1Ywrai5uDe
 Xkc1Q7vH1bjy/IxKFhxW+UCvQoaG7/YmDZtxzLPbMWIfC479t/jaoVZe09fx2rPUxJ4vJUwcl
 +9Dcs/xE+yc0edlnkO4vYrj+hPt9nnYquoc4+z53YGQiaqA9z3vIhmvfuCBIIV1cB0C9QGOUQ
 90olN5LPMyhzG57JeYXdXugRq9DqzGwD565uxfLZ4XQ+GyM+L81q8WgqEBx8KAl/ACpZ22h0Q
 2cYT8a4A+zsfGshf/YKMsV15Cy2jqHWF9p/+Whv1YFy5yUFXBY/PK25JqHyxTFHwUXNZ9Wz2M
 N2QRFRWZrGIoir3LzQtFvwbUTBjeYAkuZmHN8eLhuhcHIUiNaQSk38+jPXDLu9G9Tc5sMQawe
 6wCWY6tf/jRBXtxISJDqchmMWzPdhvT6SigzirhTdcDmUpm5BKq+z+Nv25vGUGrBbosyjJp+b
 RIjTdW6WhKZs+l4++LEeSXVrezZy5DKAuFI/iXqKc/Ksd7u+FE5YS3Ye4th1hufPcWmQRSCXq
 CCpogG74pn3lFK3ZayZDZcnofuK1gT2jyV3ERxi0Vhv1aXclT5l19uHc/Y4/mTZX/5ilRwVwS
 GcvVmNTYWdMy36cec+VTPGhzZpUSOGBX83A+ch005VdhnD5z0yIyClCfVWHiZa1ICj5eMzT9C
 b25kzwztUcKsdtpMiuNTBria9nnI9ZBcRK2b1M8G1NyTekZYAm2iMgxJn8Ytys90lsHxxGQwC
 jD3kjBfnsQCaOe3+NkVct/2RL2HR5IAWa3vUdC/TI5TLzfQHpUrmMNYa/QxxR8v4KzHhP4Arl
 bpZB9FuibR823bL4SsLwwjjp1f8FWQI9AGVv4XvUkFyZslDzDl3Zn+83sakr9i8CKMS4gZsU3
 NF7y6cv8sYaL3rVKwib6Un3qspypyMQ9gCN6NUFTa7jXhPU9CZsiSiaIAloBlMDeyFTv/+1tX
 nA88Obtpux7cF9b11+PRz1FnI/cB5OnwPPucKP0l9tuDJXBkj1H9bXvNMiWV+evNPy4VTvrH7
 miTFMA4ek16Pxw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rMVIOjWIznr4FNxxRkRL5LWyWcjEVKSq5
Content-Type: multipart/mixed; boundary="nfWN18QWs61oerD9wNbYNuDhd90958i9z";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: mangoblues@gmail.com, linux-btrfs@vger.kernel.org
Message-ID: <c8ddfed7-bdae-4405-5bec-082b261e07cb@gmx.com>
Subject: Re: [BUG] Kernel 5.2: mount fails with can't read superblock on
 /dev/sdb1 (kernel 5.1.16 and 4.19 is fine)
References: <CABDitb8iKge1Ut41qxQSG2ep1ozp2Veieha072eANqn_L_LCNw@mail.gmail.com>
In-Reply-To: <CABDitb8iKge1Ut41qxQSG2ep1ozp2Veieha072eANqn_L_LCNw@mail.gmail.com>

--nfWN18QWs61oerD9wNbYNuDhd90958i9z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/12 =E4=B8=8B=E5=8D=887:05, mangoblues@gmail.com wrote:
> Hi,
>=20
> After updating to kernel 5.2 (archlinux):  2 out of my 7 btrfs drives
> fail to mount on boot.
>=20
> Error: can't read superblock on /dev/sdb1 and /dev/sdc1.

Pull dmesg output please.

Thanks,
Qu

>=20
> Going back to kernel 5.1.16 (and 4.19 also) fixes the problem. Btrfsck
> reports the 2 drives are OK.
>=20
> What can I do to fix this ?
>=20
> Thanks.
>=20
> $ btrfs fi show
>=20
> Label: 'disk3'  uuid: 37d68257-a2bf-44e4-82e6-7bda35d3af3c
>         Total devices 1 FS bytes used 1.77TiB
>         devid    1 size 1.82TiB used 1.82TiB path /dev/sdb1
>=20
> Label: 'disk4'  uuid: 8b72d7bd-603c-41c0-a395-a763ffe0de8b
>         Total devices 1 FS bytes used 2.67TiB
>         devid    1 size 2.73TiB used 2.73TiB path /dev/sdc1
>=20
> Label: 'disk5'  uuid: 1728d60b-bdf2-4baa-8372-de7014d85e1d
>         Total devices 1 FS bytes used 3.59TiB
>         devid    1 size 3.64TiB used 3.64TiB path /dev/sdg1
>=20
> Label: 'disk7'  uuid: 5e9437b5-bf53-4135-8b25-52539cfc491e
>         Total devices 1 FS bytes used 6.66TiB
>         devid    1 size 7.28TiB used 7.23TiB path /dev/sde1
>=20
> Label: 'disk6'  uuid: ce325155-0922-4c62-9f5d-70cbc1726b5c
>         Total devices 1 FS bytes used 3.47TiB
>         devid    1 size 3.64TiB used 3.63TiB path /dev/sdd1
>=20
> Label: 'disk1'  uuid: b9c65214-b1dc-4a97-b798-dc9639177880
>         Total devices 1 FS bytes used 3.31TiB
>         devid    1 size 3.64TiB used 3.62TiB path /dev/sdh1
>=20
> Label: 'disk2'  uuid: d77e4116-de32-4ff4-938c-9c6eea6cdd42
>         Total devices 1 FS bytes used 6.83TiB
>         devid    1 size 7.28TiB used 7.26TiB path /dev/sdf1
>=20


--nfWN18QWs61oerD9wNbYNuDhd90958i9z--

--rMVIOjWIznr4FNxxRkRL5LWyWcjEVKSq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0oeooACgkQwj2R86El
/qiNrQgAgdRBHR9VSzOi4c2KANULCW27jfwgcniKfh0CrytJjrDjYf7iD1+oPowR
vE1OSKH1xrzqQC8m7eZDbY4Gzi40LfeuUHlGlbhy+UwTFhcE3ZhCk/t1HWKMDoMk
FKuqLXTY/sf5qkiUh8hbeGZekm1RTcZD041o++BNS9U9e0BlMFldpd2VMc749X3I
mcVxDqtCPgPC1M/GrNd/otIs+76SQ4APxsAEReXBYLHd0rst4lo1T4BAgOi6KUzw
//d6wsxuwlPL0sn42ING2WV8UYA6MRICYDvE62RlpZ+us4AvsIfANfvsuB9vIi6O
ChkL3MJIYj9ii+jGee0DKrK6WP6+tw==
=r1jX
-----END PGP SIGNATURE-----

--rMVIOjWIznr4FNxxRkRL5LWyWcjEVKSq5--
