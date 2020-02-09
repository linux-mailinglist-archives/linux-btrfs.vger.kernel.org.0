Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7400E156846
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2020 02:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBIBH5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Feb 2020 20:07:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:34857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgBIBH5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 8 Feb 2020 20:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581210470;
        bh=4Mte0QBOgpXzSFkEnz0JhvKTxtn+Fa1vOxCMBNPh5/Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=egrFAW0U5u4RRu4YcQ8L0HQuUjJKnPh9Fu6fkjrOfmWrH7Abq/atRtZxyFyaKvvFI
         228STG7IF6kMQl5BbmeWc53kmyYsbNH7pUbOKI6Z2T6r6kiWJtbI3L2Np5lVMzOjbh
         VTl709fKCm7N/ZDQsdgev8EyNKuoIk/1ut2LuIhc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpUUm-1jJRkn3lXQ-00psvQ; Sun, 09
 Feb 2020 02:07:50 +0100
Subject: Re: btrfs root fs started remounting ro
To:     John Hendy <jw.hendy@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
 <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com>
 <CA+M2ft8zMv8nhs6VzZWnzgcP2nRasrwxLzjKgaZPnm_prtWQow@mail.gmail.com>
 <3e5f4de7-fec1-f8cd-c8b1-20b5a3f38f60@gmx.com>
 <CA+M2ft_6_1pkP75G79qj4dLxOjJr0bOGtATaGPTVQGn25sAo+A@mail.gmail.com>
 <CA+M2ft9dcMKKQstZVcGQ=9MREbfhPF5GG=xoMoh5Aq8MK9P8wA@mail.gmail.com>
 <75f86be2-80fe-26c1-235f-1c6d3a618eeb@gmx.com>
 <CA+M2ft9PjH29SY+nBqfFEapr9g7BjjMFeE_p2P0oL1q8xHGUBw@mail.gmail.com>
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
Message-ID: <fac62b70-feec-6c0d-5ef3-6682e79b2886@gmx.com>
Date:   Sun, 9 Feb 2020 09:07:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CA+M2ft9PjH29SY+nBqfFEapr9g7BjjMFeE_p2P0oL1q8xHGUBw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7ybUy1wd8iBiKpOVtGLIFgTbUBivZSIeR"
X-Provags-ID: V03:K1:n9Vy8GLoi/efLbFBviIVHl9dec7IPS5lV1fkLxp5ZlckhDcJuWV
 UKQTPqqtg3eCrN7AEziQvKv/rrWCbTlHAc+8ko3tLXA8U5NXPCrhGWIxMklCe/QSZcjCYfl
 hvtumT1ZFJyMdWqQ51gY2JvEB1CkmO7W80rTXm7J8FLCF47q2BAySLkJge+U2QxQwpeXUSe
 WJIGusSBMcEMBgP34iXDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QnhuQeAfs3k=:DplJzvLP3/YCnXYwqh3HAa
 xESSRgZQj8s39bVP3Wg1Vy+pemHBRJxyOO0HM6GOYI9Vm+uhjWS2jwzx+cKBOmEMd2xjIzfBY
 D0FMo3eiDs2JtJJr7vyvdbjOEqB2gkd9MPPLZ46wftTcIhICBxtduJWy5fPbjjDf3I70/3FAc
 dajNw6Q+4oAipQwuyWzxCftvcUE6fhZNTl4eCPtlAAl3MgsrhbgmUnp5P28bkNgAfejr0l5cG
 b4r6V3k1JVJqoP0SqRc5BfdK9GleE9pTYQT58iVvJMwj8XeHQ4QwN5j9Npd6yPjCn/pcAMCBz
 XGcQFkhm8s8umfl0OeA/t8APK8t2me5cciwqeBVR3CTodSba/KZnD0Ko2LUse2SR3m3N4LfiG
 WFHUMvS/jWGc8VCI75POI2e0Lr7sEHcTa5JmDxAbNdz5tzxVjIQpr/ZCMCU/ejTjrohL8ISr6
 Ne+EpSc7z4oZn+mgN3KpFvjCY++6lCYvpLA0G/mYa72cbKLe+4wlLinChbjKQKy8gwtRCf26v
 QGfgGXsTJBNHyF92WVEAd7kO1vxDffBk8wDHNfZ9yqLfiV8hpvLeLlb4S1Zjgr6jysoSaupIM
 PZQfNVrK68IgHcjoIHP31LceG0BMLXAi93z4pRJPmBXSyhjSEXAjJPFtiRZqHW2QmYQUfX2t1
 VJLHtsz4xQO8Py/fsT63ouZ26PQL3IupNsdS7hlHubjrPI9tY+H+wfIk+o8jWzju1xigxZcXh
 dKVL6yEtVADzPiNU2fYss45rTFh0d9ho98bBNELKtC5iJc+az2E4MuBknZurqbRKQPZgliBbg
 9Wlwu2l7xTxObauJouu7VmAl2clOimnCFM+gSQPVSx4szzre+Cr4novbKrPb95vOccQuWZSMX
 jBLSzZE8QdHYnPlFOMbRcKLor6VYjS0Jv2YnhEXUELPI6BbDkHEfIS1yTRjCjyU1e6WnigaMn
 9B35jfw64jyE+dm/1jDczZgi/0wUSR8wW+B1iQc4UozCSPbWCkWyuXx6Y55ohANEPPPDFYXdh
 iv59ifUo38CX9KCOeVIjDVxJooFe2WiEj1VqQJ5UuFGPWSiS7aZTfeKzDwdU8eOrshGIbiRcu
 Pe4pFOqUlivU4hiIzLCCMLD1vOb2A+ApsjfZQtBW9ajp8kjdKx5yt/4PQoTE3uEoboxmmvH/M
 bBJOKgS4uEhpZITZpiXc0PUuGp0ynE1ME01yGA5GCxFBNhSwyLIn4/rygy0l6M4U+eAK3Gf7Q
 lQIV8gJNeoM/eqeineeMbanNzwRoDHqLl1B24kGh/2+hvR8i2IPp0QGLJM+xjudEYc7QceVFX
 RyWVYHvcmObalIVDKjGW6X0LNCZHhFdK58zjF1RSrVdlgc1RlZXVbgTR6MOKWbOM6poenW1X
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ybUy1wd8iBiKpOVtGLIFgTbUBivZSIeR
Content-Type: multipart/mixed; boundary="xjd0cZCcxUAL0sIxFKUVwENSQpNT1QGPY"

