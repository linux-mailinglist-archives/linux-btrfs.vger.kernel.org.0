Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB65C66CAD
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2019 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfGLMWL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jul 2019 08:22:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:43139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbfGLMVp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jul 2019 08:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562934103;
        bh=BlbCCiNHLxKZYR91d7ntMbu0oMcKzXhBJVHigqvCzg0=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=ce8aw9RnveLQmsM0eexd2ic9ttQaHUSFCUIvES1Q2vBNHGrivtskxZ//TpTc1TxZB
         hRzWoEl+I3f4/181Zmc8YHWyFuLa1t928Lc90oZNmRCrdBrhVNkzXnb/n24zuY5oOc
         cwVKf2I9SI1++vvbsbkRZfnqln9q0bzyd+B7Hn4k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LoEwL-1iNh9D2ZGz-00gKLH; Fri, 12
 Jul 2019 14:21:43 +0200
Subject: Re: [BUG] Kernel 5.2: mount fails with can't read superblock on
 /dev/sdb1 (kernel 5.1.16 and 4.19 is fine)
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     mangoblues@gmail.com, linux-btrfs@vger.kernel.org
References: <CABDitb8iKge1Ut41qxQSG2ep1ozp2Veieha072eANqn_L_LCNw@mail.gmail.com>
 <c8ddfed7-bdae-4405-5bec-082b261e07cb@gmx.com>
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
Message-ID: <6ffb9d7d-21b7-f938-c638-212058316223@gmx.com>
Date:   Fri, 12 Jul 2019 20:21:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c8ddfed7-bdae-4405-5bec-082b261e07cb@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9QeQYjdHYPxhFM12h3givxYI9mlSNIcus"
X-Provags-ID: V03:K1:R5UxCFLmD+3S7PHnt1FRqGPmEBGU8oyqT4LfBOgUOsgkKVRLQWc
 f4p4rG+DWDpfhzv13+TcQdZhPymrSx2qWpAXeYyfF57RdlEgx6gcYv+n1XqqFpU+uAJAr/r
 3uwc3cy8j1MO+fVU8hmfwjXO0Je1SxLNPIehYkvKpGXN6UXQC5M4G6LtF3s5odNrPrISDSi
 HWt9ZUwz6KbipNGQEnS8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ezmDeEn8jck=:b2M7J3K3TKDEmPGxkLDaif
 7X1iKAo5cZz1KE+UZo0Iloa4QnK2jw4F93JDuJfxfV3afPXdLXeRmlamed1PpGlwkJACOKG0r
 kF9z0ElFAiBNRXdS6h9z6HvLMC2eNl0tjTjmZRKB4kPZgBZU//7WfmsZ89HE3eLLatk0KXJ2X
 ciEcTqWnkzP73fMvkOg9OX+MRD4dxPykBLXgDPc9CB08jooWilY+mJnVuFONL0BQzq/8WPK37
 laAHbhRVPhdIsSZjrwYwM9UfEJr2t7u0fSyd6epvMNG0F4ea+PrP7NonKte37oHSN7v/qGb04
 8gdtTeAPPggEWdY0y2tC+LEbf1kh4mSPoAUwa/jLCLyUbYTtMzvQ8LHFPduAaHMaoBKXE2ru/
 8R9pYYe2OAZpVR6eypxsUKlA5BAproE/2/3mEXO4sYB+fX16/+PtUs2isCBy32D6K3k8Hp8Lx
 bgepuhtjQc2ndWqoSKUBxDsfS9vrQjuUIlxjCrAe4LN6q9sTuhwqYu+CpPjxydK2vSMetZCQa
 7woetug15ffwf3paVFGDU69gIEOxGuJYi8Npc0MAqQ/dQcK6AbxHhmYpr/wMSj7f+QoUt0jmu
 WIJ3Y+Vs8ZBVtPr5iABerUyrsQwXyWABytGiX580g3OpA+grRjRngps30p5/PPYTsfribQ0+u
 KdSAJmkovUO5KH+qz8oMreCc6a3uw89xT86ZtxSbZbY4GyQPyRSzvd4QHYB2ESPPHIoRIFhN0
 0yE/43Jmjk8QAanez9flYWprhr3rYgWDcaKvuVIhhe96BN9bWmYejP6vCrz9B7TAzcJ5OQejA
 djYxyOUQddC/nxbDxpNZ0tCv/oR4x5ujrWQ0Xo7VYYGrumUrKnbEDKv2PQF2896w6WAgftVgv
 MthrTGnZZDYO71xIjlut4rFw3Zlcu2cpIUdHHcDPiRaNV6ngBCTRZN7Rskmf2RyyyKEcIym1E
 si6bXWvZRq4d6R1xbtJaWqzlsxjppEsZuxZWX/8851Tlr0kPzWb2zZ6RMcNner5fh8MoLSk3H
 /cMc+ahTgR65V7jrf17MUULKZXuSp5SztHk+yNPzK/seVC/xoCXOh6PSSMwCutqjiur2pQrHV
 CHanmh0CrToRJU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9QeQYjdHYPxhFM12h3givxYI9mlSNIcus
