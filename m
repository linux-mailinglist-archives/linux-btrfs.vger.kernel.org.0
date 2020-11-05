Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1615A2A77E3
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 08:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgKEHT6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 02:19:58 -0500
Received: from mout.gmx.net ([212.227.17.20]:36591 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgKEHT6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 02:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604560789;
        bh=4yLuQePq88C3Kr7AVorZFp/ljFKJOJbQGflTUJemusg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Sv55vvnoN0casTWl08c2VkFdUBTC4EqA9asHH5BO0SF2REszSOG58uq4tsNkLwz9i
         JJob0ES5g6uV4ds2lAKrR0xYkKm25SrQ/IOLo5PdTLsvWj14qIW2saNrii3TMvgqFI
         e1ve6v8DMWo8JuiUxzlJ3Wv1+buBUG44K1mYUmqM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGNC-1ksmfK2JXC-00JKLV; Thu, 05
 Nov 2020 08:19:49 +0100
Subject: Re: Fwd: Read time tree block corruption detected
To:     Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
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
 <e2c8eaaf-6adb-374f-4005-a1edcbcb8f79@gmx.com>
 <CAJheHN1U4j1KsD96oFuCVwP+6RVP6V6oAZP-aGOTtfm7tDL3BA@mail.gmail.com>
 <CAJheHN3pTj-6dOQZVKqA_r38F+WVNrjVO6-Z_hFeq96uTNK5zw@mail.gmail.com>
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
Message-ID: <1f26ff53-f7c7-c497-b69f-8a3e5d8ce959@gmx.com>
Date:   Thu, 5 Nov 2020 15:19:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJheHN3pTj-6dOQZVKqA_r38F+WVNrjVO6-Z_hFeq96uTNK5zw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MNzUniWUG4wlW9A9VUvxhNLcwGEmEV5g2"
X-Provags-ID: V03:K1:Ij20r7lF2rOI/C2D6aWrgNgVtDrS4ul6IAGJqmhBA3tIhq6AgA1
 mcWuzNtheGjAfVrtHGB+HMWAlMM28SqrTiNNxezKmz9t2uiB84X9e7cOOYbSyP8bNjjiSLd
 m3VyPg4OvE6b0yyrvB3IAIj46cDQ4KkczIBskRPZCcDLzFMowpWo+eoKI9aQnNft9WhzSak
 kSbWprtMdtVh1dE3wAs8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y0Ceik1jGBg=:OO5HEmYsQrxeWt58ed03D9
 ZOqyK1zrPn4LpY1r9ulSnhgdk39pyWMFio5e4kmfKsFkXXVsS4HV0zXUhX9ot1Agogb5cSGUN
 xCL3fFk5CodDM0fwLpfzzXBBrzce50I3zLbG2THHwvA7kLXNuYA/LUR27OLPvdv4lzAcppvFQ
 ddek5A6/qPq8Y54sPPwXe9F1/ysOHQqxY8tqGnaaZ8PbWcvjFcc61MyJEq5maMgAb92BrOtC5
 AaM8lFrF/jciljs299I2BNsKwDKSjf2e5UkSu+tivWOkViefUVLg1M4TM+5vaUptULRb/zQhQ
 HnL1BTQdJ7tRN3AJRWihCgaZYwQUt0BaToz3gEZeczbtta2HLFFIspdhMy3rdrs4m/ZIcczka
 TgP6dOdmuZo+V9W+4fDAwRVzJWN9AoCEhSNKZRw3o3DtDR4WXQyI0KG2yL5n7Ra2p3Oi3PowR
 LprtW8RAy6Jnna2sANjRHyLs+uHh+zuLRzpNTvhKnGlt5miTCI8uizTOslOBiI02o6ibQJhMl
 Gvhh0n0wXSIvYM16bWMbMa11Yc88UFa6RirCO8BRZbKJPHKhcwKaiwlz0m5TrqUJYWS/ATLpf
 +2VOAFKrTJvr6rfDlCuXw9WNAIYipSC0I6+0OMr0YVkkGzsXkD00zELZ5NuEExajyhJZ+wn1U
 NjJmiSQp4LMqiqVX+HgDub15EPXm7lc00/whNbOLBLS8gfTCwMeSmBcjhWadDGRAdrRaSiiMT
 7MgySJ9gSPC8XPV90GCR6T7K1hiohCJHw0WQfhZwkDzv5l49jhKb8zhnf3m6VMU5KqdKYvWWc
 mVN9bRVsWpPfD8GmPk0Plk6aUg3CTcUlyAHPhQFD1ymGoyRmrQ8FxQ/4T8PMLVrUn1q29QQx9
 s7LBqo7zrzFAACRmW41w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MNzUniWUG4wlW9A9VUvxhNLcwGEmEV5g2
Content-Type: multipart/mixed; boundary="L4WIFUMbE8hBbQFTBxPhqCZo8BJU5IX6Z"

--L4WIFUMbE8hBbQFTBxPhqCZo8BJU5IX6Z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/5 =E4=B8=8B=E5=8D=883:01, Tyler Richmond wrote:
> Qu,
>=20
> I'm wondering, was a fix for this ever implemented?

Already implemented the --repair ability in latest btrfs-progs.

> I recently added a
> new drive to expand the array, and during the rebalance it dropped
> itself back to a read only filesystem. I suspect it's related to the
> issues discussed earlier in this thread. Is there anything I can do to
> complete the balance? The error that caused it to drop to read only is
> here: https://pastebin.com/GGYVMaiG

Yep, the same cause.

Thanks,
Qu
>=20
> Thanks!
>=20
>=20
> On Tue, Aug 25, 2020 at 9:43 AM Tyler Richmond <t.d.richmond@gmail.com>=
 wrote:
>>
>> Great, glad we got somewhere! I'll look forward to the fix!
>>
>> On Tue, Aug 25, 2020 at 9:38 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>
>>>
>>>
>>> On 2020/8/25 =E4=B8=8B=E5=8D=889:30, Tyler Richmond wrote:
>>>> Qu,
>>>>
>>>> The dump of the block is:
>>>>
>>>> https://pastebin.com/ran85JJv
>>>>
>>>> I've also completed the btrfs-image, but it's almost 50gb. What's th=
e
>>>> best way to get it to you? Also, does it work with -ss or are the
>>>> original filenames important?
>>>
>>> 50G is too big for me to even receive.
>>>
>>> But your dump shows the problem!
>>>
>>> It's not inode generation, but inode transid, which would affect send=
=2E
>>>
>>> This is not even checked in btrfs-progs, thus no wonder why it doesn'=
t
>>> detect them.
>>>
>>> And copy-pasted kernel message shares the same "generation" word, not=

>>> using proper transid to show the problem.
>>>
>>> Your dump really saved the day!
>>>
>>> The fix for kernel and btrfs-progs would come in next few days.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Thanks again!
>>>>
>>>>
>>>> On Tue, Aug 25, 2020 at 2:37 AM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>>>>>
>>>>>
>>>>>
>>>>> On 2020/8/25 =E4=B8=8B=E5=8D=881:25, Tyler Richmond wrote:
>>>>>> Qu,
>>>>>>
>>>>>> Yes, it's btrfs-progs 5.7. Here is the result of the lowmem check:=

>>>>>>
>>>>>> https://pastebin.com/8Tzx23EX
>>>>>
>>>>> That doesn't detect any inode generation problem at all, which is n=
ot a
>>>>> good sign.
>>>>>
>>>>> Would you also pvode the dump for the offending block?
>>>>>
>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode gene=
ration:
>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>
>>>>> For this case, would you please provide the tree dump of "203510940=
835840" ?
>>>>>
>>>>> # btrfs ins dump-tree -b 203510940835840 <device>
>>>>>
>>>>> And, since btrfs-image can't dump with regular extent tree, the "-w=
"
>>>>> dump would also help.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>> On Mon, Aug 24, 2020 at 4:26 AM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2020/8/24 =E4=B8=8A=E5=8D=8810:47, Tyler Richmond wrote:
>>>>>>>> Qu,
>>>>>>>>
>>>>>>>> Finally finished another repair and captured the output.
>>>>>>>>
>>>>>>>> https://pastebin.com/ffcbwvd8
>>>>>>>>
>>>>>>>> Does that show you what you need? Or should I still do one in lo=
wmem mode?
>>>>>>>
>>>>>>> Lowmem mode (no need for --repair) is recommended since original =
mode
>>>>>>> doesn't detect the inode generation problem.
>>>>>>>
>>>>>>> And it's already btrfs-progs v5.7 right?
>>>>>>>
>>>>>>> THanks,
>>>>>>> Qu
>>>>>>>>
>>>>>>>> Thanks for your help!
>>>>>>>>
>>>>>>>> On Sun, Aug 23, 2020 at 12:28 AM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=8810:49, Tyler Richmond wrote:
>>>>>>>>>> Well, I can guarantee that I didn't create this fs before 2015=
 (just
>>>>>>>>>> checked the order confirmation from when I bought the server),=
 but I
>>>>>>>>>> may have just used whatever was in the Ubuntu package manager =
at the
>>>>>>>>>> time. So maybe I don't have a v0 ref?
>>>>>>>>>
>>>>>>>>> Then btrfs-image shouldn't report that.
>>>>>>>>>
>>>>>>>>> There is an item smaller than any valid btrfs item, normally it=
 means
>>>>>>>>> it's a v0 ref.
>>>>>>>>> If not, then it could be a bigger problem.
>>>>>>>>>
>>>>>>>>> Could you please provide the full btrfs-check output?
>>>>>>>>> Also, if possible result from "btrfs check --mode=3Dlowmem" wou=
ld also help.
>>>>>>>>>
>>>>>>>>> Also, if you really go "--repair", then the full output would a=
lso be
>>>>>>>>> needed to determine what's going wrong.
>>>>>>>>> There is a report about "btrfs check --repair" didn't repair th=
e inode
>>>>>>>>> generation, if that's the case we must have a bug then.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>>
>>>>>>>>>> On Sat, Aug 22, 2020 at 10:31 PM Qu Wenruo <quwenruo.btrfs@gmx=
=2Ecom> wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:51, Qu Wenruo wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:15, Tyler Richmond wrote:
>>>>>>>>>>>>> Is my best bet just to downgrade the kernel and then try to=
 delete the
>>>>>>>>>>>>> broken files? Or should I rebuild from scratch? Just don't =
know
>>>>>>>>>>>>> whether it's worth the time to try and figure this out or i=
f the
>>>>>>>>>>>>> problems stem from the FS being too old and it's beyond try=
ing to
>>>>>>>>>>>>> repair.
>>>>>>>>>>>>
>>>>>>>>>>>> All invalid inode generations, should be able to be repaired=
 by latest
>>>>>>>>>>>> btrfs-check.
>>>>>>>>>>>>
>>>>>>>>>>>> If not, please provide the btrfs-image dump for us to determ=
ine what's
>>>>>>>>>>>> going wrong.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> Qu
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Tue, Aug 18, 2020 at 8:18 AM Tyler Richmond <t.d.richmon=
d@gmail.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I didn't check dmesg during the btrfs check, but that was =
the only
>>>>>>>>>>>>>> output during the rm -f before it was forced readonly. I j=
ust checked
>>>>>>>>>>>>>> dmesg for inode generation values, and there are a lot of =
them.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> https://pastebin.com/stZdN0ta
>>>>>>>>>>>>>> The dmesg output had 990 lines containing inode generation=
=2E
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> However, these were at least later. I tried to do a btrfs =
balance
>>>>>>>>>>>>>> -mconvert raid1 and it failed with an I/O error. That is p=
robably what
>>>>>>>>>>>>>> generated these specific errors, but maybe they were also =
happening
>>>>>>>>>>>>>> during the btrfs repair.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The FS is ~45TB, but the btrfs-image -c9 failed anway with=
:
>>>>>>>>>>>>>> ERROR: either extent tree is corrupted or deprecated exten=
t ref format
>>>>>>>>>>>>>> ERROR: create failed: -5
>>>>>>>>>>>
>>>>>>>>>>> Oh, forgot this part.
>>>>>>>>>>>
>>>>>>>>>>> This means you have v0 ref?!
>>>>>>>>>>>
>>>>>>>>>>> Then the fs is too old, no progs/kernel support after all.
>>>>>>>>>>>
>>>>>>>>>>> In that case, please rollback to the last working kernel and =
copy your data.
>>>>>>>>>>>
>>>>>>>>>>> In fact, that v0 ref should only be in the code base for seve=
ral weeks
>>>>>>>>>>> before 2010, thus it's really too old.
>>>>>>>>>>>
>>>>>>>>>>> The good news is, with tree-checker, we should never experien=
ce such
>>>>>>>>>>> too-old-to-be-usable problem (at least I hope so)
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Qu
>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo <quwenruo.btrfs@=
gmx.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 2020/8/18 =E4=B8=8A=E5=8D=8811:35, Tyler Richmond wrot=
e:
>>>>>>>>>>>>>>>> Qu,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Sorry to resurrect this thread, but I just ran into some=
thing that I
>>>>>>>>>>>>>>>> can't really just ignore. I've found a folder that is fu=
ll of files
>>>>>>>>>>>>>>>> which I guess have been broken somehow. I found a backup=
 and restored
>>>>>>>>>>>>>>>> them, but I want to delete this folder of broken files. =
But whenever I
>>>>>>>>>>>>>>>> try, the fs is forced into readonly mode again. I just f=
inished another
>>>>>>>>>>>>>>>> btrfs check --repair but it didn't fix the problem.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> https://pastebin.com/eTV3s3fr
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Is that the full output?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> No inode generation bugs?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>  I'm already on btrfs-progs v5.7. Any new suggestions?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Strange.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The detection and repair should have been merged into v5.=
5.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> If your fs is small enough, would you please provide the =
"btrfs-image
>>>>>>>>>>>>>>> -c9" dump?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> It would contain the filenames and directories names, but=
 doesn't
>>>>>>>>>>>>>>> contain file contents.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond <t.d.richm=
ond@gmail.com
>>>>>>>>>>>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>     5.6.1 also failed the same way. Here's the usage out=
put. This is the
>>>>>>>>>>>>>>>>     part where you see I've been using RAID5 haha
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>     WARNING: RAID56 detected, not implemented
>>>>>>>>>>>>>>>>     Overall:
>>>>>>>>>>>>>>>>         Device size:                  60.03TiB
>>>>>>>>>>>>>>>>         Device allocated:             98.06GiB
>>>>>>>>>>>>>>>>         Device unallocated:           59.93TiB
>>>>>>>>>>>>>>>>         Device missing:                  0.00B
>>>>>>>>>>>>>>>>         Used:                         92.56GiB
>>>>>>>>>>>>>>>>         Free (estimated):                0.00B      (min=
: 8.00EiB)
>>>>>>>>>>>>>>>>         Data ratio:                       0.00
>>>>>>>>>>>>>>>>         Metadata ratio:                   2.00
>>>>>>>>>>>>>>>>         Global reserve:              512.00MiB      (use=
d: 0.00B)
>>>>>>>>>>>>>>>>         Multiple profiles:                  no
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>     Data,RAID5: Size:40.35TiB, Used:40.12TiB (99.42%)
>>>>>>>>>>>>>>>>        /dev/sdh        8.07TiB
>>>>>>>>>>>>>>>>        /dev/sdf        8.07TiB
>>>>>>>>>>>>>>>>        /dev/sdg        8.07TiB
>>>>>>>>>>>>>>>>        /dev/sdd        8.07TiB
>>>>>>>>>>>>>>>>        /dev/sdc        8.07TiB
>>>>>>>>>>>>>>>>        /dev/sde        8.07TiB
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>     Metadata,RAID1: Size:49.00GiB, Used:46.28GiB (94.44%=
)
>>>>>>>>>>>>>>>>        /dev/sdh       34.00GiB
>>>>>>>>>>>>>>>>        /dev/sdf       32.00GiB
>>>>>>>>>>>>>>>>        /dev/sdg       32.00GiB
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>     System,RAID1: Size:32.00MiB, Used:2.20MiB (6.87%)
>>>>>>>>>>>>>>>>        /dev/sdf       32.00MiB
>>>>>>>>>>>>>>>>        /dev/sdg       32.00MiB
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>     Unallocated:
>>>>>>>>>>>>>>>>        /dev/sdh        2.81TiB
>>>>>>>>>>>>>>>>        /dev/sdf        2.81TiB
>>>>>>>>>>>>>>>>        /dev/sdg        2.81TiB
>>>>>>>>>>>>>>>>        /dev/sdd        1.03TiB
>>>>>>>>>>>>>>>>        /dev/sdc        1.03TiB
>>>>>>>>>>>>>>>>        /dev/sde        1.03TiB
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>     On Fri, May 8, 2020 at 1:47 AM Qu Wenruo <quwenruo.b=
trfs@gmx.com
>>>>>>>>>>>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>     >
>>>>>>>>>>>>>>>>     >
>>>>>>>>>>>>>>>>     >
>>>>>>>>>>>>>>>>     > On 2020/5/8 =E4=B8=8B=E5=8D=881:12, Tyler Richmond=
 wrote:
>>>>>>>>>>>>>>>>     > > If this is saying there's no extra space for met=
adata, is that why
>>>>>>>>>>>>>>>>     > > adding more files often makes the system hang fo=
r 30-90s? Is there
>>>>>>>>>>>>>>>>     > > anything I should do about that?
>>>>>>>>>>>>>>>>     >
>>>>>>>>>>>>>>>>     > I'm not sure about the hang though.
>>>>>>>>>>>>>>>>     >
>>>>>>>>>>>>>>>>     > It would be nice to give more info to diagnosis.
>>>>>>>>>>>>>>>>     > The output of 'btrfs fi usage' is useful for space=
 usage problem.
>>>>>>>>>>>>>>>>     >
>>>>>>>>>>>>>>>>     > But the common idea is, to keep at 1~2 Gi unalloca=
ted (not avaiable
>>>>>>>>>>>>>>>>     > space in vanilla df command) space for btrfs.
>>>>>>>>>>>>>>>>     >
>>>>>>>>>>>>>>>>     > Thanks,
>>>>>>>>>>>>>>>>     > Qu
>>>>>>>>>>>>>>>>     >
>>>>>>>>>>>>>>>>     > >
>>>>>>>>>>>>>>>>     > > Thank you so much for all of your help. I love h=
ow flexible BTRFS is
>>>>>>>>>>>>>>>>     > > but when things go wrong it's very hard for me t=
o troubleshoot.
>>>>>>>>>>>>>>>>     > >
>>>>>>>>>>>>>>>>     > > On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenr=
uo.btrfs@gmx.com
>>>>>>>>>>>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>>>>     > >> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Rich=
mond wrote:
>>>>>>>>>>>>>>>>     > >>> Something went wrong:
>>>>>>>>>>>>>>>>     > >>>
>>>>>>>>>>>>>>>>     > >>> Reinitialize checksum tree
>>>>>>>>>>>>>>>>     > >>> Unable to find block group for 0
>>>>>>>>>>>>>>>>     > >>> Unable to find block group for 0
>>>>>>>>>>>>>>>>     > >>> Unable to find block group for 0
>>>>>>>>>>>>>>>>     > >>> ctree.c:2272: split_leaf: BUG_ON `1` triggered=
, value 1
>>>>>>>>>>>>>>>>     > >>> btrfs(+0x6dd94)[0x55a933af7d94]
>>>>>>>>>>>>>>>>     > >>> btrfs(+0x71b94)[0x55a933afbb94]
>>>>>>>>>>>>>>>>     > >>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8=
]
>>>>>>>>>>>>>>>>     > >>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19=
d09]
>>>>>>>>>>>>>>>>     > >>> btrfs(+0x360b2)[0x55a933ac00b2]
>>>>>>>>>>>>>>>>     > >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
>>>>>>>>>>>>>>>>     > >>> btrfs(main+0x98)[0x55a933a9fe88]
>>>>>>>>>>>>>>>>     > >>>
>>>>>>>>>>>>>>>>     /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x=
f3)[0x7f263ed550b3]
>>>>>>>>>>>>>>>>     > >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
>>>>>>>>>>>>>>>>     > >>> Aborted
>>>>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>>>>     > >> This means no space for extra metadata...
>>>>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>>>>     > >> Anyway the csum tree problem shouldn't be a big=
 thing, you
