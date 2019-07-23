Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85CD470E7D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 03:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbfGWBJE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 21:09:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:57997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387703AbfGWBJE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 21:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563844135;
        bh=/mrgeDXs/MdPKvghhl71WNXn7va+JjnAd+c8mlpxFxc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LrmsU4ZtLBSVVgrk9fFF3THi7qbZOyXGiSIwV/D4HDI/4Nxo+UZ+ZAZkkS+MB/5xt
         6GRkrQmUMlPFbc5zk2IRnpExjSNddswPEsPk08Mf8csKhPULwSrXXEju1kkVkXK0JW
         PC+X4p6DSMEUT/sA2+0rG/1g+m+5mPBAkuCbfcJo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MdKkd-1i6z4B3eJX-00IWfT; Tue, 23
 Jul 2019 03:08:55 +0200
Subject: Re: [PATCH 3/5] btrfs-progs: mkfs-tests: Skip 010-minimal-size if we
 can't mount with 4k sector size
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190705072651.25150-1-wqu@suse.com>
 <20190705072651.25150-4-wqu@suse.com> <20190722171516.GC22308@twin.jikos.cz>
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
Message-ID: <24556bf9-4d68-0e45-ef4d-15e0e726f9d5@gmx.com>
Date:   Tue, 23 Jul 2019 09:08:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722171516.GC22308@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3RgrKUeqb17WKlfEuu5H6eF6ej5UDLT2s"
X-Provags-ID: V03:K1:TTwxFPRobwnp4TsVLTSbd30V/X7ieOvAHmyzHhlU9Fh9iJ1V+7t
 4Eve8ECAkmbOrfJEoQmD5YmrZYUEHu4cTD+ydn2tg+9/StHarzR9oh6+7s44guz8ixyw82J
 oN2kQkP5+P3HmAUiNMYar+sFBDCH6iLbWfmM6BZOXsG8WNh8oamMcVmkuy02ocmFRN/qkA+
 lfx2ojEg0Y3vDhlIEve/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GjbYzYcGlPw=:0kg9n+2FFLN2DAvl7rvvQL
 loFWMMGLaF3duobEc7Gs2NUTU6WDv/Pdc9reLoCNOes6iKVpdvzP0XjoUVnt2vyE5iNw3Q69G
 xSXfzbXB9uwTxVTsm8UvgAVlE8VJItzRCKp24t/MW4lGjDgSqHDFIjVLjYqVNLMrPShsklK50
 ZLdl1C+05pN4IlEoS7aWF7qFTeDPjVzxFvGPalwT8Ft8+4Bc8tAY7cRuJ3Nv5ODl/EKdOJr6h
 6hqBwdVvDwV5is+1IsILmGkiwUmV1Pz7/FIPcvrjpiP900X7VPmkxM3mMbf81iKP3lFiyYnWb
 8JrC+3ER8490ggQtAe6z4EDjJi4ndkP2/gIe4bZGEBoIMIe7clWJaQIDHE4Fq0Q0A76Hlk+Z1
 jWnTZVztj3dGyB1Av+i/+rfBLG+RPdVBgnUOiVfl87rWv74qQo6ZqHUhV1DOzj6udDCwnbuwf
 K+i7klaUQrBiIQjR4WdFZ4hV7eUKALbI3cPJcJPk056Y9xZjg5BokcDwzgn0d9ZZ9t7vAIyYn
 f4iUu8irlrOS/peU7cTugFfXxOWRotadGUUSLe/3lBEUYBthZJAsPR0k1cs4RHKRpEMS6KXQv
 1lE57z/fU53eUy9L1IwqkH+67A3M/0dYP3IDo3b2QjqVYLGEVmWaSBK5QxcSOJ5W92qL2O9Z/
 Fk2t/5nme9RxFd+xHtulBX6J9cPRD1MhJCL22aMLgq7oFIlexd5Thyp70t8G37KDpXTCnoRAN
 yEL4rDcp3DX8F6zH0NgWEMkm6ofzKxC+jHtPVWLfXMVAfTwv/Dud7WMBoHd72aa4Zsr3IxiV9
 k5AIUW0xtfUdAKdLK43DReMWKUlQqbE7LXr+UAFgmgaxBIkzXPas1TwvBkuNQqsB1eDpnYZkO
 j69PqYowckIyV5g+LoPfCnq4539CjZI/vCFslRyqAijJ/kWi3dJ++ooeLehqw5lcuoy5iPy7q
 OSNdWjdz6PIHH5XdvyDc20mrs2vVgfmXd3I6UnkcFE90vK3Fp3HNGkltOgE7Ew5CHVhYqDwR3
 Us/3rX750+KE1LoZgwWrrw7iPJoh920we+fQgf9L4fh7ILf349Uz1H4Nseeme9iEKIFdBCl40
 PRJIfMH0yUjjas=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3RgrKUeqb17WKlfEuu5H6eF6ej5UDLT2s
