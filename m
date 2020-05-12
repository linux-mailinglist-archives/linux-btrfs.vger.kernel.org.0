Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38A21CEAC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 04:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgELCa6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 22:30:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:45005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgELCa6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 22:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589250651;
        bh=FkQctqB3YgJhHBKDAYkjGJK0wSlfOj9MJccoaSuFJ3I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NzAQPtvgvHqkeT7HowKDcRnFiRbrFP6AWAIuIuOyN41k1/+eA2svh73zZcrBrO5xU
         tD4/KbdeXfQhjo0qXf5+n3eX/6L4KM2kU43yialUGzYC42fh/a7da9I6i9D9opRqFO
         s0+zMluE/cqJOQfmM2IWhiQGLc2SRcODGF3bvTCQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McYCb-1iyRdv24lh-00d15i; Tue, 12
 May 2020 04:30:51 +0200
Subject: Re: [PATCH v4 00/11] btrfs-progs: Support for SKINNY_BG_TREE feature
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200505000230.4454-1-wqu@suse.com>
 <20200511185810.GX18421@twin.jikos.cz>
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
Message-ID: <ce5fe286-fa4a-e282-3b92-564cab62b776@gmx.com>
Date:   Tue, 12 May 2020 10:30:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511185810.GX18421@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cMGhb17zTFFlQPT4woTjI9OhywqiVR2u1"
X-Provags-ID: V03:K1:YlNolYHkRC3/MCRvuomfNphQHFPF/tq1eALNZbx/dNQlXP6HC/M
 rPmJhKx837WMFLGk4TJqbXWQoZH/Ms9mUzPMaN3sBARLX9c27FfDYWvB6XbZhM/HLcxItWy
 zgHC0GFwnf9dPyjPQJUKFxP6t+78QpVZ7D9Okw0wkmNzbHW/ZInYDX0Sj3oX/dAG9bWlAlZ
 43NSv+JgECOAaBJIkD82w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eFTM272a9y8=:Ga5oeYz4UYUhBTJPdultJS
 kspuUc66WLMNzdrVoMC2nxI9pWlvdVcX3PL6FfpY3Z37Xgwv64M9OlOBbFiM66iHkr8Fa4qEW
 6Huy5rRnDTr47xPCCqcnCkgW6s22Gr/FizPecS/L7rTHbTzEWCGOe/rlWRERDnpP3g8iSMe8T
 +5hFe3z6BUB+gjN0oxBKFY/O6VnKha9KnZwctQDVJS9QU5CyfYwwLidGbFVgCxlR1Dz/A6DbZ
 DbombQVXpyfwjomXLVriyQArCVerhdj4HnXesONvD9SqBlxUmHdRC7HftTlyT4VvYTkVfRe1/
 rFP7Eje6u0mqRvDyYuep82yP26GcfV40SRdjE3zCrgN+E3xFsBq+2MIqVsZMBJZlGDqlzPJRz
 mlCftV3SuZe+FfqAv6oUIOawCcYTpDZdOG4dSIJuwSSvYKxIdvhPZFOppX22GqGvLQaIE7H83
 UoBKdxVEQLea4qoc648QHM6FUzsALNseyUG4wZo8T4v2UKxo167KXDIcMIWI2V7druA1F/2Ae
 KrwY3cKD10wNdtca+ntLSBny3m+zBJyC2lPKgcjHEGz48OVkcDU0tL5+edRIoYuPqpOWOD7L2
 BLNje150a9HaNr0xWz7a0IEu5gub4GPiVVNh9JWYCyF95TJCAhT3/+xWsy//99xB8mKpfmk5t
 TzzuBkLhe3BY9uMvDOJd9xw5PejH1DEsDHzJbXGAk0UBu3lbPu14HmLB4sqDpvYNeadgxbq6u
 1RjdYxPzWoqyA2/dV433dm3Of+bWQmF0KFECkqRI/fDeLPQwNz1Gk6kdVut5FSk6WHKnErrHk
 gyvRPh+a5p6Ob/BEpXWEtCxpkt/lfhCy207pk2HYtqg7dYy9jXz3CwMKft7kDaqR+bTxzV55Q
 zs9VXnOZEwWjannzOIrm9OZ/GmMYQoGvZBbxyO6riK3Syc8Si8Q8/GriBTr1rUWGJsuRW2oTK
 g2L6aJFG/bvFgonCAUv6b/1r6OAwRJFUVZjgjvmOr5Rod7blEcS4pl0mrTg0hpp9ss2NAYkEF
 LRTlc70UJld0r8cw+R9LlO/CkKgbNuCu/4b0kCXrfJ0b1MFHQZtPSrpZXAFVhUqWoM4zwpbx+
 lJH5Pa/oRrynQ/B1o+7CvPrapaIWSUVx5AuOcmSMtdD5R14pR1SPEyfsHbEUWp745AZdPRmw/
 KHR+6Ug83mnpfJG9qMG+MOe7/SlhItAvALd+laZLagW8qa1IxDLgJboR3+pF+uxYDLNERiBQe
 5CnrMK20Vegd2WcxU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cMGhb17zTFFlQPT4woTjI9OhywqiVR2u1
