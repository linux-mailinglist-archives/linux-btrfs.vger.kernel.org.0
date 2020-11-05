Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577A42A8ACA
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 00:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbgKEXc0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 18:32:26 -0500
Received: from mout.gmx.net ([212.227.15.18]:48725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEXc0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 18:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604619137;
        bh=zzTAAhZPVu4xrf3e9XKBL4F31BqMmDJ0FQLhRay1NSg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eo7cFYhGgzrMJgJE70HhXzFvQ4fUvtzricJy68gD/KAt2iYwbqgwzW7NemGhNy+rq
         kaJmOsX1IyxzzEW3mfyMyZEhryMcn5FcMLLj4e4fa7mpe5Lmj8PwuqtPq1mIFzIf8C
         nzNPBy6RXTVqu3j2mUmcrhKfbpXVlsaVArBnjM24=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLiCo-1ksU753EH2-00HcSh; Fri, 06
 Nov 2020 00:32:16 +0100
Subject: Re: Fwd: Read time tree block corruption detected
To:     Ferry Toth <fntoth@gmail.com>,
        Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
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
 <1f26ff53-f7c7-c497-b69f-8a3e5d8ce959@gmx.com>
 <b7383762-4a86-fdb9-12f3-89470808f4e6@gmail.com>
 <0d6a0602-897a-b170-f1a2-007cff1f23fb@gmx.com>
 <134e61b5-ecf7-bc1a-e16b-c95b14876e6e@gmail.com>
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
Message-ID: <5b757c2b-6dbf-cbec-6c66-e4b14897f53c@gmx.com>
Date:   Fri, 6 Nov 2020 07:32:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <134e61b5-ecf7-bc1a-e16b-c95b14876e6e@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lOqhX0WzOwk0J5k52Lt92d9dRJpRTAz0w"
X-Provags-ID: V03:K1:hS+MXfh71+V2C/gjXz2wfgt0wkSVj0/mnaNILTBeLYMy4yvSMr9
 1Vb/iKS5G4u6RmwczETrHy4ss+rJ4fbu9X8Coffn8+TzQ8z6FkeuwiTnZg0L1kuAdMnF6r5
 QVLyANkaP93BkJAPpQIegBOjZLMJkoNSvZMRKmVcP55LS8f/TUSVAbTda53HIppsHqm6sr4
 l432Ao5xinLmW2Yp8Ml6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d0Och7xLCr0=:NlK/inYRHt7fFgtjADNoec
 49fGzaAoNqimqz/Djh1EqeYWuJuiD4io+sUH6bBlZVQiprczoJHhChhQZcn5VqYZu2gh6PNEQ
 a3ijukw32/mHxngzdf4Dh70bPKRzdoXm8D1UsTOr4kmNRQjd57V4//NDg2Vg3BpvavI0WjTF/
 GUc1ftXzXvZx5idBLBlUM419tpMy2YCGSil9Wuuei+iU82sBw/1we5ccMIWottl1QWULWtxYs
 FaDVZ+vxQIdeasHOXgU0hkZBNILRjLjyz6i75d89id4xsLKWS8/ta8mYsny7OKSu6wpG96ZYT
 5KqEThr/AkVc/Qqmi1brWaejp+Gfd/Nubwdi/rIkt41b3cjrKGjtv8d1hfbW3TeQc0xSzdED7
 kzyW0N6uw782dfsIvqtc17dbeFGFoZYTxkKopdf/23Xyw/y6exALzs3hWMrC2hS8gEJfKZ9wE
 DWIah5EmRPPtRB2NGFcFxP4Ra8tuQ5AFvchlp0srTBnkf3B8qKSBzTszN7bKRgWHdtBa0nSgP
 Dr+Stvjv6o8qvQZVnFlAfovEVyd8JJgdjaw35Tau9Fx3iEQxO4VsHDaiL31Acl79bZdvmxM88
 V2qP/OZvcU9v5aCM9Uv00zHKu4LieFvrAkoO3momqZ7ldsWBu6fhkj0tJJO0YWWh1MuXJ8sjf
 1fBYynLqRjvc7qhsxHOnXtOamOMmExD2sLidjwJTCxVbCMRJAvVqD7rdTUYZ+CX0+dnqTR7eE
 OLWo/Sq3ELge9mLzdYMLH4+ibD07eFfsTSKFtN3vXpKcBGVQOeRLxjNTu/oP4MZewWE4vV95D
 B4Bd3CIy7YX73N6wZq0YJaGnCFlhIjCydKpYlyQimjFtKrwUW4WBVJy+ImqQ2Tt3ihj4FctvD
 4iojyI3MH3zC0cF8432w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lOqhX0WzOwk0J5k52Lt92d9dRJpRTAz0w
Content-Type: multipart/mixed; boundary="8LeC4Db0I3HcPfxXNKw9UI3J2oh3uJxVx"

--8LeC4Db0I3HcPfxXNKw9UI3J2oh3uJxVx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/6 =E4=B8=8A=E5=8D=887:12, Ferry Toth wrote:
> Hi,
>=20
> Op 06-11-2020 om 00:00 schreef Qu Wenruo:
>>
>> On 2020/11/6 =E4=B8=8A=E5=8D=884:08, Ferry Toth wrote:
>>> I am in a similar spot, during updating my distro (Kubuntu), I am una=
ble
>>> to update a certain package. I know which file it is:
>>>
>>> ~$ ls -l /usr/share/doc/libatk1.0-data
>>> ls: kan geen toegang krijgen tot '/usr/share/doc/libatk1.0-data':
>>> Invoer-/uitvoerfout
>>>
>>> This creates the following in journal:
>>>
>>> kernel: BTRFS critical (device sda2): corrupt leaf: root=3D294
>>> block=3D1169152675840 slot=3D1 ino=3D915987, invalid inode generation=
: has
>>> 18446744073709551492 expect [0, 5851353]
>>> kernel: BTRFS error (device sda2): block=3D1169152675840 read time tr=
ee
>>> block corruption detected
>>>
>>> Now, the problem: this file is on my rootfs, which is mounted. apt
>>> (distribution updated) installed all packages but can't continue
>>> configuring, because libatk is a dependancy. I can't delete the file
>>> because of the I/O error. And btrfs check complains (I tried running =
RO)
>>> because the file system is mounted.
>>>
>>> But, on the sunny side, the file system is not RO.
>>>
>>> Is there any way to forcefully remove the file? Or do you have a
>>> recommendation how to proceed?
>> Newer kernel will reject to even read the item, thus will not be able =
to
>> remove it.
> That's already the case. (input / output error)
>> I guess you have to use some distro ISO to fix the fs.
> And then? btrfs check --repair the disk offline?

Yep.

You would want the latest btrfs-progs though.

THanks,
Qu
>> Thanks,
>> Qu
>>
>>> Linux =3D 5.6.0-1032-oem
>>>
>>> Thanks,
>>> Ferry
>>>
>>> Op 05-11-2020 om 08:19 schreef Qu Wenruo:
>>>>
>>>> On 2020/11/5 =E4=B8=8B=E5=8D=883:01, Tyler Richmond wrote:
>>>>> Qu,
>>>>>
>>>>> I'm wondering, was a fix for this ever implemented?
>>>> Already implemented the --repair ability in latest btrfs-progs.
>>>>
>>>>> I recently added a
>>>>> new drive to expand the array, and during the rebalance it dropped
>>>>> itself back to a read only filesystem. I suspect it's related to th=
e
>>>>> issues discussed earlier in this thread. Is there anything I can do=
 to
>>>>> complete the balance? The error that caused it to drop to read only=
 is
>>>>> here: https://pastebin.com/GGYVMaiG
>>>> Yep, the same cause.
>>>>
>>>> Thanks,
>>>> Qu
>>>>> Thanks!
>>>>>
>>>>>
>>>>> On Tue, Aug 25, 2020 at 9:43 AM Tyler Richmond
>>>>> <t.d.richmond@gmail.com> wrote:
>>>>>> Great, glad we got somewhere! I'll look forward to the fix!
>>>>>>
>>>>>> On Tue, Aug 25, 2020 at 9:38 AM Qu Wenruo <quwenruo.btrfs@gmx.com>=

>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2020/8/25 =E4=B8=8B=E5=8D=889:30, Tyler Richmond wrote:
>>>>>>>> Qu,
>>>>>>>>
>>>>>>>> The dump of the block is:
>>>>>>>>
>>>>>>>> https://pastebin.com/ran85JJv
>>>>>>>>
>>>>>>>> I've also completed the btrfs-image, but it's almost 50gb.
>>>>>>>> What's the
>>>>>>>> best way to get it to you? Also, does it work with -ss or are th=
e
>>>>>>>> original filenames important?
>>>>>>> 50G is too big for me to even receive.
>>>>>>>
>>>>>>> But your dump shows the problem!
>>>>>>>
>>>>>>> It's not inode generation, but inode transid, which would affect
>>>>>>> send.
>>>>>>>
>>>>>>> This is not even checked in btrfs-progs, thus no wonder why it
>>>>>>> doesn't
>>>>>>> detect them.
>>>>>>>
>>>>>>> And copy-pasted kernel message shares the same "generation" word,=

>>>>>>> not
>>>>>>> using proper transid to show the problem.
>>>>>>>
>>>>>>> Your dump really saved the day!
>>>>>>>
>>>>>>> The fix for kernel and btrfs-progs would come in next few days.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>> Thanks again!
>>>>>>>>
>>>>>>>>
>>>>>>>> On Tue, Aug 25, 2020 at 2:37 AM Qu Wenruo <quwenruo.btrfs@gmx.co=
m>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2020/8/25 =E4=B8=8B=E5=8D=881:25, Tyler Richmond wrote:
>>>>>>>>>> Qu,
>>>>>>>>>>
>>>>>>>>>> Yes, it's btrfs-progs 5.7. Here is the result of the lowmem
>>>>>>>>>> check:
>>>>>>>>>>
>>>>>>>>>> https://pastebin.com/8Tzx23EX
>>>>>>>>> That doesn't detect any inode generation problem at all, which =
is
>>>>>>>>> not a
>>>>>>>>> good sign.
>>>>>>>>>
>>>>>>>>> Would you also pvode the dump for the offending block?
>>>>>>>>>
>>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode
>>>>>>>>>> generation:
>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>>>
>>>>>>>>> For this case, would you please provide the tree dump of
>>>>>>>>> "203510940835840" ?
>>>>>>>>>
>>>>>>>>> # btrfs ins dump-tree -b 203510940835840 <device>
>>>>>>>>>
>>>>>>>>> And, since btrfs-image can't dump with regular extent tree, the=

>>>>>>>>> "-w"
>>>>>>>>> dump would also help.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Thanks!
>>>>>>>>>>
>>>>>>>>>> On Mon, Aug 24, 2020 at 4:26 AM Qu Wenruo
>>>>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 2020/8/24 =E4=B8=8A=E5=8D=8810:47, Tyler Richmond wrote:
>>>>>>>>>>>> Qu,
>>>>>>>>>>>>
>>>>>>>>>>>> Finally finished another repair and captured the output.
>>>>>>>>>>>>
>>>>>>>>>>>> https://pastebin.com/ffcbwvd8
>>>>>>>>>>>>
>>>>>>>>>>>> Does that show you what you need? Or should I still do one i=
n
>>>>>>>>>>>> lowmem mode?
>>>>>>>>>>> Lowmem mode (no need for --repair) is recommended since
>>>>>>>>>>> original mode
>>>>>>>>>>> doesn't detect the inode generation problem.
>>>>>>>>>>>
>>>>>>>>>>> And it's already btrfs-progs v5.7 right?
>>>>>>>>>>>
>>>>>>>>>>> THanks,
>>>>>>>>>>> Qu
>>>>>>>>>>>> Thanks for your help!
>>>>>>>>>>>>
>>>>>>>>>>>> On Sun, Aug 23, 2020 at 12:28 AM Qu Wenruo
>>>>>>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=8810:49, Tyler Richmond wrote:=

>>>>>>>>>>>>>> Well, I can guarantee that I didn't create this fs before
>>>>>>>>>>>>>> 2015 (just
>>>>>>>>>>>>>> checked the order confirmation from when I bought the
>>>>>>>>>>>>>> server), but I
>>>>>>>>>>>>>> may have just used whatever was in the Ubuntu package
>>>>>>>>>>>>>> manager at the
>>>>>>>>>>>>>> time. So maybe I don't have a v0 ref?
>>>>>>>>>>>>> Then btrfs-image shouldn't report that.
>>>>>>>>>>>>>
>>>>>>>>>>>>> There is an item smaller than any valid btrfs item, normall=
y
>>>>>>>>>>>>> it means
>>>>>>>>>>>>> it's a v0 ref.
>>>>>>>>>>>>> If not, then it could be a bigger problem.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Could you please provide the full btrfs-check output?
>>>>>>>>>>>>> Also, if possible result from "btrfs check --mode=3Dlowmem"=

>>>>>>>>>>>>> would also help.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Also, if you really go "--repair", then the full output wou=
ld
>>>>>>>>>>>>> also be
>>>>>>>>>>>>> needed to determine what's going wrong.
>>>>>>>>>>>>> There is a report about "btrfs check --repair" didn't repai=
r
>>>>>>>>>>>>> the inode
>>>>>>>>>>>>> generation, if that's the case we must have a bug then.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>> On Sat, Aug 22, 2020 at 10:31 PM Qu Wenruo
>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:51, Qu Wenruo wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:15, Tyler Richmond wrot=
e:
>>>>>>>>>>>>>>>>> Is my best bet just to downgrade the kernel and then tr=
y
>>>>>>>>>>>>>>>>> to delete the
>>>>>>>>>>>>>>>>> broken files? Or should I rebuild from scratch? Just
>>>>>>>>>>>>>>>>> don't know
>>>>>>>>>>>>>>>>> whether it's worth the time to try and figure this out =
or
>>>>>>>>>>>>>>>>> if the
>>>>>>>>>>>>>>>>> problems stem from the FS being too old and it's beyond=

>>>>>>>>>>>>>>>>> trying to
>>>>>>>>>>>>>>>>> repair.
>>>>>>>>>>>>>>>> All invalid inode generations, should be able to be
>>>>>>>>>>>>>>>> repaired by latest
>>>>>>>>>>>>>>>> btrfs-check.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> If not, please provide the btrfs-image dump for us to
>>>>>>>>>>>>>>>> determine what's
>>>>>>>>>>>>>>>> going wrong.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>> On Tue, Aug 18, 2020 at 8:18 AM Tyler Richmond
>>>>>>>>>>>>>>>>> <t.d.richmond@gmail.com> wrote:
>>>>>>>>>>>>>>>>>> I didn't check dmesg during the btrfs check, but that
>>>>>>>>>>>>>>>>>> was the only
>>>>>>>>>>>>>>>>>> output during the rm -f before it was forced readonly.=
 I
>>>>>>>>>>>>>>>>>> just checked
>>>>>>>>>>>>>>>>>> dmesg for inode generation values, and there are a lot=

>>>>>>>>>>>>>>>>>> of them.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> https://pastebin.com/stZdN0ta
>>>>>>>>>>>>>>>>>> The dmesg output had 990 lines containing inode
>>>>>>>>>>>>>>>>>> generation.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> However, these were at least later. I tried to do a
>>>>>>>>>>>>>>>>>> btrfs balance
>>>>>>>>>>>>>>>>>> -mconvert raid1 and it failed with an I/O error. That =
is
>>>>>>>>>>>>>>>>>> probably what
>>>>>>>>>>>>>>>>>> generated these specific errors, but maybe they were
>>>>>>>>>>>>>>>>>> also happening
>>>>>>>>>>>>>>>>>> during the btrfs repair.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> The FS is ~45TB, but the btrfs-image -c9 failed anway
>>>>>>>>>>>>>>>>>> with:
>>>>>>>>>>>>>>>>>> ERROR: either extent tree is corrupted or deprecated
>>>>>>>>>>>>>>>>>> extent ref format
>>>>>>>>>>>>>>>>>> ERROR: create failed: -5
>>>>>>>>>>>>>>> Oh, forgot this part.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> This means you have v0 ref?!
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Then the fs is too old, no progs/kernel support after all=
=2E
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> In that case, please rollback to the last working kernel
>>>>>>>>>>>>>>> and copy your data.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> In fact, that v0 ref should only be in the code base for
>>>>>>>>>>>>>>> several weeks
>>>>>>>>>>>>>>> before 2010, thus it's really too old.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The good news is, with tree-checker, we should never
>>>>>>>>>>>>>>> experience such
>>>>>>>>>>>>>>> too-old-to-be-usable problem (at least I hope so)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo
>>>>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> On 2020/8/18 =E4=B8=8A=E5=8D=8811:35, Tyler Richmond =
wrote:
>>>>>>>>>>>>>>>>>>>> Qu,
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Sorry to resurrect this thread, but I just ran into
>>>>>>>>>>>>>>>>>>>> something that I
>>>>>>>>>>>>>>>>>>>> can't really just ignore. I've found a folder that i=
s
>>>>>>>>>>>>>>>>>>>> full of files
>>>>>>>>>>>>>>>>>>>> which I guess have been broken somehow. I found a
>>>>>>>>>>>>>>>>>>>> backup and restored
>>>>>>>>>>>>>>>>>>>> them, but I want to delete this folder of broken
>>>>>>>>>>>>>>>>>>>> files. But whenever I
>>>>>>>>>>>>>>>>>>>> try, the fs is forced into readonly mode again. I ju=
st
>>>>>>>>>>>>>>>>>>>> finished another
>>>>>>>>>>>>>>>>>>>> btrfs check --repair but it didn't fix the problem.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> https://pastebin.com/eTV3s3fr
>>>>>>>>>>>>>>>>>>> Is that the full output?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> No inode generation bugs?
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0 I'm already on btrfs-progs v5.7. Any ne=
w
>>>>>>>>>>>>>>>>>>>> suggestions?
>>>>>>>>>>>>>>>>>>> Strange.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> The detection and repair should have been merged into=

>>>>>>>>>>>>>>>>>>> v5.5.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> If your fs is small enough, would you please provide
>>>>>>>>>>>>>>>>>>> the "btrfs-image
>>>>>>>>>>>>>>>>>>> -c9" dump?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> It would contain the filenames and directories names,=

>>>>>>>>>>>>>>>>>>> but doesn't
>>>>>>>>>>>>>>>>>>> contain file contents.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>>>>> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond
>>>>>>>>>>>>>>>>>>>> <t.d.richmond@gmail.com
>>>>>>>>>>>>>>>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.6.1 also failed the=
 same way. Here's the usage
>>>>>>>>>>>>>>>>>>>> output. This is the
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part where you see I'=
ve been using RAID5 haha
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARNING: RAID56 detec=
ted, not implemented
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Overall:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 60.03TiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 98.06GiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 59.93TiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 92.56GiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>>>>>>>>>>>>>>>>>>>> (min: 8.00EiB)
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.0=
0
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 512.00MiB
>>>>>>>>>>>>>>>>>>>> (used: 0.00B)
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Data,RAID5: Size:40.3=
5TiB, Used:40.12TiB (99.42%)
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.07TiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.07TiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.07TiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.07TiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.07TiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sde=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.07TiB
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Metadata,RAID1: Size:=
49.00GiB, Used:46.28GiB
>>>>>>>>>>>>>>>>>>>> (94.44%)
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 34.00GiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00GiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00GiB
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 System,RAID1: Size:32=
=2E00MiB, Used:2.20MiB (6.87%)
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Unallocated:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.81TiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.81TiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.81TiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.03TiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.03TiB
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /de=
v/sde=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.03TiB
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 On Fri, May 8, 2020 a=
t 1:47 AM Qu Wenruo
>>>>>>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <mailto:quwenruo.btrf=
s@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > On 2020/5/8 =E4=B8=8B=
=E5=8D=881:12, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > > If this is saying=
 there's no extra space for
>>>>>>>>>>>>>>>>>>>> metadata, is that why
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > > adding more files=
 often makes the system hang
>>>>>>>>>>>>>>>>>>>> for 30-90s? Is there
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > > anything I should=
 do about that?
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > I'm not sure about =
the hang though.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > It would be nice to=
 give more info to
>>>>>>>>>>>>>>>>>>>> diagnosis.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > The output of 'btrf=
s fi usage' is useful for
>>>>>>>>>>>>>>>>>>>> space usage problem.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > But the common idea=
 is, to keep at 1~2 Gi
>>>>>>>>>>>>>>>>>>>> unallocated (not avaiable
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > space in vanilla df=
 command) space for btrfs.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Thanks,
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Qu
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > > Thank you so much=
 for all of your help. I
>>>>>>>>>>>>>>>>>>>> love how flexible BTRFS is
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > > but when things g=
o wrong it's very hard for
>>>>>>>>>>>>>>>>>>>> me to troubleshoot.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > > On Fri, May 8, 20=
20 at 1:07 AM Qu Wenruo
>>>>>>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <mailto:quwenruo.btrf=
s@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> On 2020/5/8 =E4=B8=
=8B=E5=8D=8812:23, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> Something went =
wrong:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> Reinitialize ch=
ecksum tree
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> Unable to find =
block group for 0
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> Unable to find =
block group for 0
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> Unable to find =
block group for 0
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> ctree.c:2272: s=
plit_leaf: BUG_ON `1`
>>>>>>>>>>>>>>>>>>>> triggered, value 1
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> btrfs(+0x6dd94)=
[0x55a933af7d94]
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> btrfs(+0x71b94)=
[0x55a933afbb94]
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>
>>>>>>>>>>>>>>>>>>>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>
>>>>>>>>>>>>>>>>>>>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> btrfs(+0x360b2)=
[0x55a933ac00b2]
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> btrfs(+0x46a3e)=
[0x55a933ad0a3e]
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> btrfs(main+0x98=
)[0x55a933a9fe88]
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0
>>>>>>>>>>>>>>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x=
f3)[0x7f263ed550b3]
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> btrfs(_start+0x=
2e)[0x55a933a9fa0e]
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> Aborted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> This means no sp=
ace for extra metadata...
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> Anyway the csum =
tree problem shouldn't be a
>>>>>>>>>>>>>>>>>>>> big thing, you
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 could leave
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> it and call it a=
 day.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> BTW, as long as =
