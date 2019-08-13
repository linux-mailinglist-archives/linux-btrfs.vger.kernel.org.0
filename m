Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82808C4C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 01:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfHMXYz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 19:24:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:59927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfHMXYz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 19:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565738686;
        bh=cNwJTc0Afy2EiqdUEK956g2Q6UCM8ISdJBedDrT8oPk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fhscwHfNQAl12q7w3k9OYmO+xLSmmieKB5i/YzSBCFKJ9oaGUHi4m4kjXiBmJuEEy
         Qv1wJUAgsW8DaCskvYD0ZGtYBp28nY+t7TNFEfNNQ9ivZ/Pd3Ca9Ur3WA0/CpufrVM
         /41l7YBwxl61rZGc8O9UCwRECX/hvxvBB9WW4qF8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MVayZ-1hmwNu3j7n-00Z0BX; Wed, 14
 Aug 2019 01:24:46 +0200
Subject: Re: btrfs errors
To:     "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <347523577.41.1565689723208.JavaMail.gkos@xpska>
 <8cdacece-32a3-daf7-3ac8-f062179ebbaf@gmx.com>
 <744798339.29.1565703591504.JavaMail.gkos@xpska>
 <f2899154-3de6-3d8b-706c-539911831d17@gmx.com>
 <1425294964.32.1565720950325.JavaMail.gkos@xpska>
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
Message-ID: <3ef16706-8c2f-f47d-8057-38c567487926@gmx.com>
Date:   Wed, 14 Aug 2019 07:24:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1425294964.32.1565720950325.JavaMail.gkos@xpska>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MY6U0MZFrbIKcrK62O9dDvMnUAwwctoe9"
X-Provags-ID: V03:K1:uT+vTdwnHO9xhRDgXTSiq8hIlVNCiNz+f9muVSaRL07HWMelTXy
 A86pznBXLpZcbyzWwYTNDT52iD+0z/aKZE6skMQLbaVxLKblHprOpQ1C1Zk4oaJuPepLIk3
 BPfDDaFqnOGhgMHlKDBTk3nvnwKDOg332+N/YpcwwVsJya+r08pMzUNYogjuI7vJ8wFn1+F
 cRWvBmDW9JQC2aFJLvzPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gPvkRsA5HqE=:bw/SrFCZzBa/AI+2plp92Z
 y8PbtdAB0ioZA//eH6bbv9Vx38oHAjz0M37D8mHlmnviOYJ7vGySNGG0B0tfqhTv1zx9yZOJ+
 y7/0cDDY/1F6s+csLWRTDyn1LRQ6tyN1+5pPMlSUI3BOXC3U4Kx45rrgoo82BJJUzFF775b4W
 7bHfF+aqduH7E421Ao4qya6cDSBBeaf/eTm4y9nlnfCI90plcRL7cJyUEDRnhgaURhwiiYM8P
 hJVcs5GqsUaPNbksMhSLZ2XsdxKmynNcRwcqLI/o+Ou8bFvl+fylXsKGfVZIVAdLR8kEDYgoc
 8FDCRgzddcmJ1BshFWZ9rlM/OTfj+0Mr3jrWasJDKA0zCNJ6FJ/1oFJi5nzrhHqx6fmS028vZ
 G23Zt/PylAQTU/LvQ/xlbYVBuZQ5uZv7ZdTDjLq2ZGcEKMI8mKW0lTGk8N+a6zk9eBxQegl2X
 TYdIHdHQC94ZW/brEKAvc4Q8srGYKTJzI/jjxPEg6H2lLhx6wjprXxbsHBslEb+M5J71yzHb+
 LpnMFxcVx1SZhFP4bUqLHdTZIrzuFwCE06bJ9clOOhczOUYGFJrKS1t70uGszn7I8iv98ZPqP
 fzSpE8cmIRBasdM5Mt3BGPIGjrbM78CLLYnlu8s8yL1FKo8FWmpC4xUJvHbDYid40dh33eTs5
 FT5jDqwhSJPh+ro3NlzzIMlignTBu0e+dvkMkGE0DpfoAyCuU8ZsW0vKqvzTJA0wTFEZJkRAG
 A5e9Uy2CfVwXtCZ4C8vQwt+TYcUAjim5JTVJ80KoBOY9DfwBei5l6QkK4mHDw5xV6u0kwBMpu
 qIqnWy2b5iulas7YTMn2IRnvqmQmiUQ749PwEVEwdttQa3myHw9wnE/WGPKi+2+RphQdJLgEj
 VZ4cbnaukqmv5xl6G50lgccfDqZnjblIBZHs0BpRUgx1emyxFfSZLrLUR0Ks5oz8M776hfPO9
 KQLthxM+bOlUZVUk0C7ciBQBA5Ofv87y+R0z6dTA7EnLZgBQvvZXcB2c6NIW8V/3edHi/Kmnd
 kVM1VU+X87vyZ1vqxgUT1gnDz4Iu2/1+PMNF2UmelCnqWzww7n0zYKauEp7wgdrKhhtqO5TdL
 2bJDpK/aQYStbhDfAzjRoeAFwXjpZPSxkmzgCFUN7NkByqfd0fhkkVsxg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MY6U0MZFrbIKcrK62O9dDvMnUAwwctoe9
