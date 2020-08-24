Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ED924F3F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHXI0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 04:26:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:56309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgHXI0e (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 04:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598257587;
        bh=z7wZeWNbdiFNBBsMPmx/9uL83mQmb3ejJkM0k0swfvM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EMynEkf3ySdjig04t6Qi11JxpURXy7NoVi4aZlS9uTIWwwjDzdUNP32AidYskG08l
         KZOR+O3fu3j3rz3grPYGlMKC9G1Ufc6BTD3kz2gVRagmkvxlbd3sor3LTF+mWrr9w2
         O14vzzmRUZ5rDfdFoSHNLcsG525WwRuxav3mmNtc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpUZ4-1kzu1N1hs4-00pvSD; Mon, 24
 Aug 2020 10:26:27 +0200
Subject: Re: Fwd: Read time tree block corruption detected
To:     Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <155abe60-8970-c345-5f28-b4c2713d0c1e@gmx.com>
 <CAJheHN0EOPu9CuTT2hg=5HZskaC-yB2V5LSwNkrhP4XYYyv5+A@mail.gmail.com>
 <63677627-ca0a-663e-5443-9bd1b12ff5a9@gmx.com>
 <CAJheHN2mQX7VZxMZo+-GBhxeOWFu1tYAUfJ9Ut7hokMh-+ua-Q@mail.gmail.com>
 <5a9a2592-063a-5dfc-c157-47771d8bfb2b@gmx.com>
 <CAJheHN2-PbGC8S3f74CAFipsjxwXgip5N0zKG_xs-m8ky=WD2A@mail.gmail.com>
 <CAJheHN3qwDAGY=z14zfO4LBrxNJZZ_rvAMsWLwe-k+4+t3zLog@mail.gmail.com>
 <11fe4ad3-928c-5b6b-4424-26fc05baa28d@gmx.com>
 <CAJheHN2kY7kVyfo+kv0=DymXfnjiacX_a=rg7oXkeNV4x_XvHw@mail.gmail.com>
 <CAJheHN0qqOn2u4Rks6u+Epsr+L+ijs0E=G=AUCV3F-yLvsLasA@mail.gmail.com>
 <98c633bc-658c-d8d9-a2cd-4c9b9e477552@gmx.com>
 <6bc0816e-b58c-1d74-7c0e-e07a38a5a027@gmx.com>
 <CAJheHN25gNo-jgykeQ6=ZQAm1ZHG9+-rWhBp3S-x2c1xi5j-og@mail.gmail.com>
 <4d1bb444-921c-9773-ff68-b6ea074ff35d@gmx.com>
 <CAJheHN1+AQR-irSbaH8f7HGj=rDN4+uUCyqjvtezGewQkQoDpg@mail.gmail.com>
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
Message-ID: <5346c4af-c73e-84b3-ec4f-8f169c0a732a@gmx.com>
Date:   Mon, 24 Aug 2020 16:26:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJheHN1+AQR-irSbaH8f7HGj=rDN4+uUCyqjvtezGewQkQoDpg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5uxK5NBRD27zDwpm3tdgIfGLJQ6xIlHlo"
X-Provags-ID: V03:K1:GjP+N61SIsso4enKis1euCYPVmGGQeBti6QWwxzgeRmFUyplT9s
 mEAhtgAHvas9mE0jIZWw9zW6THdy/1Bd+OPcuVA4LItOQqePCxAeqlAh8UOK0/Mgwu7zivP
 7+e8jCn9uGhTMUSYolyqVSne5lqki/7UcxLm0+sNOoNVbB4VvNGI9aD53/LQNwMV5nAN4bq
 5eJkLKzJ69rMWczPYqQpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kwSXCuGsCj8=:suP9Z5Y7Bkj62BXPWj9sbc
 JDDz22EWxkFCRsCYEncI6r4lltZTgfdQo+Yk+EpP7i4NN4a0xE3SzmMvihZGp48XykHsNBEUJ
 VmUFU3ysY7CY4Vhowzr2miPkyqVrBrm+bbHDfzvaQ++3m2IFdkUFzTfAbsNG++ag29o/Q7UA8
 wg/1vJaHvmqKwQFLnhRCZnLCZZZwIByXf8cACJxp5jKGCf8xMOVfoYg7c21OEWAQy3GCTTPJY
 hT4pdLwY6n/VsWNrZj2VClBiQlofJJB85BM3COCg+BYwNOqJb09pyTuoHL+xCMZEFQqZOZQWd
 ZSJk52U4HmLOkuDIpYVhgHcseZAGqW8U+Ad1Mq3YrJPEayEx5dNEfX6egyClu9B16FQZxO7xu
 CyU7UeDdZLSMQf81yK5DjKGyV+dLfKrO1RLejxRhiNj4tdLpYKLaS8MoN3LipXVL6sKAyHvLZ
 VYjS2gm6Qd1MFh0ZfTy4p7EJHfImMDBcJtxx/z+T921OxKqisJ++81atyJXp4z+uZdoKNYcFq
 nq7w5H9sbNmLqdiH028nDBkHX1OGr2Z/EbMjg3o1QUx5lfVyco9WGNDvTpzqSaGJjOD/1scYM
 SfnIgWtoaTHV8r8i5lipFiqDUMMeTUHajkCxKUOymjeAzm+8dcHmZTKJ6+Idze5RlP+fDHgli
 4fhzjbtLBXZGzYAk5H6M9gGd55RXuWQDx/aEphSt0mSqQZ2kNpR5H2DUNJLalVm7d6zbEltt1
 pJEWeXiMmT7upEVJSZVqedwQutIYKM0VaS9r9B6wZdAlNzq7k6RjuuL/cqCGUr3kv+KW7oH/z
 xEGviIuwSp00/JwC624bM1Vb2YCKqGzOgsfBpKT84sSasMQfndX5qvt4ec0TeW+0thtAn7J/m
 54vdsCkMxcvJbXQKZe9pZSp1pMDw36DsmyazV/8w4DgX8SmfuN88wFZisrK1CECnwWt+6u4v3
 sVgfzyE7Q0/yFFGrsmP3sdywCNyaUN8ZP4E0ZPZw19BAw0cOnvjyqpF8UuIIjNudaL474X5ax
 xBPYwg3RnQHqDKI4ZSBfB7SSrlxfHKeEgQN+N0k9+4Jpx54v7twGA+Bf++t9MgAxssHHzbzD1
 DKLnd1CU3URR2t0iDfBMtrWhLC6adOecTNIrJuRgQ9U6DInVOM2OL0Hlo8E9E3XkRMYwzSsDx
 hES15XSHh6wCkKvTV4sdlQkrx6jB3vrELrX7nQI5a9IlUAMRs9StZ4/mgjv6qQWKLZFPgXD5e
 wxSmzWqdjevo0HoxhCAW0etq+YxY0WtjN5yDLQw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5uxK5NBRD27zDwpm3tdgIfGLJQ6xIlHlo
Content-Type: multipart/mixed; boundary="4fToKNieaKszbknw8tf38vD6KJMFaCvj2"

--4fToKNieaKszbknw8tf38vD6KJMFaCvj2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/24 =E4=B8=8A=E5=8D=8810:47, Tyler Richmond wrote:
> Qu,
>=20
> Finally finished another repair and captured the output.
>=20
> https://pastebin.com/ffcbwvd8
>=20
> Does that show you what you need? Or should I still do one in lowmem mo=
de?

Lowmem mode (no need for --repair) is recommended since original mode
doesn't detect the inode generation problem.

And it's already btrfs-progs v5.7 right?

THanks,
Qu
>=20
> Thanks for your help!
>=20
> On Sun, Aug 23, 2020 at 12:28 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>
>>
>>
>> On 2020/8/23 =E4=B8=8A=E5=8D=8810:49, Tyler Richmond wrote:
>>> Well, I can guarantee that I didn't create this fs before 2015 (just
>>> checked the order confirmation from when I bought the server), but I
>>> may have just used whatever was in the Ubuntu package manager at the
>>> time. So maybe I don't have a v0 ref?
>>
>> Then btrfs-image shouldn't report that.
>>
>> There is an item smaller than any valid btrfs item, normally it means
>> it's a v0 ref.
>> If not, then it could be a bigger problem.
>>
>> Could you please provide the full btrfs-check output?
>> Also, if possible result from "btrfs check --mode=3Dlowmem" would also=
 help.
