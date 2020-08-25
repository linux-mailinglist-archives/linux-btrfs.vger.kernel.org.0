Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A7251A11
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgHYNlb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 09:41:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:43149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHYNjF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 09:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598362737;
        bh=avUrd60e6euc7NdDRL0pD9np2IXUsWEV3wErnCI0DXE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ni/gLhle1LtOLlt0to/ooRpsAWA3QOpRWucOvlxx7r7/vIlEMVSLn3ygE4ANyNEut
         y/OROikpQBCWvYI197z6u4FHASmBU8WDLKmXn/T2QYF09C7ULTIWNXDSM92wsvCmeI
         kNMqgbvnO+TlI1ycC72M94YaHO3DgU6nz9zmC8Ds=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQnF-1kOc300oYv-00GuA7; Tue, 25
 Aug 2020 15:38:57 +0200
Subject: Re: Fwd: Read time tree block corruption detected
To:     Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
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
 <5346c4af-c73e-84b3-ec4f-8f169c0a732a@gmx.com>
 <CAJheHN0NmgVoGF+AsnUNQkQnEJ46JCmpg4o5nwAkqi+VoGMjfw@mail.gmail.com>
 <e04680b4-f4c0-254f-24ba-f2053e4ad8b3@gmx.com>
 <CAJheHN0THhKcqKY3cGtJqUGaub=E0tuCmi6wuNeCGBxyAHmecQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <e2c8eaaf-6adb-374f-4005-a1edcbcb8f79@gmx.com>
Date:   Tue, 25 Aug 2020 21:38:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJheHN0THhKcqKY3cGtJqUGaub=E0tuCmi6wuNeCGBxyAHmecQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JTOG0ZHifhiPqcTL7EkXSalGKu8KbC9q5"
X-Provags-ID: V03:K1:hMTEdLssy7+6Ozw8qJliXFwozo+HPp3KzAjA7BAM94XvzGAwQFo
 KUZ8kzXGZMmzpSSLgeh6BTbs6pJpEoccIc6ONOxMsaDj5DcLtKnZ9eFjls3um7iclzixVJ2
 PyDkybx2+GglR5tGxbnJKfY4mXwk9VKqe5CvYwaNMlQp6LxfPGwlOYZGW4EYj6ctr6QvbaB
 bL7xJa6asna/wRzBMDpIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aUuFqUZuL7A=:2ezbLVmcJgam78W/Lz3YEc
 m2kbzYWcLHfX8e25xTUCnOg4vrZhu4x8smYg2AEzSLWjYDHiOFLglccU3HJeqcGJdGG/fvvR8
 kQTU95+UT4iLInZLpMt0X+IbyfRgMkbrP3/CSiUNXiuhyzgCDo4XhR4XlJ46hwlDYRtAD1UUc
 fiFB79YguDDMEx2YsIcnnFbFva4rdxSJne+otg7+EuwZYEtZiFY7ZK5QOZu253P8EASNSeNnS
 kXw5SLlhSWdRgzaBeh/Mk290nlg3ot9iLkgluk26882Ez5yhpZnDz2mDnoCSdjTMAt05S2Ll1
 Or0D4hS/JXMGc0rY7zpEf2bRZtQ3kt+N+nmQdkUEbQ3Lg+DZJxJPYIHavOc4HqJqxN48ZbjYG
 P5ngDYTJRjNf9fKjPl2aJftMWbgZ+UN2zrFjnLwn2CXX8X49V46vF2ywTdzXX2VWWYRgZHZ+X
 +OU9U8PRIdWxsN6/yIiI+VYD23NG3481NsYOPed/n8fFQ3m8b4sDhZKLmAg9W1P1/0UU1ZWbh
 XpvWQ7f5A0XCOejw99TsLse65WkdMzb+2aHZuJheyjrWif1/N9hU96eKKZt+FAjeXXCjCEJUD
 PdeT/QADKTKzJy3FhP48TfYUduQUknOWcojRbj4cyy90+BKZgo5ELaz34s2OUHtrKMd2D/Hpm
 0X9UoZeuuClw4HE5z0AA5Ppz2q1vQBaiLMGP0E+Sshl+sQd1NFJxO4/6QZPu2Gl8c4L9KFga2
 /RLeU/DZgk7flAN48XzTYjrSZhgfysY8VaxNAEjrl7/RHagpsQZGdvcsN9jCH5cloSlNc9zIa
 I3yP3Gt8MK2h8JM+rcFzevu4PyB+3lC92nobmt36b4bWyrrqidQcetB1bOC1NuDmG+4tXNhst
 8HPhaZq8XObi9ecL1kgi9w+zocQgl1FLVHcjdQ1DjaGPzOSrIzdIikWI0W+PauPluYq7aYxyn
 olxFVogpV1AOG6SR9qxYsyc8jvd1iHQeXumXFiMp/6F3SSQ4hFflDD5/x9s8o2gkvOJ50wFXz
 rLmFMe3Iy5LVghDoTJ7MpD5Oq1sIxtvBXjH0d6cUOYXfMufxPi3Pfu/sE/s5RrfgtYZUT6XDG
 r+i+Wj9uO3Pgi0EpliyRb1ZxU3q/p6kL8UyYanXefkOrhzhlwJfJH7neEWuM1X5UJ/nT5CcjI
 DPNevKQvwTKLDrlymS6wf5tXJIdNp9forrHUnK6x+HlQq2c0P+kWaMDk/oXtOR6ZbboybGkld
 Y1ceVN6BgAIH7+v0P/5UF+wq150MC6PqGXWSEmw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JTOG0ZHifhiPqcTL7EkXSalGKu8KbC9q5