Content-Type: multipart/mixed; boundary="EpmydCVF2C0G8YVaREp2MtEKXzHOPakXn";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <3ef16706-8c2f-f47d-8057-38c567487926@gmx.com>
Subject: Re: btrfs errors
References: <347523577.41.1565689723208.JavaMail.gkos@xpska>
 <8cdacece-32a3-daf7-3ac8-f062179ebbaf@gmx.com>
 <744798339.29.1565703591504.JavaMail.gkos@xpska>
 <f2899154-3de6-3d8b-706c-539911831d17@gmx.com>
 <1425294964.32.1565720950325.JavaMail.gkos@xpska>
In-Reply-To: <1425294964.32.1565720950325.JavaMail.gkos@xpska>

--EpmydCVF2C0G8YVaREp2MtEKXzHOPakXn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Thanks for the dump.

Now it's very clear what the problem is.

It's an old kernel behavior which allows compressed file extents to have
NODATASUM flag.

The behavior is going to be fixed in v5.3 by commit 42c16da6d684
("btrfs: inode: Don't compress if NODATASUM or NODATACOW set").

Currently you can just dismiss the false alert.
The only minor downside of the current behavior is, if one copy of your
data is corrupted, there is no chance to recover the data even you're
using DUP/RAID1/RAID5/RAID6/RAID10.

Or you can wait for v5.3 kernel and copy old data back to a newly
created fs which only modified by v5.3 kernel.

Thanks,
Qu

On 2019/8/14 =E4=B8=8A=E5=8D=882:29, Konstantin V. Gavrilenko wrote:
>=20
>=20
> Yours sincerely,
> Konstantin V. Gavrilenko
>=20
> Director
> Arhont Services Ltd
>=20
> web:    http://www.arhont.com
> e-mail: k.gavrilenko@arhont.com
>=20
> tel: +44 (0) 870 44 31337
> fax: +44 (0) 208 429 3111
>=20
> PGP: Key ID - 0xE81824F4
> PGP: Server - keyserver.pgp.com
>=20
>=20
> ----- Original Message -----
> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> To: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
> Cc: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Sent: Tuesday, 13 August, 2019 4:01:30 PM
> Subject: Re: btrfs errors
>=20
>=20
>=20
> On 2019/8/13 =E4=B8=8B=E5=8D=889:40, Konstantin V. Gavrilenko wrote:
>>
>> Hi Qu,
>>
>> thanks for the quick response. so I've booted into the latest Archiso =
(kernel 5.2.xx, btrfs 5.2.xx) and rerun the # btrfs check  and # btrfs sc=
rub. The btrfs check output is rather large and is included as an attachm=
ent to this message.
>>
>> It seems that the problem lies in fs_roots.
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space cache
>> [4/7] checking fs roots=20
>> root 257 inode 6360900 errors 1000, some csum missing=20
>> root 258 inode 364233 errors 1040, bad file extent, some csum missing
>> root 258 inode 364234 errors 1040, bad file extent, some csum missing
>> ....
>> root 258 inode 5074178 errors 100, file extent discount
>> Found file extent holes:
>> 	start: 0, len: 4096
>> root 258 inode 5386921 errors 1040, bad file extent, some csum missing=