>>
>> Also, if you really go "--repair", then the full output would also be
>> needed to determine what's going wrong.
>> There is a report about "btrfs check --repair" didn't repair the inode=

>> generation, if that's the case we must have a bug then.
>>
>> Thanks,
>> Qu
>>>
>>> On Sat, Aug 22, 2020 at 10:31 PM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>>>>
>>>>
>>>>
>>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:51, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:15, Tyler Richmond wrote:
>>>>>> Is my best bet just to downgrade the kernel and then try to delete=
 the
>>>>>> broken files? Or should I rebuild from scratch? Just don't know
>>>>>> whether it's worth the time to try and figure this out or if the
>>>>>> problems stem from the FS being too old and it's beyond trying to
>>>>>> repair.
>>>>>
>>>>> All invalid inode generations, should be able to be repaired by lat=
est
>>>>> btrfs-check.
>>>>>
>>>>> If not, please provide the btrfs-image dump for us to determine wha=
t's
>>>>> going wrong.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>>
>>>>>> On Tue, Aug 18, 2020 at 8:18 AM Tyler Richmond <t.d.richmond@gmail=
=2Ecom> wrote:
>>>>>>>
>>>>>>> I didn't check dmesg during the btrfs check, but that was the onl=
y
>>>>>>> output during the rm -f before it was forced readonly. I just che=
cked
>>>>>>> dmesg for inode generation values, and there are a lot of them.
>>>>>>>
>>>>>>> https://pastebin.com/stZdN0ta
>>>>>>> The dmesg output had 990 lines containing inode generation.
>>>>>>>
>>>>>>> However, these were at least later. I tried to do a btrfs balance=

