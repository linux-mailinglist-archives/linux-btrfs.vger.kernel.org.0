Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C30DD5C2
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2019 02:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388519AbfJSAYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 20:24:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:53693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbfJSAYd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 20:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571444668;
        bh=knDxskx4Fo6hktWHjiH9uPg1KLthaw8u/yoUuPbCQgI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Zn8Zw3OzBbxpTo5df5C8+qtbUWU4ZeeYHiKYJr7/CaROK87Mk3oaJt1NRBwaVK9N/
         Om/cOM8YNFRBqAMRdUGR/F0bytzsngiEzFF93pmKyhxbmzCwuLvTdQX9HIQYs9xrdH
         imeOBms+Ddt3DHiL7Lla6/fmn0sqGZdFCMnxbHp0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFsYx-1iFrdN3Tah-00HSBN; Sat, 19
 Oct 2019 02:24:28 +0200
Subject: Re: tree-checker: corrupt leaf: invalid mode: has 00 expect valid
 S_IF* bit(s)
To:     =?UTF-8?B?5bCP5aSq?= <nospam@kota.moe>, linux-btrfs@vger.kernel.org
References: <CACsxjPamjSOddJ9oOmkE-7bQVZCr+0UhL_hfG0zHqHrY+07opA@mail.gmail.com>
 <CACsxjPa3gkUK5+J5aCqtkrjdu1kVE8GB=ErRPu-RCyALWwhU3A@mail.gmail.com>
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
Message-ID: <6ee919b1-48f6-3718-b6c2-2bd7befb3dd3@gmx.com>
Date:   Sat, 19 Oct 2019 08:24:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CACsxjPa3gkUK5+J5aCqtkrjdu1kVE8GB=ErRPu-RCyALWwhU3A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7dDZd4XwCkHflx74zZUJgFZIME4q4KspS"
X-Provags-ID: V03:K1:rAOWzqhi+oMbzekMJVsG4qYKOJKpn7HszLlcFEoLp6WnRwz3YZd
 HxZdAw2US3HK/1UwASdzBjA4TCaLCt9lS0Qg00x/w9ZxKVuBH78oGkIDx/12m0WobwT4XLT
 +r1pQjxuhFt4qrmb6DTeFzUJO8w+2K1zz7thJM9RK3GzR77hZFQSO4X7ElAoTbCJXAant7C
 fLAV83etukX9izKs0blOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GXZwbnv5aL8=:zAFG51jPznBWlu5o1V40fo
 WlGpY/ahoBmmURhU+aSpZ0QDIifHoQSfRe/eO6kU/6qw8Kj0vp1ZFd6d7rp687m3oNlV7REN8
 yoSylfupc6z8q77FKCZw6dkedK1Tm4RnO+ID106d6rnXKoBw+v1URcevJicKwRi2c7Edf7ZWz
 sKGJv96ICzg2uXKfxGzcLluq4LdcUPhxnofnMydEQZCuVJDnqv0XTfT8680RXQrav3jihE/J5
 vFD/Rg/OneGs4btuxoZMp92K8vLn9rsfwV3/i+se8Nj1NbahfqvjbXMaTLUBFByejX0JVROhU
 OxVy+86nmt3l7PUQAh5A7jlXTjyeyL/qZvdSccWSvS9ttIE4c8L2+xgn+U3Suhn5noLU4krTG
 t2JKuj4HL8xamDZdU+lG8sbbFAbu1OE7IEotuqWrMXZ67nTgurX3wlgmIzsFgCAHmHlTGcJgU
 3KHZDHTOqn5JW8fjkTc5rKVhp68DuSjrvtCUrdTZ1Y3XHSwcttOlxwELipCLQk2NIa4m2dNf+
 228NKgs1JjSIUYi/iTFTBs9novyCHlrDidNCZAGXpwTF00eBQE5Zjeyvxwi/r3ca73PVWcvz5
 nnZ2Gju+WXmYiBVFbbyUbIf0RdxTzEx5dYgFrij1sYSmd4M0pmSqO8g4L2FceVLVzQ/CRGy5I
 UsthvOBzJn9vRDEFPe/8B9dHcQxQQs9MhhN9qQt4r8jxVzEMbFnriUiRh024ySHMjhEjLD/8w
 QM0wyq/HaRw6C2RfGg2MuxWhbsUssQpTf4llE+CFFo6kgAayBapPU0WMc3lY09YGa6RuWxOM8
 QtTegl+2p9GUTfq6PXcFlbZxy6+rFSK1jQO0TjLwF9+9LfePvUBJwYfHM50WMylo2Skgy32UN
 LWQOfS4egGtSmmW7h3Y4/y+hwNh46PwntW7KxxLE8FcqQMAUYlaMH/W1qyVWe1fpfFJTRz3z/
 Rqv1bToJSHMfQCp+eAUccpbY0v6kRgbitR97QxwXK1D71NzuVIQEmuMRvR77m2QxBvusb9PgR
 rvsqwbNbutK/XdTH8BEXg9NR2DbUYpsjlPLE0MFdgCbIhBwAcuv9SvCfWPq14VdoenRozRlv9
 vEmpMLPiHPenYnoGg1vINaZ1Wf2X0XFFTK4pmHZwlZCUUgDvHXMtszhYPKYZFZD+aF6XAO4/9
 sAJzP2QPu0hI7bmwfqr6zKu1NdQ8A+qZeVDeuG4Nyo9cBDn8J2WN6VVNk9txIAVn83VPfbV86
 BB9LI/0iD2wyTdUzsH/yUdNqYtML752ialmAraQ9crQFe7q/GGwwZu8YZIk0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7dDZd4XwCkHflx74zZUJgFZIME4q4KspS
