Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D865F273FB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 12:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIVKe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 06:34:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:33771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIVKe2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 06:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600770861;
        bh=gK0RFP6GyazagibZBvMt5lSyd7+MlIn9Rhol550SGmY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=T/9c7fIkJ0p1eHSGmfmo0wd/421I1UE0ZoWIKPSTIE7RPW0xqu3HmnR5eCqVI/PYV
         L8czxMFgrBivQtZe3jU6qykjYEELXc2LxQOM3XZvABkBHvBCAxItNFTNa3m0QZUjec
         bAC/vkwf/q+gMIKLu7L5qXwGFffZS8A4huHwhTp8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIx3I-1k1MM30kyA-00KRH4; Tue, 22
 Sep 2020 12:34:21 +0200
Subject: Re: [PATCH] btrfs: fix false alert caused by legacy btrfs root item
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20200922023701.32654-1-wqu@suse.com> <4591966.Q0mfgpEauH@merkaba>
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
Message-ID: <6db35b15-1f16-dfd8-368c-b03e428eba08@gmx.com>
Date:   Tue, 22 Sep 2020 18:34:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4591966.Q0mfgpEauH@merkaba>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ANoT8dRVQgFZZJmFGN0e6ZjwKdDCk0Z2C"
X-Provags-ID: V03:K1:MfIBEOTNXxzC4UIEGZRtm/2nNsDAPLAwwuVlHJ3kP8Kbdsw/sx3
 o5qOmFGG4sG90BOagbDvUof/2pg0VvX8tmHDddQk9Hlq3Mgu26kVsts2Tp+4d9ZOnrXU65v
 h9+q5yfIqpk46AFJjlBsarbN1rrrqV3cBOeKXtXEaeDJ+3nbBbI8IKHc7o0Jd3ZjzDRD8vH
 +fKK1OXti+JCzRx9nTK/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6MrNvjgCYK4=:Vnd8yRwvwf13N0JX5U/AV+
 Lj19KBF6TucEHRy9uV4IPine/ReuSho8EqoiBQRWFsR0x0Pwl3S5ARHmhmL0TjPW3euMWXg7n
 1wAWPweWpj7W4iE1pGnZbPYkK722+vQXShHNVpT4pOEU/OhnZSVRwB+c+XO7c1c8OAabGIWmX
 8NulSDgW6VI+Ok545tAKR9mqq6J633KEiT3rwdlI6wo1yt06D7xrOsG1zXGnz0BB6+m2SAvuO
 hGIsVNbQ/D8rO+5E3/dhIxMO0ZAbFa6ce8er8t2/yq2r1aK00xDDwW6lt+d33DbgaX4yiNpTz
 +OLayLosOwPT//FQLqQ8bRfOqi85AfZwGNQPlcaXOlzH7GEnktsjadSxT2wJ50y9ONC4Db+O6
 oIDacvLsR5B6wcaZdbGOlMSZR4v4RBrH6jGHpYFzLRJQn8Yc1Q2xv3AuYlDNtBbv2Joz2UZeZ
 m1R3HMS1HiVj05wYaadiaKM0X7I4r9owUmVWsHufPAm3xX85r4zYJSgGeOb+6x8X51XBNZVjZ
 QxygX4fOImgPL22ChpmM5OXbFqUFz9ebPnDYW6+6Aw7GZMAjV1luZmi2La4CrTQZCyTZyYaSC
 5vqoTIZS5pkZ0pNptPakenJgT3xIJb4pVQbgTNZFATSIeNbyhjAFsC8xcmznL8jPI6HhQvvrF
 mceAlBoWp8+qI5mr+WY+48lYo83C4lHi2g3fXp15Pwq2hkdJfuzzSevCaRiGKKpHNXNtU4mjJ
 D0us1QTgjv87CxkHjvVMyxX5fpOQJog3Nwo5/pQb8QF7vEjgXENiofM/KX8BVqydYrm9ByiOc
 wGgKA4X1W6rFqgrOnlj/zJTN7lBHjuVu5dH+MwYEcf0QBhQoqGi0++e1FM3aEaobWMjBBm3o1
 AP1jSb6crRrcnoJI+oVqdioh93U39iMnditnB64YwKjt8/9jVt4JmWfJ8cPdmLPwrKiApqkJv
 bsK252BVkMknGm7ZYAbOnQZVk+BobRVtPLsB26M1m3N4hh9cWm7V0uEXzTsBTV4Jamg+jqnLA
 uGeFvhb4ws4kI/jfFJJ0Zi9nKBTg2M6T+NOIADQJxjMfrNpYxQIhWWC9u7oveQQbWFoYBKBUC
 rrmv6Ek0sKxRP/OWeaiLeHVAdC2pNP2bXFOrM2gGQBug+Dj9R6w0CZpUptbygxss3tZ+WTmGC
 fo9qUpBe35rBPAy8lMbtYokIa31ZjJo95pyL39rhbKNHmRrl7NaMXBXLiKb7K33aVgKJqvm8q
 QvkE9ppacByvBJWT2xXIjD4Xp7SR2yO5nFbBAPw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ANoT8dRVQgFZZJmFGN0e6ZjwKdDCk0Z2C
Content-Type: multipart/mixed; boundary="odu05pg9Dx9R1O28jXPjCJIhrTQAXnJs4"