>> ...
>> ERROR: errors found in fs roots
>>
>>
>> Opening filesystem to check...
>> Checking filesystem on /dev/kubuntu-vg/lv_root
>> UUID: 7b19fb5e-4e16-4b62-b803-f59364fd61a2
>> cache and super generation don't match, space cache will be invalidate=
d
>> found 335628447749 bytes used, error(s) found
>> total csum bytes: 292272496
>> total tree bytes: 5118279680
>> total fs tree bytes: 4523163648
>> total extent tree bytes: 244498432
>> btree space waste bytes: 1186351226
>> file data blocks allocated: 536719597568
>>  referenced 630181720064
>=20
> The result indeeds shows some *minor* problem.
>=20
> One is "bad file extent" normally related to some extent too large for
> compressed inlined extent.
>=20
> Considering you're using lzo compression, it looks like some older
> kernel behavior which is no longer considered sane nowadays.
>=20
> You don't need to panic (never run btrfs check --repair yet), as your f=
s
> is mostly fine, no data loss or whatever.
>=20
> At least in recent kernel releases, you won't hit a problem.
>=20
>=20
> KVG: Good to hear that. Actually this system is about 1.5 y/o, since th=
e release of Ubuntu 18.04LTS that was shipped with 4.15
> and the mount options remained the same from the start. the kernel upgr=
ade path was 4.18 in Feb'19, then 5.0 in Apr'19 followed by 5.1 in May'19=
=2E
>=20
> I also used to run on a monthly basis for about a year.
>=20
>        btrfs filesystem defrag -r -t 32m $MP 2> /dev/null
>        btrfs balance start -musage=3D35 -dusage=3D55 $MP
>=20
> but once I started doing daily snapshost, I stopped doing it a it was m=
essing the free space calculations.
>=20
>=20
>>
>>
>> so I've mounted the FS and run scrub, which resulted in "ALL OK" again=
=2E
>> UUID:             7b19fb5e-4e16-4b62-b803-f59364fd61a2
>> Scrub started:    Tue Aug 13 13:01:26 2019
>> Status:           finished
>> Duration:         0:02:44
>> Total to scrub:   312.59GiB
>> Rate:             1.91GiB/s
>> Error summary:    no errors found
>>
>>
>> I have backed up all the important data on the external disc just now,=
 and no errors in the dmesg were reported, so I assume the data is OK.
>> I also have snapshots of this system stored on the external disc datin=
g back to Apr'19.
>=20
> Currently it looks like false alert.
>=20
> But to be sure, please do me a favor by running lowmem mode check, whic=
h
> should output more useful info other than "bad file extent".
>=20
> # btrfs check --mode=3Dlowmem <dev>
>=20
> It may take a longer time to finish. But should be more useful.
>=20
>=20
>=20
> KVG: Indeed, the btrfs check generated 150k lines of text :)
> so the more detailed errors fall into the following categories
>=20
> 326 lines similar to
> ERROR: root 258 INODE[5074178] size 162 should have a file extent hole
> ERROR: root 258 INODE[5711285] size 586 should have a file extent hole
> ERROR: root 258 INODE[5761076] size 215 should have a file extent hole
>=20
> 75584 lines similar to
> ERROR: root 258 EXTENT_DATA[364233 0] is compressed, but inode flag doe=
sn't allow it
> ERROR: root 258 EXTENT_DATA[364233 131072] is compressed, but inode fla=
g doesn't allow it
> ERROR: root 258 EXTENT_DATA[364233 262144] is compressed, but inode fla=
g doesn't allow it
>=20
> 75693 lines similar to
> ERROR: root 258 EXTENT_DATA[364233 0] compressed extent must have csum,=
 but only 0 bytes have, expect 4096
