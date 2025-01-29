Return-Path: <linux-btrfs+bounces-11137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EF0A21C49
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 12:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037A03A3CDE
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96A91D9A7F;
	Wed, 29 Jan 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtI67GZD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8313C9A3;
	Wed, 29 Jan 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738150236; cv=none; b=JmSz1AMo52PKJRhYAFoOo1MkjJ4wiKtniP6hxdNJ49VZKIC1VrRvd4xq7izueedoy+iZ0tU2L+CMEAUeJlZ4gLBE9+Aw4VbQerYRuloX47F0Rq3021zqmh61XWuQgFABUHdYHefHy5APrOWHT/9KrQQt7hqiXdc4gGZZ1IHUSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738150236; c=relaxed/simple;
	bh=PGzhPhIGvedo1hUSZOhnBkmZDQESU8tumG/s6DUxvXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOPseLnQ9vgx4ZmyKuAaF4JxW1LyXh5RSNFgxeCT/AWA/Z3Q7xcAtuvA+y02pvM7sxAcB/92PD0pDxincJBB6olNLxZSUAhTf6j3uEbtpn5BznFbZON407Bba+g9juH5GeFL+A7u5TCHgU1fX837VEXYskpzj3bRum+sWCXajlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtI67GZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08219C4CED3;
	Wed, 29 Jan 2025 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738150236;
	bh=PGzhPhIGvedo1hUSZOhnBkmZDQESU8tumG/s6DUxvXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZtI67GZDUwmVObMXVDnkn0JrT90mq1FWzZPJfX54LEnSuCkHcZegr9yD+nONZRlzB
	 NdTLLdl6vn6f8UrE+u4ErdIRAJ08ob0Xby74NcltekuNw+jlEhZ/ccP0QNf7C6JcXf
	 SwqH2i3Gs/sVoWSH1fgadm8LkE8QOh8sim2YzKEDtprzZ8ObXHa24pw/dQvs2U98RF
	 Tr6DWrDeNAfZAaOGR1I0I3HG51Uw66JRtlaZH0NKwMSzMvf3IVfb4NrYOydkdw8khx
	 9vzabwvkyLvROFag7yIgVq22runc6+02aDA3ULJ93boFRdvIIutHM5yGGI5/dCwLO/
	 rGjfk6o1HfewA==
Date: Wed, 29 Jan 2025 11:30:21 +0000
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
Subject: Re: [PATCH 13/16] spi: spi-imx: convert timeouts to secs_to_jiffies()
Message-ID: <003cc629-1969-432b-9d9a-e17a315a0407@sirena.org.uk>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-13-9a6ecf0b2308@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqw+F9EZKY3y+n+J"
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-13-9a6ecf0b2308@linux.microsoft.com>
X-Cookie: The world is not octal despite DEC.


--nqw+F9EZKY3y+n+J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2025 at 06:21:58PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

Acked-by: Mark Brown <broonie@kernel.org>

--nqw+F9EZKY3y+n+J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeaEU0ACgkQJNaLcl1U
h9DZyQf/T/OK8ZWxSzh3dJWsLr99J2XEq+bjv9e7IU0AU/eyO6YeJOJ5PzHFHkPr
Zk1IUnGI0OF8pcUXyBzuUL5L6xn4D2+l7+ChMN1V94Q0KWuPSEf7bJL7lo+UBq4k
BDHHE1Qs7qag4DrPoQb4K+6qXX46HvTIJKamPKtm4VAw0BAVoK/N6pSPKtK+yRC8
TmfWRcS+046vsaFWuQF1aS3hy1eiY0eFjv3+XLhta71PFbIfQ8sBZtX+gzPu8/t8
w8BgXrldeDtBpKhtizRNkmlu9WoicVeENDpjYOAf3CeC08eHyRT/GrS4iYwRP26k
HKKCEB2NvAkAB5bvQXqsqFPC+Nzgmg==
=CTWt
-----END PGP SIGNATURE-----

--nqw+F9EZKY3y+n+J--

