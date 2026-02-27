Return-Path: <linux-btrfs+bounces-22050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AukHBw+oWnsrQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22050-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 07:47:56 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A5E1B376E
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 07:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6E5D30E43B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 06:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9639F389E04;
	Fri, 27 Feb 2026 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="cbQRgG4r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B82EBB99;
	Fri, 27 Feb 2026 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772174847; cv=none; b=V/HHiYU2AaNuTyQIz2nQuIqMySsrH+EpC6eij3ZeHUW9x2MIPqJ9xZKUYLFeEUNkM9Cq887HY7Uy6gOOgPDKunhyTQtpQoLSfVQ9F8mN6jYCKrj9+m7eBAy13+NPhoh7/wvncXrC2mDiVi1jB4cL0xKGm9V4nMEICNmycRYkKqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772174847; c=relaxed/simple;
	bh=gWDjhttxca+3AOv05NSygKj/cDeQl4vUQT8eMuNaeNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LR/Zz97m1Vvntn2XEK8HIZL+EuQ28lFiSd+ksaF69lQWsVhnIRwlkdFMi6ptzSf+So8Hi5Fu307kTW6HxMGDBI3bX+04UpCZJf/J8YvGrSFM8kkcieu68F9Ixq0rMS/D7MjTfsHUpT/jL8V9YnfhW9P9ADMAJsFhaviBbsLPkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=cbQRgG4r; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fMf5H5l7Nz9tlM;
	Fri, 27 Feb 2026 07:47:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1772174835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFPU0MwuAwLOLyTjI3MiI8XRAPiQoVxV9wn5Tk5PYMI=;
	b=cbQRgG4rcHtnSO+iyIugnYUsrcI5yeKhLiSeX6AHIvlhkJ8ddLIglYdzFGpuQ2UgWoDNrS
	G1C1FceiCDJiJUK+zTMLiiV59qcCo/XKTBT1KCA3gxwk3a6e2y6PgwiLa0FnQz2LBMmCmc
	i/MDTWoxwsEPTtVRZo+6ToVAew6TtR9/bwB0+NXklsJRnHG9EllbSfndcggg5Uk/bvmwiK
	NRx4Md7aOhiO982IiyU5y9clzXLONMtPFtli5NRqF9WnikHpMaYRHMPeMVhuOP/UM+N2+S
	cqfAxzLnsk8B3E+h4TtSZHSH+DpnzlhJYNHUdSXKptgB+f/FhLnKAzKyEKgpFw==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: David Sterba <dsterba@suse.cz>
Cc: dsterba@suse.com,  clm@fb.com,  naohiro.aota@wdc.com,  kees@kernel.org,
  linux-btrfs@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: replace kcalloc() calls to kzalloc_objs()
In-Reply-To: <20260227002727.GJ26902@twin.jikos.cz> (David Sterba's message of
	"Fri, 27 Feb 2026 01:27:27 +0100")
References: <20260224214544.562283-1-mssola@mssola.com>
	<20260227002727.GJ26902@twin.jikos.cz>
Date: Fri, 27 Feb 2026 07:47:10 +0100
Message-ID: <87a4wud6oh.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.29 / 15.00];
	SIGNED_PGP(-2.00)[];
	INVALID_MSGID(1.70)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22050-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9A5E1B376E
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Sterba @ 2026-02-27 01:27 +01:

> On Tue, Feb 24, 2026 at 10:45:44PM +0100, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
>> introduced, among many others, the kzalloc_objs() helper, which has some
>> benefits over kcalloc(). Namely, internal introspection of the allocated
>> type now becomes possible, allowing for future alignment-aware choices
>> to be made by the allocator and future hardening work that can be type
>> sensitive. Dropping 'sizeof' comes also as a nice side-effect.
>>
>> Moreover, this also allows us to be in line with the recent tree-wide
>> migration to the kmalloc_obj() and family of helpers. See
>> commit 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for
>> non-scalar types").
>>
>> Reviewed-by: Kees Cook <kees@kernel.org>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>
> Added to for-next, thanks.
>
>> -	buf =3D kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
>> +	buf =3D kzalloc_objs(*buf, map->num_stripes, GFP_NOFS);
>
>> -	pointers =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>> -	unmap_array =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>> +	pointers =3D kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
>> +	unmap_array =3D kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOF=
S);
>
>> -	pointers =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>> -	unmap_array =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>> +	pointers =3D kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
>> +	unmap_array =3D kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOF=
S);
>
> I've changed it to the type in the above cases so it's a direct
> conversion that only removes the sizeof(). For the rest there are no
> strong preferences so we'll keep it as is, and my preference for new code
> is to use the types.

Got it, thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmhPe4bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZWNGD/wN2UGCfVEHe4SoGIM+3hPbS6aKTwg+773VUXQuojLnzfQGsKfUKLOQT9al
Mdnb75zOv+abPusMox2yL38wyRp50dNLf1zZXxIl8jqFe+xlBLrTjZ2Det3A9dsM
H+OdnFfycHPsnskTVHdtOSaFvl69qEW5gHEOmTk2qlZ5TPAifyTGzQhKTc4eRdEJ
wb9IjsAAVKG7E4GRdLVQfXMPhGpRacyJLv1E2AOLMJDj51ACn0ZRqOuSIh0i0tzN
9HkG2P/TPm+QaWp4UP9IJpGErnYqHJIZ9gj8AEljJTkBjjl4lX23O69DQgdgPubw
EAIr+GHZgrLCkR00+JD8jD9wVrHNZsQlP+d4M9VrNODe67JL1f8xwMArtrFoCEwP
fEoLhYDO7ZcQCHIVjmZIBCVv6sRJ/GZCG2eXOC+tNnfcb010Rj1SPBRVCWfnQccv
EHx4vUxaSqaylpSXKs4K/XGWgTMof7mWE5McNfgkv6VJ6K7QlKQEYL0zU/X7h23j
qXmH/WNf1zm3T6Oc1pH7Rd3wB4PCc5p+UPSkfavlwo5k2Tm3moK0U345rs9io9Zy
tprRwQdCsJx1SNmEHqp299Wy3QmJhmOflaIfElBIpG7uvmKVAAxLh3TOMfUdpjiB
nZs3W9EeG7dhsvfKjkhFheTQ80plK4JgVIRHEoFVP0DB0/AwpA==
=OlZi
-----END PGP SIGNATURE-----
--=-=-=--

