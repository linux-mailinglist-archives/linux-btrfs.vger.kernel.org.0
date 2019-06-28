Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7091F593F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 08:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfF1GCB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jun 2019 02:02:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:34739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfF1GCB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jun 2019 02:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561701708;
        bh=t0mvSoRoHeS1MqDmpl9cVgoak4lLJRnoOveJkcHAbL0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CGAMtgZHVvdv33K3aHMIEmwYFjfX6+LwIzOPisspdC3LvMCEKBXKbcMXW2b8XkjVN
         tKE1OXp3eVoVPhDEKH1EoCA8K9MJKHmk8Y4otSNonlhc1G2umeBb75kq+YrQKMz17l
         OzzfZVFDOwftzH75SYyi5hTrJNJYdyV8sD806FBU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MUILK-1i7j0D1gBO-00Qyd0; Fri, 28
 Jun 2019 08:01:48 +0200
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20190628022611.2844-1-anand.jain@oracle.com>
 <0a250a9a-d710-4c7c-ca24-0e4f635a4a99@gmx.com>
 <5d93d408-2575-f564-32ce-e6c39b3b8d17@oracle.com>
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
Message-ID: <fb0af2df-d4d6-4e50-33a6-f76f2a39f4f9@gmx.com>
Date:   Fri, 28 Jun 2019 14:01:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <5d93d408-2575-f564-32ce-e6c39b3b8d17@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DeVSpSYzAzRN2PwDFazjtqA59Kc5znkeq"
X-Provags-ID: V03:K1:WtlzxsVxQ2BrIIAZNXD7CscnesOBGwAvNC36HpSzvaJMdCe1tJD
 2P3t7KYaBhWffPev81OUq2So7OpYqmURqTi3NWOOLX1j0tFu31ecHW3IkLlbTpQQc5Hl8aY
 aYugNRpeeZV0xy/cg+b+bvu0tu8ygB+334bjBtFsZc0IWzkcvzi88mxLMdJH9cCr4Prb96a
 C8nBnLlRFwa2o9su/4wWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/NgF2j7Wd2s=:mSU2xfgXlpvzHyCp5LhRM1
 sTNz2b3oNZYu4z23O+oUTOFXzWCTrWq6DSvHfLcINPVENhsG312AMv0Q5QgIOtwFalGY2YOA+
 NR2YOU71bzvQ1ISuXlGjwW2GueedUu0vTMrmDQtUlSSqZPwB4Ugvd2nCol5A9EcR+2R+gCVvC
 hZ0DINEBtneZn7cyRsyxS8lG8AxvhHMzWvIk/xezIVTx4np4KjF+OKJarrDPQYrsaV3hrBfdF
 kSZ/acDXTvZQQ+jzqFb0ga9qZW+OQ0PPBW4EBjsftdtBYZE8nxOn7GRN3uTLy4X1GvC5zFQie
 gigRJ4z83mo4wUMCq+jPzpEyXV8/acHQs1jbdqqaqQ3XirLh5WVTwFz8SLLRareQjgDFKbsBc
 5V9lhj2Bwb0FLatb766WKNf+NdY4IK/lARqtCc7dJjeqMLNNIVMDuLbrXKV1v+43enCmht6X+
 2fYR3K0hV6jpI01QIGO6qWmXQlJFDOglvRIIh8doAkXpEKIxYaM4vkg7svZ/PDFbyMUVdCXLB
 GevR4mBWlMOQ8/WeFcCVjpA9Hzu6fOJASywrghewayAtwAqQwPJ1/URAFW0efkF8G9IyEr2vZ
 vFnG6uD6fNN1sn/czvfZhKs7XEMVsVnAEGdPVpQwXd35pmmcyVSKnrI7SrzX3Fo/HhBcK9Yc/
 OtPWIq01yAylElO9zRTStIm4vLnBhqZh43AD3f6bDNIOLmwy0FyOayjlci4bJWh6HXtTG0Yf0
 4H5MqKHLToz1gAaOu1nSC+JQuLCpusXqQrAA1BnYTWDfZ6AU/ZUcMdqvxrXKBrXKPJj3C6rui
 LxyH4n4ULqg2PLVzB6dNB1V33UL4RA7OHGGiH9XdvZiwNt+Hnm8MTWFUJ97pCVP+/DHKVcMEh
 CwNpeC168LPdXb5hoyjFNKF6Xuen4SZ1J23v7FeaJHaPmoa/gw8FbQOB3j+eM/HkNAyQ/Styn
 60BN9GO8Z0i+zbYKN7ZjsnfFCLdK2/n0MOINhW0O5unNJ/GUEIjbdBg/fIOXdxr0xsmq0Mz32
 kooilBeIOCvfu0UTPPG1Sqjko+FiwZkWeZPNkCsPqvP8+aIuna3OHSKQwwF3yOwRJNCGN+qTS
 YF9e8bcm/V69HU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DeVSpSYzAzRN2PwDFazjtqA59Kc5znkeq
