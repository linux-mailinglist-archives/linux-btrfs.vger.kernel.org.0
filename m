Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124C324EACF
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 03:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgHWBwH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Aug 2020 21:52:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:46063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgHWBvz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Aug 2020 21:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598147507;
        bh=FaKWYTOIyW1X946TYqzgGfsqmFPlcaTEaDL7V8wglyA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WXTgZReoHiHqZ98Lb8Q/ilhD1YhAPlydj4g8uvXUnAk+yKgzI1IcGunhFX15vCeGk
         bqAxqGyKTNh+e/yNdm0M0lI3Z7jakLFqTqOcj9WxaWlXKau+1iM5CVTtvqmVmDlp1n
         Uj130XtFgaoVJITXkoK5GTNGhSQNJGAFKN9j0CqU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MV63g-1k2TuW0Ebu-00S8xW; Sun, 23
 Aug 2020 03:51:47 +0200
Subject: Re: Fwd: Read time tree block corruption detected
To:     Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com>
 <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
 <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com>
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
Message-ID: <98c633bc-658c-d8d9-a2cd-4c9b9e477552@gmx.com>
Date:   Sun, 23 Aug 2020 09:51:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJheHN0qqOn2u4Rks6u+Epsr+L+ijs0E=G=AUCV3F-yLvsLasA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Mh25gwQNqsOT1ofayAMEHslTmZ67bkjto"
X-Provags-ID: V03:K1:IGbedBOyzSJRzXK3zNhclifibqObiU4JHl5UiEjl2csKilyl/K8
 rSClU4GKAQ4LxZpAQ3h5fc3OZ1jLqjLn+TVGYNxTzFk46nDzkuYAydY4Ew3yF90FcMNxnMh
 d/tLQYOBWwyi8Uvs5XfWvWjCzhuFEqHAGrBoILF1/z59wdzPINxhnOh9ibTgCtdKhuPyYp/
 PFtGbaWlVZcXWloI72t9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k02QjWTtWOU=:DRJjXsnbHjbxATgkSfBov/
 lg+1N3CUrHZIK6aHsxscvJs2RqxdpWf+6vi2M1krtAtplQnSmVkPtFlakIhEZICSTSHGr+eRm
 kLjux7qANOusr/zmECIwAIVuvrpzoBaRR+rJouaP4wOkNVKo5S5tBRwe2I58iwtSvR2rPl3sJ
 i6IUx1mYxbSNXKixIbq9KMwyOayUhGw7Zn4UTeJohXIamNf+IdxNbL7Fq7kGpoTIZ9Dzpb080
 qcEIhzwXWDbskU3Li8FhLuQsfdq+QvaDrhsu3a8HRSJbggvsI71bDuPiUQESMqll1sYb/dAtS
 DsoAByhyvKj3zi8+WmMlIfFgJRgADrMhyy2aT11tYvoJcQXyseQxroAZMFWUmEYhST5ss/5qG
 nW1dePyjMkL3lrqViJzQBfv+36sikXJXA0de2GmRa51oxpxPE9CefKa3Z2JWvlVA7Q95aN/O+
 X19uThwjSpRIEd0E3r7pxHnXHk8FyO5e0KgNDxrNm9tcn1xS7tUntF8tuzwtW2W4VeNa1Daiz
 w0zksHcPCY0PqfZmjgKoIHvAWWgUAqjFybbVnpaG5m1LzvOSuNHZ7ZjbJ5con2Hinj0/Mtds2
 h/LdOU9Xaq2if+3tKN4qMI03UTIeKJ5+Qg55OhY6W2NYmtxLnuxwr5hBJ0bZMhGV29tnTj5gy
 LJCkNN5rIZIP+RG/feGRjjXHlKheMtrEcjRF/7aNrPNfvFDCdFijKE2ToTyn1jFQcQ6jd62Oy
 2aJimxvD/7/LcRnisFWsK1x9ZoOo2W7tNsGR4zVeAgpHdBBByWrKfAg7m/Qrdf3HAQAaMuLPx
 jaYrj8FBi4O/3RR1E909KM7kaX73Pcva5T/I9+foWNCQCrwuR7oncNX/dlctXx0L8ICwtvAWs
 GlHZ8G24GxMMZNpNCKQuVdJjbH4QNm3PWUR3RUaCjMdGhbOiDOAtjEP827BnmSwZDFutq2BEw
 3AbBexYvS6wAJ3jJ27dYavZegAN1fOhkynYSHrCQAD363ysJWQuq25B3jjadOLSngaXoS74zr
 IGv7rfx5fd0Lqv6VoJxkJFxnOLkrUUS70X3uPDDk5g8bPrZTQiSNtHhwlm4z+gY99Vj+Weqzj
 NfaYXL5XZrp2tK8gVBBUCoPNeGXuNDRhJ7nF+cOAk8Tb/EHITIZZNvPxogq2GnW91D1vcbwoI
 m2cQYtPFdemM3cdUshSe0xawZJ/a+jWJWEVbCs6oSwrfI+Cd9O07To0BICQ9YqMEOk72xe1ER
 0PGVvn4z4YVvIPaQSmd105SDLwbXQTGVWhNW/6w==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mh25gwQNqsOT1ofayAMEHslTmZ67bkjto
