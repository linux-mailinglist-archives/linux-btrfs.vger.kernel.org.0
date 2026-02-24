Return-Path: <linux-btrfs+bounces-21864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHC6GhNpnWnBPwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21864-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 10:02:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6051842BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 10:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C33E30D3811
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 08:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F62366821;
	Tue, 24 Feb 2026 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="Wq23nPwv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14B1C3BF7;
	Tue, 24 Feb 2026 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923558; cv=none; b=B0B/Fh/lGDU2BIEAQT1v5vbPg/nLlwFum8JHwOttLMkBhkRpvtaFEOMrkMGd81xBjx0jgDzbCGls2Jl3H/Q1KXeP7P/ORCn21DduMB0+aDarnPbCewT6Lq7yePEgV6MfgBpZAVXSeKZOC1whCWGO818x5tbzQz9J4AlgGGmEFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923558; c=relaxed/simple;
	bh=5ADkG5GAITHJI3lgw3cG4MQ7/LEa3eeWJnLWS3YC02Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=COqtawk6mssb9vbzjzmtA4n/QtnACPs0h6i2HDS04/q/YdeuWkBwvh54m7Bi7n77Wpgd2DTx8V7YZSYd/YxVfrhh2tXUzcf04SLByC2IHGQOEtBeK2tDRvcAbZvAVYrj/zhDQHPS3bSL9S8lDzGn1i8SNKWshDWowlh5lD+LG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=Wq23nPwv; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fKs8r2jkFz9sWL;
	Tue, 24 Feb 2026 09:59:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771923548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vRULpDVwsVgWl7LuoGsHbb9Mj55mUS7qOAuMZwFJxo=;
	b=Wq23nPwvURv9/0TWWdnP8Fw5BN/uxi9mP4knQs699wJpsRnAZCDMGXDwArb/RksCxUjGV8
	1Diziv98yKoTzHBZlQ9eNcHfKN8wSt/TVVmVH6V9W6rjag3gE7qfvCpEtD9xysV7gSZjf+
	Zv13G4xSRFMeTcI1QF6SE7ogKrwb3pMHioEKBrosYap0+oFpJlePB+YC/mlq2k128eMwPU
	z5aWOqib++a32uxqjdxV4VP3D6b8Mfe1l6WACnuk9bgyyOZQ54dZDYX5PO4Z/sf9jKNb77
	dk9ibkmrTjeVBZDOXeeUd0tHTMNIFGiVBtDW93feINbICfq/5b115eHV8V766w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::2 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,  dsterba@suse.com,  clm@fb.com,
  naohiro.aota@wdc.com,  linux-btrfs@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kees@kernel.org
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
In-Reply-To: <e21ea0cf-b392-487f-843f-962efedcf10c@suse.com> (Qu Wenruo's
	message of "Tue, 24 Feb 2026 17:18:31 +1030")
References: <20260223234451.277369-1-mssola@mssola.com>
	<69c16813-5ac1-4756-ad42-41b4275e6aee@gmx.com>
	<699d4704.050a0220.1a6450.86d7SMTPIN_ADDED_BROKEN@mx.google.com>
	<e21ea0cf-b392-487f-843f-962efedcf10c@suse.com>
Date: Tue, 24 Feb 2026 09:59:04 +0100
Message-ID: <87qzqa5xgn.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.23 / 15.00];
	SIGNED_PGP(-2.00)[];
	INVALID_MSGID(1.70)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.83)[subject];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21864-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,suse.com,fb.com,wdc.com,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C6051842BB
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qu Wenruo @ 2026-02-24 17:18 +1030:

> =E5=9C=A8 2026/2/24 17:06, Miquel Sabat=C3=A9 Sol=C3=A0 =E5=86=99=E9=81=
=93:
>> Qu Wenruo @ 2026-02-24 15:07 +1030:
>>
>>> =E5=9C=A8 2026/2/24 10:14, Miquel Sabat=C3=A9 Sol=C3=A0 =E5=86=99=E9=81=
=93:
>>>> Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
>>>> introduced, among many others, the kzalloc_objs() helper, which has so=
me
>>>> benefits over kcalloc().
>>>> Cc: Kees Cook <kees@kernel.org>
>>>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>>>> ---
>>>>    fs/btrfs/block-group.c       | 2 +-
>>>>    fs/btrfs/raid56.c            | 8 ++++----
>>>>    fs/btrfs/tests/zoned-tests.c | 2 +-
>>>>    fs/btrfs/volumes.c           | 6 ++----
>>>>    fs/btrfs/zoned.c             | 5 ++---
>>>>    5 files changed, 10 insertions(+), 13 deletions(-)
>>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>>> index 37bea850b3f0..8d85b4707690 100644
>>>> --- a/fs/btrfs/block-group.c
>>>> +++ b/fs/btrfs/block-group.c
>>>> @@ -2239,7 +2239,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_in=
fo, u64 chunk_start,
>>>>    	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
>>>>    		io_stripe_size =3D btrfs_stripe_nr_to_offset(nr_data_stripes(map)=
);
>>>>    -	buf =3D kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
>>>> +	buf =3D kzalloc_objs(*buf, map->num_stripes, GFP_NOFS);
>>>
>>> Not sure if we should use *buf for the type.
>>>
>>> I still remember we had some bugs related to incorrect type usage.
>> Considering the type of 'buf' and how kzalloc_objs() will resolve the
>> first argument '*buf', it should really just be equivalent to what was
>> written before.
>
> Good luck if you miss the '*' for a structure pointer, and compiler won't=
 give
