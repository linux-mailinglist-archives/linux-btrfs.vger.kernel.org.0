Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C97D7761
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 15:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfJONZa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 09:25:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:47427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbfJONZa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 09:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571145927;
        bh=Kd3ho/UKMBw8fpyuoG53X+MX9h45I3bS37Go1+UB/OQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dCg/l200kDgKZts779m6KeeYSDFZNLUInik6niRwHpz6HHTKZP3oecA/eY/8VdDzE
         Sm2ncCIBFbpHDZBYi0S0ybz2UR5uA7rNgc0lArEIZDoAMGI1fiieWPciZ2dmCM0eRU
         Kqg18MjWmCBvXa/h3TTJyhZVZFwBKLjV0rbpGHg4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mgeo8-1hqXn72NLw-00h79x; Tue, 15
 Oct 2019 15:25:27 +0200
Subject: Re: kernel 5.2 read time tree block corruption
To:     =?UTF-8?Q?Jos=c3=a9_Luis?= <parajoseluis@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CADTa+SqDLtmmjnJ5gz-3jDxi1NGNAu=cyo0kFXSZfnu6QE_Fdw@mail.gmail.com>
 <66e27fee-7f64-6466-866d-42464fca130f@gmx.com>
 <a6d7a4c6-4295-e081-1bfc-74e9d13fd22d@gmx.com>
 <CADTa+SrurdZf5+T+QGNyLc7gKLuTFYsto+L4Q+30y-uQj+jutg@mail.gmail.com>
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
Message-ID: <3e7acddf-6503-7746-db4b-a116b7f89c4d@gmx.com>
Date:   Tue, 15 Oct 2019 21:25:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CADTa+SrurdZf5+T+QGNyLc7gKLuTFYsto+L4Q+30y-uQj+jutg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ibf8nzXqaDZAp8OIiOLbc3y8gNNVCmaVJ"
X-Provags-ID: V03:K1:v/sAxwxWYBbbD1U7K5CbJbsZMrUANOHFSh3+L23d5qCU3OEn6v8
 g9pDkQlc1k0IuvWZf5a/q0658hLLPfCXlPNCJGm5hzRevvOvzbF8nGKBuNnnIm93ueNzGo6
 e8tOmPp3U6Njy0KrHisHor+ngZ0/9oSWNS0NlqOE6Y9ujzOuK0mxInhqvmMBHDo7oVBnIT+
 KL4NLLn4ORdnL89xUuykQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bIvhh/A10aw=:NFPi+swSA/YmMxkDsjdGBf
 ipfhlr1zkiqAcbgsoyjPRCM+6OgnFObS7vR6lMSv9HosnkJQpQZ6lBOWhZKxoGwrQJ2WPOXaw
 i6XFbgTqyJxWAprQEvTpzxLn/j4M7rNuCOgrJzPN9wjssUELXIW2ysyFMu/05cDMDqK6/6H3i
 kcUR/kRiQ1Occ2qxXjhWx0UPv/IrCI9DinQN5uYAC2r75jSB/ghE7fKdSRAUUNMqhBf2zRoWX
 Q186CfqLAnzml5IsPPhxL+p1DAcDfS3krcToochEhUtSTc87kGQGa3WmBHraNI8NNIuhGc5MH
 qcuVXZjVqVxdZVKiyItWrUYskD0Zhx4TC61cY4Wxu5unN65Sv7oKHxnYSfFRI3J3Z/5Tnt+Wn
 WriAzCSg0oGR3hxVHHCCKmkFyo7q5NWgkAE8cNYf7nbV5vwoz9ygWX4GSgIatEK8gVa1CGe8J
 mDZNaTIvQGc/lk65JKlh2Hv0prWSgqEwO1wycKHgBIo8ByqCdt6wYHW7ez6+UzQZ0hPTiuEYS
 PpuYsbNTT5fscjZTn+Ju76G+Dfsda13NtVyQ5jWaQmPHBcvhiEyMjU8iiLDGXfsxCifYcyKy1
 V+p43CnPpZwE6qWB41iO9TKE9GWVE3Mv1nR+gGrr+VB7rrvHeAaM86xkROVtax1FdDXL9Q/5H
 u8/xzBNcsCybP9nP3dgjwstgUm+3fY0R0/zFwdy/8IJGX8O06XUJnky53zHuo2J/ZIq9GbPAd
 1Ipr4GzWwgi0d6THgLtgtmy7LIuAOMTQeq0ub0+j0GZY1m0Kg5RiHMtX+6M9HGNQZsp1rMT4c
 EOUSUNVHKilKw5wKojV2hxHi79DdIHiazJTI1XOHU6ip3TuANuNVmtTqwnPlSzFPCPMycgkKn
 D1KhOprL4wIZBVFcTj8vuLhsyzq8KVSQkDGxot0zrW/yiNfntnS1Bj7zuGNHh5Vu+5Vt4qJYj
 JjRHed+lre6SGvh4BnSyw+Jx60zAVwDpwg9HmniS8AFIwkoxLegcSio+bWRDrD6FOmUnXhk0S
 x7uVeqJvyZshHSAyK8DCUn01oKGIE6u4BY0TtXg4iRabOrhDUyGNCkcM4LWdeaLOLtxVupDn/
 BCqv3Y6/EMiejx8e+h1WIjQa7MIt4gzTm3ipZj7e/SJC+hfTj6xaMijscQFpSccI7ViGzn5cj
 54lrg6a6ZlV+e/0AMh0VVJRlqk+b3tO2e4S+/QDDZOfdwivhyPxuDapNiohzNYFl7jbIp+nUL
 KW1yWgnnSNldL/xFivktH7Dx/eTmaDREpayx3tkP3Fo4fFM9mFrcLzSznX6A=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ibf8nzXqaDZAp8OIiOLbc3y8gNNVCmaVJ