--xjd0cZCcxUAL0sIxFKUVwENSQpNT1QGPY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/9 =E4=B8=8A=E5=8D=888:51, John Hendy wrote:
> On Sat, Feb 8, 2020 at 5:56 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/2/9 =E4=B8=8A=E5=8D=885:57, John Hendy wrote:
>>> On phone due to no OS, so apologies if this is in html mode. Indeed, =
I
>>> can't mount or boot any longer. I get the error:
>>>
>>> Error (device dm-0) in btrfs_replay_log:2228: errno=3D-22 unknown (Fa=
iled
>>> to recover log tree)
>>> BTRFS error (device dm-0): open_ctree failed
>>
>> That can be easily fixed by `btrfs rescue zero-log`.
>>
>=20
> Whew. This was most helpful and it is wonderful to be booting at
> least. I think the outstanding issues are:
> - what should I do about `btrfs check --repair seg` faulting?

That needs extra debugging. But you can try `btrfs check --repair
--mode=3Dlowmem` which sometimes can bring better result than regular mod=
e.
The trade-off is much slower speed.

> - how can I deal with this (probably related to seg fault) ghost file
> that cannot be deleted?

Only `btrfs check` can handle it, kernel will only fallback to RO to
prevent further corruption.

> - I'm not sure if you looked at the post --repair log, but there a ton
> of these errors that didn't used to be there:
>=20
> backpointer mismatch on [13037375488 20480]
> ref mismatch on [13037395968 892928] extent item 0, found 1
> data backref 13037395968 root 263 owner 4257169 offset 0 num_refs 0
> not found in extent tree
> incorrect local backref count on 13037395968 root 263 owner 4257169
> offset 0 found 1 wanted 0 back 0x5627f59cadc0