Content-Type: multipart/mixed; boundary="kvazZnHoBpbB5biUsuvVXVTIK6Impq8C5"

--kvazZnHoBpbB5biUsuvVXVTIK6Impq8C5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/25 =E4=B8=8B=E5=8D=889:30, Tyler Richmond wrote:
> Qu,
>=20
> The dump of the block is:
>=20
> https://pastebin.com/ran85JJv
>=20
> I've also completed the btrfs-image, but it's almost 50gb. What's the
> best way to get it to you? Also, does it work with -ss or are the
> original filenames important?

50G is too big for me to even receive.

But your dump shows the problem!

It's not inode generation, but inode transid, which would affect send.

This is not even checked in btrfs-progs, thus no wonder why it doesn't
detect them.

And copy-pasted kernel message shares the same "generation" word, not
using proper transid to show the problem.

Your dump really saved the day!

The fix for kernel and btrfs-progs would come in next few days.

Thanks,
Qu
>=20
> Thanks again!
>=20
>=20
> On Tue, Aug 25, 2020 at 2:37 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2020/8/25 =E4=B8=8B=E5=8D=881:25, Tyler Richmond wrote:
>>> Qu,
>>>
>>> Yes, it's btrfs-progs 5.7. Here is the result of the lowmem check:
>>>
>>> https://pastebin.com/8Tzx23EX
>>
>> That doesn't detect any inode generation problem at all, which is not =
a
>> good sign.
>>
>> Would you also pvode the dump for the offending block?
>>
>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode generat=
ion:
>> has 18446744073709551492 expect [0, 6875827]
>>
>> For this case, would you please provide the tree dump of "203510940835=
840" ?
>>
>> # btrfs ins dump-tree -b 203510940835840 <device>
>>
>> And, since btrfs-image can't dump with regular extent tree, the "-w"
>> dump would also help.
>>
>> Thanks,
>> Qu
>>
>>
>>> Thanks!
>>>
>>> On Mon, Aug 24, 2020 at 4:26 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>
>>>>
>>>>
>>>> On 2020/8/24 =E4=B8=8A=E5=8D=8810:47, Tyler Richmond wrote:
>>>>> Qu,
>>>>>
>>>>> Finally finished another repair and captured the output.
>>>>>
>>>>> https://pastebin.com/ffcbwvd8
>>>>>
>>>>> Does that show you what you need? Or should I still do one in lowme=
m mode?
>>>>
>>>> Lowmem mode (no need for --repair) is recommended since original mod=
e
>>>> doesn't detect the inode generation problem.
>>>>
>>>> And it's already btrfs-progs v5.7 right?
>>>>
>>>> THanks,
>>>> Qu
>>>>>
>>>>> Thanks for your help!
>>>>>
>>>>> On Sun, Aug 23, 2020 at 12:28 AM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=8810:49, Tyler Richmond wrote:
>>>>>>> Well, I can guarantee that I didn't create this fs before 2015 (j=
ust
>>>>>>> checked the order confirmation from when I bought the server), bu=
t I
>>>>>>> may have just used whatever was in the Ubuntu package manager at =
the
>>>>>>> time. So maybe I don't have a v0 ref?
>>>>>>
>>>>>> Then btrfs-image shouldn't report that.
>>>>>>
>>>>>> There is an item smaller than any valid btrfs item, normally it me=
ans
>>>>>> it's a v0 ref.
>>>>>> If not, then it could be a bigger problem.
>>>>>>
>>>>>> Could you please provide the full btrfs-check output?
>>>>>> Also, if possible result from "btrfs check --mode=3Dlowmem" would =
also help.
>>>>>>
>>>>>> Also, if you really go "--repair", then the full output would also=
 be
