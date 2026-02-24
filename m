Return-Path: <linux-btrfs+bounces-21869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MLLKwyZnWnwQgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21869-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 13:26:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31237186F11
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 13:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0301530E440B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 12:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23F5395DAB;
	Tue, 24 Feb 2026 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="kQZPllsR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4F396D07;
	Tue, 24 Feb 2026 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935814; cv=none; b=akZSMLnFOqataPDjDZbosjFNH9LRqWDR1y66C0nel5L474fDaaGSGODQ346SFyZpFcAhyiraak4jk2+6gOncWyCDzqrJ38vBx71iXHfPMAox6JSrT6adAbHRVtEkXyHOUwMEW6PjOLPU7cDhqagkgykR68cYvKRNoOgiw9TYts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935814; c=relaxed/simple;
	bh=K9qUiyM7b+cdE5WG5gwPSRuoDd3PWM+m2lzFUBBPUOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K4OJUhbX3KLYkV1VMX9WG6GU4qk1nn6X7cO0rAIqytzipTUHM3OaWt79EOYPqths/OP52Mvg4UhXVXi6Wky/O2u+IH7pY/4bzb+8K7x/yy/JZSssRiP5Uk/EPLn6QOyEcaC4es9h8fOznjmvhda+vW+9xGl2sdW2MJ6X9AbwHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=kQZPllsR; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fKxhZ4q2dz9vgB;
	Tue, 24 Feb 2026 13:23:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771935806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VBzFxT6O1k4eu2DAgcXff+p4lk62ry7+QtHjgPmCNI=;
	b=kQZPllsROb8SOeXE0sQeIGsoTC3+AfG5mv3iAnof8C1Yzyf9L2SI+ZTliH04yI0F45uesb
	Mm/a1ru5yeIQox4IUiKqnCw5CUvfVcqlRFo1Xp7gUcEOC4pVstUi8tcbHkB4SRwnI31KLM
	4t8tF9mXlu1xtl2lLb9xJo2nV2UgWj13HzOf9cmYbWEvhx/bvUoKK1UbX3iD4XjDwzRElV
	hpqoH3kb110HkYjMh93QH6ntoFKqVZMqyHQzBUFeoc41bQkVTQQ9QrITx45YpuxoBnPoP0
	6E8Fl+I/o7dNxc8UxbZM1Vdre5Q8A91vSiylkRoBL4aGqo5/KcUkqSI/ja0taQ==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: David Sterba <dsterba@suse.cz>
Cc: Kees Cook <kees@kernel.org>,  dsterba@suse.com,  clm@fb.com,
  naohiro.aota@wdc.com,  linux-btrfs@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
In-Reply-To: <20260224112905.GQ26902@suse.cz> (David Sterba's message of "Tue,
	24 Feb 2026 12:29:05 +0100")
References: <20260223234451.277369-1-mssola@mssola.com>
	<202602231603.4F93301E@keescook>
	<699d43e6.170a0220.3a6e96.a235SMTPIN_ADDED_BROKEN@mx.google.com>
	<20260224112905.GQ26902@suse.cz>
Date: Tue, 24 Feb 2026 13:23:22 +0100
Message-ID: <871pias539.fsf@>
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
	TAGGED_FROM(0.00)[bounces-21869-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[mssola.com:server fail,tor.lore.kernel.org:server fail];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mssola.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31237186F11
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Sterba @ 2026-02-24 12:29 +01:

> On Tue, Feb 24, 2026 at 07:23:25AM +0100, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> Kees Cook @ 2026-02-23 16:06 -08:
>>
>> > On Tue, Feb 24, 2026 at 12:44:51AM +0100, Miquel Sabat=C3=A9 Sol=C3=A0=
 wrote:
>> >> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> >> index 02105d68accb..1ebfed8f0a0a 100644
>> >> --- a/fs/btrfs/raid56.c
>> >> +++ b/fs/btrfs/raid56.c
>> >> @@ -2110,8 +2110,8 @@ static int recover_sectors(struct btrfs_raid_bi=
o *rbio)
>> >>  	 * @unmap_array stores copy of pointers that does not get reordered
>> >>  	 * during reconstruction so that kunmap_local works.
>> >>  	 */
>> >> -	pointers =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>> >> -	unmap_array =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOF=
S);
>> >> +	pointers =3D kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
>> >> +	unmap_array =3D kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_=
NOFS);
>> >>  	if (!pointers || !unmap_array) {
>> >>  		ret =3D -ENOMEM;
>> >>  		goto out;
>> >
>> > Just as a style option, I wanted to point out (for at least the above,
>> > I didn't check the rest), you can do the definition and declaration at
>> > once with "auto" and put the type in the alloc:
>> >
>> > 	auto pointers =3D kzalloc_objs(void *, rbio->real_stripes, GFP_NOFS);
>> >
>> > But either way is fine. :) This patch looks good to me!
>>
>> I personally don't mind either way, but I don't what's the policy around
>> using "auto" in btrfs.
>
> So far it hasn't been used and as with all the other syntax updates it's
> up to debate and eventually start using it or not.  I'd need to see
> examples where it's better than not using it, apart from macros.
> In C the explicit types are everywhere and are I think always simple,
> unlike in C++ where 'auto' can hide something very complex.

In this case, I'd say we can skip the use of 'auto', at least for these
patches. Using it wouldn't help much, and it's more coherent with the
rest of the codebase to stick with explicit typing.

Also, using 'auto' in this case would mean to remove the declaration
from the top of the function, which would break the style for this and
many other functions from the btrfs code.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmdmDobFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZaMvEADAIABTslAFtMr6s58fDwEYFRs074BYaiTXckwVos4CvZRPedRj2vLLct0+
yn/zwadPZdxtN87SYuQqvnrmVHu9E0SnGLrvFtYjXv6lGv0v920sRKyuPzwEFW4x
hT+fV9J/bgueM1Jh1+769yp8whm7I3NJX8rIuR4IckB29pORYODa4jYg5wqtQ/Nl
y/sT4UR8vqEggOsLYiP/W2AI8mIXLOUOHj7D4zzcDErP1DtdwBXfHrIB/kVvau9K
XxRW4orQwsbmqvgVFRbQ9hzivyenCoYfusT1Y8hL9RLIUFcGaQPrdbiEW4K/Cpjm
TWskGlAqed6eMrlktz7Tjog4G3mp12fgcqM+5yHYLZ1c2W+6b1y3HkehOhHlllI9
MVoI45ERt1yQfXnnaHSb4twn+clZU3ZbUwgrxut1oSdW0xIGFPINBYj8iR8IyOx9
7cWrdUxjnGU9YcDiF9E59nkVbHwHDazJGskhZGUv4135joFRvETSCr5LXfbIaFmG
GjGUuKuZZyESE05cIBnX5oxHBquPJIprZ8UPzH+4TBuu7/97v7m7vqQDVOx6DK1p
a6DLEtySttVThc6jWZNb03GqoLZUOyhRUFZdEhffGLHLNTti2RfYocEWCh2qN8sn
rVU3uGUvFsS7HB+eCDB4N7wY827vJdLNg/5RheRWnVXLzzwyag==
=Trwz
-----END PGP SIGNATURE-----
--=-=-=--

