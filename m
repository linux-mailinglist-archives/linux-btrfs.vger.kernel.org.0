Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C81515619A
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Feb 2020 00:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgBGXmo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 18:42:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:55063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgBGXmo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 18:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581118960;
        bh=X0L4vX9Gg6HJRIkfUdrCLb6rwd5JIFPYmdRJmDdf5zY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=f/12yidmif/vQwu/VnqPqvNdbm45Ctoc92jk6ikvYcKOV9qTMiRgjVmzI5BKUTuSq
         muZLqjlBnbP6MWdTsNG6JblAsKGjyQEQvMzmTGYXj7zUfZN8y5gKRjTCS+u+BSNx/4
         di9+8J32C9gH9EDgt42nHCxmU/8U7ueY7SQMfHqc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlGq-1jUr7v0pBQ-00dldn; Sat, 08
 Feb 2020 00:42:39 +0100
Subject: Re: btrfs root fs started remounting ro
To:     John Hendy <jw.hendy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
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
Message-ID: <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com>
Date:   Sat, 8 Feb 2020 07:42:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mmcQFvDRxXUIr9SANQIX39t78BgCPYIJs"
X-Provags-ID: V03:K1:f4PY41Et4zuuhv7Mvvtg4daXm388/SQL67DLjzf7OiSGuVY52fT
 +QmldzM/IQ+JbMpnLkFe78/jiSjLTpKsZmT5x97X9mczuaS42/b48KYYouNVp7nslw5PlVI
 H7tYJhQ1ZC7eXtzRz8OF381qr59OnoGXE5/FDBF+4P4A62FTKAOWXC85jCGYAbp/QUxsTFY
 rtDvzfHIMiLEMTGIBtVAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jIqrZHFl+lc=:vYGBA/5pP0wjZWPaciNyT9
 3BQoo/XdqLW0i24VU3/2hw2rnXp2AUD5OXwjJXUo8bChg9APJ/oE1/OXsCVwls0ww9Qdi6wQu
 SzwBuZgW2wAlqx6ok40S+fOClta60WW/CAJowWE+4Yfa/eSBvBaUOQdRSd2fsmMaVY0TwmRDT
 goNWXGKxh94j+i+pQCZvI34MolKqPvCzJ9SWCCum90I8PHkn69Wjlp+T2fGnqrd4uE4Hyz35s
 5xKhAi22ulr2Iqdr45Ka0GlFbJ8ygZJhlgouHOADRj1YiXSAC0TzfylQYNeTYnzE16nDJ9fG5
 U+8+QG0FHO/WJiq0OVTu7paNzjg8Q6LGEC5NYz2N5MPv81XmsWyut83cJMpo60hWmVPDw98oM
 dEapMXZxG9KIxUbNEZm0oo1jzylQZD8NQYvJNId4g9jcO+RbSJB0gWP0agHhOwmoQb3JTw5aZ
 Syma1rUyfR15JaN99ArGHM/PlNgV1VYzBxysGATHxeEq6f7A+3eHP2Y24V7MrSKaqu1SHyQWs
 B0XO3judezmPbmNKgXPTNKV4d/+yfnI1ZpR1WyTIaqwI4prVxJo1/ZHcrwZkRIF6seeGURhPx
 Ktf9EiH/IuWTrvRzsMO+Ymu7YIMDX7xXDnYghcq83/xg0BK93+U3kpU3KEcBFD9AMJcv9cTQ7
 29kLs+RVdK1uvXZZJ6AW3/ThC7jPlP11MWJSdasOvZ9ojTkPSxaQHNcYMg7dnD1e2WCO9JXqu
 GHW0nPvAcAUDV9O1nZXqyRDqQY5mKkz/x0nVk0AD7y2lV3lWKb61BjdIQrq1Jp2nkzpuNnLYA
 ytyT5Q5oCm7aSYMx5XJPz7sMObn2WhNNs4zNpdea5GiS2mHrrEM6tT1XGTiTK99v5B1/7pOc+
 8RMr9NoHAAXn/nDiPsG8B6/FoxZanRVjx5CigBlprIl2ZbP6iK5tBt3AN96UrtQAm03zyYX9r
 hwbrhPjLbWCAso7v0sM730TUItNarXWi8vKcYv1m3502BPZOZFfToDX/ybIjC3IPD+GOODVca
 bwqL538sLcIUb2biqHOpdAL0pU+MEJuLrbx9jW7TnTSM87g5qVXhIDXyDWrjiyrSp2SPBAPaw
 I+bEY25jZ7SzeJo9sQsObO/5MrQzSyr10wjO3tS5FVjN84BiLelGMpcQK1akzfmC7LCHh3ofQ
 5Kisw4oqopSxyOfU2icr8CwMpuyWy8T6loIa4cjWwH8EzeVL0Z6Eif2ektBYtk4IHOEyGixBL
 gNmOTLI2fXJ3ZMoAJ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mmcQFvDRxXUIr9SANQIX39t78BgCPYIJs
Content-Type: multipart/mixed; boundary="jG2uzJEWBVON070JwYK0v6m44c2oShGpe"

--jG2uzJEWBVON070JwYK0v6m44c2oShGpe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/8 =E4=B8=8A=E5=8D=881:52, John Hendy wrote:
> Greetings,
>=20
> I'm resending, as this isn't showing in the archives. Perhaps it was
> the attachments, which I've converted to pastebin links.
>=20
> As an update, I'm now running off of a different drive (ssd, not the
> nvme) and I got the error again! I'm now inclined to think this might
> not be hardware after all, but something related to my setup or a bug
> with chromium.
>=20
> After a reboot, chromium wouldn't start for me and demsg showed
> similar parent transid/csum errors to my original post below. I used
> btrfs-inspect-internal to find the inode traced to
> ~/.config/chromium/History. I deleted that, and got a new set of
> errors tracing to ~/.config/chromium/Cookies. After I deleted that and
> tried starting chromium, I found that my btrfs /home/jwhendy pool was
> mounted ro just like the original problem below.
>=20
> dmesg after trying to start chromium:
> - https://pastebin.com/CsCEQMJa