Content-Type: multipart/mixed; boundary="ZFfLmW7NIWCujHJ4kL8uQY7SfqHvaxIzH"

--ZFfLmW7NIWCujHJ4kL8uQY7SfqHvaxIzH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/23 =E4=B8=8A=E5=8D=889:15, Tyler Richmond wrote:
> Is my best bet just to downgrade the kernel and then try to delete the
> broken files? Or should I rebuild from scratch? Just don't know
> whether it's worth the time to try and figure this out or if the
> problems stem from the FS being too old and it's beyond trying to
> repair.

All invalid inode generations, should be able to be repaired by latest
btrfs-check.

If not, please provide the btrfs-image dump for us to determine what's
going wrong.

Thanks,
Qu
>=20
> On Tue, Aug 18, 2020 at 8:18 AM Tyler Richmond <t.d.richmond@gmail.com>=
 wrote:
>>
>> I didn't check dmesg during the btrfs check, but that was the only
>> output during the rm -f before it was forced readonly. I just checked
>> dmesg for inode generation values, and there are a lot of them.
>>
>> https://pastebin.com/stZdN0ta
>> The dmesg output had 990 lines containing inode generation.
>>
>> However, these were at least later. I tried to do a btrfs balance
>> -mconvert raid1 and it failed with an I/O error. That is probably what=

>> generated these specific errors, but maybe they were also happening
>> during the btrfs repair.
>>
>> The FS is ~45TB, but the btrfs-image -c9 failed anway with:
>> ERROR: either extent tree is corrupted or deprecated extent ref format=

>> ERROR: create failed: -5
>>
>>
>> On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>
>>>
>>>
>>> On 2020/8/18 =E4=B8=8A=E5=8D=8811:35, Tyler Richmond wrote:
>>>> Qu,
>>>>
>>>> Sorry to resurrect this thread, but I just ran into something that I=

>>>> can't really just ignore. I've found a folder that is full of files
>>>> which I guess have been broken somehow. I found a backup and restore=
d
>>>> them, but I want to delete this folder of broken files. But whenever=
 I
>>>> try, the fs is forced into readonly mode again. I just finished anot=
her
>>>> btrfs check --repair but it didn't fix the problem.
>>>>
>>>> https://pastebin.com/eTV3s3fr
>>>
>>> Is that the full output?
>>>
>>> No inode generation bugs?
>>>>
>>>>  I'm already on btrfs-progs v5.7. Any new suggestions?
>>>
>>> Strange.
>>>
>>> The detection and repair should have been merged into v5.5.
>>>
>>> If your fs is small enough, would you please provide the "btrfs-image=

>>> -c9" dump?
>>>
>>> It would contain the filenames and directories names, but doesn't
>>> contain file contents.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond <t.d.richmond@gmail.co=
m
>>>> <mailto:t.d.richmond@gmail.com>> wrote:
>>>>
>>>>     5.6.1 also failed the same way. Here's the usage output. This is=
 the
