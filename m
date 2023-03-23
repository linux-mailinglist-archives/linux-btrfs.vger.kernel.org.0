Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242346C730F
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 23:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjCWW0W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 18:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjCWW0Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 18:26:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28142385A
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 15:26:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso2116456wms.1
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 15:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679610371;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FEqdAq5dRGl2hZDd9rsbCPnsRZ+oYPgKWv3lWfX6QUk=;
        b=fQvI5wswOVO9Xc2MyXUhbKeHcMGF9PWLLuL9Chf0Vim0nAQz+SydWZ7/PuAnia8tGF
         SxSrQCDtz+rvcRo677+15O9GMHmWHygBA6ryAFlCIBAqEr6gvXgc4tyIjK6SN0LA+Z2P
         QdmS3d1DPrJcv8rzT+9nqqk2CeuXLCS9Vv28AkTyPQTRhuyTgm62VyqwLjVspC6v0uSY
         ANsOad+9a/6HzYs++s7m49H3N5YWaa3DNBjmv45YgmL4Mb96gzkW9VhCudBBLgs7DEC5
         2N1XLt7DAcaiVg6EGjARKCujAvVnURYGc7fw7DdwntBsVZ3k+k5B9HTUv/ltcifSari/
         ytMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679610371;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEqdAq5dRGl2hZDd9rsbCPnsRZ+oYPgKWv3lWfX6QUk=;
        b=g9NCrWFZs/jueHFILJavrsSERGAE7+mEwRlS3gYtUCYUWyzgzXdodrLyfk09Z+THkF
         e/DYayStnYLYbZy+ZrGHO9yR6C21GTiIPx8Gv4aBQcCMTrcHx3rryLexF4+/7maYB8+P
         ZHm9O+fdEP8ZI2lvxkp35D0vQtr8GL1eDx70ZSyCAnwDx1jrLzpIoyKHVPgtu+GcIkeh
         Lmwk7mf1/n0qBdCVwXqOPr2WQuFk62f/Q4H5sb7yy4k4hGSFu3m2EuZPOGdnUSBDCyga
         vYJ/GLvVE+oOl+5zOjFxX+MyE55hMavOWUM+512j+A9sQF+/H4k5dxgKHLkN5X38vLnM
         OGAg==
X-Gm-Message-State: AO0yUKUCczuWLkhlSP7jB84cWgOpOP1NN33P2A5SYmQU/FawCJlslvti
        RGmAxZT7ldvhxZjQCWn7vwQ=
X-Google-Smtp-Source: AK7set83O40+JAWj0KetLmMioYFmqCga+4NA+YIiohe9aWbtDFcXUXXbV+S+Tl/6vJ3E169n0+vmdQ==
X-Received: by 2002:a1c:790b:0:b0:3ee:56f7:75d2 with SMTP id l11-20020a1c790b000000b003ee56f775d2mr870866wme.20.1679610371343;
        Thu, 23 Mar 2023 15:26:11 -0700 (PDT)
Received: from nz (host81-147-8-96.range81-147.btcentralplus.com. [81.147.8.96])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c19ca00b003ee5fa61f45sm3284873wmq.3.2023.03.23.15.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:26:10 -0700 (PDT)
Date:   Thu, 23 Mar 2023 22:26:06 +0000
From:   Sergei Trofimovich <slyich@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, boris@bur.io, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, regressions@leemhuis.info,
        regressions@lists.linux.dev
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <20230323222606.20d10de2@nz>
In-Reply-To: <ZBq+ktWm2gZR/sgq@infradead.org>
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
        <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
        <ZBq+ktWm2gZR/sgq@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lLb6Eq1VWQLRudR2XeIhZq3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/lLb6Eq1VWQLRudR2XeIhZq3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Mar 2023 01:38:42 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Mar 21, 2023 at 05:26:49PM -0400, Josef Bacik wrote:
