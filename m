Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3DBC2B11
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 01:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfI3Xp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 19:45:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:51241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfI3Xp5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 19:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569887150;
        bh=s2d+ym0H0lad0rwCIy3QK2ZgfdY62DpdW0wXxfa4mmA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=R6KC/JQraaCRG90Z2egvecdnhSGPZuBm7ZzXr/HGc/5NoTNdRY43xIQ8aI8QiV724
         seqDhhT5dBrJUDCZk8/axGflibZrOIEjZyBhH5kYK8H8+Npv9WTldK71/xGgdY8liM
         sh6Gd8AEYMHO6kL8V1jY81RnobZQbnY73p9ijQug=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N95e9-1i2f0c1mcB-0167Ch; Tue, 01
 Oct 2019 01:45:50 +0200
Subject: Re: [PATCH RFC] btrfs: relocation: Hunt down BUG_ON() in
 merge_reloc_roots()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190926063545.20403-1-wqu@suse.com>
 <20190930175159.GB2751@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <56942097-9466-e1f9-b727-7daac2fbab06@gmx.com>
Date:   Tue, 1 Oct 2019 07:45:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930175159.GB2751@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="U7UrLkqeCWZAbZHecqfe7JjoXJ0Mj5xfe"
X-Provags-ID: V03:K1:1e65pOsHrTYkk8cu8qQgVLbiCt6dLKAyW0Y0nZo8PIiD6BZhWRB
 r8CMtTbpcRXH21Acd8m/oQG63Zq2a9S+57fQi5I0bbLwVqdSj/kSqgzeKmWFrTma6zHE3cJ
 b50LvDPwlnE5YcxZ+hhZGBPQYZ128G7FuSLAKquRffxKf4sMtwUrvNI8sks0U6kJeCqbCfG
 s1XWS2hgkNY6cKYwwJuQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:b9Jx12LWROM=:S/SQsha9X/lTsQiq4Or7ax
 h5VySnu0D1eMI/PBgHELk5Vabjoe3ayphF+DAMRQDosH1SKUhxzEfuxYHUEcRrlqc5LPMnLAr
 U+oUjOoTAQ2Q0WU/oKuMkhKgrfA7Jt9TfRJsHsF23rEfNCwzXVVHKrOEKDSgOxHAVYdRPMnzL
 YDko6lXRrdHCK/kNw9mtkv/Vm38R0afQy97jCTopBl1Mh1SMOCk6c6hL3JADmt/Aae0tHrKKF
 HBMKcgm2dHKETe8c1k5cCEKXU9sTNYISbNozf8rsHTuAUPS/VGvshU+2c1/s5CJnw0S5GnjjB
 2sWkGzSZ1E9/eYfR4VPkf2XzM0R9E9fyaSrqOSJoAd+EQoH502V69SypQZwZNLMNNgyxfxTgJ
 D4BBZIHmQt7502UGgu3Z9Hz4zvhle+73I3TbRYqZ83KWlce999lyfc7k8RIV6hkgjUNvoRfrj
 +BTvGVO99pmUGr+NezYLYNFQkzr34Bwl21aDPcHMYWFx4zALk28mi2lNzv/bOM9Sbol87vm+R
 1C6CsOI/r+ETFFkd6GtqvM/hw83uQAwK0DvhevGIhqicepButTif1qtaB8LTP+34BKOXHdZGH
 FT30ZFSj5D0+aU3nI+69Mlf9hM+6Midd7RnCvqFzJTYHhks8VDTWeTkgeEkd+zfdw96vEsHub
 AVlBvF+PKOhpPhRiCogYT6eIVsVT6WXDavUeKB76JtR9SVwQREoAj1CEyNSxIPOCYc6FPBYji
 R463JPU2UMksZxzu6ut3B/533vLMIaseE+bqu3j3G5FFqQYjlItsfvTO6wVV5nd3wSzIDtNWo
 9DtYK3p4/5kmUyOGJVF/o0kSzZ+/MfsQXRJoQaapffiei/4doy3MeSvL+5ctSBAQKjWu01wdC
 HobT3S85Ozd/mPcLYEZqT6OxH337xZSW8k7va04mCdytKw4wUAp6G0AFuzA7ho3mS0BMA2MOe
 xGt92/rhcIjf5JyTrWjrtd+hUOa1MuX5EdBYv/m70Zl6sJys/r2zCFb8RHAgJafzlUKhT3Dxb
 pcGdVns/gfDsvks8opvrWav92IYPhWi+KqSpOXLtA80EVX9jjd+LQ3LJPOFeBHtlChJLXh9SK
 XRAtWPp6/IfqXM6nKuMR0rLbPRJomc/HYQ9DFtCpeCbO4gd5xxWFwQvRuRipDSLx3INELFZyk
 wn8E1cxSVk8DADEuzGQATfR+cF1NLFF0Z74lNo3vFr9kt8csRBNiii4Mm2y/4h1yqvWSoqGMh
 gZx6cB8z8d3tdpr/r6Q+6FINVcR8hPi/dM2WAPrKgTYFq13AiSprEWUMHguU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U7UrLkqeCWZAbZHecqfe7JjoXJ0Mj5xfe
Content-Type: multipart/mixed; boundary="ObiKS878RIamc9TuROGavGDihucpOxt17"

