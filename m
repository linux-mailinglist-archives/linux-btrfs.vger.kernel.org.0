Return-Path: <linux-btrfs+bounces-19987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75553CD8732
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 09:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C27AF30213E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3815C31BC8D;
	Tue, 23 Dec 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=helgefjell.de header.i=@helgefjell.de header.b="dRQxMRuB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.helgefjell.de (mail.helgefjell.de [142.132.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB3169AD2
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.201.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766478700; cv=none; b=knfiEHuHo96zCbQBuK3x0AxtpunnkJhWbCanD05NrNcxlL6OactNv14WQMJZi6/ZNdrJYXpvRB6lVSBmM3JrUJ7LbfYkucHFMmDbgL8UNRj0BVH0Awhw13t2qVLm6MzCVj6prP0SgYMdeSNU6d96u0OWJM/Cw+DtUSlqp+qAEvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766478700; c=relaxed/simple;
	bh=m/8t3yAtrTm/mE85Cb1Py/HSOAeosXHyhnpQb0xP8Ew=;
	h=Date:From:To:Subject:Message-ID:Mime-Version:Content-Type:
	 Content-Disposition; b=InjP6EeDXszfDcKd4sDFJzQtp35PirWEShxaEHgzL9Zs8aMpSoM793wEO0sOThrDjf6vL3bpe0PHxZf+XE4KPx0d3Ky6jVyNtCAUZvY5ErGEA/b8Ma1x6WH3il3HL3wgT3R1g+XVvYU4a0kRX43ucGeYlIh9jK2IG+TSY9qIpDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de; spf=pass smtp.mailfrom=helgefjell.de; dkim=pass (2048-bit key) header.d=helgefjell.de header.i=@helgefjell.de header.b=dRQxMRuB; arc=none smtp.client-ip=142.132.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helgefjell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=helgefjell.de;
	s=selector.helgefjell; t=1766478387;
	bh=9DPJXsXnfMK/bUW25HPgXWZj8rA+LFvTHtbzLwDzBns=;
	h=Date:From:To:Subject;
	b=dRQxMRuBnCNO8yo7vxKNNAwh90LZjmFFZzCsgm9vL4I1ORQFtwDRpNilfy8VZbBGk
	 XAv9bZ7djqQN6n8NN4FKelu2NCUDsiNOAKuvG+PGKqXdAQTZsg8KnLtyPQJKayvLoO
	 9vOU6PZa1DstcoQuYqb9sUXUjWhDheTX7nYQPehGyVFN/7BgxbnnB6J+diBJUG4aKP
	 4wMjMRThpk4RV9SBZwKqtO3BnTR73aPH6GAvRnVv+Up/0JCdBPV39UHtok7pOcuFYQ
	 pg2VRAo9ut4oHQ2haeVj+qC3N6cvwqh1K8YoBKoivcYbZJ4AxeocMEhgv7O07Mj7nl
	 ba9JEIN/pSYsQ==
Original-Subject: Issues in man pages of btrfs-progs
Author: Helge Kreutzmann <debian@helgefjell.de>
Received: from localhost (localhost [127.0.0.1])
  (uid 1002)
  by mail.helgefjell.de with local
  id 00000000000200D9.00000000694A5233.00103325; Tue, 23 Dec 2025 08:26:27 +0000
Date: Tue, 23 Dec 2025 08:26:27 +0000
From: Helge Kreutzmann <debian@helgefjell.de>
To: linux-btrfs@vger.kernel.org
Subject: Issues in man pages of btrfs-progs
Message-ID: <aUpSM2MZ7JahHX-p@meinfjell.helgefjelltest.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_meinfjell-1061669-1766478387-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_meinfjell-1061669-1766478387-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Btrfs maintainer,
the manpage-l10n project[1] maintains a large number of translations of
man pages both from a large variety of sources (including Btrfs) as
well for a large variety of target languages.

During their work translators notice different possible issues in the
original (english) man pages. Sometimes this is a straightforward
typo, sometimes a hard to read sentence, sometimes this is a
convention not held up and sometimes we simply do not understand the
original.

We use several distributions as sources and update regularly (at
least every 2 month). This means we are fairly recent (some
distributions like archlinux also update frequently) but might miss
your latest upstream version once in a while, so the error might be
already fixed. We apologize and ask you to close the issue immediately
if this should be the case, but given the huge volume of projects and
the very limited number of volunteers we are not able to double check
each and every issue.

Secondly we translators see the manpages in the neutral po format,
i.e. converted and harmonized, but not the original source (be it man,
groff, xml or other). So we cannot provide a true patch (where
possible), but only an approximation which you need to convert into
your source format.

Finally the issues I'm reporting have accumulated over time and are
not always discovered by me, so sometimes my description of the
problem my be a bit limited - do not hesitate to ask so we can clarify
them.

