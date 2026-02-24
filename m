Return-Path: <linux-btrfs+bounces-21866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIQhJ5tqnWnhPwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21866-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 10:08:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12056184451
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 10:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4431730EBAD2
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5880036A009;
	Tue, 24 Feb 2026 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="jTPYAoL7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E9369982;
	Tue, 24 Feb 2026 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923872; cv=none; b=tdgRBh4nXkI3BRiXLMUt8RHuQkc+sbx2k9enBUKPyzumnznlcUCmqeoF2a/oxlT/Lx5K1Q1pcDSOljLCpi+BZEMErdV4Egli3e7iiwkecC01sDnDAI8y4b2fASy4YKSUFnWle1H4ix80RfoL8suDoKx+kr1dz6/CpuUPETZ8qQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923872; c=relaxed/simple;
	bh=tHpomfCkiWCoDfiNY2udnyFtpDuoWh+di3TVA309zc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e0ME+LqviNxAX/ICcYE6IRdy5xiwiIkj+420VfrIsoLTIdm8ZbSUNDxFaqfhWQ7uQYne67F9y8RqcWI6Xp4bxFvJtikxaxhJZySQRB3jxlGQhr7f8AL13vSAg7HfxtowUGf9kzRn4fQD55EAEMC2PNfmBZqJNPpPmgpJhdCr5pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=jTPYAoL7; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fKsGy2WXgz9vBN;
	Tue, 24 Feb 2026 10:04:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771923866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tHpomfCkiWCoDfiNY2udnyFtpDuoWh+di3TVA309zc0=;
	b=jTPYAoL7ETwJxOWnrEhl5xpS5QQj9+6nE3NFeSX7IzgIg5SFWoVspbrh9YevwN1UMZ3pXg
	cnkC2qKcNtSr0dw1FyMJNJ/Z1vpTuQz4rz+zQ74Jz9nhQk6ALlzYcOpjm3yTzjQhiE9uVH
	wnDkD/WrUgI7Iu2ABxTV6GmScWzldgtDZ0+nb7I/No1C+tImTlOh5a0hfoWbOLrU2nBbPd
	G859Qin+njleZ4OxL3Kd3CMsFeo9sh8mYfc8wpbbF1t/TrxTrUyUxFFzIMkAQxcouhPXTo
	keV0JABDESn6tqZx5zB4GMLFj4jPNH0EFLUSDX3KkjWFX5f59JQ4R1OuD+QE+g==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,  "dsterba@suse.com"
 <dsterba@suse.com>,  "clm@fb.com" <clm@fb.com>,  Naohiro Aota
 <Naohiro.Aota@wdc.com>,  "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "kees@kernel.org" <kees@kernel.org>
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
In-Reply-To: <c1394e2e-fa7b-496f-9fb2-3e88e9d42044@gmx.com> (Qu Wenruo's
	message of "Tue, 24 Feb 2026 17:24:04 +1030")
References: <20260223234451.277369-1-mssola@mssola.com>
	<076d767a-48f3-4c71-87d5-5c304513f9a8@wdc.com>
	<c1394e2e-fa7b-496f-9fb2-3e88e9d42044@gmx.com>
Date: Tue, 24 Feb 2026 10:04:22 +0100
Message-ID: <87ldgi5x7t.fsf@>
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
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21866-lists,linux-btrfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mssola.com:dkim]
X-Rspamd-Queue-Id: 12056184451
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qu Wenruo @ 2026-02-24 17:24 +1030:

> =E5=9C=A8 2026/2/24 17:16, Miquel Sabat=C3=A9 Sol=C3=A0 =E5=86=99=E9=81=
=93:
>> Johannes Thumshirn @ 2026-02-24 06:32 GMT:
>>
>>> On 2/24/26 12:45 AM, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>>>> Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
>>>> introduced, among many others, the kzalloc_objs() helper, which has so=
me
>>>> benefits over kcalloc().
>>> Namely?
>> I didn't want to repeat the arguments from the quoted commit
>> 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family"). Namely:
>
> If you assume every btrfs developer is aware of all slab/mm/vfs/whatever
> subsystem development, then I'd say you're wrong.

To be fair, what I quoted comes from the git log for that commit. So I
was not assuming a subscription to any list or following of other
subsystems. If that's how I sounded, then I apologise.

>
> Thus you should mention the commit (which is not yet in our developmenet =
tree),
> and at least have a short reason on the benefit.

Regardless of the above, both you and Johannes bring a fair point. I
will expand the git message just so people don't have to lookup in other
places to get the full context of the change. I'll do that on v2.

Thanks!
Miquel

>
>>
>>> Internal introspection of the allocated type now becomes possible,
>>> allowing for future alignment-aware choices to be made by the
>>> allocator and future hardening work that can be type sensitive.
>> Should I put this in the commit message as well, regardless of the
>> commit explaining this being quoted?
>> There's also the argument of dropping 'sizeof' to be more ergonomic. To
>> me, though, and considering how these helpers have been applied
>> tree-wide, I see this change more as aligning us with this recent
>> tree-wide move, which also affected btrfs (see commit 69050f8d6d07
>> "treewide: Replace kmalloc with kmalloc_obj for non-scalar types").

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmdaZYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZSeUD/9rPbZMg3dc2gnlio17gJIVh2Wkq73jaazAALZmKiESrqd5s05R5Gganizx
ro4EMApPHB4C3wOUhaoAFnaSaewvIeUuTWe3ToBKrQMfOMShFSFDT11D+vc8n8Ny
iqOUIE4C5vcX7oJ4dhQkiM6H/UsVGW0VMSilmDjbJmFA40rFJkeUsJwCP93LyXgA
QokfB5OWJzKTJ42CTidnsSQBtQp2SfiHbZTfbURE2Xggj0qGGV+pi2m68gvNErru
0chlrbveQ2ew1XwsTvDwGf3xER4QO1QFkcTIV4oBHKL49JyZGp+pOU3ZipQI0P4m
RZtJYbah01yr3DqqlhgVKSZYxSHuIKQ/LF/RoZtW5UwG9nOpVlUJ0zq9lwhsTaSI
U+eQHB7yf7ws7z2o3v4vyS/n5yTqKoENyUyhpINmJYNEY23Y1+j4hG+9j8h0HnAU
IFAd5d0Nep4G3k4dj6tH2p/DZcG34jwMIJXvMX/Eh0DML5+543tbTuC0OBZZBhZU
UWqfBJWi3ztmdCWalM8009r4ehZrm2MUp6z1DE3+0mOIG6pLEUHA590LeYtrUSs/
Izgl3HaBUrafCp4qgZHhG+vk+dMhfCJq3yVrLDpH1toZ5oFIPHyIa5ryzY8CVNJC
Lz0VGtH2+fNgPZEbYV3NaQS3qv8D7YdYVgImV8I6bLmuktMDOw==
=av7j
-----END PGP SIGNATURE-----
--=-=-=--

