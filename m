Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F1F24EB58
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 06:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgHWE2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 00:28:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:52529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725139AbgHWE2R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 00:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598156890;
        bh=ZVvm3WkOS6gbCYbi+9Cq33wn6XdDbaDpFauyzEQIxi8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ann4alr/3NSi5qbn/hnMMSStlLAXBdReTExcjn5HsCQf1KtQrLFMHHVt0UYNyc/bM
         clZszWigiBYGuYcRiGt1lfX27FMZmheqKOEGFeudh8QFt+RtoFXCXXGBB8C9fx2GuL
         rcmvrw0B0PgHN1Ucp2UyFMQ2wpb1F2mfZua12P98=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f9b-1kDIFK1aMp-004Ckn; Sun, 23
 Aug 2020 06:28:10 +0200
Subject: Re: Fwd: Read time tree block corruption detected
To:     Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com>
 <CAJheHN3qgr+FNq+N3DiAQaPkbdcmV+1O8TetAX_HLU5V304Phw@mail.gmail.com>
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
Message-ID: <4d1bb444-921c-9773-ff68-b6ea074ff35d@gmx.com>
Date:   Sun, 23 Aug 2020 12:28:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJheHN25gNo-jgykeQ6=ZQAm1ZHG9+-rWhBp3S-x2c1xi5j-og@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EamPimhguEXrPgmKQcAxgRFBbNKFgtPOE"
X-Provags-ID: V03:K1:BTn36SPum7q4gfzgvxoWzd5I1qbQHbHSp5trSgJCQnFrRFYhH1g
 MWQNsQo8SJ58H83SN/GYT9BQvyR8BCy10bIufN2c/AprluXFB4C2zGvWq7+hMenFBs9vdGt
 TRVFj2xQEy1Hm7wnxX8cqLWEb0rX4/j5nxuCgi7WVfSzPo0mzb+nniEfdO2BldyeoM9o5XP
 mywIJB8MERLyYAPjtxTvA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xPGPNXB/cv0=:+zFcYjmu1lhbvYm8lA7Vsk
 vUIHCKigYs5etdTxdx6EHcAso1VMWZt1HAbxk46ucQOpHBIqtWBgYOvFXx/IHlZeg2+rV65fu
 Sd5djmiJU4d1n2P4mxYqt6pzPgi3wri/sX81LMtpgtmiT/54P2UvvTorUtLip70jJHO7PC3d2
 a7tIYGKsJ2Go025kyQKSJ0QJBHX2rczBcVJMSpo/MGepUVhmnUoubmB2dp47wqenSKF6s8rLg
 tvzyKy/DKLcH3zrPHgwjm3FqMi21XGKP7YAyBZiIsabR7Rm+b1KY+Hh8R1TJ936OerbA9hW4r
 e9OH+CK0HTKbwO8GBp7/oNpWQ2qlUqGHQqhITioClXD0aWQvnvID4jTCOB+vXVXFiuziwheqZ
 hLZZKKyeOmMbcVvHLjD6IWg+YTLTLbAxuNaQdJV3zowhs5U6asCHzI/0LSFOGP1I4rU7rsj8w
 OT6ADYLGTuRmnftr023S1j8cxcUWYio+2BCoXnDwbC16QD+k1HyO6xf+cOWfPB5R2b4BAdANa
 2TK9EcjBcPveZeB8gWCm6n3DEJntZB5suW0Z2Svk3cOqaQOGdaUjI+ddaC3Vhzq+/3dMiJm1Q
 w2iHYFdeK+jb8EAdq8WelW49q3PZ8Ycw5Bz5o2AhKIejYjkjIONHnW5Yuiak6RVK0E5FgHevG
 UDNt7MSTqHERqmF+RNvXYq8Y4pZ9XdRDCirvxCk0jSn0t5tELaNKIwceFWCsG5XZf6i9IHaU2
 LANQ0l9g5k2qaouIC8ddm0XBjf6LwY9DiUbGxPyGqfc9sRh5TBhGIF73sT8ctbNcEEMGIuyxc
 g3Qc849aspVD68FhCY3wK5jWNqt0OM9+NTyGXhwwWOMQQAyv6bJMjpFAyHaJTx+BqFsr7OHAL
 bqbf57uN+YVjSyFv/1NTNExoXdwxlmofc8cqW+TM7l9Ta9nyA9l/Zk7SCiKcHsmY4x6FfBWcM
 6dae6bY14PSMqv2m1YWLeR+5+klvOHh9ppOEaT+9NiDNgwTxYKOcSyg9LmEgK5vtMasqTj4Ve
 ZknvfZl7wjHXYzdQLq0PslCAk6Jb0EOxgT9ToP9HEGAyYFW5m40+s6nRpZNSNCA8FHkUAoeEp
 NEe48AeakDg3K4a6WaEiwL1jvRtQp5S2y8gGjuXlc9+qDNPp4UGvUQMrXJShJOvDuIhH+wWI4
 gkyA5KX+GjcvdYqBfK4rPGIXnW0AHwly3QLHPHBi7OHVw5su3yz10yCpMCODV+XHrfcrwNMYr
 D8y1tgHtKj+jTa73X/JRCWd8l4PimmMYycCBqZA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EamPimhguEXrPgmKQcAxgRFBbNKFgtPOE
