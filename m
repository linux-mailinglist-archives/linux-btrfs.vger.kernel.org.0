Return-Path: <linux-btrfs+bounces-11119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B0BA21371
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2025 22:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1C1889B7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2025 21:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287671F1505;
	Tue, 28 Jan 2025 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lugd+JEl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855255887;
	Tue, 28 Jan 2025 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738098164; cv=none; b=BMNRC8H3iK95KZ6QQRmoVEJ2idqDjZpsW+HpUwRdqvZQZgH2z3q4pIcaO6OCWJ1aKTFphRfWpvjHkffyQchjzSyfXh91IkJYdT6KrHfys0JenNEvJdCk/q1gm3lBGphUPo1+7ywTy0GVCheIeNkiMJrveaVK80B/HBKcZ+6VFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738098164; c=relaxed/simple;
	bh=mfMB/kOJwWCWBi7AtFus1i5A8KKc2SzYD9VfPPB6/Bk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fuYgz03dOehmWdW6aKYsAV8FxZ6PcsyruP+zj9JmsWnoLrjv9cc1NTWMmbrEkxHxIRCQ11YROer0V6iPt87GlJIXijEfWShyEyXoG2kKD5VcGhYYOH1s/rRBx/a6XznfPyQESmNKgZ8V6Lt3XzbMz1opliLSw/IWZLV2l1DLE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lugd+JEl; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738098159; x=1738702959; i=markus.elfring@web.de;
	bh=3umHLMGrcLo5C0gV5DfFSpcRm6HAQK73Bd3Y1mC2uB4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lugd+JElfIBEVWJEly/xpiC37xATW6N6QL/mFXzaImqmdRiGu9El4suaNDc5SBIJ
	 f7yuPAtB4XVuylj3u7G5BczelJ5/emDxHQ30PDVNcC9rtRKBhqRseJy6OASoL+Iq9
	 ArcQ3FyUW9yd6zl6HvZ2Xlf0WV4HKCmnClbV719vvUnC+rm0ypbfdtPwsGGbVAZnj
	 WkCAfzZcvm0TYZkxsVNFrodDO6tQZu6OcvhdWzOTgMDymVvgzqDR+mTdyiZV8tA4+
	 QU/te2bbCzVTLcIj2amNj5TwWzdApX4spmArstqfs3lmriJ7U+3XkJ3feVPqxmnLX
	 mxBXcCqystTm/wZ5ww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.40]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mi4z5-1szA8E0tNZ-00bwwr; Tue, 28
 Jan 2025 22:02:39 +0100
Message-ID: <565fb1db-3618-4636-8820-1ca77dad07a2@web.de>
Date: Tue, 28 Jan 2025 22:02:29 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
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
 Yaron Avizrat <yaron.avizrat@intel.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
