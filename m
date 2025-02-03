Return-Path: <linux-btrfs+bounces-11251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52926A2657A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 22:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DBB18855E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B781E2101AE;
	Mon,  3 Feb 2025 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4DBgFuy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E71D5159;
	Mon,  3 Feb 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738617576; cv=none; b=iXgQg4xCpSAd/QThsJFWPgvui3QkIawazEcq2cPLNpWZeWRuiqTzdeFcK/KKgXRmLN2Reoi53N9J4MRr92MqZWnAsZ7nqOdXIny2HtDpUJLHb7Z0nhK6vmhtJKhFLALHGu8hBOVvixK3Lir7if4Pb7SDEnaOLEPsivUrXVISNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738617576; c=relaxed/simple;
	bh=ofj6JP1j6Y98Ose9xyS7S3SdHxczj7+yv4cnT8ALfhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKTuiuGpzVOBh1Dmzbws5NPGBxWbbUZoprisnpLR3uYp3J5NMmAra56Xptd067Un8wDa5HkgjpbPOA4VpC96wpfSArU1zBXTj3r2P1rd7lMh9BNRQ7ceVCJx2Ev0LklG/MV0VEqOL/xHjcxEJWirmZnMUoC+XXhCdCxUbM8DJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4DBgFuy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so8446300a91.1;
        Mon, 03 Feb 2025 13:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738617574; x=1739222374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1RprFycDuHJldRn/ezrS+F5IM4jHFkaXUl211fTz08=;
        b=Z4DBgFuykrZqDu1upZJ84eRLEMqLfFKX/p8Ue4Bt3alKw64qkzVBSfgHnFDYNSR4Pm
         Ttkm6F75KIX5misHMBY4EHbwf8BPPYI4IE06iCzFAQAZk8gPAigau7bDQmT70Ahcfbmh
         qHl67eu/+a7nB1hBb9MyIENHHgOX5VKvDaUGaCTAZzuD7Cg+MIe9SB90dp6qXVovb0Gu
         ymZswTHlpw75FlMKqwOfDUvos/aK3ZzSaPnodIcSmZtMj7GRectKgSmhphM+BqXcScm5
         LjtP45aLtqdjsiKDE+AOV2Sj90RwMvWEZvH/qUMjb9vAaLbM+t+YUEr7eodgMh1bLeLo
         J/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738617574; x=1739222374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1RprFycDuHJldRn/ezrS+F5IM4jHFkaXUl211fTz08=;
        b=jeO/QL3x+2GbXR984ZBzqVfLkyhNzyKQRvHIrODjUGlvICPSBETdt+rfABgo56y1gZ
         r210AJbYDiUEHROM+9Ackp4Wf6LRQzOp3QPJ/8XIskx9qlyFaf4ooQ4t52OoBDX+K4sY
         Fvfs/M3QGrSZL2DeZIkaIBVOwMSQBnBA6m3kMk1SUt0+sNmn2Oq8/NzgJF5J7vckJQ7H
         ZaS8RUDxF320PujJOz6MqVU3J+WUTYmGNlB1ZFvn0YNx1BNBQHlO956NSwG6d3NEUZ1M
         SjOWn3nM8ht2OoGq7LBgOkYCK4h7NB56lWN0MS4MPkxvFJ9j1YGLH+RA2CAXTGz6r7+w
         JTww==
X-Forwarded-Encrypted: i=1; AJvYcCUJpe3ycE+G6sip/Dz20D682kGflFR3mKSBiLkRiiVJastzU05Dg6Fa6hk2+JeIOz4YgFwN8mY5JhxnrMw=@vger.kernel.org, AJvYcCULfmGoMI0QBvWeqGZ5v1fbvZ/vnXU2xrODroYCp8rV4y8GaQIPWKI2MqT4PynvhFbLAVqn9gFET8Cp7A==@vger.kernel.org, AJvYcCUdekDuxZgEFzXSpphBDQRoPkkefDgZRqdEopSBOrBtFSTsp72lay3/c+/l5uM3p7vM4n71rrnvk8sQ8iA=@vger.kernel.org, AJvYcCV4bj0n81xB+tYZw/illWJdbRSNR2w83zW+KfPO7//S6JJl1Pj93eNg4m1GxztlOV5lV4vteNSQ7gZkNg==@vger.kernel.org, AJvYcCVFQyQj+7TEr7T+jZFoGcQyyXESPKljizShOBGfb0ypdnufH9VPZ7f6LUyC9JTvwEB9Ma6EjBo+WFGe@vger.kernel.org, AJvYcCVIqofbX745Us/vOLeigmClTYtKFg9STRQmzoW8SwOLkYxey7A82vktd/NEIVhye3c6+PMM++4AsjvmnSM=@vger.kernel.org, AJvYcCVmFm4MxsMoylNE4tKEPiU0fqaLiJRIp6AilynKGdZD9nTlbdo41UJ0UHYgVsm3qQ6a3GDng0vPt2XD@vger.kernel.org, AJvYcCWKVHdaVzta6WsTGcU4oNgTegxlD8TKP5zn9BK44Oxvm7cp8hFA8C0TqyN9XH08Z8TEtrhm27kUEQVd@vger.kernel.org, AJvYcCWmQQenG4bnnOcy3lVw+BxPBM7PKEv/F1UfPbcrKvu2gZ8wpuV7ltQEubyEN+FmsRLvmHqt4E1nMsI=@vger.kernel.org, AJvYcCX1aQy4lxshEe0P9tYftRsWGvTh
 JVX/ZMPMPpe6KxbceJUyAr50IONQNEYuLsMvVVoKso58+6ZPRTl8@vger.kernel.org, AJvYcCXBnWUGrvZZrWnUn2D0Rxg1t7fgp/ghTiHFlqKMSt0TCYPjvIeofyDG7/XC3Q7pXvOz01YDABprXOUK2MTZNSaeDu3l+A==@vger.kernel.org, AJvYcCXuNT1kngL+byCHKiB+uAy67tygETz8kqTV8QsTm0Zcc4TX9MhuGEhEZtOFihwchSPS/2YJGMheZErHqv/o@vger.kernel.org