>>>>>> needed to determine what's going wrong.
>>>>>> There is a report about "btrfs check --repair" didn't repair the i=
node
>>>>>> generation, if that's the case we must have a bug then.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>> On Sat, Aug 22, 2020 at 10:31 PM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:51, Qu Wenruo wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:15, Tyler Richmond wrote:
>>>>>>>>>> Is my best bet just to downgrade the kernel and then try to de=
lete the
>>>>>>>>>> broken files? Or should I rebuild from scratch? Just don't kno=
w
>>>>>>>>>> whether it's worth the time to try and figure this out or if t=
he
>>>>>>>>>> problems stem from the FS being too old and it's beyond trying=
 to
>>>>>>>>>> repair.
>>>>>>>>>
>>>>>>>>> All invalid inode generations, should be able to be repaired by=
 latest
>>>>>>>>> btrfs-check.
>>>>>>>>>
>>>>>>>>> If not, please provide the btrfs-image dump for us to determine=
 what's
>>>>>>>>> going wrong.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>>
>>>>>>>>>> On Tue, Aug 18, 2020 at 8:18 AM Tyler Richmond <t.d.richmond@g=
mail.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> I didn't check dmesg during the btrfs check, but that was the=
 only
>>>>>>>>>>> output during the rm -f before it was forced readonly. I just=
 checked
>>>>>>>>>>> dmesg for inode generation values, and there are a lot of the=
m.
>>>>>>>>>>>
>>>>>>>>>>> https://pastebin.com/stZdN0ta
>>>>>>>>>>> The dmesg output had 990 lines containing inode generation.
>>>>>>>>>>>
>>>>>>>>>>> However, these were at least later. I tried to do a btrfs bal=
ance
>>>>>>>>>>> -mconvert raid1 and it failed with an I/O error. That is prob=
ably what
>>>>>>>>>>> generated these specific errors, but maybe they were also hap=
pening
>>>>>>>>>>> during the btrfs repair.
>>>>>>>>>>>
>>>>>>>>>>> The FS is ~45TB, but the btrfs-image -c9 failed anway with:
>>>>>>>>>>> ERROR: either extent tree is corrupted or deprecated extent r=
ef format
>>>>>>>>>>> ERROR: create failed: -5
>>>>>>>>
>>>>>>>> Oh, forgot this part.
>>>>>>>>
>>>>>>>> This means you have v0 ref?!
>>>>>>>>
>>>>>>>> Then the fs is too old, no progs/kernel support after all.
>>>>>>>>
>>>>>>>> In that case, please rollback to the last working kernel and cop=
y your data.
>>>>>>>>
>>>>>>>> In fact, that v0 ref should only be in the code base for several=
 weeks
