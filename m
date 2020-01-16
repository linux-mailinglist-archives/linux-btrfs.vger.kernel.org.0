Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BEA13D145
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 01:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbgAPAv6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 19:51:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:43929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgAPAv6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 19:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579135913;
        bh=SvreGx5ZFd7+lfnSVmGEAbKUOM75nb0/Hc30yVRiet8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bTwsPPXlJwRzjfsK+xnryDLyigKTAuT4L1Vum+g070plX6tnMZwL8aqmIZMqVYyju
         ChZpr3+lrxPU/95J+mZ8548J1rIf+MTu3t+J/gZ3s5z+qZWnAz7uE48p/JsoV/yRt4
         bbsdKUxgP7VGKC0EHy1zo5X0yAc7BxqS+IGzi1rs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGNC-1j7uda4C0s-00JHQb; Thu, 16
 Jan 2020 01:51:53 +0100
Subject: Re: Linux swap file not activating after reboot
To:     Michael Ruiz <michael@mruiz.dev>, linux-btrfs@vger.kernel.org
References: <5318295.DvuYhMxLoT@archlinux>
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
Message-ID: <98436ce6-63f4-d618-2c18-e460b16a3a14@gmx.com>
Date:   Thu, 16 Jan 2020 08:51:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <5318295.DvuYhMxLoT@archlinux>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ktH5MWKwpiK5UVUXStgX0VKxT33kyb0IR"
X-Provags-ID: V03:K1:Hb5RgwMg60GFc2SXfzcIv7sX8UQiYDo2KQLnJqtj0g5MyP+Jgxl
 a1WW5yIY+/IYuh8u5pkTDS1oXJ+qnr8Vtl1wCfoIk395bzuH6XKTKPPm6S9mCRDENiarO1r
 EYlPLwOTt8XoEq0mNiw+9hXVksAAYA2wGpSDQNYccmuT3R/c7ObOPnwbUkIu7vxsFPEZYSp
 trsV3Pvqy/9K7FU2a2E7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:itq21uZqOtg=:AkZ+HaAC+5BAwLH0PEKtnZ
 DGEaQXczVWzejx6ZhaMe7c1yZn7WUn9SC+BuVG2D42DzRoSf9pGdZ5Apa+V5sOy51wmQAme0f
 3Ar+ZUQUAHQyMhflXeQ+d+H0Y0X6IKIAxVCncsTh29MZynElTz40ScWCBaYb1YjFrQHiKR7Es
 JIavLRHgN/Q9HNsFrG+AnQ/M3r6hKFXDmAINea9f+i3agOTh3VCNbzZlNROr7KAihJAyZzTMc
 jioEm2YSPX0HSOdP8ypW0VKvksbTe/UMXZDYkpT0ueaSEPPq7gcD4QDNouIVNmnozmpwtSt0r
 aoXl0xgeEl4CBtXhBn2FIyshnGuHM7JY4VX4ggKmq+QDW4CVQi2QM9tgKm1h8UHR9kRSMF+jY
 Ta+aAjsvTFHL/y15JUptGNRnS0bE8Q/Lbzg5oCQjgBTwp4Wlv8zYS/PwKHseZEF4YhdlewQt5
 2q1gO7BX4QJ3A4cU23uDI8Le+XQtf1RZnq2cbdWKNsRGRaCyyerJrefOo5sGY3Kjj8Y29n9ZB
 BejXPyMAUm83OTu1dAujDFbLy83nPlM7y8FNzFzkW/DsL+b5oyZ2FLKuvX8c1f8Ef3THd7U2M
 o2vexKDhoyPFPkdZ1gXDC22mKozPce6LfAXCN8SmzaQtQpV6A9A3ETI8ulNvBTlLDlz4hKzUV
 xk64L2A0l2sfjB1mCqYcv9MuH6CWJXYcjb0POeDztlVkSsXtWNQmVPBZPOwBTAal1uR261Eao
 HjpyqT5c53GGpfvW77t50M/QJ0gG0wVFvCaVdMjkDgDGGoQDz4sobdi53MDnVGTqmvKcl0osu
 CID/NAMWum2C4jPVXMKRHu7UhjcfXtiDV8EQoUQIBmrUow39DczuS3XJFgSr0Crwkn0P9nR3s
 Jri53sTShZdq7Ub/QeITmmejLNWcXzQxCXH9fm2yDYVZxYA047pUsWv+M6qGKbHIJln9fpN3e
 jykWK0LyZEiK4zHmHCdORBw1C+Gj3fU4T3HXlwuNRxPV+tmFJBGaoMtuGk7a6t/Ug/tQe/lD9
 d+mGR9usHjNiUtFwF0IdwrJbIlCz+YPhyNAVubT4/kSJ0rtxT/+RdwDWGDlL4fY7bABWo5NbT
 ZgBH+KX+ExYQXQeYNk+BsGTYelGTaUJh2abytfczscvYUHkGb1PFsdWm+Mq7J/AXU7mnPtI3c
 /uTenRSNLNA0GB3CKjpxxcmGxYM2tsgtjCyEvPojA1UKQwN6nndVnPf04m1qFR0L+WkWNjAtE
 mzby6QUBtHXnpNDR3Vkl6XxfbQv660enlSJBoKdJMr3dvhiRLkKhCMORYej8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ktH5MWKwpiK5UVUXStgX0VKxT33kyb0IR
Content-Type: multipart/mixed; boundary="YnMj8mqvay7dB5A9NOrPqMGNDmhgDYpnG"

--YnMj8mqvay7dB5A9NOrPqMGNDmhgDYpnG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/16 =E4=B8=8A=E5=8D=888:34, Michael Ruiz wrote:
> Hi,
>  I have a //@swap subvolume and i have a swapfile within it. I mount th=
e=20
> subvolume like such in fstab:
>=20
> `rw,ssd,nofail,noautodefrag,nodatacow,nodatasum,subvolid=3D1234,subvol=3D=
/@swap`
>=20
> It mounts correctly, but 1/15/20 4:20 PM kernel I get:=20
>=20
> `BTRFS warning (device dm-0): swapfile must not be copy-on-write`
>=20
> I did chattr +C on the empty swapfile as per arch wiki instructions. Th=
e only=20
> problem is that it does not work after reboot... Does btrfs allow subvo=
lumes=20
> to have different mount options?

If that file has nodatacow, then it may be possible that you had a
snapshot of that subvolume, and caused problem.

Thanks,
Qu


--YnMj8mqvay7dB5A9NOrPqMGNDmhgDYpnG--

--ktH5MWKwpiK5UVUXStgX0VKxT33kyb0IR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4fs6YACgkQwj2R86El
/qgYOAf9HkMKLD78lH2BZXi3jCbCQ0fpF17wJMUZCEw4HgIrcDIIPAQgvcMlwC78
hZ3Kon+tpXtx84Y6K2PTzaBFRpE7IYtegGgPlm4AuLQvo+WRakniTUWIUOCgLwVG
iQQGWxfr5dpJzdzAArgnKirS04/SLIlAiZBZywI6h4V6JCLNRHumJ4EvZJrz/xpz
nKLq3/jiTqhZ/RQxj91vXwIX1AqL91uzST4+hovQ1eqaL8W3SgXoqKuos6U7Gq8O
LZflZZQWNK7lL6NPXSPwmLWbZMB100nmtstDfZE749Txok7QoAmAESkECLw4NH3x
6MOQP1IpMp7tAcY92QbiS3OgmI778w==
=b0nf
-----END PGP SIGNATURE-----

--ktH5MWKwpiK5UVUXStgX0VKxT33kyb0IR--