Content-Type: multipart/mixed; boundary="7Jnu4tc3RGPx83jhqbKUkIdXc6BKuWxdd"

--7Jnu4tc3RGPx83jhqbKUkIdXc6BKuWxdd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/23 =E4=B8=8A=E5=8D=8810:49, Tyler Richmond wrote:
> Well, I can guarantee that I didn't create this fs before 2015 (just
> checked the order confirmation from when I bought the server), but I
> may have just used whatever was in the Ubuntu package manager at the
> time. So maybe I don't have a v0 ref?

Then btrfs-image shouldn't report that.

There is an item smaller than any valid btrfs item, normally it means
it's a v0 ref.
If not, then it could be a bigger problem.

Could you please provide the full btrfs-check output?
Also, if possible result from "btrfs check --mode=3Dlowmem" would also he=
lp.

Also, if you really go "--repair", then the full output would also be
needed to determine what's going wrong.
There is a report about "btrfs check --repair" didn't repair the inode
generation, if that's the case we must have a bug then.

Thanks,
Qu
>=20
> On Sat, Aug 22, 2020 at 10:31 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>
>>
>>
>> On 2020/8/23 =E4=B8=8A=E5=8D=889:51, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:15, Tyler Richmond wrote:
>>>> Is my best bet just to downgrade the kernel and then try to delete t=
he
>>>> broken files? Or should I rebuild from scratch? Just don't know
>>>> whether it's worth the time to try and figure this out or if the
>>>> problems stem from the FS being too old and it's beyond trying to
>>>> repair.
>>>
>>> All invalid inode generations, should be able to be repaired by lates=
t
>>> btrfs-check.
>>>
>>> If not, please provide the btrfs-image dump for us to determine what'=
s
>>> going wrong.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> On Tue, Aug 18, 2020 at 8:18 AM Tyler Richmond <t.d.richmond@gmail.c=
om> wrote:
>>>>>
>>>>> I didn't check dmesg during the btrfs check, but that was the only
>>>>> output during the rm -f before it was forced readonly. I just check=
ed
>>>>> dmesg for inode generation values, and there are a lot of them.
>>>>>
>>>>> https://pastebin.com/stZdN0ta
>>>>> The dmesg output had 990 lines containing inode generation.
>>>>>
>>>>> However, these were at least later. I tried to do a btrfs balance
>>>>> -mconvert raid1 and it failed with an I/O error. That is probably w=
hat
>>>>> generated these specific errors, but maybe they were also happening=

>>>>> during the btrfs repair.
>>>>>
>>>>> The FS is ~45TB, but the btrfs-image -c9 failed anway with:
>>>>> ERROR: either extent tree is corrupted or deprecated extent ref for=
mat
>>>>> ERROR: create failed: -5
>>
>> Oh, forgot this part.
>>
>> This means you have v0 ref?!
>>
>> Then the fs is too old, no progs/kernel support after all.
>>
>> In that case, please rollback to the last working kernel and copy your=
 data.
