Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D51368BD
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 02:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFFA3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 20:29:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:53237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfFFA3j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 20:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559780970;
        bh=q0Lm7hjSfnOtPr3zCr6e4qa0jcOmzcjsADDV2viCX9M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VcKxX+sIU1i2R5IEyNSlGnYPGhozLUst1e9XE1SnlgkeUw0ir5ivYSjdWB8KcnUv5
         2bCMumlHA1La10x2NTk6DSjYPs6HjhtI2GMHJTrYEf9Aj/ywQtlbABSfcfX8OL3c+q
         G9VqZcmeCMlKQuEs8bBoZK6JLIB0lp2+xLaiyK7M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LbPza-1gpCB03THm-00kyad; Thu, 06
 Jun 2019 02:29:29 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: Avoid nested chunk allocation call
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190416102144.12173-1-wqu@suse.com>
 <20190416102144.12173-2-wqu@suse.com> <20190605163200.GF9896@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <6b33483e-5330-9230-d109-bdec56924615@gmx.com>
Date:   Thu, 6 Jun 2019 08:29:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605163200.GF9896@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GFvxnDYuZkCKfK59jDmlY6M2JX3GCsHOv"
X-Provags-ID: V03:K1:5CAIlNJALTpe0sfS1f/0X5NuvOX4w+swMxEB2V+AV2vaL0dvGbp
 HjuKte5sQ9RwNQAAWNozzgeOL/NKTC2wDfelTD1i3F0lnbEqQ2GEQlDNTKXQtz6Ox+2pXDN
 PnFwF8Ia5hBI/nW5c2WmPiPpeIvZQk+1X1/9FmuZeaKrOmxdlqAyQkePEhieef1AG73977/
 AXsFNEVZBKp8VhEourbWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Ot5aNSUivQ=:DVFb7DnegifnbBzvLvxsdg
 8eZFkmP356bfwtvUEZROPwErh33nRzU1orbZgp9/Ti3Iqgaxmmb4/YU8isAms2XEHnNtUyR9q
 f+SyKMJSZbSRnfFXR5PCnnn5VbDEFESJMyZizAVmqS/1Kba2Lc/Vm6Hw/9fwILUepAbB/JqfA
 C4JKZCJD9FpDlfChDPkF6I3jLeAJbIWYSsAHpetF/V/A6lWahepZENCItAToPVh/WKOFEiDvB
 M2KJ6sY1gOHVcQh2qfY5whqYEnmBc2+O2uJ0L6IbvRDICC8/VW9pOSfrKd0bXilu1K4FDdFlE
 z5DIfZ8acbxKrzPiqxwJNRH6iq0seBl1UPFsNzyQfpiVCnPfxIAV+DAo1RyDHhCSIkr/qWmNu
 qK5eE2Mo43sP8L9a7yutOemHTekrSzj7Ji5PxJxcZ+FxGJW42G4r3g4vRN7dgzd6XOwH79FLF
 duYItPGsOxflMnqIi2IDtqmHSl1UuMnBbzbNpd+cyCiZxecSNY8Q9/AXktO5i155sVy0HnQjd
 wTm3VnzgsmRiiR2MsBmCD4qmRHCn6XP4iXyYR7jxKRDlnG3gma+VJi4+ePEUhvTaVSL9FEs4K
 MWU/iVVlOy0ER50k3Vy1P9synA6XZSyLy3nT3GFlHGtoZchh52wtpQ1JmUIJ4MyC8Tw6u1tBc
 HOzG0b3sGeQe4EZjryibufRqaGK6IaUdpRLQYlNUhbrdkOQz7Gk/sxjzIVcRhZcfg/FawizJu
 4n8Q2BUtylfz6f0j1PScHEwcAmezfRWTloDO5nbWWONKeqkxf8K6u3//Uc7+mWruEk+SZhVa/
 WAX/p5+CueXZJTvn2CuMYS8KgyMQOPOD0q5snaiVrjF52SEgXj0Wg6yGq21ZdPpqjRE07xYDX
 sdFH/HGGtX5/9fB+Zqt4FDWKkPmecHregB5cZzXKR0tjB2w61rqCe0DkOz3Ovnl+2aU9DGqa7
 eD0NuOflZGs+iU7vPy35kxGHLRC1UsYU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GFvxnDYuZkCKfK59jDmlY6M2JX3GCsHOv
Content-Type: multipart/mixed; boundary="UN93LpTO6D52CPncqKIjcgg4DFEkPC73n";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <6b33483e-5330-9230-d109-bdec56924615@gmx.com>
Subject: Re: [PATCH 1/2] btrfs-progs: Avoid nested chunk allocation call
References: <20190416102144.12173-1-wqu@suse.com>
 <20190416102144.12173-2-wqu@suse.com> <20190605163200.GF9896@twin.jikos.cz>
In-Reply-To: <20190605163200.GF9896@twin.jikos.cz>