Content-Type: multipart/mixed; boundary="xGWolblj3L29DpAeqjldOchwXU2mOv9dS";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: mangoblues@gmail.com, linux-btrfs@vger.kernel.org
Message-ID: <6ffb9d7d-21b7-f938-c638-212058316223@gmx.com>
Subject: Re: [BUG] Kernel 5.2: mount fails with can't read superblock on
 /dev/sdb1 (kernel 5.1.16 and 4.19 is fine)
References: <CABDitb8iKge1Ut41qxQSG2ep1ozp2Veieha072eANqn_L_LCNw@mail.gmail.com>
 <c8ddfed7-bdae-4405-5bec-082b261e07cb@gmx.com>
In-Reply-To: <c8ddfed7-bdae-4405-5bec-082b261e07cb@gmx.com>

--xGWolblj3L29DpAeqjldOchwXU2mOv9dS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/12 =E4=B8=8B=E5=8D=888:18, Qu Wenruo wrote:
>=20
>=20
> On 2019/7/12 =E4=B8=8B=E5=8D=887:05, mangoblues@gmail.com wrote:
>> Hi,
>>
>> After updating to kernel 5.2 (archlinux):  2 out of my 7 btrfs drives
>> fail to mount on boot.
>>
>> Error: can't read superblock on /dev/sdb1 and /dev/sdc1.
>=20
> Pull dmesg output please.

s/Pull/Full/

>=20
> Thanks,
> Qu
>=20
>>
>> Going back to kernel 5.1.16 (and 4.19 also) fixes the problem. Btrfsck=

>> reports the 2 drives are OK.
>>
>> What can I do to fix this ?
>>
>> Thanks.
>>
>> $ btrfs fi show
>>
>> Label: 'disk3'  uuid: 37d68257-a2bf-44e4-82e6-7bda35d3af3c
>>         Total devices 1 FS bytes used 1.77TiB
>>         devid    1 size 1.82TiB used 1.82TiB path /dev/sdb1
>>
>> Label: 'disk4'  uuid: 8b72d7bd-603c-41c0-a395-a763ffe0de8b
>>         Total devices 1 FS bytes used 2.67TiB
>>         devid    1 size 2.73TiB used 2.73TiB path /dev/sdc1
>>
>> Label: 'disk5'  uuid: 1728d60b-bdf2-4baa-8372-de7014d85e1d
>>         Total devices 1 FS bytes used 3.59TiB
>>         devid    1 size 3.64TiB used 3.64TiB path /dev/sdg1
>>
>> Label: 'disk7'  uuid: 5e9437b5-bf53-4135-8b25-52539cfc491e
>>         Total devices 1 FS bytes used 6.66TiB
>>         devid    1 size 7.28TiB used 7.23TiB path /dev/sde1
>>
>> Label: 'disk6'  uuid: ce325155-0922-4c62-9f5d-70cbc1726b5c
>>         Total devices 1 FS bytes used 3.47TiB
>>         devid    1 size 3.64TiB used 3.63TiB path /dev/sdd1
>>
>> Label: 'disk1'  uuid: b9c65214-b1dc-4a97-b798-dc9639177880
>>         Total devices 1 FS bytes used 3.31TiB
>>         devid    1 size 3.64TiB used 3.62TiB path /dev/sdh1
>>
>> Label: 'disk2'  uuid: d77e4116-de32-4ff4-938c-9c6eea6cdd42
>>         Total devices 1 FS bytes used 6.83TiB
>>         devid    1 size 7.28TiB used 7.26TiB path /dev/sdf1
>>
>=20


--xGWolblj3L29DpAeqjldOchwXU2mOv9dS--

--9QeQYjdHYPxhFM12h3givxYI9mlSNIcus
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0oe1IACgkQwj2R86El
/qgN0wf/W4S86zsMbuLIaKNU5yq1B7axqxSn3NljIDQ4U7oUEyShtSEtqIrk/pkh
Uz5HBSSMT0bC7HXX9WQmx1n9gUZQtigfOEKyPDGyN3ewzLyvO9LUFkj5Ix8XVZQP
ExL4iUiruh1DfMlkXkFHPXEbDTwJmyCOwezs3rKzpoUP3FE/AlcBlDtIJGk+CYUz
RMOmQhCFICgE5hj0A5ubCG2ynbII3libqFvMnUn+U7UeleuY9uArH2JxI7xh+dxo
W0l5eTv4lenteH9bfcV94y/IYhR1sB7mwEjwgq/WeOEDJAl8OXF029dOUHDn8V9V
8JXduoYlMonOLRigtg8zPKBcLnORKg==
=GK3h
-----END PGP SIGNATURE-----

--9QeQYjdHYPxhFM12h3givxYI9mlSNIcus--
