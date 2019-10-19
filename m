Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD2EDD5AA
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2019 02:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfJSAFG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 20:05:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:60069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfJSAFF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 20:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571443497;
        bh=m0LbZyfDNDLivz7aqWiu81L1NZewhGGeI9shoTaQVtE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Qfyy2kzxYATKvHZIQODq4vNc9LZAgZ7AOROgO5Kfr8QuesAqEdNLOO1Wum7Ed+aTo
         ngRE0bUjXuldeztil1L6aaULrVflVCNSg+kYM9adiBthxme9UusDCp0qTQhCILneSR
         NKtkuibq9hZwMe7DxGE3HpzvsJSKO97sHw2ssFlE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M89Gt-1iPiiB17rf-005HvY; Sat, 19
 Oct 2019 02:04:57 +0200
Subject: Re: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
To:     dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191008044936.157873-1-wqu@suse.com>
 <20191014151723.GP2751@twin.jikos.cz>
 <1d23e48d-8908-5e1c-0c56-7b6ccaef5d27@gmx.com>
 <20191016111605.GB2751@twin.jikos.cz>
 <7c625485-1e2b-77f5-26ac-9386175e2621@suse.com>
 <20191018172745.GD3001@twin.jikos.cz>
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
Message-ID: <03ba36bd-fa92-fdea-6069-da60fe4df159@gmx.com>
Date:   Sat, 19 Oct 2019 08:04:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018172745.GD3001@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="11eAVbLpSMXWelcemAQ64VebiWxNcUNAi"
X-Provags-ID: V03:K1:CREz8wpgxlCqihccUf0Yy7Tk+hWnV9s5ai1IKqUai6HyYOKk0IH
 JjSh8owYszdpvCDYg2BZnmmdl80p37IOrugUTTlx6HneslyDTAzSxqtbXRCJo0bIjP/Y5uF
 RWbhEgUMSpni6xUgv9PpuxT9r0ngFXXyMFx2wMjcYJcEZSc1wfhkRtgPRQZ6xbSGnoJyiip
 G7KxjHnhlOa5wzlAeaSzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+zuzPyxzVkc=:NyhKfEw37T+RCDwsFsQWOB
 bWg1CU9oJ34FVZJLQxXGvS10TwzNbLVPGAS4B9lDvi6U5ppk9/D2kGsifo+QgbC3UKG4Ca3Lm
 wo4G+rwuoZoU9K0QHeU7C7XRr4fSA8/lXy1Z6cgTmQgXu3clN7YN8o4NNrdCs+8VolJ6VVzdE
 GzcN/ln/RmjdBVVjnREQZVIWAFB4vg/8jPSg81uGVxvGvKceRYANdY9HQWbBz77e9UrlXEKUe
 klBkEWtntPomgSGYBqRMnEpo+TPZ1qg3SDpRqpkHw0056J/ltYBE1QtxGSbkutbzM921mKRtN
 pWm+00nmU4ebDeNP3lco7o+JYwQbUH07SN6wusgI9Xq+8ocPcUXUORE7sJbO1gJ6nMrBbGvyj
 aaklxcAezxM6y77JDMKDop3xL24DdWL2G5J5TFLTIbCehJ4sbMEtRz3R0AkkbJHxsGObPvG1M
 Iu1JTNsX+rA4PP8XsYCurlQ3V2GQBiWAfg/nBiOCHBHfq+ei1ARlxK1wDpbhUwdP3erhan898
 APa0k33XO9uUz5FgJvYDh64UzFRoGNx79SkorNWNqy6C+iezlgNfLLkwwFPyLziTkRck/ZXGN
 nWyqVlZ1WbibPqjC9T3B0dsd63O73L5FReeXzzPLx65rWjyNQg8pXUvHwCtk/3hg1JwWRKLN5
 EZFxQWXxSZTDwmaSPz4Xel/aUJEJp9P5qx58cSdNqBDhufEeIKVLX40ZK7WIkq129sWu1uQl1
 iaBJReqcHIjYKXx6elRrMgxOIA2IjnMDIJMeFPPZqW9/bH8f0K3bs3kBUG2ODsKtS3U4pBNmd
 npIg7l0auY24fNROmnWiNrghKnLo0Y9y/F4S+wCYPZuoEAEQXiNylwlYxb6RpV5nGvVrF3zik
 AJg32b41fJgrAsMd28ftePNS7Oi4TNT9mR2WxhLEGl619xEUVW5I2OAdBtk5hZNySb3MIYFD1
 +vT8h/xxO1FMa6mn8tPL7lYC7jZ0W2B+ckPQBvLyIAhSf8ASxfqr470zOe7V8vomDu8bTB6IQ
 7XiIuCAZSrD36lXLOG+QPgo1w8t5FdOVYAblrJzITMbLHENshAxE1uQQ8Ox8hAFml7jgV5qoG
 Wv6kWtbzCpsumCUd7YM8iane5yDjQcz8QmCyGoN5Xsf32zuWNpJ7TOXBKvaaTlmXDggU0rTrM
 LixvfsIEUQacoLKxdlSViAys3x5GmDnKV4VLHY8H9Go2wD4aorKLU1CL/q2VLfgR4Fu0/Q3OX
 R9djO1oVIrtvPSSLJxpXVbGoIY8E0uAxW4lDcjXE1bSJiFoDlaM24YYzsZmI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--11eAVbLpSMXWelcemAQ64VebiWxNcUNAi
