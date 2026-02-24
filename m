Return-Path: <linux-btrfs+bounces-21860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONVzJFFJnWk7OQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21860-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:46:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F90182875
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCA423057E85
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 06:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA081DE4FB;
	Tue, 24 Feb 2026 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="YE1Qjsmc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862B4199FAB;
	Tue, 24 Feb 2026 06:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915585; cv=none; b=rimHWWbscK+Et58VGNSaK3QXfHVmiSykDh+eF7g5Bflb6PIuEqY6GXuKXW70hOPu4/xg8fvBFBwvjc/G+BA+0+5Z5JJW/4lLN8JlsvjRGJ1szSRLUS9od/Dc+O6NwF8vCdtb1dM+tuJctbcs0iz3oz4m0b8GvJLE6sk/1kozi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915585; c=relaxed/simple;
	bh=IvoCD8TSqm4D98nLkP5WlFF44UBR97a0vzFXDHdBsW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbygMdsn73k/H+17yTwuC9RemDcrFTFaxNlXwwTGZGei24ntudn1H+lZk7mxphchS/KSdG/OD1g4oy5B6vmpjpxUHiWGtHfYjfM6N38MIRCkW5nsVFa776He+m9kNVCA2aDKc1hi9niG+0P62I+OutYEbBPFNP5B1vI8AfGiDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=YE1Qjsmc; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fKpCZ5mDRz9vcw;
	Tue, 24 Feb 2026 07:46:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771915578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IvoCD8TSqm4D98nLkP5WlFF44UBR97a0vzFXDHdBsW0=;
	b=YE1QjsmcNvE0b/yiB1kX3c6K3ell4SeHuqFLcYhyXU7fUSUWDY7urT6T1dFlP6qIEbCwUL
	PR7jItXoUP81yJBgvzN/Qnpc+pt8RFZ07E2/+Kl5W4FUar1+V12S9ClPvWDxcqYZwzkgA3
	ISwIQb3F0z0YkBoXaN7M6sLNqJ6yiwbbnq7jzVoGiBVZS9IXJxH5rkxoW+CirF2QH+gmjf
	2nZ0WsajyWwUnzza3XRYtbwvTQfEnt+Yagmy4o1lLIcC4+Fjh3VVSbnxKE5N8/LqwmF7FC
	xwXEXmMsDv1LO/lemMQTdkcEhRTmRnZC7JS73ZufVuQ5LIRvSIPRqjUcNRSdGQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::202 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "dsterba@suse.com" <dsterba@suse.com>,  "clm@fb.com" <clm@fb.com>,
  Naohiro Aota <Naohiro.Aota@wdc.com>,  "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "kees@kernel.org" <kees@kernel.org>
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
In-Reply-To: <076d767a-48f3-4c71-87d5-5c304513f9a8@wdc.com> (Johannes
	Thumshirn's message of "Tue, 24 Feb 2026 06:32:39 +0000")
References: <20260223234451.277369-1-mssola@mssola.com>
	<076d767a-48f3-4c71-87d5-5c304513f9a8@wdc.com>
Date: Tue, 24 Feb 2026 07:46:16 +0100
Message-ID: <87wm0263lz.fsf@>
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
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21860-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[mssola.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 03F90182875
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Johannes Thumshirn @ 2026-02-24 06:32 GMT:

> On 2/24/26 12:45 AM, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>> Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
>> introduced, among many others, the kzalloc_objs() helper, which has some
>> benefits over kcalloc().
> Namely?

I didn't want to repeat the arguments from the quoted commit
2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family"). Namely:

> Internal introspection of the allocated type now becomes possible,
> allowing for future alignment-aware choices to be made by the
> allocator and future hardening work that can be type sensitive.

Should I put this in the commit message as well, regardless of the
commit explaining this being quoted?

There's also the argument of dropping 'sizeof' to be more ergonomic. To
me, though, and considering how these helpers have been applied
tree-wide, I see this change more as aligning us with this recent
tree-wide move, which also affected btrfs (see commit 69050f8d6d07
"treewide: Replace kmalloc with kmalloc_obj for non-scalar types").

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmdSTgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZYRlD/9zXNYGxQ2Ta4yFn8fj6t04r6wqevG7XWeOIjb5o9VazrmHNB27Zy/yViap
eyb6TNF4gkYSb9l4RWb2MPeQH6cYjEZUjGkf5GKsqgDsw/Zn6qvdUzh6Caiqdw14
C1opcnzgFv+2w8VSM5bdtroRMTtJlFLhMlF59Tyh0cARs1EWIh0uoj4bAzQmsKB3
xEQLYgFrO9wRg3DrVB8YDOudVHQ6pFYrC3YH/X+l/mlXKsDTaFwtTJ26Gc37gXmm
9htRsmomCGUbBz4PvzQKakK+6Gxs3qwy9885Ur4I7Bcc2XvA5WyUsxO0BeDavb7I
HUgeYRQjhlu6CNz5cmh1+980iUSgTrWUUR6p3T+ylPSP8n4zrmyA5kqQX4F6Z3Zi
b1SwRte5VxHBvaGovAX0dCF9nNw2JFcjIQXdzi/VstOtp3KUemaVJK5rwzIdO70I
dJYKA3kxINTSpDKZNyp/vGnTNfMs9Lw4yGfl0BL2+Y7SiQe0am2jUaeHg+kaq7w2
ra0tTSYAUL+FzIi1gbe0bpV7wg1vcDL/N1ffJpCinCAI+x8520uzRYQZatVetCeK
HJsOzPCVgjOxMCbi8THB2umNelUdxGHdhIGUNaL0G9NU9kDie5kO/JmDsVjHiGtl
OQNIn68340/CfUoUvEq5yWqmZDed26764W2fwnsnYQ7FzG/1ng==
=GiVY
-----END PGP SIGNATURE-----
--=-=-=--