>>>>>>>> before 2010, thus it's really too old.
>>>>>>>>
>>>>>>>> The good news is, with tree-checker, we should never experience =
such
>>>>>>>> too-old-to-be-usable problem (at least I hope so)
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo <quwenruo.btrfs@gmx=
=2Ecom> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 2020/8/18 =E4=B8=8A=E5=8D=8811:35, Tyler Richmond wrote:
>>>>>>>>>>>>> Qu,
>>>>>>>>>>>>>
>>>>>>>>>>>>> Sorry to resurrect this thread, but I just ran into somethi=
ng that I
>>>>>>>>>>>>> can't really just ignore. I've found a folder that is full =
of files
>>>>>>>>>>>>> which I guess have been broken somehow. I found a backup an=
d restored
>>>>>>>>>>>>> them, but I want to delete this folder of broken files. But=
 whenever I
>>>>>>>>>>>>> try, the fs is forced into readonly mode again. I just fini=
shed another
>>>>>>>>>>>>> btrfs check --repair but it didn't fix the problem.
>>>>>>>>>>>>>
>>>>>>>>>>>>> https://pastebin.com/eTV3s3fr
>>>>>>>>>>>>
>>>>>>>>>>>> Is that the full output?
>>>>>>>>>>>>
>>>>>>>>>>>> No inode generation bugs?
>>>>>>>>>>>>>
>>>>>>>>>>>>>  I'm already on btrfs-progs v5.7. Any new suggestions?
>>>>>>>>>>>>
>>>>>>>>>>>> Strange.
>>>>>>>>>>>>
>>>>>>>>>>>> The detection and repair should have been merged into v5.5.
>>>>>>>>>>>>
>>>>>>>>>>>> If your fs is small enough, would you please provide the "bt=
rfs-image
>>>>>>>>>>>> -c9" dump?
>>>>>>>>>>>>
>>>>>>>>>>>> It would contain the filenames and directories names, but do=
esn't
>>>>>>>>>>>> contain file contents.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> Qu
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond <t.d.richmond=
@gmail.com
>>>>>>>>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>     5.6.1 also failed the same way. Here's the usage output=
=2E This is the
>>>>>>>>>>>>>     part where you see I've been using RAID5 haha
>>>>>>>>>>>>>
>>>>>>>>>>>>>     WARNING: RAID56 detected, not implemented
>>>>>>>>>>>>>     Overall:
>>>>>>>>>>>>>         Device size:                  60.03TiB
>>>>>>>>>>>>>         Device allocated:             98.06GiB
>>>>>>>>>>>>>         Device unallocated:           59.93TiB
>>>>>>>>>>>>>         Device missing:                  0.00B
>>>>>>>>>>>>>         Used:                         92.56GiB
>>>>>>>>>>>>>         Free (estimated):                0.00B      (min: 8=
=2E00EiB)
>>>>>>>>>>>>>         Data ratio:                       0.00
>>>>>>>>>>>>>         Metadata ratio:                   2.00
>>>>>>>>>>>>>         Global reserve:              512.00MiB      (used: =
0.00B)
>>>>>>>>>>>>>         Multiple profiles:                  no
>>>>>>>>>>>>>
>>>>>>>>>>>>>     Data,RAID5: Size:40.35TiB, Used:40.12TiB (99.42%)
>>>>>>>>>>>>>        /dev/sdh        8.07TiB
>>>>>>>>>>>>>        /dev/sdf        8.07TiB
>>>>>>>>>>>>>        /dev/sdg        8.07TiB
>>>>>>>>>>>>>        /dev/sdd        8.07TiB
>>>>>>>>>>>>>        /dev/sdc        8.07TiB
>>>>>>>>>>>>>        /dev/sde        8.07TiB
>>>>>>>>>>>>>
>>>>>>>>>>>>>     Metadata,RAID1: Size:49.00GiB, Used:46.28GiB (94.44%)
>>>>>>>>>>>>>        /dev/sdh       34.00GiB
>>>>>>>>>>>>>        /dev/sdf       32.00GiB
>>>>>>>>>>>>>        /dev/sdg       32.00GiB
>>>>>>>>>>>>>
>>>>>>>>>>>>>     System,RAID1: Size:32.00MiB, Used:2.20MiB (6.87%)
>>>>>>>>>>>>>        /dev/sdf       32.00MiB
>>>>>>>>>>>>>        /dev/sdg       32.00MiB
>>>>>>>>>>>>>
>>>>>>>>>>>>>     Unallocated:
>>>>>>>>>>>>>        /dev/sdh        2.81TiB
>>>>>>>>>>>>>        /dev/sdf        2.81TiB
>>>>>>>>>>>>>        /dev/sdg        2.81TiB
>>>>>>>>>>>>>        /dev/sdd        1.03TiB
>>>>>>>>>>>>>        /dev/sdc        1.03TiB
>>>>>>>>>>>>>        /dev/sde        1.03TiB
>>>>>>>>>>>>>
>>>>>>>>>>>>>     On Fri, May 8, 2020 at 1:47 AM Qu Wenruo <quwenruo.btrf=
s@gmx.com
>>>>>>>>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>     >
>>>>>>>>>>>>>     >
>>>>>>>>>>>>>     >
>>>>>>>>>>>>>     > On 2020/5/8 =E4=B8=8B=E5=8D=881:12, Tyler Richmond wr=
ote:
>>>>>>>>>>>>>     > > If this is saying there's no extra space for metada=
ta, is that why
>>>>>>>>>>>>>     > > adding more files often makes the system hang for 3=
0-90s? Is there
>>>>>>>>>>>>>     > > anything I should do about that?
>>>>>>>>>>>>>     >
>>>>>>>>>>>>>     > I'm not sure about the hang though.
>>>>>>>>>>>>>     >
>>>>>>>>>>>>>     > It would be nice to give more info to diagnosis.
>>>>>>>>>>>>>     > The output of 'btrfs fi usage' is useful for space us=
age problem.
>>>>>>>>>>>>>     >
>>>>>>>>>>>>>     > But the common idea is, to keep at 1~2 Gi unallocated=
 (not avaiable
>>>>>>>>>>>>>     > space in vanilla df command) space for btrfs.
>>>>>>>>>>>>>     >
>>>>>>>>>>>>>     > Thanks,
>>>>>>>>>>>>>     > Qu
>>>>>>>>>>>>>     >
>>>>>>>>>>>>>     > >
>>>>>>>>>>>>>     > > Thank you so much for all of your help. I love how =
flexible BTRFS is
>>>>>>>>>>>>>     > > but when things go wrong it's very hard for me to t=
roubleshoot.
>>>>>>>>>>>>>     > >
>>>>>>>>>>>>>     > > On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenruo.=
btrfs@gmx.com
>>>>>>>>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>     > >> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmon=
d wrote:
>>>>>>>>>>>>>     > >>> Something went wrong:
>>>>>>>>>>>>>     > >>>
>>>>>>>>>>>>>     > >>> Reinitialize checksum tree
>>>>>>>>>>>>>     > >>> Unable to find block group for 0
>>>>>>>>>>>>>     > >>> Unable to find block group for 0
>>>>>>>>>>>>>     > >>> Unable to find block group for 0
>>>>>>>>>>>>>     > >>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, v=
alue 1
>>>>>>>>>>>>>     > >>> btrfs(+0x6dd94)[0x55a933af7d94]
>>>>>>>>>>>>>     > >>> btrfs(+0x71b94)[0x55a933afbb94]
>>>>>>>>>>>>>     > >>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
>>>>>>>>>>>>>     > >>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09=
]
>>>>>>>>>>>>>     > >>> btrfs(+0x360b2)[0x55a933ac00b2]
>>>>>>>>>>>>>     > >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
>>>>>>>>>>>>>     > >>> btrfs(main+0x98)[0x55a933a9fe88]
>>>>>>>>>>>>>     > >>>
>>>>>>>>>>>>>     /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)=
[0x7f263ed550b3]
>>>>>>>>>>>>>     > >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
>>>>>>>>>>>>>     > >>> Aborted
>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>     > >> This means no space for extra metadata...
>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>     > >> Anyway the csum tree problem shouldn't be a big th=
ing, you
>>>>>>>>>>>>>     could leave
>>>>>>>>>>>>>     > >> it and call it a day.
>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>     > >> BTW, as long as btrfs check reports no extra probl=
em for the inode
>>>>>>>>>>>>>     > >> generation, it should be pretty safe to use the fs=
=2E
>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>     > >> Thanks,
>>>>>>>>>>>>>     > >> Qu
>>>>>>>>>>>>>     > >>>
>>>>>>>>>>>>>     > >>> I just noticed I have btrfs-progs 5.6 installed a=
nd 5.6.1 is
>>>>>>>>>>>>>     > >>> available. I'll let that try overnight?
>>>>>>>>>>>>>     > >>>
>>>>>>>>>>>>>     > >>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo
>>>>>>>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>=
> wrote:
>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>     > >>>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richm=
ond wrote:
>>>>>>>>>>>>>     > >>>>> Thank you for helping. The end result of the sc=
an was:
>>>>>>>>>>>>>     > >>>>>
>>>>>>>>>>>>>     > >>>>>
>>>>>>>>>>>>>     > >>>>> [1/7] checking root items
>>>>>>>>>>>>>     > >>>>> [2/7] checking extents
>>>>>>>>>>>>>     > >>>>> [3/7] checking free space cache
>>>>>>>>>>>>>     > >>>>> [4/7] checking fs roots
>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>     > >>>> Good news is, your fs is still mostly fine.
>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>     > >>>>> [5/7] checking only csums items (without verify=
ing data)
>>>>>>>>>>>>>     > >>>>> there are no extents for csum range 0-69632
>>>>>>>>>>>>>     > >>>>> csum exists for 0-69632 but there is no extent =
record
>>>>>>>>>>>>>     > >>>>> ...
>>>>>>>>>>>>>     > >>>>> ...
>>>>>>>>>>>>>     > >>>>> there are no extents for csum range 946692096-9=
46827264
>>>>>>>>>>>>>     > >>>>> csum exists for 946692096-946827264 but there i=
s no extent
>>>>>>>>>>>>>     record
>>>>>>>>>>>>>     > >>>>> there are no extents for csum range 946831360-9=
47912704
>>>>>>>>>>>>>     > >>>>> csum exists for 946831360-947912704 but there i=
s no extent
>>>>>>>>>>>>>     record
>>>>>>>>>>>>>     > >>>>> ERROR: errors found in csum tree
>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>     > >>>> Only extent tree is corrupted.
>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>     > >>>> Normally btrfs check --init-csum-tree should be =
able to
>>>>>>>>>>>>>     handle it.
>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>     > >>>> But still, please be sure you're using the lates=
t btrfs-progs
>>>>>>>>>>>>>     to fix it.
>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>     > >>>> Thanks,
>>>>>>>>>>>>>     > >>>> Qu
>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>     > >>>>> [6/7] checking root refs
>>>>>>>>>>>>>     > >>>>> [7/7] checking quota groups skipped (not enable=
d on this FS)
>>>>>>>>>>>>>     > >>>>> found 44157956026368 bytes used, error(s) found=

