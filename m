Return-Path: <linux-btrfs+bounces-6839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A293F87C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3511C220AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B600155301;
	Mon, 29 Jul 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PzO5Bj2D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09290823A9
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264192; cv=none; b=GXP6+ku5Kq863O5H4idu8jF4RvgccKTgORN8BeBWZeDTRAhAQVWTJGjJDjDCHElyl7At+ReznX/kya5G8aL6Qz1FuiGKRn1/1Sgm042jI229gmy3np3/j9fzjPt8+vKZP6bROXV5b+ZOVzCk0XJ64G1XcQ2zxzE9wUBe4Fv4f8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264192; c=relaxed/simple;
	bh=HFEgjcPsdf7dJsWeiKMoPTWYeoebMBj3PqDaM7fAyJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMPisjk4BiMLXweccdVZhLzxi4JtpH0ibYVazmfvwXprVX+Hlmov77qmJb0v0dFO7bJiBia0Zjy1hwTskeuwonLCUOKQ8ylti9pXyv1e4jqucJqjjZk2iXLJNJ+9SXQTHIHO8Pi8LUZYRUXNXjFhXilm9e2PdBA8n732M5RIJ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PzO5Bj2D; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6659e81bc68so22524357b3.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722264190; x=1722868990; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1hUgbKozrIn4+fgAN7wMTNN6TQArjYOKYEt87tQQn+s=;
        b=PzO5Bj2DMeZ4CGTLtDL2dNR1w/gmeiu/kRsndh1EMvdMJWUNW3bENbL/YcoprrKoQt
         6lZbXFpLdDnT8wU7s8KhTNaOpU5byrmJ9XnxLh0O+DDsQLwOPOLQaYdEaqqj74U2vx6E
         N+c+nJv6kBoy3Ev1P4BXg4lWyKSPMLFLSPrsvpz7VoBgh0FfJ0taJFojyd8Z1srwhoZ9
         cxVzRaxc7WWM4veQS5yE9PGYwE+9y9MkBqfl8mkbmM59PhBHi9y9oc7ce7ZSYNLXOUAo
         d8e115/s5joW8stppuhiZxog59ILo5tae8zgmZC4yaKwCvJGsVlVJLNfRJTKAYg5hYfw
         Z0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722264190; x=1722868990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hUgbKozrIn4+fgAN7wMTNN6TQArjYOKYEt87tQQn+s=;
        b=aVgN5Tr8XgNm9SyEl/iY5FyNLMu5EoaweXgs6ZOkEQ84dFM/VTrM/CGVv83z3R6vn3
         7wLKwgUZFli2mhuNSTLBk2EB+Zfo+YOrjjFOZUNpv+3VA2ykk+PrX727tn+wDq+O+h0k
         8HL6pzgWZwVTneJG89fj5oidpsrDLS4mikGFlCN7cM5tgokj7Joct/owcIik0ex0HFA0
         XdvXmjq33Wxba8S3/EHywpjyY7E/ybtjp+JVWoH4X4wVJIaoT9Qh02Y1M+bWQq0jD5Tf
         WjWcu1Sf98qpHHQV9pJRzmtvT32sHmQFdDG8/ondX67yfRwmLZuLhbOPzeaM3dd9fRzm
         BMKg==
X-Forwarded-Encrypted: i=1; AJvYcCUkYjFp8rMRcO29CCFo/z3XcL4y69nJSvKU5YCtRRzq6tqj8MfVvSBwO2yfeznBOjpmNBngmgG0dKxfJhGGg9abick7lU5YgoECLHQ=
X-Gm-Message-State: AOJu0Yw1qyPSR6O6Di+yE1zlo9zYaHMrg+miypVqyDsp1ZoPM9/e2KCj
	HonjOFV2nSZs/X6SZdRROv01JRE6L49uw90SXG3eAkqjrABEibzP7ptyX56N7R4=
X-Google-Smtp-Source: AGHT+IFFLRvEH1wCWgV3z/ketSz5i5bLjkz7lQ0pNumqac+i/2ugARCbJonkNQ9e3gSVH6CEM82U0Q==
X-Received: by 2002:a0d:e64d:0:b0:650:9fb3:959f with SMTP id 00721157ae682-67a0a6125bemr85015947b3.40.1722264189980;
        Mon, 29 Jul 2024 07:43:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd8ff5sm20625787b3.25.2024.07.29.07.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:43:09 -0700 (PDT)
Date: Mon, 29 Jul 2024 10:43:09 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Neal Gompa <ngompa13@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 00/46] btrfs: convert most of the data path to use folios
Message-ID: <20240729144309.GB3589837@perftesting>
References: <cover.1722022376.git.josef@toxicpanda.com>
 <b98b2b61-8b56-4a92-8de8-a75a645c3dc3@gmx.com>
 <CAEg-Je99b+8MghQOJfJGO0eramosOi+8zoeqD6zfO-DK4TRq+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je99b+8MghQOJfJGO0eramosOi+8zoeqD6zfO-DK4TRq+g@mail.gmail.com>

On Fri, Jul 26, 2024 at 08:55:54PM -0400, Neal Gompa wrote:
> On Fri, Jul 26, 2024 at 6:58 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > 在 2024/7/27 05:05, Josef Bacik 写道:
> > > Hello,
> > >
> > > Willy indicated that he wants to get rid of page->index in the next merge
> > > window, so I went to look at what that would entail for btrfs, and I got a
> > > little carried away.
> > >
> > > This patch series does in fact accomplish that, but it takes almost the entirety
> > > of the data write path and makes it work with only folios.  I was going to
> > > convert everything, but there's some weird gaps that need to be handled in their
> > > own chunk.
> > >
> > > 1. Scrub.  We're still passing around page pointers.  Not a huge deal, it was
> > >     just another 10ish patches just for that work, so I decided against it.
> > >
> > > 2. Buffered writes.  Again, I did most of this work and it wasn't bad, but then
> > >     I realized that the free space cache uses some of this code, and I really
> > >     don't want to convert that code, I want to delete it, so I'll do that first.
> >
> > Totally agree, v1 is better to be deprecated.
> >
> 
> Didn't we already deprecate it? We should just announce the removal schedule.
> 
> > >
> > > 3. Metadata.  Qu has been doing this consistently and I didn't want to get in
> > >     the way of his work so I just left most of that.
> >
> > I guess there are still metadata codes switching between page and folios.
> >
> > I'm totally fine if you feel like to convert them to use folios.
> > The only focus for me is to enable larger folios.
> > So the conversion part is totally fine.
> >
> > >
> > > This has run through the CI and didn't cause any issues.  I've made everything
> > > as easy to review as possible and as small as possible.  My eyes started to
> > > glaze over a little bit with the changelogs, so let me know if there's anything
> > > you want changed.  Thanks,
> >
> > Just give us some time to review the whole series though, the pure
> > amount of patches is already making my eyes glazing.
> >
> 
> I'm impressed, but my eyes are glazing over reading it patch by patch
> through emails, do you happen to have a branch on GitHub/GitLab/etc.
> that I could look at it through instead?

Yup it's here

https://github.com/josefbacik/linux/tree/btrfs-convert-readahead

Thanks,

Josef