btrfs check reports no extra
>>>>>>>>>>>>>>>>>>>> problem for the inode
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> generation, it s=
hould be pretty safe to use
>>>>>>>>>>>>>>>>>>>> the fs.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> Thanks,
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> Qu
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> I just noticed =
I have btrfs-progs 5.6
>>>>>>>>>>>>>>>>>>>> installed and 5.6.1 is
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> available. I'll=
 let that try overnight?
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> On Thu, May 7, =
2020 at 8:11 PM Qu Wenruo
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <quwenruo.btrfs@gmx.c=
om
>>>>>>>>>>>>>>>>>>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> On 2020/5/7 =E4=
=B8=8B=E5=8D=8811:52, Tyler Richmond
>>>>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> Thank you for=
 helping. The end result of
>>>>>>>>>>>>>>>>>>>> the scan was:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [1/7] checkin=
g root items
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [2/7] checkin=
g extents
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [3/7] checkin=
g free space cache
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [4/7] checkin=
g fs roots
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> Good news is, =
your fs is still mostly
>>>>>>>>>>>>>>>>>>>> fine.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [5/7] checkin=
g only csums items (without
>>>>>>>>>>>>>>>>>>>> verifying data)
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> there are no =
extents for csum range
>>>>>>>>>>>>>>>>>>>> 0-69632
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> csum exists f=
or 0-69632 but there is no
>>>>>>>>>>>>>>>>>>>> extent record
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> ...
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> ...
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> there are no =
extents for csum range
>>>>>>>>>>>>>>>>>>>> 946692096-946827264
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> csum exists f=
or 946692096-946827264 but
>>>>>>>>>>>>>>>>>>>> there is no extent
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 record
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> there are no =
extents for csum range
>>>>>>>>>>>>>>>>>>>> 946831360-947912704
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> csum exists f=
or 946831360-947912704 but
>>>>>>>>>>>>>>>>>>>> there is no extent
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 record
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> ERROR: errors=
 found in csum tree
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> Only extent tr=
ee is corrupted.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> Normally btrfs=
 check --init-csum-tree
