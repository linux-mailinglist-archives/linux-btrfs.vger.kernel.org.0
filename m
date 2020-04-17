Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985071AE746
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 23:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgDQVJC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 17:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgDQVJB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 17:09:01 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82268C061A0C
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 14:09:01 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id l13so3219491qtr.7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q7k9KCiyhFjpyyKNXEKkIn6qVz4rr3hsae8WKs7E59w=;
        b=g6Ls8mf++G/+shcZYvKrXHamlbCSnIKqjWX4khcBCTWjCkat+iB01HhBsd7SQ5e5xV
         JA0szS36BqXdLwG52dZOCnTQ+umPVf38DVE8vLgoFoo7KOB+d3l0j2PAnfNo4klpsIvW
         o40ubjIBd9zodEEHz4zhAyGn6lYmAh4sf4CAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q7k9KCiyhFjpyyKNXEKkIn6qVz4rr3hsae8WKs7E59w=;
        b=Y01Sap0fGXwZDUIRbPkJZ14bJu5FJGmGWS3wn63bQN29XIQ/8uDHAOzyrlcre5fkmv
         eONtdwX1Vro5eefwuOfe9+5G0c23JXjspvshhoIPN2atHXyEK6DfJyYuWBwDCLR2LDYe
         CSLO5kSdHwKNj0neAOPbDW9dHW3v/ma0hZuk9y5CqI0PIkSMONenlz/JUDWk2b6YYd97
         VU+3jlhuurZwp9Wz4m78xs3AvvMBycBVqJL82qeNChMbZzcLwbk3fYIEoGLmwmoqWUNT
         GH5QuKeweKy+3vpdjvyD5NubBnY5kPTaXlA1udl0UktIYZyh/IZfKA6Vhst1XpXSH/XM
         VLFg==
X-Gm-Message-State: AGi0PuZTLvc3FPznzemh/XonY7S2VcCz1FRQUz2IAe5x5S9RPDBcby+y
        WmG6d8nSM41J+xz/goh/uZBnhJi6N/I=
X-Google-Smtp-Source: APiQypJZB2j1PNvsuoYq15qpo+zEZhMAOwUQ3bIi0oKe1T2Geo7w4M4zyx790TVVKDJWR81WASV1jw==
X-Received: by 2002:ac8:44aa:: with SMTP id a10mr5181511qto.230.1587157740460;
        Fri, 17 Apr 2020 14:09:00 -0700 (PDT)
Received: from bill-the-cat (2606-a000-1401-826f-4058-2b78-ede2-0695.inf6.spectrum.com. [2606:a000:1401:826f:4058:2b78:ede2:695])
        by smtp.gmail.com with ESMTPSA id e133sm329132qkb.128.2020.04.17.14.08.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 14:08:59 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:08:57 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH U-BOOT v2 1/3] fs: btrfs: Use LZO_LEN to replace
 immediate number
Message-ID: <20200417210857.GN4555@bill-the-cat>
References: <20200326053556.20492-1-wqu@suse.com>
 <20200326053556.20492-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="je2i5r69C8+2chMc"
Content-Disposition: inline
In-Reply-To: <20200326053556.20492-2-wqu@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--je2i5r69C8+2chMc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 01:35:54PM +0800, Qu Wenruo wrote:

> Just a cleanup. These immediate numbers make my eyes hurt.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Cc: Marek Behun <marek.behun@nic.cz>
> Reviewed-by: Marek Beh=FAn <marek.behun@nic.cz>

Applied to u-boot/master, thanks!

--=20
Tom

--je2i5r69C8+2chMc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl6aGukACgkQFHw5/5Y0
tyw54Qv/cDPBq1WovDEeH/c7i3Z7thAeIpZY3X4y5kodhtkPiXRqLhgZiKOvcRwL
doC2JQAjIgxtMJpZj6nyqmobv1NNE9I+/U5kQvt+ZAi2GhRL47l/n0FllrdZ+ose
/h0H8AL8wx3CpVbV9OkOGkzY5WxMNmER+dS8rR3PLCpNIYooUUJet+Gdi86xU3IB
p+NPd2E9crD77pISfZZYbMP6ll6l7CJDNdsXHU1zQ8gmwcMBDT2vj214OFwRnSLR
usijq6S8/H/i/8Df3TDMFrSAbSBxrn7jD3YO0qW4SfhLh9AYT29FBAvMCM4by+6x
fFwwnuZRuCXATkp4wRQDXN8LB8hdEGuoRnty6Wne+sbcee2tLSgftciUeT5Qd/sU
Cl5q94QECQ0EeQG3E5eK0tX1Yos5zyPvDxVhyewaSln+4V0GsRw6WVY0xrXg4sIj
zITKoDRUB0/zshhWVe2sYr0u4ZKqOD9y8/b1a8F5QAUsgAcN6W16WnfGn6/fEcR+
gGBsvoE3
=dJKd
-----END PGP SIGNATURE-----

--je2i5r69C8+2chMc--
