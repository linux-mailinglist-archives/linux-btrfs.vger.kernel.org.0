Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91295421C96
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 04:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhJEC24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 22:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhJEC24 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 22:28:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2F8C061745;
        Mon,  4 Oct 2021 19:27:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HNhLD1MkYz4xbY;
        Tue,  5 Oct 2021 13:27:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1633400823;
        bh=6fdyQbvlrLBU34wLy+3byGNd8L6sygGzY8o8B4R6laI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TRLrBoCWgrOdQBw3cE12GIRRjZ0bWnd1NwchsOtLyjJzURQauirkPYLMOEtMxi3Sv
         m7Cfby+yMa0HtXig+mG/WWBOGHkipj2npPCtzGl/zW7w4Xo3ndCMTmol2pglbE5N2N
         44kA5ZqtcvOAfHhQrkknD24G4OOS4ME/4QUGI/Q1r4HxWcgAzZ3t5HFlKDRt0RcnvR
         No59vSIuMEnsab/q+Z5ntPBIxlQfUQ0RHLcxH93PnljzJnWPT75rrjFOQSYAcfcrF8
         DwVhrVKNMaH9iJsyRX9qpwTHvL37pYzZCtAjNsNs3qkHBmAv009k3t5lAB06ZbSkPW
         kfGJxuVKOi90Q==
Date:   Tue, 5 Oct 2021 13:26:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     linux-next@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Jones <paul@pauljones.id.au>,
        Tom Seewald <tseewald@gmail.com>
Subject: Re: [GIT PULL][v12] zstd changes for linux-next
Message-ID: <20211005132659.6774f10b@canb.auug.org.au>
In-Reply-To: <20211005014118.3164585-1-nickrterrell@gmail.com>
References: <20211005014118.3164585-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IExg.Rb=XT2QN9cy3Ol9ik7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/IExg.Rb=XT2QN9cy3Ol9ik7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Mon,  4 Oct 2021 18:41:18 -0700 Nick Terrell <nickrterrell@gmail.com> wr=
ote:
>
> From: Nick Terrell <terrelln@fb.com>
>=20
> The following changes since commit a25006a77348ba06c7bc96520d331cd9dd3707=
15:
>=20
>   Add linux-next specific files for 20211001 (2021-10-01 17:07:37 +1000)
>=20
> are available in the Git repository at:
>=20
>   git@github.com:terrelln/linux.git tags/v12-zstd-1.4.10
>=20
> for you to fetch changes up to 5210ca33b09bed5e09f72e9b46a3220f64597f8c:
>=20
>   MAINTAINERS: Add maintainer entry for zstd (2021-10-04 18:14:42 -0700)
>=20
> I would like to merge this pull request into linux-next to bake, and then=
 submit
> the PR to Linux in the 5.16 merge window. If you have been a part of the
> discussion, are a maintainer of a caller of zstd, tested this code, or ot=
herwise
> been involved, thank you! And could you please respond below with an appr=
opiate
> tag, so I can collect support for the PR

Sorry, but you can't base a branch on linux-next itself (since
linux-next - and many of the trees it merges - rebases every day).  If
you want a branch included in linux-next, it needs to be based on some
stable tree/branch, almost always Linus Torvald's tree.

Also, what I need is a branch that I can fetch every day (so its name
must not change) and all you do is update that branch to any newer
version if/when you are satisfied that it is ready for merging.

Also, I would like a git URL that does not require a github account ...
--=20
Cheers,
Stephen Rothwell

--Sig_/IExg.Rb=XT2QN9cy3Ol9ik7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFbt/MACgkQAVBC80lX
0Gw0IAf/XBdkJX2rPcknvr3a4cCv/ao8k9WfSQuj5lWeBh1GfidsCcnBy2cbhaPq
Js9sChfzfE5X6Ac1ocml8Rray4Z7Wiy1o5Nk82/Z6l8fjM2YsKz3yRTs6NEk19Mi
cAz4EnrIAYIQ+U4isMQjGpF50zoB+QBf3eQrE+iGsW8KHO8U/OxDQAef/+70NQ3o
p10hNyGW8r4XwZjlMydlLJ7Itafl5sMVWFzl6XPWWltse4h5civmLPgOys4nolCX
6d7erPxykk+M9llHEvz+qpaezkLbEK3xQpmDlXsgFMRhYqPFsX6ejElMM20gH8am
J0Z55WImkMdcmjRzonZKRid8udWwuw==
=siw5
-----END PGP SIGNATURE-----

--Sig_/IExg.Rb=XT2QN9cy3Ol9ik7--
