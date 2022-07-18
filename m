Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006AF578532
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 16:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiGROT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiGROTy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 10:19:54 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 07:19:52 PDT
Received: from static.213-239-213-133.clients.your-server.de (luckmann.name [213.239.213.133])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 2FA911FA
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 07:19:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E62056.0000000062D56AD8.00006109; Mon, 18 Jul 2022 16:14:48 +0200
Date:   Mon, 18 Jul 2022 16:14:47 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: Issues in man pages of btrfs-progs
Message-ID: <20220718141447.GA24796@Debian-50-lenny-64-minimal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-24841-1658153688-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_05,CK_HELO_GENERIC,
        HELO_DYNAMIC_IPADDR,SPF_HELO_NONE,SPF_NONE,URIBL_SBL_A autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-24841-1658153688-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear btrfs-progs maintainer,
the manpage-l10n project maintains a large number of translations of
man pages both from a large variety of sources (including btrfs-progs) as
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
Issue:    B<btrfs(5)> =E2=86=92 B<btrfs>(5)

"For other topics (mount options, etc) please refer to the separate manual "
"page B<btrfs(5)>\\&."
--
Man page: btrfs.8
Issue:    B<btrfs-balance(8)> =E2=86=92 B<btrfs-balance>(8)

"Balance btrfs filesystem chunks across single or several devices.  See "
"B<btrfs-balance(8)> for details."
--
Man page: btrfs.8
Issue:    B<btrfs-check(8)> =E2=86=92 B<btrfs-check>(8)

"Do off-line check on a btrfs filesystem.  See B<btrfs-check(8)> for detail=
s."
--
Man page: btrfs.8
Issue:    B<btrfs-device(8)> =E2=86=92 B<btrfs-device>(8)

"Manage devices managed by btrfs, including add/delete/scan and so on.  See=
 "
"B<btrfs-device(8)> for details."
--
Man page: btrfs.8
Issue:    B<btrfs-filesystem(8)> =E2=86=92 B<btrfs-filesystem>(8)

"Manage a btrfs filesystem, including label setting/sync and so on.  See "
"B<btrfs-filesystem(8)> for details."
--
Man page: btrfs.8
Issue:    B<btrfs-inspect-internal(8)> =E2=86=92 B<btrfs-inspect-internal>(=
8)

"Debug tools for developers/hackers.  See B<btrfs-inspect-internal(8)> for "
"details."
--
Man page: btrfs.8
Issue:    B<btrfs-property(8)> =E2=86=92 B<btrfs-property>(8)

"Get/set a property from/to a btrfs object.  See B<btrfs-property(8)> for "
"details."
--
Man page: btrfs.8
Issue:    B<btrfs-qgroup(8)> =E2=86=92 B<btrfs-qgroup>(8)

"Manage quota group(qgroup) for btrfs filesystem.  See B<btrfs-qgroup(8)> f=
or "
"details."
--
Man page: btrfs.8
Issue:    B<btrfs-quota(8)> and B<btrfs-qgroup(8)> =E2=86=92 B<btrfs-quota>=
(8) and B<btrfs-qgroup>(8)

"Manage quota on btrfs filesystem like enabling/rescan and etc.  See B<btrf=
s-"
"quota(8)> and B<btrfs-qgroup(8)> for details."
--
Man page: btrfs.8
Issue:    B<btrfs-receive(8)> =E2=86=92 B<btrfs-receive>(8)

"Receive subvolume data from stdin/file for restore and etc.  See B<btrfs-"
"receive(8)> for details."
--
Man page: btrfs.8
Issue:    B<btrfs-replace(8)> =E2=86=92 B<btrfs-replace>(8)

"Replace btrfs devices.  See B<btrfs-replace(8)> for details."
--
Man page: btrfs.8
Issue:    B<btrfs-rescue(8)> =E2=86=92 B<btrfs-rescue>(8)

"Try to rescue damaged btrfs filesystem.  See B<btrfs-rescue(8)> for detail=
s."
--
Man page: btrfs.8
Issue:    B<btrfs-restore(8)> =E2=86=92 B<btrfs-restore>(8)

