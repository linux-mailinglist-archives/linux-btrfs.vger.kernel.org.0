Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E5432506E
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 14:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhBYN1U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 08:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhBYNZY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 08:25:24 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BEBC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Feb 2021 05:25:01 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d11so3279998qtx.9
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Feb 2021 05:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sTpa+cy0LcyHYxnfVutPcJ2bo6k1tlUvUKzalYcYcow=;
        b=lWGAfrumx4r6x+RhD4FdAjPW7HCmZhAoa+doueFexMKaGdNYhypKi0jpprezPtCsQD
         nzbambReanTaff+e1FzgUMg6Q/yxubp/L1KeK3afkOaMuzu9XdiwXMo7uXREtv8OtEhy
         hqniQNVvBYLPV8UugDJdV95g6CjGAA9qs1y/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sTpa+cy0LcyHYxnfVutPcJ2bo6k1tlUvUKzalYcYcow=;
        b=iHOOdCI6E28rDRxhxGG29aT61RoZ/hky7PT1q7ylerZlegQxkTfvbriY7G4YYQ22kf
         d63qBH01m2jA1pWIjXNZ5hLMOuC/9HRXVxN1VAJqYuvuAfvTWJl2kuKcBJMqzA48umEE
         IpqxLM2JjIwq0WTPOR5z4GWfV2UcUGJhnFVBkRlsiP9D2iMsFTA5dAj89mSmEHJPDEVO
         iVyMeRd4SRVJ3uQk0fojEtxmPR3SYRjB56WGwNZvAo9EbJI2sk191UZACvBjkfQ+23Oa
         eblldyfma4qfrYIuHwKRaw3UShBAlaovs9JjA8tUZGIM6jRUxHRNKNaDhI72UMCwBxae
         snDQ==
X-Gm-Message-State: AOAM530t3jluRmwUvERl1LCXDDLZbvhkYPjzLlmib3fDBUcEsHezCw8e
        T3h0Fo4dIveUeRmbroVk4qyWaVo2PorZXA==
X-Google-Smtp-Source: ABdhPJwx/987C2x0ZUlpGwM1JF5D3JEh3eZS1HPN/PPDJGo0JG7nLd0OLiVWVTCb7uNlD3bDzW5EAw==
X-Received: by 2002:ac8:ace:: with SMTP id g14mr2246025qti.156.1614259500857;
        Thu, 25 Feb 2021 05:25:00 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b07-927a-4842-8631-dad1-fa95.res6.spectrum.com. [2603:6081:7b07:927a:4842:8631:dad1:fa95])
        by smtp.gmail.com with ESMTPSA id 18sm3291856qtw.70.2021.02.25.05.24.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Feb 2021 05:25:00 -0800 (PST)
Date:   Thu, 25 Feb 2021 08:24:58 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH u-boot 1/2] fs: btrfs: skip xattrs in directory listing
Message-ID: <20210225132458.GT10169@bill-the-cat>
References: <20210209180508.22132-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Jd6iylqttSgi8bZ"
Content-Disposition: inline
In-Reply-To: <20210209180508.22132-1-marek.behun@nic.cz>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--3Jd6iylqttSgi8bZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 07:05:07PM +0100, Marek Beh=FAn wrote:

> Skip xattrs in directory listing. U-Boot filesystem drivers do not list
> xattrs.
>=20
> Signed-off-by: Marek Beh=FAn <marek.behun@nic.cz>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Tom Rini <trini@konsulko.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Applied to u-boot/master, thanks!

--=20
Tom

--3Jd6iylqttSgi8bZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmA3pSoACgkQFHw5/5Y0
tyxHVQwAhC6/DI+8jPVcJp79vO1k5nIpQKEFzUJIsLa6Uy/SlSjFjfewNC/5okby
SkBBTFa7CbXqOBihUBF1C+jKz1YijKJYwsoxLA1CYOCH9NgNQ9aONVLlYOP6lDVK
D2L43v2t9EMmehEz9s7R0wH1ZExunnJGGAASw9Gm3wo80fSZJSMAKYQdkGK3FkSz
VuG09lSyknc6oCh2n4GcQwsINaj2Er/SaEs0V1vUyeOMZ9OmH/7N4rjKLmVBa9pA
cUb45gEU4B/xzQ0A3sOTkwfgfdpj3Ky/9/xGvIAqjuSsaz1X5UJd0g3zXxjznf/v
D2G2Hq0r1JpLf7/ho+ps8Iq958xDluNnV50Oxc9N4p9aqVmmfhJMFv8OWmMDkX3A
aZUwcH5u2IjXFYy10KB28M76DA3v/yx9YrDh3vqXiK4I4KPsCTEubA54f6hkQGAb
tR37KwqVbQ60RkX9a9MGdDgUY9AGwgU/BkNQpNUee6nm1xR24HyFSVRPebwN2S6E
orcsEwTb
=+shO
-----END PGP SIGNATURE-----

--3Jd6iylqttSgi8bZ--
