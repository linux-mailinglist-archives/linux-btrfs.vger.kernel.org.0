Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D58B987ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 01:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfHUXcW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 19:32:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:43491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfHUXcV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 19:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566430339;
        bh=K/KBc5gVxBbCJt2rWEdMJgbG5phIouF9QG4a5Ihouh0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Q41Tp1xQQMs9+LFo7IHWUeXuQL+LzixD0KS4ba50iFfw70NA0o0NxJJl6G1bziZop
         WrGf1G1t2GglD13k7HX0yWjxw+OptC2TL6RWqyTfj9mOXbJKM8SJEdghLpQ5Wjrn1e
         nmH7BC6oU07kqcwyUdFVFxFMZ5SHhBHve7+kHRMc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MdnN3-1havZH0JfZ-00PdQ8; Thu, 22
 Aug 2019 01:32:18 +0200
Subject: Re: Chasing IO errors. BTRFS: error (device dm-2) in
 btrfs_run_delayed_refs:2907: errno=-5 IO failure
To:     Peter Chant <pete@petezilla.co.uk>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
 <CAJCQCtSWi+PUbOWXNwv0guCLRuSgZunWdvRBB4TKMG_X48jHFw@mail.gmail.com>
 <2433d4cb-e7f7-72c5-977b-02f51e9717b3@petezilla.co.uk>
 <e439aafe-8836-b761-3b72-b9215b463c09@gmx.com>
 <c593c2ef-044d-32e1-a75d-a2116a5b91a5@petezilla.co.uk>
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
Message-ID: <a632bbef-974a-1ff5-fa10-300ce9a47b42@gmx.com>
Date:   Thu, 22 Aug 2019 07:32:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c593c2ef-044d-32e1-a75d-a2116a5b91a5@petezilla.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SH2CYKSJLdtFBN00mQ7azBD6L9kNM7iag"
X-Provags-ID: V03:K1:y4ip5OhPJT2bJS3w8cBK6L1vmO2hRyR6/1p1ZxbSQqQzgYcvQ03
 KzW+1AzRhD0YWCz1eGiXjHelef9JcUYZ+lNlFimFNSDZHZzLE9m1jCOaERHlKMzrR0Q/hfM
 BKVZVL7CFszoBREF2/4ngnaNa68juIaibIy/TqQ52KyRl8MKQp47Z7OyeNEYM/W3vA1cyO0
 NLZRmu2oizfF+fqws2p5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nGkbBtfwhMQ=:yQduQJyNC13oHyYaFg0akX
 3KlI03XTN/RtLJ2eQYgRg6dseBclsvKJ0AljRql/mGe7Vwg+hwCEGb6TJIOasLSkV1NzOmWrm
 F5ePbY9zaECvuiOKTvgiw3ns2k8NqVS/rKLo/fFpAzq72tnh55jDS+wvPyDppT8vCFZCYmUH8
 x3oDw2bpOG404OxVfR/3QQd72gx4YC/lfioYVVvSK1MrYKvUdUpB3pqz89ai/1MuYUENynE6z
 yhqexJQekJcUZ5ehhrODoiQDF0HHYxbKTO/OQ9EOnCS55lFQhqq17losPJ+itX07jbu1oNRNU
 hLbQ0qPp04AAJsX0tqAhWRcKc1TR5uHvK+h4V4iQuuwV21fHNf+nYNo1bJpiu1ivCftRkyCvd
 PkvgMbreWYFdSWRAy9V6+aeAC8Hul/Zg0wWfaxwoDU6rqenewj7IOPp1vvG3BKa5kA9tXX6h9
 XyZjZPpGtZNelhSoqf3oL/G1vJMEmGceX1J0clr9y9IN/7RNmdVASJU7VaSX9Qx0cPglR3caa
 kHU8Co4ykLDjnm1YPaGFAW8aNG2hF47pyKS3v0tSzGY1vnmTUZRh1U+d6A3y4QmfGQfPa1EdZ
 ZzHpFnsZwVdhX5h7qeI2XhuQTnj1FBwRkBMik0p04WoaLs7Fg5PKwWFHhwjOkCrkeWlURYPPv
 gxEbfwTlw8WDyOR3UwAXVRE8MM09LHd5VIp3l/vuSwRg6JJUXZRLgRAUH6OxTXpbi9vNxnecO
 kAC3TtwHdjYN2jFdDXuUUgHOkPLy1OzuGvjNStoKqyxmCy7G+r4avE4MxOD4vCzQBPGZTKptI
 seoohv75s13FXbX30dvUMyuWDkEFJT6e42o5gZeBAaNZUJ2Fna0bn1vjg0xTycG6XPdGGbUW3
 uv7q8X6MhjzIHoraeDSrnEl6XocAhFZoyiXyS3K9lBhsyUQOFI7wJvKL9hNtHaurHz0rS8CKW
 ga7pwpsgxnUXugtA0UTaxPpOV9x4fnP1y8cJ1PvDZ941JJtYBg2rt4YIh5+X5MsM7+MVpDs5s
 7P+G2LZT0lSu+TgGq/l7rgE2i8CRUzRWnJAmQQd8QP3w/ES+I23dhpoL+v5A75ZmjMc3/RBJw
 3NyBjWfq162Ar7WAm9rqWbXcQeSzTAbZzmlCD5yIOaY6Dls9r1TZ33J6A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SH2CYKSJLdtFBN00mQ7azBD6L9kNM7iag
