Return-Path: <linux-btrfs+bounces-11875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E143A45E04
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 12:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB78B164737
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B7D21D3EA;
	Wed, 26 Feb 2025 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FgF5BQbo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68A20FA9B;
	Wed, 26 Feb 2025 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570951; cv=none; b=djoU+Ez3jXe53heNODomC8SP4TxyZeG97U29DdVBHDA/wHexMs0r/UHmtmhefMKOkmta7p4nV5UNChXQnS2C8JConPe150MmhI4VH6Fo3kGzMTqivoZqLsWhDrYlkzVzkNf5LoT/qiBShHrpeWdrmcbPMAzr5mZyoajHugejlEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570951; c=relaxed/simple;
	bh=sTX8xi6LRWxYofvmbcRQIPwzk4BhNjim5Kc1TZCgi5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=oa2f+uIviei+UOpW+FvaORTW8H79sCtzIO5I5byYm/xMmFhRB06NmNmIMpFHLZ5g7SYpxD20t5wzXBUmB5WX3Wki+KWapLdJ7T0ElsFMCIBwu28Tr5V7FAO4ed1Qb7ErD0b4Ge8+HchhElsDbUJnKLtKc21GyT3ZujrMLYjlJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FgF5BQbo; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740570931; x=1741175731; i=markus.elfring@web.de;
	bh=sTX8xi6LRWxYofvmbcRQIPwzk4BhNjim5Kc1TZCgi5I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FgF5BQbol86RnWL2Sk24p7qdL5tQLOeT6f07Kvxk4P0VuErz4WgTRL7pn6j/9HBZ
	 z+cak2KgFRXeyXt7h/+BTqXGvv0hTXqqct+9+hLjPcNj3botKQ3pCtj1zGcH4ifEh
	 yFa3sBuphYKHeZZwVQaSV3wyFrLsvWanJ3Z6ukLmBSFQ8+HjJKTN807sEt43aEoUg
	 HbB2HsK30RgebgKAq9z+FLUxZ7GFREklxLf4JkReYQU8HhTTePiNS5BpbM3Q4Iq3/
	 /8xzXq7fVNqYLas56fa9vFIZ5anQ0OIXKnqjBE+M5zkQbuCHIU124L0CnFIHiM9E2
	 ngho7wBag929Q1fQLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.43]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M604f-1tfrLt2zXv-00E5Ph; Wed, 26
 Feb 2025 12:55:30 +0100
