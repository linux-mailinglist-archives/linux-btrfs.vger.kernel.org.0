Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A18F12CB6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 01:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfL3AqP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 19:46:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:40177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfL3AqO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 19:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577666773;
        bh=RufrQPdYJgiiRTzgnsacq3EJYWB+6Z65XIihBvZDApY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=C4uT4suzG/zcdqbKjvWo4+rS0cFCThrWYy1nP9Z7QoUrtfkrGcqkBu0wuf2IsOpqx
         WtYYibQqRBBeu6obfzmETJgnurrtXnqw8HNE09EDV0j//Sxlfg4bSN62dsaT2o4Xii
         TlqTGv3JvIbA0zSwHIRcURbUh5x3ytiZzJVyK6JE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdNcG-1jL3wq19Ye-00ZSP9; Mon, 30
 Dec 2019 01:46:13 +0100
Subject: Re: read time tree block corruption detected
To:     Patrick Erley <pat-lkml@erley.org>, linux-btrfs@vger.kernel.org
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com>
Date:   Mon, 30 Dec 2019 08:46:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xFKDV7gdT4HYye51uI0B1MSCdo16J0NoA"
X-Provags-ID: V03:K1:YmdTu7M5MDI7e2ORemoVc1ZKCykQKD1A+zECOCw2dkgDsM2Itip
 Hld36uaGKqJJiOydkQkdd9Tnpfi7OtbeasKUK+869pYU+/x+cW3XNvfPEeec8sXfanQUAz5
 A7Zty4rCyCcmECumln05Ow1Dc9VZ2m79QDOxjhamLoeJSg6a0tTgAZdNHP+VZI9tjhxzlXP
 emvq6PiSGKy8aRviUN5ew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eDwoszmOmuk=:olDeot+1FN969BVvnYLxQE
 NYadgvKqoBH4+OOkflbDmA888PnRssI6sPkDjzwnHO0ERd1XwwC0Y/ay3Fheh8iYfW7oNyelR
 03LM/3+omy/qWF8ybruj+4mnQ/yyflnpVYaULl4YgB+e1/hDVOSIkFrQoxy560HJik7QeJOVM
 5hf5jwOWuWFxz4uOWEphCXQmKnVc52ARKgutk6AgwCJ10To9mW+CJ2wEjZLGLZP5xEhbDaa+w
 2dtMa8RX9rTVkz1/4c5scRfvfwqYS5QySUy+FcOooGdXxkGqFpsB1jg2hcUbBijoNGbLJBTOM
 L4P+UQv+OXvfTZsPtAwEBkTpFQiathkGBEuPdy1mmzydlFFqvt/LZuNeOsfuQlklzXP24Huia
 milzQuDJdsrUCmWXZihB6rHPjXapBMAvXDX22kTorF9MSNzD3lTc5iZhf2mJnkb5bWiWpM67G
 CYY7i+mFlXoKGI9RBSKZ/uloS2P8M4sA77bsxtWfjWpg1ahd6KMZvQov2wVpHKNUc2GsCvHCf
 7kRvPYfh2IptM7uPLRBmiMSu3mZQLK1aX+goszbFXk6tE/km/jmWYnJLh6jByUB0YURxI/vWz
 /bgrdSuLFfhNls0i/An1imcnKDuykN3MFZ6TWp+Fx0iQs2G3LasEARAdJTsoqF440kzzCeRri
 FXj+vVgJYmYoBY+10PqG+5C8XZvGsgcNhptXS1kNNl+I5K4lulVsW7wrLgyBgdrjZvVBb0iw+
 0jz2E3s+jHRx7EZrdtYsba/F2C6pvhG07Fw8D2a7+vBU6W1Tcob6NsR5mugRvexuMFZ4bVI1S
 K3kQtOKrY/sSXe+V28gDauzvdg6oBh6W2jLx0gPdXYLANZ6vy24yjUnOleeRV33x9MZbOuA9w
 uAjt6fWNPg6+Ij28a1kcbCCtCb4kIEAXmt1kZSULNizp+xy5AuedXxFN5ZHaYyMS5UEhKWiRT
 yU6zdpIRuKTRZcKu2xCnYX/1vEBUM7nvbBZcbTgqxOq2lbC9DLSq0dVV/g+/buJaSYlu8oZHp
 u7zQO0ADfU0MsRKrlwo0Rhgl3f0/hRqKam5m60E43KN8eGgv6baGXD7lhbNbX2FYmQE02s8PJ
 CVCB3ZOozA5OVmwesza4EwRU+jQ5oPZMwiHUULvNg5ZfYeWbnT26EL/E5JWrgh4LCwx/hCIRN
 ZoDa99B9uubp+uhkZoBo3QZWoggoBHd4p54WGwK2RpHExeb48WsNl431jcnw7JoOtFQpPr5zR
 lCksbkt9DmAoiFLjqDJ+KHhsc7EaqQy9XLkVN3G9uNZaKo65oQJ8m8YDpRGA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xFKDV7gdT4HYye51uI0B1MSCdo16J0NoA