--UN93LpTO6D52CPncqKIjcgg4DFEkPC73n
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/6 =E4=B8=8A=E5=8D=8812:32, David Sterba wrote:
> On Tue, Apr 16, 2019 at 06:21:43PM +0800, Qu Wenruo wrote:
>> There is a hidden call loop which can trigger itself:
>>
>> btrfs_reserve_extent()             <--|
>> |- do_chunk_alloc()                   |
>>    |- btrfs_alloc_chunk()             |
>>       |- btrfs_insert_item()          |
>> 	 |- btrfs_reserve_extent() <--|
>>
>> Currently, we're using root->ref_cows to determine whether we should d=
o
>> chunk prealloc to avoid such loop.
>>
>> But that's still a hidden trap. Instead of solving it using some hidde=
n
>> tricks, this patch will make chunk/block group allocation exclusive.
>>
>> Now if do_chunk_alloc() determines to alloc chunk, it will set a speci=
al
>> flag in transaction handler so it new do_chunk_alloc() will refuse to
>> allocate new chunk until current chunk allocation finishes.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  check/main.c  |  2 +-
>>  extent-tree.c | 12 ++++++++++++
>>  transaction.c |  3 ++-
>>  transaction.h |  3 ++-
>>  4 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/check/main.c b/check/main.c
>> index 683c322eba6f..121be4b73c4f 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -10185,7 +10185,7 @@ int cmd_check(int argc, char **argv)
>>  			goto close_out;
>>  		}
>> =20
>> -		trans->reinit_extent_tree =3D true;
>> +		trans->reinit_extent_tree =3D 1;
>>  		if (init_extent_tree) {
>>  			printf("Creating a new extent tree\n");
>>  			ret =3D reinit_extent_tree(trans, info,
>> diff --git a/extent-tree.c b/extent-tree.c
>> index 8c9cdeff3b02..e25ddf02e5cc 100644
>> --- a/extent-tree.c
>> +++ b/extent-tree.c
>> @@ -1873,10 +1873,21 @@ static int do_chunk_alloc(struct btrfs_trans_h=
andle *trans,
>>  	    (flags & BTRFS_BLOCK_GROUP_SYSTEM))
>>  		return 0;
>> =20
>> +	/*
>> +	 * We're going to allocate new chunk, during the process, we will
>> +	 * allocate new tree blocks, which can trigger new chunk allocation
>> +	 * again.
>> +	 * Avoid such loop call
>> +	 */
>> +	if (trans->allocating_chunk)
>> +		return 0;
>> +	trans->allocating_chunk =3D 1;
>> +
>>  	ret =3D btrfs_alloc_chunk(trans, fs_info, &start, &num_bytes,
>>  	                        space_info->flags);
>>  	if (ret =3D=3D -ENOSPC) {
>>  		space_info->full =3D 1;
>> +		trans->allocating_chunk =3D 0;
>>  		return 0;
>>  	}
>> =20
>> @@ -1885,6 +1896,7 @@ static int do_chunk_alloc(struct btrfs_trans_han=
dle *trans,
>>  	ret =3D btrfs_make_block_group(trans, fs_info, 0, space_info->flags,=

>>  				     start, num_bytes);
>>  	BUG_ON(ret);
>> +	trans->allocating_chunk =3D 0;
>>  	return 0;
>>  }
>> =20
>> diff --git a/transaction.c b/transaction.c
>> index 3a63988b0969..21377282f806 100644
>> --- a/transaction.c
>> +++ b/transaction.c
>> @@ -46,7 +46,8 @@ struct btrfs_trans_handle* btrfs_start_transaction(s=
truct btrfs_root *root,
>>  	fs_info->generation++;
>>  	h->transid =3D fs_info->generation;
>>  	h->blocks_reserved =3D num_blocks;
>> -	h->reinit_extent_tree =3D false;
>> +	h->reinit_extent_tree =3D 0;
>> +	h->allocating_chunk =3D 0;
>>  	root->last_trans =3D h->transid;
>>  	root->commit_root =3D root->node;
>>  	extent_buffer_get(root->node);
>> diff --git a/transaction.h b/transaction.h
>> index 34060252dd5c..b426cd112447 100644
>> --- a/transaction.h
>> +++ b/transaction.h
>> @@ -28,7 +28,8 @@ struct btrfs_trans_handle {
>>  	u64 transid;
>>  	u64 alloc_exclude_start;
>>  	u64 alloc_exclude_nr;
>> -	bool reinit_extent_tree;
>> +	unsigned int reinit_extent_tree:1;
>> +	unsigned int allocating_chunk:1;
>=20
> Why do you switch reinit_extent_tree to the bit, this is an unrelated
> change. I'll drop it and update changelog with the 2M preallocation
> that was discussed.
>=20

Because in this patch, we're introducing new bit, thus to me it's pretty
valid to expanding old bool value into bits.

Thanks,
Qu


--UN93LpTO6D52CPncqKIjcgg4DFEkPC73n--

--GFvxnDYuZkCKfK59jDmlY6M2JX3GCsHOv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlz4XmQACgkQwj2R86El
/qg5sgf/RxCF3OekmFY1x94XCzzQRBVkfcpUlIIyFAiZNhG9gFiqL+LRx+9N0+N/
BAU+NdNi5LLYPhq1UlvBQ28zEaQ41b8FR53/6AXrtDrLpgWJWVDS2ytea58J4Nam
Snm0Ory9YmfbQeMsGAALLXmKzj79SjLaTkgxK3JxWde66MXhTdMijYqrDfNWLx4F
m4K5t2LO+GnYVvR8F37SmZsgUGr9JKPgT/rDr6uyMWT3kn6V7PEnOuAetxOxTBsc
kICppabHFM9pfaGe+bfq0bJK7+GbRh3QZP5z83EbqJEbpXzTeQqZiZjyQRvz6C7e
KuBeyr9Rb+kue64fl8tuMnnrOHZohQ==
=O3Sj
-----END PGP SIGNATURE-----

--GFvxnDYuZkCKfK59jDmlY6M2JX3GCsHOv--
