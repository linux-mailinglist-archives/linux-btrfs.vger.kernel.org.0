Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2699F2354C0
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Aug 2020 03:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHBBTe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Aug 2020 21:19:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:54743 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHBBTe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Aug 2020 21:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596331166;
        bh=F8ipo5coTf1fbn1kUdtXynh52teYWgCK34EJSbxrQws=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=C3TgqdtyHBs8wZD8VV9f/lUaL2OHTuKpYluljnW6u2K2Cofdg79D/zheMBLIceibM
         ydJmvMKTQ13HKl5LZ8DtXubFk5fAuekhG7tkek2B47qLc26IinKbdYeYuDCJoEPwEN
         KYStwae2PqXtzUjv3tcb+T3kxjkH+JZ+zSDhNZz8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEm6L-1jzb1C2L3z-00GI07; Sun, 02
 Aug 2020 03:19:26 +0200
Subject: Re: balance loop with raid-1 on 5.7.6-1
To:     Russell Coker <russell@coker.com.au>, linux-btrfs@vger.kernel.org
References: <13086015.6n0rELWJ5N@liv>
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
Message-ID: <927d2761-dfa8-ca50-a1b0-155d70828bdf@gmx.com>
Date:   Sun, 2 Aug 2020 09:19:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <13086015.6n0rELWJ5N@liv>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ilh39EaBZ5iP9ffaspTAGbUFXn8l8pssB"
X-Provags-ID: V03:K1:WiZUcfxw2COLAPCGT/K1GHBw4NADIVemzupSTaUyIOBgOTAQEca
 G+lGASVJ5eHpP7wlRuJQj8AHCboAhYOPnhySBhcw8V2E3UwmTWiDwDeO44McGGBqTLa3lAB
 VbLa0/HQo3ZxPGffgbvFPcRcrBT6L0P86qm953ztSGD60z49DVEw1lKtsIVBhEP78STOVN9
 o5VrCrgFJAqlZQztdstBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:018A9SnjuGI=:YWMaXJ6ibODOO4Rfc0XXNu
 t1B5AckkcypYfzt7CqY3eJKBHl/qc1RZ+eFibCD5cyHuRkIgOtK2wFUTENQYz4pNMioJmxBRG
 0UJGRggXSY/sivyw4paL2qCseY5YCOd/w/JPzR197OnbhQoCoETjtw88RNxzRPNajdgCF3Psg
 HD48o+xbADFN6fr7IZWUyyw2/TUaBSwmlTRkxbsN9VEDXm47RZCph5QjW6WYp+fvUycsQe/AT
 jZKuNL6v9jm01XNKT2EUCLgRdnWPT4mFL/nGE7zEfCIfnIO766kOjUF3tasyJQXy4Uc+YZEq1
 px3XGge1MzN4vO2mMOYKgDgH1maiqNvcFM94OhxSbm+ntxD7jKy4k0TwbxC9RIZOvEWWX2czm
 tdCGXUK19wu3qTC7SKOh/V8aPPF/On3JyQ1+tyFpUrulM/pKx5yxOZO6lyprdGX/Gvzlvx/nt
 hlpko3LVqjLj1QQ82SWkT3eSwRe0AeBWvYhxnFjjwWOshTuSs8A2JbgzCji8yxVtfgktC3mQD
 GAHbxEqoYO8CJ4VBAO+bTbBzIHZmgmNAueYz3BGrZNpNcKf/+MsX3zFHHlxilOqBZ+VYiynew
 1xYCjnOqW1Go8WgB7Be+yReukyDyd0MJGhKkJdN1g+k8CjM3b0im4Mk4xV5Y2Lug3MMUB1EvK
 /xZ5lrPGHdWXgaKIFIxvo6qjbWFNSsuZAmYtI7UZmh1ATc9aGFn0/w/pOlqPmlBlkiVa6BLgV
 PtGe/kbAnVtITYUT1n7O4ypclo0cvrlX/5xYeHd/wvYt0k1ZS3zm2xeBhycDNs49mT7qU4IqO
 fn1FKZZBMaeC0x6Wev6QzJ4oX9VqbrbOymqUJ7I69YgkBdSN18h8qPn6ikxEIM6cFumCBv3DI
 dPS9FrFmgQVp3LfO1WyzB/DQknG7tktArm/Cjg45oLCen0MUHfSE4htbkbMzKLqJ0S9AkYwwv
 YRVy5oUUG3iwEhawOgimvCDhk8Z0IikPvr2D8t67/0gfjNDkoCv8qOUoVgXk0BAU46JbbDc31
 R/PIN+S3isyDegqQLNgd2LcCKnNi2LLbPQ77LyXXnU1yo3GiRVEyYboT2RaSsC7RGhgQe9QP1
 ZDBLD1cCGA/M6y3lTao7aBpc9m2+rV3svWGrEtnTYBqcEFJjiHLQQqTRg93TKdX0eOWqmAUGo
 QIpGJAm4hVZklOhEVVAwFxUJ9i47hPPYy6sqag9PuJ7/Ub/sUAQA3jvjC03TJQEC9i0BMwusZ
 RMmvdbC7vAu6fF2HBfznU6xgDI725DWqL9RKcmQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ilh39EaBZ5iP9ffaspTAGbUFXn8l8pssB
