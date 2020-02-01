Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D6214FAFE
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 01:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgBAXzr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Feb 2020 18:55:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:50045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgBAXzq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Feb 2020 18:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580601341;
        bh=j2S2e3DAfv6lXz+MiHAEwejvdZthEfBVIjI10cS3zPg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CgwfChJ5d21gw89yf2X5T+uaeSGVV1LDxBcD7ChhumkhF7xVsahwFhwR6ZgNBcMpb
         kfW9pOWwtJag52A9qBJpCh6PePVeWe9Bt2FlzvWsncwpCRIfG5wmalXraETv076LdI
         i57/uEk89AORTT9YEepd2Y0tI5nca8eImGmxb/1g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUGiJ-1j6fIV3VGV-00RHgS; Sun, 02
 Feb 2020 00:55:41 +0100
Subject: Re: support for RAID10 installation
To:     Matt Zagrabelny <mzagrabe@d.umn.edu>, linux-btrfs@vger.kernel.org
References: <CAOLfK3Vs-5CJxPuC2zFyQ4tw0BZkHx-ggE=tLcmriELx-Qe8og@mail.gmail.com>
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
Message-ID: <23ba3440-8f68-9e77-0ce3-aa2a81ab1d46@gmx.com>
Date:   Sun, 2 Feb 2020 07:55:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAOLfK3Vs-5CJxPuC2zFyQ4tw0BZkHx-ggE=tLcmriELx-Qe8og@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hrXHHNGvwsKkYv71PGmgg9FZyiD2uqakA"
X-Provags-ID: V03:K1:RQuLPdtawGSgA5Y6f3zBVtuXOJPJsXAch7PL+SRyM7/QjM0YviA
 gGr4oblYDbmjPvD9ZcUDJpLU6TgO/36lVNQxLHJfseOJseApYFRGZjXXW+2Wn1GImpNAT9d
 1pueJuTN+OtQDHFQCgDQGOVyb0z9VHKHfn/HkIhwupIpZF92L9453jl1y0DxJn7owV+a1EY
 aj4G45/YB2AylTvS0lLRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xThGFbyAeD8=:On+QXbtSp2jiDg6i+Tideu
 B+TNbAu8pbwU1vg1rB28IZy9Kf02+nPti6oo9icPwXcFOVAQ2WO9o5Qjp0oGQws09IUvSqBIG
 /UcElu6AAmQoQKXr8pKXFPShVmct6jxQUObnxrSBGxfBB41OM9SyqyRNl+w5ICAZVUHrqHjaC
 gESZFwfVTY6nDVp9juwPnnw6tT7bkHvHGV7QrjoiZs65MSXdgTIW1q/Zvc67eYhLiArHZjA1p
 Hiohdh2Szc+J6xK5Y2GOBK0NkVU7NsmAwwanmMlmJ5olWcr04ZRiZIkvOqg8KEMR0ZvPJf2Vp
 uaF6lQMSWcp+HTzCoY/TQiwrXg9pZjoM3FGrnUr/8nwkv7gs5xSy2iLhui0EWNu1Kv1lmqE7Q
 wWlJFxCfGvZaQcmA+F/UAXP8TZbm0KKQnFRwJSk4LEjgn9hkRDcSjuNs0Q5cGCwm+/dJPhK/8
 LV5s1NhEPff8GJL45go5SXvRWswwME/COCrtR8nNsyiXMAa/hcfUXdZnhPx/UzX05E19LUd99
 e5DQJ/fLOLLRp1PsAtWPz46135/UOHogGZaziUJiclBqcbGVHov3TABGoDNaW9GDL+b+283Va
 fIfjpGqLPFdxEX9v3vjcUDIQK5w08bg4kcRx6LScHC5JUPGNeNOGz52eq5yvlMU5B5MLoATqN
 Q3Dnf8tCtQQLQ00MrVAk7+dOc5+TQ5v1y44EwCT5qeqj8mTDy7bv0raKgTdWov/ceLfAN0I2P
 p5I1iwWhCWCM3LJM02RZ5WymoKbXZEawTkJosJNtXdT/P/+Y5IRXf4yR/fVQK6QttIT0n8IYQ
 GzWfURIFUB+U3bK6ByUL3HACFLSa1xeghJJZwfty6gJ9/YXRNTuLjUrqDuXWpy8hwOu+xUVXY
 fHaZ+AN3/QMDn9IBtK0Mdwl+ZhGryujhHWSe5qgdbaQDeBoUkWLi7myOOu3ZoZBqoe2ZnEc+Q
 /UOljaAgg6aEGbCSPhFO9HFTt+pcwgmr+iJAv76YquTOJr7n1j3ckWX84nxSxAqnBqHKQbVpU
 tFgLf3P/jiy/whG2zyPaqC/jM2Gq0qXGqWanXNy8PaxmqU+F3y/U9CQ6XbzZcn/atN8SicaNB
 tY6qSU3zfi9x2y1BlA3FQ81qLL7reQTW/gJG/jjJjR/qAGWtMXWc1kaKBX+T95fqIaFdgMEUp
 OwrIaKKRRavRVrBJvPx1a7y7jXRkuIdWpQY1VLH6k62BMmsGVfXQAHEhjfJ9c1nJwtyoAI9w2
 xRLRWQT3LPMg5hrGN
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hrXHHNGvwsKkYv71PGmgg9FZyiD2uqakA
Content-Type: multipart/mixed; boundary="HBJyOKnwr4MiqRsAx1bnjq1ZouxuAsm15"

