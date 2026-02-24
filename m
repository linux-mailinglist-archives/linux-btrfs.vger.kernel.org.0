Return-Path: <linux-btrfs+bounces-21859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBZqNUJHnWmoOAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21859-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:37:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5786C1827AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DFA3304F214
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 06:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE51F3033FC;
	Tue, 24 Feb 2026 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="1Y+ttd+O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB947302146;
	Tue, 24 Feb 2026 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915008; cv=none; b=lxaVmmc5FE8gZPj651AC/y2e9kkr7uFwvbjnPUkUgmI8CmGUQOPXuumZ6J7avcrmDeC0SV0zMYjpl9GyopV7lR3JqgOTMmiY6+Dhu61xkGRP223351GpCTSJLjINRJNMnjxUSHC5lxnj4TqY7J/pptfN14gbdr/asDsnvv3msq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915008; c=relaxed/simple;
	bh=9PyasL8lwr5119E68jxTFaBakyFd7CK2RWvkqLbl5eg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s3BxlF7F9V79UXGJ1jmhIVItK/NyAN0KXbX5lFG877zzlWq33gZr7SrnUm0IFK1TajHtkHICW4XsgL42g69um//4IRp600/zkF6f97MrYbwGlYgBbS06CCE/tJQ5vO/Tagsa22tfyEBxUuL7Xq5bp8THeEXPDO2bm76xuuQUal0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=1Y+ttd+O; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fKp0T1DLvz9v2P;
	Tue, 24 Feb 2026 07:36:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771915001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/yBhvm86PjNcdHkPw10UEl0zpebwfz8viY0IFhSoutc=;
	b=1Y+ttd+OskjYj573JEefl9QsZRQKLDPVGob2X1tzR3bwsf5J7fFILTGyBE1rIduAOnzMAc
	sNjYwX9P+rlJMtRCeaVL5kdzNLAjZvE1rAX3JqgGySnoGxqv8ye7oY0wcDVChs5D9dTKCl
	1UUxMD3VVY8aTADInVLujjTsxpw8voWOea5pOk8GytiT/6PyYDDPhBLave3iiioP8sHgQZ
	cV1i6am+3bLK7RL4ryMfoIV2zgwZ3EVLSGWrDHMFH2QD4II5nbGxH5a1Kn8V3ph/0IueR/
	eUdp5GXpLjV96VfqkMYH9SCAR+OkC6R7oB6SZdbGXFdtIY3IY5i0BQJ0DdjhTw==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.com,  clm@fb.com,  naohiro.aota@wdc.com,
  linux-btrfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  kees@kernel.org
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
In-Reply-To: <69c16813-5ac1-4756-ad42-41b4275e6aee@gmx.com> (Qu Wenruo's
	message of "Tue, 24 Feb 2026 15:07:10 +1030")
References: <20260223234451.277369-1-mssola@mssola.com>
	<69c16813-5ac1-4756-ad42-41b4275e6aee@gmx.com>
Date: Tue, 24 Feb 2026 07:36:38 +0100
Message-ID: <87342q7imh.fsf@>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21859-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mssola.com:email,mssola.com:dkim]
X-Rspamd-Queue-Id: 5786C1827AB
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qu Wenruo @ 2026-02-24 15:07 +1030:

> =E5=9C=A8 2026/2/24 10:14, Miquel Sabat=C3=A9 Sol=C3=A0 =E5=86=99=E9=81=
=93:
>> Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
>> introduced, among many others, the kzalloc_objs() helper, which has some
>> benefits over kcalloc().
>> Cc: Kees Cook <kees@kernel.org>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>> ---
>>   fs/btrfs/block-group.c       | 2 +-
>>   fs/btrfs/raid56.c            | 8 ++++----
>>   fs/btrfs/tests/zoned-tests.c | 2 +-
>>   fs/btrfs/volumes.c           | 6 ++----
>>   fs/btrfs/zoned.c             | 5 ++---
>>   5 files changed, 10 insertions(+), 13 deletions(-)
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 37bea850b3f0..8d85b4707690 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2239,7 +2239,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info=
, u64 chunk_start,
>>   	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
>>   		io_stripe_size =3D btrfs_stripe_nr_to_offset(nr_data_stripes(map));
>>   -	buf =3D kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
>> +	buf =3D kzalloc_objs(*buf, map->num_stripes, GFP_NOFS);
>
> Not sure if we should use *buf for the type.
>
> I still remember we had some bugs related to incorrect type usage.

Considering the type of 'buf' and how kzalloc_objs() will resolve the
first argument '*buf', it should really just be equivalent to what was
written before.

>
> Another thing is, we may not want to use the kzalloc version.
> We don't want to waste CPU time just to zero out the content meanwhile we=
're
> ensured to re-assign the contents.
>
> Thus kmalloc_objs() maybe better.

Yes, having a second look at this function, it looks like kmalloc_objs()
might just be enough. If you don't mind, I will add another commit in v2
translating kzalloc_objs() into kmalloc_objs() wherever I see we can do
this from the ones I've touched. This way we can easily revert in case
things go south :)

>
> Thanks,
> Qu

Thanks,
Miquel

