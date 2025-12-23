Return-Path: <linux-btrfs+bounces-19990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF381CD8F57
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 11:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5D7B306503D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF74232B9BD;
	Tue, 23 Dec 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=helgefjell.de header.i=@helgefjell.de header.b="IZYE+TD5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.helgefjell.de (mail.helgefjell.de [142.132.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C5E32E751
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.201.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766486638; cv=none; b=N0K4wyxEzZYzpHSR2o3LqsBBOvgYsVtCY/fto0agtVC+JZAuVz5Lw98XSbax99/QPQpPQsPSTSzgY04g7sMPfCkZHGpNfFmhQUQ5j7NCMjvTFP0Fzy4twdf75G6N/GtDX9dgoAkpKdqD4pPOYRj4kakmO5xwAJKH2jiWmQWF7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766486638; c=relaxed/simple;
	bh=HXYYXgdJp6LSiiLQYwejmgDcLNmnbXvIS/P7+b/BYWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdBPvM0tuXJmO8UuEzL9QsBoNwEcV3pcHWfC3vJA5g9mV7LyNjvqhuxo+froaxX0ObgDf31U/5HjfboiqSKnjAryofI+kq01THNswUrTYWSk5wjzF1kR5Q9Ss7wghLnErXQiGka0TBjwp5X/Fgt300zzzGhQwJ3aOqf1LTrdEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de; spf=pass smtp.mailfrom=helgefjell.de; dkim=pass (2048-bit key) header.d=helgefjell.de header.i=@helgefjell.de header.b=IZYE+TD5; arc=none smtp.client-ip=142.132.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helgefjell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=helgefjell.de;
	s=selector.helgefjell; t=1766486630;
	bh=WCM+JybtcJBn0Vtzya4SogXLC0/mC/BQGqLFZp0KMTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IZYE+TD5ScMZszce63/7TZwVlgZpZeAIBSvaa88pqTJJw/FwY5xvrR5ELOMuxJG71
	 KXtHjvMvE6kg8AE0F079dTIdEZ5riPw0tA4Abckeza7LCwL3g7+yAtQqVaKb7y6b4K
	 nkcZcUt/yfabpn7/WFF3FUzEX1UKYtYLjLDQbK9PNB5SnKWNAi10iAZnAnbFhbUb6F
	 +KUJwu6ykg+ze69Bb/q7/AGqJXgbsmfBM1cK3NpuUAjsxgSg2DGqr55TNTtWGNMd5M
	 W50qnOqZJIxB0Kymu9rbQeOpPDu4km+2NW9wXIL2xL9QyP2Mq+BmGfOxCSQYMf4tWF
	 LKKy4hk4dPdwg==
Original-Subject: Re: Issues in man pages of btrfs-progs
Author: Helge Kreutzmann <debian@helgefjell.de>
Received: from localhost (localhost [127.0.0.1])
  (uid 1002)
  by mail.helgefjell.de with local
  id 000000000002010A.00000000694A7266.00103CB2; Tue, 23 Dec 2025 10:43:50 +0000
Date: Tue, 23 Dec 2025 10:43:50 +0000
From: Helge Kreutzmann <debian@helgefjell.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Issues in man pages of btrfs-progs
Message-ID: <aUpyZsbXjO6KJF0D@meinfjell.helgefjelltest.de>
References: <aUpSM2MZ7JahHX-p@meinfjell.helgefjelltest.de>
 <32d13c5d-68f7-41fc-b94b-fa1f793fb2bf@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_meinfjell-1064114-1766486630-0001-2"
Content-Disposition: inline
In-Reply-To: <32d13c5d-68f7-41fc-b94b-fa1f793fb2bf@suse.com>
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_meinfjell-1064114-1766486630-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Qu,
thanks for your swift reply.

