Return-Path: <linux-btrfs+bounces-2987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB88686F4D9
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Mar 2024 13:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993971F21D0D
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Mar 2024 12:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26860BE6B;
	Sun,  3 Mar 2024 12:38:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.helgefjell.de (mail.helgefjell.de [142.132.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D3883D
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Mar 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.201.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709469512; cv=none; b=c5AxKR5vhs+7q2l7kSumPGVlhdjUIP6np4sODlInhaZaOoFNBb4ZtQNPVmPIGM8IkkzwU/LKro7TaDKI/NGI6AWOd6gnURH1N3folqR/1XlsIQxDPTC7fPZ5mYEmjisDIldHL1xeI1alEtv8khjYftduAfscr/WjLLuoaHXSym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709469512; c=relaxed/simple;
	bh=6AAVgYgfoZwA4gVhJFHPuUVH7IkcgWnly0/MhyIXfzo=;
	h=Date:From:To:Subject:Message-ID:Mime-Version:Content-Type:
	 Content-Disposition; b=QoGuRYTisRVLrl2FJGhUrI6CTKxKuCuHKr/J7YsGsn6v+sbSF7sb/9HvAXRa1jSVYTh2Vnr2G3uyvPXjYqWLKZgh1kelymom1WstC539OuhcierthLzccXmTcrXDBn5WaNsbIqLZoyGNsCX9REG37hc3saQuoUZSK+r1CLXSyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de; spf=pass smtp.mailfrom=helgefjell.de; arc=none smtp.client-ip=142.132.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helgefjell.de
Received: from localhost (localhost [127.0.0.1])
  (uid 1002)
  by mail.helgefjell.de with local
  id 000000000002016C.0000000065E46E10.00395568; Sun, 03 Mar 2024 12:33:20 +0000
Date: Sun, 3 Mar 2024 12:33:20 +0000
From: Helge Kreutzmann <debian@helgefjell.de>
To: linux-btrfs@vger.kernel.org
Subject: Issues in man pages of btrfs-progs
Message-ID: <ZeRuEH029j3enMr0@meinfjell.helgefjelltest.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_meinfjell-3757416-1709469200-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_meinfjell-3757416-1709469200-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear brtfs maintainer,
the manpage-l10n project maintains a large number of translations of
man pages both from a large variety of sources (including btrfs) as
well for a large variety of target languages.

During their work translators notice different possible issues in the
original (english) man pages. Sometimes this is a straightforward
typo, sometimes a hard to read sentence, sometimes this is a
convention not held up and sometimes we simply do not understand the
original.

We use several distributions as sources and update regularly (at
least every 2 month). This means we are fairly recent (some
distributions like archlinux also update frequently) but might miss
the latest upstream version once in a while, so the error might be
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

I'm now reporting the errors for your project. If future reports
should use another channel, please let me know.

Man page: btrfs.8
Issue:    I<\\%btrfs(5)> =E2=86=92 B<\\%btrfs>(5)

"For other topics (mount options, etc) please refer to the separate manual "
"page I<\\%btrfs(5)>\\&."
--
Man page: btrfs.8
Issue 1:  I<\\%numfmt(1)> =E2=86=92 B<\\%numfmt>(1)
Issue 2:  I<\\%locale(7)> =E2=86=92 B<\\%locale>(7)

"I<Sizes>, both upon input and output, can be expressed in either SI or IEC=
-I "
"units (see I<\\%numfmt(1)>)  with the suffix I<B> appended.  All numbers "
"will be formatted according to the rules of the I<C> locale (ignoring the "
"shell locale, see I<\\%locale(7)>)."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-balance(8)> =E2=86=92 B<btrfs-balance>(8)

"Balance btrfs filesystem chunks across single or several devices.  See I<\=
\"
"%btrfs-balance(8)> for details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-check(8)> =E2=86=92 B<btrfs-check>(8)

"Do off-line check on a btrfs filesystem.  See I<\\%btrfs-check(8)> for "
"details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-device(8)> =E2=86=92 B<btrfs-device>(8)

"Manage devices managed by btrfs, including add/delete/scan and so on.  See=
 "
"I<\\%btrfs-device(8)> for details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-filesystem(8)> =E2=86=92 B<\\%btrfs-filesystem>(8)

"Manage a btrfs filesystem, including label setting/sync and so on.  See I<=
\\"
"%btrfs-filesystem(8)> for details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-inspect-internal(8)> =E2=86=92 B<\\%btrfs-inspect-inte=
rnal>(8)

"Debug tools for developers/hackers.  See I<\\%btrfs-inspect-internal(8)> f=
or "
"details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-property(8)> =E2=86=92 B<\\%btrfs-property>(8)

"Get/set a property from/to a btrfs object.  See I<\\%btrfs-property(8)> fo=
r "
"details."
--
Man page: btrfs.8
Issue:   I<\\%btrfs-qgroup(8)> =E2=86=92 B<\\%btrfs-qgroup>(8)

"Manage quota group(qgroup) for btrfs filesystem.  See I<\\%btrfs-qgroup(8)=
> "
"for details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-quota(8)> and I<\\%btrfs-qgroup(8)> =E2=86=92 B<\\%btr=
fs-quota>(8) and B<\\%btrfs-qgroup>(8)

"Manage quota on btrfs filesystem like enabling/rescan and etc.  See I<\\"
"%btrfs-quota(8)> and I<\\%btrfs-qgroup(8)> for details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-receive(8)> =E2=86=92 B<\\%btrfs-receive>(8)

"Receive subvolume data from stdin/file for restore and etc.  See I<\\%btrf=
s-"
"receive(8)> for details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-replace(8)> =E2=86=92 B<\\%btrfs-replace>(8)

"Replace btrfs devices.  See I<\\%btrfs-replace(8)> for details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-rescue(8)> =E2=86=92 B<\\%btrfs-rescue>(8)

"Try to rescue damaged btrfs filesystem.  See I<\\%btrfs-rescue(8)> for "
"details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-restore(8)> =E2=86=92 B<\\%btrfs-restore>(8)

"Try to restore files from a damaged btrfs filesystem.  See I<\\%btrfs-"
"restore(8)> for details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-scrub(8)> =E2=86=92 B<\\%btrfs-scrub>(8)

"Scrub a btrfs filesystem.  See I<\\%btrfs-scrub(8)> for details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-send(8)> =E2=86=92 B<\\%btrfs-send>(8)

"Send subvolume data to stdout/file for backup and etc.  See I<\\%btrfs-"
"send(8)> for details."
--
Man page: btrfs.8
Issue:    I<\\%btrfs-subvolume(8)> =E2=86=92 B<\\%btrfs-subvolume>(8)

"Create/delete/list/manage btrfs subvolume.  See I<\\%btrfs-subvolume(8)> f=
or "
"details."
--
Man page: btrfs.8
Issue:    btrfs wiki I<\\%http://btrfs.wiki.kernel.org> =E2=86=92 E<.UR htt=
p://btrfs.wiki.kernel.org>btrfs wiki<.UE> (Note: https)

"B<btrfs> is part of btrfs-progs.  Please refer to the documentation at I<\=
\"
"%https://btrfs.readthedocs.io>\\&."
--
Man page: btrfs.8
Issue:    section number in such links must not be bold: I<btrfs(5)> =E2=86=
=92 B<btrfs>(5) etc.

"I<\\%btrfs(5)>, I<\\%btrfs-balance(8)>, I<\\%btrfs-check(8)>, I<\\%btrfs-"
"convert(8)>, I<\\%btrfs-device(8)>, I<\\%btrfs-filesystem(8)>, I<\\%btrfs-"
"inspect-internal(8)>, I<\\%btrfs-property(8)>, I<\\%btrfs-qgroup(8)>, I<\\"
"%btrfs-quota(8)>, I<\\%btrfs-receive(8)>, I<\\%btrfs-replace(8)>, I<\\%btr=
fs-"
"rescue(8)>, I<\\%btrfs-restore(8)>, I<\\%btrfs-scrub(8)>, I<\\%btrfs-"
"send(8)>, I<\\%btrfs-subvolume(8)>, I<\\%btrfstune(8)>, I<\\%mkfs.btrfs(8)=
>"

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_meinfjell-3757416-1709469200-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmXkbg0ACgkQQbqlJmgq
5nB2yBAAgj33IabCxu45JHTm7UV11EU5MbAdWWMuJQfLLp/Bz7uX8oIYbslWhBjI
psdZAvnZSK+q2+/w0uDGsCssuLv7H+M8OfXWUuPuRqHCNNCeJ49jI4ZRm8g9dKHU
Txzoc7y8apaojk+2WbCM0DQ2lXXXoG7g6gRxR4lt5IL6nVOo7FNT32h2ss3cswnd
tqFdb59Yg36FuZdmXbZ3y3WgFFUpG8Ii3zLrXebaFkpFlA5cIalqOzptZfnF0z5Y
RS+TpWeqpIuQM5oE9NZJdJQ2bgyZy6VeK51PiE4QNWxunpj4YuvnRzj7QuvwUJwb
foGwPzJoAB5AKDy8A5lPx0B4qyATyUBao8ZTu1pWsh+S1WNayAZPk3nFnBpnrLG8
hZC8LuVjcX5onMwKKGpwzDJzOt1TjvcCKM8pdaZjz0Ye9DXOAJWbEUpxdAPawiy3
doz8UHmgWJ+83SU3nja4bc3an6rJz49Pj8XP4eR4jodLgesBhPurethPBAltcqTe
NjNMxVSHx1IvIWYqzPBanB910pz5zhWF6qvmiOQDUECU+EUD5KgijOBjIjD1ZDL5
RXsO10LkVb62NbeljDDQP0+ZaUyv4/YZaSCWvswaEeJEdppviEy8rVDESAW8meKP
eKG4Twr1vZaZ338ppKiLpaSRFdyY4IysUj4F45ApVPiS52p0qKQ=
=bgGX
-----END PGP SIGNATURE-----

--=_meinfjell-3757416-1709469200-0001-2--