>>>>>>> -mconvert raid1 and it failed with an I/O error. That is probably=
 what
>>>>>>> generated these specific errors, but maybe they were also happeni=
ng
>>>>>>> during the btrfs repair.
>>>>>>>
>>>>>>> The FS is ~45TB, but the btrfs-image -c9 failed anway with:
>>>>>>> ERROR: either extent tree is corrupted or deprecated extent ref f=
ormat
>>>>>>> ERROR: create failed: -5
>>>>
>>>> Oh, forgot this part.
>>>>
>>>> This means you have v0 ref?!
>>>>
>>>> Then the fs is too old, no progs/kernel support after all.
>>>>
>>>> In that case, please rollback to the last working kernel and copy yo=
ur data.
>>>>
>>>> In fact, that v0 ref should only be in the code base for several wee=
ks
>>>> before 2010, thus it's really too old.
>>>>
>>>> The good news is, with tree-checker, we should never experience such=

>>>> too-old-to-be-usable problem (at least I hope so)
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>>>
>>>>>>>
>>>>>>> On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2020/8/18 =E4=B8=8A=E5=8D=8811:35, Tyler Richmond wrote:
>>>>>>>>> Qu,
>>>>>>>>>
>>>>>>>>> Sorry to resurrect this thread, but I just ran into something t=
hat I
>>>>>>>>> can't really just ignore. I've found a folder that is full of f=
iles
>>>>>>>>> which I guess have been broken somehow. I found a backup and re=
stored
>>>>>>>>> them, but I want to delete this folder of broken files. But whe=
never I
>>>>>>>>> try, the fs is forced into readonly mode again. I just finished=
 another
