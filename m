Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27EB131DB1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 03:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgAGCgO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 21:36:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:40861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbgAGCgN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 21:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578364560;
        bh=GgwYfw5hR7x73r8eZg+gFkiHghJeW+YlWaXhEvWZz1w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Mg27cV/zUsX4cu6tO5kXMjCfFeHg6JrqO0058Sqzf+prkWMdo5RSp+3PBo9pdvWXo
         dCRtWbQSy7CrtI/kCSYCIx0mLNOXzxKSeojyoktMJDVuQU5/zEhRYINNF7QVIlosr1
         vBoV7GXrSFbyDhuBkmwidK8CzGYbB3XeOweMG8MY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQj7-1iw3Fq0eVR-00Gr9L; Tue, 07
 Jan 2020 03:36:00 +0100
Subject: Re: [PATCH] btrfs: relocation: Fix KASAN reports caused by extended
 reloc tree lifespan
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200104135602.34601-1-wqu@suse.com>
 <20200106181525.GR3929@twin.jikos.cz>
 <22b7f3ff-aa2d-8637-a7b3-46790067bed2@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <57964ffa-1c95-a8ba-9bfe-26f8e065f4f2@gmx.com>
Date:   Tue, 7 Jan 2020 10:35:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <22b7f3ff-aa2d-8637-a7b3-46790067bed2@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1LjPrNXAcqpw3ETj0wY91XKCRD89T99IC"
X-Provags-ID: V03:K1:rvV3YHtzVVlLKhLUfDTb9TvgBueQN7yqPFadNnKJIuJJlCsR1m3
 0pG8/379xN9rB0WSD0X41U1bEs1LxxL010YAhetuJphcC1LKlAGz8mXDi7cbm8ha9UOEfTp
 smemvw0dOPp5R7Qp7cWs8yOgNyKbnDqwV/bFWVlqgC863Ged3icBbk2vw7isD5mBCCB9gEB
 dUgz4kmfjSLuegEcx0mvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:It20KqQmpfI=:7yzmfZw8ZTctd1hpOiXw2c
 Kc9hTLMmCWGQLW1tlQuPcPS7Ti+qwhgURoXXLnMVLwn2eikUBQYDPbDreTwkhz+4P0uKtPEnf
 //HPeKuktXC2QKyrpFI+nVYaZ5xI+XCY+zPfTHXPQG+1lR73d671wuEsjHJb79QMMmYm5MUkJ
 biACcDkXsOa5SxU4eQOliLMWvmgbkjS0siE/d1QbFG4WCrGnzFmqzfOoVgoFKzZtdDhh9icLQ
 itn8B7+dhD3jZNhU4zkPgRCNyp+9jqNYOXJXWs6nU84mrLQMU5hGIfaW9sWWY8AZBg0kV1+MU
 HQAEJJQF5Ewgz8/zVyMpr1ZiscY4WgMhe9kLeAdhtF0XmlEiVgsTyEHVrtBXL+A6cbZeLHIDb
 u7BS5T0ns7T5RhlDeDYBYfiMcHzbFdnbSp7S3zPB/eJkJsQnTGx1nMUMjd26iqVPciQ4USTXp
 j+3CM4DHn1pLWwVMmHuxre2abL6TRHFg6U1mjjfJU4nWjoIx7ydc4QbwNdZayG6B9Z902PiYo
 pLe/HRnH8IziqVrYuH5pfr1qDgolcVy94F8yrXp6vlmqPl0J7dQZ1CKpUBCntalfi8FO21/mM
 FUD7MyR1SMp+0XQjgBk569u1ICeI+HZ/x6DKCiKYvhVS6cnitfKJpg6VA6q/pweHjMpl95ug4
 T46ZW+Ec6mtnzjTJT9GXdYNDMglIUEnoGNp2lFKXbZvfbch7zsUNbIgM7sNtXVcF6D+5Hax6f
 uoj66mJyWXpRQ05aA2oiHwuRjSYSZcOgNAeIICaI0A4OJtdd3SZMzanFLXAGLsaavhk4ip7rc
 +FcI1m3kRwLva4w40pTuVHoEw7ktkGqJH1zkHV5yE62L/MmfttkgpblBAMG5H0NNhXMt+ujdU
 KsRiefj2MHAHGru2u0TfPU/bdA8NLZRNu4ehvVJezHChY1K9kGVKV9WpF8+QI+FpDlyhEg4YS
 beAzefSzIn0A5vvYgwvVxTn5OgwE66Cdo/BYEnGM4LNMrOBqiFacZrBfWSnbcl/Ijm0tm57BC
 9AswX0t/1MaIH/M+sj4ouNcBem2fXUCo6BPlIBs6RYdubUj9iMBVCaZfUfTO4q9h/BsPsQVI9
 PdoH8LhUQG8FvQEV5fgrZnMxGE9lSX53Uys1dfvLcHacWmphnJH9p05Azt6TojIZiGTVWZP8v
 2kzZt0ekw6KH0ClBlgIJ2jnYoOti+GnJnaE9AZ0UmUAwQorJJC1oIFMlpodFaqImHlcgtllIV
 V2e3mQmL8+we2J7xbxwiJ1JxCjFguXC97JjvttOSG2MfqS6ZF35CUbQKLzWU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1LjPrNXAcqpw3ETj0wY91XKCRD89T99IC
