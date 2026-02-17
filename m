Return-Path: <linux-btrfs+bounces-21705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KyJK8pPlGktCQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21705-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 12:23:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E00814B4CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 12:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 465573008C34
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 11:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73477331A4F;
	Tue, 17 Feb 2026 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="U5nIpMZA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BE331A4D;
	Tue, 17 Feb 2026 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327429; cv=none; b=Ft7efsahtKXp2iTPYm6zyP0RH1u39z1Nkp6JXk1rtQDC5+dDCFfs+5vXbaOHZUMrAcn/AEjSHbyI/x4kAdivQP6tlACYmQCHDQvFUyNQAQ+A87S+eYI1pe03AsC7SGsRIqZaxAqePK/Cit/iu1dlGN8bpLjOfcdRy/hH2hdCkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327429; c=relaxed/simple;
	bh=uu6jJB6mPmKQK8NVtrGq1bWgBtkCzHmK66GqRXZD7hY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=movJaoUjau2emRlGKIQmbl1tvu84yzk79qOARcy2wlpA2wLjqxWh8lLKuUcb/zWGNn6zJmxeAQZDqAlVuLgld8HvpJaa4g14b3XFM9cCu4XGm8h0opXoONxyyN5qfA3AIi4E9IprLjuIQ5lbtqzv5dxb2A3U5PR3hkHXFvObBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=U5nIpMZA; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fFchp2VTrz9t59;
	Tue, 17 Feb 2026 12:23:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771327418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShkN+rtYyNn5EZP5rydtE4Wag5gyfvv/ddzaEOJta6o=;
	b=U5nIpMZAzUQwA5n2YYoaOhkjQTpci97aYBlU+xDOE8ozlDS26VnW8I7WbtC+eY3Hjlm6ls
	IKJXUe7HXFJXBGX7jR/tk+EYWqbJjcqqUKw9BrTFKJKABmBKtCToGvOofjGYFRETM9TdiD
	/TlumAfytxzB+B0DnUVa2mZwMvZc8SRTrVN2dZtPwoNj8Gc1lKeuC0o9QTaPhBC+2IFsbo
	a64LHWgEHLOh1UkvcQmdP1z3DQbsaAsuMM55hNrpMIiVMvY2dLl2gsvjYNiUW+c4XLUv5K
	+GYkqP8GnhiSxif/uufeKtCJoVhgvrW2khgs83GMZLDoNjwpXDufox72ni3Zxw==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Burenchev Evgenii <EBurenchev@orionsoft.ru>,  "clm@fb.com" <clm@fb.com>,
  "dsterba@suse.com" <dsterba@suse.com>,  "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "lvc-project@linuxtesting.org"
 <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] btrfs: remove dead assignment to dirid in
 btrfs_search_path_in_tree()
In-Reply-To: <CAL3q7H7x3ZRYXBkMjyA1UihWr8FUz4NQE1nR+thc9Q3g7rwd3w@mail.gmail.com>
	(Filipe Manana's message of "Tue, 17 Feb 2026 10:53:14 +0000")
References: <3f1d7281b3004c6baa24a531b409c466@orionsoft.ru>
	<6994405b.170a0220.24287.89ffSMTPIN_ADDED_BROKEN@mx.google.com>
	<CAL3q7H7x3ZRYXBkMjyA1UihWr8FUz4NQE1nR+thc9Q3g7rwd3w@mail.gmail.com>
Date: Tue, 17 Feb 2026 12:23:35 +0100
Message-ID: <87ikbvtxzc.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.35 / 15.00];
	SIGNED_PGP(-2.00)[];
	INVALID_MSGID(1.70)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21705-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 4E00814B4CD
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Filipe Manana @ 2026-02-17 10:53 GMT:

