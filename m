Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60D0492C8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 18:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347447AbiARRjw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 12:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347431AbiARRjv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 12:39:51 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FFEC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 09:39:51 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id jr5so22060347qvb.11
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 09:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WGjGHAm2jk3oI6CMev6iDkyX+Qq/wOiynz05dmzVQtw=;
        b=BgU01J1aSDHzKjCD/TIzrkrR4V1xFN8B3LFHhpBCMm8dals6rnd8EbyFFNWPvYgsyS
         ZvlrQ/ZKxd+Iul2e1sytcbs7glfhEFBSXDzw6wu0yu8gkg2j1BjA/Q+ultQLn6IzVMjH
         G8Lm955yAkyDFTARzyqz46fRtLKPjtTv1AzvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGjGHAm2jk3oI6CMev6iDkyX+Qq/wOiynz05dmzVQtw=;
        b=W4ZEjkZZJJgK/J6Q4R2hh14mPwH85Py3non8u5lCC2wru6et8509nAD2V86xioE6ge
         sgRUejDvXabPSsoi4ruUVR3CTk8siUa2sjKC4bnlCzfz0S3xdWqxjX7brBYcS2p5eWFj
         a6GaJmDCBM41793WPCwAVayEJ5JmCa3O9wONsWFg1pIIjPUQlEJAapQWflN7jhhqUyOt
         Ce+hajB+Hix4/fnz6D0/9Ck09Welc3WLJgrKCxS7Xhd5yXJsjQnxI2HstSmgauo2sAxs
         pmCGp3tJFJshN0z1XgR1elh68z01QH8qBQNazFdPvbQdcdHHEh3bl4oKLZTb/l4DHS7r
         MMJg==
X-Gm-Message-State: AOAM5321Mpi2tcKHH+d/NYCUqTXctxFv9ReTbXXsay7VyBRu80QWcK35
        0cmnggfBHvQnCzNo2lVvH/E27w==
X-Google-Smtp-Source: ABdhPJzLMA/Jz0YMMraoRVFmubkRe/3UEMVbn4/FWrKh3P9uA9nMoCfFwEHYnDdna20iNjSc9fhvsA==
X-Received: by 2002:a05:6214:23c8:: with SMTP id hr8mr24201081qvb.26.1642527590537;
        Tue, 18 Jan 2022 09:39:50 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b01-cbda-ec5d-c40e-552f-ed0c.res6.spectrum.com. [2603:6081:7b01:cbda:ec5d:c40e:552f:ed0c])
        by smtp.gmail.com with ESMTPSA id t21sm10100256qtc.46.2022.01.18.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 09:39:50 -0800 (PST)
Date:   Tue, 18 Jan 2022 12:39:48 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] fs/btrfs: add dependency on BLAKE2 hash
Message-ID: <20220118173948.GS2631111@bill-the-cat>
References: <20211227061208.54497-1-wqu@suse.com>
 <20211227061208.54497-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sV6E+871crhbObqU"
Content-Disposition: inline
In-Reply-To: <20211227061208.54497-2-wqu@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--sV6E+871crhbObqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 02:12:08PM +0800, Qu Wenruo wrote:

> Now btrfs can utilize the newly intorudced BLAKE2 hash.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Applied to u-boot/master, thanks!

--=20
Tom

--sV6E+871crhbObqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmHm+2QACgkQFHw5/5Y0
tyzy0Av+MKXTSbvHpjJkNUlQti6hP8i8inlm2lmCVTMLCcml9z9khjaM6ChlOl+W
ay8r0Nthpqsy933bU/eh2b6/Q2Ye/sh4kIq5JsL35ZkXhO3kkY9zGr3h6kbkdVQI
ll7Eop+MDQXSkjcRixfiQchPAC+ZZR55R8uvot7xxgSyA7WmGA1VQEOmjTo4O/iu
wZH/SeZeLLWHq/GYOhuTnzxG4mKahNkRiYyHyP09UNr+zcQN/q5RbzEjkHxbg0EY
BxXK84KRFo3hLwExgi4Xq+9xJEV61P+8hc+zJUiEwr198IlHgHhp7avMhKIz4RWB
j2ijiPAc7aNiV1VEVmYBI1KWuoMeuUf7tZllO9728GolgCyvXPMHLy3FPSebLz7G
NY/lEw600SvpERqru3qTLUH32KNxv5KCDgebjMY/TDY3aHiAblkrlWOMs13JOJN5
GIngqGE2Bgi0cU7XDWX+603imTdTKzC0juN13fS0SN2T20NbkN7WEAm0l4y5TXBK
I7A2Me4x
=pFHm
-----END PGP SIGNATURE-----

--sV6E+871crhbObqU--
