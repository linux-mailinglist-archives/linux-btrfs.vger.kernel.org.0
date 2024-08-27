Return-Path: <linux-btrfs+bounces-7576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DE0961895
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 22:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9480C1F24822
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43DE1D2F72;
	Tue, 27 Aug 2024 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="a4b0ZKET"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D30537F5
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790952; cv=none; b=drEv2L5eRIBa21jxIYnnI+Y+ceBeUKUK/kf0uI3svDfbzB3OIPema459FSoqGPShWmSpdA4pLbn8LD13fqUP2HlyrMoFQ/RcsYBeazyedK4b9hZY901FRn6zX4NFLDF44+HFoZP67FoZRimjP71DmnmtVr6Ca01EXdEPrYeZUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790952; c=relaxed/simple;
	bh=8F43L/CC5ZBEqJk8hNuMZvbIe/N21+a1eAhsHJ1niQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaOPxeL+ANetZhptknG8aBNcYcZKOwbxp+z04Y2lb5saUt9LXMqBG0Q53m6rUTIEDyLUFZyESj2pLIpWTmV37ftMw4aRtsKnnAMsJ3ZAVbS0HC2azLsSZW4/RS6sz44fWZbB2yOeXHVDkh2Nio9y0cVMi97AJSmLk5fxBeF78tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=a4b0ZKET; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6c0ac97232bso49442727b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724790950; x=1725395750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NPvcpNlOBjX8vOhO2ph3IzoH56fu+jpQNUsi6G9CoaQ=;
        b=a4b0ZKETE0feyi3zNF4xWfBz3R4nEqpZhATz6VIV+OWzMwQEUyd/eKGJoqOlrk5UWn
         91CMyDw3gAvdD+HL/lB9il+VUYJngP1OwLXWynvl4Im+jn7ZsoVs/QMgkUO6S8H8ezL7
         RFDjb0aDOqhVdXnGwN/OefQnE+X3saoKokYtfUcDrqdEU17UGSJibfnG8SnfOD+I5vPG
         Jg3UyIVR58FXsNEHG1pCRKHv5iO7gkdxsHLryGECRNtXx/YcVaYty+lrjFWEYI8tUnsu
         OmGPvqFzwQIQ7t8yzd1BcCYTKjvqzom1ROC3uEKkORWxIuq+xH8Ws4LJZ7DLbc3W4cmJ
         6rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724790950; x=1725395750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPvcpNlOBjX8vOhO2ph3IzoH56fu+jpQNUsi6G9CoaQ=;
        b=D0QppvjGTz0MxjVA6zkgAO+fw4nmzmlJ1b22CcRmMLbnaYNzAy/IxhSwh1P9XC7RQQ
         1Lk3MApvUFMSjW7rbHQUBUw1hfIB+mWoK5/69I7NWtHIPRa3olk3EWS7WTm79cz5S9xv
         ROWJqAF0AfjyN1GAafp9adCkByz0qu2KAOtfkqLM9UvjkayJgx18sa6n+8jyUfeu75M/
         3e/Zy+U/ZuiJC5r48Xo5uqbyegH59WONfYcvRPeIXLPHI67YFoQRl7NMNvdpg3YfZby/
         pPhSh63Qe1JiSwphpGsE28d3HI+aPTQ9xwqiy3Qd4ZhEsPPg/7nV4AFHZsO+BX1dpSDH
         Td8w==
X-Gm-Message-State: AOJu0YyZLcj039vpPZWXRVl8i4Ngd7MTAg9ZrufHvIOSw0JM5g4QUxXa
	VSKoYdTuD3w7mlyBd9KNhsK4o2yZFwTVpjpOXlE42BQBJHboBg2miIKg/ZKaUrI=
X-Google-Smtp-Source: AGHT+IGEMWbY1szlK6+TRo2l28qI6nSegoRheQgaYffPlFkgmkdrw9J+B6CDlqEjkLgs+ENKiK/Rlw==
X-Received: by 2002:a05:690c:2b8a:b0:6af:ee15:6c4f with SMTP id 00721157ae682-6c6262f584amr116184707b3.27.1724790950191;
        Tue, 27 Aug 2024 13:35:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d61fe9sm59542466d6.58.2024.08.27.13.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:35:49 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:35:48 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] btrfs: BTRFS_PATH_AUTO_FREE in orphan.c
Message-ID: <20240827203548.GB2576577@perftesting>
References: <cover.1724785204.git.loemra.dev@gmail.com>
 <b5ac0f327ed18a0b6ca9f7d22f3964ff3e1480ff.1724785204.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ac0f327ed18a0b6ca9f7d22f3964ff3e1480ff.1724785204.git.loemra.dev@gmail.com>

On Tue, Aug 27, 2024 at 12:08:45PM -0700, Leo Martins wrote:
> Add automatic path freeing in orphan.c. This is the original example I
> sent with only one exit point that just frees the path.

We don't have context to what your other postings were when we're looking
through changelogs, simply write

Add automatic path freeing in orphan.c.  We only allocate a path twice in this
file and they're both simple with a single exit point.

Or something like that.  Thanks,

Josef