>>>>>>>>> btrfs check --repair but it didn't fix the problem.
>>>>>>>>>
>>>>>>>>> https://pastebin.com/eTV3s3fr
>>>>>>>>
>>>>>>>> Is that the full output?
>>>>>>>>
>>>>>>>> No inode generation bugs?
>>>>>>>>>
>>>>>>>>>  I'm already on btrfs-progs v5.7. Any new suggestions?
>>>>>>>>
>>>>>>>> Strange.
>>>>>>>>
>>>>>>>> The detection and repair should have been merged into v5.5.
>>>>>>>>
>>>>>>>> If your fs is small enough, would you please provide the "btrfs-=
image
>>>>>>>> -c9" dump?
>>>>>>>>
>>>>>>>> It would contain the filenames and directories names, but doesn'=
t
>>>>>>>> contain file contents.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond <t.d.richmond@gma=
il.com
>>>>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
>>>>>>>>>
>>>>>>>>>     5.6.1 also failed the same way. Here's the usage output. Th=
is is the
>>>>>>>>>     part where you see I've been using RAID5 haha
>>>>>>>>>
>>>>>>>>>     WARNING: RAID56 detected, not implemented
>>>>>>>>>     Overall:
>>>>>>>>>         Device size:                  60.03TiB
>>>>>>>>>         Device allocated:             98.06GiB
>>>>>>>>>         Device unallocated:           59.93TiB
>>>>>>>>>         Device missing:                  0.00B
>>>>>>>>>         Used:                         92.56GiB
>>>>>>>>>         Free (estimated):                0.00B      (min: 8.00E=
iB)
>>>>>>>>>         Data ratio:                       0.00
>>>>>>>>>         Metadata ratio:                   2.00
>>>>>>>>>         Global reserve:              512.00MiB      (used: 0.00=
B)
>>>>>>>>>         Multiple profiles:                  no
>>>>>>>>>
>>>>>>>>>     Data,RAID5: Size:40.35TiB, Used:40.12TiB (99.42%)
>>>>>>>>>        /dev/sdh        8.07TiB
>>>>>>>>>        /dev/sdf        8.07TiB
>>>>>>>>>        /dev/sdg        8.07TiB
>>>>>>>>>        /dev/sdd        8.07TiB
>>>>>>>>>        /dev/sdc        8.07TiB
>>>>>>>>>        /dev/sde        8.07TiB
>>>>>>>>>
>>>>>>>>>     Metadata,RAID1: Size:49.00GiB, Used:46.28GiB (94.44%)
>>>>>>>>>        /dev/sdh       34.00GiB
>>>>>>>>>        /dev/sdf       32.00GiB
>>>>>>>>>        /dev/sdg       32.00GiB
>>>>>>>>>
>>>>>>>>>     System,RAID1: Size:32.00MiB, Used:2.20MiB (6.87%)
>>>>>>>>>        /dev/sdf       32.00MiB
>>>>>>>>>        /dev/sdg       32.00MiB
>>>>>>>>>
>>>>>>>>>     Unallocated:
>>>>>>>>>        /dev/sdh        2.81TiB
>>>>>>>>>        /dev/sdf        2.81TiB
>>>>>>>>>        /dev/sdg        2.81TiB
>>>>>>>>>        /dev/sdd        1.03TiB
>>>>>>>>>        /dev/sdc        1.03TiB
>>>>>>>>>        /dev/sde        1.03TiB
>>>>>>>>>
>>>>>>>>>     On Fri, May 8, 2020 at 1:47 AM Qu Wenruo <quwenruo.btrfs@gm=
x.com
>>>>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>     >
>>>>>>>>>     >
>>>>>>>>>     >
>>>>>>>>>     > On 2020/5/8 =E4=B8=8B=E5=8D=881:12, Tyler Richmond wrote:=

