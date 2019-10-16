Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD79BD8503
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 02:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfJPAnk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 20:43:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:57329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfJPAnk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 20:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571186615;
        bh=1LmidhbngFvUA+E/KzEIgNCew6eGqGnf9eLytngkovM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jYWrIsBZFT3TRwBB73ppjjDT7ggnU8quaZN2QyfkybBxG8OA+zWlzZu+1PefZpjVK
         y+4p9FoLeX3U7Adw+omx7+HKNc7G04/eCNw7aWr97pUkFTdk+X6mkIZ/TB+F/VZiOp
         eqeJTu47fiR/WsMA2bhCWmUqImsNtPbr8mkFN4/o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryTF-1hgEIl3ek9-00nwyu; Wed, 16
 Oct 2019 02:43:35 +0200
Subject: Re: kernel 5.2 read time tree block corruption
To:     =?UTF-8?Q?Jos=c3=a9_Luis?= <parajoseluis@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CADTa+SqDLtmmjnJ5gz-3jDxi1NGNAu=cyo0kFXSZfnu6QE_Fdw@mail.gmail.com>
 <66e27fee-7f64-6466-866d-42464fca130f@gmx.com>
 <a6d7a4c6-4295-e081-1bfc-74e9d13fd22d@gmx.com>
 <CADTa+SrurdZf5+T+QGNyLc7gKLuTFYsto+L4Q+30y-uQj+jutg@mail.gmail.com>
 <3e7acddf-6503-7746-db4b-a116b7f89c4d@gmx.com>
 <CADTa+SoDEcHvpJj6-QMHUubFcKACiKLQ6izr=uER-hYtqVg20g@mail.gmail.com>
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
Message-ID: <0cae0d30-db18-37cc-562f-100c862099e3@gmx.com>
Date:   Wed, 16 Oct 2019 08:43:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CADTa+SoDEcHvpJj6-QMHUubFcKACiKLQ6izr=uER-hYtqVg20g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZGih63Cb5uBeTVzSQqK5X27B2Bg5jtaQV"
X-Provags-ID: V03:K1:BXksAcSKBWkRka0blmqD45ozDne2oT778m2FIxOw2qZiHAmV1Fc
 euYfTP7bkeiPyFdQJKH59egc95Q/b7V+QbxHUdgRyEESjHCGVfeMxXY9K67uSXlgym5Rwqr
 VSAviwRnGGYLZ13YgFNF7hQdmJ2tPc8phcxKXTUFY1UztaUEal04DBxjYX8PMZ1I1oDVyBf
 bxRkfHkBN8iBt83QUp6bQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ZaXeFJST1s=:/hEmVNMYPLRhg3GjJvIaza
 7bHWgl8501XOOJWU2Q4N6I3QZbvlpYhWv0dQ75Ev4yeTbyf/V2lXHAUiYc3c4d7l4txesxcet
 A4wkTTrXxgjmFrsHKnwww0oZWtCbGnhY0o7C95FzQ7VS5iBxbSnBjfBN6ahPccfUKQQAflj7f
 +UdOzeDipuenw+Daez08W4vWalws2/z6IIi+rBjV1AfeP6ctoq1tI2PRvp4d0DUUYoT52Rq8N
 nuc1/CWX2KZiThfo3r3Hvdzxrn0wS9pbZYo23HOQxhNtQqpccC3DFOAi3Z58Md4gg0zO0v+0n
 Q5fSUB4/RAcKsITdr0hBkaA7yMwR4BgNvtml4vsipcm1rewkUgH71SU8bwCJ78IyEfmVYwWw0
 K6w61hKx0pDzFh03zpAXsB6vj3JCWyke5pSDEN+cCyL8y1rkncnoVUgZo9F3+QC1yJoBj4on0
 t28IEgwoZLVwpdq5jAHDh5UMo4g/IpTrxPREUgrUKf07pns20ENwhHCoA6NRP495x+dMIJW9s
 P+3uZiMih1pSn/qLrpZNHQk9sHivxKIu0JTCA5DT8in8MWkjBpHpFRgOdcRwHlCU3OBjd/5sL
 UpFNYIycQJO7J3P2z90RCNN5Uq5EvT+TJWrZS8cQrf/IG0gNlP2efpN9oAhVpBez/PdvCioRp
 PGZEX/knS2tMH1yapIrn0ytgjkK6f48lS/RvAcoQ5k4qU4YmL+FD0FUMsHnkWZs0pv5JcDv3J
 kK9JemIeOdEYJuAofhq2dzsuOoZvY5vvjRIQHCrXw2ru92sb8Uvdfma7uAs8gfsNsgKMGedHC
 qUiF+xAu07WaGtK1KFU7TI72bzv7YQwczzY/Q4NERJFnHvmAlNMqXsurWbKboMBD2m2D7Xvul
 HhHEIB8UBIR4lFVx/DS34t+YGtVI8HSs17Xluedw6K9J063nqTyDwQjxzC2aSSgdJGOO2SV5h
 +/3kOZ11ZQSXyV29NxXA96TWSqmP7RD8+E491cmBkKSdKSqFN8C2XbUczx6MjvL0ZfmJkPerF
 cdFStJOo5Vec9B7gcQzO8lO74aS1EWyxdxSnHfIk4D/576ucLX7J9Wo93oJYsnfDL04/7DSTI
 Jrb/gWAybVuRxRfieUBx8xK0peUbKrhQWYDDsaXpPWse3KmydSa+XpWbE6njT1HUhaH2EZCXV
 9nc3/AmD7mN/QDGA0edMXvKEClLTjMAnUzZ+6BI90zWQnuCZFoM3D6E8yZ89Imm/L7G5uRUPU
 wWyCrjCkcMv+hqquk5bhMqvA8HdBDs1uemJ60ZVPWkvVvRkDQKZsfpnuPII0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZGih63Cb5uBeTVzSQqK5X27B2Bg5jtaQV
