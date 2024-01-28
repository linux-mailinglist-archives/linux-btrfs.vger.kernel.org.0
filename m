Return-Path: <linux-btrfs+bounces-1872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5759883F9A2
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 21:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3B71F23F6B
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 20:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F303C46B;
	Sun, 28 Jan 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HLbacQqc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E474C3BF
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706471991; cv=none; b=RrEW7pns74xSKagGd33EfB1K8LOU1IWJyf/YTvqSqBlutA17ZjNvHw1F1QxsmvfKd7zJrlKW3lepCW73c8LUI3dD4OiQK36XlSVR2NcMMcmmA8hKr3ETjQhjz6rc/8SwLFw/MuodY/dPzorxgJyeRrpJX0gefoTjWBWyBKeen1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706471991; c=relaxed/simple;
	bh=RQPBgjqLxVYa9z7DAN4AMZv6aMuk7G/qW9fdGyDL5MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nP97WNbhafldrAV6zFf6XkgmEsKJUo0zXFIKG2iUvexYR2MNuaaQOWgFLhccgC74GVhz3MZ8rw8WXy42edESQ52B3QzDPcGkFfWqc67iUQdY0kXCN3Nqmv8nxSKD8Y3X5MvQORfzbc/4INJW1jI34J1r+MnDLNF9irCWTfmqhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HLbacQqc; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso23368431fa.3
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 11:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706471987; x=1707076787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvgl07qLmO97AnDOonOYaDY55AuzJRLfRUuCExUHbJw=;
        b=HLbacQqcZ10CSzcNoAQ72MHpzZ8XS+RKCzZCY0k1uvjX4dMlOAAtiq8bBaGjJ3myvZ
         Ae7OoytbX0x9shmBgYS0M0+eUvd5VhZwS+Y6nJeh0UE35ciQiouWptiORbIJ4b3JE+fM
         tceLZ7v3lg3u3vDzHODtdrEJz5lZ0d+BqpZd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706471987; x=1707076787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvgl07qLmO97AnDOonOYaDY55AuzJRLfRUuCExUHbJw=;
        b=Ba82TiLDDVO4/1NdOPmYnke1n/v1fz0QEURhDsil0KUJxvyXoFzkpp1S/vMmcRwRp0
         kBhfUpMt23nt1cvaxUXscO0ORT9J4jqwFU9z4E4tXSfEMSX8bpGoTY+7J4csGLGQeg5h
         rvzVOEdtKWNOKylGoHdqg3SfeYjgKUiqCc4TkdNhKWsIEpag8p44NjZeTeCnIxM9vvF0
         AVJySaNKnkr2P4iphI+fl+iMl3Si1bEGyFs45aqYZ+AyUjqdXI8wmk0EIWuubxrOkhUr
         xRAUNYGkTZzoJMc1QP+ecCHOl/MXU8lDYriecumPKVGsAdsBKmylVxcsbE9Gn9pzsjUl
         MQ8A==
X-Gm-Message-State: AOJu0Yw7sb/+U1YxamzLWNo0XSjIjaECNV8xhiWExzOp3ZCS9HtSfG9E
	9NBEVGYDPKflY9mLDyxm0xkllEXvGue1czqbRUAkJ5pWjERlzOqVVOacgH5Ge888H1ooOBY2YNd
	Qbwo=
X-Google-Smtp-Source: AGHT+IGWXt02+ym1EGpOeZFz4m0bbRqDeYoXLXy3j9baMEUWaYuR6q86eHYi0Ji/Zv3kPylsb0fd5A==
X-Received: by 2002:a2e:9882:0:b0:2cf:3851:5fad with SMTP id b2-20020a2e9882000000b002cf38515fadmr3188194ljj.2.1706471987020;
        Sun, 28 Jan 2024 11:59:47 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id v2-20020a2e9602000000b002cefb66ef4csm919246ljh.56.2024.01.28.11.59.46
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 11:59:46 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso23368181fa.3
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 11:59:46 -0800 (PST)
X-Received: by 2002:a2e:994e:0:b0:2cf:1a11:ea87 with SMTP id
 r14-20020a2e994e000000b002cf1a11ea87mr3234050ljj.39.1706471985664; Sun, 28
 Jan 2024 11:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com> <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
In-Reply-To: <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 11:59:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxYjLFhjov39N67ePb3qmCmxrhbVXEtydeadfao53P+A@mail.gmail.com>
Message-ID: <CAHk-=whxYjLFhjov39N67ePb3qmCmxrhbVXEtydeadfao53P+A@mail.gmail.com>
Subject: Re: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, "David S . Miller" <davem@davemloft.net>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Jan 2024 at 11:36, David Laight <David.Laight@aculab.com> wrote:
>
> However it generates:
> error: comparison of constant =C3=A2=E2=82=AC=CB=9C0=C3=A2=E2=82=AC=E2=84=
=A2 with boolean expression is always true [-Werror=3Dbool-compare]
> inside the signedness check that max() does unless a '+ 0' is added.

Please fix your locale. You have random garbage characters there,
presumably because you have some incorrect locale setting somewhere in
your toolchain.

           Linus