Content-Type: multipart/mixed; boundary="lLkRQLdNaAUQFGsBPljcFG0XO98zhw2BM"

--lLkRQLdNaAUQFGsBPljcFG0XO98zhw2BM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/19 =E4=B8=8A=E5=8D=881:18, =E2=80=8D=E5=B0=8F=E5=A4=AA wrote:
> Hi, I recently got the following error in dmesg while taking an
> incremental backup of my data:
>=20
> [26876.491167] BTRFS critical (device dm-0): corrupt leaf: root=3D258
> block=3D739531833344 slot=3D0 ino=3D19366566, invalid mode: has 00 expe=
ct
> valid S_IF* bit(s)

Tree-checker detects an invalid inode mode bit.

=46rom previous report, it should be caused by older kernel around 2014.

> [26876.491171] BTRFS error (device dm-0): block=3D739531833344 read tim=
e
> tree block corruption detected
>=20
> It is triggered whenever stat() is called on one of these files:
> $ ls -lR >/dev/null
> ls: cannot access './<redacted a>/2018-05-31.220504+1000AEST.html':
> Input/output error
> ls: cannot access './<redacted b>/2018-05-31.200836+1000AEST.html':
> Input/output error
> ls: cannot access './<redacted c>/2018-05-31.201834+1000AEST.html':
> Input/output error
> ls: cannot access './<redacted d>/2018-05-31.222947+1000AEST.html':
> Input/output error
>=20
> https://btrfs.wiki.kernel.org/index.php/Tree-checker#How_to_handle_such=
_error
> tells me to post on this mailing list upon getting such an error, so
> here I am.
>=20
> What's happened?

Your 2014 kernel created some bad inodes.

> How can I fix this?

There are two solutions:
- Remove the offending inodes using older kernel
  The problem is, you need to find *all* offending inodes.
  Tree-checker can only report the first one it hits, can't
  report all.
  The offending inodes is reported by the "ino=3D%llu" part of the kernel=

  message.

- Use out-of-tree btrfs-check.
  The report and repair functionality hasn't been merged yet, but you
  can still try them using this branch:
  https://github.com/adam900710/btrfs-progs/tree/for_next

  You can fix it using "./btrfs check --repair" but you need to compile
  the branch.

Thanks,
Qu

> Should I just restore from backup?
>=20
> Various diagnostic command outputs:
>=20
> $ uname -a
> Linux home.kota.moe 5.2.0-3-rt-amd64 #1 SMP PREEMPT RT Debian 5.2.17-1
> (2019-09-26) x86_64 GNU/Linux
> $ btrfs --version
> btrfs-progs v5.2.1
> $ sudo btrfs filesystem show
> Label: none  uuid: 909c3fad-bc84-4b62-8090-ad1ae46f925e
> Total devices 2 FS bytes used 191.27GiB
> devid    1 size 200.00GiB used 197.03GiB path /dev/mapper/home-dom0
> devid    2 size 200.00GiB used 197.03GiB path /dev/mapper/home-dom0--mi=
rror
> $ sudo btrfs filesystem df .
> Data, RAID1: total=3D193.00GiB, used=3D188.50GiB
> System, RAID1: total=3D32.00MiB, used=3D48.00KiB
> Metadata, RAID1: total=3D4.00GiB, used=3D2.77GiB
> GlobalReserve, single: total=3D385.31MiB, used=3D0.00B
> $ diff -u <(sudo btrfs ins dump-tree -b 739531833344 /dev/home/dom0)
> <(sudo btrfs ins dump-tree -b 739531833344 /dev/home/dom0-mirror)
> $ sudo btrfs ins dump-tree -b 739531833344 /dev/home/dom0
> (See attached file)
>=20


--lLkRQLdNaAUQFGsBPljcFG0XO98zhw2BM--

--7dDZd4XwCkHflx74zZUJgFZIME4q4KspS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2qV7UACgkQwj2R86El
/qjudQf7BE/hxUbTExN1D8aRzhA9l7FpaL/vcSr8+AuAy3zLKPlhZMyJp2Wi4HZ5
tFusTxpm1z/iSSgbKs+ZEBeOr7MFdLNSdBoXiAmn8v5kG7LdLf3mukjEsYUzGkhK
vI7S04ZjpA87wfyuiC7cVsuFDlod48icb4ElCYpzxxHNfbB2/bv6llmQAVJyNNt7
1yyBgH0mVosYi2j8OAqvtC0+LTlGW6T41WeHGgeiNGVz4lFFujL7FCmG2KIgIbuW
ZeAUrGHItVvzAUZF9JbSxjvCXpNuOkUOZXdCc1BmNvUiAR3OeTuXEj9tBYS8TD6N
lv6VgI+duDC0WnFzi17Nen8aNQH5lQ==
=EeN2
-----END PGP SIGNATURE-----

--7dDZd4XwCkHflx74zZUJgFZIME4q4KspS--
