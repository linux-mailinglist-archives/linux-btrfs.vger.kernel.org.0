Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F021EB2EA
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 03:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgFBBTG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 21:19:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:59687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFBBTF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 21:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591060741;
        bh=aFNaSCFczaZf8pKgIheNivm4l5ihiAwR2d0nOwq7DL8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZlfksrZCGvzSXaYpBvh0lKkV3J/mOQIUhQnEBL+gNY1s0lN3ynBqT0kubdcIcmHkP
         Py3NS76yFCgckvph3R6oIB7r0D53UsatqKoL7v+Ypv8RPS9TVqzxfoFMzEvLDFck/y
         9TSgEU+agj+nkZKBgBSTHG/823PfgwJb8A/gfouU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MD9T1-1joPuH3cJ7-0096sr; Tue, 02
 Jun 2020 03:19:01 +0200
Subject: Re: Massive filesystem corruption, potentially related to
 eCryptfs-on-btrfs
To:     Xuanrui Qi <me@xuanruiqi.com>, linux-btrfs@vger.kernel.org
References: <DM6PR02MB44274C6B16F173291A82C4A8C98A0@DM6PR02MB4427.namprd02.prod.outlook.com>
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
Message-ID: <bf3629ad-730d-3808-38e5-8c42eccbaf5e@gmx.com>
Date:   Tue, 2 Jun 2020 09:18:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <DM6PR02MB44274C6B16F173291A82C4A8C98A0@DM6PR02MB4427.namprd02.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QrV3FNVFYO9xzbmKkiYYlmoPb8OG0nPAl"
X-Provags-ID: V03:K1:0J37DkYX6d+vcbxTzeFM5OgFykBdUlSJmeFLtbfNVgB7G9T43WJ
 pMd8hSdLx1WIUY3o/gx58dYzMyDGMeiPb+4bk5Ze+5hyQ5gYbnpAGAe4Ps3vsbAKC76I9Cn
 kG2NC3WseabrSJDy3/CaVh/BGBcRBd5G2qzcpM/5l/8togWxP+eaXX5jvGMzj/DBhR6AuIt
 cxG1l6mklCAhJIExuXqJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6giPL3Spo4E=:BMrtjOJiCOREO7l4eP9G9B
 DYvF5VUQIemBx/cQmsXz2jA2NVPo9WPVPuMVmBw1CUOFtUovDvA2o22tn+6h5bVYuMus3K56V
 QRpvj1t51n6EwEIBN/vsB0Dzfikt9pkkJtOyJ/IVFQwl+TSUliav+PdhOhjbFBSJnFkKA85OZ
 5vREBG9UI5w812UrQKnzWk3P4RxtHLSyK0f3CyfgV9CjAmKBMbfgEqsDAB8HyanGBXkLBNgi8
 NzcL/f5wm/xNbLWymbn6XP7VImj+OLlhCzmIyfirHbEy/LfMxk29Q1s2VFUV2imOga2Wu7/hk
 wi9dE3jlzBGijKEszVnpmzZ5LbX2WfBACpgksdvqTLmSCMehw8oEJ2s406MN1VVOuBuDD5Wec
 1TG8no1YGVgcDciBwmdOLSxfqxGO9kRF+nWDoCUpDuMU1GK0RQ4JJpaojXwk/PdcwP7U/i2t8
 ps2Ta/a9iJzNT/Gjq3kfi/e8v7BeoXFotQaY3mEqgdhHi5fBpGea4y2ZABpcuWbPPXt/o/nVI
 RX9i2q7WfLl4DOqYd3Z4NoLHG9exqVrDr8u1w6Fw4OqFvBY0RLkMpWROEcK+N3AMbCgsi19gp
 1e1r2047JRRu+XkDI7AyXZ9SzouZlurLhF59N3Dj9KgMFuSw225CtnTZLsnA4y2Olp7WNcSI7
 EAwp94bX7fw/ZCCFS7eiik38I7tUwQdZZmWiDI30b0lOV4TPWo5+uqEYv4VvJottvAxUGrIPL
 IIkFxi/jgxDaIcHk7svb7xbnLQ0gIi47QQARvEFftLEiX7B1YA+lJ4bIpYzzYrhc0eSQdh/iu
 P1S0CP4JgIG3PosQZozCSPhiw+xcGDSG7NVYrRx69v4jrUDqO5iIUZspYMSjr87ElLWjiJRT5
 bjaIBDpHVMzJDyYBNxg9QAD25jkFDFNT5UB8gPOTRTIJ/2QQ1dQ2X7Tvo28esLjoADuUpcI2M
 b4ywwLbIkNJTDhQcW1ZFnojNmw3V+GFJSUFcJT4NI+2rmIuYAIJHnvBPMLh6mE0JzH/p2CEeo
 KdnQ+Nht8RCV54DmvKQZmCVyCZnjU1eBV6d6yz+Kh2gUUh5wI3qLOA8Zo8ea1/vL+HjGLnKrG
 fa5V2toCmggDJIp4nm3hbPTlkGE85L2H3A/ZlD4/4+U/1RxnlbJaSgUwp8KFPiEM28ZKjRcgX
 Kaqkdy+fbJPuy1EZ/11nRGHGaxFvFnQPkO+/n763ndT8GCjcgnCKfrNk9A6A8jBtrQ7a8XX9e
 2NdpxkSs7smtLyGrL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QrV3FNVFYO9xzbmKkiYYlmoPb8OG0nPAl