>>>>>>>>>>>>>>>>>>>> should be able to
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle it.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> But still, ple=
ase be sure you're using the
>>>>>>>>>>>>>>>>>>>> latest btrfs-progs
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to fix it.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> Thanks,
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> Qu
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [6/7] checkin=
g root refs
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [7/7] checkin=
g quota groups skipped (not
>>>>>>>>>>>>>>>>>>>> enabled on this FS)
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> found 4415795=
6026368 bytes used, error(s)
>>>>>>>>>>>>>>>>>>>> found
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> total csum by=
tes: 42038602716
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> total tree by=
tes: 49688616960
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> total fs tree=
 bytes: 1256427520
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> total extent =
tree bytes: 1709105152
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> btree space w=
aste bytes: 3172727316
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> file data blo=
cks allocated:
>>>>>>>>>>>>>>>>>>>> 261625653436416
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>=C2=A0 referen=
ced 47477768499200
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> What do I nee=
d to do to fix all of this?
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> On Thu, May 7=
, 2020 at 1:52 AM Qu Wenruo
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <quwenruo.btrfs@gmx.c=
om
>>>>>>>>>>>>>>>>>>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> On 2020/5/7 =
=E4=B8=8B=E5=8D=881:43, Tyler Richmond
>>>>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Well, the r=
epair doesn't look terribly
>>>>>>>>>>>>>>>>>>>> successful.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignoring tr=
ansid failure
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: chil=
d eb corrupted: parent
>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent leve=
l=3D1
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> This means t=
here are more problems, not
>>>>>>>>>>>>>>>>>>>> only the hash name
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mismatch.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> This means t=
he fs is already corrupted,
>>>>>>>>>>>>>>>>>>>> the name hash is
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 just one
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> unrelated sy=
mptom.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> The only goo=
d news is, btrfs-progs abort
>>>>>>>>>>>>>>>>>>>> the transaction,
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thus no
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> further dama=
ge to the fs.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> Please run a=
 plain btrfs-check to show
