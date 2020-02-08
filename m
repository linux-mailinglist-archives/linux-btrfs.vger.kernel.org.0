Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40D115634C
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Feb 2020 08:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgBHH3v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Feb 2020 02:29:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:59591 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgBHH3v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 8 Feb 2020 02:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581146986;
        bh=sVfVYSYVKj2PBdMb5bTs8dTd0t/KD88CPepynCVz2o4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KUPcuy/ajaQ14IG4u05JPk16AwVv0i1nLkdJjWBfYLMGbQxxMg/GgJ0UAfHpNEmt4
         mqy56bYKsz573mozIp7VgC5d9yARs87BP6tNKFO5EUoaywFc0RAwxjxbfJ6TGNZSey
         pLuv5XoqB3J7Di6PV/Hx1f8L37md8/+aUc+bzxRY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYPY-1jT5ns3rzM-00fxJi; Sat, 08
 Feb 2020 08:29:46 +0100
Subject: Re: btrfs root fs started remounting ro
To:     John Hendy <jw.hendy@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
 <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com>
 <CA+M2ft8zMv8nhs6VzZWnzgcP2nRasrwxLzjKgaZPnm_prtWQow@mail.gmail.com>
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
Message-ID: <3e5f4de7-fec1-f8cd-c8b1-20b5a3f38f60@gmx.com>
Date:   Sat, 8 Feb 2020 15:29:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CA+M2ft8zMv8nhs6VzZWnzgcP2nRasrwxLzjKgaZPnm_prtWQow@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tEfmk9hmURTvvhtQb4eDEx43HLNayMowz"
X-Provags-ID: V03:K1:xVzgJZkx1fF26pij7WKgnfcQSPnDksAkWLFvGZYkLvQulETp7eM
 wfFoqMchbntQ4bPQGvsZA6mayVsztpqG/Kx2OrXuKkwIam36xahqFpYV27QC+eh6/GmP5i3
 +DCG04KI7uaNU0haDg7R67wT/IzxtlMKBU1pxTl9ppBpOY034XPWrZn3aejBFH+mLhuIfLj
 BzbqIJpQ6NYnMj9vLpMQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k3qdt/PMY6c=:Cn+AUUCWIywyr+HplISYpv
 PoR1AmdMNGzJgPlEIaByiV85UrOr0IS+tZlOLlw9VW3aEv9tT+X8bdEOGSFTdiTqDkb5EAb+w
 b4EK/apXQ5AxqVXYI+SgJxK8Gl+3Lhbjw/oQP0CS99auSGK1iPB3O48SZ94b/UpDW+gzXK1pg
 f3Q5/Rg11kxDWX5SY+RJeoaw3dqiXD8YwNMg3uRkNsirFVeKvrmvG91mw1OqeuZ7wRXrl9Fiw
 wAUk1V5A+KXqetv6E1h41YLY7n2I+25PzbCA3C1OhKvMXDTqoa3EnS+B9zdGhix3aLfLdJ1F3
 z7ztVfifklh7RB5Ir3wEJjGA9nKZDr86jVeYRe2VaFLfwTUMq690+kXVL5MIBYOoEuK3kvsne
 QYQvx8x9uGz758uotgami8TrVCfTIGJ9cTM/k2TWQ70zRp3+CkTQoXGYIDf0sUGwiNgSetuzO
 lzBY5ajfP5IJm9widXeC0pfjflKHuayKr21i8LzhfdVb93BRrRBlRtffXSxGB1xjkOcwLdCHT
 KFOtwmnUnn60U8XMQ84EtgUQssghlj4mD5PE4/5IYpnEjwFrYlCbvFCHaOBcOBr6cgAKKwiGR
 XZHxfcvKvcss5Ccu9oWuzMSpeGUpdZefX5EaHOWUt/BXyv8X8ljDhgX7p4/zvM2fwAYFYa4et
 oN9jv4KsysPwruA288jA+lytGUZKXYz3o56eZX74iocIWUJExPbefcy085YYyifngFbRKXA2Y
 Ow7RyHf5bY4rYGXiDkUnqpYikZbkKmDEmm0TxC6JFXTfzH4IdENl6DtVS+P9WQUbEuvHgaCYU
 WVZlCdgJGqIvdGEdaZLXn9se8hIQEpqPm7GBgRiXXstq8FM9bfWHe5b4QTPDjS85sJVlL9Bur
 IpNw3XsQsepWn2Q+I1wHopKqTUMarpAHWeKUPoTnkQL8rdo1a5nqT2au/2gta9oExphGRdqhg
 CjthgqHfReCOjKcZad6Py5TLu8b+sq2HkC8iuDVA8/wMhYbs3e+LPeFV7IBtaa4O9yS4tu6P8
 dHyrpDJekglzVJ0Dqk6r46wJJd9UDNZA3h3IVgZCL6N58ghTqdmTWKw2FFpu+GpnOzmB53Y4r
 79dffaXz8+JEZzl1kS4nXmaV5PXhPvvjrSJFckzh5zGJyuHRHlIJ/Kr9ksrtxzitbJpjjCjxb
 9Mq0eo3WqNij/vDY/XSmyEflwXI9CYqmxzCFZGAdOq8fXhy0Er74ZDBZXKlDPnBa8kbOzrsXL
 f+VgC15z/4eYrMnY7
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tEfmk9hmURTvvhtQb4eDEx43HLNayMowz
Content-Type: multipart/mixed; boundary="BN3xnzynjsFcbveqrUDWG9z9DesV9rGtu"