--ObiKS878RIamc9TuROGavGDihucpOxt17
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/1 =E4=B8=8A=E5=8D=881:51, David Sterba wrote:
> On Thu, Sep 26, 2019 at 02:35:45PM +0800, Qu Wenruo wrote:
>> [BUG]
>> There is one BUG_ON() report where a transaction is aborted during
>> balance, then kernel BUG_ON() in merge_reloc_roots():
>=20
> Do you have details from the report, eg. what's the error code?

Nope, what I get is only kernel message.

Not enough to get the error code.

>=20
>>   void merge_reloc_roots(struct reloc_control *rc)
>>   {
>> 	...
>> 	BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root)); <<<
>>   }
>>
>> [CAUSE]
>> It's still uncertain why we can get to such situation.
>> As all __add_reloc_root() calls will also link that reloc root to
>> rc->reloc_roots, and in merge_reloc_roots() we cleanup rc->reloc_roots=
=2E
>>
>> So the root cause is still uncertain.
>>
>> [FIX]
>> But we can still hunt down all the BUG_ON() in merge_reloc_roots().
>>
>> There are 3 BUG_ON()s in it:
>> - BUG_ON() for read_fs_root() result
>> - BUG_ON() for root->reloc_root !=3D reloc_root case
>> - BUG_ON() for the non-empty reloc_root_tree
>=20
> relocation.c is worst regarding number of BUG_ONs, some of them look
> like runtime assertions of the invariants but some of them are
> substituting for error handling.

Yeah, if we inject kmalloc error into btrfs_relocate_block_group(), it's
too easy to hit BUG_ON().

>=20
> The first one BUG_ON(IS_ERR(root)); is clearly the latter, the other ar=
e
> assertions
>=20
>>
>> For the first two, just grab the return value and goto out tag for
>> cleanup.
>>
>> For the last one, make it more graceful by:
>> - grab the lock before doing read/write
>> - warn instead of panic
>> - cleanup the nodes in rc->reloc_root_tree
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>> The root cause to leak nodes in reloc_root_tree is still unknown.
>> ---
>>  fs/btrfs/relocation.c | 39 ++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 36 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 655f1d5a8c27..d562b5c52a40 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -2484,11 +2484,26 @@ void merge_reloc_roots(struct reloc_control *r=
c)
>>  		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
>>  			root =3D read_fs_root(fs_info,
>>  					    reloc_root->root_key.offset);
>> -			BUG_ON(IS_ERR(root));
>> -			BUG_ON(root->reloc_root !=3D reloc_root);
>> +			if (IS_ERR(root)) {
>=20
> This is bug_on -> error handling, ok
>=20
>> +				ret =3D PTR_ERR(root);
>> +				btrfs_err(fs_info,
>> +					  "failed to read root %llu: %d",
>> +					  reloc_root->root_key.offset, ret);
>> +				goto out;
>> +			}
>> +			if (root->reloc_root !=3D reloc_root) {
>=20
> With this one I'm not sure it could happen but replacing the bug on is
> still good.
>=20
>> +				btrfs_err(fs_info,
>> +					"reloc root mismatch for root %llu",
>=20
> Would be good to print the number of the other root as well.
>=20
>> +					root->root_key.objectid);
>> +				ret =3D -EINVAL;
>> +				goto out;
>> +			}
>> =20
>>  			ret =3D merge_reloc_root(rc, root);
>>  			if (ret) {
>> +				btrfs_err(fs_info,
>> +			"failed to merge reloc tree for root %llu: %d",
>> +					  root->root_key.objectid, ret);
>>  				if (list_empty(&reloc_root->root_list))
>>  					list_add_tail(&reloc_root->root_list,
>>  						      &reloc_roots);
>> @@ -2520,7 +2535,25 @@ void merge_reloc_roots(struct reloc_control *rc=
)
>>  			free_reloc_roots(&reloc_roots);
>>  	}
>> =20
>> -	BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root));
>=20
> This one looks more like the invariant, the tree should be really empty=

> here. While the cleanup is trying to make things work despite there's a=

> problem, I think the warning should not be debugging only.

Indeed, we should output the warning no matter whatever.

Thanks,
Qu
>=20
>> +	spin_lock(&rc->reloc_root_tree.lock);
>> +	/* Cleanup dirty reloc tree nodes */
>> +	if (!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root)) {
>> +		struct mapping_node *node;
>> +		struct mapping_node *next;
>> +
>> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>=20
> ...
>=20


--ObiKS878RIamc9TuROGavGDihucpOxt17--

--U7UrLkqeCWZAbZHecqfe7JjoXJ0Mj5xfe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2Sk6gACgkQwj2R86El
/qihmQf/W6oxML3IgCxOwB0mBaFwEKAW1ssi1ywbKvyNs+k0Yh1kbBDJjljynmEr
9ChmcoNtyMU3JQqCcdd1Y4zgWN51Q0MRuMkgnRkJHGFapXAzsDygrm8LPLmuAtJv
z+Z7KThiWjPOi251eFCd6oi8Pt+ufCvaUcZXqElAR0lK7bFJi0IHyS//rirmbrtr
6X62uMoRXBRAveLFT01pJ0iOfYp/sBLJ+SiH5W+l9GgN4U9DCIWRPI1snDtgEtoo
I89B2Zm/r+zlMpSZDKz2gLVFi/7+5pRHVyNhLg7ptNhFBJUOKP5UxV4fqypnhurk
Z4FgLPouLNV+6AtvHoVdcSu3L5RcKA==
=8HgL
-----END PGP SIGNATURE-----

--U7UrLkqeCWZAbZHecqfe7JjoXJ0Mj5xfe--