Am Tue, Dec 23, 2025 at 07:35:19PM +1030 schrieb Qu Wenruo:
> =E5=9C=A8 2025/12/23 18:56, Helge Kreutzmann =E5=86=99=E9=81=93:
> > Dear Btrfs maintainer,
> > the manpage-l10n project[1] maintains a large number of translations of
> > man pages both from a large variety of sources (including Btrfs) as
> > well for a large variety of target languages.
> >=20
> > During their work translators notice different possible issues in the
> > original (english) man pages. Sometimes this is a straightforward
> > typo, sometimes a hard to read sentence, sometimes this is a
> > convention not held up and sometimes we simply do not understand the
> > original.
> >=20
> > We use several distributions as sources and update regularly (at
> > least every 2 month). This means we are fairly recent (some
> > distributions like archlinux also update frequently) but might miss
> > your latest upstream version once in a while, so the error might be
> > already fixed. We apologize and ask you to close the issue immediately
> > if this should be the case, but given the huge volume of projects and
> > the very limited number of volunteers we are not able to double check
> > each and every issue.
> >=20
> > Secondly we translators see the manpages in the neutral po format,
> > i.e. converted and harmonized, but not the original source (be it man,
> > groff, xml or other). So we cannot provide a true patch (where
> > possible), but only an approximation which you need to convert into
> > your source format.
>=20
> Thanks for the report, unfortunately we're not dealing with po format
> directly, but rst (for older versions there were ascii docs too) for the
> ability to generate both html and manpage targets.

Thanks, I was not expecting fixes in the po format. I'm aware that
this is not the source, only what we translators see.

> So for certain errors, the fix may not be that straightforward, but we wi=
ll
> definitely try to fix them all when possible.

Thank you.

> > Finally the issues I'm reporting have accumulated over time and are
> > not always discovered by me, so sometimes my description of the
> > problem my be a bit limited - do not hesitate to ask so we can clarify
> > them.
> >=20
> > I'm now reporting the issues for your project. If future reports
> > should use another channel, please let me know.
> >=20
> > [1] https://manpages-l10n-team.pages.debian.net/manpages-l10n/
> >=20
> > Man page: btrfs.8
> > Issue 1:  btrfs-convert(8) =E2=86=92 B<btrfs-convert>(8)
> > Issue 2:  btrfstune(8) =E2=86=92 B<btrfstune>(8)
>=20
> Not an expert, but the original rst is ":doc:`btrfs-convert`" and
> ":doc:`btrfstune`", which means to be interpreted as a doc type
> cross-reference role, and I failed to figure what's going wrong in the
> original RST docs.

If you cannot fix these (now), please tell me, than I mark them in our
sources so we don't report those again. So maybe a toolchain problem?

> > "There are also standalone tools for some tasks like btrfs-convert(8) \=
\"
> > "%E<lt>E<gt> or btrfstune(8) \\%E<lt>E<gt> that were separate historica=
lly"
> > "and/or haven\\(aqt been merged to the main utility. See section STANDA=
LONE"
> > "TOOLS for more details."
> > --
> > Man page: btrfs.8
> > Issue 1:  btrfs(5) =E2=86=92 B<btrfs>(5)
> > Issue 2:  What does the <> at the end of the string mean?
>=20
> The ending <> seems to be a bug in the generated man pages only.

Ok, if this is a bug in the man page and not intended, then=20

> The html version looks working fine:
>=20
> https://btrfs.readthedocs.io/en/latest/btrfs.html
>=20
> So this along with the previous bold formatting problem seems to be man p=
age
> target specific, will need to dig deeper, but unfortunately not familiar
> with RST, thus this will take some time.

Thank you for your analysis and take your time, no pressure form my
side.

>=20
> [... Same problem skipped ...]
>=20
> > --
> > Man page: btrfs.8
> > Issue:    The proper way to write the link: E<.UR https://btrfs.readthe=
docs.io> Text <.UE>
> >=20
> > "B<btrfs> is part of btrfs-progs.  Please refer to the documentation at=
 \\"
> > "%E<lt>https://\\:btrfs\\:.readthedocs\\:.ioE<gt>\\&."
>=20
> The original RST code is a correct hyper link:
>=20
> `https://btrfs.readthedocs.io <https://btrfs.readthedocs.io>`_.
>=20
> This maybe another manpage target specific problem related to RST.