>>>>     part where you see I've been using RAID5 haha
>>>>
>>>>     WARNING: RAID56 detected, not implemented
>>>>     Overall:
>>>>         Device size:                  60.03TiB
>>>>         Device allocated:             98.06GiB
>>>>         Device unallocated:           59.93TiB
>>>>         Device missing:                  0.00B
>>>>         Used:                         92.56GiB
>>>>         Free (estimated):                0.00B      (min: 8.00EiB)
>>>>         Data ratio:                       0.00
>>>>         Metadata ratio:                   2.00
>>>>         Global reserve:              512.00MiB      (used: 0.00B)
>>>>         Multiple profiles:                  no
>>>>
>>>>     Data,RAID5: Size:40.35TiB, Used:40.12TiB (99.42%)
>>>>        /dev/sdh        8.07TiB
>>>>        /dev/sdf        8.07TiB
>>>>        /dev/sdg        8.07TiB
>>>>        /dev/sdd        8.07TiB
>>>>        /dev/sdc        8.07TiB
>>>>        /dev/sde        8.07TiB
>>>>
>>>>     Metadata,RAID1: Size:49.00GiB, Used:46.28GiB (94.44%)
>>>>        /dev/sdh       34.00GiB
>>>>        /dev/sdf       32.00GiB
>>>>        /dev/sdg       32.00GiB
>>>>
>>>>     System,RAID1: Size:32.00MiB, Used:2.20MiB (6.87%)
>>>>        /dev/sdf       32.00MiB
>>>>        /dev/sdg       32.00MiB
>>>>
>>>>     Unallocated:
>>>>        /dev/sdh        2.81TiB
>>>>        /dev/sdf        2.81TiB
>>>>        /dev/sdg        2.81TiB
>>>>        /dev/sdd        1.03TiB
>>>>        /dev/sdc        1.03TiB
>>>>        /dev/sde        1.03TiB
>>>>
>>>>     On Fri, May 8, 2020 at 1:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com=

>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>     >
>>>>     >
>>>>     >
>>>>     > On 2020/5/8 =E4=B8=8B=E5=8D=881:12, Tyler Richmond wrote:
>>>>     > > If this is saying there's no extra space for metadata, is th=
at why
>>>>     > > adding more files often makes the system hang for 30-90s? Is=
 there
>>>>     > > anything I should do about that?
>>>>     >
>>>>     > I'm not sure about the hang though.
>>>>     >
>>>>     > It would be nice to give more info to diagnosis.
>>>>     > The output of 'btrfs fi usage' is useful for space usage probl=
em.
>>>>     >
>>>>     > But the common idea is, to keep at 1~2 Gi unallocated (not ava=
iable
>>>>     > space in vanilla df command) space for btrfs.
>>>>     >
>>>>     > Thanks,
>>>>     > Qu
>>>>     >
>>>>     > >
>>>>     > > Thank you so much for all of your help. I love how flexible =
BTRFS is
>>>>     > > but when things go wrong it's very hard for me to troublesho=
ot.
>>>>     > >
>>>>     > > On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenruo.btrfs@gmx=
=2Ecom
>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>     > >>
>>>>     > >>
>>>>     > >>
>>>>     > >> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmond wrote:
>>>>     > >>> Something went wrong:
>>>>     > >>>
>>>>     > >>> Reinitialize checksum tree
>>>>     > >>> Unable to find block group for 0
>>>>     > >>> Unable to find block group for 0
>>>>     > >>> Unable to find block group for 0
>>>>     > >>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
>>>>     > >>> btrfs(+0x6dd94)[0x55a933af7d94]
>>>>     > >>> btrfs(+0x71b94)[0x55a933afbb94]
>>>>     > >>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
>>>>     > >>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
>>>>     > >>> btrfs(+0x360b2)[0x55a933ac00b2]
>>>>     > >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
>>>>     > >>> btrfs(main+0x98)[0x55a933a9fe88]
>>>>     > >>>
>>>>     /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f263e=
d550b3]
>>>>     > >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
>>>>     > >>> Aborted
>>>>     > >>
>>>>     > >> This means no space for extra metadata...
>>>>     > >>
>>>>     > >> Anyway the csum tree problem shouldn't be a big thing, you
>>>>     could leave
>>>>     > >> it and call it a day.
>>>>     > >>
>>>>     > >> BTW, as long as btrfs check reports no extra problem for th=
e inode
>>>>     > >> generation, it should be pretty safe to use the fs.
>>>>     > >>
>>>>     > >> Thanks,
>>>>     > >> Qu
>>>>     > >>>
>>>>     > >>> I just noticed I have btrfs-progs 5.6 installed and 5.6.1 =
is
>>>>     > >>> available. I'll let that try overnight?
>>>>     > >>>
>>>>     > >>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo
>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>     > >>>>
>>>>     > >>>>
>>>>     > >>>>
>>>>     > >>>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond wrote=
:
>>>>     > >>>>> Thank you for helping. The end result of the scan was:
>>>>     > >>>>>
>>>>     > >>>>>
>>>>     > >>>>> [1/7] checking root items
>>>>     > >>>>> [2/7] checking extents
>>>>     > >>>>> [3/7] checking free space cache
>>>>     > >>>>> [4/7] checking fs roots
>>>>     > >>>>
>>>>     > >>>> Good news is, your fs is still mostly fine.
>>>>     > >>>>
>>>>     > >>>>> [5/7] checking only csums items (without verifying data)=

