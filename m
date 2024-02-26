Return-Path: <linux-btrfs+bounces-2759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A8866775
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 02:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF23F1F21072
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 01:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E471E12E78;
	Mon, 26 Feb 2024 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuIQ5gam"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3DD2F0;
	Mon, 26 Feb 2024 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708909885; cv=none; b=YJQ7SN8efRZaO4BP7AqT8yhG36IVR7/axEY1l6j6iJnRYXl/O176lY1QWYLbum+SJI55prbtQzJJTm7jqSb9zLtJbpbv4wQfdGtPOx8v1yx3D/7v8QQVw9J4hZKdQd4MEnjqrvG1lronjFlSW797zXSnjeC5Z/uKhU+YCYD5YZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708909885; c=relaxed/simple;
	bh=6qmrE6+jn6YSMGhMW1/AGnwAcB6kCFzMHImpUti6Q7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt7iV7KSTBYEc5cHUm2luPq318h0yjLk91u8XI22Vm78pzzc+Nvu8ksuExtL+sFxyzv9Wg3xf0v0iXD7a1Zw/GEy1FEFGOG7OYb60A/J8jhU9jYmVcNjPE1HROtWsAqW9MKs6fF4oks4sYC+vkBOxSv28GEeAC41SeHaWAb6JxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuIQ5gam; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e75e30d36so497011466b.1;
        Sun, 25 Feb 2024 17:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708909882; x=1709514682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1BlXsF+OuFlUNEpAoVeuxGYC9Hm23Z9ZRhwis7/85k4=;
        b=BuIQ5gamhcpRLPZB9eUeE60EOqa2a6BPAT9g6gCLOXxIdCkNjbrBrRnzkH16zzLir+
         /Z+PA/yUcKHxsfdT8AesPk49h6gVhDj+xEXmQEx47g9DpY5vnSptxyuk/u75o/c60CUV
         GtYPdrl+oQIXMkz4zt2U0UbRMoHWUZrgVZI1g5fH3mm0WyyUZao5+bzPCBtUYBFYw1C+
         VPKJ7xpIaHq1p88mZD46cFSTr3d4xBi9V7RDNgj3cp1v+lr4XWioHlW4Vu4FemTHG9rs
         E5CF3jMX3ugFcLR6issvPFQcqNVw2spBs9tfcf3CdlPyjcdMSKRm6xXqSxW4e5ACERsW
         HO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708909882; x=1709514682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BlXsF+OuFlUNEpAoVeuxGYC9Hm23Z9ZRhwis7/85k4=;
        b=mxghGZIgBIZpXaO30xG2kP8POW/GLGdyivUVQbvCmouzhMyDdLwDywaDh7uK0i9N2D
         emxk7fkKFQB64QL30XINM1WVj67+iMvrPr+KM7oS4uL5105TaBRB422W93eazO28Y6Lo
         VUaLmk05vbGSztWKfG8qa4W5jOHlpKIwO1CNYpQfgvrCrULppCTSmUL5y+o56vYSlQwd
         ldtzTao+rJrSa9usoc4ccjIS/rDC3ZEdz+VoPLvdrmu8aQTHoRVVqqlFhNVP/i+3J+yg
         73kRpQV4LH7/SKgXKpRLsdwOwZ7Ijosjai73QbRNdgS1PEWwFEn7TtBwvDGvgL+VdmDn
         p7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU/r16P3llFN41IiovvcmpgAlSPCTN42xPembjsEQhC2RHuTIu228EOYhrLCNMi9d9suvR74mIUcsuEzz1KjAVhxFztdKZ7X/9bbGL7i4g58YxLkug2nLXYmglTdy4QSCikKotn1o0TB6EEWXovltiqjjj6ZIlAhLqWhGjNbjUbjbQ=
X-Gm-Message-State: AOJu0Yx1Sn5rzuk9SZpLHhyyrR1CGKDVyiVC3WfiMTqnUxjud3E7yeM0
	qwLBI0w5worDQD/tgbxzu6VEVshtm/tuDQJuhylmtFruwYt41BKX+xufO/wujDFK0wRJRoRcHGo
	JBjzt+RrORqgaJKYfIZYCrVKSHQo=
X-Google-Smtp-Source: AGHT+IFOehwj84kQIRqQVYwkOgQPHTcWeDJbPeGXLVkMYA3O7eptousMzzl+O5lBqPSUgagXimIE3CIvovIB7VA25zI=
X-Received: by 2002:a17:906:fa8d:b0:a3f:f8a7:e1f7 with SMTP id
 lt13-20020a170906fa8d00b00a3ff8a7e1f7mr5091442ejb.5.1708909881496; Sun, 25
 Feb 2024 17:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com>
 <c6924533f157497b836bff24073934a6@AcuMS.aculab.com> <CAHk-=wgNh5Gw7RTuaRe7mvf3WrSGDRKzdA55KKdTzKt3xPCnLg@mail.gmail.com>
 <59ae7d89368a4dd5a8b8b3f7bc2ae957@AcuMS.aculab.com>
In-Reply-To: <59ae7d89368a4dd5a8b8b3f7bc2ae957@AcuMS.aculab.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 26 Feb 2024 11:11:09 +1000
Message-ID: <CAPM=9tyJQw2OPP=-WTozVuvzRiRrkk-BtZ+82MQCuUmjXBLKbw@mail.gmail.com>
Subject: Re: [PATCH next v2 08/11] minmax: Add min_const() and max_const()
To: David Laight <David.Laight@aculab.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"David S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 07:26, David Laight <David.Laight@aculab.com> wrote:
>
> ...
> > Yes, yes, that may end up requiring getting rid of some current users of
> >
> >   #define MIN(a,b) ((a)<(b) ? (a):(b))
> >
> > but dammit, we don't actually have _that_ many of them, and why should
> > we have random drivers doing that anyway?
>
> They look like they could be changed to min().
> It is even likely the header gets pulled in somewhere.
>
> I'm not sure about the ones in drivers/gpu/drm/amd/display/*..*/*.c, but it
> wouldn't surprise me if that code doesn't use any standard kernel headers.
> Isn't that also the code that manages to pass 42 integer parameters
> to functions?

They are all separate in C files, I think we could get rid of them
pretty easily in favour of the standard ones,

Adding Harry to cc.

Dave.

