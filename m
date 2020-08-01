Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8672354A1
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Aug 2020 01:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgHAXa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Aug 2020 19:30:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:34303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHAXa1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Aug 2020 19:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596324622;
        bh=/4byIqm/NCLCvGOEnpKvp7UzmhxAhaoaQZGfrlzDahA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cHY4wpe3jyg+gWWQsGWVT79AsTGVBBQnWnohEwXk62DW+lv8wKVcOnvakzmZx8dyc
         ZRySSb5Dan65rkiOsclIjLglA5OQbmlmjTPO7ey4jEQh7eE6UiqzZUrkcQtm0Ijmbb
         50L8zzJlZ+puQRepwrwUGISpg0I4Xvg0ngpHnSaY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOREi-1kPZS731tW-00PwaP; Sun, 02
 Aug 2020 01:30:22 +0200
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     Justin Brown <Justin.Brown@fandingo.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKZK7uwRs_tf6htRtJvw3kNhyNPMJ-juA6_WSJo+PbQA7f40Cg@mail.gmail.com>
 <8e17a4d1-6555-15ba-808c-dd867d7ecbcb@gmx.com>
 <4f21b4c4-430e-59eb-068c-231cf3bc492d@gmx.com>
 <CAKZK7uzmg19NDjGPPAxXKu7LJ-7ZdHu2cad22csj_chr2qxMJg@mail.gmail.com>
 <2061ec67-a5a4-07c6-fe5e-8464feb272aa@gmx.com>
 <CAKZK7uwFFpxiwA=Ye1VpqvkonAER=T-a2i_h_yGwpkieaeXcjg@mail.gmail.com>
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
Message-ID: <bd921a29-cd4a-62dc-4e14-708e617ec156@gmx.com>
Date:   Sun, 2 Aug 2020 07:30:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKZK7uwFFpxiwA=Ye1VpqvkonAER=T-a2i_h_yGwpkieaeXcjg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="P9CD8ZJMm42oSCkCb9bnkjkNYDS9wTi6k"
X-Provags-ID: V03:K1:/+sSWja+JVzTrAL/LOzjkHOeRCMRNQwYEv3nHQ09FiNdmkl/8Tu
 dxNwWYIkv6s9VFS7O/ltwdTMJRfA7PyHcrAxKynU571O+ZFO19t5PnkgyEi2G7a2lEUknJ/
 9MRtl/IG/5pSvbqaIcILGEvmRGcExK5Aq8wcbk5hRClWiy19waU0uxOwTRQD9S4GmcW9luw
 mK1IByQbPoGomYY2hySLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i1PS2+lB3F0=:1GJ3v7Z/W/LTyrbyDwbdhH
 ZGxdsuyND2bGQlrN8UvtgGcHfkuRXdpVwX8FptC9CoBqkDSyQ9eBTHHn79/LXA8GFhhT1Wy1s
 ZzYsU87zz4fbEwPK6X3rnx30S2MCVIHE71SZXd2SQsO7FKl1dBYmzJ88MS2gxE7zLQTBnxXlQ
 APKXSrwi5qxumKzTkqu3HhyAkeDeZIxbjxsbZprlAFDMTqiS/KBZPmtYf55F42LyroIBFHu+P
 RSXgNocxIG613c9UKbgeR+Nwi5BbFRWrIFMrxQhroEo4nmC34snzBY/FcTID+4X9yQF7yARsa
 DWIvt2/BtaDGqMQOjbgHqtg+tdo6ntXCLDrLw/PfO6f9DZOzisOqWtHg8Ai6GLYfDXBAonWyZ
 toXvYToPQVSzacU9LpyAwJnxnu9m1IuhLNKxgQQRdhwYE1aMMnSesxPwxHchAItE2ic/uZ5Gt
 gc8wPWbCeJ8ILgtRLOfAr4jsp5bUzX0GydL6MupD7tzHznqjsMyqBqNTaYet954gv4bsunZTc
 54tugcGu3HPiEtYPcb4dsZyO7bzo5Hh4SyolEXFeJzL1VuiprpeRZk8qLwYKny1r5DEsvUQFn
 U/sytyUCFP9nctP4uRvzoUJbw3HYlsSDSEDHNCYt5npQmCvLgNRNM5qz9T1VI9CoJjH4gUd/N
 4W+OEzM0FjKpfVUG7UmMUJiEf54K9veTM1P1/UBV5lSr/YZi520pWr9CsA/5QNjrpqHOzlVyC
 XfBXggOXv0MWR4FSgilsni0xh73I1vKSrg28oYHBWhP+Y5y8XlqHe0ilYjiG/R1aL9Go4ZTQU
 Me/bO82WykGq9rG9kNPg7dhnEA9HSC3BgYXSEdt1y221Mx2LI+U8HQVJ7LY2K47kvZOEYKMe9
 2NXPQZtmvicfCynwWiDFPOrRGg27YfDVJqtUJ5MCR3GO5wzVkC2mFtGqDyIxGOHHBOajH3hEq
 5UWP0iqGKwkyHNHwwnyc9Fhm7mqQ0GEH15Jwv6Ko4mg4i0/YBpQs/FRQcDJWHK0s46MJHavE0
 3nrxKm4jBNSL0QJ2n3DgVg4VWsOOrrQ37foSIAUAdR1Kwgw7KXSblO9EpeHpKYxqxUnSIwta1
 h11E57yLZfMagxQC3BbcI3DD81W1LKW3zLDxzsrlt8RUBuvADvEooBOf1IaFrjK8VQxPehEkL
 ayYikOlJto3lOjGAlaQCX6nNsoOD4I1t14GHepUtXAwB2DHN7EDdVPd3+eZ6el3E1C7cGuYG8
 HZjze9kO6yTV9RnmF26qq9d8Z1n18e2IBDpM5tg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P9CD8ZJMm42oSCkCb9bnkjkNYDS9wTi6k
