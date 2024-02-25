Return-Path: <linux-btrfs+bounces-2750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F9B862C39
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 18:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475A21C20EDB
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC2018EAF;
	Sun, 25 Feb 2024 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DpqlcBhM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBA18641
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708881257; cv=none; b=oxYGMrHFgjUkZQHrb0NbfrxXQcpaU2hc8MR5xhW8Rlk2xmE2twdBKE6D+V02nnekLdDTfaHSHM4nThkQ9VV5vevBscgvgish1UKHlwbkHkoGG/h+ZKh5bZR3Bx6l8hS9CpP0H/FKe+aCdt+Av3KEy6Jo5Ps7nY92ELM1nrMoEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708881257; c=relaxed/simple;
	bh=WWHe62jqpP7qRkfkrLQuEDOnSdiAq/+HGLtVLP+TA+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4goSVlzZ6nguYp+uwVqo/EyW6IsKpekpOaC+zqjNsPOSNH2sW71vy/juLvGG8+/sUTQJqrYnJ2pfum4eV+7rbd5peKxysazVJZVDZIQtQt9YepvpE/Jgh1FYWG7ImBDRRzSIzbeEDJd/8xV//0d5kJjeEsRXgFCTHFiCAIhE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DpqlcBhM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so334598766b.2
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 09:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708881254; x=1709486054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0eZgSeXgV3xfMa5j0GZq4dgMO8aNM+WGN0zJZjS5h1g=;
        b=DpqlcBhMhLvtUpYRG+XScFGBv00VhXEQ5QUMSjnWXs3FaOF6AyB3DWV0wfs2oQbZJ4
         9QRGb99QBH79/DE/uZ7vLv94zt0ApT5kYvA7/znY+RlgUA/GnGFC7FuxIvhHCK/tiFeT
         mymG87sOzZpru/vrlHCq5K2UXkvUqNCWLaeoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708881254; x=1709486054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eZgSeXgV3xfMa5j0GZq4dgMO8aNM+WGN0zJZjS5h1g=;
        b=fXFU6VDm+uEZ06LPCpZj+W3av5BGM3PSs7qfBLg88mivrSl2qPIcT6qmcXGUTEFGOg
         QRQWiZzAEn2TBrHcrTWTCY1pqNq9yO9+6P5EzyhKzh2OBUvfJOR1fodlJrwEM16pJ1Wr
         10mnU86wC3UBKOGCg0LU6Xs9knSghsHAc4dB+cuuTVWEg9EwNOOXiaGXvOei8JTFPw+Y
         8kwZk7AdStiyBOSgtnOHY8+Wxm6+NStK/LRMIxNhygBV0iNWoJQT30HybYGawzly/vR2
         xL09PP1Xmf+gukkSe1hQSFKS45DG1fT9fD4tYkyLx1XkwlOPz9qVmkemICzmiRfHQRhF
         3uqg==
X-Forwarded-Encrypted: i=1; AJvYcCXeoQG/Vu0nq2aLtjRFuqtAqYEhufEo+3r+IBwNfX3eGJT9qGcP+QqqWNNLBSbFbORpLlln8SuGkP1y4eYlxOr3xumpz7EwtJhPwDg=
X-Gm-Message-State: AOJu0YzSqtEpq+J8YfReUEyoC4TBgJ+SPNaOqpu7IwuhxYpCJTwappnC
	oiSrp3iXxYYX54gBCBWpV2P+/zIXs7tEOU1kQ1LgwxqZC54L10NwQ2Z8yGyqwsg8YcDrNGB8xKB
	Ju1XeLw==
X-Google-Smtp-Source: AGHT+IGokNqAavzxmw5CPi2t6Ig+FbRj/hEOHHLj06sTJIgMU75s5ciq2wJ8dvxl5C9Mr/H1ZY28Rg==
X-Received: by 2002:a17:907:209a:b0:a3f:7e2:84cc with SMTP id pv26-20020a170907209a00b00a3f07e284ccmr3906153ejb.6.1708881253710;
        Sun, 25 Feb 2024 09:14:13 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906170a00b00a3f64663fe8sm1599547eje.200.2024.02.25.09.14.12
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 09:14:13 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so334596766b.2
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 09:14:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtWMvx+0TJppdrsCke46Em/1qLIAXNANzTilnbAAU8M+cfTD00DQg9593HtJMI7LBny16icAw+RtlGOVWE5fgRQABJ5hsNfVoIB2I=
X-Received: by 2002:a17:906:4f01:b0:a43:1201:6287 with SMTP id
 t1-20020a1709064f0100b00a4312016287mr1617440eju.73.1708881252681; Sun, 25 Feb
 2024 09:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com> <c6924533f157497b836bff24073934a6@AcuMS.aculab.com>
In-Reply-To: <c6924533f157497b836bff24073934a6@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Feb 2024 09:13:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNh5Gw7RTuaRe7mvf3WrSGDRKzdA55KKdTzKt3xPCnLg@mail.gmail.com>
Message-ID: <CAHk-=wgNh5Gw7RTuaRe7mvf3WrSGDRKzdA55KKdTzKt3xPCnLg@mail.gmail.com>
Subject: Re: [PATCH next v2 08/11] minmax: Add min_const() and max_const()
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"David S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 08:53, David Laight <David.Laight@aculab.com> wrote:
>
> The expansions of min() and max() contain statement expressions so are
> not valid for static intialisers.
> min_const() and max_const() are expressions so can be used for static
> initialisers.

I hate the name.

Naming shouldn't be about an implementation detail, particularly not
an esoteric one like the "C constant expression" rule. That can be
useful for some internal helper functions or macros, but not for
something that random people are supposed to USE.

Telling some random developer that inside an array size declaration or
a static initializer you need to use "max_const()" because it needs to
syntactically be a constant expression, and our regular "max()"
function isn't that, is just *horrid*.

No, please just use the traditional C model of just using ALL CAPS for
macro names that don't act like a function.

Yes, yes, that may end up requiring getting rid of some current users of

  #define MIN(a,b) ((a)<(b) ? (a):(b))

but dammit, we don't actually have _that_ many of them, and why should
we have random drivers doing that anyway?

              Linus

