Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89F7114B7F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 04:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfLFDtg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 22:49:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:49773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfLFDtg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 22:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575604169;
        bh=gX+q8jjxupskZmS03fnD5oZyTA2FsjlSFPkaZxvLGi8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Lk0udOLMuSXIbXExeilADNYtJNwocFz3R+O36ggWkPxD8uuFyXl0MxWJ+ofepKBol
         I+3uP62sEho3IuscCBUfPX5TZ2BlvHdSx9eQJ0bfqzW9iSGhRIWiFFr39/e9vtPwPo
         LKP6s3KqUsQ7RAZT3etfKosT3TvlNa6lHdeSPraE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDXp-1hkgHV1n4P-00uWUB; Fri, 06
 Dec 2019 04:49:29 +0100
Subject: Re: is this the right place for a question on how to repair a broken
 btrfs file system?
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
References: <A01B0EC4-8E96-486B-A182-76B74AD0F97D@icloud.com>
 <20191205202449.GH4760@savella.carfax.org.uk>
 <61D37CED-8564-49BC-9388-4A8511C3AC50@icloud.com>
 <522495ca-ed55-dd81-a819-dab93e67d0aa@gmx.com>
 <DBA30D34-E186-4359-A8C5-C13C870F1D81@icloud.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6c1cb788-33b9-eff4-ca0b-7c2ac6b73841@gmx.com>
Date:   Fri, 6 Dec 2019 11:49:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <DBA30D34-E186-4359-A8C5-C13C870F1D81@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qPOwEYlgNWCeOoO2z3oLr3czX0AnMdo8o"
X-Provags-ID: V03:K1:IeonsK4KsQFZa6mraQDrXaJEdyOTu2/yGo7aUNwDTYQ4a7FeBcP
 2nRVgYSs/2GOr0ZjRS1qREEJQA1j+dhoA6d9J7ewvbgtiasRQG5An4DDjwrNV+6Uw4CE4H+
 lX2R2PmT5V6oXYLbg0VoiVA88piqXUKAXtTXczaaZnDokbjgaLBjlYK+LGjLTUjWNGbDU2t
 5KPdv0XOuqk3cgMjJYZRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wHTV5UN9Bak=:uvzAD3e9ALCDVdgCqDoo1i
 iZTa/m4Weii3Ws0GpoFkm0nsXnMVRouOWsqIvolRom6vRhIEVdG61+3Zw1WLmwS/Ni34Rh865
 tjAGJ5YOQYsBRfZgHP9FM/hSOOMr9o49f8nezcKAFXB4Zm9/Gu8imzwjEkFzklt2uKyFrQrZn
 vfMCg7D8OP+yErLPwHWqNsPIssBCKnGqgHGUtaZU+llGBQEfzDVjT2N1Zzj6V8yQ0ka1HaqYV
 xl/ME/sg1ETeSSDJ4OJENjDYvAKtzeWumQ1r0/FxLpWAjZGeyrLzRf1VHhiez1Gm6jLsVKK7z
 B7W7DfX/SH20CMGbf4hsz58oOYeaQJn2ohcxmLavBeuehYFyktF5ug1TadPKYXAVq5l58wdm9
 +74RaanN8tpSRher+53AshiJDxQcrkvIYl/dpSGOCCa/J+VhXZRO/EMPqFC9wf/vcei+URz7K
 3IjD7LElTnh0hY5EPeN6MVYEYlKGHLKnQyPExbFu40RZ3nrOv+KKE/aCZr3ah+/okbq+K+EvD
 jboV8DG9SCOHDDYjYuzSxxhDAcWiIDg+mKllvsPqKMfJOLTLR3XkphuL8X84Dj/KvTu806RUC
 AsW9qp4Eym5yFzhZn1vqigwn0zUKTL2flOdNRJdBHWZcUkUudNZxh/r4cS/5uYN0Qz70h80Zf
 7RLbgMAyoVmuCYtrPvz9BydIurGChJ72/wm53FVEN/HVOlH+Y0BYKh0ZlT1cBv0gGxdNYXiuW
 8TIGK2XkqNtnqUe0+uD5OcokwQb/bRDj0+x5mn4ucek/9wrPoplMSjc+/yyI1wYc6PF+GojpG
 9zP+m2p0tjsjAfkKzCY3wKFHO8MfVkCId+bdJdFCcd1sz2Ea9TvgFi4fcqtxy27nVr62ySHBn
 rSCYl2wcqcQt+G2Ge/Wf6MgvsdYxeuowjVfmzJ9zLU/qqPP9ijaoyl0s24KnC5Reqqn4n1JQ4
 7c4V5ctRosv3gHd6JYFbgZmu5TZtx4kJTsNHUqrAB27Ga04F66qrypjg6JzrgH8dFj17CkPmh
 zguKX3xVoCY6LoLzBcnANOVz2en0PYC7gL/J4FyDKWifnyVuhq6f/iJ/kAmZozFZD6csbAP2v
 H7Sp8sVmKivbSbny3CsYdC++e35i9+3j7i/ynUEAKL98Tek0L+OwbV14nijTciLjMpf8soXt8
 j6RYbchLIQLyV/0ucWAX36Bw/YH6+KKgrJiK5jXLusU4P/+/B4HDHi5UJ2FN7m+PszX/SGruS
 F04ZP3+zjD6vYbAG4Wu8E2RvVd3lXbfU3IzCtIqS2b3xTlefsmURbceh72yU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qPOwEYlgNWCeOoO2z3oLr3czX0AnMdo8o