Content-Type: multipart/mixed; boundary="UjIo4vBNWy78YFPouU334ncRV5lntKZnB"

--UjIo4vBNWy78YFPouU334ncRV5lntKZnB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/19 =E4=B8=8A=E5=8D=881:27, David Sterba wrote:
> On Wed, Oct 16, 2019 at 11:19:54AM +0000, Qu WenRuo wrote:
>>>> The most important aspect to me is, to allow real world user of supe=
r
>>>> large fs to try this feature, to prove the usefulness of this design=
,
>>>> other than my on-paper analyse.
>>>>
>>>> That's why I'm pushing the patchset, even it may not pass any review=
=2E
>>>> I just want to hold a up-to-date branch so that when some one needs,=
 it
>>>> can grab and try them themselves.
>>>
>>> Ok that's fine and I can add the branch to for-next for ease of testi=
ng.
>>> I'm working on a prototype that does it the bg item key way, it compi=
les
>>> and creates almost correct filesystem, so I have to fix it before
>>> posting. The patches are on top of your bg-tree feature so we could h=
ave
>>> both in the same kernel for testing.
>>
>> That's great!
>>
>> As long as we're pushing a solution to the mount time problem, I can't=

>> be more happier!
>>
>> Then I guess no matter which version get merged to upstream, the
>> patchset is already meaningful.
>=20
> We'll see what works in the end, I'm getting to the point where the
> prototype almost works and am debugging weird problems or making sure
> it's correct. So I'll dump the ideas here and link to the code so you
> can have a look.

That's wonderful.
Although I guess my patchset should provide the hint of where to modify
the code, since there are only a limited number of places we modify
block group item.

>=20
> We agree on the point that the block group items must be packed. The ke=
y
> approach should move the new BGI to the beginning, ie. key type is
> smaller than anything that appears in the extent tree. I chose 100 for
> the prototype, it could change.
>=20
> To keep changes to minimum, the new BGI uses the same block group item,=

> so the only difference then becomes how we search for the items.

If we're introducing new block group item, I hope to do a minor change.

Remove the chunk_objectid member, or even flags. to make it more
compact. So that you can make the BGI subtree even smaller.

But I guess since you don't want to modify the BGI structure, and keep
the code modification minimal, it may not be a good idea right now.

>=20
> Packing of the items is done by swapping the key objectid and offset.
>=20
> Normal BGI has bg.start =3D=3D key.objectid and bg.length =3D=3D key.of=
fset. As
> the objectid is the thing that scatters the items all over the tree.
>=20
> So the new BGI has bg.length =3D=3D key.objectid and bg.start =3D=3D ke=
y.offset.
> As most of block groups are of same size, or from a small set, they're
> packed.

That doesn't look optimized enough.

bg.length can be at 1G, that means if extents starts below 1G can still
be before BGIs.

I believe we should have a fixed objectid for this new BGIs, so that
they are ensured to be at the beginning of extent tree.

>=20
> The nice thing is that a lot of code can be shared between BGI and new
> BGI, just needs some care with searches, inserts and search key
> advances.

Exactly, but since we're introducing a new key type, I prefer to perfect
it. Not only change the key, but also the block group item structure to
make it more compact.

Although from the design aspect, it looks like BG tree along with new
BGI would be the best design.

New BG key goes (bg start, NEW BGI TYPE, used) no data. It would provide
the most compact on-disk format.

>=20
> I'm now stuck a bit at mkfs, where the 8M block groups are separated by=