>>>>>>>>>>>>>>>>     could leave
>>>>>>>>>>>>>>>>     > >> it and call it a day.
>>>>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>>>>     > >> BTW, as long as btrfs check reports no extra pr=
oblem for the inode
>>>>>>>>>>>>>>>>     > >> generation, it should be pretty safe to use the=
 fs.
>>>>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>>>>     > >> Thanks,
>>>>>>>>>>>>>>>>     > >> Qu
>>>>>>>>>>>>>>>>     > >>>
>>>>>>>>>>>>>>>>     > >>> I just noticed I have btrfs-progs 5.6 installe=
d and 5.6.1 is
>>>>>>>>>>>>>>>>     > >>> available. I'll let that try overnight?
>>>>>>>>>>>>>>>>     > >>>
>>>>>>>>>>>>>>>>     > >>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo
>>>>>>>>>>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.c=
om>> wrote:
>>>>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>>>>     > >>>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Ri=
chmond wrote:
>>>>>>>>>>>>>>>>     > >>>>> Thank you for helping. The end result of the=
 scan was:
>>>>>>>>>>>>>>>>     > >>>>>
>>>>>>>>>>>>>>>>     > >>>>>
>>>>>>>>>>>>>>>>     > >>>>> [1/7] checking root items
>>>>>>>>>>>>>>>>     > >>>>> [2/7] checking extents
>>>>>>>>>>>>>>>>     > >>>>> [3/7] checking free space cache
>>>>>>>>>>>>>>>>     > >>>>> [4/7] checking fs roots
>>>>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>>>>     > >>>> Good news is, your fs is still mostly fine.
>>>>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>>>>     > >>>>> [5/7] checking only csums items (without ver=
ifying data)
>>>>>>>>>>>>>>>>     > >>>>> there are no extents for csum range 0-69632
>>>>>>>>>>>>>>>>     > >>>>> csum exists for 0-69632 but there is no exte=
nt record
>>>>>>>>>>>>>>>>     > >>>>> ...
>>>>>>>>>>>>>>>>     > >>>>> ...
>>>>>>>>>>>>>>>>     > >>>>> there are no extents for csum range 94669209=
6-946827264
>>>>>>>>>>>>>>>>     > >>>>> csum exists for 946692096-946827264 but ther=
e is no extent
>>>>>>>>>>>>>>>>     record
>>>>>>>>>>>>>>>>     > >>>>> there are no extents for csum range 94683136=
0-947912704
>>>>>>>>>>>>>>>>     > >>>>> csum exists for 946831360-947912704 but ther=
e is no extent
>>>>>>>>>>>>>>>>     record
>>>>>>>>>>>>>>>>     > >>>>> ERROR: errors found in csum tree
>>>>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>>>>     > >>>> Only extent tree is corrupted.
>>>>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>>>>     > >>>> Normally btrfs check --init-csum-tree should =
be able to
>>>>>>>>>>>>>>>>     handle it.
>>>>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>>>>     > >>>> But still, please be sure you're using the la=
test btrfs-progs
>>>>>>>>>>>>>>>>     to fix it.
>>>>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>>>>     > >>>> Thanks,
>>>>>>>>>>>>>>>>     > >>>> Qu
>>>>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>>>>     > >>>>> [6/7] checking root refs
>>>>>>>>>>>>>>>>     > >>>>> [7/7] checking quota groups skipped (not ena=
bled on this FS)
>>>>>>>>>>>>>>>>     > >>>>> found 44157956026368 bytes used, error(s) fo=
und
>>>>>>>>>>>>>>>>     > >>>>> total csum bytes: 42038602716
>>>>>>>>>>>>>>>>     > >>>>> total tree bytes: 49688616960
>>>>>>>>>>>>>>>>     > >>>>> total fs tree bytes: 1256427520
>>>>>>>>>>>>>>>>     > >>>>> total extent tree bytes: 1709105152
>>>>>>>>>>>>>>>>     > >>>>> btree space waste bytes: 3172727316
>>>>>>>>>>>>>>>>     > >>>>> file data blocks allocated: 261625653436416
>>>>>>>>>>>>>>>>     > >>>>>  referenced 47477768499200
>>>>>>>>>>>>>>>>     > >>>>>
>>>>>>>>>>>>>>>>     > >>>>> What do I need to do to fix all of this?
>>>>>>>>>>>>>>>>     > >>>>>
>>>>>>>>>>>>>>>>     > >>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo
>>>>>>>>>>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.c=
om>> wrote:
>>>>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>>>>     > >>>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler R=
ichmond wrote:
>>>>>>>>>>>>>>>>     > >>>>>>> Well, the repair doesn't look terribly suc=
cessful.
>>>>>>>>>>>>>>>>     > >>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
>>>>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>>>>     > >>>>>>>                                           =
  child level=3D4
