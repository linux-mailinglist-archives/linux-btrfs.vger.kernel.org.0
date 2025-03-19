Return-Path: <linux-btrfs+bounces-12423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E750A68D15
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 13:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D30B421F8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FA82561AD;
	Wed, 19 Mar 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO4lQ9ev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E291207DE2;
	Wed, 19 Mar 2025 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388061; cv=none; b=mngo+lqw0ajvGBd3RvSbT5uU6sVCxjmDoUP7dyH3+YYn+yBvwTbeim1wT4iYvGBTY/HH37h7Hr7qY+pR55E8VK5argrCMcFOxKOb15/sYVqWI3/9eWT7IO1qRpjORqNc3jUbWDuNHb10UOntXL4kzJ35orRYg8PHXqju3IxYJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388061; c=relaxed/simple;
	bh=BJ+LAqacq0lj2gjo5UgSE+v50Jpt2bPxz8VVea61Gj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFa1cjGrnk7+7SxQr1km9wbTSmh2Y7/DzNdiWCHCs96Cg6tRlg+F3Ee/J8zc02or8ZFft9c92bpe/NXVd43/Rnt8V1lj+aKBtd/T27rvPZlM+8eY/LrYMG5AVtPDom8iuMLAuIojwwsbu66PGwevNXdxgamGCMQ+DHr88PcP8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO4lQ9ev; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913d45a148so5872856f8f.3;
        Wed, 19 Mar 2025 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742388058; x=1742992858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqSeUs7iKjP/0tFnJCwD06pNCVAaFLRRLlOZbtXmJJ0=;
        b=SO4lQ9evNWWGpjtPPuvcAUTch24MdKMx99evgycZQq4+UwW1E7MEJV8TQPsA+OI7DJ
         8gTgJI9aR9bixPXbCHMUuhDygSqArZUUSkXPxVHLLOMOEjhN6KLs4aV9zKwRn1n8Thwc
         bho86exxsWIfBu9g0RWuTrBVWL7XWYMydKzDaV1feG/hGbFmahHWCqmHuRJik6EKAf6j
         gaZRvjLvK4Z7ZVg+0RizzW68DQPfJr6pUOjYJeU+St159jCBDDncZ42iHS8G/oVjTNh8
         +579jE85DSLsS1J8el8LWTvMy4d+OuYv17rcTi55ViGNgYmSf8ATaQSqM8m3cBHg6NqU
         G9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742388058; x=1742992858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqSeUs7iKjP/0tFnJCwD06pNCVAaFLRRLlOZbtXmJJ0=;
        b=nlbG7eDPin3ZDfazpWqvc/8F3wAvfUYZdXGxzRA1JatWW8QVuk4j4ihqAK68sHB02z
         E8sPDL5BF++hse8+KJxsKz51F2LPXa71VV0OIbp+NU5prr1xCUdlV8V8rzxVeYPlDBgH
         ZI8WpVyH4Of77GsXyyu62hgA0EQn1warubgIokITibD4if49SRQIopzg0YT9b9dNIVgi
         +9ItB4PT9aR+3SMhogoiK5oLpU1xR3MMdfi2Pnd72JOGetOUHhS36ARnU25sCyU0Izhz
         /G4RDwSMDYVyivvzgFnxUfyfXwFEHOpa9CMqU8IVKU0ExiVUobJemY3fvztr2kgxLecV
         KeBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5EybqtgaK894CI7OAS2dOFlipzyL7kShpAyxjLoBkB0ojz53iazuQNyYCxpT50BBPAZUWSJxN7KyEDA==@vger.kernel.org, AJvYcCXHdccCx89w6zGXFAE0+2PfwosMC1xYXQCVy/0re58N7nAfPgwM+Goo6794faCL7b80HSco5fn3H0uzdGxU@vger.kernel.org
X-Gm-Message-State: AOJu0YzM6TXNA2UUJldzOPnkROe43nBYG1UdKdn5Ghdf2KFD5QxTCLGW
	t+kj9bt7tDGXTdFLK+X585DsxKgOZacaMW0BzSULywdN9meKe0NV