Content-Type: multipart/mixed; boundary="CEWE9kczmANPXpJ2EaCeOYDY7HoKWTq9x";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Peter Chant <pete@petezilla.co.uk>, Chris Murphy
 <lists@colorremedies.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <a632bbef-974a-1ff5-fa10-300ce9a47b42@gmx.com>
Subject: Re: Chasing IO errors. BTRFS: error (device dm-2) in
 btrfs_run_delayed_refs:2907: errno=-5 IO failure
References: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
 <CAJCQCtSWi+PUbOWXNwv0guCLRuSgZunWdvRBB4TKMG_X48jHFw@mail.gmail.com>
 <2433d4cb-e7f7-72c5-977b-02f51e9717b3@petezilla.co.uk>
 <e439aafe-8836-b761-3b72-b9215b463c09@gmx.com>
 <c593c2ef-044d-32e1-a75d-a2116a5b91a5@petezilla.co.uk>
In-Reply-To: <c593c2ef-044d-32e1-a75d-a2116a5b91a5@petezilla.co.uk>

--CEWE9kczmANPXpJ2EaCeOYDY7HoKWTq9x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/22 =E4=B8=8A=E5=8D=885:38, Peter Chant wrote:
> On 8/21/19 8:29 AM, Qu Wenruo wrote:
>=20
>>> I'll run the checks shortly.
>>
>> Well, check will also report that transid mismatch, and possibly a lot=

>> of extent tree corruption.
>>
>=20
>=20
> Depends on what is 'a lot', over 400 lines here:
>=20
> parent transid verify failed on 11000765267968 wanted 2265511 found 226=
5437
> parent transid verify failed on 11000777834496 wanted 2265511 found 226=
5453
> parent transid verify failed on 11001243893760 wanted 2265512 found 226=
5500
[...]
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D11016181694464 item=3D83 par=
ent
> level=3D1 child level=3D1
> ERROR: failed to repair root items: Input/output error
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/data_disk_1
> UUID: 159b8826-8380-45be-acb6-0cb992a8dfd7
>=20
>>> [   99.710315] EDAC amd64: Node 0: DRAM ECC disabled.
>>> [   99.710317] EDAC amd64: ECC disabled in the BIOS or no ECC
>>> capability, module will not load.
>>>                 Either enable ECC checking or force module loading by=

