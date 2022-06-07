Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE04F540409
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbiFGQqT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 12:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiFGQqS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 12:46:18 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8966F504E
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 09:46:17 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id hh4so13023801qtb.10
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oqkEyATW5JHzGRUk0deWgOQZKzq24pQmEDmqPi9iI9w=;
        b=mDZv+zTAbM1LVouEhwI7/n4So5M5T9YWXSr66/oin+yO1R5WRxBgCXKryKylYLXYDi
         IsG6W1nGb/ekt+qHTK345sxRkGX0dUBRVnRn5C4TJ4VoMIIHNWc+bKzfrSQT2X0IIRP4
         pz5WTWMpAVy5ogzZEFHr4NvSuliLS32c8SXHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oqkEyATW5JHzGRUk0deWgOQZKzq24pQmEDmqPi9iI9w=;
        b=nBRdy+VdipW99/H2QosSq5TvzDFV6oZ8EwTqd51A3MvSznjwytwRv3efWEW7nO5Ny4
         lN1+E0lUiQ8NTCJSn0awdwV7QgoundxaBPKENrtVGRFByQaDHpSPCe53WHeoQNgELaVa
         o1iH20QZ1+4TosridUyyLPNoeX1131X7v96z/lPmXIUJyuABRyjJozGw/sxRXRXXM2Hi
         4m78QvOees3DH+0U5OnNrHnuxw3GGxKPlO6fWxQmtZg1UTQKga3EY9ikBgOjKXP0Ry6U
         4kxN6T+3W4trpk9pPlc0dQvoKiURESJRe7I0smFd9H16lCyWPozVW9mf3Vkyb4Y/y99X
         MKQw==
X-Gm-Message-State: AOAM533SiqIYv0H4bm6g9qIslut9X+TJ0OPyXVKdUH70iR8MBKFulYd+
        8p8rZ3PZqx2n/3nW4Pw0AfnX6w==
X-Google-Smtp-Source: ABdhPJy5tNFMcwL4P7nl8wNW0mnm2tGu3HQ0PLKMKNhejBS5S8xSSgJB7ioJMK/rQgRZ+jD7jOT03g==
X-Received: by 2002:ac8:7f8a:0:b0:304:ce5:6a2f with SMTP id z10-20020ac87f8a000000b003040ce56a2fmr23570944qtj.563.1654620376975;
        Tue, 07 Jun 2022 09:46:16 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006a6bd2ff3adsm5432903qkb.20.2022.06.07.09.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 09:46:16 -0700 (PDT)
Date:   Tue, 7 Jun 2022 12:46:14 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Marek Behun <marek.behun@nic.cz>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] btrfs: simplify lookup_data_extent()
Message-ID: <20220607164614.GG2484912@bill-the-cat>
References: <20220510194338.24881-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline
In-Reply-To: <20220510194338.24881-1-heinrich.schuchardt@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 10, 2022 at 09:43:38PM +0200, Heinrich Schuchardt wrote:

> After returning if ret <=3D 0 we know that ret > 0. No need to check it.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Anand Jain <anand.jain>

Applied to u-boot/next, thanks!

--=20
Tom

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmKfgNYACgkQFHw5/5Y0
tywQhwv/So7p/XBCs1bRJWX5MzbIUv7fy7SzGlLIRI7k7aJll08nt6jPWWSHMwf5
2T8Zrky3Zw/DANXIO6Esg3dBDUq6qFTT6icZjyVyBTJxW6GP4EhnsSTla9FzOY/i
DxONWfQPp9gzEVEjVVFlHGFw+GJphAruYSlMyOB7H3XfHTo4tIIbBL1V+XGUlFCt
7U8cA6ulk6BQl6iqyWrxx1KkC9VNttlvGSY8HRMz1RrTVC3mbsybYDDMfjdMFxAb
BqoVJUpjYc4f4BnPnfa0TS+3shGJAbPWPMr1Bkz3FWeWmllD4rR8L7X5JgZlP6xd
+nHeNhQSX9e0Vs52TmKogDCAh9AF/LyPCmiI0DShRK2EltQ6VvgEg+Om7P7VrwB3
FyUrPTIaq6vp5StIDSpvDcRvmAJ4wHMUSHOv99q2r+iJ19dzibjM1h3/xoxpOLfk
1kVcq+JZzVEvbuppQ1oFr2jkirXru2YH1QYweauEHKGHwvQ85XkGD8ON2Z4hJitC
5mvpo9h9
=OsWT
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
