Return-Path: <linux-btrfs+bounces-9607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2E69C796B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 17:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AB62821A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 16:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7BC1FF5F2;
	Wed, 13 Nov 2024 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XsocD30/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FAC16DEA2
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517075; cv=none; b=t9xcuWK7ReymxKuxu/JwHzIxUP1EPJ0hxkBsd2O+mbaUE9aThHrywmGPjN4axJGnPHpJ1e3G7VlwVxSpz/zF1FiglqgN1qY2P0AtRZT6cqDjacKvvB4BdKJIWVnL4ZzEJcbeCDKOvCbtBZMNG1LvjA6MW+QTFL3zuqppUwZifhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517075; c=relaxed/simple;
	bh=csPBoYSDByNBHf+k5gUPUX7+wR76Q1hEBFh0oJb/HtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=to+fYELMkN+8AQla6DgOako3OkulW640KE70mldbul0E4ar1Hl1gP35rVmLKvs/Dx5fnyLxUD+znAtNvLHazsU7xVz/968J5dSOk3MFsjmcJk20+eV5sQHVoTpkZQzErxZ6PnKN6N1O1PQlEBgSt51lLfU1UpIIu3zro7LrsueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XsocD30/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so643087266b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731517072; x=1732121872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r6dKI9I0XiNa6P0LadyJEAqhNHGcRQ6Z3i6i70GfR1Y=;
        b=XsocD30/gXul2vROh5Ys/l609H69kF00w7ADaURIHXGD2wnw+esQzMhYoLpPUNux1E
         enpgwxayRyyogPs5s0BfTt4louTe7d2f64Fs7nPY/zaEBDf8mHLPx3b/3tIkSuvLY02i
         HEoA0zTwcH3VjX7zxw3Pp+HS25XsCpSdpgnkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517072; x=1732121872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6dKI9I0XiNa6P0LadyJEAqhNHGcRQ6Z3i6i70GfR1Y=;
        b=gkFc8Uj8Rt3b/kwsv9AmwtcOtRbN/t4WPG1UM6reiIKK3BvVIMqmWTPZB0VnYKC9Nu
         Fr5xOi+siidlEwOWYPqaDTnXYPoX0d5XPxQHZN+o+78fPkWxJxNiNwe87Cv7b3U8FOtI
         Dc96lHyZD/ypTRPhB7//TwRlQWET+AeAURjzJEOFgaN3CT3ZjKNt2GWd8f7Cnh4E54IU
         vCfHDHWT8ALphXqtqMl7NFwhEk6y5rCSIhT+Wopmw7ZNKZqtJ0gNGVbk8UimUKcEDcY0
         svgUGcLomuXUD3qhqOhH35e5st0hPG+q6CjAgZLScg8Q+3GFh8uyP1Nc4GFrkisKZACH
         nX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhpsjfqLfB4+JIfBnSkvwO/XB6f+tziIIlErNgDs2iRSBhXBX3x8yxLSn+i1vMHqwXn9PXv2RWtrWHpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3DbxfIWN0kAucTISiMofbzWIIA7a3kIi9HLKs+Hoi63Av9Q1
	xFjaOl6R8WaDu/7B5VUkNbne5LS6uQEEQfnyw2L0coaYzpmJf7ApnauorkzPUlMFWm6vIq5nP9v
	cJN9BLQ==
X-Google-Smtp-Source: AGHT+IHKDMdbEFKu7F6q4FW6ygtqUtdFdNpKhuzGnRmo0Vbt6Rhwzv9tYJbtqGWDGHIYuLQGP+aXUA==
X-Received: by 2002:a17:907:1c12:b0:a9a:dac:2ab9 with SMTP id a640c23a62f3a-aa1c57aff74mr562654966b.42.1731517071698;
        Wed, 13 Nov 2024 08:57:51 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4c97sm881986566b.131.2024.11.13.08.57.51
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:57:51 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cf6f7ee970so1034906a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 08:57:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtgwfBBKRzFH0Fr/+dFq4wd4eKcjD2flsGZUII4jj35T1kNTlgk6L01wfNe6fsx6lYTOo4cYqVKmBHjw==@vger.kernel.org
X-Received: by 2002:a17:906:7308:b0:a9a:3718:6d6 with SMTP id
 a640c23a62f3a-aa1c57ffee4mr725890666b.58.1731517070805; Wed, 13 Nov 2024
 08:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com> <CAOQ4uxjob2qKk4MRqPeNtbhfdSfP0VO-R5VWw0txMCGLwJ-Z1g@mail.gmail.com>
In-Reply-To: <CAOQ4uxjob2qKk4MRqPeNtbhfdSfP0VO-R5VWw0txMCGLwJ-Z1g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Nov 2024 08:57:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigQ0ew96Yv29tJUrUKBZRC-x=fDjCTQ7gc4yPys2Ngrw@mail.gmail.com>
Message-ID: <CAHk-=wigQ0ew96Yv29tJUrUKBZRC-x=fDjCTQ7gc4yPys2Ngrw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 16:06, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Maybe I could use just this one bit, but together with the existing
> FMODE_NONOTIFY bit, I get 4 modes, which correspond to the
> highest watching priority:

So you'd use two bits, but one of those would re-use the existing
FMODE_NONOTIFY? That sounds perfectly fine to me.

             Linus