Content-Type: multipart/mixed; boundary="sczil6KJslGoW9yow4YTJdl2zbXSF7Zrt"

--sczil6KJslGoW9yow4YTJdl2zbXSF7Zrt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/1 =E4=B8=8B=E5=8D=887:56, Justin Brown wrote:
> Hi Qu,
>=20
> Thanks for your continued help.
>=20
> dump-super:
>=20
> for i in a b d e f g; do x=3D$(sudo btrfs ins dump-super /dev/sd${i}1 |=

> grep dev_item.uuid | cut -f 3); echo "/dev/sd${i}1 $x"; done
> /dev/sda1 cc3f9a00-bd69-4ceb-b6e5-4fb874be2aaf
> /dev/sdb1 27e1cf24-9349-4f72-a23b-86668b2a9e78
> /dev/sdd1 601d409e-8ffd-489c-91af-daf3e0cc9bd2
> /dev/sde1 2908ebfb-e6b5-4991-b25d-32d1487ff6a4
> /dev/sdf1 cb05aae6-6c03-49d3-b46d-bf51a0eb8cd0

They match with the device size. So no chunk item beyond device boundary.=


>=20
> btrfs check:
>=20
> sudo btrfs check /dev/sda1
> Opening filesystem to check...
> Checking filesystem on /dev/sda1
> UUID: 51eef0c7-2977-4037-b271-3270ea22c7d9
> [1/7] checking root items
> [2/7] checking extents
=2E..
> failed to load free space cache for block group 92568662507520
> failed to load free space cache for block group 92574031216640
> ...
> failed to load free space cache for block group 97722656817152
> failed to load free space cache for block group 97728025526272

This is interesting. Maybe that's related to the problem?

> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)

Great that all metadata are fine.

> found 5148381876224 bytes used, no error found
> total csum bytes: 4998903140
> total tree bytes: 5301813248
> total fs tree bytes: 96894976
> total extent tree bytes: 41910272
> btree space waste bytes: 135561977
> file data blocks allocated: 8972043898880
> referenced 5113155596288
>=20
> The alignment issue would be confined to performance, correct?

Yep, only related to performance and some noisy warning for newer kernel.=

Not a big problem yet.

Since btrfs-check reports no obvious problem but free space cache
problems, maybe btrfs repair --clear-space-cache v1 is worthy trying.

BTW, since current kernel and btrfs-progs doesn't do restrict chunk
check against device boundary, I'll add such checks to both kernel and
progs soon.