>>
>> In fact, that v0 ref should only be in the code base for several weeks=

>> before 2010, thus it's really too old.
>>
>> The good news is, with tree-checker, we should never experience such
>> too-old-to-be-usable problem (at least I hope so)
>>
>> Thanks,
>> Qu
>>
>>>>>
>>>>>
>>>>> On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2020/8/18 =E4=B8=8A=E5=8D=8811:35, Tyler Richmond wrote:
>>>>>>> Qu,
>>>>>>>
>>>>>>> Sorry to resurrect this thread, but I just ran into something tha=
t I
>>>>>>> can't really just ignore. I've found a folder that is full of fil=
es
>>>>>>> which I guess have been broken somehow. I found a backup and rest=
ored
>>>>>>> them, but I want to delete this folder of broken files. But whene=
ver I
>>>>>>> try, the fs is forced into readonly mode again. I just finished a=
nother
>>>>>>> btrfs check --repair but it didn't fix the problem.
>>>>>>>
>>>>>>> https://pastebin.com/eTV3s3fr
>>>>>>
>>>>>> Is that the full output?
>>>>>>
>>>>>> No inode generation bugs?
>>>>>>>
>>>>>>>  I'm already on btrfs-progs v5.7. Any new suggestions?
>>>>>>
>>>>>> Strange.
>>>>>>
>>>>>> The detection and repair should have been merged into v5.5.
>>>>>>
>>>>>> If your fs is small enough, would you please provide the "btrfs-im=
age
>>>>>> -c9" dump?
>>>>>>
>>>>>> It would contain the filenames and directories names, but doesn't
>>>>>> contain file contents.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond <t.d.richmond@gmail=
=2Ecom
>>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
>>>>>>>
>>>>>>>     5.6.1 also failed the same way. Here's the usage output. This=
 is the
>>>>>>>     part where you see I've been using RAID5 haha
>>>>>>>
>>>>>>>     WARNING: RAID56 detected, not implemented
>>>>>>>     Overall:
>>>>>>>         Device size:                  60.03TiB
>>>>>>>         Device allocated:             98.06GiB
>>>>>>>         Device unallocated:           59.93TiB
>>>>>>>         Device missing:                  0.00B
>>>>>>>         Used:                         92.56GiB
>>>>>>>         Free (estimated):                0.00B      (min: 8.00EiB=
)
>>>>>>>         Data ratio:                       0.00
>>>>>>>         Metadata ratio:                   2.00
>>>>>>>         Global reserve:              512.00MiB      (used: 0.00B)=

>>>>>>>         Multiple profiles:                  no
>>>>>>>
>>>>>>>     Data,RAID5: Size:40.35TiB, Used:40.12TiB (99.42%)
>>>>>>>        /dev/sdh        8.07TiB
>>>>>>>        /dev/sdf        8.07TiB
>>>>>>>        /dev/sdg        8.07TiB
>>>>>>>        /dev/sdd        8.07TiB
>>>>>>>        /dev/sdc        8.07TiB
>>>>>>>        /dev/sde        8.07TiB
>>>>>>>
>>>>>>>     Metadata,RAID1: Size:49.00GiB, Used:46.28GiB (94.44%)
>>>>>>>        /dev/sdh       34.00GiB
>>>>>>>        /dev/sdf       32.00GiB
>>>>>>>        /dev/sdg       32.00GiB
>>>>>>>
>>>>>>>     System,RAID1: Size:32.00MiB, Used:2.20MiB (6.87%)
>>>>>>>        /dev/sdf       32.00MiB
>>>>>>>        /dev/sdg       32.00MiB
>>>>>>>
>>>>>>>     Unallocated:
>>>>>>>        /dev/sdh        2.81TiB
>>>>>>>        /dev/sdf        2.81TiB
>>>>>>>        /dev/sdg        2.81TiB
>>>>>>>        /dev/sdd        1.03TiB
>>>>>>>        /dev/sdc        1.03TiB
>>>>>>>        /dev/sde        1.03TiB
>>>>>>>
>>>>>>>     On Fri, May 8, 2020 at 1:47 AM Qu Wenruo <quwenruo.btrfs@gmx.=
com
>>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>     >
>>>>>>>     >
>>>>>>>     >
>>>>>>>     > On 2020/5/8 =E4=B8=8B=E5=8D=881:12, Tyler Richmond wrote:
>>>>>>>     > > If this is saying there's no extra space for metadata, is=
 that why
