Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007C4E6023
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Oct 2019 02:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfJ0AuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Oct 2019 20:50:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:42371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbfJ0AuT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Oct 2019 20:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572137416;
        bh=9veghQlsPOMDt6ryMLQRlXpsxo1g8KZC7fbBc/OB4jE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DEHO2Tb66knaMfrtwh2d8if3rthLVSC5oaEetWyIlqhZRdheYNa8dukFYVUDoKXL1
         DfurHEB49u1tIWxSURrMtYuwaRvkgnYF0UlD6cAU+9ZeZPEzJT3FLiyNpL6z8UxL2g
         Dc/mGr2G5Avyw/RLD2io85R2+IvohVd2t5bPLIoc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC34X-1iH3z0150X-00CSta; Sun, 27
 Oct 2019 02:50:16 +0200
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     Atemu <atemu.main@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
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
Message-ID: <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com>
Date:   Sun, 27 Oct 2019 08:50:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="65Xq3GJwXV1Hm8S2NAwVp4DLOMjKIgYNQ"
X-Provags-ID: V03:K1:elo1+2MBx6LK4lgHConkGoo5oGbYgmmKrm7ZwOumFqg7/s3vEw4
 COlhIEtxYd/9RqJmqQvfVr1Bk7fPkqe4Jnp9A0cFYOP1tR3hM3PE/6YkBKUKjJfYawqpYBS
 3+xk9uiXMQAkKiDREL7fXFz8he8OnciQemwKlDzMOk4vT02o7a2DoQga27Vvw/upz1A2tAo
 YVSPyv8q5hkHpUHbM/+8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FNY+o22gDKw=:63kDhgCk6gHT5pucovq3+h
 MMnK5n2yBbzJUUpb/DENIk6JzlhjOEQxUJxjFhwgXOtyavh2O5jFYAZ5Ndenv1KtKzziEIIX0
 Ft/PuDsAlx9QQjzDKPBx6Mfxs6R2aPL4se5scsZ+2V5mbpJkdlIp2POhNw5Wd7RURqSYZ4y9c
 NZym6fnL0Lqwn1u1Snu4VLimoePRd+nywhX5L8TGlIhFpm3hCYUTUVwR0r07d7PAHnZchYphb
 iQ60uhR6Nt0veeeZSTnAs60Hxhuz3xUA/MRhC12NIwyjO8b1knxpn/dKm7UXzBbmxbIf4CMPi
 T8NQvRsNS0qJjfKU7F2c2PpWSM1P1JQ1u8HGwbIDfcvuolung+zd175hPg7KOYZ9Kr3IWtoDc
 3nuONpldQiR0G2iMmiBzgd1IDiJ31QNvE9eXDy4Wjue0W31oZfRXXgNatZ+h+QXzjH6iaeWTh
 sJRILXQ8bcUNyS04CBBaphZEZV7vLG7ez2ppIUcusrKJ112WFwq1NgVhHzsHYUNoMhzVK78Sg
 w/EtRqhhOGJhO+1jfv5aE/EGh75KJk0IhU/NTSx0rrz8DLZsGyRiYCAyyqxOPxknDjtwX72Mc
 Sm8Jb9KcCgvj6PbzqpC1y7wP01tam8LTfZkuJbdNjKGAzPIz+r4zA204OAevrGGl/rXBz32LA
 PVtyAv/KmpknqR/SqPYEOaTtG7ygIDrOeTwX1FlD/KjtdSS/WRYRXTLp9iFeqk2rWVHUodNsG
 o5hcxeWqS6q6lckpMGDnJcsmrPO2932RILCgKkQiAtBbLCI9FON8JuGOFYozQNwo3H0xd2+Zn
 LeTNo1FM0RwAU2Gzb9eb5IRO0H4TNzdX+iunzSIJrfmLlU/JMaVJPzE7fz+f4M2CFaP5OE5sl
 SHIP1pDZFemFvB4A/1DInbMBwv4wOsaAtmbPuGiVXFAq3L5qkR/QUy37zTzbzB7XSVjIqi11/
 hlhzwsP8/VSoRjwqLHp67qSVaLXIDuD1eYcqZ08jNx8S98Vtmchuymt8wz+FE/+m9MGI/lC7n
 +bhP/tDv8jLJ1DNd2z0r8leV4lRwjRck15sLKB6SPSNAFVTSjHe21mqcMF9vLF1BEfcb13kg5
 MFGdVUCejwaRcqPm7O/9vX6DHxW8K+cBBK1beojgSFMdpFBB0TeGMZQOLGiCZr8wp7IqpLKdO
 jw3ap436XiIfc1/o3QLG6xVvfkDtEPuQd7Dc8DaFqsI+xj1O0tol7QZJuW4jk2Lk76BwB4DtL
 gGYuhsrurauy6HZkSaaodC+DI9dNsKYaxw7Pkh56C+ojIU0lpnGjyAKsGas0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--65Xq3GJwXV1Hm8S2NAwVp4DLOMjKIgYNQ