Message-ID: <5495665a-774b-4bc5-8eb2-a9680d09b0be@web.de>
Date: Wed, 26 Feb 2025 12:55:17 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH v3 04/16] ALSA: ac97: convert timeouts to
 secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr,
 Andrew Morton <akpm@linux-foundation.org>,
 Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>,
 Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>,
 Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-4-a43967e36c88@linux.microsoft.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 linux-rdma@vger.kernel.org, kernel@pengutronix.de,
 Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-4-a43967e36c88@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ucYXuYgBQVTEWaObV/mFjtsvpzQ/KO5i5l5ZjdohfyGQ4hlxvcY
 sTVdlsTl9fld7Rgr2WyDph9nJLEmgybCGSVtuMLyhQK485ALORk88bsJZJIOfByFUNZedr7
 Tig7GhQucLbNWxtaLBapV3p7oWArgHdIII/eRzvvtip6IPoz+StdW8P4rzipPjdrxqJNq7V
 w9kH46OLKD2fAu1DJ4I4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NqOsrw7wXz4=;wwgFpUfWgrNKqonaHrxuK0zBMVo
 mDjqDBwUTGC2TEakQ0FQpQb+jPeq8+VUsHA9FysNiUMcu9jvRYzUnVW/cePngei1HuxUi+9jB
 gzwpaGWWDjDgiqloN8NkKw7fK1k9aiq9WO2QV+FahFVJxKCiEOht1QwMKGQlNmk9KSfqrx+xY
 /ZLupqHBoI8IrXEf4BLPHHel92dIDpHQKboSzjjYqqe+D17jNVvkdG6fNPyA61KaW3VNs4cNO
 VvTz7objQwY3sXV9VVKfi5xn57PHN9mTjtQuIqd+Fkmo2WDIvSm1qZXwIHn3nMByQ+tt7svzC
 Q8spwoR/tPpS2RHogJczvjm/AJwifCv3M4zmOA7P6thgwODVRmcvR/4vF01uKQLuK9qMgFlyc
 bcgjRUxbqZme7tOe+3/skv2xiRyQEbhJKJtGN5D+YuDiSWxugE0waVrKszeAKPmktude+e3Wm
 hb6pdZnYZCt8B9GbDEP5Vb/mlwKymujzJht1qssYcn8d3Ml1SMkSc3vuwSRHDX6T7apEaslxL
 H1ldZBfcHAqqxfpa5LbXdHASW4m4p3H0K1hJHORXZqCUnOEcZxDWNffnSEspRVYifgrFqGv4y
 Kj26KhRIVUoBKuigt9Q2mdl8jTmWXytY3VzlUIiR7tUQHVdIIbUdCyTnywoOmuD6VO0yepr5x
 bLQ4dW/TIsHMfmgenog//zbU7q2CO3bneqDQJPNt+SnDmx59ilBfNjed2YgZwvn4cQlSdaI0L
 F6NIFthjhreE3/Mi2NLvYEGxVUZoOMS2U7r5bxeagKeTc2gxxXa1GQVKaGa4DKQrDpFctrZO+
 VgS1EfusE5lk8m0igJwjGV8T5jJ4yK8zBmXHUgf2B7xsqbzIVsymf73VTGRYna5d8fpSlwFol
 Z7qd+KqzL47eifD09GmZjoE4UJBGc7zuzHDS6dRLZAuI/Zl84ps/Ym32YxhbN/YAsutAmmp+v
 TOkjv6MdafHxETdnQKdh/rPigxuHdcazx7XB6EEgDKbDg3iSQfzRgSR4xQ4NJ8AZ2iLg0mWum
 0vXgI8wXv34gMt9O2p3er2RQWDsVcZ08cX04PIZdsztxTjwu0CPkBaXXuUyTd+ZnGMu5xuqJ6
 NVigR36nr3N2Z8mQFMK5WqrimZH+EH+M90+yC79G0/T7t0PPocKOZnJL41HJTo+LovTIveleV
 HWrp9ctFsgjPDj6UJNJTykjtt8NgQ82/CLAEHggdCeEf/T9E6KPlLG59U+DvbDeDV1a/KcYk6
 oIKY/n0w1wj9RkAu6PcR+vZ6tUptSyjIto4BLBRON4Vu2xjOkAgT2n2QCgRNb4wktwpFOdB2t
 dil/Pn0qWsKxuLlEMj/YzfiGEHQVObo/J888IPK+k+5H0DLKihuIJZ57xoknHewbhE68lpmcV
 rG+nfMuo4dycdcDOCDQ3IWqIkBsiusNZFDRDG0JStERTtnEkvLAd8i/CYVJdEg4hKBw+fpLvN
 wNpIdlENtYji5zVvncyHslb0goYM=

=E2=80=A6
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci wi=
th
> the following Coccinelle rules:

Is only a single SmPL script rule relevant here?


> @depends on patch@
> expression E;
> @@
>
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )

I would miss two space characters in the first text column.
Please avoid typos also in such SmPL code.
Would you like to compare your contributions with a previous change sugges=
tion
like =E2=80=9C[PATCH v3 03/16] accel/habanalabs: convert timeouts to secs_=
to_jiffies()=E2=80=9D
once more?
https://lore.kernel.org/cocci/20250225-converge-secs-to-jiffies-part-two-v=
3-3-a43967e36c88@linux.microsoft.com/

Regards,
Markus

