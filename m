Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CF2350D7
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Aug 2020 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgHAG7H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Aug 2020 02:59:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:49547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgHAG7G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Aug 2020 02:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596265142;
        bh=Wk8pHIfWJLnEAbirkztU3vDyPANjA+gpgwd7VCxed0k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fH26HX+T4VT4pUMbbvG3lpnVjJHxzwPipzPm9bYqbcREHGkYYsb/WUhGs2ERfwLed
         dP+t9vnZxyc/DvPFDvtrUHOoTmAFo7Ifs+xZlCi57pV+KRyrm7oKHZG0zO9UQcq5Yp
         HcoLvbo0Tj6+wSA/HQQbeyS4pgsFGpNZ5td+8MTo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPokD-1kO5aQ2NCV-00MvBM; Sat, 01
 Aug 2020 08:59:02 +0200
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     Justin Brown <Justin.Brown@fandingo.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKZK7uwRs_tf6htRtJvw3kNhyNPMJ-juA6_WSJo+PbQA7f40Cg@mail.gmail.com>
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
Message-ID: <8e17a4d1-6555-15ba-808c-dd867d7ecbcb@gmx.com>
Date:   Sat, 1 Aug 2020 14:58:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKZK7uwRs_tf6htRtJvw3kNhyNPMJ-juA6_WSJo+PbQA7f40Cg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hITXcI8dwxXatNixSJdsJRohFDFPK1vDR"
X-Provags-ID: V03:K1:329pI7c0ITO1+4hejJruC9yxjDnvBd0XKVe9LKjLKau26J5VdRS
 TTT63tQfwYSP9roRZxkKL2/7J4ZuKYLPbtqcXNTxV/mn1Gvr+9gY6zhBDM2oAkrDoSc3/c1
 ai8oaiXxcdG+NxZnEOwGSqP68zqALXTSteU5TDRsKaX83N9H1X+MhRafNBALRkgNFsWUhd1
 PNWPIY3uD26fd703f01ZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jsj+RqBWIFA=:3cqe5+1SNSJTo+MlgctKJd
 cZ9eUDznuQHmexfYDFc9dl21jhyHZsY4IbFSReyZGcS9q2dGGKWKGz8Bgnh+s9AfpQGX/DuM4
 JfkHWa1pRHfCtLc8gzMKeCmJA6k/qPx/Y/5R2YhtzLV4FKDWPPcqXOOcZWg4UP/mVpV7+yUDn
 2WiFC6op1G5WPPRPXgcXMYweoHsNImpdt39MRLhcoiDT3VMhYgnTYFZTaty77sOaEJF7y5oGL
 2lAQHScZTYJ+rLiy55mwDOcMQHNOw7xr2u5f9odflIR6mtcGEXRWEo/ismcKVaOqgi1H3oTtt
 dNwbvQRAHQUM4v3gOHStTRzufmZ5FE/TRB63qD9FIIMyUfOxKXFySPjBZjJamC5IOchoGTxlU
 bcvdbu1dYUf32V+aVdswfN1EvtFE5oqdeL5dFK3WZikS/aon6PtAQ1POZs3ZouIFkoqW34Xxo
 HzGk7QDhDz4K04Zt7mZctwQYvSkwkOAnhkJziCGI8PTUHfKJoG+U3WXEha57vhhPtHR1jUFGG
 PeXR6HwhxoFvsDNw6wh8UGY0o6+NhhFN+QXyajUzRu0El1P4QMjA7+KJ8KPW569Bgvm7lUXAo
 VZsLs9+AMOt8dzraq0OjVo52CD+0gDlGyyUSOuQ7oQZv6kG64+ZJr07q+E+y2PGYSm6klXjN+
 QSAOgibWaGZyu54MbNDatlHSnNDrE7LEM8O6f2/6gCxG9u1SECaxLpKr2iq6dpF6Q6cP1iooC
 M3c1SZs2yyincGsiB9Q9moyiWHhK578LWib5C6VMG6jFRwVN1NVwsCH+4PEge0jATBZucxrVE
 x06Pwptzp4/Bui1VhfCv7XpzvNAG0wgdMVZzQYWBnoGtMYz8MvEWGtacAWP6AEkYV+cbJ4YdB
 ELihtDHhKz036BWyKFwuCBzUZMnDifQ6iSPkPjGonOzcPmqVktIyDSg5FjVMTm4HCc3O+Gswb
 fyr3wY7Ug4mgIXwd+WGbAw2cPuvxHh9U+WzSNM5dtGdEXkYHvHiXzaje+fdNtziJ1LfSrgGRz
 VracKBdcFJLLMKY22grTUhrvjiD5NJWiAxlYLEtvT3mJXCU2CWeTgdY7Wc1qEwfR6jA+Plwei
 tAmBndK9VFLlOXQHF9uQMQYsMyCIPbYWybtDEkRpuaB7kd1t//JtQaaW6d2rISDKKTbVcTLZy
 v83bcaTANG4iAK25axcNst3qlbOg7/6O3QMpM3Np537aH5SLd35Oap9Pitno650N96CTGiU8j
 s4I2s5Uncgq+GI42f6zCsjBmPBMoORr+E2/oeAg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hITXcI8dwxXatNixSJdsJRohFDFPK1vDR
