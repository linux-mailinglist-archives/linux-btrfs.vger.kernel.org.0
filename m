Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C65B127520
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 06:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbfLTFY2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 00:24:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:43021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfLTFY2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 00:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576819465;
        bh=hgxZHfU7nXsnr7tH4t3T2ZNT5/pUds0If3OTKKFW27s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gqXK7xSll364BPjXwg5LnAfBiYP5D1EltbdkfHwGCTP3I7DkSX8A+li9y82Goms1r
         H7SFQmZMfKCq2zbv9d7j/qD2Kg3p9timJn9Gl923jEolgJOXUnHBBUHMbA5QIkLpD2
         0+t0vhG6Cqw3nn04zGZQWI8QziOA3KYRSjBvsoYA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1Obb-1hhII71aYd-012srL; Fri, 20
 Dec 2019 06:24:25 +0100
Subject: Re: btrfs dev del not transaction protected?
To:     Marc Lehmann <schmorp@schmorp.de>, linux-btrfs@vger.kernel.org
References: <20191220040536.GA1682@schmorp.de>
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
Message-ID: <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
Date:   Fri, 20 Dec 2019 13:24:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220040536.GA1682@schmorp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OV9cXCk3QfdlhFqeGT2tn9Rl3fcSB2VRm"
X-Provags-ID: V03:K1:8NZ7y5sqfUt/3u1cqX+YqS5G9xZE+haCy4XH61sEG/l5VnuTI27
 7oWM1XZXOUWKYfw0MN+2V3qmy2ljiRvtnWY9izBwHYsI+744zduvUDX/ZKltnsGQsB+fyBz
 Nl0Fq0zah5LvE+gvtth2Z5C4FwhILU0Yo+y3Bmnq2XzQQxo5UlNnNYX4oRuicvHwEjEjB+l
 PSUlQyFllS7HE8kdDQqLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:b1691VWrQ64=:xQlGM4xdKyeXHUD3rTg419
 IHMv/3CXEs40qXqhks5wOKiS7A+YCY0pRb1MiEMuvhEOlMo9l0/yHwkRuwGqnrFxKQuvgBSlS
 kWv79b+mUb2yTMk9QIcNX/lmfEBJSr+l0UixPkV5LlYgIO6YDztxno+qc3/Kxh6Z9CPa80wAw
 MkWLXiw868xSkl+dfY+1Pw8OU4VbfxdeLfu79TrUMJSB7XzzdRiwEOgQCZejhp8Rdp2SF/5Mj
 AtQFrJ4udlbMFt5RyzTkyyuuG1TANld3Kgv8yF4hWlj1gf+s0qk2/vx6/l2T7Lx4+4FiuUFbg
 /cmeRNeuAN6p7cmi4xm0iHRCWwRZJYFM88B71nQ+EXV7b5g1iOxoidc7zPb4nB8Soti3nO5dW
 DorX186HbnCnNz19H2Hx353E0hP8ai9pYkZtfaJnrpmSXrmCfYHuwyJfSPBSB5dSLc52t2nDm
 K9k58QWgblwDIbVvEQAM0pmUahha6cWcwrOEobS4QkJFZ9Qeca16w0j8TNZLLLB67G8zoGj8D
 46e1A1ifPhOlWbRLZELiG31xLF/nnmGNPL7KcDd69Bp10dnal2rFkanD5jZC/MV+O9gWv85CA
 Xy8C5nTVh9itvdnAM3Z5apSzc25Sn2jJ74T91a5fUpvHEZ2k9hLgjda8+kjifLDGM5lRY38Ni
 2LRtjnt5YVku+sMO8t7wH4gUui9WI3zex6wZRfuLUdIJ08+xSYPow+mc31YaIH2JE+dYUt3aS
 zYVZ2AYO9At0lIIs4Zufj+DpeIBgMfiUaPx4hhchMecCGKrqdsVYTXyMBkXdzeiyaUBmh2gCr
 dc36NaEE8LCNpzIykquz00p1/oK/7HE2yAQiPC3zkdty+FDXHI2Y+IyCqHWBWa92hF3sfR7RG
 K1U9D0RS7IE4qI34tLkSFNvpkyOWbJe3GaHmKj6VQQVJ+wv5VA7a04vcfSH18DHdY/5m+P7gV
 w1bdA2AEaw4XQwX8I4fNiVd5v8riDZQdRtVVSn6sU6E1HdoU8XKRUMO+zly7uUn8Q5Rd0CR2c
 PW4Rw+YgHSSkJIbwnfA5vUwRjqAdMNnUQTa+VlVDEggvZE9JYqq4WgZtdBjZj3rCXFMBcvx/S
 k85tKIBJf6YLis7fZam81+S7GN5wqEgb4Pn4NrmPiWhr5lp7+p0gZTKzVrDISik+UVN6T3Obd
 Zh0WQyF9nWKbcaE4XsJNpdfq6Ma1Ory1lZO3H6QKNzGcBy4sSjTm7B5lybzIf3wQ5vHl/arAM
 ouJ33t/oAs4YTvBB32ub1ZNNmWaKi5KIMySl0Pn6YJ7pDCe0Bcxeaa9joMek=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OV9cXCk3QfdlhFqeGT2tn9Rl3fcSB2VRm
