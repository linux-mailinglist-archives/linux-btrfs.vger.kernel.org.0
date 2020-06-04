Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D81EDA77
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jun 2020 03:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgFDBbE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 21:31:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:50463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgFDBbD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 21:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591234261;
        bh=dNzE4kqzc3JG2MRuCm7+q0BvyQFOSb6Sg79ggibDjzA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lfqPjc50zGAtynuKjSEMaIGA/++5WmU5CM/vIYVsATJDA8v2P3B1Nv/q3EujABxn6
         JjMmhSKP74c6vAVsc1cfygXPVFIDoVG2HppYGUS0SmM2CgnWT9VK65RwT4XTNw8IpG
         6zTCzXFXiGyDGwANdF2XGIfVDqoYlkBDw4jbnqG8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUowV-1jY68D3NGz-00QiLa; Thu, 04
 Jun 2020 03:31:01 +0200
Subject: Re: corrupt leaf; invalid root item size
To:     Thorsten Rehm <thorsten.rehm@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CABT3_pzBdRqe7SRBptM1E5MPJfwEGF6=YBovmZdj1Vxjs21iNQ@mail.gmail.com>
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
Message-ID: <5fdc798c-c8eb-b4cf-b247-e70f5fd49fc4@gmx.com>
Date:   Thu, 4 Jun 2020 09:30:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CABT3_pzBdRqe7SRBptM1E5MPJfwEGF6=YBovmZdj1Vxjs21iNQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fxJx8flARgILu1RmPj5jdZHsteEdZ1vNE"
X-Provags-ID: V03:K1:1ZecqfZcfMlTq9vMuXl4v7Ke5Gx5mjiQnBsDVGRPVzLCzau87Mg
 GzUFxXY3PD8voYVdDEqLKZ4Bvig2OswKJ6wTd6rWTcD0Sz5usdibVDqgFlrJwP6oN4/q/lx
 hhg18CLokguJFAjK77uHbvHnpASoeCramCgz+0WFb3yefVapJh5EO6Hx2UoM9qaEtiimuoD
 7K5vb08nitoXiD/YMVIcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t18UB+xpeOQ=:JVWROcwS6eBOQjv+8B04R4
 blBPXVC0Sc92CKJkK67apo9j0ZWshkvV+5WUbWP5g08HJwWartgSD4470+uDEi+dge/6BeYU+
 +TyGTAOPJZ/ZgA96lK+rA4dTDcOQsOD3XQDh0SHtlbrw2h8byxifRnLn2zuy0aMmY0pj5GTjw
 LMQwesl+njPZVY7f2hfqFckJwnPl6eWTXq/t336GHx0GbQWvwLMSjgULu4HLGdPQIr51xo/iG
 ngbqUyR7h1XO0TuwcMoyv9bV69dWxdiiMjLlIMUdgMLzJMH9GNISjOyUAYMRlMZHB8bKYvg0A
 HPpAFxjGeRttqjv0IFf55sifqwYBC54MimPzgBZplY5u8v+yiECnOiTqwZDtYn5F7tLEU9ANI
 auMo0MKSDXIoxNIKxQ/leJ6lhqT6VOzD6yb+dYo2txMCBlA3X/XLJJBi/Bg9KWlXQRJrhIPVE
 JdyWy2PruXtGdZ5jbQH/dAt7+i+E/sXTct9VWbOsLy1eItPc1rcEwlbCscpT2B5M4DoLIC715
 Wvu0WaAX2Sf7Xi1BT4+EXyyFSCw2lW4j1KampXdeIalbjtl+SA7MCrDi0tfJbARAVfjbWxOyZ
 z5YQIUY6W50Mu/ZQCJXDtT/MInILPhyPb6A8DPNe0xUm5iIOzKI+WAfpqNhWyCOM98uPQzqHk
 dk/YYXHxVBDOnla7DFtwH7e4UGiDqFLXptH32wGPaHZz5UowX78XEFvyP1hntnZTGvDqZh5S3
 UCYE7TZqhVm7uFKKi0IUOAt3nxBYRqkM0a7b3xebE6BhypOdiyRt/PK6MP0jeIJf5i37F3bH+
 DA7zT4YNEu79ND16PSkoBMGgyYKfZ8I8WWdjl8SyswhB6JXk0Xqxu7tCWUWiBTPiTdUZ2Jn8u
 eHjHH8Ll32sgN87+c0V8CBelpNcw8qqB+SqP8h7HKDkU2cC1sNsDk4MTAQ6HNRqV2BiH74w0x
 mV4DOOWyBAFzPt/6W4WW0Oc9GAkjdfvbs1Yh8ILvrebRtUagJceTKzdTnvW+Db1iXB3Mujf3P
 YZZNsweQFCZ7nNqoUd9SLON7AWV4qTwjZ4eGcW2qgJEfP928mFfSOjXYHqtklcpo0HEBp9RBP
 CDCH6w6WCEkwpq5TO3gfA8xSWbu4H1gZex2126RFQfWTSd8yuiAxrsePsU4WBK8wFF2NQcugZ
 qsTMheGBLySFp5wOk8iWm9wXulwARl9DwtGe7iuwFWKYD8xrA45zEQRvCiZ+twd9WKRwSQuvV
 9j8sj0pJqgRhtvpn5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fxJx8flARgILu1RmPj5jdZHsteEdZ1vNE
