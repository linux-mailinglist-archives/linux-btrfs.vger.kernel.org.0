Return-Path: <linux-btrfs+bounces-21856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JFWFS0snWmwNAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21856-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 05:42:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0625181B64
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 05:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CC7D301FC92
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 04:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A54827B340;
	Tue, 24 Feb 2026 04:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="iy07t+uZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ECF1C6FF5;
	Tue, 24 Feb 2026 04:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771908136; cv=none; b=F19STYgv5GYc2o6lO11KfAwuMg0qV1mNmmHXeECDXU4srZtNzZzTV4RvcuCgKP9iv7r+lkGnI6vLiktmSJjdEViN/h9uUPeyFOFakVKfNh0rWGtuQ0bJ6blNdoYCuw2ixaUGOoZ+8nyuBVLETA57DkgsNlPm3GrTwoqsGnkWnEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771908136; c=relaxed/simple;
	bh=5EFJ7nSVg+sMgTfOu5tsvE+ZcfKOelHCkmqgUjA9c30=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p88n9YNZvFmuZ1/3nYcYf8KM0tqXXSx6nnkAO4USnlUZaq6SzgAU8i99sCYagWubemEuI599IJL5GlQ34STAWZ3SmUP+G/INtJ45tm5IchsSzOmAVA6mqhO666JDCe6VwtEZi1xOKqdR0GXv+U8v+UaivOxPd7ovPyYlCFI2Cco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=iy07t+uZ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771908133; x=1772512933; i=quwenruo.btrfs@gmx.com;
	bh=5EFJ7nSVg+sMgTfOu5tsvE+ZcfKOelHCkmqgUjA9c30=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iy07t+uZNMSmu0NdHBKf9+8AnM7bw/Cszmj7G4tdYnkNKvVCOW5YUFTsn8jKoHzo
	 lqTfhv5TDpbjnj3YcnTB86W0a54jITy6J9WitgXs7TnrqXnzG82TQu2E0Ld8+0IF8
	 PIyJfLuqogbZBaMkjOfKkI9kQ5AZUrAByN8suEJKbnv7YLcvSUl6a1t0XVLlSTqJ4
	 5szkUeFaffXUtYOivPbZAcY5g4Re0ypxvZm9N/PKKjCUFzNU88xRZtHPROUdxILsF
	 jZCGxbnHMS2TcOfhbUycZEP5pCpHdlWese3iJCCVi3SQ/xdxycyJJvQk/CnoUYbEa
	 nU5+2q6ofSnsQNW6RA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlw3N-1vUjDj2nnH-00ZVQL; Tue, 24
 Feb 2026 05:42:13 +0100
Message-ID: <3c295815-6359-472c-9703-c755b4623aed@gmx.com>
Date: Tue, 24 Feb 2026 15:12:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: =?UTF-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>,
 dsterba@suse.com
Cc: clm@fb.com, naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kees@kernel.org
References: <20260223234451.277369-1-mssola@mssola.com>
 <69c16813-5ac1-4756-ad42-41b4275e6aee@gmx.com>
