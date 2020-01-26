Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92169149AAA
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2020 14:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgAZNDh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 08:03:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:44205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgAZNDg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 08:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580043814;
        bh=Qde9zIM8GQhmecbJy5XnuwC0CdDg0KBB3ey2BF5HQM4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ji2GmDpX4R45e1eydZ7TZn7eq1V3OCIaa1AdH0Vjj5iRPxDfcvpQDajwMRfE6z+Cj
         CZQZvaDyI8jJpZfir35xPMY7hkJ8C2oQZOapOqkAi3NPlT3QcufqTQmhTGjtSwN2To
         00AFXqZQs9JisJHsg8bjkJaAXArhMfHEnz3dn1io=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mjj87-1jK3xe3xv9-00lFB4; Sun, 26
 Jan 2020 14:03:34 +0100
Subject: Re: tree first key mismatch detected (reproducible error)
To:     Thorsten Hirsch <t.hirsch@web.de>, linux-btrfs@vger.kernel.org
References: <CAH+WbHxsOEt9Z7t=ubtCmoCb2f4nDpMCCSXnT+-k5oR2pQFpOQ@mail.gmail.com>
 <688e0961-c80e-4db0-bf87-dabbfc72adf1@gmail.com>
 <71251506-88e5-c481-abdf-56dcd625b139@gmx.com>
 <CAH+WbHyYpP0ACzc+USAvwQU5SSaTbMLXbQRsc=mUWdCk23LQQg@mail.gmail.com>
 <0102016fdd701abe-0f9b4c13-9f43-4b31-af0e-fa115edb3d69-000000@eu-west-1.amazonses.com>
 <CAH+WbHyR7HC0-S3oaamk+1omON+JrBbq-MYku1k4mxAdhWJTMA@mail.gmail.com>
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
Message-ID: <f82e8a59-8d20-b689-4adb-6953cb6d6c88@gmx.com>
Date:   Sun, 26 Jan 2020 21:03:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAH+WbHyR7HC0-S3oaamk+1omON+JrBbq-MYku1k4mxAdhWJTMA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ed3opQxi1bbRrEChEZv1uzjaZs9TsLZEo"
X-Provags-ID: V03:K1:PDgbkodcG95p/Q/3q6/qNgj5vxy13y8uyd011g93Iwz7Gt3M76w
 g6Zh4BCvSheHiyfqNFJoJ0maCruzjsfq51CJPqYNRPpsb9B1Cc77RzSQlb6PI9jxxLQzEAz
 Y2ESthLenakX0ulyYv5oYinIEmCaMXCN3yQSZv+7mryPxhCQEKe8DWGo3SOBA+C/o/lxz4Q
 bCzZ9VoCIb+QJg8qPN5Ww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TcYxyL0k6r0=:AsyZtYTiDDdgvw06W3hWpK
 l3RgguL9eppWlkRUgc/If+NjADjlSwmzVBWyky+wtJhyGnJVmhU+9JLVlpSX9PXIjEwsl9d3X
 0HJF4KE9Zey9YOtRFNaxy1SW/+MgyXWDgzVvSjXmmLXareZ9sjO4YC3DFgsO4QdZr3Cxn5eX1
 30UQOufD9P2kfPofuKKg7dPe3bnnScelhTQpTNZ5Zvgc6B8BeNATzm8MeYdyHsFVIiPRaSBBD
 OcFJR5sKgyGWiL/9mw4Ggyx19Dt1Xi5eGWgEt6miIUnyNW54oPes2y4/2AHu2wSGSMUeU9WC9
 D7yYVsWXRoFKSzAGLQ1JzQj4HaATjCRdpmyMtZb+KTSzshVkFSGDxkAiK7J7HJ8TWTmqq7HII
 3W97WIsjQjiyKxSD9bqB8L0envn0dGETtpyy5S01TTNQSvIsp+LS9OU4jcTY6nwCx005OjQYp
 w8x1o9l0gMkYqkA4m4veEor3fJMJDQiAeaMjMUstiKL3k4Sdrg3kMqN6QOrG7A7zS9q5WFQj8
 qokEwgJbo1D8m7cf411iMkn5IAnREq6whsv+DKouXnvHTut6H+DtRclx2h8qexb1qG0CO3Sqf
 p/cYyfnvJr+5s496dpHbxNR3MwZSq4fJ9q/yqUCXz7vxbjY/nghC/Vea7+WmzAZSVjI4lzF7Q
 7HeM+z1/e/tlLPyn5diE6F4WJrkbnyBWH3CgEiLrRdpekORTO5icf3bBGls9fVpFUcH4bVlnA
 N4uuIR+J0mX+WeNJJPQInOhJNLxdE7Hj8vvdyl355nXGNT4kVtt/InlnPXUfWGzt4YYRWuFAW
 +TksyJW4vLXwmLygtLBL0vIU6306J3qxvIUkr3+iWKpK60uNWjFLSnAjU7h5HlD09qJ0Ig+Ew
 9qZRvBJAguIESgOGXGmggN8gIqUjoL+PdqUNwADbxHzZsu83iOTYlHRrw/v/LfYU2DsLv9g9z
 lx+ZYTQoGcr0uMdNvUnDeIkdNiKtYEv6h1kfVvA2SWD4xj+jcaM8e9Pt8rB80FVMYKqK5YCa6
 NYg3MGWndF9y96bQIdwYLjfLX7fyDx0Ih/csaUFa2LLQoqdA3f0IAG/ES1r/m5LpfdjjLHM2q
 Cxe2xz07+rKJLlOWKb6etwjLo78C90U4YEjvqQ6UHrkDjgSfFZlD5ODbVJevls6hQtst0sJgq
 0m0gHt96E3DzSqSeZJrz3WaRqR8KqPSzWgCdZ/bd0XDn9kBSOeZZhl9qC9qIzm/8ZFWyAQrG7
 p4wzqagPkSJzMXyUy
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ed3opQxi1bbRrEChEZv1uzjaZs9TsLZEo
Content-Type: multipart/mixed; boundary="PjcjvQdeAZ4j2wBgZR8CiNSJUBxpqHDp0"

