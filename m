Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9621513027E
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2020 14:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgADNSx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 08:18:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:33907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgADNSx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Jan 2020 08:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578143930;
        bh=zdjNhXv+hKCXJDUsNBKVpBCvIrXIvz+INZpGxoDaD+g=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ONHUB8hlyAHHImUwoxuQAQblM/ktTkXPgRhV71p28z2N8vdbQVcDhF8HEeLKzwV2w
         ymiDjHrbnOdnnndXR8LpZIVojkO3xDWLWSCXqreTUk3jZ7RnjF1eA851eF5NgnfSWH
         PdrByZRrJm3Vk+HyzSaF/3W3vZx88ODodhU4D8HE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6llE-1inB5j0vDK-008NmS; Sat, 04
 Jan 2020 14:18:50 +0100
Subject: Re: [PATCH 0/3] btrfs: fixes for relocation to avoid KASAN reports
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <20191211050004.18414-1-wqu@suse.com>
 <20191211153429.GO3929@twin.jikos.cz>
 <74a07fa4-ca35-57ee-2cd9-586a8db04712@gmx.com>
 <20200103155259.GA3929@twin.jikos.cz> <20200103161556.GB3929@twin.jikos.cz>
 <9cc840ed-d23c-4760-9a2a-da5e3e0deced@gmx.com>
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
Message-ID: <22ef179a-d6e6-70da-c474-630c8e59f589@gmx.com>
Date:   Sat, 4 Jan 2020 21:18:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <9cc840ed-d23c-4760-9a2a-da5e3e0deced@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tDHw3nd7fulNUhDkYYrSDfzQTsvHKkcXy"
X-Provags-ID: V03:K1:silr1ZyWi6T2fAlZ3vaEydxKsCIF27rwTW63+DUxdGi1PyEcozR
 V+wid0TfsRtMhEwfSky5uqmBjxeprUZb9Stfu8CJBtmr/FzaoDimnxIBUC+OXrPk2P82a9E
 Xe6FSrtLWtBuxibPOby8Vsg3tEpWeWGTzX3zGDEJz7PqA1RQGDK0T6GhDksvvqYGN6NX8JB
 91nQeOO4APGyKzFGENqKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1y/uiXUpOK0=:a2mwKdtKtVWjdJec7BaP0o
 gZ4ALHDCXCG7rc6Wp2UdIjhRQAG+HNUvu0oayvHupiMjGoahEJ5So86TCRn3WrPt7ZD6sWMF9
 fVh3AmKe+IsFgpo1s5DNXhCxYsreJwOlJaj+ldWYMAvBpSA73PHsOH0GrFbhcqiIN52adulIO
 moRpryR9iTIC6aJfgPWPVBCQRzF9gIvNHhnj0nEzadu8BLDmvc7VF+iuM8Oh1d0T44/HQgJ/d
 tuc6I6+lQ4jSViec2FoCR+8hpraEglmUhdWk6H09U4sugcz+BN4EykAzpZhZ/55g0g+MT+FzR
 MRVEsckLBMz8F+XswIzmvYQzIh0GgUAjXSwHysG5J9o2E+K6SB8TBGhJ1aeKcwoB2l2OQhYms
 7NAgazdmgO4jO6tFgmaIVTfVx5L7whric2K7gU9WcsqHCk62P9i9K2ImMEvCf9Q12IAYNU4yR
 MVJcjmAqnvz2PIbc5SWd9E9JKV6WMjjIvCl7sxKdMfL5ZH7l0KHs7LGFccrJNz9mWrVs55iAH
 mN47bn6GwDztNUwk7+EIBnPVyXlKOVQU57/CKce3eMa1liTyncMCXcBb8U6m1hVjYDCcyBgEo
 7snvZGM5zzQSQFQu2E1kmZc0crEMOJmaM4EFp04JHA+znMZEaheBeFQGB/RakM0GGIFCfYkmL
 UaEc0uJRqvfHNCwDmoBPVqtjwvQ4m4iXEsecyghp7Tek7iKNPJz0Wp4ap29OLtZ+Cw6AGo7+0
 IqVFXSlFDoRxaCv/64jPEPTm1a+rBSp7IPIgs83GeyYdbr0FaiY02iwfBxx5PDRYmWCH9sH2v
 PbhJBj4CzC0aU6oyRDJzANF71JHh/+Wo589qXkvGNlBheyJRBrKlHFUQOUfqZ4vVwoNBb1TYd
 o1v6qyB8UhMKYEjtDJ/jay7y8fiwuNQ0oipbRGAZtFqze4yLmUdLkEewtO/Jxh2mKo091Rv+q
 exv5P3+9KyOMm36PNYpwpT5+ptWkZJO2LHWdYHW22RILmsCkhSJfp6Q/HyMwjpqnprxyTIH+m
 ciXPRrfj7OBhztukAYdJbiV8+EVBga0pU5pZmTCTr6u/bYhTJjgCp02BcoHgSB7O7AmPItOQh
 QOI3iS2NcozPr0q4A1kAPzGv66/FzHYRVbQx7hOfNP4N8NaWK/R38S/43jz4yRmoIH1a5DxQo
 iBXGVSgcK6IB504CFpDto90Sjsf1Oa1Qd5H8dzL4ytI9H7GMKIhpWbFY+/KaVdP/T2IEyPcxF
 SB3ao1p4I6jBXnC3Bul2BeDxuDcnVJMU5dreOnIxBysVKfumb+ksQ4qa3B8w=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tDHw3nd7fulNUhDkYYrSDfzQTsvHKkcXy
Content-Type: multipart/mixed; boundary="95yZYjmz5pM356zokkgUi75iytD3rO9ER"

