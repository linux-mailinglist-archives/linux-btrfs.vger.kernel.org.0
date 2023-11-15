Return-Path: <linux-btrfs+bounces-142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6557ED10B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Nov 2023 20:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D3528177D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Nov 2023 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0622C3DBB5;
	Wed, 15 Nov 2023 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="lskkaFgp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF88D1A7
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 11:58:59 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41cbd2cf3bbso10935021cf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1700078339; x=1700683139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+WVC/yz1CbxK1ChV0GIXyLZcxYCPKHv8C+V36wbzQ3k=;
        b=lskkaFgpQoLx0wYFUaWsM1iZkWDpo4OA7o2Y1pFccNuqJ7XT5jByXs6nEODhAI+iAT
         2gW5uqgxBfrAA0vWHjSbbZxkj1VcZqTmcmHUg1t3s9v+E7qrinJUI9CBIDHcQtiBiXTy
         5ur19wifCbNyAMMVBD3A33rPDfcmhdMsowxHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700078339; x=1700683139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WVC/yz1CbxK1ChV0GIXyLZcxYCPKHv8C+V36wbzQ3k=;
        b=ENfe7rNSxVV7jF/4/d9jJgoDCShTmXyugQ1g67c3wMF7PLqBlhaNgrp5ABkLi+o/4J
         ycuXS3OJmP+NSiSx3kzdxjvcm+6+L7dzkz+UGbtOeFiwCBa7kdoZ0mEjYo6UbRtEgWYk
         lFSsmuPsWujzsfPYcTVQCzIjnVBNIIbVK4a6gBVwB7JfUvioBR6wp+pXuFsVoIAQUslk
         sfrhEiyTIlbPUyCC3BIUCQnP2LsxUj/XwN7SCLQx1gp60ACGfMQli9syKPYeQSKGkl6T
         FEtZnADzeM49ZVc7P0hJU4V4ekVwgNixV0DuOlJEAdYbpGQ6fLfBMe27TqmtSQK2xd1c
         hAAQ==
X-Gm-Message-State: AOJu0Yw/saybm+TLTMC+wY0hLICBgai0OYqG551qqMAH4gcyTVlloUY7
	wQDRVBFMuIP+FRZRT0V82gQxcw==
X-Google-Smtp-Source: AGHT+IExha4wwmhoXWcqcWNwYR3aTr+JBzbY6exrtzk+BmGqifUwKEdueu5TE9HaCe4IXEQJ5gmGBQ==
X-Received: by 2002:ac8:5ac7:0:b0:417:953c:ff57 with SMTP id d7-20020ac85ac7000000b00417953cff57mr9599583qtd.14.1700078338759;
        Wed, 15 Nov 2023 11:58:58 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-03f5-0f73-ac9e-a6c1.res6.spectrum.com. [2603:6081:7b00:6400:3f5:f73:ac9e:a6c1])
        by smtp.gmail.com with ESMTPSA id u16-20020ac87510000000b004033c3948f9sm3770075qtq.42.2023.11.15.11.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 11:58:58 -0800 (PST)
Date: Wed, 15 Nov 2023 14:58:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
	Evgeny Bachinin <EABachinin@sberdevices.ru>,
	Fabio Estevam <festevam@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Michal Simek <michal.simek@amd.com>,
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
	Qu Wenruo <wqu@suse.com>, Stefano Babic <sbabic@denx.de>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/29] treewide: Tidy up semicolon after command macros
Message-ID: <20231115195855.GM6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-4-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D6pLJ22zKbOC/++g"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-4-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett


--D6pLJ22zKbOC/++g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:08:48PM -0700, Simon Glass wrote:

> The U_BOOT_CMD_COMPLETE() macro has a semicolon at the end, perhaps
> inadvertently. Some code has taken advantage of this.
>=20
> Tidy this up by dropping the semicolon from the macro and adding it to
> macro invocations as required.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--D6pLJ22zKbOC/++g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVIv8ACgkQFHw5/5Y0
tyz5tAv/SHvR/oteVxDtQfeHpteSntQvpMFGu4cIbwCJZaOAZlWKzzZSI2M9+asF
rmuarfPcqOtNQwobXTAchlPWD08Polkb3pWKOixHxcmaXeSA4Onc+CZiBgkJ3mtI
ZWoWswhNIPbg+ivi1ITFGq+l/qScI9nlrW08U5VhxXr2ksybF7pgz0befJCyGw+o
jZdGz+p2NvZi0qodSxdA9pOHeN0Z0s9cwmwdNtbB+ghZDLIbnGLT2gfofLCX1619
apurnOiw5H3KrsNgDGPUkCcsOz/YsGd8YgqmMcLzweZ7CZeWUlxf8q7DAJKvUubd
fdLfLmrQUMEDXudPEAGrpBll/x4qDolQe/6FY/QCUBs0+S+PajiecRuNCTbGm3Cp
Sb8cE4mrPGR3kuMWRnOeh4qMWNnr5vX0wWxP/OGgvh1kFcHcMWaFSDQPVkBkkur4
B4B9CuJOSvMXdEQ8mz6BRJkivJEJNXVLDfpuL0bBzg72rfZGsUgMNTATJupKbLIX
izK1kL2S
=9zlJ
-----END PGP SIGNATURE-----

--D6pLJ22zKbOC/++g--

