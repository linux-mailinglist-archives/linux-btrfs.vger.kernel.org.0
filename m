Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB4131D9D
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 03:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgAGCar (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 21:30:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:33637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbgAGCaq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 21:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578364232;
        bh=+uRy6rNwTArKU5U1+uD+bnXBsnex9gfbF1jjorqLMP8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Wv+Qe8EAe1m6D8hbFitUKNn/3uSmYkzZWqmJhuIy5D/mMi+HEn3iVE7hnWGDMFnG3
         2eglqqfjleM18N6hu4bz+dK46NLF/szJrloP8Yi7UluaKIUiUMjKXFzkhQW7B/Lt2y
         K+E9Ru8I8Ld/BnFKKTIReV/jNVqSmAZp2xUT3ePI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Fnj-1ikXlw2iMZ-006Ksb; Tue, 07
 Jan 2020 03:30:32 +0100
Subject: Re: [PATCH] btrfs: relocation: Fix KASAN reports caused by extended
 reloc tree lifespan
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200104135602.34601-1-wqu@suse.com>
 <20200106181525.GR3929@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <22b7f3ff-aa2d-8637-a7b3-46790067bed2@gmx.com>
Date:   Tue, 7 Jan 2020 10:30:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106181525.GR3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GHDmxUyNnyJSASwIpjp8I7rW3ASt5XZDp"
X-Provags-ID: V03:K1:im+rQutghDJjhXyfXGhhBDTAGPq95+fQaq6YhLZeGxTDJg8dHR0
 cQoHL9Ua6CblpB/ts/KnhUmWVGzlC/P+sj9CJuiQ+k8s1+ifpjfbstbowsTfOea5iQvbWeu
 FNKtkUpq+sXC22nTk//uCSzlz5GA/I4EPsszXEaSvMPyfeivQk8PzsOuVN5QkosFz7f+jyT
 r3wNB0q10J/IXNyMwP5qQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hjCv5PXI5RQ=:I7FDROi8Ayv7el8iOLJaLm
 0NdnEWi04jJuYGfrzLoPyLWX/TEeKbS/OJwUmuRjxrkTBisQ9Q/IW9Dvv5iRVdP5TSKs6spzW
 hePM+pxh/Euu1LHZA6gc2yI7H1HYjpXkeZZOy5AEJwNRWWOdjFwnuJA01sxx2NU1oeDhuz/Yp
 i3kR96nDGVrwiljhEUGIkHRLqRb+CvGFhHGDAKs/vbIKF2nONarr5+jCJOkawelzOmiczgZ/6
 UIW+IY/GeYnLCmYZdzz6ClqJE8V8tGIRUBjbnqngQuS+03r0p0M74+2vGP9sgBTTSNVj5oF9m
 74of6ewYkyw7/cGlj5AVe/3GcOm8PgVRvw0rHb4bWqkVYnR5jYHOhFvl87/zBLVKPahgnOnWQ
 GL6yEe+C+w+38kpera83POpeZAqJwjHN2E65ievXEPWTEkCVLjNA55B6CvqfvWn4++3SqDNHp
 M1pLq/3lBxRpCck9BrObKLyO47k1ZGi7ksvni5oAbks9N2pKrQmMy8hTBBGIi+VwF/zNRBN09
 SiMOQdPbJ7VeWHJAcYsFdV8XSkCahKpMDm92D7l4C0DUgUH/UGaDbA2/rtFoJG5VlKAclzM6x
 IwV0K+4r3hV3teR5bgYeEORfoej7SE8wCp91OiIAwvzIEjw+8ywMB7CEYfYg0x12IpRtJ11cs
 2eBa9MQ4V//evgyxR4vOgpB97oW2QHbevKSKxDssgMTEdimq7Fug+gFfY0p3TZTVb8U/KnJls
 xGJT6WwwpMVXKxZfcVAZJyzKEpTLilRbr4VN+CvY3qSifusGkp96nU/wNFZ6mmYaBvYRsRVnn
 86399aIxYy7wNskg1vE6/VTIe5YES4obLuwfjU7wZ3MyP6augk5RrMhJjORXZm9bxg0nicz72
 +91OJjlmISCWp9uYpvlWXzy8qbEsB/eFyk87LbKIq0PQIAcllXosAbxV4Q7LM+NUn3RwxMHsr
 BPEtWQ0r+jhb2wfaVFc3vW5li096LbcrLLWpSAg5kcOX4XLV6Jmyr6liyCGBKKjUtrGGHAiHy
 MmnOprC1cIu84BNZLtRXknXoS14oftL0YAqhxXm0tWPpKnCsbMKh3HfYTTlEEbIu55kL4mUHl
 kkz+rpWXJ2nxDzmiE/dpz4zgMyQZkzrZJ0FEu6A3wSpzMj6Ym7jHK2CoHlMmn+aGskFvIx+A+
 Cd5a2hK8sqlVi0+xdWvn5OFHuLxbhsO8JxTH1aAz+PBaWrpEHIZfYzC2DgM3cLG+b4zuxc3dt
 cKiu6c5f0FySbvBPe+QbYbzZq+noVKZsA0WdH8wGC7ior7LGK5qmflwp822k=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GHDmxUyNnyJSASwIpjp8I7rW3ASt5XZDp
Content-Type: multipart/mixed; boundary="psku7qG6byC9RKwIIQ6jgUL8mHZsnfU7O"

--psku7qG6byC9RKwIIQ6jgUL8mHZsnfU7O
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/7 =E4=B8=8A=E5=8D=882:15, David Sterba wrote:
> On Sat, Jan 04, 2020 at 09:56:02PM +0800, Qu Wenruo wrote:
>>  }
>> =20
>> +/*
>> + * Check if this subvolume tree has valid reloc(*) tree.
>> + *
>> + * *: Reloc tree after swap is considered dead, thus not considered a=
s valid.
>> + *    This is enough for most callers, as they don't distinguish dead=
 reloc
>> + *    root from no reloc root.
>> + *    But should_ignore_root() below is a special case.
>> + */
>> +static bool have_reloc_root(struct btrfs_root *root)
>> +{
>> +	smp_mb__before_atomic();
>=20
> That one should be the easiest, to get an up to date value of the bit,
> sync before reading it. Similar to smp_rmb.

Yep, if we just go plain rmb/wmb everything would be much easier to
understand.

But since full rmb/wmb is expensive and in this case we're only address
certain arches which doesn't follower Total Store Order, we still need
to use that variant.


One more question.

Why not use before_atomic() and after_atomic() to surround the
set_bit()/test_bit()?

If before and after acts as rmb/wmb, then we don't really need this
before_atomic call aroudn test_bit()

>=20
>> +	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>> +		return false;
>> +	if (!root->reloc_root)
>> +		return false;
>> +	return true;
>> +}
>> =20
>>  static int should_ignore_root(struct btrfs_root *root)
>>  {
>> @@ -525,6 +542,11 @@ static int should_ignore_root(struct btrfs_root *=
root)
>>  	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>>  		return 0;
>> =20
>> +	/* This root has been merged with its reloc tree, we can ignore it *=
/
>> +	smp_mb__before_atomic();
>=20
> This could be replaced by have_reloc_root but the reloc_root has to be
> check twice in that function. Here it was slightly optimized as it
> partially opencodes have_reloc_root. For clarity and fewer standalone
> barriers using the helper might be better.

The problem is, have_reloc_root() returns false if either:
- DEAD_RELOC_TREE is set
- no reloc_root

What we really want is, if bit set, return 1, but if no reloc root,
return 0 instead.

So we can't use that helper at all.

>=20
>> +	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>> +		return 1;
>> +
>>  	reloc_root =3D root->reloc_root;
>>  	if (!reloc_root)
>>  		return 0;
>> @@ -1439,6 +1461,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_han=
dle *trans,
>>  	 * The subvolume has reloc tree but the swap is finished, no need to=

>>  	 * create/update the dead reloc tree
>>  	 */
>> +	smp_mb__before_atomic();
>=20
> Another partial have_reloc_root, could be used here as well with
> additional reloc_tree check.

Same problem as should_ignore_root().
Or we need to do extra reloc_root out of the helper.

>=20
>>  	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>>  		return 0;
>> =20
>> @@ -1478,8 +1501,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_h=
andle *trans,
>>  	struct btrfs_root_item *root_item;
>>  	int ret;
>> =20
>> -	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state) ||
>> -	    !root->reloc_root)
>> +	if (!have_reloc_root(root))
>>  		goto out;
>> =20
>>  	reloc_root =3D root->reloc_root;
>> @@ -1489,6 +1511,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_h=
andle *trans,
>>  	if (fs_info->reloc_ctl->merge_reloc_tree &&
>>  	    btrfs_root_refs(root_item) =3D=3D 0) {
>>  		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
>=20
> First set the bit, so anybody who properly uses barriers before checkin=
g
> the bit will see it set

Still the same question, why not use before and after version around
set_bit()/clear_bit() so test_bit() doesn't need extra before_atomic call=
?
>=20
>> +		smp_mb__after_atomic();
>=20
> since the reloc_root pointer is not safe to be accessed since this poin=
t
>=20
>>  		__del_reloc_root(reloc_root);
>>  	}
>> =20
>> @@ -2202,6 +2225,7 @@ static int clean_dirty_subvols(struct reloc_cont=
rol *rc)
>>  					ret =3D ret2;
>>  			}
>>  			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
>=20
> This one looks misplaced and reverse, root->reloc_root is set to NULL a=

