Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E1F1DC809
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 May 2020 09:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgEUH4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 May 2020 03:56:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:50129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgEUH4S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 May 2020 03:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590047765;
        bh=9KO+BHXrAe6JXEng0Y8bFlZARtusT/UWm1U4WheXr1Q=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AA0UVTN5kKG8cZOCvEb3Rk2GqOHfMiRV0MtkvNyspdOs3lasjynfA8Yl0eIGIxSHz
         TV42kBFih1ruShVZ/hSigCNoFXLHzXQxHjrW8wX4PIWnBoAkVmJgxzBNPTy34y33mC
         In1cY/BkTHuB9ZkK+1BQf22pkaIqOJxhrlJSK/Fs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MowGa-1jGK0g1sC6-00qRKg; Thu, 21
 May 2020 09:56:05 +0200
Subject: Re: Trying to mount hangs
To:     Pierre Abbat <phma@bezitopo.org>, linux-btrfs@vger.kernel.org
References: <2549429.Qys7a5ZjRC@puma>
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
Message-ID: <87436f2d-40d2-5fa1-cdee-4cc4f63e68c9@gmx.com>
Date:   Thu, 21 May 2020 15:56:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2549429.Qys7a5ZjRC@puma>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XqAZNvgjkecelN5iktsledddKg1GS0g0M"
X-Provags-ID: V03:K1:mIynhwThkzLjyuB4tu1o+liKDU7VH0LROi5cewdQr8HL5eVrXdE
 0/zoHVOCUbt2qwFbRk0L5JKuyezF7xWspmlsyqRK9OhYoFy4Gl9TLmy9tavHfFlIA5Y/NhW
 vFA/4q0NImuIOOF44wk94s/rqW5YCRryz/fNYwqhzcmMNDfRh1kMQM7dMFAI7AWJwVp8kTB
 kWqzDKIPg2ChIWOyg01LQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gbnMSmmTDRk=:vQOD7hONudBQ8lyxswh5dD
 faKL64B66ZDyHn3JILljokbviR04lCFmXLIU1iCCLRABNne/DLQvki8n5KIs26JmUevNVahnn
 RxcApUj3qi0NnppzamHD6UWwRoCHbHRGsgNbZdGhB2Y7c4nm2nLNiNkVvMgYL6MEauluaJcYI
 1cskHgS+s7gZQDBxA6yYvlmzDVO2aIizh1AW2FlwrNwEh8Fux0thFhl3onqwj6oq0jwjwZFXZ
 XSFxnr1VCOxD6BMFmO1uCAVZ+xKZPoHGQn9wIk8ksHNwvCdfllc0kmPegwf+OU9ALba3cjRfr
 LxLF9Sc88kWqwB9cw30rytC6F+URe9kOhyFbxKPxAJYESWDvEUJ8bYu8p4fE2PC9oC/lQ8AzB
 TtIUHhl6yj8t77Awl1Kl9VjZ/caZKH11ALQyWeWqqghQzFPN0Y6TmezRIO0yZiH7mCw/Q6acQ
 2JvLGI+VsmHpehocmCPMydGHyafLAKwDn72xdRdeLcU5ExbtTxDi98HBOOKS7+JMJeL0Z53PA
 LUj+cVthDx55TLpjU7KIkzzFUhDDAq39lgt9DEwARZGebWMNe9VMsRk/ishmW+ZmvQsmB87mH
 u7tzMdpeRDibl4/rlOzhiXpgfrUzS5e2NN6toRn//Ka9ryqszAJGywMnqOUUGiS9OuAyty2+/
 bXRf58tgj6bew9KPLjIGGaNHR0/mBz/FxzOXzlEmMp5v7itXJA1h1AFSvv+JPmsjnuC3u7Mun
 Nokp+I92y+hMCw6QsgU/o6K6t6vyOYt75AeSV89Nb7gwlvE4A17t2VyLz3EsnfzZWsCgDGY/J
 XYcPDcDOxJV06wJ7gRO2SHFtdFRM2XMB1ya/xIWDb6HYmsGBIFcVv47T/TwFSBTKe2LUOAdtS
 Os6xkr392ZqWB8+HQASI110R70+PpFyhypXz6rmz6Hzsl1r3n9P9qqSuyYnOnfKApSEiB2Lfh
 oaRwag/1y1dZTBzdT3c1B71kK/L/hFkXBqqQzVEP9KwDFXGVbTy8XyGHqYOAXjKp/RZC5S3b4
 UGBV7NDGN9zC4kmzjMYeUERlKZTKxcCjOZmw8VdsOOQOSBslvEsm5lgnc5qzp0aU08H7VtlKC
 VJWNSc766/VQZqIrlwrthU1xBevk6wDUAU2cV2/6eqTD8XDZdfzjguo3PyX+GEe7dL0JtLFUT
 p59gRULFDZOQtn3eEU5s44J7JFoY1wK1QwlIu7yrJ1bf91aT7iuViYQhEBbIiEkM8wGRlD7qi
 2uSKBOTi32SXjYdYW
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XqAZNvgjkecelN5iktsledddKg1GS0g0M
Content-Type: multipart/mixed; boundary="DejAhOyMegF5v6p5llatlCYfTAXp8zyjM"

--DejAhOyMegF5v6p5llatlCYfTAXp8zyjM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/21 =E4=B8=8A=E5=8D=889:34, Pierre Abbat wrote:
> I am not on the list, so please copy me.
>=20
> Yesterday there was a double power blink. I rebooted my box and it appe=
ared=20
> normal, but a few hours later the web browser froze, then the panel fro=
ze. I=20
> tried to kill the panel, but couldn't, and ended up rebooting. Then I c=
ouldn't=20
> log in. I logged in as root on a text console and found out that /home =
wasn't=20
> mounted. Trying to mount it hung the mount process.