>>>>>>>     > > adding more files often makes the system hang for 30-90s?=
 Is there
>>>>>>>     > > anything I should do about that?
>>>>>>>     >
>>>>>>>     > I'm not sure about the hang though.
>>>>>>>     >
>>>>>>>     > It would be nice to give more info to diagnosis.
>>>>>>>     > The output of 'btrfs fi usage' is useful for space usage pr=
oblem.
>>>>>>>     >
>>>>>>>     > But the common idea is, to keep at 1~2 Gi unallocated (not =
avaiable
>>>>>>>     > space in vanilla df command) space for btrfs.
>>>>>>>     >
>>>>>>>     > Thanks,
>>>>>>>     > Qu
>>>>>>>     >
>>>>>>>     > >
>>>>>>>     > > Thank you so much for all of your help. I love how flexib=
le BTRFS is
>>>>>>>     > > but when things go wrong it's very hard for me to trouble=
shoot.
>>>>>>>     > >
>>>>>>>     > > On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenruo.btrfs@=
gmx.com
>>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>     > >>
>>>>>>>     > >>
>>>>>>>     > >>
>>>>>>>     > >> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmond wrot=
e:
>>>>>>>     > >>> Something went wrong:
>>>>>>>     > >>>
>>>>>>>     > >>> Reinitialize checksum tree
>>>>>>>     > >>> Unable to find block group for 0
>>>>>>>     > >>> Unable to find block group for 0
>>>>>>>     > >>> Unable to find block group for 0
>>>>>>>     > >>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1=

>>>>>>>     > >>> btrfs(+0x6dd94)[0x55a933af7d94]
>>>>>>>     > >>> btrfs(+0x71b94)[0x55a933afbb94]
>>>>>>>     > >>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
>>>>>>>     > >>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
>>>>>>>     > >>> btrfs(+0x360b2)[0x55a933ac00b2]
>>>>>>>     > >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
>>>>>>>     > >>> btrfs(main+0x98)[0x55a933a9fe88]
>>>>>>>     > >>>
>>>>>>>     /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f2=
63ed550b3]
>>>>>>>     > >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
>>>>>>>     > >>> Aborted
>>>>>>>     > >>
>>>>>>>     > >> This means no space for extra metadata...
>>>>>>>     > >>
>>>>>>>     > >> Anyway the csum tree problem shouldn't be a big thing, y=
ou
>>>>>>>     could leave
>>>>>>>     > >> it and call it a day.
>>>>>>>     > >>
>>>>>>>     > >> BTW, as long as btrfs check reports no extra problem for=
 the inode
>>>>>>>     > >> generation, it should be pretty safe to use the fs.
>>>>>>>     > >>
>>>>>>>     > >> Thanks,
>>>>>>>     > >> Qu
>>>>>>>     > >>>
>>>>>>>     > >>> I just noticed I have btrfs-progs 5.6 installed and 5.6=
=2E1 is
>>>>>>>     > >>> available. I'll let that try overnight?
>>>>>>>     > >>>
>>>>>>>     > >>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo
>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrot=
e:
>>>>>>>     > >>>>
>>>>>>>     > >>>>
>>>>>>>     > >>>>
>>>>>>>     > >>>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond wr=
ote:
>>>>>>>     > >>>>> Thank you for helping. The end result of the scan was=
:
>>>>>>>     > >>>>>
>>>>>>>     > >>>>>
>>>>>>>     > >>>>> [1/7] checking root items
>>>>>>>     > >>>>> [2/7] checking extents
>>>>>>>     > >>>>> [3/7] checking free space cache
>>>>>>>     > >>>>> [4/7] checking fs roots
>>>>>>>     > >>>>
>>>>>>>     > >>>> Good news is, your fs is still mostly fine.
>>>>>>>     > >>>>
>>>>>>>     > >>>>> [5/7] checking only csums items (without verifying da=
ta)
>>>>>>>     > >>>>> there are no extents for csum range 0-69632
>>>>>>>     > >>>>> csum exists for 0-69632 but there is no extent record=

