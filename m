Return-Path: <linux-btrfs+bounces-10648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAEC9FD7F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Dec 2024 23:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D68B3A2584
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Dec 2024 22:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EDE1F8923;
	Fri, 27 Dec 2024 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Cwr3DTI/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C6139579
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Dec 2024 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735338339; cv=none; b=rngFpb4PRsnahiw1SbspvshipuhZHUKueCXWfr8sqFcj+YtxK1bjs4ErFh4NGuxGqWXmGF3TMrb3LHgmBsM8DD2aC8HKe20pS0TKDwQfzxscq1qEsa/+3LW3DXtHkrCe9PbA2QrYX3HZ63rAVpclNP/7aWA+mFQo8+1ZOG0U9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735338339; c=relaxed/simple;
	bh=mLmKQOJNlkjAebByt1FpJ88N0VjcCs4lq3MjGGxFS3Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=iGZzg3d6NscQ+OkJAPfoEC1U6QWVdhb0A/le1ynY+433XJpd4Q9ER23p7KM0BCG4lB4/Wb5BFwJ47zCXikaB+ZWPgcKnU/4a8clV86I6D6d2Tj9awOzJ1MbAcStuFafSNYYzZGrW91R5n6xrJipIKEeHX0sLWN2UZTM68rT1k0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Cwr3DTI/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:References;
	bh=/LfWfh6a9Lxyywx4jlliTYUsAkXFmAvMeGodRgh+ozs=; b=Cwr3DTI/39gO4QBb69RpBcwtY6
	zLJSnJ42Gx9f7/K5+m75IfSHCiZDoH5ZksnrSWkCZzRrAF3+KW79OSeAe6qlgfzkB1u61ye6Zu2ww
	HY/bq0N69gcMdZjsxU9gbMTfobnRGRcIXp9yX1v+pPwcNS/8txdxVBe8QfBsJQ0gFur6v/aNK23qe
	ntwUcYP23MoBuYFT313as8UtZcfxUJ33PikLPulETxU/olV5DGs7oN9KhaDQwayNpxc73h+MTBzxv
	3hs0lKWbHCjPat+1eoTZPLtyW73bPWAhL2ssnwJ180pqPUdMpdvyEPxW4jSeLF7Pd8JcoSoaltCya
	NJ+JURgA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <sten@debian.org>)
	id 1tRIlz-003nUi-6f; Fri, 27 Dec 2024 22:25:35 +0000
From: Nicholas D Steeves <sten@debian.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Brett Dikeman <brett.dikeman@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: corrupt leaf, invalid data ref objectid value, read time tree
 block corruption detected Inbox
In-Reply-To: <cfc9177b-ab53-40c2-b627-0045e9348938@gmx.com>
Date: Fri, 27 Dec 2024 15:25:32 -0700
Message-ID: <87wmfk2277.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: sten

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qu Wenruo <quwenruo.btrfs@gmx.com> writes:

> =E5=9C=A8 2024/11/27 09:39, Brett Dikeman =E5=86=99=E9=81=93:
>> On Tue, Nov 26, 2024 at 4:30=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>> Inode cache is what you need to clear.
>>
>> Brilliant! Thank you, Qu. It did mount cleanly. Shame Debian's
>> toolchain is so out-of-date. I pinged the maintainer asking if they
>> could pull 6.11.

I've salvaged Debian's btrfs-progs package, so it will now be kept
significantly more up-to-date than it was in the past.  6.12 was just
accepted into unstable/sid, and it will migrate to testing/trixie after
Debian 13's "alpha1" installer is released.

Regards,
Nicholas


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmdvKVwQHHN0ZW5AZGVi
aWFuLm9yZwAKCRBaiDBHX30QYfg+D/47ypCyxLP1/0Ig1qKCsxLXzycwBpmIFhnp
WgG9ZcHvj2W8Sf+LPBRPKkfSOWD+tAEUZSOZ7CJzEzeN+RuIpiP9ILl6q/kBXWLj
QTLETr620JG2Gk/FUx2tpijDFr4gxEGBZ2O9a7wB5hjmC5D4W+Tj/QDRiAc7fNL0
AIQ1r2PRKvbYTh7Fwk72I0KiwekpRsnQShVnQHJicxoErfyCeQstsYy+x25ccfS7
YC7yd5ALlp2Vm0kpRDoVMP/ognTKmKdsEzfim4Dzi/YnmgkUX5R/5VK1e/nWUOLT
imEyF+Vrq0rjZidXh6knOuaemrRfbTKZHm+uZ/t2dDlFiG7ZaXCOFT3XvtN0cQJn
F2/2aS9hRfvg0G9dABBVEYXQQcrc5EmT16AB9MefUwD0hlasuVYV2N2bdyzNaJyv
qigVxf3kLnPWulgA7euMtE45r7+ZEw4QFSSIO00YyeBWSEUMD3d+a5jrKnko6Obs
5re8lwCqVrwhlBpR9O2AJUhpoKWv+dntgxHjhqyCAEudwdVz52X3ovloZ2EmlvKe
dSmhoMVfF80xIx6jHSzyAR6Sjm6c3cOC+LV4o0huqJaREZzh5Gs5j0PtauaW4H1K
z6VgIpMmA1QiF3foPYRl+ngfTRHuxa26bpad+io/AVb9x+xQUqADQ1RDzLqZdgkj
ON/1j13SYA==
=G5Vi
-----END PGP SIGNATURE-----
--=-=-=--

