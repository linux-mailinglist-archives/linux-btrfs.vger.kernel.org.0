Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD401DE000
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 08:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgEVGgI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 May 2020 02:36:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:36305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgEVGgH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 May 2020 02:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590129365;
        bh=eqI50R69ERhNV7ra2o9osXeK0QJQYPwClWQZC8z/RHA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PFsiSdr2datb7WxkCU9b4lP/Wvw4uXzDcIwOc1IBHQ1crvlhHrmSE7NtzUJxbFsmv
         WjVampwLQvUdMruRaZeVUQ9JZMvU/yRrKALipLyFZBGBghSFnV9quouU0GefH41CO4
         Kjv3Tw6Ol7MFTpWh1a1/Pw3FmhamIhu6s328LFoo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7iCW-1ixt263XMo-014oZt; Fri, 22
 May 2020 08:36:05 +0200
Subject: Re: tree-checker read errors
To:     Dan Mons <dan@mons.com.au>, linux-btrfs@vger.kernel.org
References: <CACvBstUrsPPDBEV6UbePKO_p6HWXuc0GgG3KX2yF7uhNO50XCQ@mail.gmail.com>
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
Message-ID: <f42fc0d6-5dc9-dd15-9d61-53efb04fad33@gmx.com>
Date:   Fri, 22 May 2020 14:36:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CACvBstUrsPPDBEV6UbePKO_p6HWXuc0GgG3KX2yF7uhNO50XCQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gN0GuYROQ5wIL1z0J61M7ypE4mnnBqGcj"
X-Provags-ID: V03:K1:D+5dyV3ABAIgdnfUtXCKdfOd5CSgpDzHaAJ7hzCP4JoYaXOsxfc
 I6Ck3C21r5UIvqIH2BXuhQERMTppA3k0bW3m7Ef2RcOzuJji0i4YAVtBac7sbX6auHwzuPO
 eED6nQX9SOw6S0twAlUfzpm96Co/w0rhcXyYC230tprw9On+C+eRsoVEpt7tAnbvapnFSRo
 Qh7ShYSGrukIBs48Wt7Bg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w0Gmb8AJbh8=:K29mJWdR9TlNH2RvUPRyPX
 XYJD7ftyw2bJXmKSewOLulIov1d/Frrvrat4VFC5+eg35sH+2yLT2HTubNKjd2c/VR8a5b84c
 89KMOlAoASSq5XKuzIfP3IFeuLdcrYxbpjHZlNmy7zYhpHR9sJbOXDj+u46U0j0SXtyWJFD7q
 lFpe7TwaNy1Jkwaz9EQCYEKqrSNqpXlTV03AQNucyP8CfjeBeEzXiNx0SSlo5+fBVyYXqkC46
 LXaRAmVr0jDxnD/7vGn7TSPOZfA8tLu1+/te3GY/pycQVok6imppDNMFKefaMhT7ECEOz8GYq
 mn7ZzJERF3NryMxo+JLvCLvd3PADCXaP5l0Eb3eR9nfdVuOV5JqD/m6oMNpBmkmlxSSTlHGsC
 VRzZtt2xYshdXkfzFuXbdSUBVY2surBkn6OauOZ/FGgTmUHNjpL4YF1rV5M2Kd0XokVkpjoAH
 ghW7nLxeL8cbjgB9iXAVjqCVpqvqUIWwJmNPsNmTz4Ij3Ez1hP+eKPDwqhTvVmHjTuHtHFpi1
 rHK0QxUFsf3DIjVfGJKbMYaHiyRjs0X8rX6MqpzArjnA1qpzBTIwqWKf9/dPdZPKKvOIm7HZI
 28f5WsSrskworkOnV/O3FdwT/RhNyufjmmBUF5le6H14XOp1RmoIIvxqrwXdUTZySm1OER3aV
 RXIM+pwmp8rcQqjS1wV0Oz+iwJMGBIcKg4m+1Cp+Ss6uinCgG83MHS/O9K991Id3I1DUNebbV
 zrMimFGlCjusIqXcTJeJGO2PKNukNJsfqhVNnvP4vE6J0E9Myx7Kslxf+IN32SmSur9qqPSlE
 Rr1LtDfae0e0/L2TS3ta46Kvz0xF5tGP0IZHmgi1C7I2IDGoRdueiOGs9LJfCQPxPLgTGzK4+
 RiOpLtqOh9vrZdRmCkxGxgtny2eyUdZuaX0niErJZYivLgqLGyVOkwkRYn4VyuUceovD7uKsb
 hyZNJFeZz1BNJvo6fMlipDCPz0xI3QgB78eqKupQHy/8ULKHOzfCDbWH4WCe4sJMQJpPk0Z/E
 3rDclKSaWn4nHIVM/n5voRQp28i3IveOgqc3DDMh6uwhrhMBxTFZvIZSWnLZwHq2Uc1Z9FnRl
 qEn1Zt5SnddZ222liWeMI1REVEWl7EHPDHHcGmRRNYR+CoEO6ePNU5uv9bDni8HggBHAhY9+M
 ag+ux9nyBKMKjI1oqUFivJKLg7RAf67Y55x7v/77dggv6iKqv/dF0SNvvKyssq7yBIcfbfE4J
 kuf1lhwiDS7A7HbMn
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gN0GuYROQ5wIL1z0J61M7ypE4mnnBqGcj
Content-Type: multipart/mixed; boundary="GJOKtxOqLUoG3RkWXgwYUUQmLTkrYTs5h"