All 13037395968 related line is just one problem, it's the original mode
doing human-unfriendly output.

But the extra transid looks kinda dangerous.

I'd recommend to backup important data first before trying to repair.

>=20
> Here is the latest btrfs check output after the zero-log operation.
> - https://pastebin.com/KWeUnk0y
>=20
> I'm hoping once that file is deleted, it's a matter of
> --init-csum-tree and perhaps I'm set? Or --init-extent-tree?

--init-csum-tree has the least priority, thus it doesn't really matter.

--init-extent-tree would in theory reset your extent tree, but the
problem is, the transid mismatch may cause something wrong.

So please backup your data before trying any repair.
After data backup, please try `btrfs check --repair --mode=3Dlowmem` firs=
t.

Thanks,
Qu
>=20
> Thanks,
> John
>=20
>> At least, btrfs check --repair didn't make things worse.
>>
>> Thanks,
>> Qu
>>>
>>> John
>>>
>>> On Sat, Feb 8, 2020, 1:56 PM John Hendy <jw.hendy@gmail.com
>>> <mailto:jw.hendy@gmail.com>> wrote:
>>>
>>>     This is not going so hot. Updates:
>>>
>>>     booted from arch install, pre repair btrfs check:
>>>     - https://pastebin.com/6vNaSdf2
>>>
>>>     btrfs check --mode=3Dlowmem as requested by Chris:
>>>     - https://pastebin.com/uSwSTVVY
>>>
>>>     Then I did btrfs check --repair, which seg faulted at the end. I'=
ve
>>>     typed them off of pictures I took:
>>>
>>>     Starting repair.
>>>     Opening filesystem to check...
>>>     Checking filesystem on /dev/mapper/ssd
>>>     [1/7] checking root items
>>>     Fixed 0 roots.
>>>     [2/7] checking extents
>>>     parent transid verify failed on 20271138064 wanted 68719924810 fo=
und
>>>     448074
>>>     parent transid verify failed on 20271138064 wanted 68719924810 fo=
und
>>>     448074
>>>     Ignoring transid failure
>>>     # ... repeated the previous two lines maybe hundreds of times
>>>     # ended with this:
>>>     ref mismatch on [12797435904 268505088] extent item 1, found 412
>>>     [1] 1814 segmentation fault (core dumped) btrfs check --repair
>>>     /dev/mapper/ssd
>>>
>>>     This was with btrfs-progs 5.4 (the install USB is maybe a month o=
ld).
>>>
>>>     Here is the output of btrfs check after the --repair attempt:
>>>     - https://pastebin.com/6MYRNdga
>>>
>>>     I rebooted to write this email given the seg fault, as I wanted t=
o
>>>     make sure that I should still follow-up --repair with
>>>     --init-csum-tree. I had pictures of the --repair output, but Fire=
fox
>>>     just wouldn't load imgur.com <http://imgur.com> for me to post th=
e
>>>     pics and was acting
>>>     really weird. In suspiciously checking dmesg, things have gone ro=
 on
