Return-Path: <linux-btrfs+bounces-1835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB6983E46F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 23:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C43B1C224CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 22:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D767250FB;
	Fri, 26 Jan 2024 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f/w9skPW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302424205
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306571; cv=none; b=L8Mh8NB507NgwwJxljdHv/0W2LJNQeGmLbnfkO7bvFnivZLFa+I5V8SiAh/L9BMYyYH1FdDzYQw+6VW+o8xKx9v29MfAYXkBSlues1RRXjauMCzSPBCuMI0FNWxcrSxAmr9wOvHuodijee1PUbjHn0Mt7CG/fCa0rm1jwWaZ1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306571; c=relaxed/simple;
	bh=VRUIw7uC6cqt3OzoHQtSD0pyn1Xety3jUHglg9LCNCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrDF6+jdjgoGhAZVI73pymBNVk+FZepPIHy8KMN2hE65iOTu1js1z1DYQ2vwChMpMVQl2NC/j7Wp735Sh+ev4+t1lWKjIscv4yYxzXiUPKWhtp577nCN3dIrGlu+gOt2IpnuQtyqqluI12GlxKUaC8Z4bT6zkms5ZlRd0oTTar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f/w9skPW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ee82d040dso9881365e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 14:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706306567; x=1706911367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LZbBryar9KtG8ez0HuKdIzGYRXSfuC+F7NhfNZW+cM0=;
        b=f/w9skPW05v46xigv3yeeXmegPZRIgGANgsY8NcxLgAjzRke9bl+aRF6iUiPl9asVo
         Umfia9sRoTQhJfPeM2DJaK/Q0rzblh26Wem0VefO/YWGjSHs5Vyn9XzblKEoH6LsNNsU
         pD1A4ocQVeprOjj/SsWXo8xBs1H2GUF3HC594=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706306567; x=1706911367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZbBryar9KtG8ez0HuKdIzGYRXSfuC+F7NhfNZW+cM0=;
        b=FvyGi0lWkNg2LWuGXjayEt3FkliSts095pD3cMOvYxJUugO447SGkPRDo1XE8d7EFm
         qmO3jkieV2JDPWSd95n+CGhI8KYsTciwLvN6ASMYUcywQsgaP0m3bkNm+wZweZ+N4/C/
         8MYt6jCfYLgIpr8kVZNfRXrp6NVT6z3XLf//lqueosVjo9U5ZB4ourgMsJdi/z977l6T
         qWrwbZ9kkFcKNUqlRdFWDbQ1FYT67abBxff6mLKGfFK5xMvHPT0g0s7A1E61MQ58Hw+i
         EmjNT8joa/Q0BXMDp391PFssss8OFZCit5pRq5d45iJIOrTc4AXwhI8x9MW6Nv/EuuOI
         a5nQ==
X-Gm-Message-State: AOJu0Yyc78dpeq7oqcnvX43+SJMNJo4DbBoK0EPVOPHc392BjTVRL4Il
	Rgz6R4NtLw5X/w8hCCqp+U9+AlyA9kf5t90On7fp+R/QAiANTAILiCYCbOtMKjdWvfSjBfWTx2Z
	OIjh6fQ==
X-Google-Smtp-Source: AGHT+IEgk4jVlbd4YOe2kwOknSidiB20uOWVLjYJQNDNSqGKxB3gXltL8cqx2s6wr7zmqxG2ySLZJg==
X-Received: by 2002:a05:600c:4303:b0:40e:b178:40ac with SMTP id p3-20020a05600c430300b0040eb17840acmr332490wme.156.1706306567098;
        Fri, 26 Jan 2024 14:02:47 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id ti9-20020a170907c20900b00a2ecec00a88sm1056402ejc.99.2024.01.26.14.02.46
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:02:46 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55eb099e299so38618a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 14:02:46 -0800 (PST)
X-Received: by 2002:a05:6402:430b:b0:55c:7ab7:d349 with SMTP id
 m11-20020a056402430b00b0055c7ab7d349mr267672edc.3.1706306566363; Fri, 26 Jan
 2024 14:02:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705946889.git.dsterba@suse.com> <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
 <20240126200008.GT31555@twin.jikos.cz> <8b2c6d1f-2e14-43a0-b48a-512a3d4a811d@suse.com>
 <CAHk-=wjhtqo_FEqZkPuOVUNZzsGhjftdcN9aQpA3f3WD0qS1pA@mail.gmail.com> <7c4bc81e-51b4-4b93-8cae-f16663b1c820@suse.com>
In-Reply-To: <7c4bc81e-51b4-4b93-8cae-f16663b1c820@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 14:02:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj1h8GhhEuqmiCMZW7iBu3k7hn3mJSO9kTm7P31BCZExA@mail.gmail.com>
Message-ID: <CAHk-=wj1h8GhhEuqmiCMZW7iBu3k7hn3mJSO9kTm7P31BCZExA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 13:56, Qu Wenruo <wqu@suse.com> wrote:
>
> On 2024/1/27 08:21, Linus Torvalds wrote:
> >
> > Allocation lifetime problems?
>
> Could be, thus it may be better to output the flags of the first page
> for tree-checker.

Note that the fact that it magically went away certainly implies that
it never "really" existed, and that something was using a pointer or
similar.

IOW, this is not some IO that got scribbled over, or a cache that got
corrupted. If it had been real corruption, I would have expected that
it would have stayed around in memory.

                 Linus