In the mean time, I also see the following dmesg showing that kernel
failed to detect one device:

  Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS warning (device
  sde1): devid 1 uuid cb05aae6-6c03-49d3-b46d-bf51a0eb8cd0 is missing

Can you reproduce that problem? And if so, maybe try "btrfs device scan"
and then mount again?

Thanks,
Qu

>=20
> Thanks,
> Justin
>=20
> /dev/sdg1 1b938c84-eafd-4396-b06c-8a5bf1339840On Sat, Aug 1, 2020 at
> 4:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2020/8/1 =E4=B8=8B=E5=8D=884:30, Justin Brown wrote:
>>> Hi Qu,
>>>
>>> Thanks for the help.
>>>
>>> Here's is the lsblk -b:
>>>
>>> NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
>>> sda 8:0 0 2000398934016 0 disk
>>> =E2=94=94=E2=94=80sda1 8:1 0 2000397868544 0 part
>>> sdb 8:16 0 8001563222016 0 disk
>>> =E2=94=94=E2=94=80sdb1 8:17 0 8001562156544 0 part
>>> sdc 8:32 0 120034123776 0 disk
>>> =E2=94=9C=E2=94=80sdc1 8:33 0 1048576 0 part
>>> =E2=94=9C=E2=94=80sdc2 8:34 0 524288000 0 part /boot
>>> =E2=94=94=E2=94=80sdc3 8:35 0 119507255296 0 part /home
>>> sdd 8:48 0 8001563222016 0 disk
>>> =E2=94=94=E2=94=80sdd1 8:49 0 8001562156544 0 part
>>> sde 8:64 0 2000398934016 0 disk
>>> =E2=94=94=E2=94=80sde1 8:65 0 2000397868544 0 part
>>> sdf 8:80 0 2000398934016 0 disk
>>> =E2=94=94=E2=94=80sdf1 8:81 0 2000397868544 0 part /var/media
>>> sdg 8:96 1 2000398934016 0 disk
>>> =E2=94=94=E2=94=80sdg1 8:97 1 2000397868544 0 part
>>>
>>> The `btrfs ins...` output is quite long. I've attached it as a txt an=
d
>>> also uploaded it at
>>> https://gist.github.com/fandingo/aa345d6c6fa97162f810e86c9ab20d6a
>>
>>
>> Thanks, this already shows some device size difference.
>>
>> But all of them are in fact just a little smaller than device size, th=
us
>> it should be fine.
>>
>> Another problem I found is, it looks like either size or start of some=

>> partitions are not aligned to 4K.
>>
>> It may be a problem for 4K aligned hard disks, so it may worthy some
>> concern after solving the btrfs problem.
>>
>> Would you please also provide some extra dump?
>> - btrfs check /dev/sda1
>>   It should detect any problems I missed
>>
>> - btrfs ins dump-super <device> | grep dev_item.uuid
>>   It's a little hard to find which device owns to which device id.
>>   So we need this dump of each btrfs device to make sure.
>>
>> Thanks,
>> Qu
>>
>>
>>>
>>> Thanks,
>>> Justin
>>>
>>> On Sat, Aug 1, 2020 at 2:02 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2020/8/1 =E4=B8=8B=E5=8D=882:58, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2020/8/1 =E4=B8=8B=E5=8D=882:51, Justin Brown wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I've run into a strange problem that I haven't seen before, and I =
need
>>>>>> some help. I started getting generic "input/output" errors on a co=
uple
>>>>>> of files, and when I looked deeper, the kernel logs are full of
>>>>>> messages like:
>>>>>>
>>>>>>     sd 5:0:0:0: [sdf] tag#29 access beyond end of device
>>>>>
>>>>> We had a new fix for trim. But according to your kernel message, it=

