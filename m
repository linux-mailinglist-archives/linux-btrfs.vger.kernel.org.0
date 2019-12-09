Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE4B11644D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 01:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfLIALI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 19:11:08 -0500
Received: from mout.gmx.net ([212.227.15.15]:41501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfLIALI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Dec 2019 19:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575850265;
        bh=7MlX/02uEgjWa+o0PF2bi9gqcIQNyzxmKAl02Vnz5h0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fja+boCl3Z3mqtzzafYAN7sZvXQ6b0WcZC0GfUNLOkTR/JwZ/eludeSs6xj75Ey34
         QbWR/anfc6cU34HXnL4kSnKU6MWZBm0PZKCUpSANCAQ3B33OUZM7Or0O3VAdD7g9Z1
         4B/59BPcnbV2BEbf0m4OIzQzWjhAFnMsM5s6GsiA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mw9Q6-1hm96h44SC-00s58d; Mon, 09
 Dec 2019 01:11:05 +0100
Subject: Re: Unable to remove directory entry
To:     Mike Gilbert <floppymaster@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
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
Message-ID: <5eae7d6d-a462-53f4-df0c-3b273426e2b2@gmx.com>
Date:   Mon, 9 Dec 2019 08:11:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uXeBrAW5psAvH1pXzopg8WWmcZkTng9Zb"
X-Provags-ID: V03:K1:Cppi+YDCmasVOOuS8GwNYqFhaPRG2kH+JFSZw9+2vfva7KcpE++
 z2JNetDFGz/iGY+P4gQSTuL4DIWsghGGedn0u058t5C97oKHXwRaIc0uP9qBJ90gv8nJ8s2
 poWubMmZnXiruBU2YR3Nz/o6TK2TVnrEaA6L3HDmgpPizO3Uwvq6uR7bgTAHXGHKeDJ+wEd
 6AeLabQWR5LcILFZbFYbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fl/vFw19Wwo=:jaYl62/+2vWJeOPvAY9vah
 1AqGDnvPKgN79spOadzI83E+ABFizWE14mjUx75BUhY1KzKMqZJeK6gpL9i7OmNGQfoVP12IM
 RFq4l62lYiiKpeC+6tG7uTp28cM5tnUP1UyPRqboMyu1RkeYph4E7dPGLIInu0YD+4D3xt7hE
 NI0PbLItkfUAitiVdkMZpzCrzjFjUd2tR729MW2P++xKG36/VukH2LN1BnJTvAQlRKuG5DIYi
 B3tN1DlVEPnEyjH0Wbj1ryssIKIZfxD1EmrVlOnR4xCz86sFB2aW1dkKqGK+zSjT7+8UKU6v5
 s2dg+sgLZgBlo6YF29/45wmttjPvDfDeLsjYdvpeOKIhFW4+5ptfaVntjAAp5QVa5b5q9ViHj
 YL1CMCpC989Iz3A1iazdumlASV+4AKqX64Tn3NSnji09rXDQKu19Fq3+ndtfp7ao8LbDh3KpV
 vMswZRwB5jrns75cwbfuafENYMXMK6hbtj58qC6rY98DP9YUnHfPwjXydN0YxhDdFxh9NZUKq
 UQIe2owCLz/PI//8dU8Ul41YWZ8N3BcWSftivFpCYSjR8L74bmQvWFqLDlUVte1Nkc62GF0AD
 ojmaSO3jqvAProk8fhDAT7Z7RF2CJf5vfdlsOyAXuBiEsOJuxnYz2qTpfZbHSVjtYl+s8QNFg
 fVJxXulXgtDiVyd3uCb/eIRNLUwOFENZr4bJC8x9e9H/FnescmL+67MdAfWc0WNl/Jjq3+dj+
 wx2m+VBtsqWJDNnrNXp531Kqfaz7QeAmg7ketwHrglwiaIv+HwW9osNnHRvN2kCpSbKbMUay1
 tL/5XDVAob+F44ETBHk/HPjjHWkpSXrb1JpXBsJg1sK5hq7Vm8JoexxTqtam9YokI36LBbdn8
 bGYMPr/yZj8I01s/MpvQarWYWxsBVJW8U5WKlNaFr0do6YYWmuQ7Fj2S4mBuAoj3JejynN+RA
 GpyJT4bMorglRcSMQuoVSIecaVmBn0ehguouiMr06WzOivhF9/KOaT6BQA6UOE+OeK6UxQa0L
 fDUN7Gzn0WgLjZP3qvRpwzOGoXeOxqEeUPyR8ZQeBhvO2mwRJ2431jG7OtTj1HsXrKAwotnQh
 HR/MP5JfMf1XlPP6zB5ODcfRSvLKs8u99n8XdClj8raRuK5n5IQi7BzBpBvytPQCsWwCSWsqD
 PYnvHuttM/5+LchQ2M4xgbdYnYL8Ipr9uJpd9EbyrVABUOWXT8ArNhbceclN499gzIaMyl/JL
 cvKNk31G4uqdB6rLq1X2dmCWc6XsLSN9OdRZaX+sxSZXvCRXi1qXstRkNO5k=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uXeBrAW5psAvH1pXzopg8WWmcZkTng9Zb
Content-Type: multipart/mixed; boundary="JoJFIfG3ARdp3BY8NAdG9rgbKpXAWdRfN"

--JoJFIfG3ARdp3BY8NAdG9rgbKpXAWdRfN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/9 =E4=B8=8A=E5=8D=883:19, Mike Gilbert wrote:
> Hello,
>=20
> I have a directory entry that cannot be stat-ed or unlinked. This
> issue persists across reboots, so it seems there is something wrong on
> disk.
>=20
> % ls -l /var/cache/ccache.bad/2/c
> ls: cannot access
> '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manifest=
':
> No such
> file or directory
> total 0
> -????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351.man=
ifest

Dmesg if any, please.

>=20
> % uname -a
> Linux naomi 4.19.67 #4 SMP Sun Aug 18 14:35:39 EDT 2019 x86_64 AMD
> Phenom(tm) II X6 1055T Processor
> AuthenticAMD GNU/Linux

The kernel is not new enough to btrfs' standard.

For this possibility name hash mismatch bug, newer kernel will reported
detailed problems.

>=20
> % btrfs --version
> btrfs-progs v5.4
>=20
> I have tried running btrfs check, and I get differing results based on
> the --mode switch:
>=20
> # btrfs check --readonly /dev/sda3
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups
> Opening filesystem to check...
> Checking filesystem on /dev/sda3
> UUID: 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
> found 284337733632 bytes used, no error found
> total csum bytes: 267182280
> total tree bytes: 4498915328
> total fs tree bytes: 3972464640
> total extent tree bytes: 199819264
> btree space waste bytes: 776711635
> file data blocks allocated: 313928671232
>  referenced 279141621760
>=20
> # btrfs check --readonly --mode=3Dlowmem /dev/sda3
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> ERROR: root 5 INODE_ITEM[4065004] index 18446744073709551615 name
> 0390cb341d248c589c419007da68b2-7351.manifest filetype 1 missing
> ERROR: root 5 DIR ITEM[486836 13905] name
> 0390cb341d248c589c419007da68b2-7351.manifest filetype 1 mismath
> ERROR: root 5 DIR ITEM[486836 2543451757] mismatch name
> 0390cb341d248c589c419007da68b2-7351.manifest filetype 1

This means the name hash for the filename
"0390cb341d248c589c419007da68b2-7351.manifest" is incorrect.

Thus kernel can't locate that inode correctly.

Furthermore, the index for inode 4065004 doesn't make much sense. The
number looks absolutely insane.

If your fs is small enough, you can try do a binary dump first, then try
btrfs check --mode=3Dlowmem --repair, as we had such ability to repair in=

v5.4.

If your fs is too large, I guess you can only prey bad thing doesn't
happen...

Thanks,
Qu

> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/sda3
> UUID: 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
> found 284337733632 bytes used, error(s) found
> total csum bytes: 267182280
> total tree bytes: 4498915328
> total fs tree bytes: 3972464640
> total extent tree bytes: 199819264
> btree space waste bytes: 776711635
> file data blocks allocated: 313928671232
>  referenced 279141621760
>=20
> Please advise on possible next steps to diagnose and fix this.
>=20


--JoJFIfG3ARdp3BY8NAdG9rgbKpXAWdRfN--

--uXeBrAW5psAvH1pXzopg8WWmcZkTng9Zb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3tkRQACgkQwj2R86El
/qhyzAf9GwU6Z3TMra02u4wrFVfGzfdMPXPEaxdCiQUVIFZjDddIhAm8AleSVXRd
OqIiRoV9scUf7J9RLFe5wD4xepdWpRNrVdy/AvWNbGBhF5XHjhNyTRfMbS9Bib6F
71+hdCiQkoo32n1QxEE/S9gPqL4G3dmeIBnN8oq2Dev+pIZnXSoYkvoh+QDfVc+R
kvtuUIe06kPqJnM1A6W2MjEz3BGzKL0072pkrJdWGNIPttvwEUAj6X/Z0LcpkM3J
ef6q9c//cS9wAGlncRtQ+cOUn8LUrpPqfz6/z3WOWJYj1t8j1clrMbtMo7oaggDJ
zKx/JuBP29qkq1GnBpIOAML4a8ZNQA==
=AOLm
-----END PGP SIGNATURE-----

--uXeBrAW5psAvH1pXzopg8WWmcZkTng9Zb--
