Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C4114A1A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 01:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfLFAFL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 19:05:11 -0500
Received: from mout.gmx.net ([212.227.15.18]:56425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfLFAFL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 19:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575590704;
        bh=SyzVNAJ5KaxlL1XicVR5NpAAul8MU4A5znVgSDO+nTs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZIDOuOg+9zKZSRku+8afO8ZozS4y5PEB0I4SXOPGTiovAcYg9dYjMhVHm6CgrptEM
         0uEAyp9TXbRKWRAkyatV49P8eHiWf07mxxSLc3jk367kAav3crfN+e7DhzFjtlIePH
         Ey23aXh/6Ov4AdUETc5aSS7rYpkAApP5O59iFzFk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MI5UD-1ia0hk2PWZ-00FE31; Fri, 06
 Dec 2019 01:05:04 +0100
Subject: Re: is this the right place for a question on how to repair a broken
 btrfs file system?
To:     Christian Wimmer <telefonchris@icloud.com>,
        Hugo Mills <hugo@carfax.org.uk>
Cc:     linux-btrfs@vger.kernel.org
References: <A01B0EC4-8E96-486B-A182-76B74AD0F97D@icloud.com>
 <20191205202449.GH4760@savella.carfax.org.uk>
 <61D37CED-8564-49BC-9388-4A8511C3AC50@icloud.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <522495ca-ed55-dd81-a819-dab93e67d0aa@gmx.com>
Date:   Fri, 6 Dec 2019 08:04:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <61D37CED-8564-49BC-9388-4A8511C3AC50@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xde5Pth77EycHjSn71VEytYqswJF2j49r"
X-Provags-ID: V03:K1:4cYbN2IbX3Fk6/MFXDPqSXMFR3XsxankCdXILLEWq0XHcWKzltE
 fxPHXm004jQG0ws+7hyIpGYhUqDZ78A99ym7CtYEWdVC2F1Jk47CAGTXaRynpxIWMrwWaud
 +81Azne773XyVbqU+FxKjaJTstJD5a6K1oKVGwPiK88KMH4vB6RN35jzGV/GmYOcKe4ooYa
 6uAVneZW8ua/eMEzH/fVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7xD1p0cPJ4M=:/f7DOXQCpKmB4bbbsDtAds
 blNb6FBUmjNy+YshsKKq7dyVpWpX6IzcCwbZ6HCcniNukemPvOOprXG+ETsGJCMuvEm3MskIa
 mCNUr1WPmVacsug9obyKf6rxHPfawpndckV8wL1HF+f5/VkAW/Cv6yGtaiZxOqoD9QmGOL3GX
 +r9YSHGtvMVayC9BMLH6euQSqUv7naYAI4YkxJ4qK6uwOtr3wFuh2wFcsfUmKst2IeTqWOc0w
 nMjLifWFFwV536gUBn2m6HA2n3x7QhnSvuzbvZwU2pl+EkfpZXJLqjjmeoaSb+Uzuzbk7JsIE
 VzVEZNJtXG/YsYa0kPb6BuchDscdCBWwoBIGid6tCT2Wthd5xPdu3To5ReqVUtShQlioFWfz1
 NvZ5ppuJY/lVY2BaLskUGqZzGthqhmf04lb08QWYHzmU6NXaKvGi3+NMRV0EQ4HA85Y3t9x7B
 A3cDkDF3u5V5P6BQVQNsux7ZqEIUemVS1r+UmMUxfGsKgIN7ZckTo2o8EjDsAge6diJdXvo4w
 XGtRuZWhtZACDuPun3J/mO3N0ad+hvryHA4MrGDC4DT9uaS+CTeXmz+bM8oTzDDQypW59K8Fh
 8t0rGV8idtFqZfD38qaalrkrs2INlW3GU1TVA9MP8EU/ATtFHcfPofA4Aw0nMgGfM3H9lH6Y8
 YEetPkLGG5FPN6zUXLBVxI+rGHJD0Eej/3lxrIAea95aS+2OjErcLLTZrU7AYQwL1xFV3JIvM
 7BIwb2L0l3iVX/rXfmaNTb/cuMGK9ET1PACeGfecO+mhLXCy4nIL5hJBuw3+Ofo9y0hsXmqM6
 ugc9QFXAhK4dJdM1x3ASml5a1T7p2bZmq7lRBQQh5ED73eczErklVJOd5pdpmYkFUzUzIU8Dh
 4jUa4q3pwlVI49CqkmHfeflOXFV3ma3+3oPWmIWxn0/lU43xWrQ6a1Byf3aCoTsO5KDyUfuLb
 koGYoADVIcxye4Rlh7oA4CFwBertHYRdOUveAdrfi9Y/yej7LVkVV9UIniBwL1Kxq5WkIeJ9P
 +ZsZgsPS6tdTyynKH7B+pjgMpo/bKUOFyQ5X42GeYQWUz4oXEjFhVvvNzF8X2XiR6pucwPLU0
 7QYEJdC5ohfffodzMSsQtd70XOZ7GkAlG0h46XhtT+iG502scBoypXSk+DD9tiXt0T+fCYLAW
 9ImemW7ElqcYY1yc9tJjWjq7duVM1xrqhNTMie3Q9qvKSG+YkpZzoN4zt/8d5tgIm9jpznF7/
 yge3/fOreHD9Yg8CnWFp5MxANbsgxFxkUtzqz+1Y4vfuwDuAhMug40DPjLV4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xde5Pth77EycHjSn71VEytYqswJF2j49r
Content-Type: multipart/mixed; boundary="6y53NsnkAf3PQDIMIAtLKckaAsoHCZI2B"

--6y53NsnkAf3PQDIMIAtLKckaAsoHCZI2B
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/6 =E4=B8=8A=E5=8D=884:42, Christian Wimmer wrote:
> Hi Hugo,
>=20
> I am so happy to hear your voice!
>=20
> I would be very happy if you could help me get my filesystem back worki=
ng.
>=20
> Here is my setup (little special):
>=20
> Mac Mini 2018
> Inside Mac Mini I run Parallels and inside Parallels I run Suse 15.2
> Promise Pegasus R8 with 32TB, divided into a 24TB and 4TB partition for=
matted under Mac OS.
> Inside Promise Pegasus Storage (the 24TB Partition) I have the virtual =
disc that is attached to the Parallels Linux.
> This virtual disc is formatted with btrfs and appears in Linux under:
>=20
> Disk /dev/sde: 11.7 TiB, 12884901888000 bytes, 25165824000 sectors
> Disk model: Linux_raid5_12tb
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 4096 bytes
> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> Disklabel type: gpt
> Disk identifier: 2EFA3FA4-8849-40CE-A065-6CDF3581894B
>=20
> Device     Start         End     Sectors  Size Type
> /dev/sde1   2048 25165821951 25165819904 11.7T Linux filesystem
>=20
>=20
> When I try to mount it this happens:
>=20
> # mount /dev/sde1 /home/promise/
> mount: /home/promise: wrong fs type, bad option, bad superblock on /dev=
/sde1, missing codepage or helper program, or other error.
> #=20
>=20
> dmesg says:
> [ 2376.180819] BTRFS info (device sde1): disk space caching is enabled
> [ 2376.180820] BTRFS info (device sde1): has skinny extents
> [ 2376.275469] BTRFS error (device sde1): bad tree block start 14275350=
892879035392 5349895454720
> [ 2376.283339] BTRFS error (device sde1): bad tree block start 14275350=
892879035392 5349895454720
> [ 2376.344799] BTRFS error (device sde1): open_ctree failed

For btrfs, we'd recommend to use at least latest LTS kernel.

Although SUSE is supporting BTRFS, its SLE kernel is still a little
older, not the best place to start for data salvage.

For your case, later kernel will output which tree is corrupted, so we
could provide a lot of good info.

>=20
>=20
> The command btrfs restore tells:
>=20
> linux-ze6w:/home/chris # btrfs restore -x /dev/sde1 test/
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, ha=
ve=3D14275350892879035392
> Couldn't setup device tree

Device tree is completely fine to lose. We can easily rebuild it if it's
the only corruption.

Would you please try the following dump?

# btrfs ins dump-tree -t root /dev/sde1 2>&1
# btrfs ins dump-tree -t extent /dev/sde1 2>&1 >/dev/null
# btrfs ins dump-tree -t chunk /dev/sde1
# btrfs ins dump-tree -t 5 /dev/sde1 2>&1 >/dev/null
# btrfs ins dump-tree -t <subvol_id> /dev/sde1 2>&1 >/dev/null

Except the chunk and root tree dump, we only care about the stderr, to
make sure no tree corruption.

If no other error happened, we can easily ignore device tree error.


Furthermore, for newer btrfs-progs, we will automatically ignore device
tree if we can't read it.
Thus it can continue salvaging your data.

Thanks,
Qu

> Could not open root, trying backup super
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, ha=
ve=3D14275350892879035392
> Couldn't setup device tree
> Could not open root, trying backup super
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, ha=
ve=3D14275350892879035392
> Couldn't setup device tree
> Could not open root, trying backup super
> linux-ze6w:/home/chris # btrfs restore -v /dev/sde1 test/
>=20
>=20
> Now what I did in order for all this to happen was the following:
>=20
> I was editing a file inside Linux with sublime_text.
> Inside this editor I wanted to "replay macro=E2=80=9D and the command f=
or it is CTRL-ALT-SHIFT-Q which is the same command for rebooting the MAC=
=2E
> When I pressed that command it was already too late and my Mac began to=
 reboot, doing a suspend of the virtual machine.
> So far so good.
> I rebooted the MAC and started Parallels and the suspended Linux woke u=
p again and I entered in the /home/promise directory where /dev/sde1 is m=
ounted and I say only some=20
> files instead of all 5TB data. Some directories were empty, some had br=
oken links and so on.
> So I discovered that something went wrong during reboot and thus I shut=
 down the linux.
> When I started linux again, I could not mount any more the promise.
>=20
> Please help me to get out of this.
>=20
> I did a backup of the 5,5TB hard disc file of Parallels, so we can play=
 a little.
>=20
> What would you suggest to do?
> Actually I do not need all files of that disc, only some. IS there any =
chance to mount and copy what I need?
>=20
> Thanks a lot for your patience and your time for reading this Hugo.
>=20
> Best regards,
>=20
> Chris
>=20
>=20
>=20
>=20
>> On 5. Dec 2019, at 17:24, Hugo Mills <hugo@carfax.org.uk> wrote:
>>
>> On Thu, Dec 05, 2019 at 05:00:40PM -0300, Christian Wimmer wrote:
>>> Hi, my name is Chris,=20
>>>
>>> is this the right place for asking on support on how to repair a brok=
en btrfs?
>>>
>>> There is no hardware problem, just that the power went out and now I =
can not mount any more.
>>
>>   What does dmesg say when you try to mount the FS?
>>
>>> Who is the best specialist that could help here?
>>>
>>> Of course I already scanned the WEB some hours and tried all not-dest=
ructive commands without success.
>>
>>   "Non-destructive" is a fairly limited of things, and most of the
>> easily-findable advice on the web about fixing btrfs filesystems is at=

>> best badly misguided, if not actively wrong. :(
>>
>>   Can you also tell us exactly what you ran?
>>
>>   Hugo.
>>
>> --=20
>> Hugo Mills             | Is it true that "last known good" on Windows =
XP
>> hugo@... carfax.org.uk | boots into CP/M?
>> http://carfax.org.uk/  |
>> PGP: E2AB1DE4          |                                       Adrian =
Bridgett
>=20


--6y53NsnkAf3PQDIMIAtLKckaAsoHCZI2B--

--xde5Pth77EycHjSn71VEytYqswJF2j49r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3pmysXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjyYwgAryv2o+DoK64dCybnyScj1BSI
DqYh6F7Q5qn1QH5MU9XlyWR7fcuknq4PcH2ZFWkpk3AvGBax8ydMHO/0wXvrl3Pm
tSC5NHFP60/zMEbt/Wr9f8Q1/ikb6x+GLMLMe3dUC7+d8EDlHw4gbKROyvI+PEbD
Zc4LKXMmyzTFHLFalvxtYXAQdxM0ASkk6EaeMdH8pJgV8gAA4X7qKYEhdR0vUvDf
FHg8cFNSxSU8u92cCffnhqF+eXFQlqjzLTWYQl9mJgOEpxzbD+Zc0BhZniwrECfk
MubXUA1tLrC/7bL9eGlDBKmWDAWg4xi7vgmRbxIXO6FSCRRetDRXp7wPxuJvFA==
=1Bn/
-----END PGP SIGNATURE-----

--xde5Pth77EycHjSn71VEytYqswJF2j49r--
