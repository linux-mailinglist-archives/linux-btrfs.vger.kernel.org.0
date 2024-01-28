Return-Path: <linux-btrfs+bounces-1875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F683FA5B
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 23:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 421C9B22220
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 22:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FC9446C6;
	Sun, 28 Jan 2024 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GmUzxYOA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D403C473
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481141; cv=none; b=iDZGZGCVlE/zFBnp4JbcYv5cO7agCfpQDnvpmstRE+ipAnFsauxF5fSCnC7p82VBqstP7GCkSYg9puroc3Zu5M7/fKQpR5dkEh/DDN7Dw5ojf4jiJDWl03RhjNLJSm2rjdA+3V/zhHT/tHMe7S9JpYzh1SzqQLMYMo2xKpnJSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481141; c=relaxed/simple;
	bh=AEYZz0WbEa5P8+CB+O4anP0MQfywFaLOnhWBqol5b2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiHuMesOVN100vVGzMmujirZ70iO7SLYUvzW3Oy6qsrohybmxiku0dZqi4PkJmrePY2sJqdDCBe1PxQt2TrYrB5IhFasvyoBTL6A4MG4sw+VM1JxRynqXcIErx/VuWCcZyzDX7T1HKGg51EkwYTbNzx6pSx0pD2OOiB439aSK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GmUzxYOA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a35a7a86b8aso46184566b.2
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 14:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706481137; x=1707085937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bqwd7hhPAgPM5QIH38rfOxpWBqWFIbyQQhTZxa5cgpo=;
        b=GmUzxYOA42m7h/7H4YNdv34VRamsWfZHNZ0+fFrZ+hcwnOSugC+FDjr97BOejvA/B0
         15aSABLiDKGWI+Ddja2wklAoPCVjLPunUNcDlKBoPIj7ovhktc5CpY6AhqBsts39Uo9v
         PoBAqImOt3ALpkfnJXJlAe0T8391j42pTmHrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481137; x=1707085937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqwd7hhPAgPM5QIH38rfOxpWBqWFIbyQQhTZxa5cgpo=;
        b=Xxxri2NNYcz/Wr9lnsd9omSuXwpQ3aM6dQz7qqw/cmcK7L6OY9J78wzps5/wZr7GGe
         0/1bK1jDIicK+UL4Ueo411Moiym2cDauiJgsCwp8604jlPZwqeKJiXQphzqPSqn572B5
         FvtF4XqOlj3h9WSQZILr67x5IbnLG3uyw6Mqtp6RatYeZosPFIOHUFLg/8WqSEEk6/bV
         Z5w0nDrlD4zpkSlWZteInb0rJ3o9qU6Y8x45wY1LHFwmMMI6DlZgmSxfonOq4KcnujHg
         n3BRIGJvQlcarKbsfzj/Fd1siqH83hjiONtG/mA12jsYBV/7zTtgl4uQzto+v7dXk4ag
         b4ug==
X-Gm-Message-State: AOJu0Yw10j5m+k9NCo7eG+6VzPJ+1mL/FL6yKLyBE4OtydB+sITFuPbw
	7wqGwbpUwq8/71NXDjMZudBYWhEXv6JwSlMxT3kzlcqYS8Ziv1xhVxw5TnLSAdmQZR1RVQX78a2
	qDxLDPw==
X-Google-Smtp-Source: AGHT+IHIHvxuHfIx89uaPY0Y5g/Ce7KkENyVP1Fwa0XrVOd/5T2DpVCyYbGiYreryMUnoBsRm1Lmaw==
X-Received: by 2002:a17:906:27d3:b0:a35:ce76:dd67 with SMTP id k19-20020a17090627d300b00a35ce76dd67mr121150ejc.5.1706481137457;
        Sun, 28 Jan 2024 14:32:17 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709065fcf00b00a2cea055d92sm3270145ejv.176.2024.01.28.14.32.16
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 14:32:16 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55cc182da17so2087493a12.3
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 14:32:16 -0800 (PST)
X-Received: by 2002:a05:6402:3509:b0:55e:c6e3:5e24 with SMTP id
 b9-20020a056402350900b0055ec6e35e24mr2150353edd.36.1706481136452; Sun, 28 Jan
 2024 14:32:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com>
 <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com> <CAHk-=whxYjLFhjov39N67ePb3qmCmxrhbVXEtydeadfao53P+A@mail.gmail.com>
 <a756a7712dfe4d03a142520d4c46e7a3@AcuMS.aculab.com>
In-Reply-To: <a756a7712dfe4d03a142520d4c46e7a3@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 14:32:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiacNkOUvT_ib9t4HXX9DSsUCFOCAvbPi+WBkdX3KCq2A@mail.gmail.com>
Message-ID: <CAHk-=wiacNkOUvT_ib9t4HXX9DSsUCFOCAvbPi+WBkdX3KCq2A@mail.gmail.com>
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

On Sun, 28 Jan 2024 at 14:22, David Laight <David.Laight@aculab.com> wrote:
>
> Hmmmm blame gcc :-)

I do agree that the gcc warning quoting is unnecessarily ugly (even
just visually), but..

> The error message displays as '0' but is e2:80:98 30 e2:80:99
> I HATE UTF-8, it wouldn't be as bad if it were a bijection.

No, that's not the problem. The UTF-8 that gcc emits is fine.

And your email was also UTF-8:

    Content-Type: text/plain; charset=UTF-8

The problem is that you clearly then used some other tool in between
that took the UTF-8 byte stream, and used it as (presumably) Latin1,
which is bogus.

If you just make everything use and stay as UTF-8, it all works out
beautifully. But I suspect you have an editor or a MUA that is fixed
in some 1980s mindset, and when you cut-and-pasted the UTF-8, it
treated it as Latin1.

Just make all your environment be utf-8, like it should be. It's not
the 80s any more. We don't do mullets, and we don't do Latin1, ok?

            Linus