>>>>> doesn't look like the case.
>>>>>
>>>>> (No obvious tag showing it's trim/discard)
>>>>>
>>>>>>
>>>>>> I've never seen anything like this before with any FS, so I figure=
d it
>>>>>> was worth asking before I consider running the standard btrfs tool=
s.
>>>>>> (I briefly started a scrub, but it was going crazy with uncorrecta=
ble
>>>>>> errors, so I cancelled it.)
>>>>>>
>>>>>> Here's my system info:
>>>>>>
>>>>>> Fedora 32, kernel 5.7.7-200.fc32.x86_64
>>>>>> btrfs-progs v5.7
>>>>>>
>>>>>> /etc/fstab entry:
>>>>>> LABEL=3Dmedia /var/media btrfs subvol=3Dmedia,discard 0 2
>>>>>>
>>>>>> btrfs fi show /var/media/
>>>>>> Label: 'media' uuid: 51eef0c7-2977-4037-b271-3270ea22c7d9
>>>>>> Total devices 6 FS bytes used 4.68TiB
>>>>>> devid 1 size 1.82TiB used 963.00GiB path /dev/sdf1
>>>>>> devid 2 size 1.82TiB used 962.00GiB path /dev/sde1
>>>>>> devid 4 size 1.82TiB used 963.00GiB path /dev/sdg1
>>>>>> devid 6 size 1.82TiB used 962.03GiB path /dev/sda1
>>>>>> devid 7 size 7.28TiB used 967.03GiB path /dev/sdb1
>>>>>> devid 8 size 7.28TiB used 967.03GiB path /dev/sdd1
>>>>>>
>>>>>> btrfs fi df /var/media/
>>>>>> Data, RAID5: total=3D4.69TiB, used=3D4.68TiB
>>>>>> System, RAID1C3: total=3D32.00MiB, used=3D304.00KiB
>>>>>> Metadata, RAID1C3: total=3D6.00GiB, used=3D4.94GiB
>>>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>>>>
>>>>>> I can only mount -o degraded now. Here are the logs when mounting:=

>>>>>>
>>>>>> Aug 01 01:15:26 spaceman.fandingo.org sudo[275572]: justin : TTY=3D=
pts/0
>>>>>> ; PWD=3D/home/justin ; USER=3Droot ; COMMAND=3D/usr/bin/mount -t b=
trfs -o
>>>>>> degraded /dev/sda1 /var/media/
>>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#30
>>>>>> access beyond end of device
>>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: blk_update_request: =
I/O
>>>>>> error, dev sdf, sector 2176 op 0x0:(READ) flags 0x0 phys_seg 1 pri=
o
>>>>>> class 0
>>>>>
>>>>> OK, it's read, not DISCARD, thus a completely different problem.
>>>>>
>>>>>
>>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: Buffer I/O error on =
dev
>>>>>> sdf1, logical block 16, async page read
>>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
>>>>>> sde1): allowing degraded mounts
>>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
>>>>>> sde1): disk space caching is enabled
>>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
>>>>>> sde1): devid 1 uuid cb05aae6-6c03-49d3-b46d-bf51a0eb8cd0 is missin=
g
>>>>>> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
>>>>>> sde1): bdev /dev/sdf1 errs: wr 4458026, rd 14571, flush 0, corrupt=
 0,
>>>>>> gen 0
>>>>>>
>>>>>> It seems like only relatively recently written files are encounter=
ing
>>>>>> I/O errors. If I `cat` one of the problematic files when the FS is=

