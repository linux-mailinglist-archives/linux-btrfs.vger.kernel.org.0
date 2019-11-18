Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575E2FFE0F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 06:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfKRFcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 00:32:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:40335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfKRFcm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 00:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574055160;
        bh=6ekhjFDI+8MRiW+SRhH1LQH4YakIOlGf+Gf0eqmyfWI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SSBhq4jVsvH65NJOBklrvVgsePpVz4YGyC8Z2oTt1Ytd9piE9twsO0ZN+sx7NhJZW
         Z2yd+/BjQsYJCH+lf5s+x3qwVyzASkyC45gvC3iQtfSAW9mYjGnRxsN89xp7jYuspw
         Kc4XyfsP3lYUy6FT0TqTTXrtICsBNlrWxBc9A4vE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2E1G-1hrUFT3wTO-013cHz; Mon, 18
 Nov 2019 06:32:40 +0100
Subject: Re: How to replace a missing device with a smaller one
To:     Nathan Dehnel <ncdehnel@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEEhgEt_hNzY7Y3oct767TGGOHpqvOn4V_xWoOOB0NfYi1cswg@mail.gmail.com>
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
Message-ID: <58154d62-7f6e-76ee-94d5-00bfcd255e59@gmx.com>
Date:   Mon, 18 Nov 2019 13:32:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAEEhgEt_hNzY7Y3oct767TGGOHpqvOn4V_xWoOOB0NfYi1cswg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zT9Wy0DH9VXcSVpuJoxfdqS7wKjZOz6RR"
X-Provags-ID: V03:K1:k+O1sWgiqfQoBra7wmKU6eKCqq214P9McE8PYwTNcGHfjRFGO41
 GWcZ2coJzaa/9EaMTwi5q+mnMTfPzu3NgPQY3Pb/C2Umz9xX478VdmjVbtr4e3DJn6w+Dls
 axsVneWXm0KjN89+hiis88TxUTyLwpxPLhHgKSqFlEBdp3FTqJyGDRdlLZdXM9s/GXJdV86
 Z5JTFO+U7BfQz2o0DIheA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EVNo5ihkO04=:/rvhNB1Gxv9Tk1kobL2rjW
 gvKcC2qXhwxRObg+RTUpmNgyg7m5hzSCahTs29dVRufarBrFv7ykEplcbo6f60SgsQXgvqhCw
 mhnXs5jQMQOny7ty/LhRakCrh/suk2PRHQDBsuOAlrvbHymQgh8B/o3A61xgjQCcuDqDg3CRs
 g37XwPvNWDNKZ0XjcQD6lN+8X9pVM5Gx8Lu7UCTptaNQvtRDNvacj2bjdQOstKJ783KhQpbha
 HDl7LuZ+cv4ECDYkC6Ukb8OvzlI4Oc8jbbTa/i/v9RsNO/ZnaGVEx1SW/RSKDatbTF73haXjl
 EaG+8noaLAtcjWyHMG7jx9e2GAD1Hvd3XgCgAnsRlDBJBUTWEWJLLqSaST4wOjbOiPZZ3EK5k
 x+A58sRhXeVz0JzihF6DRaJ4vU2xWqijDel9BNMjC+m2ViE8KT1Lb6kzpGgoPKaEAglTCYNiU
 nbtBGWUfv1TLCvpdlx9xoQdbdLCpnl7gcR2jdNt6PYen0UtgWw/RiN6oW5paHpwXw/zxp04Yq
 FmGHvR+HDuH0Snj7cJ3lIHLbnwf+vFAcTwk6Z8p2hO/xIQCL/MnOs028+qAsVTGR19OQcjs8b
 bzmMi7rjDVk9IPdf8lipyjuyl9QwQUopDYE5hZdfVO+S1DG6FVXm7+sDi1usc7w9zu8HEozg6
 F4sN/w6rgmkXsgz0X5O9eEBpVfrjYH4h4WzU50w3sxE+jQIGuWjgMgz0vIm0RnQWUVKpuA6Sl
 V9Tp3KS6Wsvx+fQaR8n0FfNsaZNfneMD3fH+QH62nl9MWjXst+tWg1ztXo+NESOPH9YnqcMNc
 F9rjkIrzE5dGZMPovdwMRJ1jGss9Yw7XOEQmXG6f6fqnAf0xoQNb5YWtKUaMRgDQoYN6dXXTC
 Umh6ytGDbhxfaCeJOZFY0eIrFjIB/y8F1NI77tgOPa941nD0z/MBdB7yd8XuI9+c7eFmz45Yi
 Xz8LuxU5Isz6xHddjELmAACh2r6z5p3qU7F1p32vhiMgkJ1CU/9bULERq/HGTHPEtL2wY9n84
 9nNHsvPdFKod8O5H134Q4k5McUKSOuiIlqKKTu6LQBufF3E66XyVQxb8KOJbU3vj04EdSGuQE
 0t4UJ8cVWp/AGlpmNa2nM+XAEcy76zZwG8DhPrp3KXDp2D93vzB6Y8wySjFkRZmd5qb/aNzOe
 2NBxWFZPGNuWcLjvCtg68Xz0GL0RClGHRjCxVCszxBTgUExbbfUFypLoOVohVDWjuMNrzOpD+
 fRIW1cZmtCpJ8bXtvNspIATryphWDClNCN+kH0Ex5xlVCvN4TgEedCqsQapI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zT9Wy0DH9VXcSVpuJoxfdqS7wKjZOz6RR