Content-Type: multipart/mixed; boundary="LJxPVva8FIddgCtHnTAtIjCZxQLVRvABC"

--LJxPVva8FIddgCtHnTAtIjCZxQLVRvABC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/16 =E4=B8=8A=E5=8D=881:55, Jos=C3=A9 Luis wrote:
> I also noticed the craziness of the previous dump. I cannot remember
> the kernel running by this date but I use to install the latest stable
> kernel on the Manjaro repositories (I'm an early adopter :P).
> According the Manjaro forum release news they roll up version 4.19 by
> these days so probably I was using kernel 4.19 or 4.18. Diggin on my
> memory, maybe I could access that filesystem from a Windows 10 running
> on another disk using the windows btrfs driver that could be the
> origin of the problem.

That explains the problem why there are some strange windows related file=
=2E

And that also explains why kernel tree-checker isn't happy about that at
all.
Maybe Windows btrfs driver is using some strange inode number to do its
own work, but definitely not something friendly to upstream btrfs.

You may want to report the bug to windows btrfs developers.

>=20
> I added a \s to the pattern you provided to avoid undesired inode infor=
mation:
> [manjaro@manjaro ~]$ sudo btrfs ins dump-tree -t 5 /dev/sdb2 | grep "(4=
31 " -A 7
> output --> https://pastebin.com/y3LzqNx6

I see no obvious problem. Maybe some compressed data extent doesn't have
csum, then btrfs check reports it as bad file extent.

Original mode doesn't report info as detailed as possible.
But anyway, it shouldn't be a big problem.

If you're not confident about it, you can try to defrag those inodes, it
should rewrite them and populate the csum.

>=20
> Is there any magic command to repair my sdb2 filesystem? Or I have to
> backup data and rebuild those filesystems?

In fact it's not that hard to repair, just remove the offending craziness=
=2E

btrfs-corrupt-block should provide the ability to delete items.
It a tool included in btrfs-progs, but not provided in btrfs-progs
packages. You may need to compile it from source code.

In your case, you need quite some calls to delete all the bad inodes:

/* FREE_INO INODE_ITEM 0 */
# ./btrfs-corrupt-block -d 18446744073709551604,1,0 /dev/sdb2

/* FREE_SPACE UNTYPED 0 */
# ./btrfs-corrupt-block -d 18446744073709551605,0,0 /dev/sdb2

=2E..

And so on. You need to parse the key output to numeric value and pass it
to btrfs-corrupt-block, until all finished.

If it's too slow, I could add a new hack into btrfs-corrupt-block to
delete them in a batch.

Thanks,
Qu
>=20
> Thanks Qu,
> Jos=C3=A9 Luis
>=20
> El mar., 15 oct. 2019 a las 15:25, Qu Wenruo
> (<quwenruo.btrfs@gmx.com>) escribi=C3=B3:
>>
>>
>>
>> On 2019/10/15 =E4=B8=8B=E5=8D=8811:03, Jos=C3=A9 Luis wrote:
>>> Thanks for fast response Qu.
>>>
>>> I booted into a pendrive live system for the test cause I'm using the=

>>> involving fylesystem with kernel 4.19. This time when I mount
>>>> [manjaro@manjaro ~]$ sudo mount /dev/sdb2 /mnt
>>>> mount: /mnt: no se puede leer el superbloque en /dev/sdb2.
>>> and in the dmesg:
>>> [ +30,866472] BTRFS info (device sdb2): disk space caching is enabled=

>>> [  +0,017443] BTRFS info (device sdb2): enabling ssd optimizations
>>> [  +0,000637] BTRFS critical (device sdb2): corrupt leaf: root=3D5
>>> block=3D32145457152 slot=3D99, invalid key objectid: has
>>> 18446744073709551605 expect 6 or [256, 18446744073709551360] or
>>> 18446744073709551604
>>> [  +0,000002] BTRFS error (device sdb2): block=3D32145457152 read tim=
e
>>> tree block corruption detected
>>> [  +0,000012] BTRFS warning (device sdb2): failed to read fs tree: -5=

>>> [  +0,061995] BTRFS error (device sdb2): open_ctree failed
>>>
>>> So I suppose you need dump output from the block 32145457152 so I pas=
tebin that:
>>> sudo btrfs ins dump-tree -b 32145457152 /dev/sdb2
>>> output --> https://pastebin.com/ssB5HTn7
>>
>> The output is way crazier than I thought...
>>
>> I was only expecting some strange inode number, but what I got is
>> completely ridiculous.
>>
>> From item 96, we are having completely impossible inodes.
>> From FREE_INO to DATA_RELOC, even EXTENT_CSUM.
>>
>> All of these are impossible to exist in fs tree.
>> The most strange thing is, they are all last modified in 2019-2-15.
>>
>> Anyway, the tree-checker is doing completely valid behavior for this
>> case. The data is really ridiculous.
>>
>> Any history about the kernel used in that time?
>> I see something only possible in Windows, any clue?
>>
>>>
>>> Please provide the parameter to the grep redirection for: "btrfs ins
>>> dump-tree -t 5 /dev/sdb2 | grep -A 7"
>>
>> My bad, the parameter is "(431"
>>
>> It will output all info about inode 431, so we can make sure what's
>> going wrong.
>>
>> Thanks,
>> Qu
>>>
>>> El mar., 15 oct. 2019 a las 14:38, Qu Wenruo
>>> (<quwenruo.btrfs@gmx.com>) escribi=C3=B3:
>>>>
>>>>
>>>>
>>>> On 2019/10/15 =E4=B8=8B=E5=8D=888:24, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2019/10/15 =E4=B8=8B=E5=8D=886:15, Jos=C3=A9 Luis wrote:
>>>>>> Dear devs,
>>>>>>
>>>>>> I cannot use kernel >=3D 5.2, They cannot mount sdb2 nor sb3 both =
btrfs
>>>>>> filesystems. I can work as intended on 4.19 which is an LTS versio=
n,
>>>>>> previously using 5.1 but Manjaro removed it from their repositorie=
s.
>>>>>>
>>>>>> More info:
>>>>>> =C2=B7 dmesg:
>>>>>>> [oct15 13:47] BTRFS info (device sdb2): disk space caching is ena=
bled
>>>>>>> [  +0,009974] BTRFS info (device sdb2): enabling ssd optimization=
s
>>>>>>> [  +0,000481] BTRFS critical (device sdb2): corrupt leaf: root=3D=
5 block=3D30622793728 slot=3D115, invalid key objectid: has 1844674407370=
9551605 expect 6 or [256, 18446744073709551360] or 18446744073709551604
>>>>>
>>>>> In fs tree, you are hitting a free space cache inode?
>>>>> That doesn't sound good.
>>>>>
>>>>> Please provide the following dump:
>>>>>
>>>>> # btrfs ins dump-tree -b 30622793728 /dev/sdb2
>>>>>
>>>>> The output may contain filename, feel free to remove filenames.
>>>>>
>>>>>>> [  +0,000002] BTRFS error (device sdb2): block=3D30622793728 read=
 time tree block corruption detected
>>>>>>> [  +0,000021] BTRFS warning (device sdb2): failed to read fs tree=
: -5
>>>>>>> [  +0,044643] BTRFS error (device sdb2): open_ctree failed
>>>>>>
>>>>>>
>>>>>>
>>>>>> =C2=B7 sudo mount  /dev/sdb2 /mnt/
>>>>>>> mount: /mnt: no se puede leer el superbloque en /dev/sdb2.
>>>>>>
>>>>>> (cannot read superblock on /dev...)
>>>>>>
>>>>>> =C2=B7 sudo btrfs rescue super-recover /dev/sdb2
>>>>>>> All supers are valid, no need to recover
>>>>>>
>>>>>>
>>>>>> =C2=B7 sudo btrfs check /dev/sdb2
>>>>>>> Opening filesystem to check...
>>>>>>> Checking filesystem on /dev/sdb2
>>>>>>> UUID: ff559c37-bc38-491c-9edc-fa6bb0874942
>>>>>>> [1/7] checking root items
>>>>>>> [2/7] checking extents
>>>>>>> [3/7] checking free space cache
>>>>>>> cache and super generation don't match, space cache will be inval=
idated
>>>>>>> [4/7] checking fs roots
>>>>>>> root 5 inode 431 errors 1040, bad file extent, some csum missing
>>>>>>> root 5 inode 755 errors 1040, bad file extent, some csum missing
>>>>>>> root 5 inode 2379 errors 1040, bad file extent, some csum missing=

>>>>>>> root 5 inode 11721 errors 1040, bad file extent, some csum missin=
g
>>>>>>> root 5 inode 12211 errors 1040, bad file extent, some csum missin=
g
>>>>>>> root 5 inode 15368 errors 1040, bad file extent, some csum missin=
g
>>>>>>> root 5 inode 35329 errors 1040, bad file extent, some csum missin=
g
>>>>>>> root 5 inode 960427 errors 1040, bad file extent, some csum missi=
ng
>>>>>>> root 5 inode 18446744073709551605 errors 2001, no inode item, lin=
k count wrong
>>>>>>>         unresolved ref dir 256 index 0 namelen 12 name $RECYCLE.B=
IN filetype 2 errors 6, no dir index, no inode ref
>>>>>
>>>>> Check is reporting the same problem of the inode.
>>>>>
>>>>> We need to make sure what's going wrong on that leaf, based on the
>>>>> mentioned dump.
>>>>>
>>>>> For the csum missing error and bad file extent, it should be a big =
problem.
>>>>
>>>> s/should/should not/
>>>>
>>>>> if you want to make sure what's going wrong, please provide the
>>>>> following dump:
>>>>>
>>>>> # btrfs ins dump-tree -t 5 /dev/sdb2 | grep -A 7
>>>>>
>>>>> Also feel free the censor the filenames.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>> root 388 inode 1245 errors 1040, bad file extent, some csum missi=
ng
>>>>>>> root 388 inode 1288 errors 1040, bad file extent, some csum missi=
ng
>>>>>>> root 388 inode 1292 errors 1040, bad file extent, some csum missi=
ng
>>>>>>> root 388 inode 1313 errors 1040, bad file extent, some csum missi=
ng
>>>>>>> root 388 inode 11870 errors 1040, bad file extent, some csum miss=
ing
>>>>>>> root 388 inode 68126 errors 1040, bad file extent, some csum miss=
ing
>>>>>>> root 388 inode 88051 errors 1040, bad file extent, some csum miss=
ing
>>>>>>> root 388 inode 88255 errors 1040, bad file extent, some csum miss=
ing
>>>>>>> root 388 inode 88455 errors 1040, bad file extent, some csum miss=
ing
>>>>>>> root 388 inode 88588 errors 1040, bad file extent, some csum miss=
ing
>>>>>>> root 388 inode 88784 errors 1040, bad file extent, some csum miss=
ing
>>>>>>> root 388 inode 88916 errors 1040, bad file extent, some csum miss=
ing
>>>>>>> ERROR: errors found in fs roots
>>>>>>> found 37167415296 bytes used, error(s) found
>>>>>>> total csum bytes: 33793568
>>>>>>> total tree bytes: 1676722176
>>>>>>> total fs tree bytes: 1540243456
>>>>>>> total extent tree bytes: 81510400
>>>>>>> btree space waste bytes: 306327457
>>>>>>> file data blocks allocated: 42200928256
>>>>>>>  referenced 52868354048
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> Regards,
>>>>>> Jos=C3=A9 Luis.
>>>>>>
>>>>>
>>>>
>>


--LJxPVva8FIddgCtHnTAtIjCZxQLVRvABC--

--ZGih63Cb5uBeTVzSQqK5X27B2Bg5jtaQV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2mZ7MACgkQwj2R86El
/qhDWwgApDf2sivdLNWW1KisOyzl1SeQWN2rE7J323ry9n+jNfDoBLaLKGbXmmuL
b7obfEo/fc8UxoG9GTH4bhRcR28b2eXVnLxrlzMRwC5ymsqHKRJZoL2G3xdjqcCr
AEPywQuDZXtPh1VEbMtx/6+Zzgf7E1+tiGt9WFeFZSXjFdvoiceP5ge5wa/rv3hG
QzXxz2pCJeIQBKQWHcakxLYlDu16x5KyanSK0H1AuqEdAq+yP1IbmEuZggMIAoqs
TA1i7wwZNzGQi8W/SbTQW7YqaSE0+yfgwo7fwiYHGzBgyZ/RHYBKmUm5yzr+bQa4
VuoGO9KezQ+WSBaoafLmDQP521CR1w==
=le6T
-----END PGP SIGNATURE-----

--ZGih63Cb5uBeTVzSQqK5X27B2Bg5jtaQV--