>>>     me :(  Here is the dmesg from this session:
>>>     - https://pastebin.com/a2z7xczy
>>>
>>>     The gist is:
>>>
>>>     [   40.997935] BTRFS critical (device dm-0): corrupt leaf: root=3D=
7
>>>     block=3D172703744 slot=3D0, csum end range (12980568064) goes bey=
ond the
>>>     start range (12980297728) of the next csum item
>>>     [   40.997941] BTRFS info (device dm-0): leaf 172703744 gen 45098=
3
>>>     total ptrs 34 free space 29 owner 7
>>>     [   40.997942]     item 0 key (18446744073709551606 128 129790607=
36)
>>>     itemoff 14811 itemsize 1472
>>>     [   40.997944]     item 1 key (18446744073709551606 128 129802977=
28)
>>>     itemoff 13895 itemsize 916
>>>     [   40.997945]     item 2 key (18446744073709551606 128 129812357=
12)
>>>     itemoff 13811 itemsize 84
>>>     # ... there's maybe 30 of these item n key lines in total
>>>     [   40.997984] BTRFS error (device dm-0): block=3D172703744 write=
 time
>>>     tree block corruption detected
>>>     [   41.016793] BTRFS: error (device dm-0) in
>>>     btrfs_commit_transaction:2332: errno=3D-5 IO failure (Error while=

>>>     writing out transaction)
>>>     [   41.016799] BTRFS info (device dm-0): forced readonly
>>>     [   41.016802] BTRFS warning (device dm-0): Skipping commit of ab=
orted
>>>     transaction.
>>>     [   41.016804] BTRFS: error (device dm-0) in cleanup_transaction:=
1890:
>>>     errno=3D-5 IO failure
>>>     [   41.016807] BTRFS info (device dm-0): delayed_refs has NO entr=
y
>>>     [   41.023473] BTRFS warning (device dm-0): Skipping commit of ab=
orted
>>>     transaction.
>>>     [   41.024297] BTRFS info (device dm-0): delayed_refs has NO entr=
y
>>>     [   44.509418] systemd-journald[416]:
>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journal:=

>>>     Journal file corrupted, rotating.
>>>     [   44.509440] systemd-journald[416]: Failed to rotate
>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journal:=

>>>     Read-only file system
>>>     [   44.509450] systemd-journald[416]: Failed to rotate
>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/user-1000.journ=
al:
>>>     Read-only file system
>>>     [   44.509540] systemd-journald[416]: Failed to write entry (23 i=
tems,
>>>     705 bytes) despite vacuuming, ignoring: Bad message
>>>     # ... then a bunch of these failed journal attempts (of note:
>>>     /var/log/journal was one of the bad inodes from btrfs check
>>>     previously)
>>>
>>>     Kindly let me know what you would recommend. I'm sadly back to an=