--PjcjvQdeAZ4j2wBgZR8CiNSJUBxpqHDp0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/26 =E4=B8=8B=E5=8D=887:17, Thorsten Hirsch wrote:
> Thank you, Martin. So I started memtester yesterday and meanwhile it
> has run 90 loops w/o any errors.
> Back to btrfs:
>=20
> - I could restore pretty much all data with "btrfs restore", except
> for some virtualbox disk images
> - "btrfs check --init-extent-tree" took some hours to finish, but I
> still couldn't mount the partition due to multiple "corrupt leaf"
> errors

That's due to a bug in btrfs-progs where extent item generation is not
reset properly.

You can either use the devel branch
https://github.com/kdave/btrfs-progs/tree/devel

Or at least apply this commit to fix it, while without using all other
patches which may break --init-extent-tree.
https://github.com/kdave/btrfs-progs/commit/8d45dc270a3791d7217625190c9fc=
8f7cc129285

Or, you can just use v5.3 to skip such warning and do a full balance to
reset the whole extent tree and call it a day.

Thanks,
Qu

> - mounting with "-o backuproot" resulted in the same error
> - "btrfs rescue super-recover" said everything was fine
> - after "btrfs rescue chunk-recover" or "btrfs check --repair" there
> was only 1 "corrupt leaf" error left, but mounting was still not
> possible
>=20
> So basically the mount errors after "btrfs check --init-extent-tree"
> and all later commands looked like this:
>=20
> [64385.439530] BTRFS critical (device nvme0n1p3): corrupt leaf:
> block=3D156450816 slot=3D30 extent bytenr=3D51548897280 len=3D262144 in=
valid
> generation, have 315981823 expect (0, 2265510]
> [64385.440779] BTRFS error (device nvme0n1p3): block=3D156450816 read
> time tree block corruption detected
> [64385.440785] BTRFS error (device nvme0n1p3): failed to read block gro=
ups: -5
> [64385.493696] BTRFS error (device nvme0n1p3): open_ctree failed
> mount: /mnt/nvme: wrong fs type, bad option, bad superblock on
> /dev/nvme0n1p3, missing codepage or helper program, or other error.
>=20
> Then I gave up and called mkfs.btrfs. Currently the restored data is
> on its way back to the device.
>=20


--PjcjvQdeAZ4j2wBgZR8CiNSJUBxpqHDp0--

--Ed3opQxi1bbRrEChEZv1uzjaZs9TsLZEo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4tjiAACgkQwj2R86El
/qheUgf/QKyRSZ75Oz57wtaeRfv96O2LbQT1+FcCJSCRonyLo12rSjE96yQji7Ss
n3i/SuLsILsrOtT3OWf9ciu41xecobTLPqHI/D+vMqX9UWz0Cncwm+f2jNH4TiCG
+Pqbj5ErQtLK96zdiIp5VN4WIcXMwCisb1QJcyMnuAXcuW2Mv9cxl2XZhtUHtnb+
Y0giXEt2+U/MxumSSt+l6EgqeTVTsAa0//vLuN5YITVjCbLkyHDI53h7b1O62AZK
S785FF44QgFXNEJwbSTYgP/wipKY6MyoWtWdE4+N44vQWoIRddibh3x3irWPCVFC
OiRl5SUbh7RUJTMH5cMMnPY1hNeXWQ==
=/Gph
-----END PGP SIGNATURE-----

--Ed3opQxi1bbRrEChEZv1uzjaZs9TsLZEo--
