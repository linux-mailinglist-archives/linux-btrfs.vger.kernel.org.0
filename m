Return-Path: <linux-btrfs+bounces-7440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D7495D137
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62C41C22F33
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4A11885BE;
	Fri, 23 Aug 2024 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Pbyo4rcA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0293F156C69
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426258; cv=none; b=a2eWJrBZt+B3b2OVHjCWU4brogMeCY2v2XvQY7y5inR8m9VmHuiW9fedGZo3gszAhMFwqBo/L7LklEyQOyU003cOrY/lJDtzA8diw+JP1LZjQO3GnO+V64c0dzHQEUWePneajx+Zt4PJ4LK6+dHqMulZbrrqREfK3oEX5x7v5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426258; c=relaxed/simple;
	bh=OptJ1J+KR2HYYVOtbLzzZA4wctiDRVhPU8Wec3HgHPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiHfoxmRubSRrgE3MvT/8nQFGcvHSCkY+dRHb1OJ2J9E0wpWfyzcpYAwBbdmSfT0OzRrHV9S9J+6XLgXx/qXHB5W8j6VBBhtptZUZRnccM/LaILliWkswcpeEvF5N1UuH5uE8eIZ23Xwa3S1oTJdl9A1TBdzKJAlTtt6N3Qc61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Pbyo4rcA; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7094641d4e6so1081230a34.3
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724426256; x=1725031056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PavImyZBpQ0ihxMWSk5vea6sJaOx+LLDGLk4+jUyTQM=;
        b=Pbyo4rcAMhFhjg09pqeZZ9SYgPjsxTpNzsVSiuCzKlpPsxqMcvMZqrPvsHCVi9g5Ff
         5o3Rgr1MOwVP0s0BX9cgC7WS0i1YjgnKs9LnczqAd8XzaVy1ybn+9cCJH3gAoxFD9zXI
         8HbV3am7pApn9lpdoyALYgL2eWjgZfGlem9/JNzOhGiBa6D+JyCjPqONw5V7Y+V3Fx7k
         op8VKt3i6FlPUbvm5Qqkz8L2jE/NalkudH8oDEDbgwW5/OKmvbm65xASpcdpOIadIWNY
         Te+7/Mfesz/hVWaNPtFkXPYlb6pz9fAkdJEpmXNkwmoU4Txxgo7C2JRQ7m/E1lZD4SLP
         a5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426256; x=1725031056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PavImyZBpQ0ihxMWSk5vea6sJaOx+LLDGLk4+jUyTQM=;
        b=tISE3E7YqHoaGeaRhRL5Rk0r34FDLfDle2T9NlcE81DoAcGPR63QhcoSwCyHOCioBo
         4Sb+oZy4jh87ZPIn0uDA8jAIQpxunNqpYFiCcKEpVeCSWJ8CPCqo1iV3MYXfnPEORycc
         0nTrtmp9CY/fZdUPsQa/LbZXeFF2WT2bQlXW+ZvJGqhkaj2nrpzJYBdabKUwvHhEvxRm
         m8bGhKioY/hxa0gPwF6nt287ld+unV5MyDXGUFGjFTDgCRahMUCcFvRmf/fLYyrpFOnI
         kuFL2ieEsNKM7kaenc880TaqNJVcjSt0fHn5AeQA3nRFcdgdj4oP5WQD1pTREXHR3Evn
         ck4A==
X-Forwarded-Encrypted: i=1; AJvYcCXCrcGcyxDGoLxXwWMRUH9sOWqwzUQrdRmyAdmE/jqWw/hG15QjGIboR/5Ff4aUGEp29T4w8S6AujFYjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqMsZ1mkEluWGnJY70qm2kXzwcgyDfwUquGGQyAD4qgpRN4lZ
	90prIeDp3tfOFNAkHjnFXgUcVlzPo5FkjL6BPQAkA2+72HhP1130EaohT6OlsKU=
X-Google-Smtp-Source: AGHT+IG8Fm82VABdYczpwnZazgSBY53cfYwx8usVNQ4UDHH85sJ8NsypfnBCHAXtWEf+TlIObLxeJw==
X-Received: by 2002:a05:6830:6183:b0:709:61c1:374c with SMTP id 46e09a7af769-70e0eb88668mr3202201a34.20.1724426256087;
        Fri, 23 Aug 2024 08:17:36 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39b1f114dsm5740597b3.74.2024.08.23.08.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:17:35 -0700 (PDT)
Date: Fri, 23 Aug 2024 11:17:34 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Li Zetao <lizetao1@huawei.com>,
	clm@fb.com, dsterba@suse.com, terrelln@fb.com,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 02/14] btrfs: convert get_next_extent_buffer() to take a
 folio
Message-ID: <20240823151734.GB2234629@perftesting>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-3-lizetao1@huawei.com>
 <Zsaq_QkyQIhGsvTj@casper.infradead.org>
 <0f643b0f-f1c2-48b7-99d5-809b8b7f0aac@gmx.com>
 <ZscqGAMm1tofHSSG@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZscqGAMm1tofHSSG@casper.infradead.org>

On Thu, Aug 22, 2024 at 01:07:52PM +0100, Matthew Wilcox wrote:
> On Thu, Aug 22, 2024 at 08:28:09PM +0930, Qu Wenruo wrote:
> > 在 2024/8/22 12:35, Matthew Wilcox 写道:
> > > > -	while (cur < page_start + PAGE_SIZE) {
> > > > +	while (cur < folio_start + PAGE_SIZE) {
> > > 
> > > Presumably we want to support large folios in btrfs at some point?
> > 
> > Yes, and we're already working towards that direction.
> > 
> > > I certainly want to remove CONFIG_READ_ONLY_THP_FOR_FS soon and that'll
> > > be a bit of a regression for btrfs if it doesn't have large folio
> > > support.  So shouldn't we also s/PAGE_SIZE/folio_size(folio)/ ?
> > 
> > AFAIK we're only going to support larger folios to support larger than
> > PAGE_SIZE sector size so far.
> 
> Why do you not want the performance gains from using larger folios?
> 
> > So every folio is still in a fixed size (sector size, >= PAGE_SIZE).
> > 
> > Not familiar with transparent huge page, I thought transparent huge page
> > is transparent to fs.
> > 
> > Or do we need some special handling?
> > My uneducated guess is, we will get a larger folio passed to readpage
> > call back directly?
> 
> Why do you choose to remain uneducated?  It's not like I've been keeping
> all of this to myself for the past five years.  I've given dozens of
> presentations on it, including plenary sessions at LSFMM.  As a filesystem
> developer, you must want to not know about it at this point.
> 

Or, a more charitable read, is that this particular developer has never been to
LSFMMBPF/Plumbers/anywhere you've given a talk.

This stuff is complicated, I don't even know what's going on half the time, much
less a developer who exclusively works on btrfs internals.

There's a lot of things to know in this space, we can't all know what's going on
in every corner.

As for the topic at hand, I'm moving us in the direction of an iomap conversion
so we can have the large folio support, regardless of the underlying
sectorsize/metadata block size.  Unfortunately there's a lot of fundamental
changes that need to be made to facilitate that, and those are going to take
some time to test and validate to make sure we didn't break anything.  In the
meantime we're going to be in this weird limbo states while I tackle the
individual problem areas.

My priorities are split between getting this to work and fuse improvements to
eventually no longer need to have file systems in the kernel to avoid all this
in general, so it's going to be spurty, but I hope to have this work done by the
next LSFMMBPF.  Thanks,

Josef