> > We got the defaults based on our testing with our workloads inside of
> > FB.  Clearly this isn't representative of a normal desktop usage, but
> > we've also got a lot of workloads so figured if it made the whole
> > fleet happy it would probably be fine everywhere.
> >=20
> > That being said this is tunable for a reason, your workload seems to
> > generate a lot of free'd extents and discards.  We can probably mess
> > with the async stuff to maybe pause discarding if there's no other
> > activity happening on the device at the moment, but tuning it to let
> > more discards through at a time is also completely valid.  Thanks, =20
>=20
> FYI, discard performance differs a lot between different SSDs.
> It used to be pretty horrible for most devices early on, and then a
> certain hyperscaler started requiring decent performance for enterprise
> drives, so many of them are good now.  A lot less so for the typical
> consumer drive, especially at the lower end of the spectrum.
>=20
> And that jut NVMe, the still shipping SATA SSDs are another different
> story.  Not helped by the fact that we don't even support ranged
> discards for them in Linux.

Josef, what did you use as a signal to detect what value was good
enough? Did you crank up the number until discard backlog clears up in a
reasonable time?

I still don't understand what I should take into account to change the
default and whether I should change it at all. Is it fine if the discard
backlog takes a week to get through it? (Or a day? An hour? A minute?)

Is it fine to send discards as fast as device allows instead of doing 10
IOPS? Does IOPS limit consider a device wearing tradeoff? Then low IOPS
makes sense. Or IOPS limit is just a way to reserve most bandwidth to
non-discard workloads? Then I would say unlimited IOPS as a default
would make more sense for btrfs.

--=20

  Sergei

--Sig_/lLb6Eq1VWQLRudR2XeIhZq3
Content-Type: application/pgp-signature
Content-Description: Цифровая подпись OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQKTBAEBCgB9FiEE+g11JqJ4cL44QkmN7V5F4G8qwpMFAmQc0f5fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEZB
MEQ3NTI2QTI3ODcwQkUzODQyNDk4REVENUU0NUUwNkYyQUMyOTMACgkQ7V5F4G8q
wpOt+Q/9GW1oKi5km0k+vf4L+fAKDF/pZTjjqCTj3SOI5HAjxMlYPj06bzHSzibE
ZlW2AuWmDkms+lLVEsq88CKDKNGVIUe3l/z43kP1MtmcKLWXoKGtMPGyMfD2hpdT
8W5zK2MRxNRofn5OcFzUwWYoq1GBB0qIr3uAjOlOssbDuMkLs6pRgb32X+YvOZ2v
mrUZHRbQTVEJoEQf9y4A/MnFVjWvpp4r+CiR9+Qr+Jl6wn7qEbJ8BZsZDIEa/6ZY
X+VtbEmsmZ07c6omP+ZgiShzWxZN/a3VI+fFDusSCgvboiUxaX3r2StaaRnSDLO4
NJtTVUze3uq9au6RsLCYBdf6rCdeoo8S8x2RMIU7VNY1R/IirmUv169W7u2vXGtB
iTDp2xAMTQrXh0Gi5yTNh37Acgiqkp466TEwZN5jBZkHIkY1s/2GywW6WjmDq+LM
H4nTudJ/eUY1sZaCQJb64Y2aK7ikJSurkpms050oZXV0QnAjyXhrLTmhuOFgKFF5
LqwuXE8PPPb0yhxzT9Sxqvnp7kvKZObOU/xbm0GJn8jY3GnsBVQgDknRVlU8AqRF
cxwu5t2bOjftwQD671j1W2HH63iIDsg731m1v03hcNUzNFWfl0AsjZ78Co7NuQP0
FLcDkUzjGT7Dc8gzwFrjwujFHvkhYkO8bE+N5KEQgVOl88yC818=
=lMOH
-----END PGP SIGNATURE-----

--Sig_/lLb6Eq1VWQLRudR2XeIhZq3--
