Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5640E8E8AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 11:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfHOJ5J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 05:57:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:40041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730533AbfHOJ5I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 05:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565863026;
        bh=gaBbGG5simcHEzEZes8NxW6fvTvpeBGiSafIj2HCIcw=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=MZkwIQjN7HlX+LgF3Y2ZpOi0clQIN9JcvLz8g50q7yZ3N7yJbDWJLoVNcE9M+gSuR
         WYl35x32kfve+5GiVYGf9W+CGnm7LxSZ6u01lORXWs4purAbJQr10/59AunUOJcrpT
         LRMFtnhrkFuva7uU72ZEJHoTDigoPRFMjYMG4dCU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MAyZg-1i5rT30LS8-009z6I; Thu, 15
 Aug 2019 11:57:05 +0200
Subject: Re: btrfs corruption: invalid mode: has 00 expect valid S_IF* bit(s)
To:     Jim Geo <dim.geo@gmail.com>
References: <CAD9MmSeJGKx456sLLnMBUh3Jfq5nJMYMgAgeXAz5JpZZM9wZzA@mail.gmail.com>
 <126cf86b-d99c-b092-b20a-e6c3031e3675@gmx.com>
 <CAD9MmSc-ZELTEMbuHZfB8=wEnnrYwo6CAn5F4fz2tNhw6FGy5w@mail.gmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
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
Message-ID: <b8375f78-6caa-3d32-8b6b-027cd0da6c9f@gmx.com>
Date:   Thu, 15 Aug 2019 17:57:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD9MmSc-ZELTEMbuHZfB8=wEnnrYwo6CAn5F4fz2tNhw6FGy5w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XyLK4ypi6ob7FefLmNR6HKSE38ESYB6Wi"
X-Provags-ID: V03:K1:+32cFQhV3eunzXtz47x6SB9S1p2fENTU1ZjjYvKbf43KuPCiSBw
 BBhGSRbqD3m2gDVblz8LJwF1cONaWEsw3TrZcX/GdRDpK2HbvndVuSeadLEh6nX0OLKUhic
 pjG4JFvFGttiOb9JabdE1TQ14TD/6c7H/jVHz8syBdxsGXsXiXVWp5yvUUqVqiXdbtSuzpI
 ej7X+ye6MMnNH17ODoE3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jDGfG8dw4SY=:mVxsGvsXDPvLO9Fb9N9nC7
 Pkq1ULiEji9RBoBc9KlAfq0k+QEqpR+dP4Y63qBbbvWqj1Xo1TaotiLh0mtsvJWzoF7ckltZ9
 2H+fQKJnWp9esaV4V1isqSZfNJSUJoWpkcDdqZCESdL67+poHz1bW0twfre3CVvLCmqDVAZxf
 IiBvd4VPDyQ0Vw7jcOMixK8oVzsjoHhps/Hdqwr4Uf7DbRa2MHl2+0iN1TenFARq0OSx97PhL
 8o8w2UCEgrqcqZhFhEWDTt3WfxOrSGqwLMdB/YtCEcy+Rh9jsOmp1bRV+I85MzLBIvWEAt/I3
 XvjUKEKY5+J3yuiD4Pg9VCH6sstZm4llC0Yls2SPfI5unJ9rFqhQb1VKN0lOLsLxpINb8qju0
 Ci5o1EM1guB1d0LfVODQR74W6yA3tM+qWA+HKHcvM4T93RCbyQygoITe7Q+XEF6puflvF2Z3D
 h+Veuz078fVwH/UsZt5ip8CIZHHIxpp55IYO6ivzT3hSVnzESMfJw5EwVlgYDXYf4fjbKqoKQ
 ICob+pFPIdHgzDycdz4tDtIlSclQc7ohWLjk0ITsjyEfKrTrqBwYDae8Vv5VjrI8e1fSTJy1d
 y3KNhdPWef7bG6mL/THAmOp8M4AB44jz3VaidhfkurWnWnZO52JRPpzSuwxevzDSiuAB+yPIE
 SMaLAHH+OD9jvJXgmVz3Ot3cI8BWjm08xR7lr2xckzebf0g96e0AZBDw78qvLZ73iYtnc/A/F
 JajrHOz6eOO1UY3LXJ637S6EV2xiXxpMKeUg32pvKEiyTYHJgtx6F9QbgWnvi2Zka40eeSHuv
 2uU4kABmiuqUyDLlS9IeVzcgKNiOa87k0KkZK9B5aE7Prt3jsRt+26qllKpHkCVm/ZT4MRKoB
 I8GKYWGaYivNyWkheKknC+EOvh/7n4rul33N0lSKEpnY90pn7zllhCKXEltzFfrseonuSDnad
 OjleQ9hz82ekMhHFH6Mvgh3aP+EbbHhb3lVYGyfpQeBEEuCVkQ0Op8JyuzkIFLEjBuMUvF3Xx
 27Nd4hsHGYFrS2PSzuCiy08+yvz3mNQFA9FTbeLLnSBcCgdxZzXvR1kLi1S2dhwYGnQMiCW1l
 mkoxPscCkISNLAudnGgEnyLtDdHR92hUoTdMBikZc+30UMyx5yDOM6tl1WvGK/3d0LiWL+s35
 Wme82lR0i+2+LjrYdR4ubMaDWRENZNUA3KBklTn72NqHgf3A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XyLK4ypi6ob7FefLmNR6HKSE38ESYB6Wi
