Return-Path: <linux-btrfs+bounces-11874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E83B1A45D21
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 12:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B7C172D61
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97A1216612;
	Wed, 26 Feb 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIUlTfK2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FFD21519A;
	Wed, 26 Feb 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569408; cv=none; b=ikHtXf3/ILJlulQD53pnfFUAoyunNlU4g2qx+bKZvbMRSmxTTHKnGBTNFxFFnVfDKPKsOlXs29BR5vUkAtHqrpoLAbYNDC5Lt9eDM/MrBNEUxco0eGgqCoMSp7fUjU4pV2KE7vz78RdP0ZSzKdgXc0HQvFuDOmFVvfP7gHyRe/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569408; c=relaxed/simple;
	bh=9WiEqRQ0WC4TcHNEk0++D2oF9/1toQwtlnkrdN1ISFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8WNnvB2NiVYAazCbnwPbxL8J5EAA189SDk99FpdXZ6b49VkuBiHvPOfuuudsPDoGBc6aoqgPMNy2K4GcKtK5kx0Vd+yfWbAKjx4HLiuFVYlU8/5l4DlW02RVl2/CmC4rDU6YvL56zC36Jr9LbfZVXJxQzSpqIxUSvbBCuhyQ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIUlTfK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC63AC4CED6;
	Wed, 26 Feb 2025 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740569407;
	bh=9WiEqRQ0WC4TcHNEk0++D2oF9/1toQwtlnkrdN1ISFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIUlTfK2pXqaUDMpw5RIIHnVeByfDlzQfBY3+0E8d5BdAX+TUTVNIwrKJgP/FaBgf
	 IjKKuUXeG5l9Ew8YeRaCGxVo6aYi0aUIrGzgwgY4+2DWcarIPntGz/9GLbyfVSNYfO
	 SW67yeYI3cR0fo8n3xv0/29uJIe3dVQR5PiV8qSEWeCXl+fwqnxdcjjE7DRmUVfiOS
	 9ThhnWpo2ZcFcSSUl0fMoM6tREGrNbzEDH/ikx2VuLf8tYWdUKO61yIk6vUlP6vZME
	 uzwqRVd6q4FA9sQCc3I/OUPF+zTBTE5BD6JsPh7tFiinI8MhEHoSIxhQ9UdEv6t4h/
	 T5prmsk09BN7w==
Date: Wed, 26 Feb 2025 11:29:53 +0000
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
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v3 00/16] Converge on using secs_to_jiffies() part two
Message-ID: <79b24031-5776-4eb3-960b-32b0530647fb@sirena.org.uk>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZCSMnIMPvhXPgIqW"
Content-Disposition: inline
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
X-Cookie: I've been there.


--ZCSMnIMPvhXPgIqW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 08:17:14PM +0000, Easwar Hariharan wrote:
> This is the second series (part 1*) that converts users of msecs_to_jiffi=
es() that
> either use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
>=20
> where N is a constant or an expression, to avoid the multiplication.

Please don't combine patches for multiple subsystems into a single
series if there's no dependencies between them, it just creates
confusion about how things get merged, problems for tooling and makes
everything more noisy.  It's best to split things up per subsystem in
that case.

--ZCSMnIMPvhXPgIqW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme++zEACgkQJNaLcl1U
h9BKXgf/Ybq0e4qGEIKGWBa7OUYTknbVxMBC/99e3FVQ0Dwf4IPl8bDlEvGCxai/
A2UYH2niNzqAGOIs0IYUzaMIbok+phK2ifRcVyNdM2KciC1B2jGROzQplIYaq0bH
aEBWCAEyWMlRAMVwWL66KhB7d9asaNrv9v4WCNfcV9F4pThna3PAti9AF+sX6sQh
kvQleuahMD/hHAdTIrgBuJGgtox61kBDTFMibaWt2Moq01Wsp8YDQS3JtnnLyiE0
Rc67if2Uvg1ZMAyO3Fvm80flyFkMHhuiaq0uTFCLt1YiqCLfzk2w+QExnv0DRECR
mx63KFPW0WMILQcbYwjzaGgaLuTDWg==
=UO5r
-----END PGP SIGNATURE-----

--ZCSMnIMPvhXPgIqW--

