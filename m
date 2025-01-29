Return-Path: <linux-btrfs+bounces-11136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22058A21C34
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 12:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625DE16687C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 11:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FE11D9320;
	Wed, 29 Jan 2025 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keXqYgpB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97445186615;
	Wed, 29 Jan 2025 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738150112; cv=none; b=Y0h8wZHDL1MCuyUiWLwgHFoTKxBFPsUDEdGTSqXlWZlwyqC97o/uikFqiYb9xMyH+kOx5WZeEaNNtEIuEUa7gqMzpXrEjk89txBrNc+U9pzDNgVp6hELKbpflC9Svkx9ezk8vgB6SZ11ypBPNNYy1EivMZjKGTCymYT9nuHU+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738150112; c=relaxed/simple;
	bh=0afCP9tpAob285d2+c3DFTpCZwuw1x7xRMd+0cAY7dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd37aQo1UBdgorPaJmGwbIXFCr+7xJN9f2H2AzK/EDG5Fyw0ljARzmuKjFBCoH33NIxYgRk3Yvek5+IdQEuTgwBk+gORbR6zQf6Mm5ezOhqTNaG+V7j+yYNXsIrFS6U7D4OPU0VgMzp9kX8N9gRV7OOpcmf/nNz3/wPEIGCt1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keXqYgpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4990C4CED3;
	Wed, 29 Jan 2025 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738150112;
	bh=0afCP9tpAob285d2+c3DFTpCZwuw1x7xRMd+0cAY7dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=keXqYgpBqSxQiFVgp6ssrhizY4Du1eWNsvvQf4/NWW+oCjoyMXSVpfZ5Bn1PdB/ED
	 9wv1wBuRchQxQ0CuW4u8FMVzwJ8rB0L5vRFiLUUNtPD9wj9Bn+/Va+Q9Z6mxgIymwQ
	 JLqQeOEbqULVQhG02Pj+7zzB2MlkL8R3oKJEeNxyMF67Vwg78zTFJsO4OZ7KbIbgaP
	 YP9spZdl67qiwH0u1r8P2FYAPgdnGwinuVWEYrFRtCSPzqRNfIEkTTNBeG18dRI+F6
	 TAaVqoYmML/+XRYt7G2+YbCO7gYobpmwRSUYyDEsvRA3IA3F3pdig8YUD/h8psjWYU
	 PeniPeunBQVTw==
Date: Wed, 29 Jan 2025 11:28:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yaron Avizrat <yaron.avizrat@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Frank Li <Frank.Li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	cocci@inria.fr, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 12/16] spi: spi-fsl-lpspi: convert timeouts to
 secs_to_jiffies()
Message-ID: <61d507a3-ca37-4eb9-b2cd-100298ffeeb6@sirena.org.uk>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-12-9a6ecf0b2308@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wxS6hvAU6Vp1PxGO"
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-12-9a6ecf0b2308@linux.microsoft.com>
X-Cookie: The world is not octal despite DEC.


--wxS6hvAU6Vp1PxGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2025 at 06:21:57PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

Acked-by: Mark Brown <broonie@kernel.org>

--wxS6hvAU6Vp1PxGO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeaENIACgkQJNaLcl1U
h9Dwlwf/b75reI0uh7UpxNuw1Dgg2fl7hJn3m8DCJwfdhTb1pyNP6o2VB7PJ1FPR
zu8lccVGi/iZRranIOtvGjKtg5SrDhrF9CChAbwxk2f26lvF27Srdn7mHycwzkEm
h579H3K/1ri3X0oWXziH3KBnzKNBR3TB6h7Rp5na27mnWR9gKqZncog+7Qvr1aP1
3ufuZYWQ3RTFLp/IcPgBRYYjA/Ev1i7qKuqRS8qugS1d1vtZ7Js396WlV3r1KtgJ
qKDie5bMyU16q7C+SJERETYIrFvtYKXn3bERyeN2wpSjyOtEYM2awuQ3XRDFvz05
lMz/vFonoSs3p3TPlosZHyaOSE/Vdg==
=JJPM
-----END PGP SIGNATURE-----

--wxS6hvAU6Vp1PxGO--