> ERROR: root 258 EXTENT_DATA[364233 131072] compressed extent must have =
csum, but only 0 bytes have, expect 16384
> ERROR: root 258 EXTENT_DATA[364233 262144] compressed extent must have =
csum, but only 0 bytes have, expect 4096
>=20
> The complete output is xz'ed and attached.
>=20
>=20
>> So I guess the two important questions are=20
>> - is it possible to reliable recover FS, or at least find out which fi=
les were affected  at the reported inode location.
>=20
> If it's a false alert, you don't need to recover anything.
>=20
> If it's too strict btrfs check, and you want to follow latest btrfs
> *too sane* behavior, you can just try copy the old data to a newly
> created btrfs.
>=20
> KVG: Sure, thats one of the possibilities. What about if I try a forcef=
ul recompression of the complete FS via=20
> # btrfs filesystem defragment -c $MP
>=20
> or alternatively I can try to remove compression alltogether and run a =
defrag to see if that helps remove the problem.
> What do you think?
>=20
> thanks,
> Kos
>=20
>=20
>=20
> Thanks,
> Qu
>=20
>> - is it possible to # btrfs check <snapshot> without copying it back o=
n the main disk. maybe loopdevice?
>>
>>
>> thanks,
>> Konstantin
>>
>>
>> ----- Original Message -----
>> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>> To: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>, "linux-btrfs=
" <linux-btrfs@vger.kernel.org>
>> Sent: Tuesday, 13 August, 2019 12:55:47 PM
>> Subject: Re: btrfs errors
>>
>>
>>
>> On 2019/8/13 =E4=B8=8B=E5=8D=885:48, Konstantin V. Gavrilenko wrote:
>>> Hi list
>>>
>>> I have run the btrfs check, and that reported multiple errors on the =
FS.
>>>
>>> # btrfs check --readonly --force /dev/kubuntu-vg/lv_root
>>> <SKIP>
>>
>> Please don't skip the output, especially for btrfs check.
>>
>> The first tree btrfs check checks is extent tree, if we have anything
>> wrong in extent tree, it's way serious than the later part.
>>
>> And I understand you want to check your root fs, thus you have to use
>> --force, but I'd recommend to go whatever distro you like, use its
>> liveCD/USB to check your root fs.
>>
>> It looks like that since your fs is still mounted, the data structure
>> changed during the btrfs check run, it's possible to cause false alert=
=2E
>>
>>> root 9214 inode 6850330 errors 2001, no inode item, link count wrong
>>>         unresolved ref dir 266982 index 22459 namelen 36 name 9621041=
045a17a475428a26fcfb5982f.png filetype 1 errors 6, no dir index, no inode=
 ref
>>>         unresolved ref dir 226516 index 9 namelen 28 name GYTSPMxjwCV=
p8kXB7+j91O8kcq4=3D filetype 1 errors 4, no inode ref
>>> root 9214 inode 6877070 errors 2001, no inode item, link count wrong
>>>         unresolved ref dir 226516 index 11 namelen 28 name VSqlYzl4pF=
qJpvC3GA9bQ0mZK8A=3D filetype 1 errors 4, no inode ref
>>> root 9214 inode 6878054 errors 2001, no inode item, link count wrong
>>>         unresolved ref dir 266982 index 22460 namelen 36 name 52e74e9=
d2b6f598038486f90f8f911c4.png filetype 1 errors 4, no inode ref
>>> root 9214 inode 6888414 errors 2001, no inode item, link count wrong
>>>         unresolved ref dir 226391 index 122475 namelen 14 name the-re=
al-index filetype 1 errors 4, no inode ref
>>> root 9214 inode 6889202 errors 100, file extent discount
>>> Found file extent holes:
>>>         start: 0, len: 4096
>>> root 9214 inode 6889203 errors 100, file extent discount
>>> Found file extent holes:
>>>         start: 0, len: 4096
>>> ERROR: errors found in fs roots
>>> found 334531551237 bytes used, error(s) found
>>> total csum bytes: 291555464
>>> total tree bytes: 1004404736
>>> total fs tree bytes: 411713536
>>> total extent tree bytes: 242974720
>>> btree space waste bytes: 186523621
>>> file data blocks allocated: 36730163200
>>>  referenced 42646511616
>>>
>>>
>>> However, scrub and badblock find no errors.
>>>
>>> # btrfs scrub status /mnt/
>>> scrub status for 7b19fb5e-4e16-4b62-b803-f59364fd61a2
>>>         scrub started at Tue Aug 13 07:31:38 2019 and finished after =
00:02:47
>>>         total bytes scrubbed: 311.15GiB with 0 errors
>>
>> Scrub only checks checksum, doesn't care the content.
>> (Kernel newer than v5.0 will care the content, but doesn't do full
>> cross-check, unlike btrfs-check)
>>
>>>
>>> # badblocks -sv /dev/kubuntu-vg/lv_root=20
>>> Checking blocks 0 to 352133119
>>> Checking for bad blocks (read-only test):  done                      =
                          =20
