Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A397B58B106
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 23:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbiHEVO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 17:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbiHEVOZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 17:14:25 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DED465663
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 14:14:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id b18so2912270qtq.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zmIQUD9k3oMh2xY+Lf9iRiwwBZTO4inqzTNpKNqiUnI=;
        b=ebV62zXa/egD95xHYq60v5ND+BTzIWXpM3mOCD49LABCgpbKmKvXb+xy4YJWRRQM9L
         0rJCW2qZu/fPZtYfs7SicMyosjuFkfbGpjQsv5AJNlEihxUNvwWR5HqiGQaU7kaXnIQE
         GCBJU/r2RKmgdWX4h/6tCBfAQc2xCfPJ1DVQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zmIQUD9k3oMh2xY+Lf9iRiwwBZTO4inqzTNpKNqiUnI=;
        b=jJIDf5E8yGoTrpbzqTFNhxHG4sMDUKE1u+MIxpsxOd2PhX3YE7CWaX68UYhE/bGJTl
         QDwNo8k7bSq+x+S6FQ9gdS67N6IRhvoUZPX+tG9Fylpox9v2GJgyDHx9wd1F+xXe2J8y
         EX9UMcsXhGrtsrGNn15OnMfRSYQAreZX/9eAXBfG7cFhFPNN6Ledtkt26Zn2pTk12kd+
         FmJhbGP5cXaAxSWGECNteL1pPzmhQWn+qTyAF7mlL9Bb20L7c3QNmPGw9KbNTMePWhfO
         MZK1wEl0t+5MMLtIR+lRxkPQPaEPxF3JwbhpNfhoC6Fk8zJdU8mLloWBM7rTAAeQ1mqF
         QOGw==
X-Gm-Message-State: ACgBeo1Qh8GBKwuWTllB0or+qIC+m9jMNLa96RnTVLrGN+Mzb5IT+KBs
        /6xhVXw5HRLT+IlQCkVZ/dV/KDrV3ij33C28
X-Google-Smtp-Source: AA6agR6hdIK5rNSWh2Q8F6vp5nMGNFbxXbyqpr7lwsb1iYaN09spPJoYqETC1LYz4kYLN25wveGHiQ==
X-Received: by 2002:ac8:5a4c:0:b0:340:91d8:f217 with SMTP id o12-20020ac85a4c000000b0034091d8f217mr7686483qta.90.1659734063249;
        Fri, 05 Aug 2022 14:14:23 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id j2-20020ac806c2000000b00304fe5247bfsm3152129qth.36.2022.08.05.14.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:14:22 -0700 (PDT)
Date:   Fri, 5 Aug 2022 17:14:20 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, marek.behun@nic.cz,
        linux-btrfs@vger.kernel.org, jnhuang95@gmail.com,
        linux-erofs@lists.ozlabs.org, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH v2 1/8] fs: fat: unexport file_fat_read_at()
Message-ID: <20220805211420.GA3027583@bill-the-cat>
References: <cover.1658812744.git.wqu@suse.com>
 <ee01c16f20f02230c3cfd0b266f06564fa211f62.1658812744.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <ee01c16f20f02230c3cfd0b266f06564fa211f62.1658812744.git.wqu@suse.com>
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


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 01:22:09PM +0800, Qu Wenruo wrote:

> That function is only utilized inside fat driver, unexport it.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Unfortunately, the series fails CI:
https://source.denx.de/u-boot/u-boot/-/jobs/478838

--=20
Tom

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmLtiCEACgkQFHw5/5Y0
tyzViwwAjplcVzC8GpC7tnQx8Xb/E8+UYXJ5daXce5nIbeGOoOWnkQMgF4ZdzySK
UXYvQbpwToKHTLDzKhEBrmvZtsHC3nivADw1njcn+O+tQHOWJQk5tBd2ZHyTZhsE
b1ZskG3xeNqoZSjGqFpK3YkDWWHaSnWIjufZhuxbQ5yzv5EFnonJZvQ6bQYIZAwp
SDHhN4gTbWaR0Trlkv+FnQI5D8uu3d2fc0Eqav4IuKVakSjf6fulJODlnwcHcs9z
4Ux+btq6RkanERySlcP5aKi6oLKY56V5AwQM3h4V1yqYiYC7T7tnPIEx7J91HESc
6Q62mPAbjJ5+Wq3ogTNj61PGyLIMrEdAKPbeesI5uFz8/KWZXqxWQb6Hj2Znm1aY
k59RNKyIrzNyj0MiR1Rwsu5B9onlYK8CPTszIhGITTer27dnc2d2pKZA1pO4cESV
2EEnsXFEUBlMA99NEccpe5cNeT3BXPmBuvUEMmwxVyl0VYTt+GNro6hRB9G+Q9oI
tfapHCIR
=4wU9
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