>>>     unusable system vs. a complaining/worrisome one. This is similar =
to
>>>     the behavior I had with the m2.sata nvme drive in my original
>>>     experience. After trying all of --repair, --init-csum-tree, and
>>>     --init-extent-tree, I couldn't boot anymore. After my dm-crypt
>>>     password at boot, I just saw a bunch of [FAILED] in the text spla=
sh
>>>     output. Hoping to not repeat that with this drive.
>>>
>>>     Thanks,
>>>     John
>>>
>>>
>>>     On Sat, Feb 8, 2020 at 1:29 AM Qu Wenruo <quwenruo.btrfs@gmx.com
>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>     >
>>>     >
>>>     >
>>>     > On 2020/2/8 =E4=B8=8B=E5=8D=8812:48, John Hendy wrote:
>>>     > > On Fri, Feb 7, 2020 at 5:42 PM Qu Wenruo <quwenruo.btrfs@gmx.=
com
>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>     > >>
>>>     > >>
>>>     > >>
>>>     > >> On 2020/2/8 =E4=B8=8A=E5=8D=881:52, John Hendy wrote:
>>>     > >>> Greetings,
>>>     > >>>
>>>     > >>> I'm resending, as this isn't showing in the archives. Perha=
ps
>>>     it was
>>>     > >>> the attachments, which I've converted to pastebin links.
>>>     > >>>
>>>     > >>> As an update, I'm now running off of a different drive (ssd=
,
>>>     not the
>>>     > >>> nvme) and I got the error again! I'm now inclined to think
>>>     this might
>>>     > >>> not be hardware after all, but something related to my setu=
p
>>>     or a bug
>>>     > >>> with chromium.
>>>     > >>>
>>>     > >>> After a reboot, chromium wouldn't start for me and demsg sh=
owed
>>>     > >>> similar parent transid/csum errors to my original post belo=
w.
>>>     I used
>>>     > >>> btrfs-inspect-internal to find the inode traced to
>>>     > >>> ~/.config/chromium/History. I deleted that, and got a new s=
et of
>>>     > >>> errors tracing to ~/.config/chromium/Cookies. After I delet=
ed
>>>     that and
>>>     > >>> tried starting chromium, I found that my btrfs /home/jwhend=
y
>>>     pool was
>>>     > >>> mounted ro just like the original problem below.
>>>     > >>>
>>>     > >>> dmesg after trying to start chromium:
>>>     > >>> - https://pastebin.com/CsCEQMJa
>>>     > >>
>>>     > >> So far, it's only transid bug in your csum tree.
>>>     > >>
>>>     > >> And two backref mismatch in data backref.
>>>     > >>
>>>     > >> In theory, you can fix your problem by `btrfs check --repair=

>>>     > >> --init-csum-tree`.
>>>     > >>
>>>     > >
>>>     > > Now that I might be narrowing in on offending files, I'll wai=
t
>>>     to see
>>>     > > what you think from my last response to Chris. I did try the =
above
>>>     > > when I first ran into this:
>>>     > > -
>>>     https://lore.kernel.org/linux-btrfs/CA+M2ft8FpjdDQ7=3DXwMdYQazhyB=
95aha_D4WU_n15M59QrimrRg@mail.gmail.com/
>>>     >
>>>     > That RO is caused by the missing data backref.
>>>     >
>>>     > Which can be fixed by btrfs check --repair.
>>>     >
>>>     > Then you should be able to delete offending files them. (Or the=
 whole
>>>     > chromium cache, and switch to firefox if you wish :P )
>>>     >
>>>     > But also please keep in mind that, the transid mismatch looks
>>>     happen in
>>>     > your csum tree, which means your csum tree is no longer reliabl=
e, and
>>>     > may cause -EIO reading unrelated files.
>>>     >
>>>     > Thus it's recommended to re-fill the csum tree by --init-csum-t=
ree.
>>>     >
>>>     > It can be done altogether by --repair --init-csum-tree, but to =
be
>>>     safe,
>>>     > please run --repair only first, then make sure btrfs check repo=
rts no
>>>     > error after that. Then go --init-csum-tree.
>>>     >
>>>     > >
>>>     > >> But I'm more interesting in how this happened.
>>>     > >
>>>     > > Me too :)
>>>     > >
>>>     > >> Have your every experienced any power loss for your NVME dri=
ve?
>>>     > >> I'm not say btrfs is unsafe against power loss, all fs shoul=
d
>>>     be safe
>>>     > >> against power loss, I'm just curious about if mount time log=

>>>     replay is
>>>     > >> involved, or just regular internal log replay.
>>>     > >>
>>>     > >> From your smartctl, the drive experienced 61 unsafe shutdown=

>>>     with 2144
>>>     > >> power cycles.
>>>     > >
>>>     > > Uhhh, hell yes, sadly. I'm a dummy running i3 and every time =
I get
>>>     > > caught off gaurd by low battery and instant power-off, I kick=
 myself
>>>     > > and mean to set up a script to force poweroff before that
>>>     happens. So,
>>>     > > indeed, I've lost power a ton. Surprised it was 61 times, but=
 maybe
