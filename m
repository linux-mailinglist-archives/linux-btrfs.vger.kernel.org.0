Return-Path: <linux-btrfs+bounces-4579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008768B4D81
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Apr 2024 20:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADB61F21309
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Apr 2024 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937A64CC0;
	Sun, 28 Apr 2024 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OD+kJilx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ACF1E4B0
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Apr 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714329986; cv=none; b=XU2Fg8Xnsq4Y+94701GoDjMwcaG8FKVfVuNAUCoRGIiGLQ4GFy1dzWrOxG4DqmtO7LkbKyCGVwb46JScRgfvcx9sdcYWDBMCctxPn76Jr9OvlElIMDx1fpbECJj8lMYlA2Phe0Jsp91ToF7vAbsz8ZnJnJ710SxxF0FMEEs+858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714329986; c=relaxed/simple;
	bh=UCyUGbVStsQ4PqcA5v9cIrp44bn4QBwbJ1SKpM09zOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXgR0vVR+GABziq7Y04tFEPgUzk4jjAxViMwwZ9lLBjzcc6ooOqRhweYMkBupXflNz4K9yWg53TBY4vTfr/Gd5UmfuC82uPm0Az3Y6r2nLpvS0ghR122hMM5Ji7Mhv+j+lusYrZm1q7n0QH3kqcwsvSbZVrpTElX/R6fiUxcyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OD+kJilx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so4495898a12.1
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Apr 2024 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714329983; x=1714934783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jGHcgF+VuTvfty4lb510NeRVdXMmfzGhEByfgWFXZww=;
        b=OD+kJilx9xZ9IEnsJx70FScd6agDuG5vRjpJ0LOL784/QHP39vMTjDMQvdRcOeThli
         4WI/T/8IxkN0k4h+Y7p98Sq9F9JeqIOc61MG5SLD6Jj+ZKAUlL1hilvyPcJa9z0IRV61
         ZND9lUMZ4R4febOMl3bHzZyfJ/6NkBW/fNS2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714329983; x=1714934783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGHcgF+VuTvfty4lb510NeRVdXMmfzGhEByfgWFXZww=;
        b=rO3ib7WhkIQynz+/QpN89h0SQ3OQp5jCJswKqrgcjRzkpZXXciE8MNEV3Kg4zvftEO
         3az/nhe4nLq3H/kWmDUq7pjvAJQfisr+Y0KLpo57WULEK+UQFFDxliH1g/Uh8UQ8XJRt
         nfOi3Qw66G+BsvdIE7CZkLptr9Yo0Dc+Nv4w7JV7Q0lsiDt4+uoUH6Cf59GwRliIQEMG
         VZN8aY50quN/sVz2RKKwqocemvdtxLyGBtP+cqd9qpKP4OLSVTkTnqRASZVqodzcpOma
         5FlR7EfulLCiWTqr/IvPa1auu1mg8WpcsTpQaBjKKFMYjqaoVTX8/ERSwMezjFz3CDSD
         prSg==
X-Forwarded-Encrypted: i=1; AJvYcCWeNg+itrrFYfNvewMbVGHKe7bX46Dal2MuzJodPSLd4FDHiPipN+CeQJO9UEkNOEuYelbJcCRfOzVeu51wRf6k2BCGcCrQBPxHGJo=
X-Gm-Message-State: AOJu0YxxrusYXydiIG3O8PRQacoEVwn9cMVAHzoQS7Y4tKWYRwaVjM8n
	ynSkQ+zLruxPE1bAKpsZj96Gr7hTmvG5rtSX1r5wdgF0eXIM/zLEVnkPp9pMtuO89fzrtN4c8bu
	QK6fO9Q==
X-Google-Smtp-Source: AGHT+IH4Pyb3T4GO7VnRrtSmrugmgEKX5avBsNNkTbRUbvXRQhWViPw0et5loUPhE7hszQuJmr7+gw==
X-Received: by 2002:a50:955c:0:b0:572:46db:1670 with SMTP id v28-20020a50955c000000b0057246db1670mr5835966eda.20.1714329983240;
        Sun, 28 Apr 2024 11:46:23 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id q25-20020aa7cc19000000b0057203242f31sm8413969edt.11.2024.04.28.11.46.22
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 11:46:22 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572669fd9f9so2049763a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Apr 2024 11:46:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWc0VAJ+L1xR2eD+VyLHNasA4zvktD3LidLMDVIxSOrKmR3kTIPcJ4ZZFUCqy0YdyE+7noMksH4KQCZyPihFOukX32pZh8Ql9PidXE=
X-Received: by 2002:a17:906:c7d6:b0:a58:a13b:37b with SMTP id
 dc22-20020a170906c7d600b00a58a13b037bmr5288677ejb.56.1714329981787; Sun, 28
 Apr 2024 11:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427210920.GR2118490@ZenIV> <20240427211128.GD1495312@ZenIV>
 <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
 <20240427234623.GS2118490@ZenIV> <20240428181934.GV2118490@ZenIV>
In-Reply-To: <20240428181934.GV2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 11:46:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPpeg1fj4zk0mvCmpYrrs0jVqrFrRONNFgA8Yq6nLTeg@mail.gmail.com>
Message-ID: <CAHk-=wgPpeg1fj4zk0mvCmpYrrs0jVqrFrRONNFgA8Yq6nLTeg@mail.gmail.com>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-btrfs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Apr 2024 at 11:19, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, pretty much the same can be done with zram - open with O_EXCL and to
> hell with reopening.  Guys, are there any objections to that?

Please do. The fewer of these strange "re-open block device" things we
have, the better.

I particularly dislike our "holder" logic, and this re-opening is one
source of nasty confusion, and if we could replace them all with just
the "O_EXCL uses the file itself as the holder", that would be
absolutely _lovely_.

                Linus