That doesn't sound good. But according to your btrfs check result, your
memory doesn't look good.
There seems to be a memory bit flip.

A full memtest is highly recommended.

And since your hardware is not functioning reliable, everything can go
wrong.

>=20
> I booted a thumb drive and tried "btrfs check /dev/mapper/puma-cougar" =
(the=20
> device containing /home). It said it was busy. I ran btrfs-restore and =

> recovered source code files into /crypt (/mnt/crypt since I had booted =
the=20
> thumb drive), which I then copied to another computer and pushed to Git=
Hub. I=20
> tried mounting puma-cougar with -o ro,recover, but mount still hung.
>=20
> The next day (today, this morning) I bought an SSD, which I installed i=
n the=20
> afternoon. I ran btrfs-restore again, copying all files found to the SS=
D. I=20
> changed /etc/fstab to point to the SSD, rebooted, and am back in busine=
ss.=20
> Running "btrfs check puma-cougar" now goes through, saying that there a=
re some=20
> errors.
>=20
> I'd like to send you the filesystem so that you could figure out why mo=
unting=20
> hangs, but it's 138 GiB and I'd have to mail you a drive. Is there a wa=
y to=20
> extract a skeleton that would still make mount hang, but that I could a=
ttach=20
> to a bug report?
>=20
> It was originally 128 GiB, but a week or two ago I ran out of space, mo=
ved the=20
> point clouds to /crypt, and enlarged the LV. Maybe the combination of r=
esizing=20
> the filesystem and the power blink made it fail. Nothing went wrong wit=
h /
> crypt/.
>=20
> What does "looping too much" mean?
>=20
> phma@puma:~$ uname -a
> Linux puma 5.3.0-7625-generic #27~1576774560~19.10~f432cd8-Ubuntu SMP T=
hu Dec=20
> 19 20:35:37 UTC  x86_64 x86_64 x86_64 GNU/Linux
> phma@puma:~$ btrfs --version
> btrfs-progs v5.2.1=20
> phma@puma:~$ sudo su
> [sudo] password for phma:=20
> root@puma:/home/phma# btrfs fi show
> Label: none  uuid: 155a20c7-2264-4923-b082-288a3c146384
>         Total devices 1 FS bytes used 67.60GiB
>         devid    1 size 158.00GiB used 70.02GiB path /dev/mapper/concol=
or-
> cougar
>=20
> Label: none  uuid: 10c61748-efe7-4b9c-b1f7-041dc45d894b
>         Total devices 1 FS bytes used 53.36GiB
>         devid    1 size 127.98GiB used 56.02GiB path /dev/mapper/cougar=
-crypt
>=20
> Label: none  uuid: 1f5a6f23-a7ef-46c6-92b1-84fc2f684931
>         Total devices 1 FS bytes used 92.58GiB
>         devid    1 size 158.00GiB used 131.00GiB path /dev/mapper/puma-=
cougar
>=20
> root@puma:/home/phma# btrfs check /dev/mapper/puma-cougar=20
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/puma-cougar
> UUID: 1f5a6f23-a7ef-46c6-92b1-84fc2f684931
> [1/7] checking root items
> [2/7] checking extents
> incorrect local backref count on 4186230784 root 257 owner 99013 offset=
=20
> 5033684992 found 1 wanted 2097153 back 0x5589817e5ef0

Here, the 2097153 is 0x200001, it's an obvious bitflip.

And since it's in extent tree, even write time tree checker can't detect =
it.

But that problem is not a big thing, btrfs check --repair can fix it.

Still, memtest first, only process to try repair after your memory is fix=
ed.

Thanks,
Qu


> backpointer mismatch on [4186230784 188416]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 257 inode 30648207 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648208 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648209 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648210 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648211 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648212 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648213 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648214 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648215 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648216 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648217 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648218 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648219 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 257 inode 30648220 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> ERROR: errors found in fs roots
> found 99403300864 bytes used, error(s) found
> total csum bytes: 96230456
> total tree bytes: 737820672
> total fs tree bytes: 534069248
> total extent tree bytes: 75481088
> btree space waste bytes: 129276390
> file data blocks allocated: 10627425239040
>  referenced 68243042304
>=20
> Pierre
>=20


--DejAhOyMegF5v6p5llatlCYfTAXp8zyjM--

--XqAZNvgjkecelN5iktsledddKg1GS0g0M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7GNBEACgkQwj2R86El
/qg81Qf/VXBWEjhYkaVgApoe7HV9dJg+t0Cl/EprZJlgR+huPsMiqSf3C0PuVyrR
zmLwYECVxZRUvDu8QwHRCtnK0Z/u571H5V5dz2VEhuhYkQv1KRrTOKguWhStKKU8
yezPul7K4EbSOPZOCjpsa00BvMZd7mOvT1BH/Ox2KvHd1U0ti8G80Si6YBdXYxPe
VxI/iJXGrJaaHIae39kUtaXPxfIvCkLKr3FDL7vAkdaqDxkLzuxFxJCpA3T8CMug
3j2IMuivr3eT0z7XiHM2G8wMuTzAo49OGb6f9IvYWNGKpnDobmun+laywESAMRzK
Kq1EEdIPkcRJ763bJ08ZsEdQPOLARw==
=Q+Mv
-----END PGP SIGNATURE-----

--XqAZNvgjkecelN5iktsledddKg1GS0g0M--