I'm now reporting the issues for your project. If future reports
should use another channel, please let me know.

[1] https://manpages-l10n-team.pages.debian.net/manpages-l10n/

Man page: btrfs.8
Issue 1:  btrfs-convert(8) =E2=86=92 B<btrfs-convert>(8)
Issue 2:  btrfstune(8) =E2=86=92 B<btrfstune>(8)

"There are also standalone tools for some tasks like btrfs-convert(8) \\"
"%E<lt>E<gt> or btrfstune(8) \\%E<lt>E<gt> that were separate historically "
"and/or haven\\(aqt been merged to the main utility. See section STANDALONE=
 "
"TOOLS for more details."
--
Man page: btrfs.8
Issue 1:  btrfs(5) =E2=86=92 B<btrfs>(5)
Issue 2:  What does the <> at the end of the string mean?

"For other topics (mount options, etc) please refer to the separate manual "
"page btrfs(5) \\%E<lt>E<gt>\\&."
--
Man page: btrfs.8
Issue 1:  numfmt(1) =E2=86=92 B<numfmt>(1)
Issue 2:  locale(7) =E2=86=92 B<locale>(7)

"I<Sizes>, both upon input and output, can be expressed in either SI or IEC=
-I "
"units (see numfmt(1) \\%E<lt>https://\\:man7\\:.org/\\:linux/\\:man-pages/"
"\\:man1/\\:numfmt\\:.1\\:.htmlE<gt>)  with the suffix I<B> appended.  All "
"numbers will be formatted according to the rules of the I<C> locale "
"(ignoring the shell locale, see locale(7) \\%E<lt>https://\\:man7\\:.org/"
"\\:linux/\\:man-pages/\\:man7/\\:locale\\:.7\\:.htmlE<gt>)."
--
Man page: btrfs.8
Issue 1:  btrfs-balance(8) =E2=86=92 B<btrfs-balance>(8)
Issue 2:  What ist the <> for?

"Balance btrfs filesystem chunks across single or several devices.  See btr=
fs-"
"balance(8) \\%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue 1:  btrfs-check(8) =E2=86=92 B<btrfs-check>(8)=20
Issue 2:  What ist the <> for? =20

"Do off-line check on a btrfs filesystem.  See btrfs-check(8) \\%E<lt>E<gt>=
 "
"for details."
--
Man page: btrfs.8
Issue 1:  btrfs-device(8) =E2=86=92 B<btrfs-device>(8)
Issue 2:  What ist the <> for?

"Manage devices managed by btrfs, including add/delete/scan and so on.  See=
 "
"btrfs-device(8) \\%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue 1:  btrfs-filesystem(8) =E2=86=92 B<btrfs-filesystem>(8)
Issue 2:  What ist the <> for?

"Manage a btrfs filesystem, including label setting/sync and so on.  See "
"btrfs-filesystem(8) \\%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue 1:  btrfs-inspect-internal(8) =E2=86=92 B<btrfs-inspect-internal>(8)
Issue 2:  What ist the <> for?

"Debug tools for developers/hackers.  See btrfs-inspect-internal(8) \\"
"%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue 1:  btrfs-property(8) =E2=86=92 B<btrfs-property>(8)
issue 2:  What ist the <> for?

"Get/set a property from/to a btrfs object.  See btrfs-property(8) \\"
"%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue 1:  btrfs-qgroup(8) =E2=86=92 B<btrfs-qgroup>(8)
Issue 2:  What ist the <> for?

"Manage quota group(qgroup) for btrfs filesystem.  See btrfs-qgroup(8) \\"
"%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue 1:  btrfs-quota(8) =E2=86=92 B<btrfs-quota>(8)
Issue 2:  btrfs-qgroup(8) =E2=86=92 B<btrfs-qgroup>(8)
Issue 3:  What ist the <> for?

"Manage quota on btrfs filesystem like enabling/rescan and etc.  See btrfs-"
"quota(8) \\%E<lt>E<gt> and btrfs-qgroup(8) \\%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue 1:  btrfs-receive(8) =E2=86=92 B<btrfs-receive>(8)
Issue 2:  What ist the <> for?

"Receive subvolume data from stdin/file for restore and etc.  See btrfs-"
"receive(8) \\%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue 1:  btrfs-replace(8) =E2=86=92 B<btrfs-replace>(8)
Issue 2:  What ist the <> for?

"Replace btrfs devices.  See btrfs-replace(8) \\%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue 1:  btrfs-rescue(8) =E2=86=92 B<btrfs-rescue>(8)
Issue 2:  What ist the <> for?

"Try to rescue damaged btrfs filesystem.  See btrfs-rescue(8) \\%E<lt>E<gt>=
 "