>>>>>>>>>>>>>>>>>>>> what's the problem
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> Thanks,
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> Qu
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignoring tr=
ansid failure
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: chil=
d eb corrupted: parent
>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent leve=
l=3D1
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignoring tr=
ansid failure
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: chil=
d eb corrupted: parent
>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent leve=
l=3D1
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignoring tr=
ansid failure
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: chil=
d eb corrupted: parent
>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent leve=
l=3D1
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignoring tr=
ansid failure
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: chil=
d eb corrupted: parent
>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent leve=
l=3D1
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignoring tr=
ansid failure
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: chil=
d eb corrupted: parent
>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent leve=
l=3D1
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignoring tr=
ansid failure
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: chil=
d eb corrupted: parent
>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent leve=
l=3D1
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignoring tr=
ansid failure
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: chil=
d eb corrupted: parent
>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent leve=
l=3D1
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignoring tr=
ansid failure
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: chil=
d eb corrupted: parent
>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent leve=
l=3D1
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignoring tr=
ansid failure
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: chil=
d eb corrupted: parent
>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent leve=
l=3D1
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent tran=
sid verify failed on
>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6876224=

>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignoring tr=
ansid failure
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: chil=
d eb corrupted: parent
>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> parent leve=
l=3D1
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: fail=
ed to zero log tree: -17
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR: atte=
mpt to start transaction
>>>>>>>>>>>>>>>>>>>> over already running one
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> WARNING: re=
served space leaked,
>>>>>>>>>>>>>>>>>>>> flag=3D0x4 bytes_reserved=3D4096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> extent buff=
er leak: start
>>>>>>>>>>>>>>>>>>>> 225049066086400 len 4096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> extent buff=
er leak: start
>>>>>>>>>>>>>>>>>>>> 225049066086400 len 4096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> WARNING: di=
rty eb leak (aborted trans):
>>>>>>>>>>>>>>>>>>>> start
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 225049066086400 len 4=
096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> extent buff=
er leak: start
>>>>>>>>>>>>>>>>>>>> 225049066094592 len 4096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> extent buff=
er leak: start
>>>>>>>>>>>>>>>>>>>> 225049066094592 len 4096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> WARNING: di=
rty eb leak (aborted trans):
>>>>>>>>>>>>>>>>>>>> start
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 225049066094592 len 4=
096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> extent buff=
er leak: start
>>>>>>>>>>>>>>>>>>>> 225049066102784 len 4096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> extent buff=
er leak: start
>>>>>>>>>>>>>>>>>>>> 225049066102784 len 4096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> WARNING: di=
rty eb leak (aborted trans):
>>>>>>>>>>>>>>>>>>>> start
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 225049066102784 len 4=
096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> extent buff=
er leak: start
>>>>>>>>>>>>>>>>>>>> 225049066131456 len 4096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> extent buff=
er leak: start
>>>>>>>>>>>>>>>>>>>> 225049066131456 len 4096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> WARNING: di=
rty eb leak (aborted trans):
>>>>>>>>>>>>>>>>>>>> start
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 225049066131456 len 4=
096
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> What is goi=
ng on?
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> On Wed, May=
 6, 2020 at 9:30 PM Tyler