>>>>>>>     > >>>>> ...
>>>>>>>     > >>>>> ...
>>>>>>>     > >>>>> there are no extents for csum range 946692096-9468272=
64
>>>>>>>     > >>>>> csum exists for 946692096-946827264 but there is no e=
xtent
>>>>>>>     record
>>>>>>>     > >>>>> there are no extents for csum range 946831360-9479127=
04
>>>>>>>     > >>>>> csum exists for 946831360-947912704 but there is no e=
xtent
>>>>>>>     record
>>>>>>>     > >>>>> ERROR: errors found in csum tree
>>>>>>>     > >>>>
>>>>>>>     > >>>> Only extent tree is corrupted.
>>>>>>>     > >>>>
>>>>>>>     > >>>> Normally btrfs check --init-csum-tree should be able t=
o
>>>>>>>     handle it.
>>>>>>>     > >>>>
>>>>>>>     > >>>> But still, please be sure you're using the latest btrf=
s-progs
>>>>>>>     to fix it.
>>>>>>>     > >>>>
>>>>>>>     > >>>> Thanks,
>>>>>>>     > >>>> Qu
>>>>>>>     > >>>>
>>>>>>>     > >>>>> [6/7] checking root refs
>>>>>>>     > >>>>> [7/7] checking quota groups skipped (not enabled on t=
his FS)
>>>>>>>     > >>>>> found 44157956026368 bytes used, error(s) found
>>>>>>>     > >>>>> total csum bytes: 42038602716
>>>>>>>     > >>>>> total tree bytes: 49688616960
>>>>>>>     > >>>>> total fs tree bytes: 1256427520
>>>>>>>     > >>>>> total extent tree bytes: 1709105152
>>>>>>>     > >>>>> btree space waste bytes: 3172727316
>>>>>>>     > >>>>> file data blocks allocated: 261625653436416
>>>>>>>     > >>>>>  referenced 47477768499200
>>>>>>>     > >>>>>
>>>>>>>     > >>>>> What do I need to do to fix all of this?
>>>>>>>     > >>>>>
>>>>>>>     > >>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo
>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrot=
e:
>>>>>>>     > >>>>>>
>>>>>>>     > >>>>>>
>>>>>>>     > >>>>>>
>>>>>>>     > >>>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond w=
rote:
>>>>>>>     > >>>>>>> Well, the repair doesn't look terribly successful.
>>>>>>>     > >>>>>>>
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
>>>>>>>     item=3D84
>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>     > >>>>>>>                                             child l=
evel=3D4
>>>>>>>     > >>>>>>
>>>>>>>     > >>>>>> This means there are more problems, not only the has=
h name
>>>>>>>     mismatch.
>>>>>>>     > >>>>>>
>>>>>>>     > >>>>>> This means the fs is already corrupted, the name has=
h is
>>>>>>>     just one
>>>>>>>     > >>>>>> unrelated symptom.
>>>>>>>     > >>>>>>
>>>>>>>     > >>>>>> The only good news is, btrfs-progs abort the transac=
tion,
>>>>>>>     thus no
>>>>>>>     > >>>>>> further damage to the fs.
>>>>>>>     > >>>>>>
>>>>>>>     > >>>>>> Please run a plain btrfs-check to show what's the pr=
oblem
>>>>>>>     first.
>>>>>>>     > >>>>>>
>>>>>>>     > >>>>>> Thanks,
>>>>>>>     > >>>>>> Qu
>>>>>>>     > >>>>>>
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
>>>>>>>     item=3D84
>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>     > >>>>>>>                                             child l=
evel=3D4
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
>>>>>>>     item=3D84
>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>     > >>>>>>>                                             child l=
evel=3D4
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
>>>>>>>     item=3D84
>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>     > >>>>>>>                                             child l=
evel=3D4
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
>>>>>>>     item=3D84
>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>     > >>>>>>>                                             child l=
evel=3D4
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
>>>>>>>     item=3D84
>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>     > >>>>>>>                                             child l=
evel=3D4
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
>>>>>>>     item=3D84
>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>     > >>>>>>>                                             child l=
evel=3D4
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
>>>>>>>     item=3D84
>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>     > >>>>>>>                                             child l=
evel=3D4
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
>>>>>>>     item=3D84
>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>     > >>>>>>>                                             child l=
evel=3D4
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
>>>>>>>     item=3D84
>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>     > >>>>>>>                                             child l=
evel=3D4
>>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
>>>>>>>     6875841 found 6876224
>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
>>>>>>>     item=3D84
>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>     > >>>>>>>                                             child l=
evel=3D4
>>>>>>>     > >>>>>>> ERROR: failed to zero log tree: -17
>>>>>>>     > >>>>>>> ERROR: attempt to start transaction over already ru=
nning one
>>>>>>>     > >>>>>>> WARNING: reserved space leaked, flag=3D0x4 bytes_re=
served=3D4096
>>>>>>>     > >>>>>>> extent buffer leak: start 225049066086400 len 4096
>>>>>>>     > >>>>>>> extent buffer leak: start 225049066086400 len 4096
>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>>>>     225049066086400 len 4096
>>>>>>>     > >>>>>>> extent buffer leak: start 225049066094592 len 4096
>>>>>>>     > >>>>>>> extent buffer leak: start 225049066094592 len 4096
>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>>>>     225049066094592 len 4096
>>>>>>>     > >>>>>>> extent buffer leak: start 225049066102784 len 4096
>>>>>>>     > >>>>>>> extent buffer leak: start 225049066102784 len 4096
>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>>>>     225049066102784 len 4096
>>>>>>>     > >>>>>>> extent buffer leak: start 225049066131456 len 4096
>>>>>>>     > >>>>>>> extent buffer leak: start 225049066131456 len 4096
>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>>>>     225049066131456 len 4096
>>>>>>>     > >>>>>>>
>>>>>>>     > >>>>>>> What is going on?
>>>>>>>     > >>>>>>>
>>>>>>>     > >>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond
>>>>>>>     <t.d.richmond@gmail.com <mailto:t.d.richmond@gmail.com>> wrot=
e:
>>>>>>>     > >>>>>>>>
>>>>>>>     > >>>>>>>> Chris, I had used the correct mountpoint in the co=
mmand.
>>>>>>>     I just edited
>>>>>>>     > >>>>>>>> it in the email to be /mountpoint for consistency.=

