Return-Path: <linux-btrfs+bounces-7462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AA995D63D
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 21:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0538D1C213D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 19:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76601192B67;
	Fri, 23 Aug 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CvWQkD/P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED84513634A
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442657; cv=none; b=Ac5AlOduT7iGlkpIM8WV6+P1pcuWBlwUDJbvsEqLIuwz7+tdw2/MwYFOqK9dnezmmKTD7TCUxMwgCds8drHp4bgor8sWNLNJdFnjXuo8/R//AA8dZ417MfiYP/HYMB0SOBSOhMNN9GMIs+Z0sMqxdZEQ7+sSYcjBFZ6RQOAF+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442657; c=relaxed/simple;
	bh=1kQ8WCl3PE4DvsfiQDAhi1qldA68MqCYWkyV8kGMzZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umLmnC+fCTijPNq3USCqKNTs2iMAxXsIbf/RJV3rWJe61myi7osgWO9qh2BvSowe0isW537l+00P/K/EgIEtNBXHsOFy8Z6lZ2tGSR1v1o/OwiWSHC0vHNLbatIcQIfGXlc6grFOStVm/J0IC4LQJZDzwarvab+ZrRhcJpy90cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CvWQkD/P; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6c0ac97232bso20543377b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724442653; x=1725047453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvDUOtqcbYcBaJm8eltM8LTQ5pM/0IWo4qbVFUFMhb8=;
        b=CvWQkD/PFfk8iAFNyJ3NxUA5vTE4dxXxn3NKf1DTaSgdBN4dIpdRkJjCwKJVARf4GV
         IiHRYdybWfZO/JlUc5YU9VHFNnpa0P0IWOdCV9Lwrq4FwGswRvjHtwtYQ+Gb45x5+gbO
         +GbpRsxo+NyWaJaXeGsjG/MSqX1prJo3b4ZEkQgIQjMg5EFUhAHXgJqvVtU22buworw+
         gSs3TexJ/7cZ+Eu9vFQSK1LEhp2k1AqNlpaq7TehCxay92GJOkWNeBHQBjCPQkuGkj7k
         iEJ0ndy6Z+DKy3WBYPLEkuFJ/QReFVy7JzrlwHpTscbM2EZIB6Okb1VWiIiJhOht265F
         i2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724442653; x=1725047453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvDUOtqcbYcBaJm8eltM8LTQ5pM/0IWo4qbVFUFMhb8=;
        b=C/E3y/+KeQsLPhT8cAz0DYwvfOeh9eW2cdULendM3b+ZmpSMFuaKvGqwsiCsmpOWVy
         qLhLvdvmte6B6E1I1P7DhJ6wDh1Ua5XjsauD3JkEKqOnDg+/hOLt+y6UdM0Dqb64Otbm
         hlyGMEaENlgBe+LciavXAX17z0ygP7dREoonJ4gKG/nxyEVpuCFGM7WD7EaoSB3X1n2b
         R4gC6wpFJycskiRe/QSPpCXWeQhK0oLp2AObwovPwLFg1op+H9MtUxNycCAALVMGRuKf
         j4Zb8yk920tH3KEYkqQpKCqfQZ3yMJ7nD7kwYkI8/ja0CnX4lIj2gM+0QuQGDx74pA61
         xpSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdgoS+fu4VELWquyu/cHBj0lwY1xlRUcT5lv4jvCOZVgSD3ghRWOjRwdtmkFnp0z/2MZ5B2yaEwPQ7+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJzy2y2Z3dF1oC44yBSa/jn7KkkiuNgGz4cqbueAV46mvVDvZj
	T3SGNw94poRd1p8RtRjgHCyvtEy/kLfNovefatHFGjpqxq8NOwSYkDJH3ovD6k4=
X-Google-Smtp-Source: AGHT+IH4qOLQPF2HPeO5TqFqGYEIwV4E0AAAjJEh0SIJO2HuyeRtTSkUJvREsKWLNYSeNG9LdY3NiA==
X-Received: by 2002:a05:690c:887:b0:652:e90f:cd15 with SMTP id 00721157ae682-6c62601404amr39080987b3.25.1724442652925;
        Fri, 23 Aug 2024 12:50:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39de3ea5asm6531627b3.130.2024.08.23.12.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 12:50:52 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:50:51 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: clm@fb.com, dsterba@suse.com, terrelln@fb.com, willy@infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH -next 00/14] btrfs: Cleaned up folio->page conversion
Message-ID: <20240823195051.GD2237731@perftesting>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822013714.3278193-1-lizetao1@huawei.com>

On Thu, Aug 22, 2024 at 09:37:00AM +0800, Li Zetao wrote:
> Hi all,
> 
> In btrfs, because there are some interfaces that do not use folio,
> there is page-folio-page mutual conversion. This patch set should
> clean up folio-page conversion as much as possible and use folio
> directly to reduce invalid conversions.
> 
> This patch set starts with the rectification of function parameters,
> using folio as parameters directly. And some of those functions have
> already been converted to folio internally, so this part has little
> impact. 
> 
> I have tested with fsstress more than 10 hours, and no problems were
> found. For the convenience of reviewing, I try my best to only modify
> a single interface in each patch.
> 
> Josef also worked on converting pages to folios, and this patch set was
> inspired by him:
> https://lore.kernel.org/all/cover.1722022376.git.josef@toxicpanda.com/
> 

This looks good, I'm running it through the CI.  If that comes out clean then
I'll put my reviewed-by on it and push it to our for-next branch.  The CI run
can be seen here

https://github.com/btrfs/linux/actions/runs/10531503734

Don't worry if you see errors on the zoned run or the RST run, Johannes is
running down the RST stuff and I need to sit down and figure out what's going on
with zoned.  If anything else fails I'll look at it to see if it's legit or not.
Thanks,

Josef

