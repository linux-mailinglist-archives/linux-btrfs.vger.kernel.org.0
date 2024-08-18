Return-Path: <linux-btrfs+bounces-7307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66650955C5B
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 13:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B37281B8E
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 11:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88794224D1;
	Sun, 18 Aug 2024 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="i0DvSryU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA031803D;
	Sun, 18 Aug 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723981544; cv=none; b=FLyLxScpNYVXkBLyVBOKC/iPp298TW4ajxFUgVVFpKW/jQtHmFSYvMhnGE/AVd6emiT1f3tGFUmcYlbSCpvXgdKxj4EgB1lOKKG3/vHkGjbBaJftkKxFl2X9cf+eeSs/vhJmRnzfa3tFrjU9ITujWekc7M4QRpm0JjeWLlxdK0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723981544; c=relaxed/simple;
	bh=Ee0NJhwA1mFRhyXTh1ahgd08EBzvfs/+Rge0vDVW5Eo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=lmJ9znYbRPOzW3AZlnBTi/DXkwN5CKFV58xrW5UsGyfyZtFgVbfoIAQt+X18G+Mxi3jK1hXYti7tyGHy1jD87lE47nybVigS3UXnjaPCzEvkodFyUEW+bhtigGyyIa584vDygBw1NmnkhIID6ZTyuzRzQzp+/rO3tRHat8VwcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=i0DvSryU; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723981533; x=1724586333; i=markus.elfring@web.de;
	bh=i2wEq5t2ni+TcH94U0okDlCDrekF0+WUCWcIYa0wtzo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i0DvSryUtVwFGTCcIU+HgRC3ND3GrwLXQZXC8bjCwJ8J+Ux4xyCmEaoMy7KMFh98
	 Y00fY3kthfnO8yyDjs9nygGEHBtAHmm9tDAiD1Q7obtGq1PrH1Tu97jy5epX9u4zp
	 x/e544jmbhEbJqewLcbOPG3Y/BG4IevCDeO5IsQRCdHjnjtbX2DUAIRo2EzBYk/pe
	 ZXVdRA3bN2GOo8mtAh4/ZV/G3f+bPoSt89ub+5W14UA+6A9m33p/DGbHv+X4GOQpC
	 YF4DHkUgyzw7YOex0kut8tnOX7fsLR7GrvxvP36paAbrxgYvNpFDwoDZTQxGZk0XN
	 x3JY/DkcOMOaGSPHzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1rwJbQ2Zky-00zNsj; Sun, 18
 Aug 2024 13:39:12 +0200
Message-ID: <6e9dc4ce-fd4c-42a7-9839-6bcdfe5d0cbd@web.de>
Date: Sun, 18 Aug 2024 13:38:29 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ira Weiny <ira.weiny@intel.com>, Navneet Singh <navneet.singh@intel.com>,
 linux-cxl@vger.kernel.org, linux-btrfs@vger.kernel.org,
 nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Chris Mason
 <clm@fb.com>, Dave Jiang <dave.jiang@intel.com>,
 David Sterba <dsterba@suse.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Josef Bacik <josef@toxicpanda.com>,
 Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>
References: <20240816-dcd-type2-upstream-v3-21-7c9b96cba6d7@intel.com>
Subject: Re: [PATCH v3 21/25] dax/region: Create resources on sparse DAX
 regions
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240816-dcd-type2-upstream-v3-21-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SDZ0mAvNdLKow+wykbK1KiOyQmXyTPlV1uC1C+eCaomkPY5xVF2
 iMLv8p4ZioEUFddT9msWDOy29paAp5SqQJw5+cQg83gm8AaFg5A2ZuGdMWZzh/wqHa776u6
 w0rS47wRs/rUhw9FGiT5WqiEg8JqTyszPl/bfsw8AYnTxlhH33+ddmoKTx1/u/qeZjyYl6k
 sU/i0aJ6l2PAogEC09NUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZcGeyuGiXPE=;u8RUXU03d6tpqvo7a2y83Lp/vB5
 4CMNtKFulyvvi69D2gS8xxY/sqZqmd50D7+9goxbAonCZHsIhan69YK5H4kV+vU5jNzn+3jxB
 GnljVFqfylwL0PffO1d86TOjtg4Ekdigo7sCmAeOT1h9GQzuM4eYuJk7hrR3C1t0OBOLDVza6
 V3TCwfLoD7vBi8ZqcKtZtJY/VWa3q2YnqBGpXqA5tjPLOOp5ABCLbnaXHcm+teAHjzSAhYRxr
 dOkLCfoD9kej45UQJHdbYlnjhTjq/MD0EpshG4PsnA0N8qeGtZf81KxNZ2CT5ELF7AW7/Q6WN
 FtAEm9Z9vdox5M0j2mVPvXPmcG6kh78PZk0iWX7pAqfMdQgfnN21peafg1k+sMiLUIog5MuKe
 sPJQbaPEp42iYbtOX6zsRCCGusXaHjAMtWBXDBVrxTdbqDKmZrJArM4nfQDcVR65b7CI7Gg1Z
 XhffZAQb/t/n9rf5JYA6OTup4Ks3FcCwTJcZ0bkUpLNQcJW5SsPBOLTNYrMDp6WoMr8hiNX2f
 PCSiz3Ph9R8iN3ezyHZ2i3ELinvAQbCC7C7Em+mneTk0WWUC9/DTtVGwTvHXxI3YCJDrqmGRf
 Hu7838t6IQ8ZXLE9OfTzimAgj1do8IIoSMgtdpAnO49azkKleR1mnuy5wOsCQ5M9NYUyV+cpP
 8HnzZT8eXtp07OHpT/b/umw5X4WPXZdqKmSELyqyrKW3BFylfId107KQzJLv8DIAspDueSKB2
 zOLz/iYk6EKcmBVb3jcL9guSy1ysLtP2NsIi3eCkUHqqKy+dhWA1BC/48RSaOGEyCEPYYArDy
 pLZ+dJERm06WFwZR44ZvU4cA==

=E2=80=A6
> +++ b/drivers/cxl/core/extent.c
> @@ -271,20 +271,67 @@ static void calc_hpa_range(struct cxl_endpoint_dec=
oder *cxled,
>  	hpa_range->end =3D hpa_range->start + range_len(dpa_range) - 1;
>  }
>
> +static int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event ev=
ent,
> +			      struct region_extent *region_extent)
> +{
=E2=80=A6
> +	device_lock(dev);
> +	if (dev->driver) {
=E2=80=A6
> +	}
> +	device_unlock(dev);
> +	return rc;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(device)(dev);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.11-rc3/source/include/linux/device.h#L=
1027

Regards,
Markus