--95yZYjmz5pM356zokkgUi75iytD3rO9ER
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/4 =E4=B8=8B=E5=8D=885:37, Qu Wenruo wrote:
>=20
>=20
> On 2020/1/4 =E4=B8=8A=E5=8D=8812:15, David Sterba wrote:
>> On Fri, Jan 03, 2020 at 04:52:59PM +0100, David Sterba wrote:
>>> So it's one bit vs refcount and a lock. For the backports I'd go with=

>>> the bit, but this needs the barriers as mentioned in my previous repl=
y.
>>> Can you please update the patches?
>>
>> The idea is in the diff below (compile tested only). I found one more
>> case that was not addressed by your patches, it's in
>> btrfs_update_reloc_root.
>=20
> But fix in btrfs_update_reloc_root() is already included in commit
> d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after
> merge_reloc_roots").
>=20
> Or would you mind to share more details about the missing check?
>>
>> Given that the type of the fix is the same, I'd rather do that in one
>> patch. The reported stack traces are more or less the same.
>=20
> To merge them into patch set is no problem, and should make backports a=

> little easier.
>=20
> But I still didn't understand the barrier part.
> If we're relying on that bit operation before accessing reloc_root, it
> should be safe enough, even without memory barrier.

My bad, set_bit() and test_bit() themselves doesn't imply memory
barrier. (I always thought the opposite)

I'll put memory barriers in next version.

Thanks,
Qu

>=20
> Would you please explain a little more?
>=20
> Thanks,
> Qu
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index af4dd49a71c7..aeba3a7506e1 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -517,6 +517,15 @@ static int update_backref_cache(struct btrfs_tran=
s_handle *trans,
>>  	return 1;
>>  }
>> =20
>> +static bool have_reloc_root(struct btrfs_root *root)
>> +{
>> +	smp_mb__before_atomic();
>> +	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>> +		return false;
>> +	if (!root->reloc_root)
>> +		return false;
>> +	return true;
>> +}
>> =20
>>  static int should_ignore_root(struct btrfs_root *root)
>>  {
>> @@ -525,9 +534,9 @@ static int should_ignore_root(struct btrfs_root *r=
oot)
>>  	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>>  		return 0;
>> =20
>> -	reloc_root =3D root->reloc_root;
>> -	if (!reloc_root)
>> +	if (!have_reloc_root(root))
>>  		return 0;
>> +	reloc_root =3D root->reloc_root;
>> =20
>>  	if (btrfs_root_last_snapshot(&reloc_root->root_item) =3D=3D
>>  	    root->fs_info->running_transaction->transid - 1)
>> @@ -1439,6 +1448,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_han=
dle *trans,
>>  	 * The subvolume has reloc tree but the swap is finished, no need to=

>>  	 * create/update the dead reloc tree
>>  	 */
>> +	smp_mb__before_atomic();
>>  	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>>  		return 0;
>> =20
>> @@ -1478,8 +1488,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_h=
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
>> @@ -1489,6 +1498,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_h=
andle *trans,
>>  	if (fs_info->reloc_ctl->merge_reloc_tree &&
>>  	    btrfs_root_refs(root_item) =3D=3D 0) {
>>  		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
>> +		smp_mb__after_atomic();
>>  		__del_reloc_root(reloc_root);
>>  	}
>> =20
>> @@ -2201,6 +2211,7 @@ static int clean_dirty_subvols(struct reloc_cont=
rol *rc)
>>  				if (ret2 < 0 && !ret)
>>  					ret =3D ret2;
>>  			}
>> +			smp_mb__before_atomic();
>>  			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
>>  			btrfs_put_fs_root(root);
>>  		} else {
>> @@ -4730,7 +4741,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pendi=
ng_snapshot *pending,
>>  	struct btrfs_root *root =3D pending->root;
>>  	struct reloc_control *rc =3D root->fs_info->reloc_ctl;
>> =20
>> -	if (!root->reloc_root || !rc)
>> +	if (!rc || !have_reloc_root(root))
>>  		return;
>> =20
>>  	if (!rc->merge_reloc_tree)
>> @@ -4764,7 +4775,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans=
_handle *trans,
>>  	struct reloc_control *rc =3D root->fs_info->reloc_ctl;
>>  	int ret;
>> =20
>> -	if (!root->reloc_root || !rc)
>> +	if (!rc || !have_reloc_root(root))
>>  		return 0;
>> =20
>>  	rc =3D root->fs_info->reloc_ctl;
>>
>=20


--95yZYjmz5pM356zokkgUi75iytD3rO9ER--

--tDHw3nd7fulNUhDkYYrSDfzQTsvHKkcXy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4QkLYACgkQwj2R86El
/qjjlgf+LaBLCKFOmOZ+98ZE1kAVJt+sv6J327J0HwbSoWu2VcN0gPGKiogoBjUL
W9PE5HMhxZqyJj28125kPolRql/gnKH0rK+3eyer2s8SknaEKWIgWccJrgk+6Nev
kgd+HpZOBfvrc7PwsiZ57f3da0rrRJG7o1r8BpKa37UC7haYSDfSgUh+yGbVfDKB
JoOzEYf/9K4cMwfQrl4y9ChnQJ5HwuhyUVdvXWuGms7IhLi3TjqQsjnY52jCtbVq
nl+HUIPuc7adCaNtPriCyaKuIuMtcgIQCDOS0Xid3B0Y6ygdAH+Hp3x66uGqkUfu
/SnYmHUokXnVTVZBZ1gqSX9o9MPpCw==
=IiE8
-----END PGP SIGNATURE-----

--tDHw3nd7fulNUhDkYYrSDfzQTsvHKkcXy--