> On Tue, Feb 17, 2026 at 10:18=E2=80=AFAM Miquel Sabat=C3=A9 Sol=C3=A0 <ms=
sola@mssola.com> wrote:
>>
>> Hello,
>>
>> Burenchev Evgenii @ 2026-02-16 16:16 GMT:
>>
>> > From ff2df73ba6483b0dc67b3ed89d2a43c49f1c2eb8 Mon Sep 17 00:00:00 2001
>> > From: Evgenii Burenchev <eburenchev@orionsoft.ru>
>> > Date: Mon, 16 Feb 2026 18:39:30 +0300
>> > Subject: [PATCH] btrfs: remove dead assignment to dirid in
>> >  btrfs_search_path_in_tree()
>> >
>> > After the introduction of btrfs_search_backwards(), the directory
>> > traversal state in btrfs_search_path_in_tree() is fully maintained via
>> > struct btrfs_key. The local variable 'dirid' is no longer used to cont=
rol
>> > the search and the assignment
>> >
>> >     dirid =3D key.objectid;
>> >
>> > has no observable effect and is dead code.
>> >
>> > Remove the unused assignment to avoid confusion and silence static
>> > analysis warnings.
>> >
>> > No functional change.
>> >
>> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
>> >
>> > Signed-off-by: Evgenii Burenchev <eburenchev@orionsoft.ru>
>> > ---
>> >  fs/btrfs/ioctl.c | 1 -
>> >  1 file changed, 1 deletion(-)
>> >
>> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> > index a6cc2d3b414c..292043b11207 100644
>> > --- a/fs/btrfs/ioctl.c
>> > +++ b/fs/btrfs/ioctl.c
>> > @@ -1708,7 +1708,6 @@ static noinline int btrfs_search_path_in_tree(st=
ruct btrfs_fs_info *info,
>> >               btrfs_release_path(path);
>> >               key.objectid =3D key.offset;
>> >               key.offset =3D (u64)-1;
>> > -             dirid =3D key.objectid;
>> >       }
>> >       memmove(name, ptr, total_len);
>> >       name[total_len] =3D '\0';
>>
>> I would add a Fixes tag with the commit that made this assignment
>> useless.
>
> No. We add Fixes tags for patches we want to backport to stable
> releases, things that fix a problem affecting users, like functional
> bugs or performance regressions for example.
> For cleanups, removing unnecessary code, we don't want a Fixes tag, as
> that will trigger unnecessary backport overhead.
>

Got it, thanks for the explanation!

>> As far as I can tell this is commit 98d377a0894e ("Btrfs: don't
>> miss inode ref items in BTRFS_IOC_INO_LOOKUP"), which made the update
>> inside of the loop of 'dirid' no longer needed. This way it's easier to
>> track from where this was no longer needed and whether that's really the
>> case.
>>
>> Other than that, and taking a quick look at this function, I can already
>> tell that the 'ret' variable could be initialized to 0 in the beginning
>> and make the last assignment to it (just before the "out" label) not
>> needed. Hence, while we are at it, could you also remove that
>> assignment?
>>
>> Cheers,
>> Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmUT7cbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZU3QD/0WaUk9lwXHM6M0VSJx2CQ5dywOVFyoMbc7YSTG9Oz6obgUckLvdhrtGCx1
oKeTBphJpIj8UG5aL4/uZY6qJaXRmpRPOsSge7WvPEvamKad59f1Z+ZRBbXnBKco
7KI/k7Q+yjKTyU+Yre71sG+WsHtp5ZBC0M1fczgmwjAll1mJZ3iur17TYpSW2Hzo
5da5BUahm0iMFSzCVnS8Etf9TJM4iTiIzJBcffFMD616p+sdhbTVLMyeJWnb3p6N
Qj4laT5lSgDdY6Zykz6bbVEOf+6dC7tubEyYvWf43IbVxmqJRcCmdi9U3J22sceU
Q/B9IvvMFcjtL0elEzX8slLKK2S4LONT/rfAn6eCLxYhNF2UGm6jQQLkrdHXVzB0
fDbyv8xl/wBIeDzZrOknvDkTZ0Ot/weQY7dhkBhSBBpY8UXu+Ow1m4A+JJ5CaY3a
RF0lpqdPxzECcU6lA8bw/1xHAuTsvzq9t6fatj32k8OMy5oopesNgG66+WK2iscw
5XqgYqDNKxzgoqtGRKfYFEWJEBIfZx/AepopK0aoncZijRPmSZyiixUnNdIfav6W
RPUS0tf6zKU1CNM3NTGFillAV0AsNdLrcO9dib3xemI+RfsFd2dxZ8if9iwkEIBd
qxFMWtT0X/tUCY8BfIIKWknSNAvgVXDMADXwbRBi9OwNJmz34w==
=+O/0
-----END PGP SIGNATURE-----
--=-=-=--