X-Gm-Gg: ASbGncszrAhrfbB/cajWim3wAiw5w5AOAlSjzvHa2+PiKXUpvAlyhZeD+lxJFstx1eY
	JYvDL0SFbQ3z4IaQQs0cpxwWXba9QwrMgQAW9FJ8JlzVumBJ3n5gX4FVKrEqxMDeo4dWk4L+ar6
	VEJLxhCB0BuqmGzoyag1YYE1aoehmaIPOEwyKzdOZyMpFHZzqLfb0KfShAL70trp03SWCZkRQaM
	76lUogT45/W2mxiyklT2dbf6fSTY1t9IH2N9wIS+Y0nQ3PlYbj99p0kvq+ezQWC8pqtm1Ya/mhW
	j6tbX42NqwxNh9yx5oV4JfeSH/YKdhGV5AqvT9jaNn2T9P2qHIDvccmpjYCV6Pbcfpgp8qH2UfB
	UzavwcxA=
X-Google-Smtp-Source: AGHT+IHeD7pb6uzExOV47g3sJRNdjV+Wg94z+l+pQKJoYlf2ryhaTj0nXCPW73oSb1vQMdrjvSbAWA==
X-Received: by 2002:a05:6000:1a8e:b0:391:3d12:9afa with SMTP id ffacd0b85a97d-399739c18e6mr2670396f8f.21.1742388057483;
        Wed, 19 Mar 2025 05:40:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8e43244sm21371547f8f.60.2025.03.19.05.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:40:56 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:40:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: David Sterba <dsterba@suse.cz>
Cc: Arnd Bergmann <arnd@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Qu Wenruo
 <wqu@suse.com>, Arnd Bergmann <arnd@arndb.de>, Johannes Thumshirn
 <johannes.thumshirn@wdc.com>, Filipe Manana <fdmanana@suse.com>, Li Zetao
 <lizetao1@huawei.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] btrfs: fix signedness issue in min()
Message-ID: <20250319124055.6951aeca@pumpkin>
In-Reply-To: <20250317192638.GA32661@twin.jikos.cz>
References: <20250314155447.124842-1-arnd@kernel.org>
	<20250317141637.5ee242ad@pumpkin>
	<20250317192638.GA32661@twin.jikos.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 20:26:39 +0100
David Sterba <dsterba@suse.cz> wrote:

> On Mon, Mar 17, 2025 at 02:16:37PM +0000, David Laight wrote:
> > On Fri, 14 Mar 2025 16:54:41 +0100
> > Arnd Bergmann <arnd@kernel.org> wrote:
> >   
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > Comparing a u64 to an loff_t causes a warning in min()
> > > 
> > > fs/btrfs/extent_io.c: In function 'extent_write_locked_range':
> > > include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_588' declared with attribute error: min(folio_pos(folio) + folio_size(folio) - 1, end) signedness error
> > > fs/btrfs/extent_io.c:2472:27: note: in expansion of macro 'min'
> > >  2472 |                 cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
> > >       |                           ^~~
> > > 
> > > Use min_t() instead.  
> > 
> > It would be slightly better to use min_unsigned() since, regardless of the types
> > involved, it can't discard significant bits.
> > 
> > OTOH the real problem here is that both folio_pos() and folio_size() return signed types.  
> 
> folio_size() returns size_t:
> 
> static inline size_t folio_size(const struct folio *folio)
> {
> 	return PAGE_SIZE << folio_order(folio);
> }
> 
> Otherwise the min_t with force u64 is ok and lots of min() use (in
> btrfs) was converted to the typed variant in case the types don't match.

That is just broken.
min_t(u64, x, y) is just min((u64)x, (u64)y) and you wouldn't do the
same casts anywhere else unless you really had to.
So you really shouldn't use min_t() unless there is no other way around the problem.

Ok (u64) are unlikely to be a problem, but there are plenty of places where
(u8) get used and can (and actually has) discard significant bits and cause bugs.

	David