Content-Type: multipart/mixed; boundary="RxF3sR4wwNcCE9kHE4K9FuvaCv9aNeetj";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jim Geo <dim.geo@gmail.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <b8375f78-6caa-3d32-8b6b-027cd0da6c9f@gmx.com>
Subject: Re: btrfs corruption: invalid mode: has 00 expect valid S_IF* bit(s)
References: <CAD9MmSeJGKx456sLLnMBUh3Jfq5nJMYMgAgeXAz5JpZZM9wZzA@mail.gmail.com>
 <126cf86b-d99c-b092-b20a-e6c3031e3675@gmx.com>
 <CAD9MmSc-ZELTEMbuHZfB8=wEnnrYwo6CAn5F4fz2tNhw6FGy5w@mail.gmail.com>
In-Reply-To: <CAD9MmSc-ZELTEMbuHZfB8=wEnnrYwo6CAn5F4fz2tNhw6FGy5w@mail.gmail.com>

--RxF3sR4wwNcCE9kHE4K9FuvaCv9aNeetj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/15 =E4=B8=8B=E5=8D=885:41, Jim Geo wrote:
> =CE=A3=CF=84=CE=B9=CF=82 =CE=A0=CE=AD=CE=BC, 15 =CE=91=CF=85=CE=B3 2019=
 =CF=83=CF=84=CE=B9=CF=82 12:12 =CE=BC.=CE=BC., =CE=BF/=CE=B7 Qu Wenruo
> <quwenruo.btrfs@gmx.com> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
>>
>>
>>
>> On 2019/8/15 =E4=B8=8B=E5=8D=884:39, Jim Geo wrote:
>>> Hello,
>>>
>>> my  /home folder is on a single device btrfs partition.
>>> When I ls a directory, I get these messages on ls:
>>> ls: cannot access 'file1' : Input/output error
>>> ls: cannot access 'file2' : Input/output error
>>> ls: cannot access 'file3' : Input/output error
>>>
>>> and dmesg says:
>>> [31209.938486] BTRFS critical (device sdd1): corrupt leaf: root=3D5
>>> block=3D859701248 slot=3D93 ino=3D5830829, invalid mode: has 00 expec=
t valid
>>> S_IF* bit(s)
>>
>> Please provide the dump of that tree blocks.
>>
>> # btrfs ins dump-tree -b 859701248 /dev/sdd1
>>
>> It looks like that tree block has something wrong with it.
>> Thus kernel reject to accept the data.
> Hello,
>=20
> Attached you can find the dump.
> I changed some filenames for privacy but the filenames that came from
> the dump are the ones that ls says that are problematic.

Forgot to mention that, feel free to censor the filenames.

And it turns out that, it's indeed a corruption.

        item 93 key (5830829 INODE_ITEM 0) itemoff 5613 itemsize 160
                generation 99667 transid 99669 size 0 nbytes 0
                block group 0 mode 0 links 1 uid 0 gid 0 rdev 0
                sequence 2 flags 0x0(none)
                atime 0.0 (1970-01-01 02:00:00)
                ctime 1516386417.601932603 (2018-01-19 20:26:57)
                mtime 0.0 (1970-01-01 02:00:00)
                otime 0.0 (1970-01-01 02:00:00)
        item 94 key (5830829 INODE_REF 376204) itemoff 5584 itemsize 29
                index 61648 namelen 19 name: <censored>