--odu05pg9Dx9R1O28jXPjCJIhrTQAXnJs4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/22 =E4=B8=8B=E5=8D=886:20, Martin Steigerwald wrote:
> Hi Qu.
>=20
> Instead of the tool, can I also patch my kernel with the patch below to=
=20
> have it automatically fix it?

Sure, this one is a little safer than the tool.

>=20
> If so, which approach would you prefer for testing?
>=20
> I can apply the patch as I compile kernels myself.

That's great.

That should solve the problem.

And if you don't like the legacy root item, just do a balance (no matter
data or metadata), and that legacy root item will be converted to
current one, and even affected kernel won't report any error any more.

Thanks,
Qu

>=20
> Thanks,
> Martin
>=20
> Qu Wenruo - 22.09.20, 04:37:01 CEST:
>> Commit 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
>> introduced btrfs root item size check, however btrfs root item has two=

>> format, the legacy one which just ends before generation_v2 member,
>> is smaller than current btrfs root item size.
>>
>> This caused btrfs kernel to reject valid but old tree root leaves.
>>
>> Fix this problem by also allowing legacy root item, since kernel can
>> already handle them pretty well and upgrade to newer root item format
>> when needed.
>>
>> Reported-by: Martin Steigerwald <martin@lichtvoll.de>
>> Fixes: 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/tree-checker.c         | 17 ++++++++++++-----
>>  include/uapi/linux/btrfs_tree.h |  9 +++++++++
>>  2 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 7b1fee630f97..6f794aca48d3 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -1035,7 +1035,7 @@ static int check_root_item(struct extent_buffer
>> *leaf, struct btrfs_key *key, int slot)
>>  {
>>  	struct btrfs_fs_info *fs_info =3D leaf->fs_info;
>> -	struct btrfs_root_item ri;
>> +	struct btrfs_root_item ri =3D { 0 };
>>  	const u64 valid_root_flags =3D BTRFS_ROOT_SUBVOL_RDONLY |
>>  				     BTRFS_ROOT_SUBVOL_DEAD;
>>  	int ret;
>> @@ -1044,14 +1044,21 @@ static int check_root_item(struct
>> extent_buffer *leaf, struct btrfs_key *key, if (ret < 0)
>>  		return ret;
>>
>> -	if (btrfs_item_size_nr(leaf, slot) !=3D sizeof(ri)) {
>> +	if (btrfs_item_size_nr(leaf, slot) !=3D sizeof(ri) &&
>> +	    btrfs_item_size_nr(leaf, slot) !=3D=20
> btrfs_legacy_root_item_size())
>> { generic_err(leaf, slot,
>> -			    "invalid root item size, have %u expect %zu",
>> -			    btrfs_item_size_nr(leaf, slot), sizeof(ri));
>> +			    "invalid root item size, have %u expect %zu or=20
> %zu",
>> +			    btrfs_item_size_nr(leaf, slot), sizeof(ri),
>> +			    btrfs_legacy_root_item_size());
>>  	}
>>
>> +	/*
>> +	 * For legacy root item, the members starting at generation_v2=20
> will
>> be +	 * all filled with 0.
>> +	 * And since we allow geneartion_v2 as 0, it will still pass the
>> check. +	 */
>>  	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
>> -			   sizeof(ri));
>> +			   btrfs_item_size_nr(leaf, slot));
>>
>>  	/* Generation related */
>>  	if (btrfs_root_generation(&ri) >
>> diff --git a/include/uapi/linux/btrfs_tree.h
>> b/include/uapi/linux/btrfs_tree.h index 9ba64ca6b4ac..464095a28b18
>> 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -644,6 +644,15 @@ struct btrfs_root_item {
>>  	__le64 reserved[8]; /* for future */
>>  } __attribute__ ((__packed__));
>>
>> +/*
>> + * Btrfs root item used to be smaller than current size.
>> + * The old format ends at where member generation_v2 is.
>> + */
>> +static inline size_t btrfs_legacy_root_item_size(void)
>> +{
>> +	return offsetof(struct btrfs_root_item, generation_v2);
>> +}
>> +
>>  /*
>>   * this is used for both forward and backward root refs
>>   */
>=20
>=20


--odu05pg9Dx9R1O28jXPjCJIhrTQAXnJs4--

--ANoT8dRVQgFZZJmFGN0e6ZjwKdDCk0Z2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9p0yoACgkQwj2R86El
/qg+iQf/bHCJa+Ipv4YCunv5wDvzRQEMMQP19Wt2GLyEYi/t9mdhSiwkhlskubHQ
W+s1IghwAsYTfM5MU9w4Cq4b93DGh8zjOlPsVp5lK5PU3RvduB1zq/pNX1Jddxw9
dGhqdRYZPw6M7XvvsJSNad8K2X67bBhNuAnr15Vx6kO5UXPrtBf6LdKorX98yBeP
ZtDRQk8Jr7QhJTI5bMWCcK0qU7z9r5fuZpVOZTgAzEgSE5l0BhvihKfNlUBEE9+x
zEA7QBVlYV9fjpXAwBqRxVfGw26c3C1kgt0+kp9VadxsFH1r7NEoq825t++TqmlG
k/Qt4/wrqUWEQJMeMD06WzqgDY2hmw==
=kAQ7
-----END PGP SIGNATURE-----

--ANoT8dRVQgFZZJmFGN0e6ZjwKdDCk0Z2C--
