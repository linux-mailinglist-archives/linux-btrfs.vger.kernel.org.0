Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6536358094B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 04:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiGZCMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 22:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiGZCMl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 22:12:41 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A781F28715
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 19:12:39 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id m10so9744233qvu.4
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 19:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JHEl4AsUGM2/gSizYBBfeutiug8IP3uRWF4Ytkdrbvg=;
        b=XKCIA4PLHALCAXI1cRbpmJo0JCQWA9+MmPFEsxMPxts1mCWLtE5d28ctL3AJmlSGHe
         tuVqLvMmw2h9MBuWKPBTHqyFLZPPMPqlV8dvoX65fjtmaHZ34NK2AAXoxvuc4nrqd5PI
         Tloorl3JUxNA3CF/GJGlxc3j7s2aqXGzGfyxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JHEl4AsUGM2/gSizYBBfeutiug8IP3uRWF4Ytkdrbvg=;
        b=x3UfgS10X6glQTB9Lm8yxPRCN/GBZzpWtaEMFSVToV9ODf8XJ70Bs4rpgh2M3sZxd4
         KFTi0+Gv5skZ6QM3x+wIzZIzr4WgQs18MivbIXcC8B6fbw6bcngNDkthrnyJQ3NEq7d2
         wdRro4iKHt3Jp6SlX64cXSaqJFCccCoxqRSn/0bpBpY4XySFXUUFliA60C7Vrc+8KUu8
         AU48XlpMbKeMkuUryKNnS5O5p5l3NjqnbC7bMJumSLNe2d58IjxY7YzD5NFmRTe1IAKj
         Z7OVTr0lVY+pPPifNjppfTd2YZJ5ko55JoOOJaWIU2csvsenGRpwAWUUlE56BLIfACkg
         uVtQ==
X-Gm-Message-State: AJIora+ynJPpuEY/VveSjitnSwhubs8iPWiGbM/DVGa5R2taIQo6xGYE
        +VdY9bgyfBjUtv8efemsSJ2tJxyUmC8Mnw==
X-Google-Smtp-Source: AGRyM1vTK5tY/1suFzgnsOa4YOOdPA42xGdhEl0IFNgTY/LosxdnFPYOqQPqht804UrbM0+bXSee4g==
X-Received: by 2002:a05:6214:19cb:b0:474:5447:2090 with SMTP id j11-20020a05621419cb00b0047454472090mr4303603qvc.93.1658801558834;
        Mon, 25 Jul 2022 19:12:38 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id m9-20020a05620a13a900b006ab935c1563sm9785937qki.8.2022.07.25.19.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 19:12:37 -0700 (PDT)
Date:   Mon, 25 Jul 2022 22:12:35 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de, marek.behun@nic.cz,
        linux-btrfs@vger.kernel.org, jnhuang95@gmail.com,
        linux-erofs@lists.ozlabs.org, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH 1/8] fs: fat: unexport file_fat_read_at()
Message-ID: <20220726021235.GI1146598@bill-the-cat>
References: <cover.1656502685.git.wqu@suse.com>
 <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656502685.git.wqu@suse.com>
 <20220725222850.GA3420905@bill-the-cat>
 <6271e1a2-db85-fb20-6ea8-d23afcb6bc69@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J7ZhEZwEjSe6poEw"
Content-Disposition: inline
In-Reply-To: <6271e1a2-db85-fb20-6ea8-d23afcb6bc69@gmx.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--J7ZhEZwEjSe6poEw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 09:35:51AM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2022/7/26 06:28, Tom Rini wrote:
> > On Wed, Jun 29, 2022 at 07:38:22PM +0800, Qu Wenruo wrote:
> >=20
> > > That function is only utilized inside fat driver, unexport it.
> > >=20
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> >=20
> > The series has a fails to build on nokia_rx51:
> > https://source.denx.de/u-boot/u-boot/-/jobs/471877#L483
> > which to me says doing 64bit division (likely related to block size,
> > etc) without using the appropriate helper macros to turn them in to bit
> > shifts instead.
> >=20
> Should I update and resend the series or just send the incremental
> update to fix the U64/U32 division?

Please rebase and resend the whole series, thanks.

--=20
Tom

--J7ZhEZwEjSe6poEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmLfTZAACgkQFHw5/5Y0
tyzamAv/VH/kckEoZrZfP9tTiGmXdHr8Cx9Moey60Y0h8J/WoUaWdZiVF8wNbI6e
8teJBnbQnmJoeG7BGcbQNv4z+r/G6V1qX8wKjdHvAMArRIg2HmeDjRl50oHTUmag
BNQEBzE5nSGrz03GOUuSTeey1uQjwHHAiNVxRhJ6e9j2SEpBgDv3Nc2Ohycqowui
v8xsSaEiXFOcI4PUoRjo0+EIoIjvWRMXYbVbAvqtXI9oMSTISfKpMTvi5dvHvICz
ANCN9hkiIzXu/hAQ7dQA4/sVfUhc2E4VSkfY+0NkUQrVxtm5VN/beMeiUNesoFcz
tMRy7dN81IKJrjVbp6Qu+ZF7rC/ZTTXqRZIzjh6gfuwqPnHcTYoSOSOlMVnlAcpc
uU/34xyLOMBr2me1e0tdm9QQ8yQOTPF8VCzoo3OnSmLpgTUuKYg+RmQD68Zv6Pfr
tBqhfam87jCVBlt8CRBI5LFSGEnulBPdG2IbM6FLHD0gX1HyCBK8PR9aBL7Rdqo9
XO0aET4o
=EqzV
-----END PGP SIGNATURE-----

--J7ZhEZwEjSe6poEw--