>>>>>>>>>>>>>     > >>>>> total csum bytes: 42038602716
>>>>>>>>>>>>>     > >>>>> total tree bytes: 49688616960
>>>>>>>>>>>>>     > >>>>> total fs tree bytes: 1256427520
>>>>>>>>>>>>>     > >>>>> total extent tree bytes: 1709105152
>>>>>>>>>>>>>     > >>>>> btree space waste bytes: 3172727316
>>>>>>>>>>>>>     > >>>>> file data blocks allocated: 261625653436416
>>>>>>>>>>>>>     > >>>>>  referenced 47477768499200
>>>>>>>>>>>>>     > >>>>>
>>>>>>>>>>>>>     > >>>>> What do I need to do to fix all of this?
>>>>>>>>>>>>>     > >>>>>
>>>>>>>>>>>>>     > >>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo
>>>>>>>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>=
> wrote:
>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>     > >>>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Rich=
mond wrote:
>>>>>>>>>>>>>     > >>>>>>> Well, the repair doesn't look terribly succes=
sful.
>>>>>>>>>>>>>     > >>>>>>>
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22=
5049956061184
>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>     > >>>>>>>                                             c=
hild level=3D4
>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>     > >>>>>> This means there are more problems, not only t=
he hash name
>>>>>>>>>>>>>     mismatch.
>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>     > >>>>>> This means the fs is already corrupted, the na=
me hash is
>>>>>>>>>>>>>     just one
>>>>>>>>>>>>>     > >>>>>> unrelated symptom.
>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>     > >>>>>> The only good news is, btrfs-progs abort the t=
ransaction,
>>>>>>>>>>>>>     thus no
>>>>>>>>>>>>>     > >>>>>> further damage to the fs.
>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>     > >>>>>> Please run a plain btrfs-check to show what's =
the problem
>>>>>>>>>>>>>     first.
>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>     > >>>>>> Thanks,
>>>>>>>>>>>>>     > >>>>>> Qu
>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22=
5049956061184
>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>     > >>>>>>>                                             c=
hild level=3D4
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22=
5049956061184
>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>     > >>>>>>>                                             c=
hild level=3D4
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22=
5049956061184
>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>     > >>>>>>>                                             c=
hild level=3D4
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22=
5049956061184
>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>     > >>>>>>>                                             c=
hild level=3D4
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22=
5049956061184
>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>     > >>>>>>>                                             c=
hild level=3D4
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22=
5049956061184
>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>     > >>>>>>>                                             c=
hild level=3D4
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22=
5049956061184
>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>     > >>>>>>>                                             c=
hild level=3D4
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22=
5049956061184
>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>     > >>>>>>>                                             c=
hild level=3D4
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22=
5049956061184
>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>     > >>>>>>>                                             c=
hild level=3D4
>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807034=
88 wanted
>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22=
5049956061184
>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>     > >>>>>>>                                             c=
hild level=3D4
>>>>>>>>>>>>>     > >>>>>>> ERROR: failed to zero log tree: -17
>>>>>>>>>>>>>     > >>>>>>> ERROR: attempt to start transaction over alre=
ady running one
>>>>>>>>>>>>>     > >>>>>>> WARNING: reserved space leaked, flag=3D0x4 by=
tes_reserved=3D4096
>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066086400 len=
 4096
