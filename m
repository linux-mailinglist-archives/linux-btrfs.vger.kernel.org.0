Return-Path: <linux-btrfs+bounces-4573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF28B485F
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Apr 2024 23:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F3528240C
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Apr 2024 21:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EED1465B1;
	Sat, 27 Apr 2024 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RIkdIDI+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751BE144D22
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Apr 2024 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714254044; cv=none; b=b7L8hvWwa1DFESiCUOCXeP041Ko6XInMqDNdBG894WaMR2RLb5loRpfDfdWV5SSV2gcofYdws8lSv1E+GKVKh7HYnrs3dCOGnN+erE1aI7M6NRjZRodN26R49TOLI7hrEcH0pxUH+9Gp5x0RD522ffwBgIdc8OAKkHNza5Zudqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714254044; c=relaxed/simple;
	bh=IIGshDaph8veGUjCfHMCr5hhSRQX7mrwk6r+2BogNic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s29OF2DD7kr9iJUpuE37qFhPqDTwLDWsGJ+wj8qEl3eGzcft4q7GIe6aqjwPpOoB5IZGBqwM7pSUqcSUY9OJplInmVYqdlr5JyQpiTz/sLhDpI+nBtal9JeUrEw6AtmMTOD27JXDPKM+mR6aMfRcc1KL4hh8fvtSSkOdHHgikks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RIkdIDI+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a58f1f36427so32126666b.3
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Apr 2024 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714254041; x=1714858841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mA6ESoMU41euVvMMgdzVMUo8Y0YkwHfh7I4CxBNPhNU=;
        b=RIkdIDI+2V8I0wlOlHmqLljoMUNIciP6A7khKduRcYnE9V4tnDUNvaZi/MKweP8W/B
         idkH6sVzdjp5kc3lCfMLhnyIq5VnxVtydmjeo2jcbtUird1FgWb8lak3l+VfLrOS0rcu
         3pK2tAQgSS0XYMLqZaXgk7xtqFlmNrdPRBqwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714254041; x=1714858841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mA6ESoMU41euVvMMgdzVMUo8Y0YkwHfh7I4CxBNPhNU=;
        b=okZk9NnJeqbImhr1pcmuDAX2s2wDU9Acq9+fo9O+DLV6n6bI63NAUmPlEZiRIZS4oa
         jt8gAQXi3pA5QkX+6KTjUBVEQn+GsV3EFN/Pi48yM//lH2sSmE/J8efTl2Hk1iI6sqaH
         OkwnG9jlRqctE9PlXwshieaxUO+8BJo0/d4hoAQDyNHT+oWm/elQ/5UxvftqisVscOSh
         1cBtDN9weEenpLS7Bb9+UPfmuvfanRFt7TwngSqb1oO9c+xX4bLUmchmsxCHSy1dOYH/
         OPboL6JHjWmMcpBPDB8UEle7yIAv7yvhlRJHAcJwzt3MAPLb7egwlWzAb5UkRPCJdhwQ
         vVoA==
X-Forwarded-Encrypted: i=1; AJvYcCUbSiOlP3F5B7nybH18Jkf3QmnCB1kO2gJovnPTALjs1fi4kwzxyT1WARKc8nA1TZ8Zdu/YbHn9yyZ09sqtNDEPmBwfOg5PYbHkGos=
X-Gm-Message-State: AOJu0Yzc3iNDjEK5QMFYC6Cdq4BHt8TSQMSL6N/6PpCn3iaTqfMumHzX
	NgHIjYkYBRpm8e0H14dB3VuRKY4lvu1mmOEKam1wLNlY9eRQpkSL2QNcZAnD/I2H3Ss7GJrg0aU
	vPkg=
X-Google-Smtp-Source: AGHT+IH6M1cjdVb4ksSWGSP/VlbF2K96pf8zsp349atiWRlC19JO3Y9+H/u4GV7bX8RkzKrh5lpYPQ==
X-Received: by 2002:a17:906:2583:b0:a58:8fc0:fbca with SMTP id m3-20020a170906258300b00a588fc0fbcamr3713441ejb.45.1714254040822;
        Sat, 27 Apr 2024 14:40:40 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a522f867697sm11994685ejz.132.2024.04.27.14.40.39
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 14:40:40 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a58d0aea14cso223567966b.2
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Apr 2024 14:40:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmfgJ5hBMRwNpAm1Uqc0a//TrcIuayxE6YlcTFwryfaqqweL8zgNUBiRyCKMfe7J0qTXIp7nlt+9kkGwpFBObfEq1KU7MC51fJYbY=
X-Received: by 2002:a17:906:22ce:b0:a55:b99d:74a7 with SMTP id
 q14-20020a17090622ce00b00a55b99d74a7mr3773528eja.11.1714254039321; Sat, 27
 Apr 2024 14:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427210920.GR2118490@ZenIV> <20240427211128.GD1495312@ZenIV>
In-Reply-To: <20240427211128.GD1495312@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Apr 2024 14:40:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
Message-ID: <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-btrfs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Apr 2024 at 14:11, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ... eliminating the need to reopen block devices so they could be
> exclusively held.

This looks like a good change, but it raises the question of why we
did it this odd way to begin with?

Is it just because O_EXCL without O_CREAT is kind of odd, and only has
meaning for block devices?

Or is it just that before we used fiel pointers for block devices, the
old model made more sense?

Anyway, I like it, it just makes me go "why didn't we do it that way
originally?"

                Linus