>>>>     > >>>>> there are no extents for csum range 0-69632
>>>>     > >>>>> csum exists for 0-69632 but there is no extent record
>>>>     > >>>>> ...
>>>>     > >>>>> ...
>>>>     > >>>>> there are no extents for csum range 946692096-946827264
>>>>     > >>>>> csum exists for 946692096-946827264 but there is no exte=
nt
>>>>     record
>>>>     > >>>>> there are no extents for csum range 946831360-947912704
>>>>     > >>>>> csum exists for 946831360-947912704 but there is no exte=
nt
>>>>     record
>>>>     > >>>>> ERROR: errors found in csum tree
>>>>     > >>>>
>>>>     > >>>> Only extent tree is corrupted.
>>>>     > >>>>
>>>>     > >>>> Normally btrfs check --init-csum-tree should be able to
>>>>     handle it.
>>>>     > >>>>
>>>>     > >>>> But still, please be sure you're using the latest btrfs-p=
rogs
>>>>     to fix it.
>>>>     > >>>>
>>>>     > >>>> Thanks,
>>>>     > >>>> Qu
>>>>     > >>>>
>>>>     > >>>>> [6/7] checking root refs
>>>>     > >>>>> [7/7] checking quota groups skipped (not enabled on this=
 FS)
>>>>     > >>>>> found 44157956026368 bytes used, error(s) found
>>>>     > >>>>> total csum bytes: 42038602716
>>>>     > >>>>> total tree bytes: 49688616960
>>>>     > >>>>> total fs tree bytes: 1256427520
>>>>     > >>>>> total extent tree bytes: 1709105152
>>>>     > >>>>> btree space waste bytes: 3172727316
>>>>     > >>>>> file data blocks allocated: 261625653436416
>>>>     > >>>>>  referenced 47477768499200
>>>>     > >>>>>
>>>>     > >>>>> What do I need to do to fix all of this?
>>>>     > >>>>>
>>>>     > >>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo
>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>     > >>>>>>
>>>>     > >>>>>>
>>>>     > >>>>>>
>>>>     > >>>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond wrot=
e:
>>>>     > >>>>>>> Well, the repair doesn't look terribly successful.
>>>>     > >>>>>>>
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> Ignoring transid failure
>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606=
1184
>>>>     item=3D84
>>>>     > >>>>>>> parent level=3D1
>>>>     > >>>>>>>                                             child leve=
l=3D4
>>>>     > >>>>>>
>>>>     > >>>>>> This means there are more problems, not only the hash n=
ame
>>>>     mismatch.
>>>>     > >>>>>>
>>>>     > >>>>>> This means the fs is already corrupted, the name hash i=
s
>>>>     just one
>>>>     > >>>>>> unrelated symptom.
>>>>     > >>>>>>
>>>>     > >>>>>> The only good news is, btrfs-progs abort the transactio=
n,
>>>>     thus no
>>>>     > >>>>>> further damage to the fs.
>>>>     > >>>>>>
>>>>     > >>>>>> Please run a plain btrfs-check to show what's the probl=
em
>>>>     first.
>>>>     > >>>>>>
>>>>     > >>>>>> Thanks,
>>>>     > >>>>>> Qu
>>>>     > >>>>>>
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> Ignoring transid failure
>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606=
1184
>>>>     item=3D84
>>>>     > >>>>>>> parent level=3D1
>>>>     > >>>>>>>                                             child leve=
l=3D4
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> Ignoring transid failure
>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606=
1184
>>>>     item=3D84
>>>>     > >>>>>>> parent level=3D1
>>>>     > >>>>>>>                                             child leve=
l=3D4
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> Ignoring transid failure
>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606=
1184
>>>>     item=3D84
>>>>     > >>>>>>> parent level=3D1
>>>>     > >>>>>>>                                             child leve=
l=3D4
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> Ignoring transid failure
>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606=
1184
>>>>     item=3D84
>>>>     > >>>>>>> parent level=3D1
>>>>     > >>>>>>>                                             child leve=
l=3D4
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> Ignoring transid failure
>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606=
1184
>>>>     item=3D84
>>>>     > >>>>>>> parent level=3D1
>>>>     > >>>>>>>                                             child leve=
l=3D4
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> Ignoring transid failure
>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606=
1184
>>>>     item=3D84
>>>>     > >>>>>>> parent level=3D1
>>>>     > >>>>>>>                                             child leve=
l=3D4
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> Ignoring transid failure
>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606=
1184
>>>>     item=3D84
>>>>     > >>>>>>> parent level=3D1
>>>>     > >>>>>>>                                             child leve=
l=3D4
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> Ignoring transid failure
>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606=
1184
>>>>     item=3D84
>>>>     > >>>>>>> parent level=3D1
>>>>     > >>>>>>>                                             child leve=
l=3D4
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> Ignoring transid failure
>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606=
1184
>>>>     item=3D84
>>>>     > >>>>>>> parent level=3D1
>>>>     > >>>>>>>                                             child leve=
l=3D4
>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wanted=