>>>>>>>>>     > > If this is saying there's no extra space for metadata, =
is that why
>>>>>>>>>     > > adding more files often makes the system hang for 30-90=
s? Is there
>>>>>>>>>     > > anything I should do about that?
>>>>>>>>>     >
>>>>>>>>>     > I'm not sure about the hang though.
>>>>>>>>>     >
>>>>>>>>>     > It would be nice to give more info to diagnosis.
>>>>>>>>>     > The output of 'btrfs fi usage' is useful for space usage =
problem.
>>>>>>>>>     >
>>>>>>>>>     > But the common idea is, to keep at 1~2 Gi unallocated (no=
t avaiable
>>>>>>>>>     > space in vanilla df command) space for btrfs.
>>>>>>>>>     >
>>>>>>>>>     > Thanks,
>>>>>>>>>     > Qu
>>>>>>>>>     >
>>>>>>>>>     > >
>>>>>>>>>     > > Thank you so much for all of your help. I love how flex=
ible BTRFS is
>>>>>>>>>     > > but when things go wrong it's very hard for me to troub=
leshoot.
>>>>>>>>>     > >
>>>>>>>>>     > > On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenruo.btrf=
s@gmx.com
>>>>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>     > >>
>>>>>>>>>     > >>
>>>>>>>>>     > >>
>>>>>>>>>     > >> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmond wr=
ote:
>>>>>>>>>     > >>> Something went wrong:
>>>>>>>>>     > >>>
>>>>>>>>>     > >>> Reinitialize checksum tree
>>>>>>>>>     > >>> Unable to find block group for 0
>>>>>>>>>     > >>> Unable to find block group for 0
>>>>>>>>>     > >>> Unable to find block group for 0
>>>>>>>>>     > >>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value=
 1
>>>>>>>>>     > >>> btrfs(+0x6dd94)[0x55a933af7d94]
>>>>>>>>>     > >>> btrfs(+0x71b94)[0x55a933afbb94]
>>>>>>>>>     > >>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
>>>>>>>>>     > >>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
>>>>>>>>>     > >>> btrfs(+0x360b2)[0x55a933ac00b2]
>>>>>>>>>     > >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
>>>>>>>>>     > >>> btrfs(main+0x98)[0x55a933a9fe88]
>>>>>>>>>     > >>>
>>>>>>>>>     /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7=
f263ed550b3]
>>>>>>>>>     > >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
>>>>>>>>>     > >>> Aborted
>>>>>>>>>     > >>
>>>>>>>>>     > >> This means no space for extra metadata...
>>>>>>>>>     > >>
>>>>>>>>>     > >> Anyway the csum tree problem shouldn't be a big thing,=
 you
>>>>>>>>>     could leave
>>>>>>>>>     > >> it and call it a day.
>>>>>>>>>     > >>
>>>>>>>>>     > >> BTW, as long as btrfs check reports no extra problem f=
or the inode
>>>>>>>>>     > >> generation, it should be pretty safe to use the fs.
>>>>>>>>>     > >>
>>>>>>>>>     > >> Thanks,
>>>>>>>>>     > >> Qu
>>>>>>>>>     > >>>
>>>>>>>>>     > >>> I just noticed I have btrfs-progs 5.6 installed and 5=
=2E6.1 is
>>>>>>>>>     > >>> available. I'll let that try overnight?
>>>>>>>>>     > >>>
>>>>>>>>>     > >>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo
>>>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wr=
ote:
>>>>>>>>>     > >>>>
>>>>>>>>>     > >>>>
>>>>>>>>>     > >>>>
>>>>>>>>>     > >>>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond =
wrote:
>>>>>>>>>     > >>>>> Thank you for helping. The end result of the scan w=
as:
>>>>>>>>>     > >>>>>
>>>>>>>>>     > >>>>>
>>>>>>>>>     > >>>>> [1/7] checking root items
>>>>>>>>>     > >>>>> [2/7] checking extents
>>>>>>>>>     > >>>>> [3/7] checking free space cache
>>>>>>>>>     > >>>>> [4/7] checking fs roots
>>>>>>>>>     > >>>>
>>>>>>>>>     > >>>> Good news is, your fs is still mostly fine.
>>>>>>>>>     > >>>>
>>>>>>>>>     > >>>>> [5/7] checking only csums items (without verifying =
data)
>>>>>>>>>     > >>>>> there are no extents for csum range 0-69632
>>>>>>>>>     > >>>>> csum exists for 0-69632 but there is no extent reco=
rd
>>>>>>>>>     > >>>>> ...
>>>>>>>>>     > >>>>> ...
>>>>>>>>>     > >>>>> there are no extents for csum range 946692096-94682=
7264
>>>>>>>>>     > >>>>> csum exists for 946692096-946827264 but there is no=
 extent