>>>>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>>>>     > >>>>>> This means there are more problems, not onl=
y the hash name
>>>>>>>>>>>>>>>>     mismatch.
>>>>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>>>>     > >>>>>> This means the fs is already corrupted, the=
 name hash is
>>>>>>>>>>>>>>>>     just one
>>>>>>>>>>>>>>>>     > >>>>>> unrelated symptom.
>>>>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>>>>     > >>>>>> The only good news is, btrfs-progs abort th=
e transaction,
>>>>>>>>>>>>>>>>     thus no
>>>>>>>>>>>>>>>>     > >>>>>> further damage to the fs.
>>>>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>>>>     > >>>>>> Please run a plain btrfs-check to show what=
's the problem
>>>>>>>>>>>>>>>>     first.
>>>>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>>>>     > >>>>>> Thanks,
>>>>>>>>>>>>>>>>     > >>>>>> Qu
>>>>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
>>>>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>>>>     > >>>>>>>                                           =
  child level=3D4
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
>>>>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>>>>     > >>>>>>>                                           =
  child level=3D4
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
>>>>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>>>>     > >>>>>>>                                           =
  child level=3D4
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
>>>>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>>>>     > >>>>>>>                                           =
  child level=3D4
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
>>>>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>>>>     > >>>>>>>                                           =
  child level=3D4
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
>>>>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>>>>     > >>>>>>>                                           =
  child level=3D4
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
>>>>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>>>>     > >>>>>>>                                           =
  child level=3D4
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
>>>>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>>>>     > >>>>>>>                                           =
  child level=3D4
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
>>>>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>>>>     > >>>>>>>                                           =
  child level=3D4
