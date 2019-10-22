Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9503DF9ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 02:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfJVAtw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 20:49:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:42159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbfJVAtw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 20:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571705385;
        bh=wfzBhJRigVxQXrAWGAk/OUEtZa4Hl18Faond24hkTgE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fkYL4CyEelGgS7cu3tbpBsBFogvWgBRsvOC1c5FC3/XzLQtNHqYkalkEyR9GKUh5k
         3ru4ViI6BB55AoWutV7T9aLlRZHfvTQcFXC50gB4GiptFS1gJ7hip/7HMddAgUFt74
         bJFW7glztlZlpmoSLvxsRJ4v+EPD/+iVEIKMUcBI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8ykW-1iPRvi3GvW-006BOx; Tue, 22
 Oct 2019 02:49:45 +0200
Subject: Re: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
To:     dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191008044936.157873-1-wqu@suse.com>
 <20191014151723.GP2751@twin.jikos.cz>
 <1d23e48d-8908-5e1c-0c56-7b6ccaef5d27@gmx.com>
 <20191016111605.GB2751@twin.jikos.cz>
 <7c625485-1e2b-77f5-26ac-9386175e2621@suse.com>
 <20191018172745.GD3001@twin.jikos.cz>
 <03ba36bd-fa92-fdea-6069-da60fe4df159@gmx.com>
 <20191021154404.GP3001@twin.jikos.cz>
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
Message-ID: <07b33628-2cec-7bd3-26a1-e3be2367774a@gmx.com>
Date:   Tue, 22 Oct 2019 08:49:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021154404.GP3001@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aI6jwsyczkbp1LeFjn4zM28k313IUKwRx"
X-Provags-ID: V03:K1:ST6BgBq27Wm4Pw5GShMC55PGQ8hLfXkGZ4v1JknZYywu724Ci2/
 VLOlBLGi80zKea06eZkyhbqY2kc+TKwM4zAT4FxTFXoD1pOy56RD+88v5jw6i9nncPCFQGt
 kbwUDWUEDy4udNAHDXIE0GQDQcnXzRNeOg+bZtU9OCYpPQckXrS8qD4J2kHYoecNT78TeKo
 AO4Fcrp/UMDeHEtBg4HrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U8QL+P1tBH8=:4UAcZ/Tj2CVtVjs925AAmD
 sh02uwjxptmHEBD9YLhmVnfXM1fwo/hOvmrLjImSdtXIa1A/lSVJWRw/lnEXLQGiD0KJuVNvp
 hyedplDTk69F/YHHk1Q55kpj4Aq0tZ/B68rK3BdP7oeQ7Q6USn70nEFO3LPxjh8hveBogj462
 oyn0edBPrhcRyUnDPDcJiU7aBRgYotCoWZKnKPqEHIkEIOGxDjz38c5n9hREgx+PvGTXSKQvv
 LgDFb7bY1wHvo97IJSt1CsQ1IIEMUf0k9bigpFmhEiSPaNZXV8FyJPpiv7eHgz8ZwrFEJ6g0v
 9EiSRtv2xKVJsJwmf+MpQDu4eA9x2IidwD7BxNgLJnhy7jJ6XieGAMkAUOVFvKnl/IUn0Kn9Z
 RBSFTXGfMfdSk1Fp92U5yqsz6GhF/0JwEiIioQjIO3O6zSJeHBch1SbhgiQm7ZCj7jKCg/BMH
 UlkHWo5/qLSc/zc/p71QVjM9xYtpK1hFeP1V8/Jg9e1xwAQtaQ8bCU8Ln/Y7iW6omSsLHhvhZ
 cKro8Gak00ZOigQernX7dGyxmoxrfuDRmKTYEt930XrkHKttPP/sRc+2P1CO8608AuAq4/zwf
 QI6RQFsy22D/C7lPHnrj8bxqR1YojqrlhxYwA+fHEDvTp9s7Je4HR4Uria9jLOkNe2Msg+05l
 MngWraJdS25uGiY5FAtBurnP0qNABb0J9g/qqXDal6N7U79hHTjzgAw8x3WjzEuDhFeCl0VJF
 MVgsLw582Ie6JAusemDbGTissft09rtPaXJril12MEI9DrhKoUccqIYhdkNL+CM1Lkals3aV0
 4NfB8uriyfiJWr/Oc2feREcnOHhNd/OlKKtzl4vxzd8+o11aNN0EEyiw3K6BPE4FcpEqbSgLz
 6EHXiS0jUvvwpZabiALMbd4p0j3dWs7zYeFdQ2cjtVe0TWAC4Yn3jVPU/ZYDGSdWf9lfyY+p5
 D8Gx55Mg8BszcP4lXFL0v/Xxs/eZtwg6JKAN4pcu0Ry59tlAtxKaK14b8OzIdhTwQb75nqWm0
 PQ8MQYKcPQIrmmHbcbWqOSLG62tFgHh6nuozOOUo1wwem6ljE8GOBRFoo2C5lPPkOwmWVscwv
 NPj8QdZSdielaF5eKkVn0XAgSF8diZA5DB6WADtbPfkafYPn6+hu3vQOGI1V2HRnPYCXjttR9
 ZVmLuGkbY/smaPYCRZ+I5TtkjO0v456LIqi+zbn0hLYZuFJoQe6T3pTWyA7vCQkhf3bG0MCqa
 IKU7z36YJC310uYvywIxxEtR27NuVRrWK/HJxkkbayqLNIOCkBKIuORFFNbU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aI6jwsyczkbp1LeFjn4zM28k313IUKwRx
