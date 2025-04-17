Return-Path: <linux-btrfs+bounces-13147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDC9A92C68
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 22:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE53F4A2462
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 20:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7477D207A34;
	Thu, 17 Apr 2025 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OyOC4fMx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6935948
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744923254; cv=none; b=jUE7MQvXC0mlPG3wsCFDhsLYhwrwHkLVy0ngU2rJLmd0bHfhV3alKFuEYUcsdSn2x+1vb8PBtj9GAd0ZyCiMoR/1NLOcj84IaF45sXgcDhBsugd2tEjPkYm9Puf24XfAOW7kvqTwZG8hj+zzWVBvvurIyCPnl3I5j4ixpM5RfB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744923254; c=relaxed/simple;
	bh=RLR9GwH9k5SnI4d3cYc7XsDX/hBpHN5FrWAiIaUVN0Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R7CgcJXwPtPHcMbNoBFz/pMfPe+byaDckhhDKIG3gQMq/cHXu/vTXYg8KDtyDMUdwp7/sHwkvUasF/wfSk3PxOwpxSySxpNKsDd253Jgv/bexTLWz9bvcMHIFQx5YtnsZupG1nGgBSLlzRQjbwg8eyQrB5fZ+RrYq96oPCpgZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OyOC4fMx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:Subject:To:From:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=eyIYzbvH3z2rd6o/3SgdUU+pryySfTxvN5TV8o481bo=; b=OyOC4fMxKVBmx7Y8ijowElvgkH
	AUWa8PTpVXYh5Ir+7YOI2bsNO1ZWR2+5CXbBjSUXzSTwz3ClGhZJsmehEtJzMm4FGXakmwhhxyTeI
	Q4gShxzTWKRb70suJlKxUO+AI14MhUIa7ebH8Zyd3zecPb4Gz+Wki9gfpoKpJC/oC2CMCY0Yc8D3x
	uvKKZ5w9xkH2XCfjO0JxVStEQBBVek09DlYK+S8Vtcp35DPziXE3QgmmTp2odEUvgdwbA4feTwb9j
	i+YWxeAR86KLSI0Qn23fgBifzHk0FWoGT8ukXxP4u4P5/Trjld11ac245NCG1JkaPhloyH8wP2uRi
	w7ah46Ew==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <sten@debian.org>)
	id 1u5WFG-005q6z-PR
	for linux-btrfs@vger.kernel.org; Thu, 17 Apr 2025 20:54:03 +0000
From: Nicholas D Steeves <sten@debian.org>
To: linux-btrfs@vger.kernel.org
Subject: Does Linux-6.12 have the missing dev = single/degraded chunk bug?
Date: Thu, 17 Apr 2025 16:53:53 -0400
Message-ID: <87plhatspq.fsf@navis.mail-host-address-is-not-set>
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
Content-Type: text/plain

Hi,

I've started to review documentation of old bugs and workarounds for the
upcoming Debian 13 (Trixie) release, and I'm wondering what the state of the
single/degraded chunk bug is for Linux-6.12.

Specifically, I seem to remember that the users/sysadmins had to resolve a
raid1 with a missing device the next time the system rebooted.  So the
reproducer was:

1. Device disappears.
2. Reboot occurs.
3. Sysadmin doesn't notice degraded raid1 (or raid10), and btrfs writes
profile=single chunks.
4. System reboots a second time.
5. The btrfs volume is now permanently read-only.

I vaguely remember that profile=degraded chunks may have been introduced
some time between 2022 and now.  Does this mean state #5 no longer
occurs, because profile=degraded chunks are written at state #3, and
that a sysadmin can simply add a new device and rebalance?

I also seem to remember that there's a "mount -o degraded" state, and
that it's not automatic, but I can't remember if it's a state that can
be recovered from with a device add and rebalance.

Finally, are raid1, raid10, and raid1c3 and raid1c4 all comparably
mature at this point?  Particularly with respect to this old and surprising
"gotcha"?


Kind regards,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmgBamIQHHN0ZW5AZGVi
aWFuLm9yZwAKCRBaiDBHX30QYfpsD/9SONxLzq39gHIeCLGGfzt2dw/06eNrLuW9
LwZ7k2JKtbhoyLmfUnm4KiLQVUx5TNZ7qLTB2Vs7Xs7iscnAqTrPCH82FIqIMKiQ
sQ36ntoyRtmiuMrXm/jzzsM+1JRpzizBsnoTNmxdzXUHzf4fSkzfXHNbE1IaVtc+
vwM/E7ijkq47rngSyWXEsnmJ+7HPBXOgCHk61/xj2joZpOy8IYy3898UDmFcWiDO
TdR6shxyCBSJPqPznCfLpxoSWH6H3Oa/AxvECxPXOxy28pzD/ucc0rFo+142abn7
QEmbC0MVfT1vzm50esAs9iLjSTySapJOHtHkfZpO2Ph6PrGzOdw4p2kBPTVJPdX9
qvq30JUq19hgECrBEr2TQQ+cWuR0Jo/z9QULWJaLGhBuCMKj9qVFSY0uPosPso2z
GafYet5HZguWnjc9dM/n+ST/qLM1ls/yXUD8swMhu1VlxRDgHLBkVo2OMXhSgOQJ
eGzy3//UwJ3E7j0oy3I5LV+LivnGEMqnSwC7KXPRU8myvfRUmLLZr6WFFsG1B+DI
OTSfyjipSj8gfOQ57ZPSREtfb45eZkln7GmFobExYN/0JJqRpoKoHWrzyqfV/VaR
I0hevA0ffSSJoN9Dmsmz173GAoxjIlN5OXPKy+1V0ZsbDvI+y9OUh2OGj4oC6NcQ
LXqHP26qlA==
=gZ5W
-----END PGP SIGNATURE-----
--=-=-=--