Content-Type: multipart/mixed; boundary="83TvAqBsP2OJymwIQUeJqp82B7fDcsEIh"

--83TvAqBsP2OJymwIQUeJqp82B7fDcsEIh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/1 =E4=B8=8B=E5=8D=882:51, Justin Brown wrote:
> Hello,
>=20
> I've run into a strange problem that I haven't seen before, and I need
> some help. I started getting generic "input/output" errors on a couple
> of files, and when I looked deeper, the kernel logs are full of
> messages like:
>=20
>     sd 5:0:0:0: [sdf] tag#29 access beyond end of device

We had a new fix for trim. But according to your kernel message, it
doesn't look like the case.

(No obvious tag showing it's trim/discard)

>=20
> I've never seen anything like this before with any FS, so I figured it
> was worth asking before I consider running the standard btrfs tools.
> (I briefly started a scrub, but it was going crazy with uncorrectable
> errors, so I cancelled it.)
>=20
> Here's my system info:
>=20
> Fedora 32, kernel 5.7.7-200.fc32.x86_64
> btrfs-progs v5.7
>=20
> /etc/fstab entry:
> LABEL=3Dmedia /var/media btrfs subvol=3Dmedia,discard 0 2
>=20
> btrfs fi show /var/media/
> Label: 'media' uuid: 51eef0c7-2977-4037-b271-3270ea22c7d9
> Total devices 6 FS bytes used 4.68TiB
> devid 1 size 1.82TiB used 963.00GiB path /dev/sdf1
> devid 2 size 1.82TiB used 962.00GiB path /dev/sde1
> devid 4 size 1.82TiB used 963.00GiB path /dev/sdg1
> devid 6 size 1.82TiB used 962.03GiB path /dev/sda1
> devid 7 size 7.28TiB used 967.03GiB path /dev/sdb1
> devid 8 size 7.28TiB used 967.03GiB path /dev/sdd1
>=20
> btrfs fi df /var/media/
> Data, RAID5: total=3D4.69TiB, used=3D4.68TiB
> System, RAID1C3: total=3D32.00MiB, used=3D304.00KiB
> Metadata, RAID1C3: total=3D6.00GiB, used=3D4.94GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>=20
> I can only mount -o degraded now. Here are the logs when mounting:
>=20
> Aug 01 01:15:26 spaceman.fandingo.org sudo[275572]: justin : TTY=3Dpts/=
0
> ; PWD=3D/home/justin ; USER=3Droot ; COMMAND=3D/usr/bin/mount -t btrfs =
-o
> degraded /dev/sda1 /var/media/
> Aug 01 01:15:26 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#30
> access beyond end of device
> Aug 01 01:15:26 spaceman.fandingo.org kernel: blk_update_request: I/O
> error, dev sdf, sector 2176 op 0x0:(READ) flags 0x0 phys_seg 1 prio
> class 0

OK, it's read, not DISCARD, thus a completely different problem.


> Aug 01 01:15:26 spaceman.fandingo.org kernel: Buffer I/O error on dev
> sdf1, logical block 16, async page read
> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
> sde1): allowing degraded mounts
> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
> sde1): disk space caching is enabled
> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS warning (device
> sde1): devid 1 uuid cb05aae6-6c03-49d3-b46d-bf51a0eb8cd0 is missing
> Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
> sde1): bdev /dev/sdf1 errs: wr 4458026, rd 14571, flush 0, corrupt 0,
> gen 0
>=20
> It seems like only relatively recently written files are encountering
> I/O errors. If I `cat` one of the problematic files when the FS is
> mounted normally, I see a ton of this:
>=20
> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#26
> access beyond end of device
> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#27
> access beyond end of device
> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#28
> access beyond end of device
> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#29
> access beyond end of device
> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#30
> access beyond end of device
> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#0
> access beyond end of device
> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#1
> access beyond end of device
> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#13
> access beyond end of device
> Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#2
> access beyond end of device
>=20
> Now that I'm remounted in -o degraded, I'm getting more comprehensible
> warnings, but it still results in I/O read failures:
>=20
> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> sde1): csum failed root 2820 ino 747435 off 99942400 csum 0x8941f998
> expected csum 0xbe3f80a4 mirror 2
> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> sde1): csum failed root 2820 ino 747435 off 99946496 csum 0x8941f998
> expected csum 0x9c36a6b4 mirror 2
> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> sde1): csum failed root 2820 ino 747435 off 99950592 csum 0x8941f998
> expected csum 0x44d30ca2 mirror 2
> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> sde1): csum failed root 2820 ino 747435 off 99958784 csum 0x8941f998
> expected csum 0xc0f08acc mirror 2
> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> sde1): csum failed root 2820 ino 747435 off 99954688 csum 0x8941f998
> expected csum 0xcb11db59 mirror 2
> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> sde1): csum failed root 2820 ino 747435 off 99962880 csum 0x8941f998
> expected csum 0x8a4ee0aa mirror 2
> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> sde1): csum failed root 2820 ino 747435 off 99971072 csum 0x8941f998
> expected csum 0xdfb79e85 mirror 2
> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> sde1): csum failed root 2820 ino 747435 off 99966976 csum 0x8941f998
> expected csum 0xc14921a0 mirror 2
> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> sde1): csum failed root 2820 ino 747435 off 99975168 csum 0x8941f998
> expected csum 0xf2fe8774 mirror 2
> Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
> sde1): csum failed root 2820 ino 747435 off 99979264 csum 0x8941f998
> expected csum 0xae1cafd6 mirror 2
>=20
> Why trying to research this problem, I came across a Github issue
> https://github.com/kdave/btrfs-progs/issues/282 and a patch from Qu
> from yesterday ([PATCH] btrfs: trim: fix underflow in trim length to
> prevent access beyond device boundary). I do use the discard mount
> option, and I have a weekly fstrim.timer enabled. I did replace 2x2TB
> drives with the 2x8TB drives about 1 month ago, which involved a
> conversion to -d raid5 -m raid1c3, which I suppose could hit the same
> code paths that resize2fs would?