>>>>>>>>>     record
>>>>>>>>>     > >>>>> there are no extents for csum range 946831360-94791=
2704
>>>>>>>>>     > >>>>> csum exists for 946831360-947912704 but there is no=
 extent
>>>>>>>>>     record
>>>>>>>>>     > >>>>> ERROR: errors found in csum tree
>>>>>>>>>     > >>>>
>>>>>>>>>     > >>>> Only extent tree is corrupted.
>>>>>>>>>     > >>>>
>>>>>>>>>     > >>>> Normally btrfs check --init-csum-tree should be able=
 to
>>>>>>>>>     handle it.
>>>>>>>>>     > >>>>
>>>>>>>>>     > >>>> But still, please be sure you're using the latest bt=
rfs-progs
>>>>>>>>>     to fix it.
>>>>>>>>>     > >>>>
>>>>>>>>>     > >>>> Thanks,
>>>>>>>>>     > >>>> Qu
>>>>>>>>>     > >>>>
>>>>>>>>>     > >>>>> [6/7] checking root refs
>>>>>>>>>     > >>>>> [7/7] checking quota groups skipped (not enabled on=
 this FS)
>>>>>>>>>     > >>>>> found 44157956026368 bytes used, error(s) found
>>>>>>>>>     > >>>>> total csum bytes: 42038602716
>>>>>>>>>     > >>>>> total tree bytes: 49688616960
>>>>>>>>>     > >>>>> total fs tree bytes: 1256427520
>>>>>>>>>     > >>>>> total extent tree bytes: 1709105152
>>>>>>>>>     > >>>>> btree space waste bytes: 3172727316
>>>>>>>>>     > >>>>> file data blocks allocated: 261625653436416
>>>>>>>>>     > >>>>>  referenced 47477768499200
>>>>>>>>>     > >>>>>
>>>>>>>>>     > >>>>> What do I need to do to fix all of this?
>>>>>>>>>     > >>>>>
>>>>>>>>>     > >>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo
>>>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wr=
ote:
>>>>>>>>>     > >>>>>>
>>>>>>>>>     > >>>>>>
>>>>>>>>>     > >>>>>>
>>>>>>>>>     > >>>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond=
 wrote:
>>>>>>>>>     > >>>>>>> Well, the repair doesn't look terribly successful=
=2E
>>>>>>>>>     > >>>>>>>
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049=
956061184
>>>>>>>>>     item=3D84
>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>     > >>>>>>>                                             child=
 level=3D4
