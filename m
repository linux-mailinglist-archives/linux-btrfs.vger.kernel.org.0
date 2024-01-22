Return-Path: <linux-btrfs+bounces-1624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4107E8376A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 23:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E00289417
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 22:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00DC14A9A;
	Mon, 22 Jan 2024 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HTC5bauZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B40610A15
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964092; cv=none; b=SswbckpqORhENQnptuc8zniV2VUWSeGhV6ezosccG+P6ej1+kVh98VWcCVik6WbRqZW4apsgPWZNI5pM435Ea96tK3X8YfMU2Fedwf4uSzNOf6ROm876Jab3VkuUc7jMbrAAjOqHW4qGYFykRhl3Ig3qoImDEvq/6DgX5WuR604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964092; c=relaxed/simple;
	bh=Vv4GoVLQbcboDBK9JF2IcWRLvU3UCl3aQM4sIGzFBNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ff5lDmbWKNm3TCP9vba2Cdhxh2CiykR4jFmFeTFXWxACpf8iDtFZAwNPIEc0hQatj1idkniF8EUQ2XC8syOgAJ6IXywWpobGlRXJ7Na2K4P3/CoL+VkbSLPYprtigPKS/zTXmZ2urrhX7pAdBKGEBYDKxm7zvjx3u551MNECQ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HTC5bauZ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf03521306so10792611fa.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 14:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705964089; x=1706568889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JOEb90GER7mzhUcx62Qpw2hCQjGXAjl9en9ZzJ8SQUY=;
        b=HTC5bauZzFgfwmwUWbkTaKbGr5SLZegCsHkpQ/SvLm9jFvdsSO8N4n8gIK9Bt2stAQ
         NDvcCSZKVE8H9Fl+CFtssBoVBaRmkUpFLYDW/E/ueJoON/yVlecfKjF6cTFUaOnIYhoS
         rI23U9P/hYluSReuBMKbSCBUGCvbpXrxYg8Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964089; x=1706568889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOEb90GER7mzhUcx62Qpw2hCQjGXAjl9en9ZzJ8SQUY=;
        b=YF8uFXaAuadfmXbKy+QkEBCMDi9Oi29bxMIGLcRl+4+cG/XTOIsVnI4ie9OQ+k59og
         IcjVbp7O7B5CGO8Wg1/VN+yOOQCSi93Gyp7SExSFS6fq5Ls/Q1bWc9waJbaAcrTESS+1
         8bhqqdnCstcnhzHqe4MRxH1j/MKyurQRnwWSWO4vnmq3G8gNl6umC8Ixbcff1v83DGzF
         cK/V/cS/MNcL4niEC2maUgJXmbrZuB7CQfiWyMl5ajUtk3W7gY3gFf8WpubkXAYE0Qts
         KH1kJU2vNl+dwPOBzDWY3j5OkBH3PfEw9KihcbFtfBPHf/voPfNPLcORxwc6KIbRJxO8
         xp2g==
X-Gm-Message-State: AOJu0YwZpEIgVin2Lw19Ws2ZFa5uXOK9X8Kr1nuBzyfgnBvTXhZB3xhV
	OV9MeYiCM2uCZgiF4c4WMZ+UkWjdmdw8G5bb5JpRbHVpr0y3A/16umlt1fWskkV5MD94GNNEN3Y
	NyEvZbA==
X-Google-Smtp-Source: AGHT+IGVePn0E+zCTGJal2/nS89TiKnxOAmniGEY9GPCfEYhDuK9yElAbS+QAAG2sOyp1vQngu8zVw==
X-Received: by 2002:a05:651c:4d2:b0:2cc:f02c:c979 with SMTP id e18-20020a05651c04d200b002ccf02cc979mr2596209lji.33.1705964088746;
        Mon, 22 Jan 2024 14:54:48 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id q20-20020aa7da94000000b00559f32cc081sm2887396eds.57.2024.01.22.14.54.48
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 14:54:48 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-336c9acec03so3255709f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 14:54:48 -0800 (PST)
X-Received: by 2002:a7b:cb97:0:b0:40e:8bb2:6bcf with SMTP id
 m23-20020a7bcb97000000b0040e8bb26bcfmr2474196wmi.151.1705964087839; Mon, 22
 Jan 2024 14:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705946889.git.dsterba@suse.com> <CAHk-=wgHDYsNm7CG3szZUotcNqE_w+ojcF+JG88gn5px7uNs0Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgHDYsNm7CG3szZUotcNqE_w+ojcF+JG88gn5px7uNs0Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 14:54:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiroGW6OMrPXrFg8mxYJa+362XJTsD5HkHXUHffcMieAA@mail.gmail.com>
Message-ID: <CAHk-=wiroGW6OMrPXrFg8mxYJa+362XJTsD5HkHXUHffcMieAA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 14:34, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Bah. These fixes are garbage. Now my machine doesn't even boot. I'm
> bisecting

My bisection says

   1e7f6def8b2370ecefb54b3c8f390ff894b0c51b is the first bad commit

but I'll still have to verify by testing the revert on top of my current tree.

It did revert cleanly, but I also note that if the zstd case is wrong,
I assume the other very similar commits (for zlib and lzo) are
potentially also wrong.

Let me reboot to verify that at least my machine boots.

              Linus