--BN3xnzynjsFcbveqrUDWG9z9DesV9rGtu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/8 =E4=B8=8B=E5=8D=8812:48, John Hendy wrote:
> On Fri, Feb 7, 2020 at 5:42 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/2/8 =E4=B8=8A=E5=8D=881:52, John Hendy wrote:
>>> Greetings,
>>>
>>> I'm resending, as this isn't showing in the archives. Perhaps it was
>>> the attachments, which I've converted to pastebin links.
>>>
>>> As an update, I'm now running off of a different drive (ssd, not the
>>> nvme) and I got the error again! I'm now inclined to think this might=

>>> not be hardware after all, but something related to my setup or a bug=

>>> with chromium.
>>>
>>> After a reboot, chromium wouldn't start for me and demsg showed
>>> similar parent transid/csum errors to my original post below. I used
>>> btrfs-inspect-internal to find the inode traced to
>>> ~/.config/chromium/History. I deleted that, and got a new set of
>>> errors tracing to ~/.config/chromium/Cookies. After I deleted that an=
d
>>> tried starting chromium, I found that my btrfs /home/jwhendy pool was=

>>> mounted ro just like the original problem below.
>>>
>>> dmesg after trying to start chromium:
>>> - https://pastebin.com/CsCEQMJa
>>
>> So far, it's only transid bug in your csum tree.
>>
>> And two backref mismatch in data backref.
>>
>> In theory, you can fix your problem by `btrfs check --repair
>> --init-csum-tree`.
>>
>=20
> Now that I might be narrowing in on offending files, I'll wait to see
> what you think from my last response to Chris. I did try the above
> when I first ran into this:
> - https://lore.kernel.org/linux-btrfs/CA+M2ft8FpjdDQ7=3DXwMdYQazhyB95ah=
a_D4WU_n15M59QrimrRg@mail.gmail.com/

That RO is caused by the missing data backref.

Which can be fixed by btrfs check --repair.

Then you should be able to delete offending files them. (Or the whole
chromium cache, and switch to firefox if you wish :P )

But also please keep in mind that, the transid mismatch looks happen in
your csum tree, which means your csum tree is no longer reliable, and
may cause -EIO reading unrelated files.

Thus it's recommended to re-fill the csum tree by --init-csum-tree.

It can be done altogether by --repair --init-csum-tree, but to be safe,
please run --repair only first, then make sure btrfs check reports no
error after that. Then go --init-csum-tree.

>=20
>> But I'm more interesting in how this happened.
>=20
> Me too :)
>=20
>> Have your every experienced any power loss for your NVME drive?
>> I'm not say btrfs is unsafe against power loss, all fs should be safe
>> against power loss, I'm just curious about if mount time log replay is=

>> involved, or just regular internal log replay.
>>
>> From your smartctl, the drive experienced 61 unsafe shutdown with 2144=

>> power cycles.
>=20
> Uhhh, hell yes, sadly. I'm a dummy running i3 and every time I get
> caught off gaurd by low battery and instant power-off, I kick myself
> and mean to set up a script to force poweroff before that happens. So,
> indeed, I've lost power a ton. Surprised it was 61 times, but maybe
> not over ~2 years. And actually, I mis-stated the age. I haven't
> *booted* from this drive in almost 2yrs. It's a corporate laptop,
> issued every 3, so the ssd drive is more like 5 years old.
>=20
>> Not sure if it's related.
>>
>> Another interesting point is, did you remember what's the oldest kerne=
l
>> running on this fs? v5.4 or v5.5?
>=20
> Hard to say, but arch linux maintains a package archive. The nvme
> drive is from ~May 2018. The archives only go back to Jan 2019 and the
> kernel/btrfs-progs was at 4.20 then:
> - https://archive.archlinux.org/packages/l/linux/

There is a known bug in v5.2.0~v5.2.14 (fixed in v5.2.15), which could
cause metadata corruption. And the symptom is transid error, which also
matches your problem.

Thanks,
Qu