>>>>>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 2186208807=
03488 wanted
>>>>>>>>>>>>>>>>     6875841 found 6876224
>>>>>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
>>>>>>>>>>>>>>>>     item=3D84
>>>>>>>>>>>>>>>>     > >>>>>>> parent level=3D1
>>>>>>>>>>>>>>>>     > >>>>>>>                                           =
  child level=3D4
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: failed to zero log tree: -17
>>>>>>>>>>>>>>>>     > >>>>>>> ERROR: attempt to start transaction over a=
lready running one
>>>>>>>>>>>>>>>>     > >>>>>>> WARNING: reserved space leaked, flag=3D0x4=
 bytes_reserved=3D4096
>>>>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066086400 =
len 4096
>>>>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066086400 =
len 4096
>>>>>>>>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): st=
art
>>>>>>>>>>>>>>>>     225049066086400 len 4096
>>>>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066094592 =
len 4096
>>>>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066094592 =
len 4096
>>>>>>>>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): st=
art
>>>>>>>>>>>>>>>>     225049066094592 len 4096
>>>>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066102784 =
len 4096
>>>>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066102784 =
len 4096
>>>>>>>>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): st=
art
>>>>>>>>>>>>>>>>     225049066102784 len 4096
>>>>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066131456 =
len 4096
>>>>>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066131456 =
len 4096
>>>>>>>>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): st=
art
>>>>>>>>>>>>>>>>     225049066131456 len 4096
>>>>>>>>>>>>>>>>     > >>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>> What is going on?
>>>>>>>>>>>>>>>>     > >>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richm=
ond
>>>>>>>>>>>>>>>>     <t.d.richmond@gmail.com <mailto:t.d.richmond@gmail.c=
om>> wrote:
>>>>>>>>>>>>>>>>     > >>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>> Chris, I had used the correct mountpoint =
in the command.
>>>>>>>>>>>>>>>>     I just edited
>>>>>>>>>>>>>>>>     > >>>>>>>> it in the email to be /mountpoint for con=
sistency.
>>>>>>>>>>>>>>>>     > >>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>> Qu, I'll try the repair. Fingers crossed!=