>>>>>>>>>>>>>>>>>>>> Richmond
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <t.d.richmond@gmail.c=
om
>>>>>>>>>>>>>>>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>> Chris, I h=
ad used the correct
>>>>>>>>>>>>>>>>>>>> mountpoint in the command.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I just edited
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>> it in the =
email to be /mountpoint for
>>>>>>>>>>>>>>>>>>>> consistency.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>> Qu, I'll t=
ry the repair. Fingers
>>>>>>>>>>>>>>>>>>>> crossed!
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>> On Wed, Ma=
y 6, 2020 at 9:13 PM Qu
>>>>>>>>>>>>>>>>>>>> Wenruo
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <quwenruo.btrfs@gmx.c=
om
>>>>>>>>>>>>>>>>>>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> On 2020/5=
/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond
>>>>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> Hello,
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> I looked=
 up this error and it
>>>>>>>>>>>>>>>>>>>> basically says ask a
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 developer to
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> determin=
e if it's a false error or
>>>>>>>>>>>>>>>>>>>> not. I just started
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 getting some
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> slow res=
ponse times, and looked at
>>>>>>>>>>>>>>>>>>>> the dmesg log to
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 find a ton of
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> these er=
rors.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> [192088.=
446299] BTRFS critical
>>>>>>>>>>>>>>>>>>>> (device sdh): corrupt
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf: root=3D5
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> block=3D=
203510940835840 slot=3D4
>>>>>>>>>>>>>>>>>>>> ino=3D1311670, invalid inode
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> has 1844=
6744073709551492 expect [0,
>>>>>>>>>>>>>>>>>>>> 6875827]
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> [192088.=
449823] BTRFS error (device
>>>>>>>>>>>>>>>>>>>> sdh):
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block=3D2035109408358=
40 read
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> time tre=
e block corruption detected
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> [192088.=
459238] BTRFS critical
>>>>>>>>>>>>>>>>>>>> (device sdh): corrupt
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf: root=3D5
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> block=3D=
203510940835840 slot=3D4
>>>>>>>>>>>>>>>>>>>> ino=3D1311670, invalid inode
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> has 1844=
6744073709551492 expect [0,
>>>>>>>>>>>>>>>>>>>> 6875827]
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> [192088.=
462773] BTRFS error (device
>>>>>>>>>>>>>>>>>>>> sdh):
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block=3D2035109408358=
40 read
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> time tre=
e block corruption detected
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> [192088.=
464711] BTRFS critical
>>>>>>>>>>>>>>>>>>>> (device sdh): corrupt
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf: root=3D5
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> block=3D=
203510940835840 slot=3D4
>>>>>>>>>>>>>>>>>>>> ino=3D1311670, invalid inode
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation:
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> has 1844=
6744073709551492 expect [0,
>>>>>>>>>>>>>>>>>>>> 6875827]
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> [192088.=
468457] BTRFS error (device
>>>>>>>>>>>>>>>>>>>> sdh):
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block=3D2035109408358=
40 read
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> time tre=
e block corruption detected
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> btrfs de=
vice stats, however, doesn't
>>>>>>>>>>>>>>>>>>>> show any errors.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> Is there=
 anything I should do about
