Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2292858075D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 00:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiGYW26 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 18:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiGYW2z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 18:28:55 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D1F25C4C
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:28:54 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g1so9794916qki.7
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+xQtkdVaNJTMiU1u+MD8iiV+11h/TXTsRFBJEbK7Xz0=;
        b=NcqMdFDo6vPwMuVMeXUfcDR55bYPgtIb/sYI/LO6MBRPjbpVjxBQoB6GtH5nu/leu0
         l05lEHaSJAjdxEl6QygQ4TcDE6M3mASmPUFv+Ua1y1D3MJmxL/COlHtldokZFaYZe1L/
         uZ08CIFEQMqM+KGJZcC5nRgeS6QSMq3cEfLzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+xQtkdVaNJTMiU1u+MD8iiV+11h/TXTsRFBJEbK7Xz0=;
        b=aoNuDHN9i17VvMemWfO0teZ8nxAQDTvTj/3FehfeXqGlss0kx8cAGbOxQQcBq1y1cw
         g4Esx9xRyAhwY9tZ7CjV2eu79cRAu6pDPIXp25bgw5SCOcnc/3gwr+rmWoroctEmQb9u
         e74b9z8Ycj3Ce+PzaQwhrB0t05SIxhpnNrz7ASHa9LlAJbEyfwG1Q7PRo8VXs5M3r9R6
         HRPIZFrJ7TBgC20Tl61t+dODg4bp4ZPte8ExsVArWuR8L0ob076JzHU+jfBHocNWA9jo
         qmUZwV/4ZCP+84dPPtOiT7RFx+RwN3Mb3ZXYf94Iiuec8iEZhU+AOAIdcefFpiwWRrd0
         7Avw==
X-Gm-Message-State: AJIora/ITrgV9ebaANg0IvQ0S6zGZt099d0FviIZnz9Om4B0g04zs4fa
        KOo7lBMZrVGjVa2jFNI8hJyUgg==
X-Google-Smtp-Source: AGRyM1sQ8FUKeGgrHslcELzZIe6d6F2Fc9q2i4k9e+Tfb53eheHW1EJ65xaUrQmLewB6k14ykr5l8w==
X-Received: by 2002:a05:620a:e1d:b0:6af:33de:ed35 with SMTP id y29-20020a05620a0e1d00b006af33deed35mr10928525qkm.270.1658788133280;
        Mon, 25 Jul 2022 15:28:53 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id n5-20020a05620a294500b006b5df4d2c81sm10494676qkp.94.2022.07.25.15.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:28:52 -0700 (PDT)
Date:   Mon, 25 Jul 2022 18:28:50 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, marek.behun@nic.cz,
        linux-btrfs@vger.kernel.org, jnhuang95@gmail.com,
        linux-erofs@lists.ozlabs.org, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH 1/8] fs: fat: unexport file_fat_read_at()
Message-ID: <20220725222850.GA3420905@bill-the-cat>
References: <cover.1656502685.git.wqu@suse.com>
 <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656502685.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656502685.git.wqu@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2022 at 07:38:22PM +0800, Qu Wenruo wrote:

> That function is only utilized inside fat driver, unexport it.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>

The series has a fails to build on nokia_rx51:
https://source.denx.de/u-boot/u-boot/-/jobs/471877#L483
which to me says doing 64bit division (likely related to block size,
etc) without using the appropriate helper macros to turn them in to bit
shifts instead.

--=20
Tom

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmLfGR4ACgkQFHw5/5Y0
tywnkgv7BsMaSsvuizP3WkNmfj7bbjU584W+IHj4/nIQ1dpJk3fAAok6dFAJOYR+
BbRTRensgyG00SXOeGBQBCULE/bQ5eeiGrxMjg7ThSpIUx1llXMmQBrLmXS+IJb5
4aFFZ74J5v8kLjt20lstTWhdcgd8OJoCBVvp/Q6NarkxlQFbhZwL3y/hy+6eNG9B
Jd70zBy8898rUkKvNiOtgen1WKOPOU0eMhOlfryzXW+1tve/so/D+G8WTTOe71nd
W2YPAALogpMwIbBgfi8A4vE0qDNw6o/7JYjGxHOHxLGb4CLmHp8HNxx0ln0xxNsG
2BKDLWVuoAk9Lff9yqYQSyl3t6iqgQ2eLtZ+iYq0G8/qu3hxH8to6wfwZCPVfiwz
XSmAzm9qrF1vOW9bwOEnSk6fQYd+8bqsZssIEobJJww33Y89VBQkvln/A2sDvsdN
SbcsDI8GLKWy8o06JLOrgjhAqPC6RV9NBNdT54obaDyn/NPIoZislmRzc9eiaPu0
hz1eGx+P
=Om0f
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