Content-Type: multipart/mixed; boundary="um3kyPOPFazL7HPFcn5nCnEMU6ra64YNL"

--um3kyPOPFazL7HPFcn5nCnEMU6ra64YNL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/18 =E4=B8=8A=E5=8D=8810:09, Nathan Dehnel wrote:
> I have a 10-disk raid10 with a missing device I'm trying to replace. I
> get this error when doing it though:
>=20
> btrfs replace start 1 /dev/bcache0 /mnt
> ERROR: target device smaller than source device (required 1000203091968=
 bytes)
>=20
> I see that people recommend resizing a disk before replacing it, which
> isn't an option for me because it's gone.

Oh, that's indeed a problem.

We should allow to change missing device's size.

> I'm replacing the drive by
> copying from its mirror, so can I resize the mirror and then replace?
> How do I do that? Do I need to run "btrfs fi res" on each of the
> remaining drives in the array?
>=20
As a workaround, you could remove that missing device (which would
relocate all chunks using it, so it can be slow).

Then add the new device to the fs.

With that done, it's recommended to do a convert to take full use the
two added devices.

Thanks,
Qu


--um3kyPOPFazL7HPFcn5nCnEMU6ra64YNL--

--zT9Wy0DH9VXcSVpuJoxfdqS7wKjZOz6RR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3SLO4ACgkQwj2R86El
/qiFrggArvI5rhE7j5eWFAljBauX+SLh+zllhIphuV7ZfJ52KzeEwxRx7Fg0e3QW
I5x1FsZKo5QcPXQipXQ4Xv6drk+OmLb/61cl23qrKZcflaTQ6R1thyxxML3sR5hX
v8QqCKvqjoAzmWH0hmL8jG0+nCbm3FbJjLtjPfo8C5aeIzw+308pMj03uipM3MjZ
YZQs3JJdWT0NdvZZqnTci1S5gBOLZ+6eIIbLDqfT//bDwB/QvT32RkJ9PtPNgSOT
hr2+mZKHY7DnHx1YWb8nriZYmn9hxbB+X3zQIqvZd8mrYx6RupqWojoJmMiSzeDg
GV9Cgz4xpYvwzJtsnBqHKP6KSCuI5g==
=emUq
-----END PGP SIGNATURE-----

--zT9Wy0DH9VXcSVpuJoxfdqS7wKjZOz6RR--