>>>>>>>>>>>>>>>>     > >>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo
>>>>>>>>>>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.c=
om>> wrote:
>>>>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyle=
r Richmond wrote:
>>>>>>>>>>>>>>>>     > >>>>>>>>>> Hello,
>>>>>>>>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>>> I looked up this error and it basically=
 says ask a
>>>>>>>>>>>>>>>>     developer to
>>>>>>>>>>>>>>>>     > >>>>>>>>>> determine if it's a false error or not.=
 I just started
>>>>>>>>>>>>>>>>     getting some
>>>>>>>>>>>>>>>>     > >>>>>>>>>> slow response times, and looked at the =
dmesg log to
>>>>>>>>>>>>>>>>     find a ton of
>>>>>>>>>>>>>>>>     > >>>>>>>>>> these errors.
>>>>>>>>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>>> [192088.446299] BTRFS critical (device =
sdh): corrupt
>>>>>>>>>>>>>>>>     leaf: root=3D5
>>>>>>>>>>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D=
1311670, invalid inode
>>>>>>>>>>>>>>>>     generation:
>>>>>>>>>>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 687=
5827]
>>>>>>>>>>>>>>>>     > >>>>>>>>>> [192088.449823] BTRFS error (device sdh=
):
>>>>>>>>>>>>>>>>     block=3D203510940835840 read
>>>>>>>>>>>>>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>>>>>>>>>>>>>     > >>>>>>>>>> [192088.459238] BTRFS critical (device =
sdh): corrupt
>>>>>>>>>>>>>>>>     leaf: root=3D5
>>>>>>>>>>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D=
1311670, invalid inode
>>>>>>>>>>>>>>>>     generation:
>>>>>>>>>>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 687=
5827]
>>>>>>>>>>>>>>>>     > >>>>>>>>>> [192088.462773] BTRFS error (device sdh=
):
>>>>>>>>>>>>>>>>     block=3D203510940835840 read
>>>>>>>>>>>>>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>>>>>>>>>>>>>     > >>>>>>>>>> [192088.464711] BTRFS critical (device =
sdh): corrupt
>>>>>>>>>>>>>>>>     leaf: root=3D5
>>>>>>>>>>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D=
1311670, invalid inode
>>>>>>>>>>>>>>>>     generation:
>>>>>>>>>>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 687=
5827]
>>>>>>>>>>>>>>>>     > >>>>>>>>>> [192088.468457] BTRFS error (device sdh=
):
>>>>>>>>>>>>>>>>     block=3D203510940835840 read
>>>>>>>>>>>>>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>>>>>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>>> btrfs device stats, however, doesn't sh=
ow any errors.
>>>>>>>>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>>> Is there anything I should do about thi=
s, or should I
>>>>>>>>>>>>>>>>     just continue
>>>>>>>>>>>>>>>>     > >>>>>>>>>> using my array as normal?
>>>>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>> This is caused by older kernel underflow=
 inode generation.