>>>>>>>     > >>>>>>>>
>>>>>>>     > >>>>>>>> Qu, I'll try the repair. Fingers crossed!
>>>>>>>     > >>>>>>>>
>>>>>>>     > >>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo
>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrot=
e:
>>>>>>>     > >>>>>>>>>
>>>>>>>     > >>>>>>>>>
>>>>>>>     > >>>>>>>>>
>>>>>>>     > >>>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmon=
d wrote:
>>>>>>>     > >>>>>>>>>> Hello,
>>>>>>>     > >>>>>>>>>>
>>>>>>>     > >>>>>>>>>> I looked up this error and it basically says ask=
 a
>>>>>>>     developer to
>>>>>>>     > >>>>>>>>>> determine if it's a false error or not. I just s=
tarted
>>>>>>>     getting some
>>>>>>>     > >>>>>>>>>> slow response times, and looked at the dmesg log=
 to
>>>>>>>     find a ton of
>>>>>>>     > >>>>>>>>>> these errors.
>>>>>>>     > >>>>>>>>>>
>>>>>>>     > >>>>>>>>>> [192088.446299] BTRFS critical (device sdh): cor=
rupt
>>>>>>>     leaf: root=3D5
>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, =
invalid inode
>>>>>>>     generation:
>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>     > >>>>>>>>>> [192088.449823] BTRFS error (device sdh):
>>>>>>>     block=3D203510940835840 read
>>>>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>>>>     > >>>>>>>>>> [192088.459238] BTRFS critical (device sdh): cor=
rupt
>>>>>>>     leaf: root=3D5
>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, =
invalid inode
>>>>>>>     generation:
>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>     > >>>>>>>>>> [192088.462773] BTRFS error (device sdh):
>>>>>>>     block=3D203510940835840 read
>>>>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>>>>     > >>>>>>>>>> [192088.464711] BTRFS critical (device sdh): cor=
rupt
>>>>>>>     leaf: root=3D5
>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, =
invalid inode
>>>>>>>     generation:
>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>     > >>>>>>>>>> [192088.468457] BTRFS error (device sdh):
>>>>>>>     block=3D203510940835840 read
>>>>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>>>>     > >>>>>>>>>>
>>>>>>>     > >>>>>>>>>> btrfs device stats, however, doesn't show any er=
rors.
>>>>>>>     > >>>>>>>>>>
>>>>>>>     > >>>>>>>>>> Is there anything I should do about this, or sho=
uld I
>>>>>>>     just continue
>>>>>>>     > >>>>>>>>>> using my array as normal?
>>>>>>>     > >>>>>>>>>
>>>>>>>     > >>>>>>>>> This is caused by older kernel underflow inode ge=
neration.
>>>>>>>     > >>>>>>>>>
>>>>>>>     > >>>>>>>>> Latest btrfs-progs can fix it, using btrfs check =
--repair.
>>>>>>>     > >>>>>>>>>
>>>>>>>     > >>>>>>>>> Or you can go safer, by manually locating the ino=
de
>>>>>>>     using its inode
>>>>>>>     > >>>>>>>>> number (1311670), and copy it to some new locatio=
n using
>>>>>>>     previous
>>>>>>>     > >>>>>>>>> working kernel, then delete the old file, copy th=
e new
>>>>>>>     one back to fix it.
>>>>>>>     > >>>>>>>>>
>>>>>>>     > >>>>>>>>> Thanks,
>>>>>>>     > >>>>>>>>> Qu
>>>>>>>     > >>>>>>>>>
>>>>>>>     > >>>>>>>>>>
>>>>>>>     > >>>>>>>>>> Thank you!
>>>>>>>     > >>>>>>>>>>
>>>>>>>     > >>>>>>>>>
>>>>>>>     > >>>>>>
>>>>>>>     > >>>>
>>>>>>>     > >>
>>>>>>>     >
>>>>>>>
>>>>>>
>>>
>>


--7Jnu4tc3RGPx83jhqbKUkIdXc6BKuWxdd--

--EamPimhguEXrPgmKQcAxgRFBbNKFgtPOE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9B8FMACgkQwj2R86El
/qj+gQf/SNlNyG6iAXBqjKzssGqyjD5oggAlfLW099R542iAjhqnyplNktk9TOgm
uMs6XjRRiKDONv/rvTjAS6d7JBm76IaEz5cRlkJngnnP6VsR3Q1tRGSgLmMC1pXS
E8ydIT4cjyU8SIktTpln1rKq+mq4Osmz6qr90IhSJ6EzzGHyjFKr3fTriooAekGm
4u9PaUVrTtgrkStSxTtspQBKLUwPwPjxY6RCvJzzyFEBx30SeBs8IhzTr5kDugCV
FL+wizP04RDUDCIQl+79UTQjHBtz9vyi9sU2TLfnVRXl5KaAEzu5BrCgYhO5Ta2m
Qjiuy3FIsFhHEQPWNiA/XMAydpkGgw==
=FU/1
-----END PGP SIGNATURE-----

--EamPimhguEXrPgmKQcAxgRFBbNKFgtPOE--