>>> setting 'ecc_enable_override'.
>>>                 (Note that use of the override may cause unknown side=

>>> effects.)
>> Not sure what the ECC part is doing, but it repeats quite some times.
>> I'd assume it's unrelated though.
>>
>=20
> Not sure either.  I've not got ECC RAM.  Motherboard is capable I think=
=2E
>=20
>=20
>=20
>> [...]
>>> [  142.507291] BTRFS error (device dm-2): parent transid verify faile=
d
>>> on 13395960053760 wanted 2265296 found 2263090
>>> [  142.544548] BTRFS error (device dm-2): parent transid verify faile=
d
>>> on 13395960053760 wanted 2265296 found 2263090
>>> [  142.544561] BTRFS: error (device dm-2) in
>>> btrfs_run_delayed_refs:2907: errno=3D-5 IO failure
>>
>> This means, btrfs is trying to read extent tree for CoW, but at that
>> time, extent tree is already corrupted, thus it returns -EIO.
>>
>> And btrfs_run_delayed_refs just returns error.
>> t
>> Not sure if it's related to device replace, but anyway the corruption
>> just happened.
>> The device replace may be an interesting clue, as currently our
>> dm-log-writes are mostly focused on single device usage.
>=20
> Sorry, 'device replace'?  I've not done that lately.  I _may_ have trie=
d
> that years back with this file system.  However, iirc it failed as the
> new, allegedly same size new disk was possibly slightly smaller.

OK, it's my bad read on the following lines:

[   99.237670] BTRFS info (device dm-2): device fsid
159b8826-8380-45be-acb6-0cb992a8dfd7 devid 4 moved old:/dev/dm-1
new:/dev/mapper/data_disk_1
[   99.241061] BTRFS info (device dm-4): device fsid
6b0245ec-bdd4-4076-b800-2243d466b174 devid 1 moved old:/dev/dm-4
new:/dev/mapper/nvme0_vg-lxc
[   99.242692] BTRFS info (device dm-2): device fsid
159b8826-8380-45be-acb6-0cb992a8dfd7 devid 3 moved old:/dev/dm-2

It just a device path update, not a big deal.
>=20
> From the above it looks like it is not a specific hardware failure.

Yep, no hardware related error message at all.

>=20
>=20
>>
>> Then I'd recommend to do regular rescue procedure:
>> - Try that skip_bg patchset if possible
>>   This provides the best salvage method so far, full subvolume
>>   available, although needs out-of-tree patches.
>>   https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D1306=
37
>>
>=20
> I can give that a go, but not for a while.
>=20
> I seem to be able to read the file system as is, as it goes read only.
> But perhaps 'seems' is the operative word.

As long as you can mount RO, it shouldn't be mostly OK for data salvage.

THanks,
Qu

>=20
>> - btrfs-restore
>>   The regular unmounted recover, needs extra space. Latest btrfs-progs=

>>   recommended.
>=20
> I've got the latest btrfs progs.    if neither of those two work I have=

> a backup.
>=20
> So, basically, make a new file system and recover the data to it.  I've=

> a new disk on the way, so I can create a file system as single and once=

> I'm happy I've migrated data to it, wipe the old disks and move one  or=

> two to the new array and rebalance.
>=20
>>
>> Thanks,
>> Qu
>>
>=20
> Thank you, very much appreciated.
>=20
> Pete
>=20


--CEWE9kczmANPXpJ2EaCeOYDY7HoKWTq9x--

--SH2CYKSJLdtFBN00mQ7azBD6L9kNM7iag
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1d1H4ACgkQwj2R86El
/qhfrggAmXnOnIUOu24acONaEA0I8P8c57gNeHbmM9G86dFbY7KMskSUk38A3JNw
FCz5819gYtn9feE0xz2hnkC/Sx7EYPsml8MQkBUx6YIApzabWB29WR8OtFV5TeY+
Rm64m3OY03yjhb8WEsP/TAgOVGS2jbSS1HpuBXF/dx85DQSP9kHmDOBENMtJyW++
lmf5pZVhCyqgvMl04SQjPVexOsasrpspkYbZUTiue2B+euFCW5EkLu13P1atQI/g
wjuc9eToas4MsAScREcR1KuIjueUKa9ynccz0wFnNiu/ZNTl1blYsb7Aq1+NyoIM
c+isfqIb3k/XLcXm2V5PEsBF3NJ7dw==
=Dnci
-----END PGP SIGNATURE-----

--SH2CYKSJLdtFBN00mQ7azBD6L9kNM7iag--