>>>>>>>>>>>>>>>>>>>> this, or should I
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 just continue
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> using my=
 array as normal?
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> This is c=
aused by older kernel
>>>>>>>>>>>>>>>>>>>> underflow inode generation.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> Latest bt=
rfs-progs can fix it, using
>>>>>>>>>>>>>>>>>>>> btrfs check --repair.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> Or you ca=
n go safer, by manually
>>>>>>>>>>>>>>>>>>>> locating the inode
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 using its inode
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> number (1=
311670), and copy it to some
>>>>>>>>>>>>>>>>>>>> new location using
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 previous
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> working k=
ernel, then delete the old
>>>>>>>>>>>>>>>>>>>> file, copy the new
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 one back to fix it.
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> Qu
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> Thank yo=
u!
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>


--8LeC4Db0I3HcPfxXNKw9UI3J2oh3uJxVx--

--lOqhX0WzOwk0J5k52Lt92d9dRJpRTAz0w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+ki3wACgkQwj2R86El
/qhhvwf9EMJuv8PKVH2EPeSdRamrxwWcHfAiCyuMFnWEkorDWTNxItX1YlbiryTY
puGiog49fqndGm9dn15swPlKccqqAgYjRDrV8CBZReMyu+ldgIDR5bIE4/YcXWi5
Jp2+X/MatUn46A/OjHRQC7pmdegPbf5IEUzO3Pqg9U1FeomjCRPCsOT6CJ/6O023
iTMHrHFLGxf12QjyCB9S2XmMIs87G79Uc5JLho6Ln5PbzX3Yep4pHUp0wcVXaoR0
1sC5oYe8He+Lr+VQW6aZl9NbteZpwAcQwJXfRgIw0HRfhUCo1x6wbPFomdzc1M3j
Zx/pTUOapbnJUoOHekH71Q5pABOEvw==
=FuR/
-----END PGP SIGNATURE-----

--lOqhX0WzOwk0J5k52Lt92d9dRJpRTAz0w--