Content-Type: multipart/mixed; boundary="lW8t5f6KOXjKSG1eOeKGO7Rl8nthon0Q6"

--lW8t5f6KOXjKSG1eOeKGO7Rl8nthon0Q6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/3 =E4=B8=8B=E5=8D=889:37, Thorsten Rehm wrote:
> Hi,
>=20
> I've updated my system (Debian testing) [1] several months ago (~
> December) and I noticed a lot of corrupt leaf messages flooding my
> kern.log [2]. Furthermore my system had some trouble, e.g.
> applications were terminated after some uptime, due to the btrfs
> filesystem errors. This was with kernel 5.3.
> The last time I tried was with Kernel 5.6.0-1-amd64 and the problem per=
sists.
>=20
> I've downgraded my kernel to 4.19.0-8-amd64 from the Debian Stable
> release and with this kernel there aren't any corrupt leaf messages
> and the problem is gone. IMHO, it must be something coming with kernel
> 5.3 (or 5.x).

V5.3 introduced a lot of enhanced metadata sanity checks, and they catch
such *obviously* wrong metadata.
>=20
> My harddisk is a SSD which is responsible for the root partition. I've
> encrypted my filesystem with LUKS and just right after I entered my
> password at the boot, the first corrupt leaf errors appear.
>=20
> An error message looks like this:
> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (device
> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, invalid root =
item
> size, have 239 expect 439

Btrfs root items have fixed size. This is already something very bad.

Furthermore, the item size is smaller than expected, which means we can
easily get garbage. I'm a little surprised that older kernel can even
work without crashing the whole kernel.

Some extra info could help us to find out how badly the fs is corrupted.
# btrfs ins dump-tree -b 35799040 /dev/dm-0

>=20
> "root=3D1", "slot=3D32", "have 239 expect 439" is always the same at ev=
ery
> error line. Only the block number changes.

And dumps for the other block numbers too.

>=20
> Interestingly it's the very same as reported to the ML here [3]. I've
> contacted the reporter, but he didn't have a solution for me, because
> he changed to a different filesystem.
>=20
> I've already tried "btrfs scrub" and "btrfs check --readonly /" in
> rescue mode, but w/o any errors. I've also checked the S.M.A.R.T.
> values of the SSD, which are fine. Furthermore I've tested my RAM, but
> again, w/o any errors.

This doesn't look like a bit flip, so not RAM problems.

Don't have any better advice until we got the dumps, but I'd recommend
to backup your data since it's still possible.

Thanks,
Qu

>=20
> So, I have no more ideas what I can do. Could you please help me to
> investigate this further? Could it be a bug?
>=20
> Thank you very much.
>=20
> Best regards,
> Thorsten
>=20
>=20
>=20
> 1:
> $ cat /etc/debian_version
> bullseye/sid
>=20
> $ uname -a
> [no problem with this kernel]
> Linux foo 4.19.0-8-amd64 #1 SMP Debian 4.19.98-1 (2020-01-26) x86_64 GN=
U/Linux
>=20
> $ btrfs --version
> btrfs-progs v5.6
>=20
> $ sudo btrfs fi show
> Label: 'slash'  uuid: 65005d0f-f8ea-4f77-8372-eb8b53198685
>         Total devices 1 FS bytes used 7.33GiB
>         devid    1 size 115.23GiB used 26.08GiB path /dev/mapper/sda5_c=
rypt
>=20
> $ btrfs fi df /
> Data, single: total=3D22.01GiB, used=3D7.16GiB
> System, DUP: total=3D32.00MiB, used=3D4.00KiB
> System, single: total=3D4.00MiB, used=3D0.00B
> Metadata, DUP: total=3D2.00GiB, used=3D168.19MiB
> Metadata, single: total=3D8.00MiB, used=3D0.00B
> GlobalReserve, single: total=3D25.42MiB, used=3D0.00B
>=20
>=20
> 2:
> [several messages per second]
> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (device
> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, invalid root =
item
> size, have 239 expect 439
> May  7 14:39:35 foo kernel: [  100.998530] BTRFS critical (device
> dm-0): corrupt leaf: root=3D1 block=3D35885056 slot=3D32, invalid root =
item
> size, have 239 expect 439
> May  7 14:39:35 foo kernel: [  101.348650] BTRFS critical (device
> dm-0): corrupt leaf: root=3D1 block=3D35926016 slot=3D32, invalid root =
item
> size, have 239 expect 439
> May  7 14:39:36 foo kernel: [  101.619437] BTRFS critical (device
> dm-0): corrupt leaf: root=3D1 block=3D35995648 slot=3D32, invalid root =
item
> size, have 239 expect 439
> May  7 14:39:36 foo kernel: [  101.874069] BTRFS critical (device
> dm-0): corrupt leaf: root=3D1 block=3D36184064 slot=3D32, invalid root =
item
> size, have 239 expect 439
> May  7 14:39:36 foo kernel: [  102.339087] BTRFS critical (device
> dm-0): corrupt leaf: root=3D1 block=3D36319232 slot=3D32, invalid root =
item
> size, have 239 expect 439
> May  7 14:39:37 foo kernel: [  102.629429] BTRFS critical (device
> dm-0): corrupt leaf: root=3D1 block=3D36380672 slot=3D32, invalid root =
item
> size, have 239 expect 439
> May  7 14:39:37 foo kernel: [  102.839669] BTRFS critical (device
> dm-0): corrupt leaf: root=3D1 block=3D36487168 slot=3D32, invalid root =
item
> size, have 239 expect 439
> May  7 14:39:37 foo kernel: [  103.109183] BTRFS critical (device
> dm-0): corrupt leaf: root=3D1 block=3D36597760 slot=3D32, invalid root =
item
> size, have 239 expect 439
> May  7 14:39:37 foo kernel: [  103.299101] BTRFS critical (device
> dm-0): corrupt leaf: root=3D1 block=3D36626432 slot=3D32, invalid root =
item
> size, have 239 expect 439
>=20
> 3:
> https://lore.kernel.org/linux-btrfs/19acbd39-475f-bd72-e280-5f6c6496035=
c@web.de/
>=20


--lW8t5f6KOXjKSG1eOeKGO7Rl8nthon0Q6--

--fxJx8flARgILu1RmPj5jdZHsteEdZ1vNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7YTtIACgkQwj2R86El
/qhYnggAj/Y8ColWnkdsgGV2KVW+zIjCBKoM3rodlVUqX82+kF1dc4JvMbPl6ONQ
H2HjeJ0Ql2AqtJaXyZrQzE/1lo72EdVUwgtoB1v5DYypO5TG5I/2kNBqTZm1EShi
YM+1h0Qjo4OO7t8iWuo6ruiUG/F0J696qHDzBu8SaUCkXkwkMEJ4lp7ATB+lKPsI
Ru4QaaYIx/D1b5jXgTE/wfSxlvIAf2xMhkPIOc7+lbWWQTps063ry/ukbeqwzRZZ
Ytr1Voov5m3KBgCkDUJfo1qAubuUMo6qj/L1NFE1V6PYrXEPafnCfpBPhUpesDeE
/6u3e3VeJ/n6P6CABjU8qdbd3RPmhQ==
=88rC
-----END PGP SIGNATURE-----

--fxJx8flARgILu1RmPj5jdZHsteEdZ1vNE--