>>>>>>>>>     > >>>>>>
>>>>>>>>>     > >>>>>> This means there are more problems, not only the h=
ash name
>>>>>>>>>     mismatch.
>>>>>>>>>     > >>>>>>
>>>>>>>>>     > >>>>>> This means the fs is already corrupted, the name h=
ash is
>>>>>>>>>     just one
>>>>>>>>>     > >>>>>> unrelated symptom.
>>>>>>>>>     > >>>>>>
>>>>>>>>>     > >>>>>> The only good news is, btrfs-progs abort the trans=
action,
>>>>>>>>>     thus no
>>>>>>>>>     > >>>>>> further damage to the fs.
>>>>>>>>>     > >>>>>>
>>>>>>>>>     > >>>>>> Please run a plain btrfs-check to show what's the =
problem
>>>>>>>>>     first.
>>>>>>>>>     > >>>>>>
>>>>>>>>>     > >>>>>> Thanks,
>>>>>>>>>     > >>>>>> Qu
>>>>>>>>>     > >>>>>>
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049=
956061184
>>>>>>>>>     item=3D84
>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>     > >>>>>>>                                             child=
 level=3D4
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049=
956061184
>>>>>>>>>     item=3D84
>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>     > >>>>>>>                                             child=
 level=3D4
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049=
956061184
>>>>>>>>>     item=3D84
>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>     > >>>>>>>                                             child=
 level=3D4
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049=
956061184
>>>>>>>>>     item=3D84
>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>     > >>>>>>>                                             child=
 level=3D4
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049=
956061184
>>>>>>>>>     item=3D84
>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>     > >>>>>>>                                             child=
 level=3D4
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049=
956061184
>>>>>>>>>     item=3D84
>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>     > >>>>>>>                                             child=
 level=3D4
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049=
956061184
>>>>>>>>>     item=3D84
>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>     > >>>>>>>                                             child=
 level=3D4
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049=
956061184
>>>>>>>>>     item=3D84
>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>     > >>>>>>>                                             child=
 level=3D4
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049=
956061184
>>>>>>>>>     item=3D84
>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>     > >>>>>>>                                             child=
 level=3D4
>>>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 w=
anted
>>>>>>>>>     6875841 found 6876224
>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D225049=
956061184
>>>>>>>>>     item=3D84
>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>     > >>>>>>>                                             child=
 level=3D4
>>>>>>>>>     > >>>>>>> ERROR: failed to zero log tree: -17
>>>>>>>>>     > >>>>>>> ERROR: attempt to start transaction over already =
running one
>>>>>>>>>     > >>>>>>> WARNING: reserved space leaked, flag=3D0x4 bytes_=
reserved=3D4096
>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066086400 len 409=
6
>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066086400 len 409=
6
>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>>>>>>     225049066086400 len 4096
>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066094592 len 409=
6
>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066094592 len 409=
6
>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>>>>>>     225049066094592 len 4096
>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066102784 len 409=
6
>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066102784 len 409=
6
>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>>>>>>     225049066102784 len 4096
>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066131456 len 409=
6
>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066131456 len 409=
6
>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>>>>>>     225049066131456 len 4096
>>>>>>>>>     > >>>>>>>
>>>>>>>>>     > >>>>>>> What is going on?
>>>>>>>>>     > >>>>>>>
>>>>>>>>>     > >>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond
>>>>>>>>>     <t.d.richmond@gmail.com <mailto:t.d.richmond@gmail.com>> wr=
ote:
>>>>>>>>>     > >>>>>>>>
>>>>>>>>>     > >>>>>>>> Chris, I had used the correct mountpoint in the =
command.
>>>>>>>>>     I just edited
>>>>>>>>>     > >>>>>>>> it in the email to be /mountpoint for consistenc=
y.
>>>>>>>>>     > >>>>>>>>
>>>>>>>>>     > >>>>>>>> Qu, I'll try the repair. Fingers crossed!
>>>>>>>>>     > >>>>>>>>
>>>>>>>>>     > >>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo
>>>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wr=
ote:
>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>     > >>>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richm=
ond wrote:
>>>>>>>>>     > >>>>>>>>>> Hello,
>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>     > >>>>>>>>>> I looked up this error and it basically says a=
sk a
>>>>>>>>>     developer to
>>>>>>>>>     > >>>>>>>>>> determine if it's a false error or not. I just=
 started
