Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 355D81A0E94
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 15:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgDGNnY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 09:43:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:53581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgDGNnX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Apr 2020 09:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586266996;
        bh=mNioJ/37nEZrQl/TKY9RK2ck5M/NiTHZnDh+wqrjdvc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dEzEkuj23YYvv/qDu9daQX99uS8hgJEt5SjdrRUn9+ZDCZ53CqQ9X5Pdb31znkKro
         c4rHN9tditHh4JFpIduSTTCjanVxV69za32afuIQZV3qboQgM7xczXXqtWjZLXdzuT
         fdwk5D+N3d3tTWxaUSAoD5dw5fACs7igXuUklHBc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mq2nA-1j0HFh3ARO-00n7ZO; Tue, 07
 Apr 2020 15:43:16 +0200
Subject: Re: [PATCH] btrfs: Move on-disk structure definition to btrfs_tree.h
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200407084434.46143-1-wqu@suse.com>
 <20200407131414.GS5920@twin.jikos.cz>
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
Message-ID: <2751ebbf-dfc4-b453-b807-17e86be43929@gmx.com>
Date:   Tue, 7 Apr 2020 21:43:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407131414.GS5920@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H89rrWk0PstxmjC2ztvWpNCkmsgdg9qbP"
X-Provags-ID: V03:K1:jbXEFY+Af9EZmDYMdsbgFE6oHPy11/ycQC4WzyOD4MX3UN+f9ci
 g0Z5zoRvDzwRYqnDltxsl9fg3nVmOD8PljFN1VFGuzCQr42s4qEIz6rnhsAH4NRuH8Il18N
 J68YdO57caKkl9Aj/Tx56Hfp7EIoa7YJZPGBCwabSp3II56uo2Jf2Cv/BjjE1krY9bLLmw9
 o3hXT3bkS6qm4bZcyg89Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nbmaw+lOsh0=:n12Yp+foo+VRprLmKB+xDr
 xqGyuOK/rXR+RHLtVmJi7WaockCe5pg286fepBRwJC6EPWq6fwGctaMA/DwaDBcJW6aPlHYSh
 9EAv5GDfk3PAybGbFRbUJae0A2Kn4IxDBAI8XyTbXqylkzakyNtcvjjbcet8OP/l4kb8LssSx
 KE7mGhcOvbQLwjkbAge+viCFiYcseRwuoaN8iK1XxQpmJYcB2S7sDKdK71M9p+rvsLGbUcPOE
 9IdTSpe33ey52dMBVVwL10dV/4y4yBXtZ+PGvNcJ6MiLLBIYJ4sY/ws4Tno6/Q55/ls/kmVQx
 KkfVFRYb3aUx1xPHkjzUV/e0NQye+EKGdpiC+rdBOjWwMxMRM0sfCAUFzqA1lI7cGPWOAaReh
 IP3HOXXJabuBV0BYRLYgNlnhRCxDVDriOIVH0KKAHTIJLVwutTGnzXURrdvHMRVAbT80QeVMN
 t5fL09kCC9T3F+lFDTIBLqExA+gpqdKurPW98Bpo6OeaO8eK4X/o9VvA8aq8LeG+ARo0kBrTY
 vN8oTw8oSjIlLSHKz7rLUsdbH/5MlL6x8uympsIHbxqp7fYg7xSNwsz7nZp0So5F2614SAd2n
 ZdQzj4I0dbi+i9a9M9urC8aa4iNZqqwrVPfZzzlVymFWgOIs4ToNEqGTla4iiPyjccd5CZM/b
 ArI99lqqge0uA3pNI7zeA9ov1LgVqcTVZplc7xw8F1kanVyRT7ehSBnenQNTSBpZw4J0hWGrS
 bx7rEoalkYrYbDtFc9HLJBGLaOW1u0mzkm0MTbzYIxERGfTACgw7biT7SWUH+QyV0VFJqOvPb
 OmKwIgh9EcoIlVqPwPr2mJnoBqgLZv9aLmgR/XEIg4ovucZUJ5kpoVJh+TgE63NLAJHGugIgj
 9RnwRIHn/Wv7h0+bI3DXmInEcVEnQOZhBIlCt+je/N9hlpFfDnYciZtXB2OFRE9RxbPDQxnSN
 lz0U3un1HfoOkZT6eG2RxWyO66UT9VeygZTYCMpFNkDFhYARLb6M4FC9mw/lI0Wbge2pgDbng
 9vuusKBMb2Umh/FzF6r3tdkJclLaSSpFN67Tp1w0BzFnSRk+DOymrSy7LGlLOPRie4tnmmGFt
 hrROcjBJ5U+xaAMs5207eKPN94a1vAXnt/G6s/WuXu3X7oUOOrs3j/guIui5JSBfJUZxde0wb
 uxi3wGvX5+Am38Bvu4ghpGD0EpPs6NiYMmRdxssloMYgbTG5gH008vK4NlLq95OxAAIxc1E3B
 PAkPRrIGBjInRUNv1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H89rrWk0PstxmjC2ztvWpNCkmsgdg9qbP