Probably.

> > --
> > Man page: btrfs.8
> > Issue 1:  The programm name itself must be in bold, e.g. B<btrfs>(5)
> > Issue 2:  What are the <> for?
> >=20
> > "btrfs(5) \\%E<lt>E<gt>, btrfs-balance(8) \\%E<lt>E<gt>, btrfs-check(8)=
 \\"
> > "%E<lt>E<gt>, btrfs-convert(8) \\%E<lt>E<gt>, btrfs-device(8) \\%E<lt>E=
<gt>,"
> > "btrfs-filesystem(8) \\%E<lt>E<gt>, btrfs-inspect-internal(8) \\%E<lt>E=
<gt>,"
> > "btrfs-property(8) \\%E<lt>E<gt>, btrfs-qgroup(8) \\%E<lt>E<gt>, btrfs-"
> > "quota(8) \\%E<lt>E<gt>, btrfs-receive(8) \\%E<lt>E<gt>, btrfs-replace(=
8) \\"
> > "%E<lt>E<gt>, btrfs-rescue(8) \\%E<lt>E<gt>, btrfs-restore(8) \\%E<lt>E=
<gt>,"
> > "btrfs-scrub(8) \\%E<lt>E<gt>, btrfs-send(8) \\%E<lt>E<gt>, btrfs-"
> > "subvolume(8) \\%E<lt>E<gt>, btrfstune(8) \\%E<lt>E<gt>, mkfs.btrfs(8) =
\\"
> > "%E<lt>E<gt>"
> > --
> > Man page: btrfs.8
> > Issue:    I<\\%btrfs(5)> =E2=86=92 B<btrfs>(5)
> >=20
> > "For other topics (mount options, etc) please refer to the separate man=
ual"
> > "page I<\\%btrfs(5)>\\&."
>=20
> Looks like the same problem related to doc role cross-ref:
>=20
> :doc:`btrfs-man5`
>=20
> Thanks,
> Qu

Thanks from my side.

Greetings

           Helge

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_meinfjell-1064114-1766486630-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmlKcmMACgkQQbqlJmgq
5nCc4A/9G2fItwEjm6+ZccotpmAXhNXDNXbi7ZddwJdWpzGlay3Ae4BsLxGwslcX
JtgWxUDkK9smHqxzHxWHWhCZwLgL1jRBNBe37n4lUr0mZUjE1yaaJI05iujSnYKF
6mu1rm7dyGuR12Y+DDfrP6RH918H/dJsrNRjUyZou+koohJr9hDjcKwO5Oe9poZT
PqG3pyJXfBMd90cvbKN4vcWjcFnP250G/yvjFDcjLyA2+u6kn0MXGGd2QJyRjHSY
3a1L4QoPVI76R+n3GN7tmkAUtFFMnBQjjeYuqt9kFy1wANocDoIcjHblVj62KIG8
F7gETAMOvb+DZAMpU/WvbCO/ZNyk7ytkxc/4fedKA2zFpl1xP8dN5XMLoN5PIJh5
SznCYN86D3IhtnZ7cEQSIoXA+5LsKVL4zr7eMoC9nsnclls5rOUMrIGv+Aycr5eI
aPGwHl0758fI7zqmVRhz5Rf+1yNbLm1mDD/cJeJZ2+V3Q+sp04kuMicdiFOFZgK1
5x3U+NeXab1yYGl+l+KmyAndv0FBK0XiFNzopzgQZx12oD0zq8mggnTKC7YihH8C
dV5mMO0yhWN+4iz+D6EXAj4payGlMI4MigyKMugVhxHpmEoLqimv8y5xlkUaWIGm
UF4BjS2HWej1xCZybDJ0jh6q8beJRkWvnOAib4teXuwMVkWSB3A=
=BjYT
-----END PGP SIGNATURE-----

--=_meinfjell-1064114-1766486630-0001-2--

