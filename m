Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A1B70D0AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 03:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjEWBwa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 21:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjEWBw3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 21:52:29 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D98CCD;
        Mon, 22 May 2023 18:52:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53202149ae2so4641266a12.3;
        Mon, 22 May 2023 18:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684806748; x=1687398748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJHAFjFAFtXjAaqHIvSdrHTyDRtStagvgqxmFGoZrEs=;
        b=Q1ivivjYzqcZM+FCwjRh4OgXuEHgSTMaQeOeos2jjM79DArhX3fq1r47YUeZwlzF8y
         JI8PUflxQQlaglrZcf9GQTBU3oKLX/ijR4TCm6GkQNZU9Do4ZBFzRw2LhwsxNkNTGNcS
         QBKg+Xd0HTDJFKXKsTiXzLXc6z3dWgNT6X4SUX3kdzBlDIbIzDIXMfhUBr0Q8MTgl4b3
         L63/4sFZNnWGVj95q0ND8i8f9B8z9lBx/OPSdY69PgbDD6/7yfW8NqQ8NipXDX6Q1PJB
         G4PVfnbbj+VRExEp71iDQtq1oIFe1NVEtaY6kAMP40TNhE8K8/Oy0w/Zjr2bBAi3bsox
         5WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684806748; x=1687398748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJHAFjFAFtXjAaqHIvSdrHTyDRtStagvgqxmFGoZrEs=;
        b=jjdjZEEJ72bPLvYChyupFZ32W29L4XRBSsnEaP4NV2sYVqNE3Z9A6L/HwbShatwq9u
         +gOmXFlJtvzw2G4We1HBedE+zdiOym0z989rD5lKbQSz8a0OyweSBbCUX7/c6enAN9Eq
         rxJnuDqM1ByUYXTGuuWGFR83I9gAkjDkAraPR2Px6ZMaGjmclV088na82pDblePADtW1
         gdspTQt029dHlZh+th0cTemLrdyj19AiByL+YpkjZfyfJjz+UO+95UyDdPpZEuq9Gevt
         vIyryoDfYcYfQYZwDDe5ByUN0Se0MMVx15nL9A6lp1sgugFCRRneml3n1PyoHcUCZROY
         pAVA==
X-Gm-Message-State: AC+VfDyGytqyn0bdtbhlqR+XVJmQVi+vnh3Cv1Ha7dsVN071I37clD3r
        FMxA+Xn6JMocHRz5lbaTk5I=
X-Google-Smtp-Source: ACHHUZ65ZrBdnHglzvC2r3og9XZPcPvr1clzbhLbJrV2UUKfcgNkL/RDkzgg80OEUwNJDiuQwvH3LQ==
X-Received: by 2002:a17:903:1208:b0:1aa:feca:b616 with SMTP id l8-20020a170903120800b001aafecab616mr13317495plh.65.1684806747723;
        Mon, 22 May 2023 18:52:27 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-65.three.co.id. [180.214.232.65])
        by smtp.gmail.com with ESMTPSA id jj20-20020a170903049400b001aaf1679c9fsm5423489plb.221.2023.05.22.18.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:52:27 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4A973106998; Tue, 23 May 2023 08:52:21 +0700 (WIB)
Date:   Tue, 23 May 2023 08:52:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Forza <forza@tnonline.net>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz
Subject: Re: Fwd: vmalloc error: btrfs-delalloc btrfs_work_helper [btrfs] in
 kernel 6.3.x
Message-ID: <ZGwcVTpQNBoJHBB+@debian.me>
References: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com>
 <fcf1d04.faed4a1a.18844d8e78f@tnonline.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vilJHAGKshW8eYzU"
Content-Disposition: inline
In-Reply-To: <fcf1d04.faed4a1a.18844d8e78f@tnonline.net>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--vilJHAGKshW8eYzU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 09:04:05PM +0200, Forza wrote:
> I have a similar experience with kernel 6.3 where vmalloc fails in a simi=
lar way. I was able to reproduce it in a QEMU VM as well as on my system.=
=20
>=20
> https://lore.kernel.org/all/d11418b6-38e5-eb78-1537-c39245dc0b78@tnonline=
=2Enet/T/

Thanks for your similar report. Telling regzbot about it:

#regzbot link: https://lore.kernel.org/all/d11418b6-38e5-eb78-1537-c39245dc=
0b78@tnonline.net/

--=20
An old man doll... just what I always wanted! - Clara

--vilJHAGKshW8eYzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGwcUgAKCRD2uYlJVVFO
o3JoAP4i8o9ucMk1qqpBMd8ABO/bcREF3CrJ2WPC/g31f/TX0gEAxA5XA9TJOQcO
qMAV7/h2Dj3zsyNZYLkYlk+euTGovgM=
=Jj6d
-----END PGP SIGNATURE-----

--vilJHAGKshW8eYzU--