Content-Type: multipart/mixed; boundary="nbELPI9GM72UQSY7g4xViDGjgi03eDJ0J"

--nbELPI9GM72UQSY7g4xViDGjgi03eDJ0J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/7 =E4=B8=8A=E5=8D=8810:30, Qu Wenruo wrote:
>=20
>=20
> On 2020/1/7 =E4=B8=8A=E5=8D=882:15, David Sterba wrote:
>> On Sat, Jan 04, 2020 at 09:56:02PM +0800, Qu Wenruo wrote:
>>>  }
>>> =20
>>> +/*
>>> + * Check if this subvolume tree has valid reloc(*) tree.
>>> + *
>>> + * *: Reloc tree after swap is considered dead, thus not considered =
as valid.
>>> + *    This is enough for most callers, as they don't distinguish dea=
d reloc
>>> + *    root from no reloc root.
>>> + *    But should_ignore_root() below is a special case.
>>> + */
>>> +static bool have_reloc_root(struct btrfs_root *root)
>>> +{
>>> +	smp_mb__before_atomic();
>>
>> That one should be the easiest, to get an up to date value of the bit,=

>> sync before reading it. Similar to smp_rmb.
>=20
> Yep, if we just go plain rmb/wmb everything would be much easier to
> understand.
>=20
> But since full rmb/wmb is expensive and in this case we're only address=

> certain arches which doesn't follower Total Store Order, we still need
> to use that variant.
>=20
>=20
> One more question.
>=20
> Why not use before_atomic() and after_atomic() to surround the
> set_bit()/test_bit()?

Typo, it's set_bit()/clear_bit().

>=20
> If before and after acts as rmb/wmb, then we don't really need this
> before_atomic call aroudn test_bit()
>=20
>>
>>> +	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>>> +		return false;
>>> +	if (!root->reloc_root)
>>> +		return false;
>>> +	return true;
>>> +}
>>> =20
>>>  static int should_ignore_root(struct btrfs_root *root)
>>>  {
>>> @@ -525,6 +542,11 @@ static int should_ignore_root(struct btrfs_root =
*root)
>>>  	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>>>  		return 0;
>>> =20
>>> +	/* This root has been merged with its reloc tree, we can ignore it =
*/
>>> +	smp_mb__before_atomic();
>>
>> This could be replaced by have_reloc_root but the reloc_root has to be=

>> check twice in that function. Here it was slightly optimized as it
>> partially opencodes have_reloc_root. For clarity and fewer standalone
>> barriers using the helper might be better.
>=20
> The problem is, have_reloc_root() returns false if either:
> - DEAD_RELOC_TREE is set
> - no reloc_root
>=20
> What we really want is, if bit set, return 1, but if no reloc root,
> return 0 instead.
>=20
> So we can't use that helper at all.
>=20
>>
>>> +	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>>> +		return 1;
>>> +
>>>  	reloc_root =3D root->reloc_root;
>>>  	if (!reloc_root)
>>>  		return 0;
>>> @@ -1439,6 +1461,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_ha=
ndle *trans,
>>>  	 * The subvolume has reloc tree but the swap is finished, no need t=
o
>>>  	 * create/update the dead reloc tree
>>>  	 */
>>> +	smp_mb__before_atomic();
>>
>> Another partial have_reloc_root, could be used here as well with
>> additional reloc_tree check.
>=20
> Same problem as should_ignore_root().
> Or we need to do extra reloc_root out of the helper.
>=20
>>
>>>  	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>>>  		return 0;
>>> =20
>>> @@ -1478,8 +1501,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_=
handle *trans,
>>>  	struct btrfs_root_item *root_item;
>>>  	int ret;
>>> =20
>>> -	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state) ||
>>> -	    !root->reloc_root)
>>> +	if (!have_reloc_root(root))
>>>  		goto out;
>>> =20
>>>  	reloc_root =3D root->reloc_root;
>>> @@ -1489,6 +1511,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_=
handle *trans,
>>>  	if (fs_info->reloc_ctl->merge_reloc_tree &&
>>>  	    btrfs_root_refs(root_item) =3D=3D 0) {
>>>  		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
>>
>> First set the bit, so anybody who properly uses barriers before checki=
ng
>> the bit will see it set
>=20
> Still the same question, why not use before and after version around
> set_bit()/clear_bit() so test_bit() doesn't need extra before_atomic ca=
ll?
>>
>>> +		smp_mb__after_atomic();
>>
>> since the reloc_root pointer is not safe to be accessed since this poi=
nt
>>
>>>  		__del_reloc_root(reloc_root);
>>>  	}
>>> =20
>>> @@ -2202,6 +2225,7 @@ static int clean_dirty_subvols(struct reloc_con=
trol *rc)
>>>  					ret =3D ret2;
>>>  			}
>>>  			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
>>
>> This one looks misplaced and reverse, root->reloc_root is set to NULL =
a
>> few lines before and the barrier must be between this and clear_bit.
>=20
> Got the point.
>=20
>> This was not in my proposed version, why did you change that?
>=20
> I thought the clear_bit() must be visible for all later operations, thu=
s
> the after_atomic() is needed.
> But forgot the reloc_root is set to NULL.
>=20
> So in that case, I guess we need both barriers.
>=20
> Thanks,
> Qu
>=20
>>
>>
>>
>>> +			smp_mb__after_atomic();
>>>  			btrfs_put_fs_root(root);
>>>  		} else {
>>>  			/* Orphan reloc tree, just clean it up */
>>> @@ -4717,7 +4741,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pend=
ing_snapshot *pending,
>>>  	struct btrfs_root *root =3D pending->root;
>>>  	struct reloc_control *rc =3D root->fs_info->reloc_ctl;
>>> =20
>>> -	if (!root->reloc_root || !rc)
>>> +	if (!rc || !have_reloc_root(root))
>>>  		return;
>>> =20
>>>  	if (!rc->merge_reloc_tree)
>>> @@ -4751,7 +4775,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_tran=
s_handle *trans,
>>>  	struct reloc_control *rc =3D root->fs_info->reloc_ctl;
>>>  	int ret;
>>> =20
>>> -	if (!root->reloc_root || !rc)
>>> +	if (!rc || !have_reloc_root(root))
>>>  		return 0;
>>> =20
>>>  	rc =3D root->fs_info->reloc_ctl;
>>> --=20
>>> 2.24.1
>=20


--nbELPI9GM72UQSY7g4xViDGjgi03eDJ0J--

--1LjPrNXAcqpw3ETj0wY91XKCRD89T99IC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4T7ogXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhfggf+MkaWOzUhtelkImV0+IG5gQxN
ND/unPYyEJ6z7WwFl6MJpXeG+CeuZqZ4mthc7VpuWxIfLEurXnEEIzQQzcoh72Y+
i0gRy8EfBuv5o2mcd9imbP27PMD/ime/sPDzYsShOyHuHCjcsv0cv5Lh0e/Jqqpg
tHfUuduvvYxi3XY5bbGHDmZop/MSUlAnY5MwgjDM4p+zdU8t0g2br5wbgJB9eJ3H
s7BDS9xTMddzMFT3JlD5DvQP+cCsFGlL0rA/QnppUbiVSC09/kwGfZRMbUXUhV8N
bf+ySOKMRVbEEu9L/ECZmwHljGWP8EMOh2dgn7RAi1F8DeUprufA1fIPXkSgDA==
=txvn
-----END PGP SIGNATURE-----

--1LjPrNXAcqpw3ETj0wY91XKCRD89T99IC--
