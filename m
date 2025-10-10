Return-Path: <linux-btrfs+bounces-17615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E63BCC3D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E87F1892ED9
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B737265CCB;
	Fri, 10 Oct 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DeCXF8Ik"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC4137932
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760086568; cv=none; b=mdEGSaKa8/jJMIug9L964gxDXpwE5MDX/Z7uARL+YBpxeIOa0s0a746H1mPc1u1jxfqU8HX3QciCz0lNLnoXlUf2XETeWPH63d1hCTodbpFnvisKu7y5Sp2msXjMrH5+vZeIhm87cLPbhQAtRaVmTLrttYvBMoz8qyXl747EQEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760086568; c=relaxed/simple;
	bh=3RTVuBKSRwwe69oH2VgsiN5+BqWYhy7JUmr9dbyfZIo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omf2vTCiG78H2RomGjWaeuKkDG2jnOQkbSOS4LS+d70t+MC3z8HEXl89GaB/H0PfJl+Gf9ErmxbMo+VPx09jRIuiww/if4Sw0y4TdUlG6kag5tiMMl4POT6/z/ojrpi5oiomGoBj7+cfnTUblO+TU17jBapyE+AghRbP6gxiv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DeCXF8Ik; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cjgZT4zBnz9sTZ
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 10:56:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760086561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=zUjYr6jIEJxt2jlFHA9KB+DfIbjgTKyH2mgKXfoVcfI=;
	b=DeCXF8IkN5jK3vPEXSj8OUdNg1JxsKMHi0Kj7amHk/maBVoyV4gNg2LscXAIqIfxS1VAxZ
	QcEdRM4vV3poKJKn7/z7w0jS4NZeZdJGUyQ/Lt3Ejchf2M9PB7eN9NURtyqrTAz/+FhVVv
	2JfrNOrOqTvr9gKbTPx6qWnJDhcymxOFUyfpYVJs3pDhunpjXJw+wHbsFugUvvkAabd/Tg
	0Jl802ay7b1nJ+SIy15Jc8abqCMi5o4B8n/hG+j62ynkj8WbHSoPtQx/pAZ85BwCo6cJYy
	jLx7tRLmrjLoS52sTNuUUvc9R3jbRTLNYU07NqY7coJTafxGSorKJFg54sTefA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of rasasi78@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=rasasi78@mailbox.org
From: =?UTF-8?B?UmHDumwgU8OhbmNoZXo=?= Siles <rasasi78@mailbox.org>
To: linux-btrfs@vger.kernel.org
Subject: Trying to tackle https://github.com/kdave/btrfs-progs/issues/541
Date: Fri, 10 Oct 2025 10:55:55 +0200
Message-ID: <2800637.mvXUDI8C0e@prox>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12756658.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-MBO-RS-ID: 5741a7ba1b2af322b26
X-MBO-RS-META: kw8upoh6k54jqrrxnq5mryxo8d5m91ds
X-Rspamd-Queue-Id: 4cjgZT4zBnz9sTZ

--nextPart12756658.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: =?UTF-8?B?UmHDumwgU8OhbmNoZXo=?= Siles <rasasi78@mailbox.org>
To: linux-btrfs@vger.kernel.org
Date: Fri, 10 Oct 2025 10:55:55 +0200
Message-ID: <2800637.mvXUDI8C0e@prox>
MIME-Version: 1.0

Hello!

After a mount error "parent transid verify failed" I went to offline check =
the=20
partition and I came accross this issue. After this, I backup all data I=20
could get from the partition (via btrs restore). As a sidenote I also tried=
=20
mounting with the rescue=3Dusebackuproot with the same outcome.

Currently I have a reproducible scenario to look into the issue and provide=
d=20
lack of activity in the issue I thought I may be of help to provide more=20
information so issue can be fixed. The btrfs consistency issue looks seriou=
s=20
so even in case of successful debugging I don't expect to recover access to=
=20
that partition.

OS and SW:

=2D Debian sid
=2D btrfs-progs 6.17
=2D linux 6.16.11

Mount error:
[  120.652356] BTRFS: device fsid 06dc5f24-a16f-4520-993a-xxxxxxxxxxxx devi=
d=20
1 transid 968758 /dev/sda3 (8:3) scanned by pool-2 (4449)
[  120.653973] BTRFS info (device sda3): first mount of filesystem 06dc5f24-
a16f-4520-993a-xxxxxxxxxxxx
[  120.653994] BTRFS info (device sda3): using crc32c (crc32c-x86) checksum=
=20
algorithm
[  123.225415] BTRFS info (device sda3): start tree-log replay
[  123.523786] BTRFS error (device sda3): parent transid verify failed on=20
logical 229603573760 mirror 1 wanted 968173 found 966625
[  123.538334] BTRFS error (device sda3): parent transid verify failed on=20
logical 229603573760 mirror 2 wanted 968173 found 966625
[  123.538372] BTRFS error (device sda3): failed to run delayed ref for=20
logical 487464960 num_bytes 4096 type 184 action 1 ref_mod 1: -5
[  123.538383] BTRFS error (device sda3 state A): Transaction aborted (erro=
r=20
=2D5)
[  123.538387] BTRFS: error (device sda3 state A) in=20
btrfs_run_delayed_refs:2159: errno=3D-5 IO failure
[  123.538395] BTRFS: error (device sda3 state EA) in btrfs_replay_log:2094=
:=20
errno=3D-5 IO failure (Failed to recover log tree)
[  123.544693] BTRFS error (device sda3 state EA): open_ctree failed: -5

Please CC me as I'm not subscribed to the list.

  Best Regards,
=2D-=20
Ra=C3=BAl S=C3=A1nchez Siles
--nextPart12756658.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEKEEkoehr/HpWbUWrcbjC7Ut1BjwFAmjoyhsACgkQcbjC7Ut1
Bjw6vQgAiWGw9zTD+pb5icwongm9OLAfoe+w4jWy9DZpNKWUTiFBNSNEp89loGTm
077wDjXfg3TJH6JfRG3GjbVAEEim4dPXwClt8KDOKtGVBtaBHEe6TPa54UE31Bel
Edj7H82qCeFGJcq9xMlJrM2BtaCwQTmoLaBEM7nUXwjHzaEzCAujfiSXKrsgFMp1
PvAf0t2jvIP+e38DOmPhgtxJA9reVL/WuOtbRhfE4IJ//dPQ3HBtDOBeZlbJ13Kp
GcUmagHlGQZKYikHQ6jaIfYWGuippqCzxF5Pl0sPLzQqEcTwB5x2T+GOkitJKWCn
QsYOotLLPzd0/MixSwjRF4X19XyxIw==
=bd3h
-----END PGP SIGNATURE-----

--nextPart12756658.O9o76ZdvQC--