> you any warning.
>
> I still remembered that Johannes exposed such bug for me.
> Unfortunately I didn't have exact lore link for it.

That's a good point. Fortunately for us, this is what I get if I remove
the star with GCC 15.2:

fs/btrfs/block-group.c:2242:13: error: assignment to 'u64 *' {aka 'long lon=
g unsigned int *'} from incompatible pointer type 'u64 **' {aka 'long long =
unsigned int **'} [-Wincompatible-pointer-types]
 2242 |         buf =3D kmalloc_objs(buf, map->num_stripes, GFP_NOFS);
      |

Hence, it looks like these kinds of errors will be catched by the
compiler with these new helpers. This doesn't mean that we are 100% safe
from corner cases, but at least there are some guarantees.

>
>>
>>>
>>> Another thing is, we may not want to use the kzalloc version.
>>> We don't want to waste CPU time just to zero out the content meanwhile =
we're
>>> ensured to re-assign the contents.
>>>
>>> Thus kmalloc_objs() maybe better.
>> Yes, having a second look at this function, it looks like kmalloc_objs()
>> might just be enough. If you don't mind, I will add another commit in v2
>> translating kzalloc_objs() into kmalloc_objs() wherever I see we can do
>> this from the ones I've touched. This way we can easily revert in case
>> things go south :)
>>
>>>
>>> Thanks,
>>> Qu
>> Thanks,
>> Miquel
>>
>>>
>>>
>>>>    	if (!buf) {
>>>>    		ret =3D -ENOMEM;
>>>>    		goto out;
>>>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>>>> index 02105d68accb..1ebfed8f0a0a 100644
>>>> --- a/fs/btrfs/raid56.c
>>>> +++ b/fs/btrfs/raid56.c
>>>> @@ -2110,8 +2110,8 @@ static int recover_sectors(struct btrfs_raid_bio=
 *rbio)
>>>>    	 * @unmap_array stores copy of pointers that does not get reordered
>>>>    	 * during reconstruction so that kunmap_local works.
>>>>    	 */
>>>> -	pointers =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>>>> -	unmap_array =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS=
);
>>>> +	pointers =3D kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
>>>> +	unmap_array =3D kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_N=
OFS);
>>>>    	if (!pointers || !unmap_array) {
>>>>    		ret =3D -ENOMEM;
>>>>    		goto out;
>>>> @@ -2844,8 +2844,8 @@ static int recover_scrub_rbio(struct btrfs_raid_=
bio *rbio)
>>>>    	 * @unmap_array stores copy of pointers that does not get reordered
>>>>    	 * during reconstruction so that kunmap_local works.
>>>>    	 */
>>>> -	pointers =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>>>> -	unmap_array =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS=
);
>>>> +	pointers =3D kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
>>>> +	unmap_array =3D kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_N=
OFS);
>>>>    	if (!pointers || !unmap_array) {
>>>>    		ret =3D -ENOMEM;
>>>>    		goto out;
>>>> diff --git a/fs/btrfs/tests/zoned-tests.c b/fs/btrfs/tests/zoned-tests=
.c
>>>> index da21c7aea31a..2bc3b14baa41 100644
>>>> --- a/fs/btrfs/tests/zoned-tests.c
>>>> +++ b/fs/btrfs/tests/zoned-tests.c
>>>> @@ -58,7 +58,7 @@ static int test_load_zone_info(struct btrfs_fs_info =
*fs_info,
>>>>    		return -ENOMEM;
>>>>    	}
>>>>    -	zone_info =3D kcalloc(test->num_stripes, sizeof(*zone_info), GFP_=
KERNEL);
>>>> +	zone_info =3D kzalloc_objs(*zone_info, test->num_stripes, GFP_KERNEL=
);
>>>>    	if (!zone_info) {
>>>>    		test_err("cannot allocate zone info");
>>>>    		return -ENOMEM;
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index e15e138c515b..c0cf8f7c5a8e 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -5499,8 +5499,7 @@ static int calc_one_profile_avail(struct btrfs_f=
s_info *fs_info,
>>>>    		goto out;
>>>>    	}
>>>>    -	devices_info =3D kcalloc(fs_devices->rw_devices, sizeof(*devices_=
info),
>>>> -			       GFP_NOFS);
>>>> +	devices_info =3D kzalloc_objs(*devices_info, fs_devices->rw_devices,=
 GFP_NOFS);
>>>>    	if (!devices_info) {
>>>>    		ret =3D -ENOMEM;
>>>>    		goto out;
>>>> @@ -6067,8 +6066,7 @@ struct btrfs_block_group *btrfs_create_chunk(str=
uct btrfs_trans_handle *trans,
>>>>    	ctl.space_info =3D space_info;
>>>>    	init_alloc_chunk_ctl(fs_devices, &ctl);
>>>>    -	devices_info =3D kcalloc(fs_devices->rw_devices, sizeof(*devices_=
info),
>>>> -			       GFP_NOFS);
>>>> +	devices_info =3D kzalloc_objs(*devices_info, fs_devices->rw_devices,=
 GFP_NOFS);
>>>>    	if (!devices_info)
>>>>    		return ERR_PTR(-ENOMEM);
>>>>    diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>>> index ab330ec957bc..851b0de7bed7 100644
>>>> --- a/fs/btrfs/zoned.c
>>>> +++ b/fs/btrfs/zoned.c
>>>> @@ -1697,8 +1697,7 @@ static int btrfs_load_block_group_raid10(struct =
btrfs_block_group *bg,
>>>>    		return -EINVAL;
>>>>    	}
>>>>    -	raid0_allocs =3D kcalloc(map->num_stripes / map->sub_stripes,
>>>> sizeof(*raid0_allocs),
>>>> -			       GFP_NOFS);
>>>> +	raid0_allocs =3D kzalloc_objs(*raid0_allocs, map->num_stripes / map-=
>sub_stripes, GFP_NOFS);
>>>>    	if (!raid0_allocs)
>>>>    		return -ENOMEM;
>>>>    @@ -1916,7 +1915,7 @@ int btrfs_load_block_group_zone_info(struct
>>>> btrfs_block_group *cache, bool new)
>>>>      	cache->physical_map =3D map;
>>>>    -	zone_info =3D kcalloc(map->num_stripes, sizeof(*zone_info), GFP_N=
OFS);
>>>> +	zone_info =3D kzalloc_objs(*zone_info, map->num_stripes, GFP_NOFS);
>>>>    	if (!zone_info) {
>>>>    		ret =3D -ENOMEM;
>>>>    		goto out;

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmdaFgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZauYD/4o/02cnnllCz5WANeoJEgl3rFE5zkkVzezYb08CzQXmDmGgc2WnbJmqaEh
27zXo9YZuIaBFJPV1lP6cyIsqYDtQyjhPlEcDnf4a41hK/Ycr2bCf0R31DJBTlH5
0J0UzTQc8pcHkAg99JJUxPm9VIZWm3UneNYE4gm5JrjCH9cxcOFRrxzb/+LG3a1V
d7kEXA4UzHDStRnrbO2pScLjjM4MCuka5ry7EjR54FIBu71f+nXXWVIAXb6Zrxpe
uKQ4H874uuArlfhkC8rJf086Vo9KPioRC3CIIHGa4NwCpW06hZ64d135xYIDSjjU
hZold4d7a3tqZEbIKoeGOrkQDvt9daDAb8qVHMjNjGkJi9gNk79Tcoy/DwvctJNy
s4mVpJZSLJKxDwT4+O1bj+G2FYW+N9HYlG1jN9WckILvsTOOQAwuj13VSg/4TtVO
FHH8qKP7F+G5iI5C1o1lLq+0VEyJQ/Xh+eqz7zBr52axD0GhhU5nvMUB+i1jxD5g
aJjnKKIDkpamqPAQg6rBdWQkeAOEHKn6JHQDpZITkzI9me6lEnkl0gIc8rC+NlRq
f39pG0vXhZuFGxLkrvJ0zEiu0DzJ4+ZldxG9U6sOOUsjgrjmNFYDqVlf76l+i+fZ
+tvZWXNirU9sV5a7aQjyvCdbJMvV5qbr0N4f2QFozDeV7XuULQ==
=LhvC
-----END PGP SIGNATURE-----
--=-=-=--

