Return-Path: <linux-btrfs+bounces-5760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE8790B435
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 17:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4777B3A0F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E98D16B3A7;
	Mon, 17 Jun 2024 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="R15MkVJZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46916B3A3
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636142; cv=none; b=tHB+y5yTMM6iRz7c94KevQ7rZJuipAQlP0hKujWacAz1C/A8MlfnEX43q0YPnsF/TlTENtx+cxt5KKSnIoBM2+RJD37BwV39CBDMgT79gK1kSjcLzm7KjzkuSIzvE9czb/OVYAthXsSjyO3NSMaBZv+FASQu3b21Xw8Zr+Kl8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636142; c=relaxed/simple;
	bh=rT7ZPSficDs86CikgqrU1aLmLCHEfIrxgKp0PNlaLPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMMiL6pQZeZK4UpdJEcu2De+1cysnovl/YxfsCx9vyDYjENQzKea3XI94EQGgzcxQBNGvpFaVs4+nM6eTsJ3+//+9cpAmmybSe8ddqIJzbop9LKl65ucEpb7TvoTBYWBaXsLdrU+xONR+qMgjI2l5IWE0Z6qHNw4r4nR6tqwL/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=R15MkVJZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f0e153eddso574427966b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1718636139; x=1719240939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl/RfqPaFCWoc2jxL/e8YCBcHJ5KVK5I92gUY4NVJZw=;
        b=R15MkVJZFkiabV9xgrExo86l/WWMJQ9xtDqHBJeqC8r2ervq2Utt1ViocotM9vvmpQ
         i8vqpDcACUeuv3j+39j91Z/fWHz/C5Hso+PN1rFfXjPkV5ii1CPn+zzQpPL693b8uTGh
         q2QrY/n+UNafNJJAJmXk9EYDRf3z6FbJNIzWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718636139; x=1719240939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wl/RfqPaFCWoc2jxL/e8YCBcHJ5KVK5I92gUY4NVJZw=;
        b=Wn2mjWn55UEzwcPx57yB9uBLmFLaG5RPAl2xeW5M/mcqgcR+5xVnoHP+S89U0iahH4
         gEeUu2jKsaAatGN0ItRYj1yEbYT5r72oyen9zQBX+y+CA/zvhaEheaFS+V/g1pxJapBu
         UxD2qg1aUBxeUmNGyeaxnBc49zFVsN6RQh0IyuQaCemZvYb30BpD53LVKJhCvGhRahW3
         yf4DAVQ5D9Jw8msU8mojn6SInd9pgMRwju5+tMWJ7S40YlYIXxlLDo1I6JK1pXXF/B9c
         zgMCymc20j5mR+pvEmhtztqnb7fSf7bCL9G6wlTIlYIcsL5yOV35KdCtBkJvjV8HslHU
         Huuw==
X-Gm-Message-State: AOJu0YwbJNs3GA37MrUxz0NPVP9SIJN+0uprvAtr2aBZjH16082Do14w
	qY5cROyjaq+ZR4jZ0V9fNfqSV5U+fyhjnApnJxMcNt5voSwjrm13GesAptS6tDHKUm2C0LoYG+b
	DPPdsl4EIwzIRmA9bg65ZLwXo2ZBiEnPfg6Gc
X-Google-Smtp-Source: AGHT+IHoVkvB9Z8jLN3JKySxhUlyMvfq0/Jx0pudr2GtIaaYk7YyMdI7t8Sr/MVWQMgBpXOBp/J6tKH6Uk8fWuedPaU=
X-Received: by 2002:a17:907:c706:b0:a6f:818f:d4c7 with SMTP id
 a640c23a62f3a-a6f818fd5cfmr301297966b.61.1718636138834; Mon, 17 Jun 2024
 07:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ5KVjrg0OO1eEXyC85Eg=97oP_CWvOdQ=1ZFKLKLOojyw@mail.gmail.com>
 <20240617134637.GG25756@twin.jikos.cz>
In-Reply-To: <20240617134637.GG25756@twin.jikos.cz>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Mon, 17 Jun 2024 16:55:12 +0200
Message-ID: <CAK8fFZ5E61qNKC5TtbWm0vTtRMS0yRt=TE0gP8HnamYig+vJ5A@mail.gmail.com>
Subject: Re: Linux 6.9.y btrfs: "NULL pointer dereference in
 attach_eb_folio_to_filemap" and "BUG: soft lockup" issues
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, Igor Raits <igor@gooddata.com>, 
	Jan Cipa <jan.cipa@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>
Content-Type: text/plain; charset="UTF-8"

>
> Hi,
>
> On Mon, Jun 17, 2024 at 01:33:59PM +0200, Jaroslav Pulchart wrote:
> > Hello,
> >
> > We recently upgraded part of our production environment to kernel
> > 6.9.y. Since then, we've been encountering random kernel "NULL pointer
> > dereference" and "soft lockup" errors when using BTRFS. These issues
> > occur sporadically, sometimes after several days, and I haven't been
> > able to reproduce them consistently. Due to this unpredictability,
> > bisecting is not a feasible option.
> >
> > Attached are console logs from some instances of these issues:
> > * "NULL pointer dereference" in "btrfs.issue.1.log"
> > * "soft lockup" in "btrfs.issue.1.log"
> > Any assistance with investigating and resolving these problems would
> > be greatly appreciated.
>
> thanks for the report, the symptoms match the problem that was fixed
> recently by commit f3a5367c679d ("btrfs: protect folio::private when
> attaching extent buffer folios").
>
> > [1072053.328255] CPU: 15 PID: 2354438 Comm: kworker/u195:18 Tainted: G            E      6.9.3-1.gdc.el9.x86_64 #1
>
> 6.9.3 does not have the fix yet (unless you're using a manually patched
> kernel), it's in 6.9.5.

Thanks, we will try the 6.9.5 asap and report results after a few days.

