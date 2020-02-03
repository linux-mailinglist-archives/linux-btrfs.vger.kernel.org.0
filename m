Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727C91501D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 07:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgBCGvU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 01:51:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:43227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgBCGvU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 01:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580712676;
        bh=CGwLO517dv212UwXRBxJ8NxRD4PiaUSDGwtrBBzM8do=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JcUyiaYHqeA9WfgbvHaEBK1C9LgkiZVXo7WKzQJh1HlccDmW4zZehxkt1AkQa8Zvw
         kqhrFTLY9e935a4U1c8+zBw/XYNp7YbBpgOliGx9bkcms5TvuPgspj/qw1aOs7X1WJ
         PhLjFHZTXmkVS5MaYUU4ZqFGHyTsN+5xT0Ge/9eI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oBx-1jjLVM36WL-00wlIe; Mon, 03
 Feb 2020 07:51:16 +0100
Subject: Re: My first attempt to use btrfs failed miserably
To:     Skibbi <skibbi@gmail.com>, Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <CAJCQCtR0hzV+9S7cggGUUTtp4R1WdnSwzsOp=9fTnxvzn3Stmw@mail.gmail.com>
 <CACN+yT-FrVi71HKANj7NRinyPoDG5Aowma9NT=UB2WGvqoLSVA@mail.gmail.com>
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
Message-ID: <94fb7bb4-53a5-f2e8-a214-2d12cf49664c@gmx.com>
Date:   Mon, 3 Feb 2020 14:51:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CACN+yT-FrVi71HKANj7NRinyPoDG5Aowma9NT=UB2WGvqoLSVA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7ryP8g0oPKrlZQzYFguD2zEmSkJx3gseH"
X-Provags-ID: V03:K1:TuuSs9x5w+p7OKHC94I/IqBfktmYThHtE0z8KVqNPnhl0BjSnla
 2w0zyidmU8+j+dk2T8wJGXyYLEQ3ETbaANH10d7qeMT3E0lIhcTyDjd56f4VnexbojSaVFm
 d6tVNpUaH9cnnYt5ENbq9kP+U+reKyC4PuvfRzQYPoi55EyMtDFW+v/s1IsQeQa6Kl026Vm
 zIhjDPVVV2PdekLVlx4Pg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:02K42LNrdoE=:L8qqpcZxcZXBIf60RjKPFg
 eVQImS6/o0aLAJrQgGlM3trjMs6Tp6KCY+M6j1ba+VvSZVHVA1LUaZudJheBAkafPwwEu4QDR
 idHpHH61pZgP+EFLlSlel2kvLzCWfJ7XWbZhQR72GDHb4fmKF9lwEElUyzq3eIcbhV/VIgnmG
 bMER1W+FC39P3tatyttzy8Fpvmx337D/3fJgNAN3EnG+bJySfXngQ7BegykyPI8k+uFAgPIMO
 kuxi5aIOgmtK1LPuNB8g7y4HdvLDoyuSWTcvwDomz3/8X0sUpWD8+wACAK8Rr3lQLCf5wMUfq
 tPxUNzBodY87B8AYlRLSw4bXLh8/NLDdZTfhH+R5UpG/bDy6qRGAfteDYT0GL0OQPZIQ7ky1L
 Cw3fsZpD2gQF9aC6zazR7OjZ9RCZH8GueF941jwj+tP8Uq0XzCVFAkVPqW85wLikb68GVvpdE
 sK0m9YdJUep9K92DGumWczd4cgE8YC0yUoKzzNaOcs+ATIM/KanCw68uvE2TeRMpUO6ycSWgO
 fJZdXChkrbTHQENdevLt97qdYjSfwlxEhXq7MAzXkWUHaIAzsVTfzYUxsFnu0Fh34l15H67R+
 8HlQHpU5Yw2xvs1zvxenWQ7G38YeE/gFM6BSaubUNhgsxXxHQkJ2OnEnp/fw/Nh9mE/xwS4Vi
 9AjyLDuu/Dqfi0MeYrZ1ct2yTHQ/QkbeVbDbxWIKaQHXli3BaEKvrVKlXDAB0k3kH+/Xdhj/F
 qw5dQRxd+Ixl6NBrI7EmZyl2W9Hz062RiWHCjktBaGTFqUmx0oAAfTA+Dxx08zzvXslVFD48V
 L5cSMmcNW2yVcCrnL5LKTMVKFPKdKyxm8FmBv/mBd/sLtPgr3Crk5Fo6LQ9Z/HdaDsNTuShzk
 LARh5F7LsJP2sSMIqN3OPgE6RvdPHSv8jkTyLF9ORs+cBz2k/S6qEN2pmuHhAfsjZeAOY/oN/
 Zxhst+q1brGc4QRlGwFpdxzw2PH2dIl4S43bhxr2pmAM6HKpxsw+1gCCwvrRlgEFCD/aa5PrL
 tix2JEW+gzq4ROZAw9gQ76j6FcJv/8EmBNIO4Bxc98Sbn4/2TppcPOUPsHrm4WsG9EHUTxFFX
 iS9f8SDNxFhnHd5kNiIj7O9RMp08aXk1/s03TyY4LW1+afW+RIv4Wy3jOYUNaA8bgWA3p9eO4
 enkniPcJ2BGwd+V6P3HCGrnIGGM5Kuw9t5sodXbG76n/7GrJjpRPNLZqOyLz1PqnNO8wOQfiy
 jkL3gNYiGw9ZCGjPE
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ryP8g0oPKrlZQzYFguD2zEmSkJx3gseH
Content-Type: multipart/mixed; boundary="EqrgJ9e7pb8f39yRt7ixQIevsBPvJbXrC"