Content-Type: multipart/mixed; boundary="cdazWAAfC1sWeX4PTc0t3H05TZkHcMKDE"

--cdazWAAfC1sWeX4PTc0t3H05TZkHcMKDE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/6 =E4=B8=8A=E5=8D=8811:40, Christian Wimmer wrote:
> Hi Hugo and Qu,
>=20
> I installed Arch Linux latest version and here are the results:
>=20
>=20
> # btrfs ins dump-tree -t root /dev/sde1 2>&1
> btrfs-progs v5.3.1=C2=A0
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720,
> have=3D14275350892879035392
> Couldn't setup device tree
> ERROR: unable to open /dev/sde1
> #=20

My bad, after looking into the code, we skipped all other trees but not
device tree.
That why even latest btrfs-progs won't work.

I have sent a patch to you, which you can apply it on btrfs-progs v5.4,
and compile it (no need to install), then use that compiled btrfs
command to retry.

For recompile btrfs-progs, you may need the following packages (and
groups) under Arch:

# pacman -S base-devel e2fsprogs asciidoc xmlto xmltoman attr libutil-lin=
ux

Then you should be able to continue.

Sorry for the inconvenience.

Thanks,
Qu

>=20
>=20
>=20
> # btrfs ins dump-tree -t extent /dev/sde1 2>&1 >/dev/null
> btrfs-progs v5.3.1=C2=A0
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720,
> have=3D14275350892879035392
> Couldn't setup device tree
> ERROR: unable to open /dev/sde1
> #=C2=A0
>=20
>=20
> # btrfs ins dump-tree -t chunk /dev/sde1
> btrfs-progs v5.3.1=C2=A0
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720,
> have=3D14275350892879035392
> Couldn't setup device tree
> ERROR: unable to open /dev/sde1
> #=C2=A0
>=20
>=20
> # btrfs ins dump-tree -t 5 /dev/sde1 2>&1 >/dev/null
> btrfs-progs v5.3.1=C2=A0
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720,
> have=3D14275350892879035392
> Couldn't setup device tree
> ERROR: unable to open /dev/sde1
> #=C2=A0
>=20
> What could be the next steps?
>=20
>=20
> Thanks a lot for your patience and help!
>=20
> Chris
>=20


--cdazWAAfC1sWeX4PTc0t3H05TZkHcMKDE--

--qPOwEYlgNWCeOoO2z3oLr3czX0AnMdo8o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3pz8QXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhXlAf+JU+MyXkp7iPoUiLpB140K6kd
mbUq3+EiTdosSxOYk854Y4lpp1gGKMvICx9kGEvTRsDNir6qLYkz4jqNUdBO1/rr
eurvoCYalFvUrrWIfpJvXcMbmEgaf9Qa1fqsj5We0Ubdu0TFnzSL+/xas5EyN27I
krJ97s6uUpmTHYDoBjXM/EfWvkphciq8BPppkfs9aG730aASCcdj6Vt11Sy8baPC
iIKQVaFsJIs9LqKVnQWWKab5FHjaRF85APNzBh0G+XHA111ygLg1atWteXWsWMfy
haIwWwPhzabuWp1Hc6EwOWm+pfTRUvGkw9JhKIF7fxCTchaUai7xmZYj8GsN0A==
=eXFD
-----END PGP SIGNATURE-----

--qPOwEYlgNWCeOoO2z3oLr3czX0AnMdo8o--