>>>     > > not over ~2 years. And actually, I mis-stated the age. I have=
n't
>>>     > > *booted* from this drive in almost 2yrs. It's a corporate lap=
top,
>>>     > > issued every 3, so the ssd drive is more like 5 years old.
>>>     > >
>>>     > >> Not sure if it's related.
>>>     > >>
>>>     > >> Another interesting point is, did you remember what's the
>>>     oldest kernel
>>>     > >> running on this fs? v5.4 or v5.5?
>>>     > >
>>>     > > Hard to say, but arch linux maintains a package archive. The =
nvme
>>>     > > drive is from ~May 2018. The archives only go back to Jan 201=
9
>>>     and the
>>>     > > kernel/btrfs-progs was at 4.20 then:
>>>     > > - https://archive.archlinux.org/packages/l/linux/
>>>     >
>>>     > There is a known bug in v5.2.0~v5.2.14 (fixed in v5.2.15), whic=
h could
>>>     > cause metadata corruption. And the symptom is transid error, wh=
ich
>>>     also
>>>     > matches your problem.
>>>     >
>>>     > Thanks,
>>>     > Qu
>>>     >
>>>     > >
>>>     > > Searching my Amazon orders, the SSD was in the 2015 time fram=
e,
>>>     so the
>>>     > > kernel version would have been even older.
>>>     > >
>>>     > > Thanks for your input,
>>>     > > John
>>>     > >
>>>     > >>
>>>     > >> Thanks,
>>>     > >> Qu
>>>     > >>>
>>>     > >>> Thanks for any pointers, as it would now seem that my purch=
ase
>>>     of a
>>>     > >>> new m2.sata may not buy my way out of this problem! While I=
 didn't
