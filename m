Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA19D5A2988
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Aug 2022 16:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbiHZOaf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Aug 2022 10:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344522AbiHZOaM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Aug 2022 10:30:12 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E05580A0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Aug 2022 07:30:02 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id d1so1207196qvs.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Aug 2022 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=7djctMO83sCUteqToXrmSm4HkVVRXqci+u3SX9On+cE=;
        b=J9iTFXaDV5zKnqScM3qCfHEwKY91JI3KS81f3pw3LCsw4UMqIbK9jCTlxzkUp+V+bX
         dKbfrjdtKYjfN+FgcxrLPugRSqmRsUsOpcZfRfdJ/FaU9E8bhaf5ngRODlNB9sA3OcOW
         sHULwKSQg+Y9c0JycF/Ti7aEokvFHtZFF2OBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7djctMO83sCUteqToXrmSm4HkVVRXqci+u3SX9On+cE=;
        b=CLpHU2e7m9Dy0pd25cjpAm1bF8sfyuripkcVOEdD6uiRWPORvsKZ9ej8UVhBVl+rx+
         3eHLLANb0yL0WvZKzwic5AC+gQkGGesNNWc9G5NapMpqKPrHFyHH0Ce1i0X7Ln0+KVjo
         3wrBPUZ8uSp4IkeRNXWwZzqssUXvRw2GjglNjevMbngDVDfhTMY+PZs3UI/YUfH1gNl6
         21H2ZNLbCDh0ZIYm7q/3Mjaj/GtCniaBNR9T3Mouf8fNyYovgN1jt6+giYVg4Qkj2pi+
         5wMS1T0Ys3X4FVh14i1C1Ql+vsnHpMxaXiDLEpjsz6DDSTY8BeJC/jxMFRcAbe5Vz0EN
         kRaQ==
X-Gm-Message-State: ACgBeo2P0QU7WBVwQFrtpEnGc75uC1KZcBgW+0skNnQMC/DpK1kbcsqD
        Jt6vQxBmvDbMK1R/4pJrQYfcLw==
X-Google-Smtp-Source: AA6agR5OFeG1GMQT2U3GUgWkAD+f5eY2z6StvNKaU5RCgy6i1wfJv7eY1seT8Djap4gZPp7OtLwG3w==
X-Received: by 2002:a05:6214:21a7:b0:496:fe62:1aeb with SMTP id t7-20020a05621421a700b00496fe621aebmr8408778qvc.60.1661524201943;
        Fri, 26 Aug 2022 07:30:01 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id f7-20020a05620a408700b006b555509398sm1854285qko.136.2022.08.26.07.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 07:30:01 -0700 (PDT)
Date:   Fri, 26 Aug 2022 10:29:59 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, marek.behun@nic.cz,
        linux-btrfs@vger.kernel.org, jnhuang95@gmail.com,
        linux-erofs@lists.ozlabs.org, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH v3 0/8] U-boot: fs: add generic unaligned read offset
 handling
Message-ID: <20220826142959.GA2641429@bill-the-cat>
References: <cover.1660563403.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <cover.1660563403.git.wqu@suse.com>
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


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2022 at 07:45:11PM +0800, Qu Wenruo wrote:

> [CHANGELOG]
> v3:
> - Fix an error that we always return 0 actread bytes for unsupported fses
>   For unsupported fses, we should also populate @total_read.
>   Or we will just read the data but still return 0 for actually bytes.
>=20
>   Now it pass all test_fs* cases.

We're failing squashfs still, sorry:
https://source.denx.de/u-boot/u-boot/-/jobs/486819#L399

--=20
Tom

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmMI2OMACgkQFHw5/5Y0
tyzu1Qv/ReTXvdoay5Pq8nGzLMiVatpiimZAFQGmXUbKcBrtiloM59Yuc1QAgBEv
RrDdsLZFXunS46iGDSM5aPOio1/gXvz4PrIrSP5ctxtZaQS9TojuE7tHsxTSvfd9
0iawlgkxjjbFIofpO8g8MJGsqxz6TDJ1Bvg9r0/YCNANzY2RJgeTCBtkolelxV+U
QdS+BCzKNIUM69mXKK1C7NSbhh1OXt2tGNEFlTP41qSC5CDdX41Y62LvzYpXT7Ny
QlYfbvubrL3pDEkDNGPeHDusOpaoBrDnfydcYANrl80LXVvdi6vziaI2s+qsnRz4
oUbKLPi/glv//uOcpOy9ebAvYPHusG4K62Czwjf8JO588zM81Ep+c5jNkv1rNeig
pOXDRw84Tc/CMheT7mm+mGS0eDb0gtZ3eLpUIZk6QI4CNaWAIwYUVEGUwNYkt0ML
CguZ5FUMf3o0/DZPYBLlRPIIJEDZEwNzAPb1oUytrpwHwQg370mT0fmbESQe6tvn
jkQ3wgZp
=csTn
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