>>>>     6875841 found 6876224
>>>>     > >>>>>>> Ignoring transid failure
>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606=
1184
>>>>     item=3D84
>>>>     > >>>>>>> parent level=3D1
>>>>     > >>>>>>>                                             child leve=
l=3D4
>>>>     > >>>>>>> ERROR: failed to zero log tree: -17
>>>>     > >>>>>>> ERROR: attempt to start transaction over already runni=
ng one
>>>>     > >>>>>>> WARNING: reserved space leaked, flag=3D0x4 bytes_reser=
ved=3D4096
>>>>     > >>>>>>> extent buffer leak: start 225049066086400 len 4096
>>>>     > >>>>>>> extent buffer leak: start 225049066086400 len 4096
>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>     225049066086400 len 4096
>>>>     > >>>>>>> extent buffer leak: start 225049066094592 len 4096
>>>>     > >>>>>>> extent buffer leak: start 225049066094592 len 4096
>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>     225049066094592 len 4096
>>>>     > >>>>>>> extent buffer leak: start 225049066102784 len 4096
>>>>     > >>>>>>> extent buffer leak: start 225049066102784 len 4096
>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>     225049066102784 len 4096
>>>>     > >>>>>>> extent buffer leak: start 225049066131456 len 4096
>>>>     > >>>>>>> extent buffer leak: start 225049066131456 len 4096
>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>     225049066131456 len 4096
>>>>     > >>>>>>>
>>>>     > >>>>>>> What is going on?
>>>>     > >>>>>>>
>>>>     > >>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond
>>>>     <t.d.richmond@gmail.com <mailto:t.d.richmond@gmail.com>> wrote:
>>>>     > >>>>>>>>
>>>>     > >>>>>>>> Chris, I had used the correct mountpoint in the comma=
nd.
>>>>     I just edited
>>>>     > >>>>>>>> it in the email to be /mountpoint for consistency.
>>>>     > >>>>>>>>
>>>>     > >>>>>>>> Qu, I'll try the repair. Fingers crossed!
>>>>     > >>>>>>>>
>>>>     > >>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo
>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>     > >>>>>>>>>
>>>>     > >>>>>>>>>
>>>>     > >>>>>>>>>
>>>>     > >>>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond w=
rote:
>>>>     > >>>>>>>>>> Hello,
>>>>     > >>>>>>>>>>
>>>>     > >>>>>>>>>> I looked up this error and it basically says ask a
>>>>     developer to
>>>>     > >>>>>>>>>> determine if it's a false error or not. I just star=
ted
>>>>     getting some
>>>>     > >>>>>>>>>> slow response times, and looked at the dmesg log to=