Content-Language: en-US
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <69c16813-5ac1-4756-ad42-41b4275e6aee@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3CWsIshAAWYr5s/Uyn/hpWcUg1rL8eLRfTjdq5kC86SM7W1vDgj
 0W1PVnJZ9ge9Y6qF7kcHjyqArA3saen+gVMN1dTPqOQL4E4jHyer5IlEA0Wr5dt8M0bod2C
 ZOr/kS6Emhb2WxCkgYqQINb1OQmdhYtx4JReDqvgois75voDjUNLIlTckDmb2Co+m/kcPUv
 NNOB21z5edI5Oo55ZT2yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z23M3bs3/Ok=;zIxphjHJlBx9xaIYc8eqx8h/Tgw
 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
 ppm9HVME=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21856-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mssola.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0625181B64
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/24 15:07, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2026/2/24 10:14, Miquel Sabat=C3=A9 Sol=C3=A0 =E5=86=99=E9=81=
=93:
>> Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
>> introduced, among many others, the kzalloc_objs() helper, which has som=
e
>> benefits over kcalloc().
>>
>> Cc: Kees Cook <kees@kernel.org>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>> ---
>> =C2=A0 fs/btrfs/block-group.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +=
-
>> =C2=A0 fs/btrfs/raid56.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 8 ++++----
>> =C2=A0 fs/btrfs/tests/zoned-tests.c | 2 +-
>> =C2=A0 fs/btrfs/volumes.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 6 ++----
>> =C2=A0 fs/btrfs/zoned.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 5 ++---
>> =C2=A0 5 files changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 37bea850b3f0..8d85b4707690 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2239,7 +2239,7 @@ int btrfs_rmap_block(struct btrfs_fs_info=20
>> *fs_info, u64 chunk_start,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (map->type & BTRFS_BLOCK_GROUP_RAID56=
_MASK)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_stripe_size =
=3D=20
>> btrfs_stripe_nr_to_offset(nr_data_stripes(map));
>> -=C2=A0=C2=A0=C2=A0 buf =3D kcalloc(map->num_stripes, sizeof(u64), GFP_=
NOFS);
>> +=C2=A0=C2=A0=C2=A0 buf =3D kzalloc_objs(*buf, map->num_stripes, GFP_NO=
FS);
>=20
> Not sure if we should use *buf for the type.
>=20
> I still remember we had some bugs related to incorrect type usage.
>=20
> Another thing is, we may not want to use the kzalloc version.
> We don't want to waste CPU time just to zero out the content meanwhile=
=20
> we're ensured to re-assign the contents.
>=20
> Thus kmalloc_objs() maybe better.

Sorry I only mean for some particular call sites, like this one.

Not all call sites can be converted to kmalloc version, and will need=20
proper inspection one by one.

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!buf) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index 02105d68accb..1ebfed8f0a0a 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -2110,8 +2110,8 @@ static int recover_sectors(struct btrfs_raid_bio=
=20
>> *rbio)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @unmap_array stores copy of poin=
ters that does not get reordered
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * during reconstruction so that ku=
nmap_local works.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 pointers =3D kcalloc(rbio->real_stripes, sizeof(voi=
d *), GFP_NOFS);
>> -=C2=A0=C2=A0=C2=A0 unmap_array =3D kcalloc(rbio->real_stripes, sizeof(=
void *), GFP_NOFS);
>> +=C2=A0=C2=A0=C2=A0 pointers =3D kzalloc_objs(*pointers, rbio->real_str=
ipes, GFP_NOFS);
>> +=C2=A0=C2=A0=C2=A0 unmap_array =3D kzalloc_objs(*unmap_array, rbio->re=
al_stripes,=20
>> GFP_NOFS);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pointers || !unmap_array) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> @@ -2844,8 +2844,8 @@ static int recover_scrub_rbio(struct=20
>> btrfs_raid_bio *rbio)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @unmap_array stores copy of poin=
ters that does not get reordered
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * during reconstruction so that ku=
nmap_local works.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 pointers =3D kcalloc(rbio->real_stripes, sizeof(voi=
d *), GFP_NOFS);
>> -=C2=A0=C2=A0=C2=A0 unmap_array =3D kcalloc(rbio->real_stripes, sizeof(=
void *), GFP_NOFS);
>> +=C2=A0=C2=A0=C2=A0 pointers =3D kzalloc_objs(*pointers, rbio->real_str=
ipes, GFP_NOFS);
>> +=C2=A0=C2=A0=C2=A0 unmap_array =3D kzalloc_objs(*unmap_array, rbio->re=
al_stripes,=20
>> GFP_NOFS);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pointers || !unmap_array) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> diff --git a/fs/btrfs/tests/zoned-tests.c b/fs/btrfs/tests/zoned-tests.=
c
>> index da21c7aea31a..2bc3b14baa41 100644
>> --- a/fs/btrfs/tests/zoned-tests.c
>> +++ b/fs/btrfs/tests/zoned-tests.c
>> @@ -58,7 +58,7 @@ static int test_load_zone_info(struct btrfs_fs_info=
=20
>> *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 zone_info =3D kcalloc(test->num_stripes, sizeof(*zo=
ne_info),=20
>> GFP_KERNEL);
>> +=C2=A0=C2=A0=C2=A0 zone_info =3D kzalloc_objs(*zone_info, test->num_st=
ripes, GFP_KERNEL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!zone_info) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_err("cannot=
 allocate zone info");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index e15e138c515b..c0cf8f7c5a8e 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5499,8 +5499,7 @@ static int calc_one_profile_avail(struct=20
>> btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 devices_info =3D kcalloc(fs_devices->rw_devices,=20
>> sizeof(*devices_info),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_NOFS);
>> +=C2=A0=C2=A0=C2=A0 devices_info =3D kzalloc_objs(*devices_info, fs_dev=
ices-=20
>> >rw_devices, GFP_NOFS);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!devices_info) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> @@ -6067,8 +6066,7 @@ struct btrfs_block_group=20
>> *btrfs_create_chunk(struct btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctl.space_info =3D space_info;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_alloc_chunk_ctl(fs_devices, &ctl);
>> -=C2=A0=C2=A0=C2=A0 devices_info =3D kcalloc(fs_devices->rw_devices,=20
>> sizeof(*devices_info),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_NOFS);
>> +=C2=A0=C2=A0=C2=A0 devices_info =3D kzalloc_objs(*devices_info, fs_dev=
ices-=20
>> >rw_devices, GFP_NOFS);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!devices_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-=
ENOMEM);
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>> index ab330ec957bc..851b0de7bed7 100644
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> @@ -1697,8 +1697,7 @@ static int btrfs_load_block_group_raid10(struct=
=20
>> btrfs_block_group *bg,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 raid0_allocs =3D kcalloc(map->num_stripes / map->su=
b_stripes,=20
>> sizeof(*raid0_allocs),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_NOFS);
>> +=C2=A0=C2=A0=C2=A0 raid0_allocs =3D kzalloc_objs(*raid0_allocs, map->n=
um_stripes /=20
>> map->sub_stripes, GFP_NOFS);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!raid0_allocs)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> @@ -1916,7 +1915,7 @@ int btrfs_load_block_group_zone_info(struct=20
>> btrfs_block_group *cache, bool new)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->physical_map =3D map;
>> -=C2=A0=C2=A0=C2=A0 zone_info =3D kcalloc(map->num_stripes, sizeof(*zon=
e_info), GFP_NOFS);
>> +=C2=A0=C2=A0=C2=A0 zone_info =3D kzalloc_objs(*zone_info, map->num_str=
ipes, GFP_NOFS);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!zone_info) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>=20
>=20