Content-Type: multipart/mixed; boundary="UACmGVxakJ0UcEtPwHpKbBkig5lX3fLO1"

--UACmGVxakJ0UcEtPwHpKbBkig5lX3fLO1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/20 =E4=B8=8B=E5=8D=8812:05, Marc Lehmann wrote:
> Hi!
>=20
> I used btrfs del /somedevice /mountpoint to remove a device, and then t=
yped
> sync. A short time later the system had a hard reset.

Then it doesn't look like the title.

Normally for sync, btrfs will commit transaction, thus even something
like the title happened, you shouldn't be affected at all.

>=20
> Now the file system doesn't mount read-write anymore because it complai=
ns
> about a missing device (linux 5.4.5):
>=20
> [  247.385346] BTRFS error (device dm-32): devid 1 uuid f5c3dc63-1fac-4=
5b3-b9ba-ed1ec5f92403 is missing
> [  247.386942] BTRFS error (device dm-32): failed to read chunk tree: -=
2
> [  247.462693] BTRFS error (device dm-32): open_ctree failed

Is that devid 1 the device you tried to deleted?
Or some unrelated device?

>=20
> The thing is, the device is still there and accessible, but btrfs no lo=
nger
> recognises it, as it already deleted it before the crash.

I think it's not what you thought, but btrfs device scan is not properly
triggered.

Would you please give some more dmesg? As each scanned btrfs device will
show up in dmesg.
That would help us to pin down the real cause.

>=20
> I can mount the filesystem in degraded mode, and I have a backup in cas=
e
> somehting isn't readable, so this is merely a costly inconvinience for =
me
> (it's a 40TB volume), but this seems very unexpected, both that device
> dels apparently have a race condition and that sync doesn't actually
> synchronise the filesystem - I naively expected that btrfs dev del does=
n't
> cause the loss of the filesystem due to a system crash.
>=20
> Probably nbot related, but maybe worth mentioning: I found that system
> crashes (resets, not power failures) cause btrfs to not mount the first=

> time a mount is attempted, but it always succeeds the second time, e.g.=
:
>=20
>    # mount /device /mnt
>    ... no errors or warnings in kernel log, except:
>    BTRFS error (device dm-34): open_ctree failed
>    # mount /device /mnt
>    magically succeeds

Yep, this makes it sound more like a scan related bug.

Thanks,
Qu

>=20
> The typical symptom here is that systemd goes into emergency mode on mo=
unt
> failure, but simpyl rebooting, or executing the mount manually then suc=
ceeds.
>=20
> Greetings,
> Marc
>=20


--UACmGVxakJ0UcEtPwHpKbBkig5lX3fLO1--

--OV9cXCk3QfdlhFqeGT2tn9Rl3fcSB2VRm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl38WwQACgkQwj2R86El
/qhhIQgAg4fiVfW9yjC5MGkwnSSMlhwfqAhW+Zpp1KyPvnMeY6fnvaOaN93BA+0O
ns/cTgvjI98zGwkYgl5PoPZ299GrAYKsekpGVilE/mWv4FHfHojXSZkMO8/kcvbz
htsY+23dFEbMB8ySvqOB07STb7LAU3t5ccDyNqE2E9hDvo5CNmoTV2rlFSvUV1Yl
L9rN2v9kFdJk/BoE12Hf1ZAKY4ocpCVyjGG2cYEv2gkJHleqCKgAy3hdtrabsCzN
1ONLHn2l6VV257T22D5RKmi4G0syKD+N4/RCylENPszv7iuTYQVHtgK+0o3Rk9oj
fTTBTFjpbrfaYWCsHwDO7WPEBsNaNA==
=6ddc
-----END PGP SIGNATURE-----

--OV9cXCk3QfdlhFqeGT2tn9Rl3fcSB2VRm--