Content-Type: multipart/mixed; boundary="URmYucHVWZ1yUCF39GElMSl5JPu4SPJoS"

--URmYucHVWZ1yUCF39GElMSl5JPu4SPJoS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/2 =E4=B8=8A=E5=8D=885:08, Xuanrui Qi wrote:
> Hello all,
>=20
> I have just recovered from a massive filesystem corruption problem
> which turned out to be a total nightmare, and I have strong reason to
> suspect that it is related to eCryptfs-encrypted folders on btrfs.
>=20
> I run Arch Linux and have my /home directory as a btrfs partition. My
> user's home directory (/home/xuanrui) is encrypted using eCryptFS.
>=20
> I ran into a massive filesystem corrpution issue a while ago. When
> reading certain files or occasionally writing to files, I encounter FS
> errors (mainly checksum errors, but also other I/O errors). Then my
> file system becomes read-only because errors were encountered.

It's a pity we won't get the dmesg of that incident, what would be super
useful to debug.

>=20
> A `btrfs scrub` identified a dozen of checksum errors which were "not
> correctable", and `btrfs check --repair` (and `btrfs check --repair --
> init-csum-tree`)

Not recommended, but the output may still help.

> also failed to fix anything. The former crashed in a
> segfault, and the latter refused to write anything because of an "I/O
> error".
>=20
> Unfortunately, I don't have any logs because I had to nuke (wipe & re-
> make) my filesystem as the solution. However, after the reformatting I
> gave up using eCryptFs, and the file corruption bugs have not
> reappeared since.

That's a little strange. I guess there is some buffered IO mixed with
direct IO, which is known to cause csum mismatch, while other fs just
can't detect such data corruption and pretend nothing happened.

But normally, csum read shouldn't lead to RO, thus I believe there are
more problems of that previous failure.

> Initially I suspected that it was a hardware issue,
> but I did a SMART test and no errors were detected; I strongly suspect
> that it is related to eCryptFS.
>=20
> System info:
>=20
> uname -a:
>=20
> Linux xuanruiwork 5.6.15-3-clear #1 SMP Sun, 31 May 2020 19:57:42 +0000=

> x86_64 GNU/Linux
>=20
> btrfs --version:
> btrfs-progs v5.6.1
>=20
> (the rest is from after the reformat, but the setup is identical to
> before the reformat sans eCryptFS)
>=20
> btrfs fi show:
> Label: none  uuid: 823961e1-6b9e-4ab8-b5a7-c17eb8c40d64
> 	Total devices 1 FS bytes used 57.58GiB
> 	devid    1 size 332.94GiB used 60.02GiB path /dev/sda3
>=20
> btrfs fi df /home:
> Data, single: total=3D59.01GiB, used=3D57.26GiB
> System, single: total=3D4.00MiB, used=3D16.00KiB
> Metadata, single: total=3D1.01GiB, used=3D328.25MiB
> GlobalReserve, single: total=3D75.17MiB, used=3D0.00B
>=20
> Some output from dmesg (note that /dev/sda1 is not the corrupted
> filesystem; these corruptions seem to have been self-corrected by
> btrfs):
>=20
> [    3.434351] BTRFS: device fsid 823961e1-6b9e-4ab8-b5a7-c17eb8c40d64
> devid 1 transid 79 /dev/sda3 scanned by systemd-udevd (519)
> [    3.440896] BTRFS: device fsid a3892669-1ad8-4ff3-9747-0f8c405c0e6a
> devid 1 transid 4769881 /dev/sda1 scanned by systemd-udevd (487)
> [    3.461539] BTRFS info (device sda1): disk space caching is enabled
> [    3.461540] BTRFS info (device sda1): has skinny extents
> [    3.464079] BTRFS info (device sda1): bdev /dev/sda1 errs: wr 0, rd
> 0, flush 0, corrupt 14, gen 0

Corruption count 14 doesn't seem good.

> [    3.510991] BTRFS info (device sda1): enabling ssd optimizations
> [    5.938153] BTRFS info (device sda1): disk space caching is enabled
> [    7.072974] BTRFS info (device sda3): enabling ssd optimizations
> [    7.072977] BTRFS info (device sda3): disk space caching is enabled
> [    7.072978] BTRFS info (device sda3): has skinny extents
> [ 3710.968433] BTRFS warning (device sda3): qgroup rescan init failed,
> qgroup is not enabled

And btrfs is trying to init qgroup rescan while qgroup is not enabled?
That's doesn't sound good either.

> [ 7412.459332] BTRFS info (device sda1): scrub: started on devid 1
> [ 7545.641724] BTRFS info (device sda1): scrub: finished on devid 1
> with status: 0
> [ 8244.846830] BTRFS info (device sda3): scrub: started on devid 1
> [ 8369.651774] BTRFS info (device sda3): scrub: finished on devid 1
> with status: 0

Any log on `btrfs check` without --repair?

Thanks,
Qu
>=20
> If anyone could look into the issue, it would be greatly appreciated.
>=20
> Best,
> Xuanrui
>=20


--URmYucHVWZ1yUCF39GElMSl5JPu4SPJoS--

--QrV3FNVFYO9xzbmKkiYYlmoPb8OG0nPAl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7VqQEACgkQwj2R86El
/qhRFwf/QogXESrfW++47gMYmF1SmT0zVcKPhjKW6dJXgZaNuW3C71EIdIZzTZs+
LfJZjK4HwNrFvf3Q4ZQOkuQEPB8luzydV4Ca+n/OLqRKxMQy7OPLnOLMtxHuuM0l
Uphi6LlKiJMw4wE4PewN+v26ju0Z+Wx2uCwYeuPhEJUQhbqfuN0nSvxhsqA5xQKB
JabMpzy0FSt5AJ05XsG46MhOcDA5FolvWKNpS6z7h+IHsyS0t8QERVuWd3YZdfeE
LQHq08KQy2Yk59iPDegcEcXsPrEaYHkLyOJ0vJymQzMXFYmT6YVMPrku1HUm33IH
2lT1Yvv5FXvNFGzgdk8DiOU2G8tVTg==
=5INF
-----END PGP SIGNATURE-----

--QrV3FNVFYO9xzbmKkiYYlmoPb8OG0nPAl--