Content-Type: multipart/mixed; boundary="GB7fnFYUEqFCsTODKlIjmtxBLkf5ltI4j"

--GB7fnFYUEqFCsTODKlIjmtxBLkf5ltI4j
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/27 =E4=B8=8A=E5=8D=881:46, Atemu wrote:
> Hi linux-btrfs,
> after btrfs sending ~37GiB of a snapshot of one of my subvolumes,
> btrfs send stalls (`pv` (which I'm piping it through) does not report
> any significant throughput anymore) and shortly after, the Kernel's
> memory usage starts to rise until it runs OOM and panics.
>=20
> Here's the tail of dmesg I saved before such a Kernel panic:
>=20
> https://gist.githubusercontent.com/Atemu/3af591b9fa02efee10303ccaac3b4a=
85/raw/f27c0c911f4a9839a6e59ed494ff5066c7754e07/btrfs%2520send%2520OOM%25=
20log
>=20
> (I cancelled the first btrfs send in this example FYI, that's not part
> of nor required for this bug.)
>=20
> And here's a picture of the screen after the Kernel panic:
>=20
> https://photos.app.goo.gl/cEj5TA9B5V8eRXsy9
>=20
> (This was recorded a while back but I am able to repoduce the same bug
> on archlinux-2019.10.01-x86_64.iso.)
>=20
> The snapshot holds ~3.8TiB of data that has been compressed (ZSTD:3)
> and heavily deduplicated down to ~1.9TiB.

That's the problem.

Deduped files caused heavy overload for backref walk.
And send has to do backref walk, and you see the problem...

I'm very interested how heavily deduped the file is.
If it's just all 0 pages, hole punching is more effective than dedupe,
and causes 0 backref overhead.

Thanks,
Qu

> For deduplication I used `bedup dedup` and `duperemove -x -r -h -A -b
> 32K ---skip-zeroes --dedupe-options=3Dsame,fiemap,noblock` and IIRC it
> was mostly done around the time 4.19 and 4.20 were recent.
>=20
> The Inode that btrfs reports as corrupt towards the end of the dmesg
> is a 37GiB 7z archive (size correlates) and can be read without errors
> on a live system where the bug hasn't been triggered yet. Since it
> happens to be a 7z archive, I can even confirm its integrity with `7z
> t`.
> A scrub and `btrfs check --check-data-csum` don't detect any errors eit=
her.
>=20
> Please tell me what other information I could provide that might be
> useful/necessary for squashing this bug,
> Atemu
>=20
> PS: I could spin up a VM with device mapper snapshots of the drives,
> destructive troubleshooting is possible if needed.
>=20


--GB7fnFYUEqFCsTODKlIjmtxBLkf5ltI4j--

--65Xq3GJwXV1Hm8S2NAwVp4DLOMjKIgYNQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl206cAACgkQwj2R86El
/qgCvgf8Doi9vomv6lyNtGM21Vf7p73vlFWnOQge1tAGP0pNISSNdfoC5X258B1R
nHBUiCLk4p7T29wzZv50DluucJmPfVWq4dhYe+fYRmkfcpUXiP44v4MuD/M/gHy7
mpthDJ+X/XFfX+xkDTBfmstWurL/z8R4Kc50m6BOI3Cmgtxt9uy7g1tqF6VneOs4
wNaPcxLrbOYk4VriHGR02rWD5pI9ZmC6MNEBrm9EpfgtogmjnTRsy2AR8e0U/JT/
r+cUXd3g+d4fMOL1ox2lx0sz1yNt3kpRYract+Th0+MuQKO7RehUPG4UXqZA+U2F
vVPlFhXtq9j/CWWj5nCT4Knxbmxaug==
=YSq2
-----END PGP SIGNATURE-----

--65Xq3GJwXV1Hm8S2NAwVp4DLOMjKIgYNQ--