Content-Type: multipart/mixed; boundary="MMDeKXfjrA8cr7yH8D5uzqgPpBt75C6QU"

--MMDeKXfjrA8cr7yH8D5uzqgPpBt75C6QU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/30 =E4=B8=8A=E5=8D=884:43, Patrick Erley wrote:
> On a system where I've been tinkering with linux-next for years, my /
> has got some errors.  When migrating from 5.1 to 5.2, I saw these
> errors, but just ignored them and went back to 5.1, and continued my
> tinkering.  Over the holidays, I decided to try to upgrade the kernel,
> saw the errors again, and decided to look into them, finding the
> tree-checker page on the kernel docs, and am writing this e-mail.
>=20
> My / does not contain anything sensitive or important, as /home and
> /usr/src are both subvolumes on a separate larger drive.
>=20
> btrfs fi show:
> Label: none  uuid: 815266d6-a8b9-4f63-a593-02fde178263f
> Total devices 2 FS bytes used 93.81GiB
> devid    1 size 115.12GiB used 115.11GiB path /dev/nvme0n1p2
> devid    3 size 115.12GiB used 115.11GiB path /dev/sda3
>=20
> Label: none  uuid: 4bd97711-b63c-40cb-bfa5-aa9c2868cf98
> Total devices 1 FS bytes used 536.48GiB
> devid    1 size 834.63GiB used 833.59GiB path /dev/sda5
>=20
> Booting a more recent kernel, I get spammed with:
> [    8.243899] BTRFS critical (device nvme0n1p2): corrupt leaf: root=3D=
5
> block=3D303629811712 slot=3D30 ino=3D5380870, invalid inode generation:=
 has
> 13221446351398931016 expect [0, 2997884]

Inode generation repair is introduced in v5.4. So feel free to use
`btrfs check --repair` to repair such problems.

But please run a `btrfs check` without --repair and paste the output,
just in case there are extra problems which may screw up repair.

Thanks,
Qu

> [    8.243902] BTRFS error (device nvme0n1p2): block=3D303629811712 rea=
d
> time tree block corruption detected
>=20
> There are 6 corrupted inodes:
> cat dmesg.foo  | grep "BTRFS critical" | sed -re
> 's:.*block=3D([0-9]*).*ino=3D([0-9]+).*:\1 \2:' | sort | uniq
> 303629811712 5380870
> 303712501760 3277548
> 303861395456 5909140
> 304079065088 2228479
> 304573444096 3539224
> 305039556608 1442149
>=20
> and they all have the same value for the inode generation.  Before I
> reboot into a livecd and btrfs check --repair, is there anything
> interesting that a snapshot of the state would show?  I have 800gb
> unpartitioned on the nvme, so backing up before is already in the
> plans, and I could just as easily grab an image of the partitions
> while I'm at it.
>=20


--MMDeKXfjrA8cr7yH8D5uzqgPpBt75C6QU--

--xFKDV7gdT4HYye51uI0B1MSCdo16J0NoA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4JSNEXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgQVQgAh2DCMoc7of8Y364D2nyRdzZq
pz7NTxkRuE3i47XI66cGv48IiY8ZYoaq1ot7gOlRJKzK7uzyySd5qXWmvXI998Zy
Hz+dNDWr6ibJ8YPDwKqCx3LnAOtKqaCDnqTbkW3a+3iEMVsCQXiluycbBfZJCsgh
xM2gpWWAM1sy6L8gQ4dEmq7R/gY5J1W/pEOlAxsIBCpxInC4t8vAZtGiF0MixcwF
699HbEPprnPSNRKuzi0nCP8tNREbm3H659/h3jsLCxfBT6jEgJwUuazIEQb8bMWh
PXu0BxkhkN/0oi6Zutv9qVGDmvhxo3Yk/7P3oLv72Ndn8R2MaxGrpdFyj0fM5g==
=XzuQ
-----END PGP SIGNATURE-----

--xFKDV7gdT4HYye51uI0B1MSCdo16J0NoA--