Content-Type: multipart/mixed; boundary="AwthAPsYSUxC3i5hjpbIqzf5te2LDcw8S"

--AwthAPsYSUxC3i5hjpbIqzf5te2LDcw8S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/7 =E4=B8=8B=E5=8D=889:14, David Sterba wrote:
> On Tue, Apr 07, 2020 at 04:44:33PM +0800, Qu Wenruo wrote:
>> These structures all are on-disk format. Move them to btrfs_tree.h
>>
>> This move includes:
>> - btrfs magic
>>   It's a surprise that it's not even definied in btrfs_tree.h
>>
>> - tree block max level
>>   Move it before btrfs_header definition.
>>
>> - tree block backref revision
>> - btrfs_header structure
>> - btrfs_root_backup structure
>> - btrfs_super_block structure
>> - BTRFS_FEATURE_* flags
>>
>> - btrfs_item structure
>> - btrfs_leaf structure
>> - btrfs_key_ptr structure
>> - btrfs_node structure
>>
>> - BTRFS_INODE_* flags
>>   Move them before btrfs_inode_item definition.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> This moved btree_tree.h is more appropriate for btrfs-progs to reuse.
>=20
> This actually answers 'why' the change is made so this should be in the=

> changelog but I still want to know the reason to move it to the header.=

> Do you mean that progs from git would be built #including this header
> directly?
>=20
No. As you answered a long long time before, btrfs-progs shouldn't
include global kernel header directly.

Your answer was for case like building btrfs-progs on older kernel, and
I still believe you're right.

For btrfs-progs, I will just cross-port (copy) the header to btrfs-progs.=


The re-use part doesn't only limit to btrfs-progs.
In fact, there are already two more projects which can benefit from such
move: grub and u-boot.

This patch is the base stone for later u-boot cross ports.
The idea is to use kernel headers (copy them to related projects), then
re-use a subset of btrfs-progs to implement a full read-only btrfs code
base in u-boot.

Thanks,
Qu


--AwthAPsYSUxC3i5hjpbIqzf5te2LDcw8S--

--H89rrWk0PstxmjC2ztvWpNCkmsgdg9qbP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6Mg3AACgkQwj2R86El
/qh9iwgAl4aT1DUeX+4a2AKL8m9XQLrYePAaFvKuJrUSc0QBTrLa4JZfjE78g7bS
uuTCzM+a/AE25vf88ZMKGUv8Hq18G2sq44yhUjfM+GLpPIyNI/jsl4p2Y/YSo6Nt
/FHQCez4o7WWqzK68k2RXQf/ctX7/1gIVhcB8ddLftOR3mX4CMNeOv8MU7PiVWtj
FtNdfv5eR6rfTWFz7sDC0ChX50LwtdtipsjmQbU4z3tMRTiYLIWHsfdl0F9EHqoh
tm6guB2iwMF2uMsVVTg5qHvXF2bsWhZqbA9z2c0nYhS3dQZ5evMh//Km1dk6dxH4
7HFBtlkO8n3mFVftk82dXSeVJV1+bw==
=ymVC
-----END PGP SIGNATURE-----

--H89rrWk0PstxmjC2ztvWpNCkmsgdg9qbP--