>>>>>> mounted normally, I see a ton of this:
>>>>>>
>>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#26
>>>>>> access beyond end of device
>>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#27
>>>>>> access beyond end of device
>>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#28
>>>>>> access beyond end of device
>>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#29
>>>>>> access beyond end of device
>>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#30
>>>>>> access beyond end of device
>>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#0
>>>>>> access beyond end of device
>>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#1
>>>>>> access beyond end of device
>>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#13
>>>>>> access beyond end of device
>>>>>> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] ta=
g#2
>>>>>> access beyond end of device
>>>>>>
>>>>>> Now that I'm remounted in -o degraded, I'm getting more comprehens=
ible
>>>>>> warnings, but it still results in I/O read failures:
>>>>>>
>>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
>>>>>> sde1): csum failed root 2820 ino 747435 off 99942400 csum 0x8941f9=
98
>>>>>> expected csum 0xbe3f80a4 mirror 2
>>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
>>>>>> sde1): csum failed root 2820 ino 747435 off 99946496 csum 0x8941f9=
98
>>>>>> expected csum 0x9c36a6b4 mirror 2
>>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
>>>>>> sde1): csum failed root 2820 ino 747435 off 99950592 csum 0x8941f9=
98
>>>>>> expected csum 0x44d30ca2 mirror 2
>>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
>>>>>> sde1): csum failed root 2820 ino 747435 off 99958784 csum 0x8941f9=
98
>>>>>> expected csum 0xc0f08acc mirror 2
>>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
>>>>>> sde1): csum failed root 2820 ino 747435 off 99954688 csum 0x8941f9=
98
>>>>>> expected csum 0xcb11db59 mirror 2
>>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
>>>>>> sde1): csum failed root 2820 ino 747435 off 99962880 csum 0x8941f9=
98
>>>>>> expected csum 0x8a4ee0aa mirror 2
>>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
>>>>>> sde1): csum failed root 2820 ino 747435 off 99971072 csum 0x8941f9=
98
>>>>>> expected csum 0xdfb79e85 mirror 2
>>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
>>>>>> sde1): csum failed root 2820 ino 747435 off 99966976 csum 0x8941f9=
98
>>>>>> expected csum 0xc14921a0 mirror 2
>>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
>>>>>> sde1): csum failed root 2820 ino 747435 off 99975168 csum 0x8941f9=
98
>>>>>> expected csum 0xf2fe8774 mirror 2
>>>>>> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (devic=
e
>>>>>> sde1): csum failed root 2820 ino 747435 off 99979264 csum 0x8941f9=
98
>>>>>> expected csum 0xae1cafd6 mirror 2
>>>>>>
>>>>>> Why trying to research this problem, I came across a Github issue
>>>>>> https://github.com/kdave/btrfs-progs/issues/282 and a patch from Q=
u
>>>>>> from yesterday ([PATCH] btrfs: trim: fix underflow in trim length =
to
>>>>>> prevent access beyond device boundary). I do use the discard mount=

>>>>>> option, and I have a weekly fstrim.timer enabled. I did replace 2x=
2TB
>>>>>> drives with the 2x8TB drives about 1 month ago, which involved a
>>>>>> conversion to -d raid5 -m raid1c3, which I suppose could hit the s=
ame
>>>>>> code paths that resize2fs would?
>>>>>
>>>>> The problem doesn't look like a trim one, but more likely some devi=
ce
>>>>> boundary bug.
>>>>>
>>>>> Would you please provide the following info?
>>>>> - btrfs ins dump-tree -t chunk /dev/sde1
>>>>>   This contains the device info and chunk tree dump. Doesn't contai=
n
>>>>>   any confidential info.
>>>>>   We can use this info to determine if there is some chunk really b=
eyond
>>>>>   device boundary.
>>>>>   I guess some chunks are already beyond device boundary by somehow=
=2E
>>>>
>>>> And `lsblk -b` output.
>>>>
>>>> It may be possible that device size in btrfs doesn't match with the =
real
>>>> device...
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> Any advice on how to proceed would be greatly appreciated.
>>>>>>
>>>>>> Thanks,
>>>>>> Justin
>>>>>>
>>>>>
>>>>
>>


--sczil6KJslGoW9yow4YTJdl2zbXSF7Zrt--

--P9CD8ZJMm42oSCkCb9bnkjkNYDS9wTi6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8l+woACgkQwj2R86El
/qivAwf/T00bAapj+IqJp8X1XTuTWYnIqGzWMtM63X8c4xRiqIb3XSBV7N3jwfCP
VkkxKc/TZ6PI7lk/fb+wJcx+9Qvs6ek627Cy9e17lt/ok27ZdVrdJVDGqdqz4gH5
AsrbM76sW95jPBC3rpezT7imoTOdVUs0MyrKpXyofYmOaz3e2ACn2z2LQ1640CTf
cqrJiW0Om5/zC73E6QU4pfd8zQVlO86Hj9PYfFG8ZauiBGZex0htEm4lW8zdMyng
jCW4ykFheR/fXwjuW4VeVqdDnls5N63uR9HIKkSGuLfHNIvQVIIgJN0i8sDa6tCT
zf5ENS7yY6lkXTsrNXy7lKOQKW/G5Q==
=Zari
-----END PGP SIGNATURE-----

--P9CD8ZJMm42oSCkCb9bnkjkNYDS9wTi6k--