Subject: Re: [PATCH 01/16] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iHXXXI1GgZe21qv8LaB36WZ2Vsbh+30ctHdeuhjL58pow7ObI/n
 WkL1BRfcGc3xPTE7WTH/8blOzYTn9sr9kmiu0JlwbK+4b714M1NEuSxTjO0wec15e2/vSDy
 uDaoXgXEnc15+k7LwhSrDlieAakHXlujaBdoTKMERuZeGqcF/lr7wB/BevoNLo+FU7wzIqQ
 aOajvgo+YHQHBAbcH9fBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rl1+EWWMtaU=;EqS9WTtqlVexMZSa5Jv6osEpxMn
 hvF5ExxFi69MshCqN0iCQJ9CsPgR4dRizBjf15Nun4PB2G1xVTkt8gPKouGwCsVTv8Wm+WqU2
 TfM0O0GAReZpmFXq82LdrG2sTl+5GS7MW/XeczWoOvfmlQZGUTxAeiabHe982tQ5sjQ7pvBjj
 b6JYk30LAwHaptKVJlAyYDTQrNqQmKm1fInHh1R0BqLWD7yAbmIhzOgsGDyapCyRzZ/6L58Kd
 qMLJCmj8kp6OcGrtC6qyfn6vENJ3sKXUzDCjeFjZsblLj6AZqVFqPaGkr3WDBvgVlzknwCsuL
 dTDBwwDzhXWZDpsnaBHnS8iI6b9y60B0/WwOzfqaZ2vol6lFD69SHUFtYn0ZgHvwiCZm9xktA
 JWX2pS3My9yJ+hVoYQ8Roh/du8QDa/Pm1AN3y4siXvV4Vd2p4r7avPuVYF89xPfhqeOiCUyim
 74txrmxIhNJtDI2TJ2SHQYS2r1gUY8+ioCwT2SsVmzxEdV795ccbiiKzw3KT1teQ1CRIhkeZF
 k+me759e21qqFhzCA+W+kKa3oNrQvnrx3MFGbr/WoIwLxlyqLG25aVhqwuWvn7yyDaFQ60QKw
 tMPxLX6+iV8IWzhIUyb4CtEkcgWiVVNm59osGitJw6HZJgsmDNDR4zs4DWL+Q5VGOpmwSVC0x
 Q+nvkt0/jEV6wgWG8uEad4c+rNAUrw9rtdYU5HViYfJzdE2v/knRfZBUzOkgi6O5iMZtJ3Lxi
 rKMYnBh+OfDHRaOKzTHuD/jxsBh2wri3J7QnuWvzCczLpsppJHq+CGdZvNevnxIcUGmYGqYZs
 K5WU8xokNX6ip+Z6iQRZjHliRbfF3LPa1bz58C8lLJ8UJMr2uicwiVhyCmJXfhfnTsF1UEjV3
 2Bjsxn/TOrbOtdszIeVMV7ChLFk0OwufgZxaGxw/3gOyHaPOUZ3Mz/eBUr3BiSQtFPFl4bvd4
 GwFqEoazTKVX6f87q5CL/ThpkFTHi+muon/dhBj6NFEXz0Vk7JlO2YBAbv+PnanDfW0BCvaKH
 DuZIBZebVIcC++l0MdC0iSdO+kNr3TXnRpRd2Pyhqn0qD+C8W+jzV6x520UF9whVDkCQlAjr8
 R1OTygelS4A8CdLcvmF1P6DSPVs1dfnOMm4gzJp4/NcmbxhgSRgtg23Df90/CTB3FnVaeTOWC
 m6owGzbKvieq3OLAkE+SPXE4/jRQF+NmzzaRCayhBpQ==

> Teach the script to suggest conversions for timeout patterns where the
> arguments to msecs_to_jiffies() are expressions as well.

I propose to take another look at implementation details for such a script=
 variant
according to the semantic patch language.


=E2=80=A6
> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> @@ -11,12 +11,22 @@
>
>  virtual patch
=E2=80=A6
> -@depends on patch@ constant C; @@
> +@depends on patch@
> +expression E;
> +@@
>
> -- msecs_to_jiffies(C * MSEC_PER_SEC)
> -+ secs_to_jiffies(C)
> +-msecs_to_jiffies
> ++secs_to_jiffies
> + (E
> +- * \( 1000 \| MSEC_PER_SEC \)
> + )

1. I do not see a need to keep an SmPL rule for the handling of constants
   (or literals) after the suggested extension for expressions.

2. I find it nice that you indicate an attempt to make the shown SmPL code
   a bit more succinct.
   Unfortunately, further constraints should be taken better into account
   for the current handling of isomorphisms (and corresponding SmPL disjun=
ctions).
   Thus I would find an SmPL rule (like the following) more appropriate.

@adjustment@
expression e;
@@
-msecs_to_jiffies
+secs_to_jiffies
 (
(
-e * 1000
|
-e * MSEC_PER_SEC
)
+e
 )


3. It seems that you would like to support only a single operation mode so=
 far.
   This system aspect can trigger further software development challenges.


Regards,
Markus

