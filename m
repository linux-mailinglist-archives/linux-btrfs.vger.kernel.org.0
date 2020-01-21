Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEDD814355C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 02:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAUBtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 20:49:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:38199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgAUBtT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 20:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579571357;
        bh=jE7D/EY/WvK53eoUfRKxkqlVTWSdp/DaAO0iQvwGfJQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ka0bUPIKWAv35+NpznYGIjVjHB2VWxA/0lAi0svcQReN+Xe0CHEIGbI48F8Zxir/E
         AG2Rsw7pMs3O3BofrTvAFtM+2sRJYWJMAKhje1K9VULc8pDdcBRLaPZuL1Gxc3s3/n
         Y8vpyIYPNTM6VQPrm6VcbONjMXfLyqnXY21+jHiM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZkpb-1j5V3j1jS3-00Wku7; Tue, 21
 Jan 2020 02:49:17 +0100
Subject: Re: BTRFS failure after resume from hibernate
To:     Robbie Smith <zoqaeski@gmail.com>, linux-btrfs@vger.kernel.org
References: <CACurcBus8d2RYTtVOheAvJcohY5jmP=akKUw1hen5seccfGihA@mail.gmail.com>
 <91be9396-4142-94ba-ea79-0baf8dc4800a@gmx.com>
 <CACurcBtC3ynvVcgS0yo2aNkxELxevc9Y=LO9eQ+hZSoB+3cMDQ@mail.gmail.com>
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
Message-ID: <3af6a8b4-4102-4f4e-67f7-deda839e0cf5@gmx.com>
Date:   Tue, 21 Jan 2020 09:49:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CACurcBtC3ynvVcgS0yo2aNkxELxevc9Y=LO9eQ+hZSoB+3cMDQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WUkHkIstGq0qWNu7XyuXg3R79dDYNP4yp"
X-Provags-ID: V03:K1:PsclRkAv51EOIDfTORlBSaafQuB9J6njF+jkGgwXTT4aOx636mj
 oEmoTROZtcbRYPauX6HZkB86FrsFD8hV2HcR1ygKD4bjZdG5nZsKSlNfwp5JKo3RtLgKrFM
 dCcl+cXC/FHBljh4ll9MFNqTNyOnP1W0cWaVEggvcoUzkvVclA8SIyZsWYlDbsAF858N61a
 dkOCaU59XY5g7P8Yh/Z3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H/yCicDiLc4=:GmIPF3mkKhL1HqNtNdcutY
 ppKGzwjGf3wVwbY/+zmYXxXQlHmUnJplMfYao0dCWA2/C+jqbjf8WkEhI8L5IKhT06vTVcoC7
 pgC673TSE+n9beMEeqmXHNr9cBdtrCbf7qOS4NZHkdJB2O+jt4jpl0D8lXHyJa+AM1/uFZ5kW
 Cn2ZLj/KzMtPGzm3101Eq8yAEcPYjoLc05Jv7FKqKajCEfEvZJQH4VzQ58nfFqGyAEnpF5g2B
 kCK4LH80pXeIogSOn2lcPXEKXltCWapty4RdNUGHxC5FOKyBBH6XRj8qMXIEYoILh2RmZ2A3D
 xh/YkJsduTWl9+ECh3o0BFJRzEn8OMYxm3IIbw8/e5NroCjiWp+uCZqTaz3KMIG1+3Pl1OYeO
 sotyHUirY5FiIPLrYosMqt36u9W5vIAP19URhTko4igLymJ81X0qSy2kbHclMZ92JdbArRZwY
 SY0QbAY5kbVl00boX1+sh2kn2izJnclIpcjY/0nGBcsS7oUFXHY5wo/e6EifVFYVdmLu+wLhE
 zfidpjw8SYSvBT88QlZgTzOaZXP2wsefGqaHlOZuR+HZ0yszizTVJJKPsQ5yvg6+5lbm3IYJP
 vnQlg7N5ixiBJ/DI3xE2hMduG+Ihg5uCDqADeiQghX9i2XCMrCNa/1rJyyTOlSVXptFdtfHw4
 Qr/5LCAuz+GuwnjSlH23053ysVU1EJQGokWZm6TtbIUu7jS8+YNGh6a5vloy4JAeKqm7Gks5J
 mQB+jYHLYF1VY0XyMMX8TBiSXdhwnQ8DjHYfmkcdISvT3fKXBoMmYjxpmMCHm3lG6yN1Drd8V
 t18aJRX5xrM+6o7Npy1/3hiVMk56ROXcDGtmTPcJ9yHeq1McB2oFGaTV+egXzik8aeKllRiNz
 i1jGn7aLAsJLHmKwTbZRhQtCpeaVnj96glwBnu7v1o/WEt9k6HrvivimkOrKhedH1WJA/93Tj
 fDXqpXw9v8BMoVZFXRHuAMV79LZ/XcY955XDg5LWUcLcPivhjmDAgotmy3LgzoWqlFYedXJSb
 I+q+3eaYWeJ9mhr6f7PWBIhBwwzVdYN9PWiknY83iEolFaRevNIU5G1ua6vlXu0HEX+Spak78
 LYgmmLjzAW1oBTA4nxCahb/drQYj3bzqffo0ThCXQ/bopqygxOgCewgTh8NAU8zYzbuZ95M30
 TWifxwTGAEYKE0DtwDuqweM+5WNDqVkw2aq0MXgHrZtYXfeWuWh87Xn0uv86gx9yo4gviH8TV
 IkDtUr+eOJczopWdRWKZMcyH3SZtPBIusLvdvV0jruhXuhzrLRy3n65CinCw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WUkHkIstGq0qWNu7XyuXg3R79dDYNP4yp
