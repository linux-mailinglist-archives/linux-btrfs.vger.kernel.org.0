Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32966325072
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 14:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhBYN14 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 08:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbhBYNZn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 08:25:43 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D772DC061793
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Feb 2021 05:25:05 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id w19so5489741qki.13
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Feb 2021 05:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=inYPpxPwJG2BYPpBgcE6xlzzrofIrJInlhcpS4qdOi4=;
        b=s7AVrO+k7qhn4xqjUYtDNdmTZuSdaQ9oBhX+kSvLNOqfqTNQK+V2xm0JvLTA2gAg1k
         5x8V9n1O6iwXwTevXz1yBFYw5yMLm7gH/YB/SgWXhMAxEAAppAqw/XecOUwSxVgKaW2Z
         nk0svu0rYVGIXOY3vQMhCzlAa96iG5vczQJEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=inYPpxPwJG2BYPpBgcE6xlzzrofIrJInlhcpS4qdOi4=;
        b=lzv8LqiRJQykgTu3VWfKiVGQ76zDyn6O0ci3yRGztMhTIsKq+/tjPNNNyJ/IEGcCva
         mM0y+/RY1/rkXJqa9/BSqBBj3STrNcLCgQjD3o8so8Eqz2FbBGsNLfvkMBBu4tJUuFio
         tt37wUNOGT02qGwb2Lq1GSOp3tf48als9MOnqXcWRJzgX/WIm/2oSOCg27DZSuJ0yJnL
         HAebThzAQOBTWDPGLs3u8SUmnV7ckgDF8zUzyl9klI+hsqk5W7RKWS+RGnOEd0/GpdCJ
         CiRfgOELWd+GhW7+bXOFkbrQXInPDJfUC3QR+80GXSmtIDx5SCw9xSg3ApJw3+FoG4W2
         TP6w==
X-Gm-Message-State: AOAM533nbOx14ynazGYygk0ZafM3S8zhYlCFcXF3gqF7pI2WEY1c9XGV
        VgqyoLPFtb173gqUgysuFRSGtQ==
X-Google-Smtp-Source: ABdhPJxHhI0Md2TDcUXXizBELfEvK8v4RtWgE5bEuk8nx79wfhz1JiB/btOSITh658UgYkKEJ829CQ==
X-Received: by 2002:a37:6492:: with SMTP id y140mr2452620qkb.415.1614259505144;
        Thu, 25 Feb 2021 05:25:05 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b07-927a-4842-8631-dad1-fa95.res6.spectrum.com. [2603:6081:7b07:927a:4842:8631:dad1:fa95])
        by smtp.gmail.com with ESMTPSA id p81sm3899813qke.18.2021.02.25.05.25.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Feb 2021 05:25:04 -0800 (PST)
Date:   Thu, 25 Feb 2021 08:25:02 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH u-boot 2/2] fs: btrfs: change directory list output to be
 aligned as before
Message-ID: <20210225132502.GU10169@bill-the-cat>
References: <20210209180508.22132-1-marek.behun@nic.cz>
 <20210209180508.22132-2-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bu/gFhZaPob7yHqb"
Content-Disposition: inline
In-Reply-To: <20210209180508.22132-2-marek.behun@nic.cz>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Bu/gFhZaPob7yHqb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 07:05:08PM +0100, Marek Beh=FAn wrote:

> Since commit 325dd1f642dd ("fs: btrfs: Use btrfs_iter_dir() to ...")
> when btrfs is listing a directory, the output is not aligned:
>=20
>   <SYMLINK>         15  Wed Sep 09 13:20:03 2020  boot.scr -> @/boot/boot=
=2Escr
>   <DIR>          0  Tue Feb 02 12:42:09 2021  @
>   <FILE>        108  Tue Feb 02 12:54:04 2021  1.info
>=20
> Return back to how it was displayed previously, i.e.:
>=20
>   <SYM>         15  Wed Sep 09 13:20:03 2020  boot.scr -> @/boot/boot.scr
>   <DIR>          0  Tue Feb 02 12:42:09 2021  @
>   <   >        108  Tue Feb 02 12:54:04 2021  1.info
>=20
> Instead of '<FILE>', print '<   >', as ext4 driver.
>=20
> If an unknown directory item type is encountered, we will print the type
> number left padded with spaces, enclosed by '?', instead of '<' and '>',
> i.e.:
>=20
>   ? 30?        .............................  name
>=20
> Signed-off-by: Marek Beh=FAn <marek.behun@nic.cz>
> Fixes: 325dd1f642dd ("fs: btrfs: Use btrfs_iter_dir() to replace ...")
> Cc: David Sterba <dsterba@suse.com>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Tom Rini <trini@konsulko.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Applied to u-boot/master, thanks!

--=20
Tom

--Bu/gFhZaPob7yHqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmA3pS4ACgkQFHw5/5Y0
tywXLAv/c8flXr9i01KbSiS1DLSJJ4z8sf68pKUh58IV3J5hEhKUX9E+Yddu3tvp
55t0OYVfiod1AvzPGME0SXb1/Okf1UTzKc5jdHcq2vEFb/BFMWtPNA/cjPL25o1R
AsUKG74Kke+n4YZYI9vSlBNYoLmuwhxc5X3CvZJm0Bf2bbXWnEWfZnfC+zhKv+PE
FVsfUtlBGGDK69jTn0g0VUgNlZTyrN8QjXHEuu2pPdpJIXK+28JhZBCQSpmCC7RY
ABUTNjORC/aUjEgE3Ydi7Ccr2H0skzOoKU0049aiHiuIt7B/usqtSlvpkLNcmnoL
lts4qn0kchZgo56EJ9wzEwCQnIiVcr/b4ghfi3m0kvOx6UUt4g1dMEQo4jV7bp/A
ctVF7sS7/yruJyz+knrssUMqMcj/So78pcDCjN3iy2nX9QT+1MVth2lzKbVga25O
jr/f2u+0bxtk9tWJzndH9TUo1yO1i/f9G4CBubCbIGRbHTlUL59UM87F2bwC0/dS
V5Zl3RH4
=UOix
-----END PGP SIGNATURE-----

--Bu/gFhZaPob7yHqb--