--HBJyOKnwr4MiqRsAx1bnjq1ZouxuAsm15
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/2 =E4=B8=8A=E5=8D=885:17, Matt Zagrabelny wrote:
> Greetings,
>=20
> I have recently installed Debian with a root disk formatted with btrfs
> (RAID 10 with 4 drives of 12TB each.)
>=20
> root@zeus:~# uname -a
> Linux zeus 5.4.0-3-amd64 #1 SMP Debian 5.4.13-1 (2020-01-19) x86_64 GNU=
/Linux

This is a known bug for v5.4 and v5.5.

Until recently we have settled down on how to fix it properly.

The fix is here:
https://patchwork.kernel.org/patch/11359995/

And it would soon be ported to involved stable trees.

Thanks,
Qu

> root@zeus:~# btrfs --version
> btrfs-progs v5.4.1
> root@zeus:~# btrfs fi show
> Label: 'root'  uuid: bfd97357-7f10-4648-88a4-6521c6c4bb9c
>         Total devices 4 FS bytes used 775.79GiB
>         devid    1 size 10.00TiB used 388.53GiB path /dev/sda2
>         devid    2 size 10.00TiB used 388.53GiB path /dev/sdb2
>         devid    3 size 10.00TiB used 388.53GiB path /dev/sdc2
>         devid    4 size 10.00TiB used 388.53GiB path /dev/sdd2
>=20
> root@zeus:~# btrfs fi df /
> Data, RAID10: total=3D776.00GiB, used=3D774.84GiB
> System, RAID10: total=3D64.00MiB, used=3D112.00KiB
> Metadata, RAID10: total=3D1.00GiB, used=3D966.09MiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> root@zeus:~# dmesg > /tmp/dmesg.log
>=20
> I've run out of space:
>=20
> root@zeus:~# df -h
> Filesystem      Size  Used Avail Use% Mounted on
> udev             16G     0   16G   0% /dev
> tmpfs           3.2G  9.2M  3.2G   1% /run
> /dev/sda2        20T  777G     0 100% /
> tmpfs            16G     0   16G   0% /dev/shm
> tmpfs           5.0M  4.0K  5.0M   1% /run/lock
> tmpfs            16G     0   16G   0% /sys/fs/cgroup
> tmpfs           3.2G   16K  3.2G   1% /run/user/1000
> root@zeus:~#
>=20
> and I've tried balancing (both data and metadata) to get both the
> system and btrfs to agree on how much free space I have.
>=20
> I've also tried resizing the disks smaller and then larger - I found a
> (perhaps misleading) post on an online forum suggesting such things to
> retrieve space.
>=20
> I have no idea how to proceed to fix things.
>=20
> If you'd like to see the dmesg output, please let me know - it didn't
> look very informative.
>=20
> Any help, pointers, or suggestions is very welcome.
>=20
> Thanks you for your time!
>=20
> -m
>=20


--HBJyOKnwr4MiqRsAx1bnjq1ZouxuAsm15--

--hrXHHNGvwsKkYv71PGmgg9FZyiD2uqakA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl42D/kACgkQwj2R86El
/qi3BggArYVJbeJ/zeCVA3cqPLoXfD6RRT9sIxq7bc02jFEdCWDQ66tQ+m82fxsD
PFUjhKhEcucpaUAGgf05C+ckmZtG5AUxkzrpWbiB/HxpVa6vR3r2TWUD5eEyoMV/
8HHrScXRXNKa+xFi0UYFD1behp80XAM8134ScEB8XFD72Mmd1e4L8tz++I7cLzdI
H/vMc4OgvJM7/OCnIF3F6VL7cDFYet5GlmkZSr5DGbLdGMz1N8hNGYGArp/QffjP
lTJ5l1c2E2J9Zo8fcD/ujzGHP/26GDsIjwfVyUlYUbD93UvNCf+wMGZzvGaFNHpN
A+C2s4Jrz1JDc5JssPLeSjTXLPzxzg==
=XFAI
-----END PGP SIGNATURE-----

--hrXHHNGvwsKkYv71PGmgg9FZyiD2uqakA--