X-Gm-Message-State: AOJu0YxYnCRY+jMAfk8JzXNQ5wlzlPfUIzlNI9tmNgFDz9glsQgIGziC
	ChHolYga5JsbVztE4TFLnXnPzl6QsPL1s/sp+bzH8VXiMpmjn9wl/xQ8dE8iLENwxtzB668cgKu
	wLDB8ZwS1gT4Kjwizv+XMURBFfLo=
X-Gm-Gg: ASbGncvA4/hiQFF1O/D6wMn+3b4gKQaESvApR1hJ54ApFW85I6VQEzBvTbnR6gXuUMW
	AY3/ewbQHwH5br3Yx9P7hfs58uY419Tr+wi3fTKQe54jqWcrlncvKtaxKsCGunFIeRb7wbbQv
X-Google-Smtp-Source: AGHT+IG/z3EJhnf9SR0K4H9KlI981FGgmyEgJkvQWHpkkih0UJEnWjGg3KJxlOWE94AU8gGejkz3MNO9Uh3+nXXaTBI=
X-Received: by 2002:a17:90b:5146:b0:2ea:3f34:f18d with SMTP id
 98e67ed59e1d1-2f83abdebdfmr37965262a91.10.1738617574433; Mon, 03 Feb 2025
 13:19:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-6-9a6ecf0b2308@linux.microsoft.com>
 <dd0358b1-7c8a-4c9e-88c5-2e1db69a3a35@linux.microsoft.com>
In-Reply-To: <dd0358b1-7c8a-4c9e-88c5-2e1db69a3a35@linux.microsoft.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 3 Feb 2025 22:19:23 +0100
X-Gm-Features: AWEUYZmGyX5TH9PuhG1vFlJR4zNh-9wcNWLcslfb_ZiDi-fTNv4o-akZqj7ScMc
Message-ID: <CAOi1vP_UTjuF5y5oEVquk45udBZ41WqxQpHufD5oK2wbQkobhA@mail.gmail.com>
Subject: Re: [PATCH 06/16] rbd: convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dongsheng Yang <dongsheng.yang@easystack.cn>, 
	Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
	Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, 
	Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 10:03=E2=80=AFPM Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> On 1/28/2025 10:21 AM, Easwar Hariharan wrote:
> > Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> > secs_to_jiffies().  As the value here is a multiple of 1000, use
> > secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplicati=
on.
> >
> > This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci w=
ith
> > the following Coccinelle rules:
> >
> > @depends on patch@
> > expression E;
> > @@
> >
> > -msecs_to_jiffies
> > +secs_to_jiffies
> > (E
> > - * \( 1000 \| MSEC_PER_SEC \)
> > )
> >
> > Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> > ---
> >  drivers/block/rbd.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
>
> <snip>
>
> > @@ -6283,9 +6283,9 @@ static int rbd_parse_param(struct fs_parameter *p=
aram,
> >               break;
> >       case Opt_lock_timeout:
> >               /* 0 is "wait forever" (i.e. infinite timeout) */
> > -             if (result.uint_32 > INT_MAX / 1000)
> > +             if (result.uint_32 > INT_MAX)
> >                       goto out_of_range;
> > -             opt->lock_timeout =3D msecs_to_jiffies(result.uint_32 * 1=
000);
> > +             opt->lock_timeout =3D secs_to_jiffies(result.uint_32);
> >               break;
> >       case Opt_pool_ns:
> >               kfree(pctx->spec->pool_ns);
> >
>
> Hi Ilya, Dongsheng, Jens, others,
>
> Could you please review this hunk and confirm the correct range check
> here? I figure this is here because of the multiplier to
> msecs_to_jiffies() and therefore unneeded after the conversion. If so, I

Hi Easwar,

I'm not sure why INT_MAX / 1000 was used for an option which is defined
as fsparam_u32 and accessed through result.uint_32, but yes, this check
appears to be unneeded after the conversion to me.

> noticed patch 07 has similar range checks that I neglected to fix and
> can do in a v2.

Go ahead but note that two of them also reject 0 -- that part needs to
stay ;)

Thanks,

                Ilya