> some METADATA_ITEMs
>=20
>  item 0 key (8388608 BLOCK_GROUP_ITEM_NEW 13631488) itemoff 16259 items=
ize 24
>          block group NEW used 0 chunk_objectid 256 flags DATA
>  item 1 key (8388608 BLOCK_GROUP_ITEM_NEW 22020096) itemoff 16235 items=
ize 24
>          block group NEW used 16384 chunk_objectid 256 flags SYSTEM|DUP=

>  item 2 key (22036480 METADATA_ITEM 0) itemoff 16202 itemsize 33
>          refs 1 gen 5 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root CHUNK_TREE
>  item 3 key (30408704 METADATA_ITEM 0) itemoff 16169 itemsize 33
>          refs 1 gen 4 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root FS_TREE

Exactly the problem I described.


>  item 4 key (30474240 METADATA_ITEM 0) itemoff 16136 itemsize 33
>          refs 1 gen 4 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root CSUM_TREE
>  item 5 key (30490624 METADATA_ITEM 0) itemoff 16103 itemsize 33
>          refs 1 gen 4 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root DATA_RELOC_TREE
>  item 6 key (30507008 METADATA_ITEM 0) itemoff 16070 itemsize 33
>          refs 1 gen 4 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root UUID_TREE
>  item 7 key (30523392 METADATA_ITEM 0) itemoff 16037 itemsize 33
>          refs 1 gen 5 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root EXTENT_TREE
>  item 8 key (30539776 METADATA_ITEM 0) itemoff 16004 itemsize 33
>          refs 1 gen 5 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root DEV_TREE
>  item 9 key (30556160 METADATA_ITEM 0) itemoff 15971 itemsize 33
>          refs 1 gen 5 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root ROOT_TREE
>  item 10 key (107347968 BLOCK_GROUP_ITEM_NEW 30408704) itemoff 15947 it=
emsize 24
>          block group NEW used 114688 chunk_objectid 256 flags METADATA|=
DUP
>=20
> After item 10, the rest of the block group would appear, and basically
> the rest of the extent tree, many other items.
>=20
> I don't want
> to make hardcoded assumptins, that maximum objecit is 1G, but so far wa=
s
> not able to come up with a generic and reliable formula how to set up
> key for next search to reach item (107347968 BLOCK_GROUP_ITEM_NEW
> 30408704) once (8388608 BLOCK_GROUP_ITEM_NEW 22020096) has been
> processed.
>=20
> The swapped objectid and offset is the hard part for search because we
> lose the linearity of block group start.  Advance objectid by one and
> search again ie. (8388608+1 BGI_NEW 22020096) will land on the next
> metadata item. Iterating objectid by one would eventually reach the 1G
> block group item, but what to do after the last 1G item is found and we=

> want do decide wheather to continue or not?
>=20
> This would be easy with the bg_tree, because we'd know that all items i=
n
> the tree are just the block group items. Some sort of enumeration could=

> work for bg_key too, but I don't have something solid.

Why not fixed objectid for BGI and just ignore the bg.len part?

We have chunk<->BGI verification code, no bg.len is not a problem at
all, we can still make sure chunk<->bg is 1:1 mapped and still verify
the bg.used.

Thanks,
Qu

>=20
> The WIP is in my github repository branch dev/bg-key. It's not on top o=
f
> the bg_tree branch for now. The kernel part will be very similar once
> the progs side is done.
>=20
> Feedback welcome.
>=20


--UjIo4vBNWy78YFPouU334ncRV5lntKZnB--

--11eAVbLpSMXWelcemAQ64VebiWxNcUNAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2qUyMACgkQwj2R86El
/qjdIggAsY5FN+eiOaa2Rr2sXaAAMB4IYFnWwZoSSmxSqSnkCH7llDnUQzcp3a7f
41G8QO1+TrknDCCCKY7pazXm+1sJ5fb72SwHARDdg0zVDIYPe8OWLNQ/4kiQT0sa
lpnJex/y6n5+UTnnxQIc3VUQD50uU+qUNn4P3OmzxiTmG7fx4wf11Om/N/W+73ni
3VuCbL8a14HWQDMDrggrUhstu1pxalU/t47BoHQRH8vhhA9nuW9TSq9yx74BdGh7
w4bBRcduCd79bMkCY4yyytcEDtD073sk/YyP+qoGE3vFQxlPIMceAaTQw4AGb0Xs
VGni0/ZEsuCtaNiCeyrQQPhe2/PErg==
=Ro7r
-----END PGP SIGNATURE-----

--11eAVbLpSMXWelcemAQ64VebiWxNcUNAi--
