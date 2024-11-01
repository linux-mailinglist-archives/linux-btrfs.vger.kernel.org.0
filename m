Return-Path: <linux-btrfs+bounces-9301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B609B969D
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 18:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9EC1F22080
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A301CCEC4;
	Fri,  1 Nov 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fi1hi20R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38A84E1C
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Nov 2024 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482530; cv=none; b=lM7nA4uxLKQ3AnTN3f2lNctS5+vzF/ccsU1Q27DsPM7hFUUhJ5Tyg0bWkw1RqQreDaNzxZxczhZHEjYWWiEABWU95aXQnJkiLqD2n879VQ7nDaunxV8WQlXlj+UiN3ntxnPfJLLvSy6d9+OTjCAf0pQc3y8z7BaCJmkXuUCaNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482530; c=relaxed/simple;
	bh=/qBius67naeqWm12WlNmN6qljDGXSjtZLs4qPrvrH8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBGls0/3JKChaM0Rpy8WP+dXIcDt7aK0f6qh/WnLpbF99NuzUbS2FT2fH/VD9OZ1XaqDbnnQUMlF1pqxAV76jl3cDKlmlQKKzrlFXWwe4YZLe2igFCPDnpbIkQWr6TPERKsXyicxwR+5ExTaoT0i9L8LW7fC4gD8skj7lhixG5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fi1hi20R; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fb49c64aso3257189e87.0
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Nov 2024 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730482526; x=1731087326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0+aUeOgQnyVbJx2Y06mDKrssyYV6SFstJsPiHxMKrPQ=;
        b=Fi1hi20Rhgn4YibTmlmyranqH+/CeEVr/+WwtUP1H0ejEhw8PKA05GzYHr7akJDjqw
         7/RwcwwJD9vgbbxEOLElfJ/b9Smi8grbVOb2SPKBrIFrcWV2bGAcAclQJu8rBoLxtSpg
         09Ds30kY8WipcF+nhVkvKt8bXPfpN+yqT/eTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730482526; x=1731087326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+aUeOgQnyVbJx2Y06mDKrssyYV6SFstJsPiHxMKrPQ=;
        b=QRYnQQXAUs0xdundnDXlNpkjnbRVX71bBsuuHoezHxJJvOEmUgGmLN5GEnxfpnu+Wx
         eI6qsbY5l/YoBs6dZu6HpCQO7Hg9Scq1/8tgpNGOXxZWMfbAaMf1TAgqDlcHnLM49/IV
         04rKuTJR7zLQB501mc8yfrsO9LyoZ1WtuurxKmYN6fRtFuHFg1g8B14YvYsSMVmJpJyQ
         D9Ma/riZrMjHahkzSU1VG0vlyCurxa9EgP352IiupZrpa7nRf9otPx+iuGG2ZZNXoR3S
         kJwQWCgfghBO2iKQGCoc2P/fIC15QOWYLcsl4YJ3HnK+KExaUWx4MzbYxoZ3KZ4OoLk0
         jDew==
X-Gm-Message-State: AOJu0YxQb/Xwm1RFvPch6LLl9vbZ9R7+5PSmTNnfltQm6rZGCBGeXn4Y
	nCrnOgg4sHIDZ8SUviy98DJ1uaWXCnFmn2ZU4LZ3dazKrr+VfkkZJ5R+GTmRXOOHTruZkKmeiy9
	JqteRSw==
X-Google-Smtp-Source: AGHT+IFAf3WghdDf4S3yrtKOxjDwJJRYJSR56Ad/T8ekxv/D5e/UZ4DMlwamM8aRcXUSDQT4r8qMCA==
X-Received: by 2002:a05:6512:2214:b0:539:93b2:1380 with SMTP id 2adb3069b0e04-53d65e0bd64mr3707858e87.48.1730482525731;
        Fri, 01 Nov 2024 10:35:25 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde02f7sm623234e87.246.2024.11.01.10.35.24
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 10:35:24 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so35410491fa.0
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Nov 2024 10:35:24 -0700 (PDT)
X-Received: by 2002:a2e:bc14:0:b0:2fa:fdd1:be23 with SMTP id
 38308e7fff4ca-2fedb813ad8mr42097111fa.28.1730482523665; Fri, 01 Nov 2024
 10:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730474495.git.dsterba@suse.com>
In-Reply-To: <cover.1730474495.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Nov 2024 07:35:06 -1000
X-Gmail-Original-Message-ID: <CAHk-=whvXcpX37UCwGxp6dd3DKER0O76+MPqt1gFXoooBsiv=g@mail.gmail.com>
Message-ID: <CAHk-=whvXcpX37UCwGxp6dd3DKER0O76+MPqt1gFXoooBsiv=g@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.12-rc6
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 05:33, David Sterba <dsterba@suse.com> wrote:
>
>  There's one patch adding export of MIPS cmpxchg helper,
> used in the error propagation fix.

Funky. I guess you're the first modular user of the new byte cmpxchg machinery.

Pulled,

              Linus