>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066086400 len=
 4096
>>>>>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start=

>>>>>>>>>>>>>     225049066086400 len 4096
>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066094592 len=
 4096
>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066094592 len=
 4096
>>>>>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start=

>>>>>>>>>>>>>     225049066094592 len 4096
>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066102784 len=
 4096
>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066102784 len=
 4096
>>>>>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start=

>>>>>>>>>>>>>     225049066102784 len 4096
>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066131456 len=
 4096
>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066131456 len=
 4096
>>>>>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start=

>>>>>>>>>>>>>     225049066131456 len 4096
>>>>>>>>>>>>>     > >>>>>>>
>>>>>>>>>>>>>     > >>>>>>> What is going on?
>>>>>>>>>>>>>     > >>>>>>>
>>>>>>>>>>>>>     > >>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond=

>>>>>>>>>>>>>     <t.d.richmond@gmail.com <mailto:t.d.richmond@gmail.com>=
> wrote:
>>>>>>>>>>>>>     > >>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>> Chris, I had used the correct mountpoint in =
the command.
>>>>>>>>>>>>>     I just edited
>>>>>>>>>>>>>     > >>>>>>>> it in the email to be /mountpoint for consis=
tency.
>>>>>>>>>>>>>     > >>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>> Qu, I'll try the repair. Fingers crossed!
>>>>>>>>>>>>>     > >>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo
>>>>>>>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>=
> wrote:
>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler R=
ichmond wrote:
>>>>>>>>>>>>>     > >>>>>>>>>> Hello,
>>>>>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>>> I looked up this error and it basically sa=
ys ask a
>>>>>>>>>>>>>     developer to
>>>>>>>>>>>>>     > >>>>>>>>>> determine if it's a false error or not. I =
just started
>>>>>>>>>>>>>     getting some
>>>>>>>>>>>>>     > >>>>>>>>>> slow response times, and looked at the dme=
sg log to
>>>>>>>>>>>>>     find a ton of
>>>>>>>>>>>>>     > >>>>>>>>>> these errors.
>>>>>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>>> [192088.446299] BTRFS critical (device sdh=
): corrupt
>>>>>>>>>>>>>     leaf: root=3D5
>>>>>>>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D131=
1670, invalid inode
>>>>>>>>>>>>>     generation:
>>>>>>>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 687582=
7]
>>>>>>>>>>>>>     > >>>>>>>>>> [192088.449823] BTRFS error (device sdh):
>>>>>>>>>>>>>     block=3D203510940835840 read
>>>>>>>>>>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>>>>>>>>>>     > >>>>>>>>>> [192088.459238] BTRFS critical (device sdh=
): corrupt
>>>>>>>>>>>>>     leaf: root=3D5
>>>>>>>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D131=
1670, invalid inode
>>>>>>>>>>>>>     generation:
>>>>>>>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 687582=
7]
>>>>>>>>>>>>>     > >>>>>>>>>> [192088.462773] BTRFS error (device sdh):
>>>>>>>>>>>>>     block=3D203510940835840 read
>>>>>>>>>>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>>>>>>>>>>     > >>>>>>>>>> [192088.464711] BTRFS critical (device sdh=
): corrupt
>>>>>>>>>>>>>     leaf: root=3D5
>>>>>>>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D131=
1670, invalid inode
>>>>>>>>>>>>>     generation:
>>>>>>>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 687582=
7]
>>>>>>>>>>>>>     > >>>>>>>>>> [192088.468457] BTRFS error (device sdh):
>>>>>>>>>>>>>     block=3D203510940835840 read
>>>>>>>>>>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>>> btrfs device stats, however, doesn't show =
any errors.
>>>>>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>>> Is there anything I should do about this, =
or should I
>>>>>>>>>>>>>     just continue
>>>>>>>>>>>>>     > >>>>>>>>>> using my array as normal?
>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>> This is caused by older kernel underflow in=
ode generation.
>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>> Latest btrfs-progs can fix it, using btrfs =
check --repair.
>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>> Or you can go safer, by manually locating t=
he inode
>>>>>>>>>>>>>     using its inode
>>>>>>>>>>>>>     > >>>>>>>>> number (1311670), and copy it to some new l=
ocation using
>>>>>>>>>>>>>     previous
>>>>>>>>>>>>>     > >>>>>>>>> working kernel, then delete the old file, c=
opy the new
>>>>>>>>>>>>>     one back to fix it.
>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>> Thanks,
>>>>>>>>>>>>>     > >>>>>>>>> Qu
>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>>> Thank you!
>>>>>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>     >
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>


--kvazZnHoBpbB5biUsuvVXVTIK6Impq8C5--

--JTOG0ZHifhiPqcTL7EkXSalGKu8KbC9q5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9FFGgACgkQwj2R86El
/qiqrggAo8s6aqjNbPUpP+Xryt/Q3KHsLB1JKGrW+ZLfkPMC9nzKmm378+gBsxon
shMzimSSbYxoGXGm+DV3w2uq6ebNIBWEEfDTPOye1k46Cp/xTGW47IMYylXs0SL/
EzXEp1sGZCEh241Q+USNTcuMWTft1/5ADgZKaMAbvG8BiKfRH+5QWH4JMMLEQyow
NRpfQLxuXNWwl78XUn15tgP6bf5TDvIpu+9L+kwmKkMrkVeZdn9NM7TfH/MZL68d
VZzOFtYCqSxjtqcXBSq7y6EZw27oemxbtWIVGMdy93xNJ/C1h5jGzLBZB2p3af37
stIBWZusfAuxRIEPUvC5V67Uew0IRg==
=9YQp
-----END PGP SIGNATURE-----

--JTOG0ZHifhiPqcTL7EkXSalGKu8KbC9q5--
