Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D27130860
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 15:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAEOJF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 09:09:05 -0500
Received: from mout.gmx.net ([212.227.17.21]:45285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgAEOJF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 09:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578233341;
        bh=ZLN3d8UxzBAHA5ptl8yovFHV6V+axzapQ/be7D/53MY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OSG386CXlhHwiwCsjWROehl/qBL+4cVHPY7UwbI0HKvRstEQtCGlsyUmVELQP0iZ6
         WR+6YU9xcy6HEk/5v2YllWnmgeQobj7fg01owXOwiddMRHF5mWRv90deS5MX7XJ/Vu
         ThpDPaqBcGw9u7PfBCknILduWMWBWf9rtk81Nqs4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUowb-1jE7kS0fiL-00Qnz6; Sun, 05
 Jan 2020 15:09:01 +0100
Subject: Re: Btrfs blocking disk access
To:     Hendrik Friedel <hendrik@friedels.name>,
        linux-btrfs@vger.kernel.org
References: <em802c94d1-16d7-490d-96e4-d46418d29222@ryzen>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f9a8a4e8-c413-9c09-d3cf-39ba7142c34d@gmx.com>
Date:   Sun, 5 Jan 2020 22:08:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <em802c94d1-16d7-490d-96e4-d46418d29222@ryzen>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Xpw9DuJ1GAayUlSscZyUfONIpVGPXXZnF"
X-Provags-ID: V03:K1:zfcgAXf4eOL4I4dIRmCE0Zu24/gE6Z1e5/wxSAv7AR6HW024tSv
 fiUeSmKU9khd5R5+i01b24SOu/xek2sCzR2mzTjSVnBDSRZsiu88a7EXGPYKJDBytEsI9vK
 pwFB20FEVnWEfjsg01xKE7dtm0PeequdQI+dTxIyxu8fOQdMTTMnEL9gU729HzNSm9u3xdk
 slO6RKwp7Y38/cLfFT4cA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cfbtb/AQFE8=:ECqhUJUfSJu9Ghfno4DMli
 ZWWMnjgdmGmZmjwvwJ0MmNlQ7G31L4TlVfzWG3KVN35ZrSFMqtfy2tNzr29F3VLMlHK6kMaPU
 /a2Bye/zk8l5TDCp/+U8lXpCd5WmsZlBJR8jxskvT1dVETzaGWMMnc6Uc3HpPAl5T3mxbesod
 pljpPqFrYxWjEiWtFPMo9s8UPT6NAVytji9Yo+qSbi2FsGecXroZ23JEi9KzUg8tbczEFFPWI
 Dr11k6CnVqaaw6svuChYGD7pXhIBwz654WBw8KNPty6015eF3WtVq9gaKFBkTTAWUrvVJ8S1m
 9585WHES64flOxbrbU7B24EfuOZTVrOmNuoyJ9/3jdqe35GAR5mC6/fGCYnLa2RcijvXZD8np
 OI+MrpTQ9VoaxRv0SysDzXCsbSaLDDqInxMXxWzwWDj8czFKIUOebGSMcio2ArOFc2P+yuwTT
 4UwcgoE7iKcNHsGEhrBjLvreII031CtuhS82uVY9O5MjXFS3lTSwLxF8Vb/xfcZyWC6hEWxzO
 Mw1skTaUTXQoOQGpTHOl4B3HadkUqb8hZpRC55D7INzLzXc3p+e7EkDhC7xS0jMkcpXEm9usS
 uGjbU55pUdBErMGDtpSafExu5TQVHrbygld0xsujWkc1d4FupctlDkChtmsxGJCvbSpzhHS4R
 27krb2N0fcKWEwcVT2+wA+E4xxsHrJHSSSSms95cVbSDuEchdT2aq/ByIx6V1OjyTG4R9KyvX
 4z+EWuhOROSC739PuODvlYhQJfGS+s/sBOxrm4f90bD5Ba4H03Do4tndn3X3eYCKDAxmeRRj8
 GFWSE8b2kJt4iR6BrwSw8hDIUcT9M44XQU4rlzX0swOrXYu02/W6qu07hjll/YQRir37ohNN8
 T8yTC5C/pr9XVLhauJPHrGHC63von6MAphbqKzIjhb0sh33hqeJ1Y1C9+xOvQ6d23n9lTTs7/
 WaiGNMp/5bAWzXwSXHfQBV2wCtfAoGZf+MeVghIC8J9HE4DFnU6DqFm//Cn0MroZcsLFupAYZ
 SUHuqjC+IArQM6mODWlAbC3DMLBKZYy+C8Th2MHPUXOx1+PZHMeoZHEvk1mmmSslMzbtHmBkj
 yjoG2I6zHRLqHQuT/3A7u4EGsRzfS0lRb00W8toYt4xUe1j2iOVxve49c06BE0djyjtysQ3pe
 nsWROOLem9vsetrnmYhuy+kQTs8ikbUU8ucqruoCJi4kISoQq/CnmFLVLXG2FppBCxMttOxq3
 66RxYQvA28Ow/KSBbqB8JsFJMFqCfz4GLo3Nk5fJf0c+/EgYEDdgMbyGQQ5s=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xpw9DuJ1GAayUlSscZyUfONIpVGPXXZnF
Content-Type: multipart/mixed; boundary="Lvvec2xyuckSsSTUbG9ibTjI2XM8rz3QC"

--Lvvec2xyuckSsSTUbG9ibTjI2XM8rz3QC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/5 =E4=B8=8B=E5=8D=889:39, Hendrik Friedel wrote:
> Hello,
>=20
> I have seen this problem multiple times now in my log (every few days).=

> A btrfs scrub /drive ran without error.
>=20
> [So Jan=C2=A0 5 13:49:21 2020] INFO: task dockerd:4076 blocked for more=
 than
> 120 seconds.
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tain=
ted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=C2=A0=
=C2=A0=C2=A0=C2=A0 5.2.8 #1
> [So Jan=C2=A0 5 13:49:21 2020] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [So Jan=C2=A0 5 13:49:21 2020] dockerd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 D=C2=A0=C2=A0=C2=A0 0=C2=A0 4076=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 1 0x00004000
> [So Jan=C2=A0 5 13:49:21 2020] Call Trace:
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 ? __schedule+0x3e9/0x690
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 schedule+0x33/0x90
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 wait_for_commit+0x41/0x80 [btrfs]
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 ? remove_wait_queue+0x60/0x60
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 btrfs_commit_transaction+0x1ab/0x9=
d0 [btrfs]
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 ? block_rsv_release_bytes+0x9a/0x1=
50 [btrfs]
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 create_subvol+0x3bf/0x820 [btrfs]
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 ? btrfs_mksubvol+0x30e/0x610 [btrf=
s]
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 btrfs_mksubvol+0x30e/0x610 [btrfs]=

> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 ? kmem_cache_alloc_trace+0x148/0x1=
c0
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 ?
> insert_reserved_file_extent.constprop.69+0x2f0/0x2f0 [btrfs]
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 ? _cond_resched+0x16/0x40
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 btrfs_ioctl_snap_create_transid+0x=
117/0x1a0
> [btrfs]
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 ? _copy_from_user+0x31/0x60
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 btrfs_ioctl_snap_create+0x66/0x80 =
[btrfs]
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 btrfs_ioctl+0x6b5/0x2ac0 [btrfs]
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 ? do_vfs_ioctl+0xa2/0x640
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 ?
> btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 do_vfs_ioctl+0xa2/0x640
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 ? __do_sys_newfstat+0x3c/0x60
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 ksys_ioctl+0x70/0x80
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 __x64_sys_ioctl+0x16/0x20
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 do_syscall_64+0x55/0x110
> [So Jan=C2=A0 5 13:49:21 2020]=C2=A0 entry_SYSCALL_64_after_hwframe+0x4=
4/0xa9
> [So Jan=C2=A0 5 13:49:21 2020] RIP: 0033:0x55a9b81cd5a0
> [So Jan=C2=A0 5 13:49:21 2020] Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 5=
4 24
> 20 49 c7 c2 00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b=

> 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48
> c7 44 24 30
> [So Jan=C2=A0 5 13:49:21 2020] RSP: 002b:000000c4214c6720 EFLAGS: 00000=
206
> ORIG_RAX: 0000000000000010
> [So Jan=C2=A0 5 13:49:21 2020] RAX: ffffffffffffffda RBX: 0000000000000=
000
> RCX: 000055a9b81cd5a0
> [So Jan=C2=A0 5 13:49:21 2020] RDX: 000000c4214c6760 RSI: 0000000050009=
40e
> RDI: 0000000000000076
> [So Jan=C2=A0 5 13:49:21 2020] RBP: 000000c4214c7790 R08: 0000000000000=
000
> R09: 0000000000000000
> [So Jan=C2=A0 5 13:49:21 2020] R10: 0000000000000000 R11: 0000000000000=
206
> R12: ffffffffffffffff
> [So Jan=C2=A0 5 13:49:21 2020] R13: 0000000000000038 R14: 0000000000000=
037
> R15: 00000000000000aa
> [So Jan=C2=A0 5 13:51:22 2020] INFO: task dockerd:2900 blocked for more=
 than
> 120 seconds.
> [So Jan=C2=A0 5 13:51:22 2020]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tain=
ted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=C2=A0=
=C2=A0=C2=A0=C2=A0 5.2.8 #1
> [So Jan=C2=A0 5 13:51:22 2020] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>=20
> What could be the reason for this and how can I prevent/fix it?
>=20
>=20
> About my system:
>=20
> root@homeserver:~# uname -a
> Linux homeserver 5.2.8 #1 SMP Thu Aug 15 21:22:00 CEST 2019 x86_64

5.2.8 is affected by a bug that some tree blocks aren't synced to disk,
thus causing this hang.

You can check the full commit message of upstream commit 18dfa7117a3f
("Btrfs: fix unwritten extent buffers and hangs on future writeback
attempts").

The fix is backported in 5.2.15.
Or you can go v5.3.0 which also has the fix.

Thanks,
Qu

> GNU/Linux
> root@homeserver:~#=C2=A0=C2=A0 btrfs --version
> btrfs-progs v4.20.2
> root@homeserver:~#=C2=A0=C2=A0 btrfs fi show
> Label: 'DockerImages'=C2=A0 uuid: 303256f2-6901-4564-892e-cdca9dda50e3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes use=
d 12.47GiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 52.16GiB used 29.05GiB path /dev/sdf3
>=20
> Label: 'DataPool1'=C2=A0 uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes use=
d 7.22TiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 7.28TiB used 7.27TiB path /dev/sdg1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 si=
ze 7.28TiB used 7.27TiB path /dev/sdc1
>=20
>=20
> btrfs fi df /srv/dev-disk-by-label-DockerImages/
> Data, single: total=3D25.01GiB, used=3D11.80GiB
> System, single: total=3D32.00MiB, used=3D16.00KiB
> Metadata, single: total=3D4.01GiB, used=3D842.02MiB
> GlobalReserve, single: total=3D85.78MiB, used=3D0.00B
>=20
> Yes, there are two btrfs filesystems. I am rather sure it is the
> DockerImages one, as I see no reason why the other would make docker ha=
ng.
>=20
>=20
> Regards,
> Hendrik
>=20


--Lvvec2xyuckSsSTUbG9ibTjI2XM8rz3QC--

--Xpw9DuJ1GAayUlSscZyUfONIpVGPXXZnF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4R7fkXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qiU+gf+IokqOgTmdiUc04LrgomDhq5s
tMsMLh+wxuOTekxp5pAxzhsa9t6H8JoFx9BhIiPP/qnZqRYJ7/MdH93jB6UlLEzh
WTqVLaMTf6wym1veaXW8ANmXaziZToSr5IbYBhP1T9zPOISv2MNZLmju0jZ4Kl+e
QrzwaSj5RiCG5t1bJftuuVHXjpB74Q1T+b6Wkfy89688/f48ORDpnK/xpRvH2k82
lEKYF6CU/IPCtjZZgQyBWhgp68ajUz1iRfz6G6d3y8QC2wjHVVaMfEX1cRKyVIEh
wCB5sVjWugmgFZMVwIFgtkBZJLtLRNYM5c4ciAO5XnDa0ZdJjf/whQWXYE6img==
=etKD
-----END PGP SIGNATURE-----

--Xpw9DuJ1GAayUlSscZyUfONIpVGPXXZnF--