>>>>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>> Latest btrfs-progs can fix it, using btr=
fs check --repair.
>>>>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>> Or you can go safer, by manually locatin=
g the inode
>>>>>>>>>>>>>>>>     using its inode
>>>>>>>>>>>>>>>>     > >>>>>>>>> number (1311670), and copy it to some ne=
w location using
>>>>>>>>>>>>>>>>     previous
>>>>>>>>>>>>>>>>     > >>>>>>>>> working kernel, then delete the old file=
, copy the new
>>>>>>>>>>>>>>>>     one back to fix it.
>>>>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>     > >>>>>>>>> Qu
>>>>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>>> Thank you!
>>>>>>>>>>>>>>>>     > >>>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>>>>
>>>>>>>>>>>>>>>>     > >>>>>>
>>>>>>>>>>>>>>>>     > >>>>
>>>>>>>>>>>>>>>>     > >>
>>>>>>>>>>>>>>>>     >
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>
>>>


--L4WIFUMbE8hBbQFTBxPhqCZo8BJU5IX6Z--

--MNzUniWUG4wlW9A9VUvxhNLcwGEmEV5g2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+jp5EACgkQwj2R86El
/qhcGgf/ZrS+Lw69esTtA3iUBSW0XmmxwH4B+5sS86uwL4UBi3Lna2GUtJhRpcfX
jZtCIS7XPNWLfFqyj6Am2ESERkL0F7sSogngKLw0KSJvKhmX1EFJyFLFfKGvHLt8
VjISV3SYHA+8Xe3C68ZIjfefHe/DfcUqoG4EX5FpcmoWcNw7GdENo/o6OFfn9x4Z
Cr33Fm/svbuv6J5MYVH+ttNsWwCdWRz9TwEq9W1dtcOIUMUPQ86xenOqJ2zA4JvP
j9nPivLTGfAHOwDGWlPo3ZincqbcT61gDv1dTv+eggW1MCY+jbO+D+bbmCYmf38n
1tPOppu9hh+ClpUSIi20boMOWrPRMA==
=pAge
-----END PGP SIGNATURE-----

--MNzUniWUG4wlW9A9VUvxhNLcwGEmEV5g2--