Content-Type: multipart/mixed; boundary="BCv0Z4BmKR4PUCDmzAcvtOk9dMesWgXlK";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Message-ID: <fb0af2df-d4d6-4e50-33a6-f76f2a39f4f9@gmx.com>
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
References: <20190628022611.2844-1-anand.jain@oracle.com>
 <0a250a9a-d710-4c7c-ca24-0e4f635a4a99@gmx.com>
 <5d93d408-2575-f564-32ce-e6c39b3b8d17@oracle.com>
In-Reply-To: <5d93d408-2575-f564-32ce-e6c39b3b8d17@oracle.com>

--BCv0Z4BmKR4PUCDmzAcvtOk9dMesWgXlK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/28 =E4=B8=8A=E5=8D=8811:28, Anand Jain wrote:
> On 28/6/19 10:44 AM, Qu Wenruo wrote:
>>
>>
>> On 2019/6/28 =E4=B8=8A=E5=8D=8810:26, Anand Jain wrote:
>>> At the time mkfs.btrfs the device id and stripe index gets reversed a=
s
>>> shown in [1]. This patch helps to keep them in order at the time of
>>> mkfs.btrfs. And makes it easier to debug.
>>>
>>> Before:
>>> Stripe 0 is on devid 2; Stipe 1 is on devid 1;
>>>
>>> ./mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc && btrfs in
>>> dump-tree -d /dev/sdb | grep -A 10000 "chunk tree" | grep -B 10000
>>> "device tree" | grep -A 13=C2=A0 "FIRST_CHUNK_TREE CHUNK_ITEM"
>>> =C2=A0=C2=A0=C2=A0=C2=A0item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020=
096) itemoff 15975
>>> itemsize 112
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length 8388608 owner 2 str=
ipe_len 65536 type SYSTEM|RAID1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_align 65536 io_width 65=
536 sector_size 4096
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes 2 sub_stripes =
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ripe 0 devid 2 offset 1048576
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ripe 1 devid 1 offset 22020096
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
>>> =C2=A0=C2=A0=C2=A0=C2=A0item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408=
704) itemoff 15863
>>> itemsize 112
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length 268435456 owner 2 s=
tripe_len 65536 type METADATA|RAID1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_align 65536 io_width 65=
536 sector_size 4096
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes 2 sub_stripes =
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ripe 0 devid 2 offset 9437184
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ripe 1 devid 1 offset 30408704
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
>>> =C2=A0=C2=A0=C2=A0=C2=A0item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 29884=
4160) itemoff 15751
>>> itemsize 112
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length 314572800 owner 2 s=
tripe_len 65536 type DATA|RAID1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_align 65536 io_width 65=
536 sector_size 4096
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes 2 sub_stripes =
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ripe 0 devid 2 offset 277872640
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ripe 1 devid 1 offset 298844160
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
>>>
>>> After:
>>> Stripe 0 is on devid 1; Stripe 1 is on devid 2
>>>
>>> ./mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc && btrfs in
>>> dump-tree -d /dev/sdb | grep -A 10000 "chunk tree" | grep -B 10000
>>> "device tree" | grep -A 13=C2=A0 "FIRST_CHUNK_TREE CHUNK_ITEM"
>>> /dev/sdb: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42 48
>>> 52 66 53 5f 4d
>>> /dev/sdc: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42 48
>>> 52 66 53 5f 4d
>>> =C2=A0=C2=A0=C2=A0=C2=A0item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020=
096) itemoff 15975
>>> itemsize 112
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length 8388608 owner 2 str=
ipe_len 65536 type SYSTEM|RAID1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_align 65536 io_width 65=
536 sector_size 4096
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes 2 sub_stripes =
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ripe 0 devid 1 offset 22020096
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ripe 1 devid 2 offset 1048576
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
>>> =C2=A0=C2=A0=C2=A0=C2=A0item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408=
704) itemoff 15863
>>> itemsize 112
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length 268435456 owner 2 s=
tripe_len 65536 type METADATA|RAID1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_align 65536 io_width 65=
536 sector_size 4096
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes 2 sub_stripes =
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ripe 0 devid 1 offset 30408704
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ripe 1 devid 2 offset 9437184
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
>>> =C2=A0=C2=A0=C2=A0=C2=A0item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 29884=
4160) itemoff 15751
>>> itemsize 112
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length 314572800 owner 2 s=
tripe_len 65536 type DATA|RAID1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_align 65536 io_width 65=
536 sector_size 4096
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes 2 sub_stripes =
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ripe 0 devid 1 offset 298844160
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ripe 1 devid 2 offset 277872640
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> But please also check the comment inlined below.
>>> ---
>>> =C2=A0 volumes.c | 4 ++--
>>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/volumes.c b/volumes.c
>>> index 79d1d6a07fb7..8c8b17e814b8 100644
>>> --- a/volumes.c
>>> +++ b/volumes.c
>>> @@ -1109,7 +1109,7 @@ again:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur =3D cur->n=
ext;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (avail >=3D=
 min_free) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ist_move_tail(&device->dev_list, &private_devs);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ist_move(&device->dev_list, &private_devs);
