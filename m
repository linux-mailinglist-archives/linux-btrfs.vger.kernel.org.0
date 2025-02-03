Return-Path: <linux-btrfs+bounces-11220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E4A252F9
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 08:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8371881649
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328DF1F541E;
	Mon,  3 Feb 2025 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tPjM0uN4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E31D95A9;
	Mon,  3 Feb 2025 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738567395; cv=none; b=MvQ7fvaIQuH/AnrO2OJqPohyoK6KYGrpcwiv3Jb5cd+NChAJsxyo2FMqr7lHc75bKngRmFopRS/jqfmUDG0E1BP5oKhwJuZfCOCknIZL3pHFR8B2el0R/YITw+akonKuA+0VJzFZvfvVWxjhiFyhU9z0IGoSJhk+ip9/Y6Q28qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738567395; c=relaxed/simple;
	bh=pL2jDbwM2tnoDPxkIcout16iJtvsCV65sn/2QOSZBsY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ua6r/yBjKdafsset+0V1csFIUecxXaCFLbNR3twTR1JbRXRHtifd+HjbfUQ9/dlO82O8WQOi8SzAqnCO3YMADfpzKIpq8xdNa0JNCxzexm9xXNJq0L8KlHeelrXqtcClg4QMrMuWWDmSnbtomqHSBJhoLgFpxMxOoEwFvulvZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tPjM0uN4; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738567338; x=1739172138; i=markus.elfring@web.de;
	bh=pL2jDbwM2tnoDPxkIcout16iJtvsCV65sn/2QOSZBsY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tPjM0uN4I/GdAFp31++PG26z4Vto4PmHwwKCB+iJ4HIbRwu5joJXwvRpwBps1Vk5
	 BsR+TBN1/gKQUNN6ZGncM+nvFp4kAyRHyxYGr6ANswR2VhX+Sk5BqHpIiTEwtoqV7
	 CYW45ezkvs7otl2YrqdQlFPAZudQCI5wDpQYRd/iR3EILMUFNGcUyJSc7iDH9JyOD
	 FbUpses7uVefH5D3IUULvsEYhibYuqoSt+k+uleYwhAQhNpVKuTLS08qGiRMwzU3I
	 whTVatnsqGvJVTwBvBpdjC7mCZHIZcsSw0Qqlo/EOLaII4kL6LfqeSBy35+o25YKu
	 kUv/J7OgQXFBoRqg1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.29]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgX3-1szyFN23FD-00mF3n; Mon, 03
 Feb 2025 08:22:18 +0100
Message-ID: <875fe1a2-64b4-43f9-8b6c-60e416a37248@web.de>
Date: Mon, 3 Feb 2025 08:22:12 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [01/16] coccinelle: misc: secs_to_jiffies: Patch expressions too
To: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 imx@lists.linux.dev, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, Carlos Maiolino <cem@kernel.org>,
 Chris Mason <clm@fb.com>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 David Sterba <dsterba@suse.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 James Smart <james.smart@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
 Josef Bacik <josef@toxicpanda.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Niklas Cassel <cassel@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Ricardo Ribalda <ribalda@google.com>,
 Sagi Grimberg <sagi@grimberg.me>, Sascha Hauer <s.hauer@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>,
 Selvin Xavier <selvin.xavier@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Victor Gambier <victor.gambier@inria.fr>, Xiubo Li <xiubli@redhat.com>,
 Yaron Avizrat <yaron.avizrat@intel.com>,
 Ricardo Ribalda <ribalda@chromium.org>
References: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
 <e06cb7f5-7aa3-464c-a8a1-2c7b9b6a29eb@web.de>
 <632be2db-78d2-4249-92f0-3f60e0373172@linux.microsoft.com>