--GJOKtxOqLUoG3RkWXgwYUUQmLTkrYTs5h
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/22 =E4=B8=8B=E5=8D=882:14, Dan Mons wrote:
> Reporting as per the instructions in the BtrFS wiki.
>=20
> I have a BtrFS RAID1 file system on two 8TB spindle drives.  Was
> created fresh on Ubuntu 18.04.2 with the 4.18 kernel, May 2019.  Lives
> its life mounted with compress-force=3Dzstd.
>=20
> No problems with weekly scrubs across upgrades:
> * 18.04.2, kernel 4.18
> * 18.04.3, kernel 5.0
> * 18.04.4, kernel 5.3
>=20
> Upgraded to Ubuntu 20.04 LTS with the 5.4 kernel in May 2020, and saw
> lots (50 instances in syslog) of errors in the next weekly scrub:
>=20
> May 17 22:31:26 server kernel: [456527.977063] BTRFS critical (device
> sdd): corrupt leaf: block=3D1552203186176 slot=3D82 extent
> bytenr=3D135271284736 len=3D4177879734039097329 invalid extent data ref=

> hash, item has 0x39facf7b95b42ff0 key has 0x39facf7b95b42ff1

The problem is exactly what the kernel message said.

So you have one bit flipped in ram, which leads to data bit flip on-disk.=


This means, your ram may not be reliable. A full memtest is highly
recommended, and random bit flip in ram could lead to unexpected
behavior not only limited to btrfs.
(An bonus feature from btrfs, the ability to detect memory bit flip!)

Older kernel doesn't have such strict check, thus won't detect it.
This check is added in v5.4-rc1.

For the repair part, currently btrfs-progs doesn't have the ability to
repair it.
Thus I'm afraid you may hit aborted transaction if you try to remove
that data extent.

You can try by "btrfs inspect log 135271284736 <device>", you will get a
file containing that file extent.
Then you can try to remove that file, to see if btrfs aborts transaction.=


If not, that's the best case, and you can call it a day.
Or if btrfs aborts (forced to RO), then you may have to do "btrfs check
--init-extent-tree" to repair, which can be a little dangerous.

Thanks,
Qu

> May 17 22:31:26 server kernel: [456527.977483] BTRFS error (device
> sdd): block=3D1552203186176 read time tree block corruption detected
>=20
> Eventually causing the scrub to fail with status "aborted" about one
> quarter of the way through its normal run time.
>=20
> Rebooting back into the 5.3 kernel (uname says 5.3.0-46-generic)
> allows a scrub to run completely and exit 0, no errors found or
> reported.  File system appears to be working fine under this kernel.
>=20
> I'll attempt to try some later kernels provided by Canonical's
> "mainline kernel" project.  I have debs for 5.6.13 which I'll install
> and test when I can get some downtime in the next week.
>=20
> If there's any other information that can help, please let me know.
>=20
> -Dan
>=20


--GJOKtxOqLUoG3RkWXgwYUUQmLTkrYTs5h--

--gN0GuYROQ5wIL1z0J61M7ypE4mnnBqGcj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7HctIACgkQwj2R86El
/qg1Tgf/T5EVzD90uYify8N64JuCJNey2dDfIaAVm4KiE0/LDyxUCeIfaObwmBfQ
fHDWJ2VawjNf+eTacMQXPiQsuGPb7WYrGQuw3X/H1roHE4KMSCw+gbxaZq55FYuu
wKosoA/InwEDdk36MpHWGFuAxYCQgNRAa/Sx53jXvTAdl5zLBK0BHag8C15MWyLh
bvF6pU1wXqlfl+5GSotOO6rXwiVt9XudoGp2eScc1xm6iegKTDO+1Us280me9cv5
2FiVButk8aiyyTB8Nbz1G7B1d2PAB6wu36dxQFdu9DFXROaC2pQiyT1O8sJwOg+2
at8bpyq+0H0T4Du/Bo/ZGLTZ5EYluA==
=XumW
-----END PGP SIGNATURE-----

--gN0GuYROQ5wIL1z0J61M7ypE4mnnBqGcj--
