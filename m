Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CAE70E4F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 20:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjEWS42 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 14:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbjEWS40 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 14:56:26 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F224189
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 11:56:23 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-562191bcfb9so421007b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1684868183; x=1687460183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTRqBEpMYR6ytA08jVqZCP9o7chg5ckfgHFlwP/rrA0=;
        b=r2UlAn3TrJ5bsNeV5lc/PfiF4RnfLZZCc8h8bqvqiEfj9WT8/SsHrB3HsHy2gSJrie
         FvktPPEnuVsM4VQ25YLA2odMTXoaG3p6O+gifFKQtQO++ueZ9wGoe2w9OsigumQuJlAR
         Zg1TCeZiENQ5XdK+c9H37x5OhWyGc/frlJ5PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684868183; x=1687460183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTRqBEpMYR6ytA08jVqZCP9o7chg5ckfgHFlwP/rrA0=;
        b=ZDvMujlhYbu58lLML+TMNdyoU58I69zF72LfaeylytXeo3wy6PYiVJ7LxI7m+T4ceu
         eXChCgL4ijFqDkdciy9zZXUVQxD9z63QqpExFsTF4Saer7BBIifWECxJ6ONSFWfbeFrh
         pdrxdIdqqOE3yCRyJpmsvxTgDJ+C/2yLR+FLVjtH62P8h8rxhoi7N/QcYmuoL6YLQcmn
         hEjx5mnS+JnU0kw1FOQJYXQ1BDQayQIKaOqv+QJwyV6IlpwYye4o3ii0bkeOyT3HwvzJ
         pyphYhbgbSuwxtkHh4Pbv1gg4M4dpdI5BiZYB+OzAYgbrbj8kBn731Z3cAEaruPpcqwx
         nF/g==
X-Gm-Message-State: AC+VfDyo4H169maw+2r1jGJe2mTo/wpFb1/HacEzgW9sRm0HcYL3QNyF
        SZ9oC6fcKb2/TKzsM6WYXZwn7EUi10ocoqkZqaqP2w==
X-Google-Smtp-Source: ACHHUZ51xmGrnT350n6HjONROOhYvQIZSh54C3JNN6ULF2Ul5g9D8jz2XCiOhfxSw0lCct43DhOrYA==
X-Received: by 2002:a0d:db41:0:b0:556:c4fa:f54 with SMTP id d62-20020a0ddb41000000b00556c4fa0f54mr16949688ywe.43.1684868183006;
        Tue, 23 May 2023 11:56:23 -0700 (PDT)
Received: from bill-the-cat (2603-6081-7b00-6400-5ea1-d61d-d007-36ab.res6.spectrum.com. [2603:6081:7b00:6400:5ea1:d61d:d007:36ab])
        by smtp.gmail.com with ESMTPSA id w204-20020a8149d5000000b00545a08184edsm3071661ywa.125.2023.05.23.11.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 11:56:22 -0700 (PDT)
Date:   Tue, 23 May 2023 14:56:20 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de,
        linux-btrfs@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Huan Wang <alison.wang@nxp.com>,
        Angelo Dureghello <angelo@kernel-space.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Wolfgang Denk <wd@denx.de>, Marek Vasut <marex@denx.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Marek Behun <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 0/8] Cleanup unaligned access macros
Message-ID: <20230523185620.GG3218766@bill-the-cat>
References: <20230522122238.4191762-1-jens.wiklander@linaro.org>
 <ZGvR3LoSN20QNrNM@hera>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bDKOoxFDCy332I9H"
Content-Disposition: inline
In-Reply-To: <ZGvR3LoSN20QNrNM@hera>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--bDKOoxFDCy332I9H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 11:34:36PM +0300, Ilias Apalodimas wrote:
> Hi Jens
>=20
> On Mon, May 22, 2023 at 02:22:30PM +0200, Jens Wiklander wrote:
> > Hi,
> >
> > There are two versions of get/set_unaligned, get_unaligned_be64,
> > put_unaligned_le64 etc in U-Boot causing confusion (and bugs).
> >
> > In this patch-set, I'm trying to fix that with a single unified version=
 of
> > the access macros to be used across all archs. This work is inspired by
> > similar changes in this Linux kernel by Arnd Bergman,
> > https://lore.kernel.org/lkml/20210514100106.3404011-1-arnd@kernel.org/
> >
> > Thanks,
> > Jens
>=20
> Thanks for the cleanup.
>=20
> For the series
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Although I'd like to hear from arch maintainers as well.
>=20
> Tom, This did pass all the CI successfully, but regardless I think it
> should be pulled into -next.  If you want me to pick it up via the TPM tr=
ee
> please let me know.

I'll pick this up for -next after it's been around a little bit longer,
to let people test / ack it, thanks.

--=20
Tom

--bDKOoxFDCy332I9H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmRtDEoACgkQFHw5/5Y0
tywADgv/Uo1O3NWuz4undGg7OzDsVPIIKrHoXR6O/Tl0okJXUAlqkkrRDSGvH0Zp
jVkDjyc8Qtl24GxMkH1MjlblIyddTvlchjFGm0MdnDjti6ojFopd6BaYlKzVaJpP
EU97p+dSBSwwfh6BA+W6lzKIXHHduneHbxJiPXQXJcFSEmsMwSQE/gGq8MrVDCLT
YKTehE1xKsJ7DxL9cJ/XlavVPRO62Z5kn4IVo94thUrWZ52rNLF7AnALd8nCSdu7
lxHv4W0Rse08o0sncQTnIeGx0IS6iIiAIpAjvlZXUU6gZAsGDpSBSYQ0XwkcK1rY
+SQh2LmrQ3YhjCgi9FeBnhEcubpGdP+A7wzfUYdDodkJggkF4DiClynupQ/NxEQ8
M+ooAS+c9iui0d9Xx9AvLdGwe0IPSUBUngNOIkLVCQNfbC1KrGxaEy7GUYXi7F1l
NoRe3612xPslDyNdkmZbyVMW/poizp1+K/nEqS3A3Vg0e1LGpesbFav+b75/UnBi
x/Pr1hKe
=aY+P
-----END PGP SIGNATURE-----

--bDKOoxFDCy332I9H--