"for details."
--
Man page: btrfs.8
Issue 1:  btrfs-restore(8) =E2=86=92 B<btrfs-restore>(8)
Issue 2:  What ist the <> for?

"Try to restore files from a damaged btrfs filesystem.  See btrfs-restore(8=
) "
"\\%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue 1:  btrfs-scrub(8) =E2=86=92 B<btrfs-scrub>(8)
Issue 2:  What ist the <> for?

"Scrub a btrfs filesystem.  See btrfs-scrub(8) \\%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue 1:  btrfs-send(8) =E2=86=92 B<btrfs-send>(8)
Issue 2:  What ist the <> for?

"Send subvolume data to stdout/file for backup and etc.  See btrfs-send(8) =
\\"
"%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue 1:  btrfs-subvolume(8) =E2=86=92 B<btrfs-subvolume>(8)
Issue 2:  What ist the <> for?

"Create/delete/list/manage btrfs subvolume.  See btrfs-subvolume(8) \\"
"%E<lt>E<gt> for details."
--
Man page: btrfs.8
Issue:    The proper way to write the link: E<.UR https://btrfs.readthedocs=
=2Eio> Text <.UE>

"B<btrfs> is part of btrfs-progs.  Please refer to the documentation at \\"
"%E<lt>https://\\:btrfs\\:.readthedocs\\:.ioE<gt>\\&."
--
Man page: btrfs.8
Issue 1:  The programm name itself must be in bold, e.g. B<btrfs>(5)
Issue 2:  What are the <> for?

"btrfs(5) \\%E<lt>E<gt>, btrfs-balance(8) \\%E<lt>E<gt>, btrfs-check(8) \\"
"%E<lt>E<gt>, btrfs-convert(8) \\%E<lt>E<gt>, btrfs-device(8) \\%E<lt>E<gt>=
, "
"btrfs-filesystem(8) \\%E<lt>E<gt>, btrfs-inspect-internal(8) \\%E<lt>E<gt>=
, "
"btrfs-property(8) \\%E<lt>E<gt>, btrfs-qgroup(8) \\%E<lt>E<gt>, btrfs-"
"quota(8) \\%E<lt>E<gt>, btrfs-receive(8) \\%E<lt>E<gt>, btrfs-replace(8) \=
\"
"%E<lt>E<gt>, btrfs-rescue(8) \\%E<lt>E<gt>, btrfs-restore(8) \\%E<lt>E<gt>=
, "
"btrfs-scrub(8) \\%E<lt>E<gt>, btrfs-send(8) \\%E<lt>E<gt>, btrfs-"
"subvolume(8) \\%E<lt>E<gt>, btrfstune(8) \\%E<lt>E<gt>, mkfs.btrfs(8) \\"
"%E<lt>E<gt>"
--
Man page: btrfs.8
Issue:    I<\\%btrfs(5)> =E2=86=92 B<btrfs>(5)

"For other topics (mount options, etc) please refer to the separate manual "
"page I<\\%btrfs(5)>\\&."

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_meinfjell-1061669-1766478387-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmlKUjAACgkQQbqlJmgq
5nB1/g/+J01HvztqbvvdJJPhCVXW5dZ9bmHFaBuapZkWFC0Zk7NB7jq/k8oPbQkW
1ZTDAAMd+0gCwHKHviLzgz1tYSj/r3l6yLtF7bgmsAsfzzxeDfP537n74lOIKsdu
aBr42jGL6JZ74ThG46qGYysCa6PvaVzN6hr29osCbEgbihsnfvW59QI1uzJaCZJK
NXyJNRWvfBkSpYJTlJGcjBUuAGA846qSJV4RAR1uApo/oFIV4p9JdJqrNi3SHUcv
i4e85H0mAhyLAQ7VH8ECLMMpucPKTKUv/b+WcgSZ5N2M9DKwx3EVpzlwNlef2Rb0
I/zrIbSI2DkuIs/KebhkThVaW+uI5EY7pd/7omCGY7GnKEOBv5IMC/J7RACfPSWu
b0SDTKTUWITMhL5a4ARUg9YP8aW61yimuHC/dQtJ4sbGLtM3dn8SFGrKH4ZhSAg8
gIfNuSCd6x9PFwjUGk5scx8L5nGDlWLZHItym7cSwfWGajuVe1n5ObWIqwNI4ZcI
PBWiYeu1BafMdWqpBYAqLkX30SbKgChyRdyps16nNXdaonurQ8DJKpaDuMJAG4Py
Cj/ztFVGfZQjI1jbTh5fa1S1tRjiIXtkzJj5Pvl21w2lIcFHocF/IMbQIdRJhnqA
eClZmJu6ol08KzoJKm6aoyA+cbwiD1KSGjv21FqMPV0+/JjlWS0=
=vs9z
-----END PGP SIGNATURE-----

--=_meinfjell-1061669-1766478387-0001-2--