>>>>     find a ton of
>>>>     > >>>>>>>>>> these errors.
>>>>     > >>>>>>>>>>
>>>>     > >>>>>>>>>> [192088.446299] BTRFS critical (device sdh): corrup=
t
>>>>     leaf: root=3D5
>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, inv=
alid inode
>>>>     generation:
>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>     > >>>>>>>>>> [192088.449823] BTRFS error (device sdh):
>>>>     block=3D203510940835840 read
>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>     > >>>>>>>>>> [192088.459238] BTRFS critical (device sdh): corrup=
t
>>>>     leaf: root=3D5
>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, inv=
alid inode
>>>>     generation:
>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>     > >>>>>>>>>> [192088.462773] BTRFS error (device sdh):
>>>>     block=3D203510940835840 read
>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>     > >>>>>>>>>> [192088.464711] BTRFS critical (device sdh): corrup=
t
>>>>     leaf: root=3D5
>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, inv=
alid inode
>>>>     generation:
>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>     > >>>>>>>>>> [192088.468457] BTRFS error (device sdh):
>>>>     block=3D203510940835840 read
>>>>     > >>>>>>>>>> time tree block corruption detected
>>>>     > >>>>>>>>>>
>>>>     > >>>>>>>>>> btrfs device stats, however, doesn't show any error=
s.
>>>>     > >>>>>>>>>>
>>>>     > >>>>>>>>>> Is there anything I should do about this, or should=
 I
>>>>     just continue
>>>>     > >>>>>>>>>> using my array as normal?
>>>>     > >>>>>>>>>
>>>>     > >>>>>>>>> This is caused by older kernel underflow inode gener=
ation.
>>>>     > >>>>>>>>>
>>>>     > >>>>>>>>> Latest btrfs-progs can fix it, using btrfs check --r=
epair.
>>>>     > >>>>>>>>>
>>>>     > >>>>>>>>> Or you can go safer, by manually locating the inode
>>>>     using its inode
>>>>     > >>>>>>>>> number (1311670), and copy it to some new location u=
sing
>>>>     previous
>>>>     > >>>>>>>>> working kernel, then delete the old file, copy the n=
ew
>>>>     one back to fix it.
>>>>     > >>>>>>>>>
>>>>     > >>>>>>>>> Thanks,
>>>>     > >>>>>>>>> Qu
>>>>     > >>>>>>>>>
>>>>     > >>>>>>>>>>
>>>>     > >>>>>>>>>> Thank you!
>>>>     > >>>>>>>>>>
>>>>     > >>>>>>>>>
>>>>     > >>>>>>
>>>>     > >>>>
>>>>     > >>
>>>>     >
>>>>
>>>


--ZFfLmW7NIWCujHJ4kL8uQY7SfqHvaxIzH--

--Mh25gwQNqsOT1ofayAMEHslTmZ67bkjto
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9By64ACgkQwj2R86El
/qi8MQgAkyE9QuUYnw6uVHLW4eDzyQBGuBZ3VkKx8t1jTCZsRAcIq5R39MkU+kw6
jHrBVfFfV6MB1CiW94SnawSozcIa07uva5K3ZHSZF6b+XGTPwzLaFEE9CXfkVtdm
8fEtlPhZloUyED1nurK6SfTJBR7KIe4Y0Yc7VFTb34CAyYA+sikAqGjbcfq/dUF4
MciTKzd9F4UASNOoTbYF8zmXNCyCAyviC3rCIRuJ2PmtqaUmdHD0fJNZHaz8c6CE
MpZASysfmWJRgRakBy8X1mjO1Ug6sRaKemFy3k311urx3HHKCwcFc4Qb96JcZzSn
ziYpt8V8DNvE3CyW83pSMQrgjmcnGw==
=PPz6
-----END PGP SIGNATURE-----

--Mh25gwQNqsOT1ofayAMEHslTmZ67bkjto--