--EqrgJ9e7pb8f39yRt7ixQIevsBPvJbXrC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/3 =E4=B8=8B=E5=8D=882:38, Skibbi wrote:
> niedz., 2 lut 2020 o 20:56 Chris Murphy <lists@colorremedies.com> napis=
a=C5=82(a):
>>
>> On Sun, Feb 2, 2020 at 5:45 AM Skibbi <skibbi@gmail.com> wrote:
>>
>>> root@rpi4b:~# dmesg |grep btrfs
>>> [223167.290255] BTRFS: error (device dm-0) in
>>> btrfs_run_delayed_refs:2935: errno=3D-5 IO failure
>>> [223167.389690] BTRFS: error (device dm-0) in
>>> btrfs_run_delayed_refs:2935: errno=3D-5 IO failure
>>> root@rpi4b:~# dmesg |grep BTRFS
>>
>> The entire unfiltered dmesg is needed. This older kernel doesn't have
>> new enough Btrfs tree checker code to help determine what the problem
>> is.
>=20
> OK, I need to reformat my drive and reproduce the issue again.
>=20
>>> [203285.351377] BTRFS error (device sda1): bad tree block start, want=

>>> 31457280 have 0
>>
>>> [203285.466743] BTRFS info (device sda1): read error corrected: ino 0=

>>> off 32735232 (dev /dev/sda1 sector 80320)
>>
>>> [218811.383208] BTRFS error (device dm-0): bad tree block start, want=

>>> 50659328 have 7653333615399691647
>>
>> These happening together suggest lower storage stack failure. Since
>> kernel messages are filtered it only shows that Btrfs is working as
>> designed, complaining about known bad file system metadata. But
>> because it's filtered, it's not clear why the metadata has gone bad.
>>
>>> [223167.290255] BTRFS: error (device dm-0) in
>>> btrfs_run_delayed_refs:2935: errno=3D-5 IO failure
>>
>> More suggestion of IO failure, whether physical device or logical
>> layer in between Btrfs and physical device. Btrfs trusts the storage
>> stack *less* than other file systems, by design. It's a kind of canary=

>> in the coal mine. Other file systems assume the storage stack is
>> working, so they're less likely to complain. Only recent versions of
>> e2fsprogs will format ext4 using metadata checksumming enabled. The
>> kind of problems you're reporting look so bad and happen so fast I'd
>> expect a good chance you'd reproduce the same problem with any
>> metadata checksumming file system, if you have new enough progs to
>> enable them.
>=20
> I removed luks encryption and had the same btrfs errors after several
> GB of writes. Then I reformatted drive to ext4 and was able to save
> 60GB without hiccups. Of course, you may be right that ext4 silently
> damages my data, but at least I was able to see it on the drive after
> remount/reboot.

BTW, still the same USB related error when the write to btrfs fails?
Or just plain btrfs errors without any other USB/block layer related
error messages?

> I'm beginning to think that my Pi draws more power when used with
> external drive (I used only pendrives so far) so I need to investigate
> for power issues.

That also looks promising.
But since it's a USB hdd, what about try it with regular PC?

IIRC, if you can prove that the same disk work fine with PC (even with
the same kernel version), then it's obvious who is to blame.

> And also I need to figure out how to get newer kernel. Raspbian is not
> the freshest distro...
>=20

Just as mentioned, Archlinux ARM has the latest kernel.

But it's a pain in the ass to setup, especially when RPI4 is not
officially supported, you have to go through something even harder than
regular Archlinux insitallation procedure.

Another recommendation is Manjaro ARM, which has just slightly older
kernels, but much easier to use I guess.

Thanks,
Qu


--EqrgJ9e7pb8f39yRt7ixQIevsBPvJbXrC--

--7ryP8g0oPKrlZQzYFguD2zEmSkJx3gseH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl43wtwACgkQwj2R86El
/qj2ywf/cZrdtTtQ5/Qd0Ii4XcVj23mgIDbT4fYc3e2WlLQzq31TwlgORyHsS6Y+
k8ZnzCE1zNbN574x9TPhYgVY8THjohxFtJzVYIG5+QJDEFSqm+hwkD/rSlElz4BE
r9NfaLWb2hpUrTuN5jw+D4RtszRUAIkS+cF3xfnPpn1c9DX9+TWc+1UphunBTIfD
Q6i+kQot0mviBDvVsCTKff1bYqLMmhCVVF/URuI8u47cTLD7B2YaYC7uGapX1HFi
XTgw8KV4UaBH0I8328OKYQiDbPCcoUOI32PYsgtaQrM32VgqeEgPVJSbf+53eeTw
/bCBGXu6kz3XPVIDr8IW0p6/d63Bzg==
=c8MB
-----END PGP SIGNATURE-----

--7ryP8g0oPKrlZQzYFguD2zEmSkJx3gseH--
