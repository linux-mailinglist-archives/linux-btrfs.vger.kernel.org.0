Return-Path: <linux-btrfs+bounces-6220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AB79281CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 08:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912AB284477
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 06:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6AD13F42D;
	Fri,  5 Jul 2024 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrCk3/dy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7732BD52F;
	Fri,  5 Jul 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160338; cv=none; b=E3JbkSfyj49N+p9PebwGNJCatAAZNzCEHMJf+3OjfXcbgsSdcyWSvlzniCXkxCD2AgHJQJDp2/3Qig2MhdfVS7NeGPuVU/cNyphy6pg9QaOr+B80+RJbX+M3gITxZ7bu/VXa1nWcOpGchDSWqV1dRu+4SYm8vHBwvgdBrdw/ACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160338; c=relaxed/simple;
	bh=rEC7/EfU+RskXymDz781fmR1JStN/Y2YQhHYC6swu+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUF8muAK1qstrAuAn05pOreUyZNGgCakDkvJyqinTogtqeJPO2jmH7ZBQgNx8w55FI0ekmqyAsCHAzGkogpmakR6WpYcWe6vwtya17zEFBxfbz19hC4iAWgQwK4nFvtazbPbFlaMytr7qgg0SP6Mm1PKlYrFWyNjDcVtT38KE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrCk3/dy; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-64d408a5d01so11824227b3.1;
        Thu, 04 Jul 2024 23:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720160336; x=1720765136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rEC7/EfU+RskXymDz781fmR1JStN/Y2YQhHYC6swu+4=;
        b=IrCk3/dyhAGxPShOGxnZ0wEidE+wIgmnxs33qHNa7qWCUi9TuOmuPqC6wnG954aX5B
         9oOijaB/kUzW3M7EVstzVuajtLQfONZ4OT4dSllFJOa2XcUFkr/7pEjRWj8tdGKp1Jv8
         wjAlkt4e3rhiq4AASXEl1qf1FWPdF0H5WVGGOoB7ccOqgPYWkXZsPbD0/yQugg9hJw1w
         IJ0HaySFnjXiqhZGsxT3Pn3sWe6/YshkrEE79yz88iyR/ZDbXKHjjYBEO98GYprgT1RP
         E3M/JO/ZGXup9a5iTtmA/dHUB6jDloTvMmDnPvjEJSdOpguCn9oBP2aKrsYvZwY5uYXM
         v58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720160336; x=1720765136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEC7/EfU+RskXymDz781fmR1JStN/Y2YQhHYC6swu+4=;
        b=QaMjzrAVinefSpR6YdKsRCxGJYgqWgZugwgS77/gTTz5BAWdUVcFKOpmNDP2+Y06s8
         sd6PVYz1nHo05fr/Xsy0PQBsGvMoEIzpyetXndvj5ky6UhcZdh+JkE2cwbF1F1Gv86h/
         ciFPEQc3smVqjXmye5grmxZNKm8CL0G+afRp9zbtp/6j6k/1DPbsL1y1m9PPfvbGu61J
         2OSRxFqegEvapQKmzOcwDc9cVCcjsuOatl/hJgBS2Kv/6Fbh4xhLu44vxNWkheCh8WI0
         FREqgcclVyPzVweDwAf+0Wks3bTydxS7BTz4ueimSbUsbSYSihQWO/dsOxhOjw8pQRNN
         tDvg==
X-Forwarded-Encrypted: i=1; AJvYcCWXE6n/ATOTzye2Vo3jJo02ckJjLi8pK4l0UvMhhwsqSe0QCyftYKkqHMkf95iVTyz+/sT1cQUg36pjEb6qE1ESSUrTbOBz8VTvg+OKyVPrOt3t7SkX4YebYYZDIrSgTuhoPVISE9RvOlY=
X-Gm-Message-State: AOJu0Yw+B7e9vASxOjqWcZM9ymWvCrkcnoe4NQWIvOGUPA8k0Eam/O8m
	vGZ/YBCRvQ2oXZn/1kaEW02gCpayiYoMHw3rbK8a/QxT//BSY04hFRyeQjqs30tgXObaJYdP74w
	lc7+EirUz5jmhb30KJ6/E+5Dts2U=
X-Google-Smtp-Source: AGHT+IHdXrZVDzTWxHaN8cS/1STMHlHytdAWYoBRFLgeI+cxXO6RYGaMCDQ3SaHKeBbh76/jIajHq3wRoqMqamPesX8=
X-Received: by 2002:a81:ad17:0:b0:630:fe1d:99cc with SMTP id
 00721157ae682-652d8536b22mr33191517b3.52.1720160336516; Thu, 04 Jul 2024
 23:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
 <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
 <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
 <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
 <CAK-xaQagqS0kePozkim7sB_Zi+8NrDRnbqFuLVQ3s4F+0WZ+DQ@mail.gmail.com>
 <CAL3q7H5AFbSy0JC=u_MAfNR-J_kFQkaG6_pXJimD80tchFXytg@mail.gmail.com> <0246e506-db8b-47a8-94f0-943e7be92dcc@gmx.com>
In-Reply-To: <0246e506-db8b-47a8-94f0-943e7be92dcc@gmx.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Fri, 5 Jul 2024 08:18:39 +0200
Message-ID: <CAK-xaQY5i0_SN94oEQQ+qsJgT5Uym-qa8eP+=G3S=je_+YotUg@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Filipe Manana <fdmanana@kernel.org>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 5 lug 2024 alle ore 00:32 Qu Wenruo
<quwenruo.btrfs@gmx.com> ha scritto:
> I think it's a little overkilled for image dump, would fix it soon.

Thanks a lot Qu! You are always fast and smart!