Content-Language: en-GB
In-Reply-To: <632be2db-78d2-4249-92f0-3f60e0373172@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:unmzcva3DfFDe8J5T/SEse13ECLrm00SFr+jMbswdVLKuVhkuYO
 KrTlmHqHj2q9ogvXNY+OT9rpa/y77P4OKcbhTRE4HQfNnHl3vyWWfzK02lPKs/doF/0oo/N
 zaSBPOg0Tas1K5KCmS6LhNSs0R2vs1xLG29Gypkmwc3S031NZBDDMgkSSAGcQ2a7o9N0Sjo
 97PGMtERfjxkxxcBQ4+cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ttbGuD59yWE=;aR8uoScoWimrSRCmRkUV4SeMiC4
 W79hOF4H0lhnQHYtzx3m5sNeqoeEjllyRz8YO7qpX8lmmz5+tS5bf6f8vLVqYn9Kaf48xHqma
 GMO3bXWom5xZ+oVyIxDcLJs8p7PgYEA5ypLybnd2/T+GawWIBGs+YXCKBHx9HvPqPogF+ZWbt
 K+TyhUDO5bQsBtbetxS3RKRmFHZaezGpeiwamE4tJBcayt8rdci1cnRAVxZjRrnyUeMDPgD6w
 WKKXvMYQI9xNIms2eXtV9M1bxbS+lhSfb6gN7tJf2LwY4iDuINHUwQnKRfA26lORiGW/UmxpA
 VDJglYJvc0HJJqymSDraa9W3b84J+5STNVqd3FDiOGXm1u1Lg5SvWgA1viCB3U/T6eNlmBKxu
 cW3HuColf7JWTbOCtYKQMticsxdqTUl6/icidZDIKeZA/6BTvCAJ5yo10i++PE5kYqE0mQ1ho
 4NVa2X6CB+FFnhhsQwwWTKFynfvg6dK/P1RIrFw78t5WsC8zz4qm64j7mnJS57vOm+HlNeNlJ
 dATJc1VHQDMoj9hjzdFzfzgZw9h5kyLYh8oVruDNFJ/+FH75gEuWoZlsU8KTOZQFV7EoxkSYe
 EVfenvSMPnmSzjQa+vNyzYbKtqQOPF88CdXdnAAym8guV56rCHkNBsyBuIPwADo10ZAjBpNzA
 OBRBkYWMqMkvqRqoLGiggpeqewsL9YdiEBa4oesyjAGQIw7IJ8/0snpG+f+cuMaO7kmaB6nHE
 nOpJS6Z9qzdfoJVXgs+47u+CzVBhVhWLqb0XCPk9jzzEHfYLkrIHTUIhakYc7nZUEAyJDC73r
 /hzw3PToNCTxBrUrwiTLOAoOxpa5fcHyJWusNq5FrbAxgole7higv+1sBb8NprFHptypkZ+Cw
 iq1xF2BAP1xbwfSfH760NHJ4EMEjOMI/iDzAJwPxQkxSlaDBQ4Gbv5ujQYBd3YMxgiuIGsl/w
 MdFuwIfMQU5oEMCItKFmMAIf7k7pEPQrOuKnG6AZ/LH/H2vUdfQfPyq8wJxV64EFZr9eSy6wJ
 Oy+t8DI1kdV301z/zAZQ8OpU2xnB8IxTLqrcbF63n+gYPUELXtWaXOoIbr5o0TxUA7XsBRCAL
 PYOoStHMrzPoz4tMq6bqU3gJQfZq4+hT0/1xGvJHF3EYYHdBGWrL7T8ngj9APgUClmkiUid9u
 qhcbZXpp66SsJcS9vzL/rjOnWJmMD3M+Ha1/NMDr7Hx2giHnnM35m2TcteG0N0JcefSzkj9ds
 f+5nMopNsnV7A3egbviqSJLT+UcbhaOvEXNf4avchAw4jPQ3zsTkczrYbZ8buav0UwNGXIMsG
 NwU97T/pGW1qLPWQZzQJs0EPaXBDrr4upn8u/GPLFGYGs6cf+BXQ4GT4mOQgByfpkCi

> As it stands, I'll fix up the current rules in v2 following your
> suggestion to keep the multiplication in each line to allow Coccinelle
> to use the commutativity properties and find more instances.

Corresponding software development challenges can eventually be clarified =
further.


> I'll refrain from implementing the report mode until current instances
> have been fixed because of the issue we have already seen[1] with CI
> builds being broken. I would not want to break a strict CI build that is
> looking for coccicheck REPORT to return 0 results.

You got into the mood to test support for an information in the software d=
ocumentation.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?h=3Dv6.13#n92
=E2=80=9C=E2=80=A6
Note that not all semantic patches implement all modes.
=E2=80=A6=E2=80=9D

Regards,
Markus