Content-Type: multipart/mixed; boundary="iy0endARZw6ALMipnY2d3t8raP39SWJc9"

--iy0endARZw6ALMipnY2d3t8raP39SWJc9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/21 =E4=B8=8A=E5=8D=889:39, Robbie Smith wrote:
> On Tue, 21 Jan 2020 at 11:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:=

>>
>>
>>
>> On 2020/1/20 =E4=B8=8B=E5=8D=8810:45, Robbie Smith wrote:
>>> I put my laptop into hibernation mode for a few days so I could boot
>>> up into Windows 10 to do some things, and upon waking up BTRFS has
>>> borked itself, spitting out errors and locking itself into read-only
>>> mode. Is there any up-to-date information on how to fix it, short of
>>> wiping the partition and reinstalling (which is what I ended up
>>> resorting to last time after none of the attempts to fix it worked)?
>>> The error messages in my journal are:
>>>
>>> BTRFS error (device dm-0): parent transid verify failed on
>>> 223458705408 wanted 144360 found 144376
>>
>> The fs is already corrupted at this point.
>>
>>> BTRFS critical (device dm-0): corrupt leaf: block=3D223455346688 slot=
=3D23
>>> extent bytenr=3D223451267072 len=3D16384 invalid generation, have 144=
376
>>> expect (0, 144375]
>>
>> This is one newer tree-checker added in latest kernel.
>>
>> It can be fixed with btrfs check in this branch:
>> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
>>
>> But that transid error can't be repair, so it doesn't make much sense.=

>>
>>> BTRFS error (device dm-0): block=3D223455346688 read time tree block
>>> corruption detected
>>> BTRFS error (device dm-0): error loading props for ino 1032412 (root =
258): -5
>>>
>>> The parent transid messages are repeated a few times. There's nothing=

>>> fancy about my BTRFS setup: subvolumes are used to emulate my root an=
d
>>> home partition. No RAID, no compression, though the partition does si=
t
>>> beneath a dm-crypt layer using LUKS. Hibernation is done onto a
>>> separate swap partion on the same drive.
>>
>> Please provide the output of "btrfs check" and kernel version.
>=20
> Here's the kernel and btrfs information:
>=20
>> # uname -a
>> Linux rocinante 5.4.10-arch1-1 #1 SMP PREEMPT Thu, 09 Jan 2020 10:14:2=
9 +0000 x86_64 GNU/Linux
>>
>> # btrfs --version
>> btrfs-progs v5.4
>>
>> # btrfs fi df /
>> Data, single: total=3D541.01GiB, used=3D538.54GiB
>> System, DUP: total=3D8.00MiB, used=3D80.00KiB
>> Metadata, DUP: total=3D3.00GiB, used=3D1.56GiB
>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>
>> # btrfs fi show
>> Label: 'rootfs'  uuid: 25ac1f63-5986-4eb8-920f-ed7a5354c076
>>         Total devices 1 FS bytes used 540.11GiB
>> devid    1 size 794.25GiB used 547.02GiB path /dev/mapper/cryptroot
>=20
> I tried a btrfs check and it failed almost immediately.
>=20
>> # btrfs check /dev/mapper/cryptroot
>> Opening filesystem to check...
>> ERROR: /dev/mapper/cryptroot is currently mounted, use --force if you =
really intend to check the filesystem
>>
>> # btrfs check --force /dev/mapper/cryptroot
>> Opening filesystem to check...
>> WARNING: filesystem mounted, continuing because of --force
>> Checking filesystem on /dev/mapper/cryptroot
>> UUID: 25ac1f63-5986-4eb8-920f-ed7a5354c076
>> [1/7] checking root items
>> parent transid verify failed on 223455674368 wanted 144355 found 14437=
6
>> parent transid verify failed on 223455674368 wanted 144355 found 14437=
6
>> parent transid verify failed on 223455674368 wanted 144355 found 14437=
6
>> Ignoring transid failure
>> parent transid verify failed on 223452872704 wanted 144358 found 14437=
6
>> parent transid verify failed on 223452872704 wanted 144358 found 14437=
6
>> parent transid verify failed on 223452872704 wanted 144358 found 14437=
6
>> Ignoring transid failure
>> ERROR: child eb corrupted: parent bytenr=3D223602655232 item=3D233 par=
ent level=3D1 child level=3D2
>> ERROR: failed to repair root items: Input/output error