First, it's an empty file without any S_IFMT flag.

I believe it's a regular file, but it's created very recently.

You can try to remove that file with older kernel (before v5.2 should
not trigger such problem).
Then the problem should be solved.

But please consider double check your memory, as it looks like a memory
bitflip or even corruption.

And also, please consider do a btrfs check --readonly to see if there is
any other problem.

Thanks,
Qu

>=20
> Thanks a lot!
>>
>> [...]
>>>
>>> I scrubbed the filesystem but no errors were detected/fixed.
>>
>> Scrub mostly only verify checksum, doesn't care about the data in the
>> tree blocks.
>>
>>>
>>> btrfs scrub status /home:
>>> scrub status for myuuid
>>>         scrub started at Thu Aug 15 02:24:42 2019 and finished after =
03:55:12
>>>         total bytes scrubbed: 2.05TiB with 0 errors
>>>
>>>  uname -a:
>>> Linux gentoo 5.2.8-ck #1 SMP PREEMPT Wed Aug 14 20:44:33 EEST 2019
>>> x86_64 Intel(R) Core(TM) i5-4460 CPU @ 3.20GHz GenuineIntel GNU/Linux=

>>>
>>> btrfs --version:
>>> btrfs-progs v4.19
>>>
>>> btrfs fi show:
>>> Label: 'home_btrfs'  uuid:-------
>>>         Total devices 1 FS bytes used 2.04TiB
>>>         devid    1 size 2.13TiB used 2.13TiB path /dev/sdd1
>>>
>>> btrfs fi df /home:
>>> Data, single: total=3D2.12TiB, used=3D2.04TiB
>>> System, DUP: total=3D64.00MiB, used=3D256.00KiB
>>> Metadata, DUP: total=3D7.00GiB, used=3D4.48GiB
>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>
>>> btrfs device stats /home:
>>> [/dev/sdd1].write_io_errs    4
>>> [/dev/sdd1].read_io_errs     3
>>> [/dev/sdd1].flush_io_errs    0
>>> [/dev/sdd1].corruption_errs  0
>>> [/dev/sdd1].generation_errs  0
>>>
>>> mount options:
>>> /dev/sdd1 on /home type btrfs
>>> (rw,relatime,space_cache,autodefrag,subvolid=3D5,subvol=3D/)
>>>
>>> How can I fix this corruption? How can I detect if more
>>> files/directories are affected?
>>
>> Affected inode number is 5830829. But I need to above mentioned dump t=
o
>> make sure if it's not a false alert.
>>
>> If it's truely corrupted by whatever the reason, you'd
>> better check your memory, as it looks like a bit flip.
>>
>> Thanks,
>> Qu
>>>
>>> Kind Regards,
>>> Jim
>>>
>>


--RxF3sR4wwNcCE9kHE4K9FuvaCv9aNeetj--

--XyLK4ypi6ob7FefLmNR6HKSE38ESYB6Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1VLG0ACgkQwj2R86El
/qjb3gf/ZTqVvioVIxgqVjYI7lqsnNAGHsMRJxbdS9Yq1unJbZLoJn+l5giOFGZI
JOvo9jJxQ3eJmQR3GbCUGacHFliS4mbVUrD7VWxhxBXcDuTb22aCJi4BbM8M7Yn1
pOQ8ltjnVB6TBAWfu66qP9+CM8tqXkS2GatX17MQbQkiOCurSy1jnRzmfTjeVQSX
wZsTtTZeXUJXuF2uwYAzLy2J78f2YXeofd0i5kXvHML/CWQBrRhkVJxAbN1d6Py8
mOdXL4CmdyiiQu+BoWoE3bSZD0kaWlgX32cuUCg/5KSbLHhc5eciAuxIt9O7aswK
0eTtlR0FUlvBXYlv4cg1hr+GyIi68A==
=lSIu
-----END PGP SIGNATURE-----

--XyLK4ypi6ob7FefLmNR6HKSE38ESYB6Wi--