Content-Type: multipart/mixed; boundary="QjK5tRZnLO22WxiJyCVCc4GQpvzj1CFBP"

--QjK5tRZnLO22WxiJyCVCc4GQpvzj1CFBP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/15 =E4=B8=8B=E5=8D=8811:03, Jos=C3=A9 Luis wrote:
> Thanks for fast response Qu.
>=20
> I booted into a pendrive live system for the test cause I'm using the
> involving fylesystem with kernel 4.19. This time when I mount
>> [manjaro@manjaro ~]$ sudo mount /dev/sdb2 /mnt
>> mount: /mnt: no se puede leer el superbloque en /dev/sdb2.
> and in the dmesg:
> [ +30,866472] BTRFS info (device sdb2): disk space caching is enabled
> [  +0,017443] BTRFS info (device sdb2): enabling ssd optimizations
> [  +0,000637] BTRFS critical (device sdb2): corrupt leaf: root=3D5
> block=3D32145457152 slot=3D99, invalid key objectid: has
> 18446744073709551605 expect 6 or [256, 18446744073709551360] or
> 18446744073709551604
> [  +0,000002] BTRFS error (device sdb2): block=3D32145457152 read time
> tree block corruption detected
> [  +0,000012] BTRFS warning (device sdb2): failed to read fs tree: -5
> [  +0,061995] BTRFS error (device sdb2): open_ctree failed
>=20
> So I suppose you need dump output from the block 32145457152 so I paste=
bin that:
> sudo btrfs ins dump-tree -b 32145457152 /dev/sdb2
> output --> https://pastebin.com/ssB5HTn7

The output is way crazier than I thought...

I was only expecting some strange inode number, but what I got is
completely ridiculous.

=46rom item 96, we are having completely impossible inodes.
=46rom FREE_INO to DATA_RELOC, even EXTENT_CSUM.

All of these are impossible to exist in fs tree.
The most strange thing is, they are all last modified in 2019-2-15.

Anyway, the tree-checker is doing completely valid behavior for this
case. The data is really ridiculous.

Any history about the kernel used in that time?
I see something only possible in Windows, any clue?

>=20
> Please provide the parameter to the grep redirection for: "btrfs ins
> dump-tree -t 5 /dev/sdb2 | grep -A 7"

My bad, the parameter is "(431"

It will output all info about inode 431, so we can make sure what's
going wrong.

Thanks,
Qu
>=20
> El mar., 15 oct. 2019 a las 14:38, Qu Wenruo
> (<quwenruo.btrfs@gmx.com>) escribi=C3=B3:
>>
>>
>>
>> On 2019/10/15 =E4=B8=8B=E5=8D=888:24, Qu Wenruo wrote:
>>>
>>>
>>> On 2019/10/15 =E4=B8=8B=E5=8D=886:15, Jos=C3=A9 Luis wrote:
>>>> Dear devs,
>>>>
>>>> I cannot use kernel >=3D 5.2, They cannot mount sdb2 nor sb3 both bt=
rfs
>>>> filesystems. I can work as intended on 4.19 which is an LTS version,=

>>>> previously using 5.1 but Manjaro removed it from their repositories.=