>=20
> Searching my Amazon orders, the SSD was in the 2015 time frame, so the
> kernel version would have been even older.
>=20
> Thanks for your input,
> John
>=20
>>
>> Thanks,
>> Qu
>>>
>>> Thanks for any pointers, as it would now seem that my purchase of a
>>> new m2.sata may not buy my way out of this problem! While I didn't
>>> want to reinstall, at least new hardware is a simple fix. Now I'm
>>> worried there is a deeper issue bound to recur :(
>>>
>>> Best regards,
>>> John
>>>
>>> On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gmail.com> wrote=
:
>>>>
>>>> Greetings,
>>>>
>>>> I've had this issue occur twice, once ~1mo ago and once a couple of
>>>> weeks ago. Chromium suddenly quit on me, and when trying to start it=

>>>> again, it complained about a lock file in ~. I tried to delete it
>>>> manually and was informed I was on a read-only fs! I ended up biting=

>>>> the bullet and re-installing linux due to the number of dead end
>>>> threads and slow response rates on diagnosing these issues, and the
>>>> issue occurred again shortly after.
>>>>
>>>> $ uname -a
>>>> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 2020 16:38:40
>>>> +0000 x86_64 GNU/Linux
>>>>
>>>> $ btrfs --version
>>>> btrfs-progs v5.4
>>>>
>>>> $ btrfs fi df /mnt/misc/ # full device; normally would be mounting a=
 subvol on /
>>>> Data, single: total=3D114.01GiB, used=3D80.88GiB
>>>> System, single: total=3D32.00MiB, used=3D16.00KiB
>>>> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
>>>> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
>>>>
>>>> This is a single device, no RAID, not on a VM. HP Zbook 15.
>>>> nvme0n1                                       259:5    0 232.9G  0 d=
isk
>>>> =E2=94=9C=E2=94=80nvme0n1p1                                   259:6 =
   0   512M  0
>>>> part  (/boot/efi)
>>>> =E2=94=9C=E2=94=80nvme0n1p2                                   259:7 =
   0     1G  0 part  (/boot)
>>>> =E2=94=94=E2=94=80nvme0n1p3                                   259:8 =
   0 231.4G  0 part (btrfs)
>>>>
>>>> I have the following subvols:
>>>> arch: used for / when booting arch
>>>> jwhendy: used for /home/jwhendy on arch
>>>> vault: shared data between distros on /mnt/vault
>>>> bionic: root when booting ubuntu bionic
>>>>
>>>> nvme0n1p3 is encrypted with dm-crypt/LUKS.
>>>>
>>>> dmesg, smartctl, btrfs check, and btrfs dev stats attached.
>>>
>>> Edit: links now:
>>> - btrfs check: https://pastebin.com/nz6Bc145
>>> - dmesg: https://pastebin.com/1GGpNiqk
>>> - smartctl: https://pastebin.com/ADtYqfrd
>>>
>>> btrfs dev stats (not worth a link):
>>>
>>> [/dev/mapper/old].write_io_errs    0
>>> [/dev/mapper/old].read_io_errs     0
>>> [/dev/mapper/old].flush_io_errs    0
>>> [/dev/mapper/old].corruption_errs  0
>>> [/dev/mapper/old].generation_errs  0
>>>
>>>
>>>> If these are of interested, here are reddit threads where I posted t=
he
>>>> issue and was referred here.
>>>> 1) https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_recove=
ring_from_various_errors_root/
>>>> 2)  https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btrfs=
_root_started_remounting_as_ro/
>>>>
>>>> It has been suggested this is a hardware issue. I've already ordered=
 a
>>>> replacement m2.sata, but for sanity it would be great to know
>>>> definitively this was the case. If anything stands out above that
>>>> could indicate I'm not setup properly re. btrfs, that would also be
>>>> fantastic so I don't repeat the issue!
>>>>
>>>> The only thing I've stumbled on is that I have been mounting with
>>>> rd.luks.options=3Ddiscard and that manually running fstrim is prefer=
red.
>>>>
>>>>
>>>> Many thanks for any input/suggestions,
>>>> John
>>


--BN3xnzynjsFcbveqrUDWG9z9DesV9rGtu--

--tEfmk9hmURTvvhtQb4eDEx43HLNayMowz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4+Y2UACgkQwj2R86El
/qiRSQf/bqu9oUabeu1MCKpqwUajWLhUY6ByJOSeiBLkEjEU+mBOKW9saa1p52Li
MYK4Yk1DYk6Nyek+Ifvgzg4k3Wr3A+imnUjb+J8tNPmTGKXTIJUYxlKmhovztV54
QpMR7p+KNkUbvzPefDMZ98dFQ0P8hM0jvN4kr35dNVrJ4ha/hhF23ebFGHpoD+SD
6jxayIijWD5YuBhhoIZBOBP8r7sRGo1XhW3JRvE9uvIeL38XLE6pISwEFBUFgIlZ
3t9vaREhlT8/ASzxly9i02Ern3aqKH5XuFWJIcvsq7Yi+u3C6fDvoKfz05PuR2ub
uJ4xKLoUU8KsfQOPiVcB7z2tvZCEnQ==
=ZPg1
-----END PGP SIGNATURE-----

--tEfmk9hmURTvvhtQb4eDEx43HLNayMowz--