Content-Type: multipart/mixed; boundary="StBvj7CZRVPVx1oBTpLNcxVFOdEVIJDhp";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <24556bf9-4d68-0e45-ef4d-15e0e726f9d5@gmx.com>
Subject: Re: [PATCH 3/5] btrfs-progs: mkfs-tests: Skip 010-minimal-size if we
 can't mount with 4k sector size
References: <20190705072651.25150-1-wqu@suse.com>
 <20190705072651.25150-4-wqu@suse.com> <20190722171516.GC22308@twin.jikos.cz>
In-Reply-To: <20190722171516.GC22308@twin.jikos.cz>

--StBvj7CZRVPVx1oBTpLNcxVFOdEVIJDhp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/23 =E4=B8=8A=E5=8D=881:15, David Sterba wrote:
> On Fri, Jul 05, 2019 at 03:26:49PM +0800, Qu Wenruo wrote:
>> [BUG]
>> Test case 010-minimal-size fails on aarch64 with 64K page size:
>>       [TEST/mkfs]   010-minimal-size
>>   failed: /home/adam/btrfs-progs/mkfs.btrfs -f -n 4k -m single -d sing=
le /home/adam/btrfs-progs/tests//test.img
>>   test failed for case 010-minimal-size
>>   make: *** [Makefile:361: test-mkfs] Error 1
>>
>> [CAUSE]
>> Mkfs.btrfs defaults to page size as sector size. However this test use=
s
>> 4k, 16k, 32K and 64K as node size. 4K node size will conflict with 64K=

>> sector size.
>>
>> [FIX]
>> - Specify sector size 4K manually
>>   So at least no conflict at mkfs time.
>>
>> - Skip the test case if kernel can't mount with 4k sector size
>>   So once we add such support, the test can be automatically re-enable=
d.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  tests/mkfs-tests/010-minimal-size/test.sh | 41 ++++++++++++----------=
-
>>  1 file changed, 21 insertions(+), 20 deletions(-)
>>
>> diff --git a/tests/mkfs-tests/010-minimal-size/test.sh b/tests/mkfs-te=
sts/010-minimal-size/test.sh
>> index 8480e4c5ae23..b49fad63e519 100755
>> --- a/tests/mkfs-tests/010-minimal-size/test.sh
>> +++ b/tests/mkfs-tests/010-minimal-size/test.sh
>> @@ -5,6 +5,7 @@ source "$TEST_TOP/common"
>> =20
>>  check_prereq mkfs.btrfs
>>  check_prereq btrfs
>> +check_prereq_mount_with_sectorsize 4096
>=20
> How about
>=20
> 	if `getconf PAGE_SIZE` !=3D 4096; then
> 		_not_run "requires 4k pages"
> 	fi
>=20
> and be done?

I'd like to make these tests future proof.

Maybe the subpage size support from IBM hasn't been updated for a long
time, but we should have such support eventually.

When that support is merged, with my current check no modification needs
to be done and every test can be run on 64k page size systems.

>=20
> I don't like hardcoding the sectorsize, the effect should be the same
> when the test is skipped at the beginning.

So is the patch doing, just skipping the test on 64K system.
I didn't see any difference here except how we skip the tests.

>=20
> When we have the subpage-size functionality, there will be an incompat
> bit exported through sysfs that we can check.

Why, there is no change in on-disk format, just a runtime feature.

> Until then the cude
> pagesize check should do. It is going to be a big change so we'll have
> to revisit all tests anyway.
>=20


--StBvj7CZRVPVx1oBTpLNcxVFOdEVIJDhp--

--3RgrKUeqb17WKlfEuu5H6eF6ej5UDLT2s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl02Xh4ACgkQwj2R86El
/qgJYwf/bByUShGKawTxIFpdP6VQuQTK6Z7MHdcZZTGbG0DlMo9Lc+fM9oe4o5OW
5RtJwnfUBMiXX259ob5ustotSSC92GLJHsbXxVLJYvzXDbRAp5xILUUPKwHC6h1a
Vln9ql7BHJ2GrIvhLlH0Da+741jRJn3oiCsZGp7RaNcG7bRSyxOT4U9nOO/KNYC1
v7Hnf8kWOn0/jy1TycnsUjlU/DmmqQwyttKLoxTck5MBI/M1xvECr+NPeYWLsWeI
G1U6IpdePz+npCj4hzFJUN1oEp26VXyKw1GqK2tPevDCNRqg9HWJ4FhjTkXc3gmS
1VChkEpwfcawz4iXJJC6Nb0D1syqeQ==
=sdnc
-----END PGP SIGNATURE-----

--3RgrKUeqb17WKlfEuu5H6eF6ej5UDLT2s--
