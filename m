Return-Path: <linux-btrfs+bounces-11120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64ACA21576
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 01:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0516318880CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 00:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C3C175D39;
	Wed, 29 Jan 2025 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AS2j4JP5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC543166;
	Wed, 29 Jan 2025 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738109807; cv=none; b=ofv9nweN/Unhza8ODLA/fSuHdda1p+DXhE523b/yp/k7zUNza6/CTuCcCaA7ZxUikgEn7PryvTLKZIwlc4xnbvCjWfnar6+D9GeT9shVnok7hIdjjguYjMJda68R6Bd/BJvgW1hkrY+545Nwx0mnOMBoUJR/oExBqV60GY6zX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738109807; c=relaxed/simple;
	bh=zZU6hynWCHp+6F/RCQmfqyOYkRbiqQZ0uQFQk367ytg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AeI2jjTOyzblWUgseBqsS4twqul6hxxLOzsNmtxWsBmQfrO132FEEf19nWxg/xk4CjJ/TQmWHqPc2unJvqvj4Ly0V13xd4XbehliYvkN3jUxIBz4PeI0EvXrNSJd9RcfmJ+KEFr7kgg0Ed2USPBCVjAFOEqXe6IuOGeoHCTyj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AS2j4JP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994C4C4CED3;
	Wed, 29 Jan 2025 00:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738109806;
	bh=zZU6hynWCHp+6F/RCQmfqyOYkRbiqQZ0uQFQk367ytg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AS2j4JP5RIAisJwaJPGo5rdD+WQkiOVOSd2qjWS7o62PB/KfGo+AtIeEIRlVi8ca4
	 DcFpL5pMszZR4AoEDS94lZdMmpR+YhI7fvUGwBGQGj85DpwI7Ag5fgschNnRNtAEJ5
	 EXSOU+Vpu5p468XbHO3vy3GdYQe6R4CubgmVMLqk=
Date: Tue, 28 Jan 2025 16:16:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, James Smart <james.smart@broadcom.com>, Dick
 Kennedy <dick.kennedy@broadcom.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Ilya Dryomov
 <idryomov@gmail.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens
 Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Carlos Maiolino
 <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Frank Li
 <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Henrique de Moraes Holschuh
 <hmh@hmh.eng.br>, Selvin Xavier <selvin.xavier@broadcom.com>, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 00/16] Converge on using secs_to_jiffies() part two
Message-Id: <20250128161643.289d9fe705ef2fdba0b82a52@linux-foundation.org>
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 18:21:45 +0000 Easwar Hariharan <eahariha@linux.microsoft.com> wrote:

> This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> either use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> where N is a constant or an expression, to avoid the multiplication.
> 
> The conversion is made with Coccinelle with the secs_to_jiffies() script
> in scripts/coccinelle/misc. Attention is paid to what the best change
> can be rather than restricting to what the tool provides.
> 
> Andrew has kindly agreed to take the series through mm.git modulo the
> patches maintainers want to pick through their own trees.

I added patches 2-16 to mm.git.  If any of these later get merged into
a subsystem tree, Stephen will tell us and I'll drop the mm.git copy.