The corruption looks happened on root tree. Which is mostly ensured to
cause problem for next mount.

It's highly recommended to start data salvage.

>=20
> I haven't rebooted the laptop, in case this issue makes the laptop
> unbootable, but I could try re-running the check from a live USB and
> an unmounted filesystem. My Arch Live USB is from June last year, and
> it's got kernel 4.20 and btrfs-progs 4.19.1 on it=E2=80=94will they be =
new
> enough, or should I fetch the latest Arch disk and flash a new one?

I don't believe newer btrfs-progs can handle it at all.
But you can still consider it as a last try.

BTW did you have anything weird in dmesg?

>=20
> In answer to Nikolay's questions, both Windows and Linux share a disk
> but are on separate partitions, and Windows did update itself. I've
> had Windows updates occur while Linux is hibernated before, and it has
> no reason to touch a partition it can't read and never mounts.

For the cause, I don't believe it's related to Windows, but the
hibernation part.

Not sure how hibernation would interact with fs, but my guess is it
should at least sync the fs.

Anyway, if something extra happened, dmesg should have some clue.


Another possible cause is, some older (still v5.x) upstream kernel had
some bug, e.g. before v5.2.15/v5.3 there is a bug in btrfs which could
cause part of metadata not synced to disk, causing the same transid
corruption.

And since you're not rebooting, but only hibernate, the problem remains
undetected until today...

Thanks,
Qu

>=20
> Robbie
>>
>> Thanks,
>> Qu
>>
>>>
>>> This is the second time in six months this has happened on this
>>> laptop. The only other thing I can think of is that the laptop BIOS
>>> reported that the charger wasn't supplying the correct wattage, and I=

>>> have no idea why it would do that=E2=80=94both laptop and charger are=
 nearly
>>> brand-new, less than a year old. The laptop model is a Lenovo Thinkpa=
d
>>> T470.
>>>
>>> I've got backups, but reinstalling is a nuisance and I really don't
>>> want to spend a couple of days getting the laptop working again. I
>>> don't have a conveniently large drive lying around to mirror this one=

>>> onto.
>>>
>>> Robbie
>>>
>>


--iy0endARZw6ALMipnY2d3t8raP39SWJc9--

--WUkHkIstGq0qWNu7XyuXg3R79dDYNP4yp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4mWJkACgkQwj2R86El
/qi3eQf+I96jrB3AEtI6R1SA9dOGA6a1Y1Mf+Tg7IXx2jwTGYURYmcJP9YJnpKSy
BeRP5nRS9YjpNUQda+LDGYM8BlZn7JVjucxW9a4U2flmIkD6+Ndc5drCaim3yj+a
k4eA98dwjQItLDwW0RPJMAwAPt20QAENjwCiQ8/keda1Xdqc/XwvsR/hYnpFMmyO
wesN3Dn3KfmyN3Ezh0H7OrW7x+Swuug56D6gq/aGw6J+8wLqkBvlxYBaIOM1O0/q
LG6fDdLGj+3Zk7o4HTgoC57BT6KKiI/9qaafiE73Fr3GEAMiDdGhcLFApPuULpih
cB2UJEtwd05XCglJlOs3ZqQ3ZiAO7w==
=0srZ
-----END PGP SIGNATURE-----

--WUkHkIstGq0qWNu7XyuXg3R79dDYNP4yp--