>>>>>>>>>     getting some
>>>>>>>>>     > >>>>>>>>>> slow response times, and looked at the dmesg l=
og to
>>>>>>>>>     find a ton of
>>>>>>>>>     > >>>>>>>>>> these errors.
>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>     > >>>>>>>>>> [192088.446299] BTRFS critical (device sdh): c=
orrupt
>>>>>>>>>     leaf: root=3D5
>>>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670=
, invalid inode
>>>>>>>>>     generation:
>>>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>>>     > >>>>>>>>>> [192088.449823] BTRFS error (device sdh):
>>>>>>>>>     block=3D203510940835840 read
>>>>>>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>>>>>>     > >>>>>>>>>> [192088.459238] BTRFS critical (device sdh): c=
orrupt
>>>>>>>>>     leaf: root=3D5
>>>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670=
, invalid inode
>>>>>>>>>     generation:
>>>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>>>     > >>>>>>>>>> [192088.462773] BTRFS error (device sdh):
>>>>>>>>>     block=3D203510940835840 read
>>>>>>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>>>>>>     > >>>>>>>>>> [192088.464711] BTRFS critical (device sdh): c=
orrupt
>>>>>>>>>     leaf: root=3D5
>>>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670=
, invalid inode
>>>>>>>>>     generation:
>>>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>>>     > >>>>>>>>>> [192088.468457] BTRFS error (device sdh):
>>>>>>>>>     block=3D203510940835840 read
>>>>>>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>     > >>>>>>>>>> btrfs device stats, however, doesn't show any =
errors.
>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>     > >>>>>>>>>> Is there anything I should do about this, or s=
hould I
>>>>>>>>>     just continue
>>>>>>>>>     > >>>>>>>>>> using my array as normal?
>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>     > >>>>>>>>> This is caused by older kernel underflow inode =
generation.
>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>     > >>>>>>>>> Latest btrfs-progs can fix it, using btrfs chec=
k --repair.
>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>     > >>>>>>>>> Or you can go safer, by manually locating the i=
node
>>>>>>>>>     using its inode
>>>>>>>>>     > >>>>>>>>> number (1311670), and copy it to some new locat=
ion using
>>>>>>>>>     previous
>>>>>>>>>     > >>>>>>>>> working kernel, then delete the old file, copy =
the new
>>>>>>>>>     one back to fix it.
>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>     > >>>>>>>>> Thanks,
>>>>>>>>>     > >>>>>>>>> Qu
>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>     > >>>>>>>>>> Thank you!
>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>     > >>>>>>
>>>>>>>>>     > >>>>
>>>>>>>>>     > >>
>>>>>>>>>     >
>>>>>>>>>
>>>>>>>>
>>>>>
>>>>
>>


--4fToKNieaKszbknw8tf38vD6KJMFaCvj2--

--5uxK5NBRD27zDwpm3tdgIfGLJQ6xIlHlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9DeawACgkQwj2R86El
/qhLrwf9EoJsGPOyfvwmCFw/UYD8qkNGZFaFDreMVPteEkG2j5srUZ+xgjyukJ9u
pQpAPxWKKxgDm99U9ez++0vs4rNiqJTAvGaKwUyGOSGV4BPx7sXLBITVlDEmOsNL
EjLePeUXmSXyXK6bQ9YgRBJQmv3bNd2f3vC0uX/sOqAGRbxlIUKQokgbztqIwNfV
tTj823Sq7V4gTVTUwZSMvp/xd2PWmnA8ySdMiCDAs/YVgGKEEvToWcwfcRwrNU7I
1v5jfEPoFO9bCkwiOM5+5Jl9RiyZhsmo0Mf+SJOLt5tStHqZceWDnpOgzLvPXVWa
E7xJ318j8WgK0L5QPebba2aPML30gA==
=Hhp5
-----END PGP SIGNATURE-----

--5uxK5NBRD27zDwpm3tdgIfGLJQ6xIlHlo--