> few lines before and the barrier must be between this and clear_bit.

Got the point.

> This was not in my proposed version, why did you change that?

I thought the clear_bit() must be visible for all later operations, thus
the after_atomic() is needed.
But forgot the reloc_root is set to NULL.

So in that case, I guess we need both barriers.

Thanks,
Qu

>=20
>=20
>=20
>> +			smp_mb__after_atomic();
>>  			btrfs_put_fs_root(root);
>>  		} else {
>>  			/* Orphan reloc tree, just clean it up */
>> @@ -4717,7 +4741,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pendi=
ng_snapshot *pending,
>>  	struct btrfs_root *root =3D pending->root;
>>  	struct reloc_control *rc =3D root->fs_info->reloc_ctl;
>> =20
>> -	if (!root->reloc_root || !rc)
>> +	if (!rc || !have_reloc_root(root))
>>  		return;
>> =20
>>  	if (!rc->merge_reloc_tree)
>> @@ -4751,7 +4775,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans=
_handle *trans,
>>  	struct reloc_control *rc =3D root->fs_info->reloc_ctl;
>>  	int ret;
>> =20
>> -	if (!root->reloc_root || !rc)
>> +	if (!rc || !have_reloc_root(root))
>>  		return 0;
>> =20
>>  	rc =3D root->fs_info->reloc_ctl;
>> --=20
>> 2.24.1


--psku7qG6byC9RKwIIQ6jgUL8mHZsnfU7O--

--GHDmxUyNnyJSASwIpjp8I7rW3ASt5XZDp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4T7UIXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgqggf9HKP4ROr2Qj2OYuVOjt5730JE
n0BZQswEX4VnOhueW9wyHJ6ftCsQNrLEohsY0kImlysZmYvvM5rlAg17gR1jxIrw
l3aOq8IvRdFrOrycFyt5YRfTHdPFAf0Zpb4JROrVoj0j694lKRKWe2xr9KOG1SkT
nuc0o+e36wI5GjchUFfUeQylDYGUwwulKCl6E1fJcon2H4M82985N4s2qD/o3I0F
QOGU2Pb7rGu3JeGENsidb/fqmOmX5GbRyv6Uf3uIF/fEWzMj427bse7AsBjTvEBt
ZuUDaxxb4mWnfEITXhEdnwpl6WK3lzNQjZm2StYb4fwOE8TCvwDORv1g0HTdcg==
=RH6e
-----END PGP SIGNATURE-----

--GHDmxUyNnyJSASwIpjp8I7rW3ASt5XZDp--
