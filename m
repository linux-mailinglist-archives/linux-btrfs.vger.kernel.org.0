Return-Path: <linux-btrfs+bounces-8402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0251C98C6C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 22:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA6BB20EAF
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 20:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256341CF2B6;
	Tue,  1 Oct 2024 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="R+vC9bJD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50FD1CF290
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814115; cv=none; b=Zm0zpz3zw1CZrG+l0NxsrR1FkMmqlBmNYVfi1SYCwcajUsYpdWsemgaa58Qop3cgDdW1BiYBBUHsN+N51QgFxzKsHYDRiGHNQmv4KIZyaxE+rp5NNpigJXvWFQ8xFLpMWcDjfdNZLS7YdPSMGGv8dmzloxeDDIpRA5d8cuwOFQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814115; c=relaxed/simple;
	bh=OCExotL4xWLXGM2WW49ff1odvzuoKiB8jrVx1dMoRTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csXb79lglC42knjp18jJavDx6aPUDFytSl394SmAQg11d6cjLbtrePNSZQXpecKJH49oRdrj1Gm6vzACrYYQu2CI/klachSxSb4Da8iisE6DCxdCULN3NVYTvPBnSYTVoy5zc4XHgLMvMVad7nRvzY/sIysKfsgdaBjTW94W8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=R+vC9bJD; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4a3af308745so947448137.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2024 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727814112; x=1728418912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hVESuOaJT7K5vT9oMNImMs3F91VJ5fu449JdfZPuAyQ=;
        b=R+vC9bJDonk8jLPizu4HN8dEozvJs73OLMmjjz9tzvzZt7nhfU5ouPYzodFen7Dh94
         MHzvKR0sbNB8UCet08bo1bMiOt/B9XgnvXWowUu6HpfCnbh3mrwVzSDMUDf8MsdcZldc
         lw2sP8hzXXi06oOpFpVYjN6hNLDG0z291yqhcp0+THu9IR7IKt32c3THoI1YWUt8311/
         x0Fi152yC5V2lvUlAXrkxoqqTglLaO/MYs1iZqhdY17zKhDK2Lgc0BU+T/H1Cs7BBkSv
         jqt+DpuYn8qVETZM1wBqlgNVkNgpJFNrOVBQgYpLYHr0yJ5SH76562DbC5HNSXcbUc86
         o39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814112; x=1728418912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVESuOaJT7K5vT9oMNImMs3F91VJ5fu449JdfZPuAyQ=;
        b=Rf96W/VZVBAXLVfgyaq0HsaNkukd+Ha+CMZjr2zj1BY0cROdrj3tbresbNrUtnDqi6
         sivDQ9hXDux+nmBSCE1uIIkfo8pV2ysUsLHolODM4d5A3wF53y6QpviSvbt+ufVJJGaI
         qYM6moWcnVyaVXxs5DYzXzs+Nr0ibMwVnjSu46MoMjQP55JB3qZGgkR7BqTkRSshTEpj
         mhsfO32rv45OGlP0gOXneSioUx0S3ygNJk/e0Zwy/4a/ppdzFvuMO+nZ5zaYUcH9+xss
         XWi4LYT3dGluB5oiE65kLtKkaZCQEHHwES6dt4iY5ltx92gIjtEcZQ8qafDyH1mRGZyh
         65qQ==
X-Gm-Message-State: AOJu0YwTl8aNdWhkyKW7OyT+RxN5KqOgcY0tukfCZkM7NY1aO6bJmYyu
	jnlIORzuZYwqLk9ZAHG6rUTwOGn6ohD5CyTLhhgzdXpVVU9/4ggIW+4EQ97izuA=
X-Google-Smtp-Source: AGHT+IHPK4xpMGxjqQSNm01cPEg9JUCezJvD+lSD8gH+J6052RmOw2MLnJXWcUwKUqbTQyCEFn6SLg==
X-Received: by 2002:a67:f592:0:b0:4a3:b777:3613 with SMTP id ada2fe7eead31-4a3e69464f7mr757515137.27.1727814112407;
        Tue, 01 Oct 2024 13:21:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2f2264sm49009391cf.56.2024.10.01.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:21:51 -0700 (PDT)
Date: Tue, 1 Oct 2024 16:21:50 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] btrfs-progs: mkfs free-space-info bug
Message-ID: <20241001202150.GB952979@perftesting>
References: <cover.1727732460.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727732460.git.loemra.dev@gmail.com>

On Mon, Sep 30, 2024 at 03:23:10PM -0700, Leo Martins wrote:
> Currently mkfs creates a few block-groups to bootstrap the filesystem.
> Along with these block-groups some free-space-infos are created. When
> the block-group cleanup happens the block-groups are deleted and the
> free-space-infos are not. This patch set introduces a fix that deletes
> the free-space-infos when the block-groups are deleted.
> 
> When implementing a test for my changes I found that there was already
> some code in free-space-tree.c that attempts to verify that all
> free-space-infos correspond to a block-group. This code only checks if
> there exists a block-group that has an objectid >= free-space-info's
> objectid. I added an additional check to make sure that the block-group
> actually matches the free-space-info's objectid and offset.
> 
> Making this change to fsck will cause all filesystems that were created
> using mkfs.btrfs to warn that there is some free-space-info that doesn't
> correspond to a block-group. This seems like a bad idea, I considered
> adding to the message to signify that this is not a big issue and maybe
> point them to this patchset to get the fix. Open to ideas on how to
> handle this.
> 
> Leo Martins (2):
>   btrfs-progs: delete free space when deleting block group
>   btrfs-progs: check free space maps to block group
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