>>> Pass completed, 0 bad blocks found. (0/0/0 errors)
>>>
>>> # btrfs dev stats /dev/kubuntu-vg/lv_root                            =
                                                                         =
                                                 =20
>>> [/dev/mapper/kubuntu--vg-lv_root].write_io_errs    0
>>> [/dev/mapper/kubuntu--vg-lv_root].read_io_errs     0
>>> [/dev/mapper/kubuntu--vg-lv_root].flush_io_errs    0
>>> [/dev/mapper/kubuntu--vg-lv_root].corruption_errs  0
>>> [/dev/mapper/kubuntu--vg-lv_root].generation_errs  0
>>>
>>>
>>>
>>> FS mount fine, and is operational.
>>> would you recommend executing the btrfs check --repair option or is t=
here something else that I can try.
>>
>> Don't do anything stupid yet.
>> Just go LiveCD/USB and check again.
>>
>>>
>>> #  uname -a                                                          =
                                                                         =
                                                      Linux xps 5.1.16-05=
0116-generic #201907031232 SMP Wed Jul 3 12:35:21 UTC 2019 x86_64 x86_64 =
x86_64 GNU/Linux
>>
>> Since v5.2 introduced a lot of new restrict check, I'd recommend to go=

>> mount with latest Archiso, btrfs-check first, if no problem, mount and=

>> scrub again just in case.
>>
>>> # btrfs --version                                                    =
                                                                         =
                                                 =20
>>> btrfs-progs v4.15.1
>>
>> Big nope. You won't really want to run btrfs check --repair on such ol=
d
>> and buggy progs. Unless recent releases (5.2?) btrfs-progs has a bug
>> that transaction is not committed correctly, thus if something wrong
>> happened like BUG_ON() or transaction aborted, the fs can easily be
>> screwed up.
>>
>> Thanks,
>> Qu
>>
>>>
>>>
>>> mount options
>>> on / type btrfs (rw,relatime,compress-force=3Dlzo,ssd,discard,space_c=
ache=3Dv2,autodefrag,subvol=3D/@)
>>>
>>> thanks,
>>> Konstantin
>>>
>>
>=20


--EpmydCVF2C0G8YVaREp2MtEKXzHOPakXn--

--MY6U0MZFrbIKcrK62O9dDvMnUAwwctoe9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1TRroACgkQwj2R86El
/qj0SggApFgBVLz19PamNmPIL0HwS2Ry+V8wOd+XAGSGW/zdXInGDGlXfOVdEOKW
wexSGS6+LIFiklr1rFtQNycc1+cAdo/45YPj3+L6UlsmLTRi4RpE+0B/UuDiPy+/
4wCZPXccNc0g/wULaWSh9Vn6ePEzJzQUrJeLe8nDOdDGQMAbsMbEmNzQkvoxi14m
wrR6aqROvsMJ1JfqdN+Z5XbMe1hOSrNVGQ4Ga2Kdw89PqL+h7YT8k8MUeCqC0qzo
2KUShJikjobvfBOWztYlioXyF9qgZfupVErzbSMYf40pQKKFWNWy2gphi8PtsiU9
47qd+P0Uu3hpfF+1pStOH4KcaCP9jQ==
=Iroy
-----END PGP SIGNATURE-----

--MY6U0MZFrbIKcrK62O9dDvMnUAwwctoe9--
