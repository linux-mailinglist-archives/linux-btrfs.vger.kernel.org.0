Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739852FDDD5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 01:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390110AbhAUAZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 19:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732850AbhATVrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 16:47:33 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22377C0613C1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 13:46:53 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id p5so11665722qvs.7
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 13:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X8aCzmDKAOE4j5/kWGS3Getv5WDTs0G0RRooT5O97LY=;
        b=FCDA0kIywmdw6/WgNnvGRf6VxpzS5H000F7p4arbTCXeNvKRUA5tehVg4UfLsWMCJk
         VwhPb0ps/TZMEJwRGzdrIj+6RzQigy8CIPXT7e11skYZxSGZTHMnIOVOYSRVPmm/ZBQQ
         8bzxcx3L43VA1Ey06JaW1ft5sYFRNB2q/z2VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X8aCzmDKAOE4j5/kWGS3Getv5WDTs0G0RRooT5O97LY=;
        b=hEqX53gqvotwMQ6yWExtpAI5hxfoL4i2k4V2GoomE29Yi1RZlmmfASmpLoOgL8LA8t
         7SpYXYwX6qPZUoCXy/d/mjEXRzZ+H1vwO8EUla1zuzOU6estZaAFB2HZrJddrrNwRCnb
         Kzaih9mbFjz/a+colghClUCCYWjI0a8MpiAkNC/8ZROfE+saKAmfmlVi20y+aWdxrMHt
         ZiRL+fq/c3A/bB1U6X8g4PENYpLAQDA98mxkRVfdVzkZRYJq9IUzlTTglnjaNlY2I3uU
         POVG9OiShG+IMAioKVbvZoopOuTBeX7mck34VMuLf1gU5C5b+SlRxPEsCPMjz4wNJlWj
         CYHA==
X-Gm-Message-State: AOAM533AUmliZzWJP7igSVayebIR90Cs+WJgQfn0WJKdPQxrgybPB+N+
        za2XpEpknrMGsFO38JmcAR3VwA==
X-Google-Smtp-Source: ABdhPJzkRvGwjAFUIXmDH6BBC5zz8Bp9OhBabWQb+SBPXwBtLS0fSRPYstV8zgswbuxwXNxvgjBhyg==
X-Received: by 2002:ad4:40c5:: with SMTP id x5mr5522681qvp.15.1611179212447;
        Wed, 20 Jan 2021 13:46:52 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b42-3f4c-0c05-11c1-0ef1-bad2.res6.spectrum.com. [2603:6081:7b42:3f4c:c05:11c1:ef1:bad2])
        by smtp.gmail.com with ESMTPSA id m13sm2064039qtu.93.2021.01.20.13.46.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jan 2021 13:46:51 -0800 (PST)
Date:   Wed, 20 Jan 2021 16:46:49 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Marek Behun <marek.behun@nic.cz>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] fs: btrfs: simplify close_ctree_fs_info()
Message-ID: <20210120214649.GE9782@bill-the-cat>
References: <20201225124525.17707-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l+eKMpPSkNEovnc5"
Content-Disposition: inline
In-Reply-To: <20201225124525.17707-1-xypron.glpk@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--l+eKMpPSkNEovnc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 25, 2020 at 01:45:25PM +0100, Heinrich Schuchardt wrote:

> At the beginning of close_ctree_fs_info() the value 0 is assigned to err
> and never changed before testing it.
>=20
> Let's get rid of the superfluous variable.
>=20
> Fixes: f06bfcf54d0e ("fs: btrfs: Crossport open_ctree_fs_info() from btrf=
s-progs")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Applied to u-boot/master, thanks!

--=20
Tom

--l+eKMpPSkNEovnc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmAIpMkACgkQFHw5/5Y0
tyxx2wv+I8U7Qt5yGWj9K+s7JSOkAC7jVW1aPwQNf8/ImTcNMn+HltJS33VYQNWS
mYflnk8wgDU2UJnDmvIGYxqPtrXNrp7OVSlAwYDBvLxyVPvP5UHCvdpf4461JG27
3L4OggBjKrNBGPN7/7oCI+h4YnsTHPTdYTJk2i78vq5LnVgBG20ePb3isqbzCGn8
MioDO6rkxIwq34rgjmtp/JdLtXbDOAAVw8YQFjfoH4FPESE+AG7YSXetgbSTPK/n
+oVFq7C+97w8iqkZiQbyMBOQlyUjwy6SwESv2Gkzz9382SK52K2MEY+yKPFJ1d+w
vfK0G+MphQ7ExRB7EnNdVm9LMkVgISx2RLPzzlu/PA0J9p5wMuzh0D2SUnT9n3Uv
3dZrlIThdhlcTB4dRWLz7xwMlELBNInD2M1YS6O9Vh0HndRdhcs9E1jTg5xJSaZ5
61Y66H736HPVQNWVSmDoQg/M0cHvRgFOaytyrrJ7I28GMOoNTumzMoRTGZPtYrsX
yTHzqQrV
=iEf1
-----END PGP SIGNATURE-----

--l+eKMpPSkNEovnc5--