>
>
>>   	if (!buf) {
>>   		ret =3D -ENOMEM;
>>   		goto out;
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index 02105d68accb..1ebfed8f0a0a 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -2110,8 +2110,8 @@ static int recover_sectors(struct btrfs_raid_bio *=
rbio)
>>   	 * @unmap_array stores copy of pointers that does not get reordered
>>   	 * during reconstruction so that kunmap_local works.
>>   	 */
>> -	pointers =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>> -	unmap_array =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>> +	pointers =3D kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
>> +	unmap_array =3D kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOF=
S);
>>   	if (!pointers || !unmap_array) {
>>   		ret =3D -ENOMEM;
>>   		goto out;
>> @@ -2844,8 +2844,8 @@ static int recover_scrub_rbio(struct btrfs_raid_bi=
o *rbio)
>>   	 * @unmap_array stores copy of pointers that does not get reordered
>>   	 * during reconstruction so that kunmap_local works.
>>   	 */
>> -	pointers =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>> -	unmap_array =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>> +	pointers =3D kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
>> +	unmap_array =3D kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOF=
S);
>>   	if (!pointers || !unmap_array) {
>>   		ret =3D -ENOMEM;
>>   		goto out;
>> diff --git a/fs/btrfs/tests/zoned-tests.c b/fs/btrfs/tests/zoned-tests.c
>> index da21c7aea31a..2bc3b14baa41 100644
>> --- a/fs/btrfs/tests/zoned-tests.c
>> +++ b/fs/btrfs/tests/zoned-tests.c
>> @@ -58,7 +58,7 @@ static int test_load_zone_info(struct btrfs_fs_info *f=
s_info,
>>   		return -ENOMEM;
>>   	}
>>   -	zone_info =3D kcalloc(test->num_stripes, sizeof(*zone_info), GFP_KER=
NEL);
>> +	zone_info =3D kzalloc_objs(*zone_info, test->num_stripes, GFP_KERNEL);
>>   	if (!zone_info) {
>>   		test_err("cannot allocate zone info");
>>   		return -ENOMEM;
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index e15e138c515b..c0cf8f7c5a8e 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5499,8 +5499,7 @@ static int calc_one_profile_avail(struct btrfs_fs_=
info *fs_info,
>>   		goto out;
>>   	}
>>   -	devices_info =3D kcalloc(fs_devices->rw_devices, sizeof(*devices_inf=
o),
>> -			       GFP_NOFS);
>> +	devices_info =3D kzalloc_objs(*devices_info, fs_devices->rw_devices, G=
FP_NOFS);
>>   	if (!devices_info) {
>>   		ret =3D -ENOMEM;
>>   		goto out;
>> @@ -6067,8 +6066,7 @@ struct btrfs_block_group *btrfs_create_chunk(struc=
t btrfs_trans_handle *trans,
>>   	ctl.space_info =3D space_info;
>>   	init_alloc_chunk_ctl(fs_devices, &ctl);
>>   -	devices_info =3D kcalloc(fs_devices->rw_devices, sizeof(*devices_inf=
o),
>> -			       GFP_NOFS);
>> +	devices_info =3D kzalloc_objs(*devices_info, fs_devices->rw_devices, G=
FP_NOFS);
>>   	if (!devices_info)
>>   		return ERR_PTR(-ENOMEM);
>>   diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>> index ab330ec957bc..851b0de7bed7 100644
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> @@ -1697,8 +1697,7 @@ static int btrfs_load_block_group_raid10(struct bt=
rfs_block_group *bg,
>>   		return -EINVAL;
>>   	}
>>   -	raid0_allocs =3D kcalloc(map->num_stripes / map->sub_stripes,
>> sizeof(*raid0_allocs),
>> -			       GFP_NOFS);
>> +	raid0_allocs =3D kzalloc_objs(*raid0_allocs, map->num_stripes / map->s=
ub_stripes, GFP_NOFS);
>>   	if (!raid0_allocs)
>>   		return -ENOMEM;
>>   @@ -1916,7 +1915,7 @@ int btrfs_load_block_group_zone_info(struct
>> btrfs_block_group *cache, bool new)
>>     	cache->physical_map =3D map;
>>   -	zone_info =3D kcalloc(map->num_stripes, sizeof(*zone_info), GFP_NOFS=
);
>> +	zone_info =3D kzalloc_objs(*zone_info, map->num_stripes, GFP_NOFS);
>>   	if (!zone_info) {
>>   		ret =3D -ENOMEM;
>>   		goto out;

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmdRvYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZeayD/9y6PcxJb3uIiDHXdefijoNaBm80HpxeqbKXzXPykWaBNQyZVH19Gz1tASj
Gb8wfnW8Ho7BDe+z7iUQ7ZztDDOxXORYOk0/fs6NMIymQ/kqhWLT1lBVBaCh8xr4
3rZYjeLCNE7ZB4nsMZZEev7iR8FWgKWPdmKQ0pTFlWsnfkcuoQCZ6+0K5MNUbTQL
61hicxMveRjHFCqcvQeWg9dyjnnisYy2owjLEL1ikcYiu2hjFGH48cGrosHlozL2
o7rSw3LtZvyFKay/xkeuQwlVa+CtCibVNeKHDsqKqBIcHwEq9Tx5g886UgWyU340
95QpwL4rGqGtQJ1cy40C6oE3Qu2IxSmmxVbg2rbm4wgVq1QBsuDUz0wJtyqTTyMk
jyAdWne/6PTzbnhM7nwotDxGTn4ZXHH56RsPR21K8cU1dww0wiO/sYk+0AT/st8q
BGahQvN8lep2++Jt86GOAB3SRWvblNHYKqMDyCLuB9FZlc6E0qXsRXgLf4A53wjl
rqXWQb/RUrBoBX8KcjJN30ztj9Q2nqSPgXJ+xoHDmg3EG/lyjwiAOrtrdzKX9CsI
puRqHR83qJHkrRMLK9RlbpTIlNlnO7j3NTzPfX31MYqjFXZjOohZAFbjtREEotHn
Vf4tFMAMRP/Yo6y/j2EfwO7UwVPi9IEiIVfuP+AVEE3ULC55tg==
=mUJa
-----END PGP SIGNATURE-----
--=-=-=--

