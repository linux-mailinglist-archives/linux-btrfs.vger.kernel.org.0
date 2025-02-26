Return-Path: <linux-btrfs+bounces-11885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC2AA46E7E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 23:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C1A3ADA78
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 22:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E1B25BADA;
	Wed, 26 Feb 2025 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqYqpdVV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2F25CC80;
	Wed, 26 Feb 2025 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608820; cv=none; b=POV7BqsHltpNjnKUrPjztvHFEcZ+6WK3ydlheME3M4koO1aiqck8q7NT25G405El5rtfgRuB3QEwKf9RJJyYHXvHlUtZhmyly0gHR7LsnR9oRhSCfzvpWlvw6VCClD5Z8bOUkvP/JXKoscYGJaJ2vy5lErpyxHSQkNCDLz6xf/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608820; c=relaxed/simple;
	bh=O5zZ7g63I+0ZeYH00JZerlvbNik71qO0CgwvkTnWcIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3PfCFO5hiCvcw4q9HDa7O6w1BcxdYyvtboUer8VaVjxnn/e+ZoolJsLiRIbGay97ZQtUsYOjEzMOr7VY1p+umFvz0OMlOvg2ZwM6UAP/drhv8KyxVLzlcvlp3L1hhaU+OvDLXbJxsvPqX8FyP+yA7mTntWmpXd1Tj4wcbQBGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqYqpdVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D179C4CED6;
	Wed, 26 Feb 2025 22:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740608820;
	bh=O5zZ7g63I+0ZeYH00JZerlvbNik71qO0CgwvkTnWcIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqYqpdVVpkD5NJn6jpo0cdClxOspwzsi8RCKpRnA88J5OPdmx1mMru31LZxBFgp96
	 SZb3oRy0Fxzg1qr18ZQYO7NtEHrnW1kSYRo35qghO1/ESXhb4R4oAXKE6PoHpaKtQk
	 rw/ltpwe8XfbrUtfiq6lveoAbVX0jopaapPwU3slyk58T6gzgfoVr9fY71ajwj3kUT
	 xvbk1I9lC3b2larN7+jztDKNXSrFhP0QhpXpDklrqd7y0o0NsfVUuwegc/GYneM1Nf
	 LoD2swB/LWax0rd/I8YAe0yQ9kMiS9zB3fdg0qmIVaFo3k/1cDqwlB1rT1yn4zBMcR
	 ST+zf0908vWAA==
Date: Wed, 26 Feb 2025 22:26:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
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
Message-ID: <594169fd-5ba6-42d5-ad35-bb8c7720904b@sirena.org.uk>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <79b24031-5776-4eb3-960b-32b0530647fb@sirena.org.uk>
 <20250226123851.a50e727d0a1bfe639ece4a72@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ktE/+HW2BMMja6u3"
Content-Disposition: inline
In-Reply-To: <20250226123851.a50e727d0a1bfe639ece4a72@linux-foundation.org>
X-Cookie: I've been there.


--ktE/+HW2BMMja6u3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:38:51PM -0800, Andrew Morton wrote:
> On Wed, 26 Feb 2025 11:29:53 +0000 Mark Brown <broonie@kernel.org> wrote:

> > Please don't combine patches for multiple subsystems into a single
> > series if there's no dependencies between them, it just creates
> > confusion about how things get merged, problems for tooling and makes
> > everything more noisy.  It's best to split things up per subsystem in
> > that case.

> I asked for this.  I'll merge everything, spend a few weeks gathering
> up maintainer acks.  Anything which a subsystem maintainer merges will
> be reported by Stephen and I'll drop that particular patch.

> This way, nothing gets lost.  I take this approach often and it works.

I've only started seeing these in the past few weeks, but we do have a
bunch of people routinely doing cross tree stuff who split things up and
it seems to work OK there.

> If these were sent as a bunch of individual patches then it would be up
> to the sender to keep track of what has been merged and what hasn't.=20
> That person will be resending some stragglers many times.  Until they
> give up and some patches get permanently lost.

Surely the sender can just CC you on each individual thing just as well?
Ensuring things get picked up is great, but it's not clear to me that
copying everyone on a cross tree series is helping with that.

> Scale all that across many senders and the whole process becomes costly
> and unreliable.  Whereas centralizing it on akpm is more efficient,
> more reliable, more scalable, lower latency and less frustrating for
> senders.

Whereas copying everyone means all the maintainers see something that
looks terribly complicated in their inboxes and have to figure out if
there are actually any dependencies in the series and how it's supposed
to be handed, and then every reply goes to a huge CC list.  That's not
good for either getting people to look at things or general noise
avoidance, especially for people who are expecting to get cross tree
serieses which do have dependencies that need to be managed.

There's also some bad failure modes as soon as anyone has any sort of
comment on the series, suddenly everyone's got a coding style debate or
whatever in their inboxes they can pile into.

--ktE/+HW2BMMja6u3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme/lSYACgkQJNaLcl1U
h9DO/Qf/a9HWwKcXS5+hFxQJSm6QW0NLy2NbqHre8UKfa7aKUVgjHmVnb1gIAdSh
gY+WUz9p7S+67TovmO+FlVs/KDBaHyw8J0auw2I/uFK7bDhNHXtiUi32jBCyuQD4
w+yhOC50NrB6ZXh/FpBk8EXI4DSUoaL5z6KMVYItTTfl0lCtBbTGJSAPXswWc3u1
5ZXriY5GR9Q2MwY4Fs6QN6pbKucqtpxnhiL26E8ic/kdpVh6ZGEoFhFWweV6nD/+
ttggFNcFA98M8YYEySK/p9ls4PyRF4dXL+oQWEXWvylpGogCDAcCj7Igb8CuyJRn
G2+ftlgr6xEk4hOBnRKBY7Ts/BcKqg==
=3AEq
-----END PGP SIGNATURE-----

--ktE/+HW2BMMja6u3--