The problem doesn't look like a trim one, but more likely some device
boundary bug.

Would you please provide the following info?
- btrfs ins dump-tree -t chunk /dev/sde1
  This contains the device info and chunk tree dump. Doesn't contain
  any confidential info.
  We can use this info to determine if there is some chunk really beyond
  device boundary.
  I guess some chunks are already beyond device boundary by somehow.

Thanks,
Qu

>=20
> Any advice on how to proceed would be greatly appreciated.
>=20
> Thanks,
> Justin
>=20


--83TvAqBsP2OJymwIQUeJqp82B7fDcsEIh--

--hITXcI8dwxXatNixSJdsJRohFDFPK1vDR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8lErIACgkQwj2R86El
/qhmRwgAn/4eurPFWpjG4rLFYC/XX/wrNqtwXAMY9m7r6rJQb9f7CpQq+vE1PATZ
iuUVKabSAH5Rsw/08pwDziJnWfDUgwj4hrKZNoKVKDkwL890RsM3cxTsptp5K1uY
xL2R20wui9WqEsR6XYVd49A/8AlxKtOGuHj58eyB9+Jmzdq4vu7W/IKqIvBaKXdu
2dTQe5VZ4CSP1z13zEb1YiusLjQIeevk2Lr60nHQHuKDQn0k3rlV1RwfQLmcIHX6
nUSxd6jwckGJ5Qi6hhV6TIq/0L3pf6IpOIEsA24UxAqH3MNTjSuUlDAqio0tgWb5
h24TUPzBotEaXUsv2hLJL7aAjO9EPg==
=HP7P
-----END PGP SIGNATURE-----

--hITXcI8dwxXatNixSJdsJRohFDFPK1vDR--