>>>     > >>> want to reinstall, at least new hardware is a simple fix. N=
ow I'm
>>>     > >>> worried there is a deeper issue bound to recur :(
>>>     > >>>
>>>     > >>> Best regards,
>>>     > >>> John
>>>     > >>>
>>>     > >>> On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gmail.=
com
>>>     <mailto:jw.hendy@gmail.com>> wrote:
>>>     > >>>>
>>>     > >>>> Greetings,
>>>     > >>>>
>>>     > >>>> I've had this issue occur twice, once ~1mo ago and once a
>>>     couple of
>>>     > >>>> weeks ago. Chromium suddenly quit on me, and when trying t=
o
>>>     start it
>>>     > >>>> again, it complained about a lock file in ~. I tried to de=
lete it
>>>     > >>>> manually and was informed I was on a read-only fs! I ended=
 up
>>>     biting
>>>     > >>>> the bullet and re-installing linux due to the number of de=
ad end
>>>     > >>>> threads and slow response rates on diagnosing these issues=
,
>>>     and the
>>>     > >>>> issue occurred again shortly after.
>>>     > >>>>
>>>     > >>>> $ uname -a
>>>     > >>>> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 2020=

>>>     16:38:40
>>>     > >>>> +0000 x86_64 GNU/Linux
>>>     > >>>>
>>>     > >>>> $ btrfs --version
>>>     > >>>> btrfs-progs v5.4
>>>     > >>>>
>>>     > >>>> $ btrfs fi df /mnt/misc/ # full device; normally would be
>>>     mounting a subvol on /
>>>     > >>>> Data, single: total=3D114.01GiB, used=3D80.88GiB
>>>     > >>>> System, single: total=3D32.00MiB, used=3D16.00KiB
>>>     > >>>> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
>>>     > >>>> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
>>>     > >>>>
>>>     > >>>> This is a single device, no RAID, not on a VM. HP Zbook 15=
=2E
>>>     > >>>> nvme0n1                                       259:5    0
>>>     232.9G  0 disk
>>>     > >>>> =E2=94=9C=E2=94=80nvme0n1p1                               =
    259:6    0
>>>      512M  0
>>>     > >>>> part  (/boot/efi)
>>>     > >>>> =E2=94=9C=E2=94=80nvme0n1p2                               =
    259:7    0
>>>      1G  0 part  (/boot)
>>>     > >>>> =E2=94=94=E2=94=80nvme0n1p3                               =
    259:8    0
>>>     231.4G  0 part (btrfs)
>>>     > >>>>
>>>     > >>>> I have the following subvols:
>>>     > >>>> arch: used for / when booting arch
>>>     > >>>> jwhendy: used for /home/jwhendy on arch
>>>     > >>>> vault: shared data between distros on /mnt/vault
>>>     > >>>> bionic: root when booting ubuntu bionic
>>>     > >>>>
>>>     > >>>> nvme0n1p3 is encrypted with dm-crypt/LUKS.
>>>     > >>>>
>>>     > >>>> dmesg, smartctl, btrfs check, and btrfs dev stats attached=
=2E
>>>     > >>>
>>>     > >>> Edit: links now:
>>>     > >>> - btrfs check: https://pastebin.com/nz6Bc145
>>>     > >>> - dmesg: https://pastebin.com/1GGpNiqk
>>>     > >>> - smartctl: https://pastebin.com/ADtYqfrd
>>>     > >>>
>>>     > >>> btrfs dev stats (not worth a link):
>>>     > >>>
>>>     > >>> [/dev/mapper/old].write_io_errs    0
>>>     > >>> [/dev/mapper/old].read_io_errs     0
>>>     > >>> [/dev/mapper/old].flush_io_errs    0
>>>     > >>> [/dev/mapper/old].corruption_errs  0
>>>     > >>> [/dev/mapper/old].generation_errs  0
>>>     > >>>
>>>     > >>>
>>>     > >>>> If these are of interested, here are reddit threads where =
I
>>>     posted the
>>>     > >>>> issue and was referred here.
>>>     > >>>> 1)
>>>     https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_recove=
ring_from_various_errors_root/
>>>     > >>>> 2)
>>>     https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btrfs_=
root_started_remounting_as_ro/
>>>     > >>>>
>>>     > >>>> It has been suggested this is a hardware issue. I've alrea=
dy
>>>     ordered a
>>>     > >>>> replacement m2.sata, but for sanity it would be great to k=
now
>>>     > >>>> definitively this was the case. If anything stands out abo=
ve that
>>>     > >>>> could indicate I'm not setup properly re. btrfs, that woul=
d
>>>     also be
>>>     > >>>> fantastic so I don't repeat the issue!
>>>     > >>>>
>>>     > >>>> The only thing I've stumbled on is that I have been mounti=
ng with
>>>     > >>>> rd.luks.options=3Ddiscard and that manually running fstrim=
 is
>>>     preferred.
>>>     > >>>>
>>>     > >>>>
>>>     > >>>> Many thanks for any input/suggestions,
>>>     > >>>> John
>>>     > >>
>>>     >
>>>
>>


--xjd0cZCcxUAL0sIxFKUVwENSQpNT1QGPY--

--7ybUy1wd8iBiKpOVtGLIFgTbUBivZSIeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4/W2MACgkQwj2R86El
/qiKSgf9GNJr9UahUABguuxQrXp/xEMdh8cNWCiCfr01TpVdHgkPY14lXRfnWBLC
3DZ0X3MQwlk6K/Au33j7cUUWGmrfGycMrzERJyrRBQbcxvnLgyLNn5tKqCxsb7hi
MA0hMMEn7MIi8Hwu5WT2dZviL4oTJ+8BeTvAyuPDSmYH2f+gIdUat+/zTo6WBtZ8
y233jcq++f3gQpa4XT9T7E8Dutt/p3k3sR4X9muf1D0Te0HPMnmblj4F3uYCbqhj
I3rJoX6SHOgikwPMWnGhYDTem6xhTL8Sd5NzqDZOsjClUixvn85oIzIoLUR4/RPI
KoODYC4Pkd7KDkKmE3XDcxzuZOpEbA==
=HXHc
-----END PGP SIGNATURE-----

--7ybUy1wd8iBiKpOVtGLIFgTbUBivZSIeR--
