Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA34328E9D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 03:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbgJOBTi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 21:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbgJOBTh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 21:19:37 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942B6C0F26EC;
        Wed, 14 Oct 2020 17:40:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CBVmr3Gpvz9sT6;
        Thu, 15 Oct 2020 11:40:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1602722412;
        bh=u1eZAuatFPCw2PYqytmYCq9mP9BK+qHXGlCxYDJPXB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oEktgIMfbUFEIPY1+zFqc/Nbna2Gqn2JBTQFMhIQgbOyKMH5+Sa1uQL6tafIbDZNw
         AomTl6dZRCfdhEYyCKBZWrbu6YSY8gPAZjY21acDE+niTkQNY8omBRCIIKeb22YW8V
         GCpPov8HEX4TKtRfbkc50Jnn03k4eF6cUqbqMq3BFp4+gsoJ9NiEBTepjsjzjg8NHQ
         GlKKHTaY0b4FPqxL3j7FC3Xv/jcj0rixv4s/z3RybUCEthTSrLOsqfkAO7Nbu0DqSf
         Hgp8I9IwYBX4MC5dZszL/jaih8uDLl7VXFbs9unc1l1Jn8xKu+OU5lyqXXI6suQCjT
         qcZCcYAW1H+1A==
Date:   Thu, 15 Oct 2020 11:40:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 5.10
Message-ID: <20201015114011.1f5f985a@canb.auug.org.au>
In-Reply-To: <cover.1602519695.git.dsterba@suse.com>
References: <cover.1602519695.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i8rQjGuhT9dk045WX8YA9Jy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/i8rQjGuhT9dk045WX8YA9Jy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 12 Oct 2020 22:25:02 +0200 David Sterba <dsterba@suse.com> wrote:
>
> Mishaps:
>=20
> - commit 62cf5391209a ("btrfs: move btrfs_rm_dev_replace_free_srcdev
>   outside of all locks") is a rebase leftover after the patch got
>   merged to 5.9-rc8 as a466c85edc6f ("btrfs: move
>   btrfs_rm_dev_replace_free_srcdev outside of all locks"), the
>   remaining part is trivial and the patch is in the middle of the
>   series so I'm keeping it there instead of rebasing

And yet, this entire pull request has been rebased since what was in
linux-next on Tuesday (and what would still be there today except I
dropped it because of several conflicts) ...  it looks like it was
rebased a week ago, but then never included in your "for-next" branch.
So I supposed it has had your internal testing, at least.

--=20
Cheers,
Stephen Rothwell

--Sig_/i8rQjGuhT9dk045WX8YA9Jy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+HmmsACgkQAVBC80lX
0GwiCwgAkLaIP0IQcRIHW8+R/G+zjMZ2HTAUrhCiB7jn89UoNXoG6w/M2KWe1kjO
VRuE21nrirNy125RuNV3lsK7DKIT9NYIArQYQ8/cw8rGvKXyn659o8PBmkS8dfD0
oiz1VncsZjBzbTfrVES+gbjw5XquCIoxd/TZTGQUXLIgab4pIqMM63uKONimg8Of
VFj6jFVspOaOzU4W/gnYs9mjNZ5+k4ik4VO2tdNcI2ELVS8lTlnCwZCg75IicBw/
apcFhNEqJVicWxAkAbouoM7Wv5mLVea/JEMEryLRwLX1x1YnGqM9avL3JNmYRNEC
5IPhFVz3SLeRZqfPU8JdrC0XWa9z3g==
=4X/W
-----END PGP SIGNATURE-----

--Sig_/i8rQjGuhT9dk045WX8YA9Jy--