So far, it's only transid bug in your csum tree.

And two backref mismatch in data backref.

In theory, you can fix your problem by `btrfs check --repair
--init-csum-tree`.

But I'm more interesting in how this happened.

Have your every experienced any power loss for your NVME drive?
I'm not say btrfs is unsafe against power loss, all fs should be safe
against power loss, I'm just curious about if mount time log replay is
involved, or just regular internal log replay.

=46rom your smartctl, the drive experienced 61 unsafe shutdown with 2144
power cycles.

Not sure if it's related.

Another interesting point is, did you remember what's the oldest kernel
running on this fs? v5.4 or v5.5?

Thanks,
Qu
>=20
> Thanks for any pointers, as it would now seem that my purchase of a
> new m2.sata may not buy my way out of this problem! While I didn't
> want to reinstall, at least new hardware is a simple fix. Now I'm
> worried there is a deeper issue bound to recur :(
>=20
> Best regards,
> John
>=20
> On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gmail.com> wrote:
>>
>> Greetings,
>>
>> I've had this issue occur twice, once ~1mo ago and once a couple of
>> weeks ago. Chromium suddenly quit on me, and when trying to start it
>> again, it complained about a lock file in ~. I tried to delete it
>> manually and was informed I was on a read-only fs! I ended up biting
>> the bullet and re-installing linux due to the number of dead end
>> threads and slow response rates on diagnosing these issues, and the
>> issue occurred again shortly after.
>>
>> $ uname -a
>> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 2020 16:38:40
>> +0000 x86_64 GNU/Linux
>>
>> $ btrfs --version
>> btrfs-progs v5.4
>>
>> $ btrfs fi df /mnt/misc/ # full device; normally would be mounting a s=
ubvol on /
>> Data, single: total=3D114.01GiB, used=3D80.88GiB
>> System, single: total=3D32.00MiB, used=3D16.00KiB
>> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
>> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
>>
>> This is a single device, no RAID, not on a VM. HP Zbook 15.
>> nvme0n1                                       259:5    0 232.9G  0 dis=
k
>> =E2=94=9C=E2=94=80nvme0n1p1                                   259:6   =
 0   512M  0
>> part  (/boot/efi)
>> =E2=94=9C=E2=94=80nvme0n1p2                                   259:7   =
 0     1G  0 part  (/boot)
>> =E2=94=94=E2=94=80nvme0n1p3                                   259:8   =
 0 231.4G  0 part (btrfs)
>>
>> I have the following subvols:
>> arch: used for / when booting arch
>> jwhendy: used for /home/jwhendy on arch
>> vault: shared data between distros on /mnt/vault
>> bionic: root when booting ubuntu bionic
>>
>> nvme0n1p3 is encrypted with dm-crypt/LUKS.
>>
>> dmesg, smartctl, btrfs check, and btrfs dev stats attached.
>=20
> Edit: links now:
> - btrfs check: https://pastebin.com/nz6Bc145
> - dmesg: https://pastebin.com/1GGpNiqk
> - smartctl: https://pastebin.com/ADtYqfrd
>=20
> btrfs dev stats (not worth a link):
>=20
> [/dev/mapper/old].write_io_errs    0
> [/dev/mapper/old].read_io_errs     0
> [/dev/mapper/old].flush_io_errs    0
> [/dev/mapper/old].corruption_errs  0
> [/dev/mapper/old].generation_errs  0
>=20
>=20
>> If these are of interested, here are reddit threads where I posted the=

>> issue and was referred here.
>> 1) https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_recoveri=
ng_from_various_errors_root/
>> 2)  https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btrfs_r=
oot_started_remounting_as_ro/
>>
>> It has been suggested this is a hardware issue. I've already ordered a=

>> replacement m2.sata, but for sanity it would be great to know
>> definitively this was the case. If anything stands out above that
>> could indicate I'm not setup properly re. btrfs, that would also be
>> fantastic so I don't repeat the issue!
>>
>> The only thing I've stumbled on is that I have been mounting with
>> rd.luks.options=3Ddiscard and that manually running fstrim is preferre=
d.
>>
>>
>> Many thanks for any input/suggestions,
>> John


--jG2uzJEWBVON070JwYK0v6m44c2oShGpe--

--mmcQFvDRxXUIr9SANQIX39t78BgCPYIJs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl499ewACgkQwj2R86El
/qicUQf/UVcnOx5wja5jXX4zwtbXC1v9X/PXbRs+K9kG7VnAJNzsxpyp5qkdT7q6
n0ynxh9skOGAOuymvYpKvBNRlC71ZJl0ZNApCf4x1S2iiJMxE0EkjutJSDtnu11q
IbeZH+pVq/QmUyWnz86HGJgx1JrX4SJ+6YG+dgJRYYFDoCr1udM8zx3sQdAJRFNL
/7upeUR+qs+MB8FyAjNgiA9iDiYQnozvbM8C1jOx/PWUFSIwyd7Yj1oIJHrES26T
5szYt2aii8om9Hmu13aF9tPqJY1CqZzD2BBrCEtHzXdYbEr2YVpse9b8/5AkgR/n
xbHqLJBA+FCGERPFjbaVAPn1/oc67Q==
=myGs
-----END PGP SIGNATURE-----

--mmcQFvDRxXUIr9SANQIX39t78BgCPYIJs--