Content-Type: multipart/mixed; boundary="k1CSgY2FU4bAPXlkX4CxCvLtED6btuEhJ"

--k1CSgY2FU4bAPXlkX4CxCvLtED6btuEhJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/2 =E4=B8=8A=E5=8D=889:07, Russell Coker wrote:
> My monthly cron job which runs a btrfs scrub followed by a btrfs balanc=
e has=20
> just gone into an infinite loop.
>=20
> root@xev:~# grep -c "found 69 extents" /var/log/kern.log
> 322889
> root@xev:~# uname -a
> Linux xev 5.7.0-1-amd64 #1 SMP Debian 5.7.6-1 (2020-06-24) x86_64 GNU/L=
inux

This is a known bug, and backport for 5.7.x only arrives at 5.7.11.

So please update your kernel to latest 5.7.x stable kernel, or try
v5.8-rc kernels.

Thanks,
Qu
>=20
> Aug  2 02:57:09 xev kernel: [894810.916299] BTRFS info (device dm-1): s=
crub:=20
> finished on devid 3 with status: 0
> Aug  2 02:57:09 xev kernel: [894810.947243] BTRFS info (device dm-1): b=
alance:=20
> start -dusage=3D60 -musage=3D10 -susage=3D10
> Aug  2 02:57:09 xev kernel: [894810.948707] BTRFS info (device dm-1):=20
> relocating block group 2734629453824 flags system|raid1
> Aug  2 02:57:09 xev kernel: [894811.034399] BTRFS info (device dm-1):=20
> relocating block group 2659366862848 flags data|raid1
> Aug  2 02:57:15 xev kernel: [894816.467989] BTRFS info (device dm-1): f=
ound=20
> 12902 extents, stage: move data extents
> Aug  2 02:57:40 xev kernel: [894841.585184] BTRFS info (device dm-1): f=
ound=20
> 12902 extents, stage: update data pointers
> Aug  2 02:57:41 xev kernel: [894842.878672] BTRFS info (device dm-1): f=
ound 69=20
> extents, stage: update data pointers
> Aug  2 02:57:41 xev kernel: [894842.915311] BTRFS info (device dm-1): f=
ound 69=20
> extents, stage: update data pointers
> [...]
> Aug  2 11:04:01 xev kernel: [924022.697116] BTRFS info (device dm-1): f=
ound 69=20
> extents, stage: update data pointers
> Aug  2 11:04:01 xev kernel: [924022.754418] BTRFS info (device dm-1): f=
ound 69=20
> extents, stage: update data pointers
> Aug  2 11:04:01 xev kernel: [924022.805762] BTRFS info (device dm-1): f=
ound 69=20
> extents, stage: update data pointers
> Aug  2 11:04:01 xev kernel: [924022.870560] BTRFS info (device dm-1): f=
ound 69=20
> extents, stage: update data pointers
>=20
>=20


--k1CSgY2FU4bAPXlkX4CxCvLtED6btuEhJ--

--ilh39EaBZ5iP9ffaspTAGbUFXn8l8pssB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8mFJkACgkQwj2R86El
/qj50gf/TrwgC80G779ud52Uxp8x4jq+QJo+O+/yYOuGvZ1LxsmtT+IuvY5zGWKU
2DXvMBDZdjvpshitZKXUq8x4MBtXFikoqiHqpsGLG6QfBfk8QoHlLm7DP2pl8MSh
BK/ZxKrScocWTjErzde/qGQ3z5EIO/7kxGd4C7rR4che7zMzamwdM6GcR7i0H0oH
/jvAW1EtfCdFbXlbYbuh73tcMR4z61g2GdBvJPeG/9fYyxvtXyldTk3cfitUoEPO
ULBut+jp1vEbuAy2+2XGAgVyGT8fWAoH+JzZte0+ZLEM7AXPvDbH/fWZHAWIvrdS
gyKECiV2DjzwtXBB7Va6c9p97qJuVQ==
=97Tq
-----END PGP SIGNATURE-----

--ilh39EaBZ5iP9ffaspTAGbUFXn8l8pssB--
