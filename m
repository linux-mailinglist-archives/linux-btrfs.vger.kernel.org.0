Return-Path: <linux-btrfs+bounces-21857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAqrMf5DnWkMOAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21857-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:23:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 199CE182631
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF5A8306175A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 06:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634CB287257;
	Tue, 24 Feb 2026 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="PY4hUSx7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BB3EBF1A;
	Tue, 24 Feb 2026 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914224; cv=none; b=PxsXEB8cpE7cIIfyGMmLUUG8m8k5NLTcEVXVGln/mM81YADDbVtSW2G9ZVgmQmWkqG9+JXOT2BAZxXGi+8LogV3jby+CRIO/7QjKS21Gj7TUD7CYjG2iCzuo7m3mlP6QOSi3OVyfKosukBGw+risEWcRA1JvPvIApIRVplHMWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914224; c=relaxed/simple;
	bh=vLtz4JtSeKoKbSmMnpaHvexveXfz4N3LbCGsBTpFrGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UKbpwhbvLTurxS+mCFCgTI8w8nuN7MD5eCqAin/z+vHfk0B9ioBbKtaKSDKy9NIaNqRAGnPQ+UArdIv4mzi4dtOP45bJ215N9xd+LGHl3wIJLEEdNY43PrDZZNwn6WEkKuCTC69OxCVorra10l4X9ZotSro247mNQaGfANA7SH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=PY4hUSx7; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fKnjJ2XSKz9v77;
	Tue, 24 Feb 2026 07:23:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771914212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkjigxzrR1tWS4vwDncxmXgTFntcC2fjQWPOvDYjGb4=;
	b=PY4hUSx73i0GYVR5ELXxTknrr1lnNeERBa8jxdzeLCK8D501VYNm/ApvV/Xm0laFt4Pi9b
	5F7qZEPI9l3lxCr1CHDv0h9FV2GdX/s/E2GQ9XiWzfU1ODzfQIcTnw5N1FYBjZ+ssGupZP
	wGBwIlg5KNQc3R5RiJJkKrxzO5TouQw8sIizH/8+LGfp/PeKilbHUMTDLaMB3De5c30iD7
	bUdUzVSpCx6pq5VEsm1Jm3qQD9qU2nm4ULszmafBt2qEkoGw4bf0Btd2OjMdDw36mrS30u
	5cFxCKXXO+IianoTyHU+SA5ICFxaFTzmCnzAmXleCPag8/Jd14qjJNXUrxmLvA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::1 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Kees Cook <kees@kernel.org>
Cc: dsterba@suse.com,  clm@fb.com,  naohiro.aota@wdc.com,
  linux-btrfs@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
In-Reply-To: <202602231603.4F93301E@keescook> (Kees Cook's message of "Mon, 23
	Feb 2026 16:06:12 -0800")
References: <20260223234451.277369-1-mssola@mssola.com>
	<202602231603.4F93301E@keescook>
Date: Tue, 24 Feb 2026 07:23:25 +0100
Message-ID: <878qci7j8i.fsf@>
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
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21857-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mssola.com:dkim]
X-Rspamd-Queue-Id: 199CE182631
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kees Cook @ 2026-02-23 16:06 -08:

> On Tue, Feb 24, 2026 at 12:44:51AM +0100, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index 02105d68accb..1ebfed8f0a0a 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -2110,8 +2110,8 @@ static int recover_sectors(struct btrfs_raid_bio *=
rbio)
>>  	 * @unmap_array stores copy of pointers that does not get reordered
>>  	 * during reconstruction so that kunmap_local works.
>>  	 */
>> -	pointers =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>> -	unmap_array =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>> +	pointers =3D kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
>> +	unmap_array =3D kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOF=
S);
>>  	if (!pointers || !unmap_array) {
>>  		ret =3D -ENOMEM;
>>  		goto out;
>
> Just as a style option, I wanted to point out (for at least the above,
> I didn't check the rest), you can do the definition and declaration at
> once with "auto" and put the type in the alloc:
>
> 	auto pointers =3D kzalloc_objs(void *, rbio->real_stripes, GFP_NOFS);
>
> But either way is fine. :) This patch looks good to me!

I personally don't mind either way, but I don't what's the policy around
using "auto" in btrfs.

>
> Reviewed-by: Kees Cook <kees@kernel.org>

Thanks!
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmdQ94bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZUJED/41nze/C48IVb7Z6Y3+IUlnwSp2VTRLaN9iseVlaM9sMvOo4sYUS+H2bWIb
cVyU4jz5uo07iMBHBBTYbrKCqC07cp5N+KaBi4PdPcqEZKO9DNcjsFA1F9Qgr313
FVL/yxUz1MSqy2qWuezo6lWiDl/TRtUQDy9D4xKEHJfbC2bVv9nuJjWSLIZg/Mis
+0kN2xJYzMHhB8AWH3VQuoq5SryIYVBASXhyIDQulPgiJgpp33lX7Ijy8L1dJxDJ
GrgPB50P49LB36rqbPHSDTiw6sryzOm/U5hpNZ4tQJ6pdab5Lco+DIpbHeZlA2E1
/PWwsgymZWHND0H5KQhwShngT2YYf2i6vNOD8/wbGquvlWly8fEZH+kjWBaYi+hb
JJDvE+Qd7xiBXHOpKWOa98yvczbbFnyYWkeRJZ799uUErxFC6bPmlTK7WF/HRFtO
gvrEAUyJ7Xp+ENwevsfVS+nLhE9ZfDH3xz9pN7061ECvl+Dj80WXyCgpsSw5g98R
po8zrEZPlkbQGH3Vwi6nUrkKG3bqBpSl3aC/a8jAvAJjVM5CViAO0yapIWKNX7Z0
Z81B1hke1VawU5udYaleRnadbHL5kZ5g6SqTvRf4liEwTbZ2I6uGGGWGkcwuABmv
FOiIfZ55Dl83Rp9hgyA//CDdQC2aru3xHYphsuU4DtlHwjBztw==
=Okhs
-----END PGP SIGNATURE-----
--=-=-=--

