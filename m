Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747932606E7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgIGW0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 18:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgIGW0N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Sep 2020 18:26:13 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C5AC061573
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Sep 2020 15:26:13 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id p65so10662199qtd.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Sep 2020 15:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wEROJDNhBttt/ksuY10GjBlngDGo9KzxpI96YctMLSM=;
        b=HoAsGeUS9yL3BYUy8b8au//DnGQgGxS+HlrppEghndMYnsW/34lvrGm/jz+hvQlwI1
         yYImi2/FqJEchVxHS3G73tPwUl9rp/6BfbJBGsVDvgYoseKv1etPdoBkUGFyiW5V6peR
         0Y5hnRm2ME2fCl0O6Z+pLKZt1tscJY+gwEz9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wEROJDNhBttt/ksuY10GjBlngDGo9KzxpI96YctMLSM=;
        b=TkzR3KXY+ZJTyC4JYRilXDORZB3ASFECyGi5K1MEi3Baf79iTek0fkoalT9d/xlqkQ
         z5LQd4lOjwT/Nd8THixkE0QRCzmEBqjUiZJitPtnmc8+tYEQlOfZY8B0Jwm+To2k1LmL
         FN36pyr0k5DAg4lrZSvBXyAbJUi9MzaruppvokKQVLklHm4+wzAykuLfHqGYDMb4ezRk
         nxW8OO0ch6quexssiRafkE9kH6+Exy5wYOyLQwrdYvCujM4Jd67zFH3yDGox3RTjr5/x
         1nqVbrE4RgSDZIPWBDXEAqM2SCS2U8ej/cB28TG6Xbx8Y8uhTfR81kEc2C56X4vNqz7S
         2Amg==
X-Gm-Message-State: AOAM532XHkuHhZmUqnrC6kmhYaay9pZQIVvMOmgksDd+skaTx8peCQ6F
        HJoAUj9jHrXTfcaNccLnSwJH0Q==
X-Google-Smtp-Source: ABdhPJx4L0RVQpprtMnZ2pTK5NstSbf/iEOPvEXfcaJvW593wdesKhseJMZb/3Inn+XB/vufnm3rTQ==
X-Received: by 2002:ac8:5d41:: with SMTP id g1mr22765956qtx.101.1599517569427;
        Mon, 07 Sep 2020 15:26:09 -0700 (PDT)
Received: from bill-the-cat (2606-a000-1401-8ebe-8cc9-065c-5dd5-0752.inf6.spectrum.com. [2606:a000:1401:8ebe:8cc9:65c:5dd5:752])
        by smtp.gmail.com with ESMTPSA id 29sm10919990qkr.114.2020.09.07.15.26.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Sep 2020 15:26:08 -0700 (PDT)
Date:   Mon, 7 Sep 2020 18:26:04 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     u-boot@lists.denx.de,
        Alberto =?iso-8859-1?Q?S=E1nchez?= Molero 
        <alsamolero@gmail.com>, Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH U-BOOT v3 03/30] fs: btrfs: Crossport
 btrfs_read_dev_super() from btrfs-progs
Message-ID: <20200907222604.GA706@bill-the-cat>
References: <20200624160316.5001-1-marek.behun@nic.cz>
 <20200624160316.5001-4-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20200624160316.5001-4-marek.behun@nic.cz>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 06:02:49PM +0200, Marek Beh=FAn wrote:

> From: Qu Wenruo <wqu@suse.com>
>=20
> This patch uses generic code from btrfs-progs to read one super block
> from block device.
[snip]
> +/* Provide a compatibility layer to make code syncing easier */
> +
> +/* A simple wraper to for error() used in btrfs-progs */
> +__attribute__((format (__printf__, 1, 2)))
> +static inline void error(const char *fmt, ...)
> +{
> +	printf("BTRFS: ");
> +	printf(fmt, __builtin_va_arg_pack());
> +	printf("\n");
> +}

Note that this does not work with LLVM (no __builtin_va_arg_pack()).
I'm reworking this call pr_err(...) under the hood instead, with "BTRFS: "=
=20
included in the message.

--=20
Tom

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl9Ws3gACgkQFHw5/5Y0
tyyDPAv/eUef4z9GBkpCzBIcUPuedHuCuURZzyIOCNM0r26SZARzCJ2ibzn0Lkda
3h6lQANUqx1ALo7+KbWXNMrQC3wCz8IepygOlEMLFBLKAd5ySZtiwfk3sQLySxyO
2FxTnhq1e4KGyYxzemfRMn6ghm1awuf25u/Ded4sFPDzEoq9bEz3BJfdYJ++MxD7
js6m1QsEgW6ASSNhI+GIlVOPoZpKojiwTMoJiXxX3GtGCm+xdSLsQKvDFHKz3HLk
gdL2syDKAdALYN7ufmPTd/q7XhbuBwFIhtXL3rTToFozwHJgjK/Pe1CXyC7J+NGh
IPzJy/DIYjx3U8oEkCPBvBnCkK4jeF7I9+iMyfvaXSshToZtfRYzFl1U4rRDxCiH
0jz1FGb51LhJ4p4fGBqKtfwQQ0OjxmVoASLRT7h3IWOhlt1jHJpGEQslEWDfIzjH
dfVbmyPAxo/vLAGlTG88IE5+1IgcbdHgmPXfvmJycc1KcfHDn5vcztxO+XGDuvrx
mVKeiWBo
=OaDJ
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