"Try to restore files from a damaged btrfs filesystem.  See B<btrfs-"
"restore(8)> for details."
--
Man page: btrfs.8
Issue:    B<btrfs-scrub(8)> =E2=86=92 B<btrfs-scrub>(8)

"Scrub a btrfs filesystem.  See B<btrfs-scrub(8)> for details."
--
Man page: btrfs.8
Issue:    B<btrfs-send(8)> =E2=86=92 B<btrfs-send>(8)

"Send subvolume data to stdout/file for backup and etc.  See B<btrfs-send(8=
)> "
"for details."
--
Man page: btrfs.8
Issue:    B<btrfs-subvolume(8)> =E2=86=92 B<btrfs-subvolume>(8)

"Create/delete/list/manage btrfs subvolume.  See B<btrfs-subvolume(8)> for "
"details."
--
Man page: btrfs.8
Issue:    btrfs wiki I<\\%http://btrfs.wiki.kernel.org> =E2=86=92 E<.UR htt=
ps://btrfs.wiki.kernel.org>btrfs wiki<.UE> (Note: https)A

"B<btrfs> is part of btrfs-progs.  Please refer to the btrfs wiki I<\\%http=
://"
"btrfs.wiki.kernel.org> for further details."
--
Man page: btrfs.8
Issue:    section number in such links must not be bold: B<btrfs(5)> =E2=86=
=92 B<btrfs>(5) etc.

"B<btrfs(5)>, B<btrfs-balance(8)>, B<btrfs-check(8)>, B<btrfs-convert(8)>, "
"B<btrfs-device(8)>, B<btrfs-filesystem(8)>, B<btrfs-inspect-internal(8)>, "
"B<btrfs-property(8)>, B<btrfs-qgroup(8)>, B<btrfs-quota(8)>, B<btrfs-"
"receive(8)>, B<btrfs-replace(8)>, B<btrfs-rescue(8)>, B<btrfs-restore(8)>,=
 "
"B<btrfs-scrub(8)>, B<btrfs-send(8)>, B<btrfs-subvolume(8)>, B<btrfstune(8)=
>, "
"B<mkfs.btrfs(8)>"

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-24841-1658153688-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmLVatAACgkQQbqlJmgq
5nAFmxAAqaVG9vUgP1FgLrC+3p4ovAD4ek1SA4rnzPI9iKJ2GrSe0qH4At8MGD+t
OrCOeTghG6ty1g5AHMWZGA3z+k1S1lGf1OktAv7Cfvv4tPEXO0Rry+fEoVvSVfky
ihT/GYRd3amna61u7xxuew85LrFckyZV5e09EHLBVml3UR87Ruhbydk3hHPbtP/R
7M4cW6PI4voU0DmFm/25Cq70ufWGwl+hF7sGF6aoKKAkRh5jBedt9LGVY1nS2s/W
Y9YUjhJ28ZC8YpOamJ/0+VVoQMxmtV+p/KeZxTz77UqiVcMpnZ6drzhKptQZuxtY
Fy2TxF7N3H7b1zVs+KshhL2L5KFQBb2K9gVG8ozPHqdOKXQGgeC33JEMDfx7WnyR
sqvLn1vDIw8m1ivkoUgvAqMCq2gdqzkGlw6HiF7GX1o95LlE7DOdTkRtg6eYxLMB
7L2STol+HejvMCL6vjZmrre14zL8FCePZbHRxS79dobbHKCWpNOmnd2OxYbMnUpv
fRLKN0LPg28fTx/8bXuT4kU/ePkpLh5x9Tkn62JE5WICcicC3OaqEgdHHuPpXp3+
nczxmpZnzYoabcXlkKkgeGNE6LdzeK18/RSmDMop8mlnV1U3Az78dXH+Kcm77Cb+
UVBZ//9/VIlqW9CLyoApxLZYZU8PxodjU3zocuUFFw/4oPY19tk=
=MEKP
-----END PGP SIGNATURE-----

--=_luckmann.name-24841-1658153688-0001-2--