Content-Type: multipart/mixed; boundary="oPoedBmkHgYtaFpT1VyyG7j2UYkuyyPHj"

--oPoedBmkHgYtaFpT1VyyG7j2UYkuyyPHj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/21 =E4=B8=8B=E5=8D=8811:44, David Sterba wrote:
> On Sat, Oct 19, 2019 at 08:04:51AM +0800, Qu Wenruo wrote:
>> That's wonderful.
>> Although I guess my patchset should provide the hint of where to modif=
y
>> the code, since there are only a limited number of places we modify
>> block group item.
>=20
> I indeed started at your patchset and grepped fro BG_TREE, adding
> another branch.
>=20
>>> We agree on the point that the block group items must be packed. The =
key
>>> approach should move the new BGI to the beginning, ie. key type is
>>> smaller than anything that appears in the extent tree. I chose 100 fo=
r
>>> the prototype, it could change.
>>>
>>> To keep changes to minimum, the new BGI uses the same block group ite=
m,
>>> so the only difference then becomes how we search for the items.
>>
>> If we're introducing new block group item, I hope to do a minor change=
=2E
>>
>> Remove the chunk_objectid member, or even flags. to make it more
>> compact. So that you can make the BGI subtree even smaller.
>=20
> Yeah that can be done.
>=20
>> But I guess since you don't want to modify the BGI structure, and keep=

>> the code modification minimal, it may not be a good idea right now.
>=20
> As long as the changes are bearable, eg. a minor refactoring of block
> group access (the cache.key serving a as offset and length) is fine. An=
d
> if we can make the b-tree item more then let's do it.
>=20
>>> Packing of the items is done by swapping the key objectid and offset.=

>>>
>>> Normal BGI has bg.start =3D=3D key.objectid and bg.length =3D=3D key.=
offset. As
>>> the objectid is the thing that scatters the items all over the tree.
>>>
>>> So the new BGI has bg.length =3D=3D key.objectid and bg.start =3D=3D =
key.offset.
>>> As most of block groups are of same size, or from a small set, they'r=
e
>>> packed.
>>
>> That doesn't look optimized enough.
>>
>> bg.length can be at 1G, that means if extents starts below 1G can stil=
l
>> be before BGIs.
>=20
> This shold not be a big problem, the items are still grouped togethers.=

> Mkfs does 8M, we can have 256M or 1G. On average there could be several=

> packed groups, which I think is fine and the estimated overhead would b=
e
> a few more seeks.
>=20
>> I believe we should have a fixed objectid for this new BGIs, so that
>> they are ensured to be at the beginning of extent tree.
>=20
> That was my idea too, but that also requires to add one more member to
> the item to track the length. Currently the key is saves the bytes. Wit=
h
> the proposed changes to drop chunk_objectid, the overall size of BGI
> would not increase so this still sounds ok. And all the problems with
> searching would go away.
>=20
>>> The nice thing is that a lot of code can be shared between BGI and ne=
w
>>> BGI, just needs some care with searches, inserts and search key
>>> advances.
>>
>> Exactly, but since we're introducing a new key type, I prefer to perfe=
ct
>> it. Not only change the key, but also the block group item structure t=
o
>> make it more compact.
>>
>> Although from the design aspect, it looks like BG tree along with new
>> BGI would be the best design.
>>
>> New BG key goes (bg start, NEW BGI TYPE, used) no data. It would provi=
de
>> the most compact on-disk format.
>=20
> That's very compact. Given the 'bg start' we can't use the same for the=

> extent tree item.
>=20
>>> This would be easy with the bg_tree, because we'd know that all items=
 in
>>> the tree are just the block group items. Some sort of enumeration cou=
ld
>>> work for bg_key too, but I don't have something solid.
>>
>> Why not fixed objectid for BGI and just ignore the bg.len part?
>=20
> I wanted to avoid storing a useless number, it costs 8 bytes per item,
> and the simple swap of objectid/offset was first idea how to avoid it.
>=20
>> We have chunk<->BGI verification code, no bg.len is not a problem at
>> all, we can still make sure chunk<->bg is 1:1 mapped and still verify
>> the bg.used.
>=20
> This is all great, sure, and makes the extensions easy. Let's try to
> work out best for each approach we have so far. Having a separate tree
> for block groups may open some future options.

Great, I'll explore the most compact key only method with BG_TREE.

And maybe also try the fixed key objectid solution, just dropping the
bg.length, while keep the current BGI structure.

Thanks,
Qu


--oPoedBmkHgYtaFpT1VyyG7j2UYkuyyPHj--

--aI6jwsyczkbp1LeFjn4zM28k313IUKwRx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2uUiMACgkQwj2R86El
/qj7rgf+OBxMxAT/V4G2LU32LB2K39eukzzAROVAnVqu3T9DB+piYHwBlLoVVpzm
TF212zhAnn9vOHyu77XHAgz++qTNwsWMCj8n+sUA6YGsu5L4XcGdimODbswraG4q
3tVGnbXTIyhi6ieB34YSlZMh0Dd2YrpDpm7YHOFUYPpfIj+TJ1ZHood9cAEkdfj8
rJMQyP/SKIAQrqqAuZI6B29khBhhotvzrEF8HJwwcouXxxaFcQqKsnJr17IV6IeJ
l/K0p1I5BtQNCs9LqQbjnYpKqSxsbliEWPEMGyqS97uuNvabAV6IxGuvdTbXMOpw
WU7TdohkY13jFBhd98IT1OxzMFdyyA==
=LKck
-----END PGP SIGNATURE-----

--aI6jwsyczkbp1LeFjn4zM28k313IUKwRx--