>>>>
>>>> More info:
>>>> =C2=B7 dmesg:
>>>>> [oct15 13:47] BTRFS info (device sdb2): disk space caching is enabl=
ed
>>>>> [  +0,009974] BTRFS info (device sdb2): enabling ssd optimizations
>>>>> [  +0,000481] BTRFS critical (device sdb2): corrupt leaf: root=3D5 =
block=3D30622793728 slot=3D115, invalid key objectid: has 184467440737095=
51605 expect 6 or [256, 18446744073709551360] or 18446744073709551604
>>>
>>> In fs tree, you are hitting a free space cache inode?
>>> That doesn't sound good.
>>>
>>> Please provide the following dump:
>>>
>>> # btrfs ins dump-tree -b 30622793728 /dev/sdb2
>>>
>>> The output may contain filename, feel free to remove filenames.
>>>
>>>>> [  +0,000002] BTRFS error (device sdb2): block=3D30622793728 read t=
ime tree block corruption detected
>>>>> [  +0,000021] BTRFS warning (device sdb2): failed to read fs tree: =
-5
>>>>> [  +0,044643] BTRFS error (device sdb2): open_ctree failed
>>>>
>>>>
>>>>
>>>> =C2=B7 sudo mount  /dev/sdb2 /mnt/
>>>>> mount: /mnt: no se puede leer el superbloque en /dev/sdb2.
>>>>
>>>> (cannot read superblock on /dev...)
>>>>
>>>> =C2=B7 sudo btrfs rescue super-recover /dev/sdb2
>>>>> All supers are valid, no need to recover
>>>>
>>>>
>>>> =C2=B7 sudo btrfs check /dev/sdb2
>>>>> Opening filesystem to check...
>>>>> Checking filesystem on /dev/sdb2
>>>>> UUID: ff559c37-bc38-491c-9edc-fa6bb0874942
>>>>> [1/7] checking root items
>>>>> [2/7] checking extents
>>>>> [3/7] checking free space cache
>>>>> cache and super generation don't match, space cache will be invalid=
ated
>>>>> [4/7] checking fs roots
>>>>> root 5 inode 431 errors 1040, bad file extent, some csum missing
>>>>> root 5 inode 755 errors 1040, bad file extent, some csum missing
>>>>> root 5 inode 2379 errors 1040, bad file extent, some csum missing
>>>>> root 5 inode 11721 errors 1040, bad file extent, some csum missing
>>>>> root 5 inode 12211 errors 1040, bad file extent, some csum missing
>>>>> root 5 inode 15368 errors 1040, bad file extent, some csum missing
>>>>> root 5 inode 35329 errors 1040, bad file extent, some csum missing
>>>>> root 5 inode 960427 errors 1040, bad file extent, some csum missing=

>>>>> root 5 inode 18446744073709551605 errors 2001, no inode item, link =
count wrong
>>>>>         unresolved ref dir 256 index 0 namelen 12 name $RECYCLE.BIN=
 filetype 2 errors 6, no dir index, no inode ref
>>>
>>> Check is reporting the same problem of the inode.
>>>
>>> We need to make sure what's going wrong on that leaf, based on the
>>> mentioned dump.
>>>
>>> For the csum missing error and bad file extent, it should be a big pr=
oblem.
>>
>> s/should/should not/
>>
>>> if you want to make sure what's going wrong, please provide the
>>> following dump:
>>>
>>> # btrfs ins dump-tree -t 5 /dev/sdb2 | grep -A 7
>>>
>>> Also feel free the censor the filenames.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>> root 388 inode 1245 errors 1040, bad file extent, some csum missing=

>>>>> root 388 inode 1288 errors 1040, bad file extent, some csum missing=

>>>>> root 388 inode 1292 errors 1040, bad file extent, some csum missing=

>>>>> root 388 inode 1313 errors 1040, bad file extent, some csum missing=

>>>>> root 388 inode 11870 errors 1040, bad file extent, some csum missin=
g
>>>>> root 388 inode 68126 errors 1040, bad file extent, some csum missin=
g
>>>>> root 388 inode 88051 errors 1040, bad file extent, some csum missin=
g
>>>>> root 388 inode 88255 errors 1040, bad file extent, some csum missin=
g
>>>>> root 388 inode 88455 errors 1040, bad file extent, some csum missin=
g
>>>>> root 388 inode 88588 errors 1040, bad file extent, some csum missin=
g
>>>>> root 388 inode 88784 errors 1040, bad file extent, some csum missin=
g
>>>>> root 388 inode 88916 errors 1040, bad file extent, some csum missin=
g
>>>>> ERROR: errors found in fs roots
>>>>> found 37167415296 bytes used, error(s) found
>>>>> total csum bytes: 33793568
>>>>> total tree bytes: 1676722176
>>>>> total fs tree bytes: 1540243456
>>>>> total extent tree bytes: 81510400
>>>>> btree space waste bytes: 306327457
>>>>> file data blocks allocated: 42200928256
>>>>>  referenced 52868354048
>>>>
>>>>
>>>>
>>>>
>>>> ---
>>>>
>>>> Regards,
>>>> Jos=C3=A9 Luis.
>>>>
>>>
>>


--QjK5tRZnLO22WxiJyCVCc4GQpvzj1CFBP--

--ibf8nzXqaDZAp8OIiOLbc3y8gNNVCmaVJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2lyMEACgkQwj2R86El
/qi3uwf/XTpEVZglxR8681PoZ4mxauuIsvd7cAAsNUoh1T7AJo54bGYBD9FYI7Ll
frPpjuULd9FTLYtAbNDD6N7KtDKU/RxvcKvjQ3fltTYNnTj4V/+1Ep3mOSISuuMH
8aKe2k1gAIJKGNJVy+DQWWD9dm8AMTN3oN2TCSJSLvg0VlKVgJrw/OAQst5bq6n2
+1Bqp6Ub7V/Wh6jaUAWlDf4A/Cd+oxlzMTBcxFtaU12+5WGwb2NTi24rqLn8I+FN
TGBYA9CRam8ekGxBiPHOF+rL12aDHjGQ/Nk+PM540z27au4/bmcxE89c365YSuVQ
7y42GVAtfgVQsTGWbthk1Y9R4vfKew==
=02e+
-----END PGP SIGNATURE-----

--ibf8nzXqaDZAp8OIiOLbc3y8gNNVCmaVJ--