>>
>> This is OK since current btrfs-progs chunk allocator doesn't follow th=
e
>> kernel behavior by sorting devices with its unallocated space.
>> So it's completely devid based.
>>
>> But please keep in mind that, if we're going to unify the chunk
>> allocator behavior of kernel and btrfs-progs, the behavior will change=
=2E
>>
>> As the initial temporary chunk is always allocated on devid 1, reducin=
g
>> its unallocated space thus reducing its priority in chunk allocator, a=
nd
>> making the devid sequence more unreliable.
>=20
> =C2=A0Right. For the debug here, I have an experimental code which disa=
bles
> =C2=A0the unallocated space sort in the kernel. I don't have a strong r=
eason
> =C2=A0to disable the sort in the kernel so didn't send the patch.

I'd say that unallocated sort is a hidden way to prevent starvation.

The mostly common case is 3 disk RAID1. (1024M X 3)
With the unallocated space sort, we can take full use of 1.5T.

While without that, we can only use 1T, as all allocation will happen on
the first (or last) 2 devices, not utilize the remaining disk at all.

So that kernel part is very helpful to prevent starvation.

Thanks,
Qu

>=20
> Thanks, Anand
>=20
>> Thanks,
>> Qu
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 index++;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (type & BTRFS_BLOCK_GROUP_DUP)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index++;
>>> @@ -1166,7 +1166,7 @@ again:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* loop over t=
his device again if we're doing a dup group */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(type & B=
TRFS_BLOCK_GROUP_DUP) ||
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (index =3D=3D num_stripes - 1))
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ist_move_tail(&device->dev_list, dev_list);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ist_move(&device->dev_list, dev_list);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D=
 btrfs_alloc_dev_extent(trans, device, key.offset,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 calc_size, &dev_offset);
>>>
>>
>=20


--BCv0Z4BmKR4PUCDmzAcvtOk9dMesWgXlK--

--DeVSpSYzAzRN2PwDFazjtqA59Kc5znkeq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0VrUYACgkQwj2R86El
/qjBAQf+P4roPsy0uQhLzzoP9/6VlSnjhKPEgGieIsP9y2hVmmOgCbvOTg7FvrZl
CGEjvy4xOXQbJ54r0zEcbXUS4c+xYz3Nuev5qlG/W/grM3SGsTcrYTxg8Z0+dBhy
Aw6iUug3HXjSa5RBL9lnPr6d7amp3yyB7i+T5/6mtGDiS/4otiVPl76VKgFq6/w6
66VJSO7iRO7l7ORrtdR89LAHBcmRZNAuKOz9m/Wy0pnV+i1o6EHeM6QdHw9SLCY9
7OcdURtcelYpexVNtvgvPlZOn8nUzXsuFEdBCafD1I9WchMQFNOi0JQ3TB0x/Wm3
8bKbd27Fr8JUMF/Jf3gYKdjotf7kTA==
=rPdd
-----END PGP SIGNATURE-----

--DeVSpSYzAzRN2PwDFazjtqA59Kc5znkeq--