Content-Type: multipart/mixed; boundary="cqe6u9xVdu1vR2Jfofbj6lYoFAZ3S0QOM"

--cqe6u9xVdu1vR2Jfofbj6lYoFAZ3S0QOM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/12 =E4=B8=8A=E5=8D=882:58, David Sterba wrote:
> On Tue, May 05, 2020 at 08:02:19AM +0800, Qu Wenruo wrote:
>> This patchset can be fetched from github:
>> https://github.com/adam900710/btrfs-progs/tree/skinny_bg_tree
>> Which is based on v5.6 tag, with extra cleanups (sent to mail list) ap=
plied.
>>
>> This patchset provides the needed user space infrastructure for SKINNY=
_BG_TREE
>> feature.
>>
>> Since it's an new incompatible feature, unlike SKINNY_METADATA, btrfs-=
progs
>> is needed to convert existing fs (unmounted) to new format, and
>> vice-verse.
>>
>> Now btrfstune can convert regular extent tree fs to bg tree fs to
>> improve mount time.
>>
>> For the performance improvement, please check the kernel patchset cove=
r
>> letter or the last patch.
>> (SPOILER ALERT: It's super fast)
>>
>> Changelog:
>> v2:
>> - Rebase to v5.2.2 tag
>> - Add btrfstune ability to convert existing fs to BG_TREE feature
>>
>> v3:
>> - Fix a bug that temp chunks are not cleaned up properly
>>   This is caused by wrong timing btrfs_convert_to_bg_tree() is called.=

>>   It should be called after temp chunks cleaned up.
>>
>> - Fix a bug that an extent buffer get leaked
>>   This is caused by newly created bg tree not added to dirty list.
>>
>> v4:
>> - Go with skinny bg tree other than regular block group item
>>   We're introducing a new incompatible feature anyway, why not go
>>   extreme?
>>
>> - Use the same refactor as kernel.
>>   To make code much cleaner and easier to read.
>>
>> - Add the ability to rollback to regular extent tree.
>>   So confident tester can try SKINNY_BG_TREE using their real world
>>   data, and rollback if they still want to mount it using older kernel=
s.
>>
>> Qu Wenruo (11):
>>   btrfs-progs: check/lowmem: Lookup block group item in a seperate
>>     function
>>   btrfs-progs: block-group: Refactor how we read one block group item
>>   btrfs-progs: Rename btrfs_remove_block_group() and
>>     free_block_group_item()
>>   btrfs-progs: block-group: Refactor how we insert a block group item
>>   btrfs-progs: block-group: Rename write_one_cahce_group()
>=20
> I'll add the above patches independently, for the rest I don't know. I
> still think the separate tree is somehow wrong so have to convince
> myself that it's not.
>=20
One interesting advantage here is, separate block group tree would
hugely reduce the possibility to fail to mount due to corrupted extent tr=
ee.
There are two reports of different corruption on extent tree already in
the mail list in the last 24 hours.

While the skinny bg tree could hugely reduce the amount of block group
items, which means less possibility to corrupt.

And since we have less tree blocks for block group tree, the cow cost
would also be reduced obviously.
As one BGI (just a key) get modified, all modification to other keys in
that leaf won't lead to new COW until next transaction.

So personally I believe it's much better than regular extent tree.

Thanks,
Qu


--cqe6u9xVdu1vR2Jfofbj6lYoFAZ3S0QOM--

--cMGhb17zTFFlQPT4woTjI9OhywqiVR2u1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl66ClcACgkQwj2R86El
/qiJeAf+M0XIa6125ZvximupuZyfDddv7y9yxMFMvYJH3O95yupPYOJUXwomcdXi
eeGbqPtgTm+J4heQrkaq2Sdscq8GpAb5dxojZ6qPk7PMhRW+AL9waWJcJVzOlMvw
lP5JzLjLBRYc3jERJIlX9wdp9PW6e1YMEYPbw9ZXYaXifzTKvMZPNDmGpl6o1J1d
PwhuDPEYPWDzXm5xBylLhjcUY9TmmUrBTCJFKHJOv4oNURLj94WaVtdFOWYzDoJx
RCfsMbV8xP5zZ0Q/zlg70j95gwrBpcH9gP8IvCG/6eZIVQVtXBFso1lOc/Q0dsDx
Iofjl5NBcVAlbecDPxKCj5gkK3BeTg==
=0GEA
-----END PGP SIGNATURE-----

--cMGhb17zTFFlQPT4woTjI9OhywqiVR2u1--
