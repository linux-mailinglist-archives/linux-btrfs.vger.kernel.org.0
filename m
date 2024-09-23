Return-Path: <linux-btrfs+bounces-8170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF2797EE00
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 17:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635842821AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E30019D086;
	Mon, 23 Sep 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="s/dNUkOP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC3197A8A
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104853; cv=none; b=UJJ/abUO3dtCQlEyHAHe1eWPVPc5uPoeji180pawy5z8wIva0swd0qqRyJpZVLaGFmFW7WvZjvtT2NkB7FSspNhbH8JTMakRqCpdGYlJTVlEji7ZafusysMeL+6ZiisqH6Ozww+FCVV4dbLc2j/7meNh8jdVcf/ZDNs9CoFcJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104853; c=relaxed/simple;
	bh=vKBpEr8O+D7ExVGut9veGE2mR2TIETvN9JQ4yQqPujs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkxXV1wMOBXzLNdPJA0Tp3Xo1ceGv5GLzzgyMequn8RuVwhSb64EsxYNieyf11h4cU6V2WHnl6vKJOg67uc3jCk4YheIYNnghT0nLYUXMGxJJmRVtbH7dSJy7eyjH0emk3StPiRIrj9CuuXqZOMDvAN/idGF+waQhkQeJYtP7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=s/dNUkOP; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ddd138e0d0so38807377b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727104850; x=1727709650; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=poRSdZdkWlG53VRrOh20DrpVgj0f/RBf0PQe7rcKx5A=;
        b=s/dNUkOPthTXCqWPuJkZkoJ8vA6Z3FRBsb2dhXwVJAH6RhJIAWwWX0U1I/y6xEUjAb
         E1pvZ0I+nUDL1dubsfeU6yJ82m25mMMkXD4BxIXugTQQhFizUYfaPbq5etezwk+OyeBd
         f13pdCNBU0VQtMUbm6ZulitYe68gwdnuK8TdkiRfBnN0FyFc75eCHCQcIwITIFLhzYHq
         J7O7Qt5JYecmlg/d9lM5GUAIyD7UGz/H3WunHPJo4hzHHKxh71rf1+/c8qx3/efjW0MK
         hI+GjNtsUhsshhH8q0XgefLnNZDiG7UorKcJvKrf56N9n5b4xYVM0/o2yX2jx90kqhNY
         9iBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727104850; x=1727709650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poRSdZdkWlG53VRrOh20DrpVgj0f/RBf0PQe7rcKx5A=;
        b=A4wCkX/Pbsz4bxP0hu3mz1aIX5NTovks/6i4YdFaOhjduFBCd3eMvR/81MwwH7BGGK
         0dJLeW5VuvIaFCRSzoIAz8tkP711qjQ3nij6v+YMXdV3mTM3SefU5mW8tRzvHHe7oxjB
         46a1M4BS2G2y2MLDzJS6oitaVTxgapY7vqE1wFhnl3YTW69LvMVHC/FT/I5de7xO4v/S
         RhsisNbB7xrPJoLz+oV9vmN0kLrIZn11nya810ze50VbLeotFuMxupYwAQBmr0Gbdoo7
         ybSMVMHo2hN6OZ3bzSzx0ZZPQPWW/I4SJ/wUX9GI75H2JmtLC6FDP/tZw0dcnNYNyW9z
         jnDg==
X-Forwarded-Encrypted: i=1; AJvYcCXGm3e3AHE41ML7b/dX1q60o+wIWxqTD5tL1X6TMCaBv8MdH+3NSAThBZeKEnQaccWuP7qkVd2oX2h7GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyla7Xq+u0KwGlDZgBKclK95gbNiBNuXpSkutSUoxSZu4DhTg6j
	ShFpAvqOIKOHiIDn5t+/3arAJg7aEx5ZTv6VhG5Vl5wh2zlYe/zOiM/Ij2bcr+c=
X-Google-Smtp-Source: AGHT+IFt15Tfa7Wq9qzctFgh8LC8TmY47SF5NHHCKmEXZy8J/U/RH98AYMytAVrK5ZyczDbliAyRZA==
X-Received: by 2002:a05:690c:25c2:b0:6dd:bbb4:bcc7 with SMTP id 00721157ae682-6dfeeffb0dcmr104927277b3.44.1727104850550;
        Mon, 23 Sep 2024 08:20:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe2ecffeesm34201287b3.79.2024.09.23.08.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:20:47 -0700 (PDT)
Date: Mon, 23 Sep 2024 11:20:46 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, Qu Wenruo <wqu@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: also add stripe entries for NOCOW writes
Message-ID: <20240923152046.GA159452@perftesting>
References: <20240923064549.14224-1-jth@kernel.org>
 <71088008-c105-4eb9-9199-882091eafe07@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71088008-c105-4eb9-9199-882091eafe07@gmx.com>

On Mon, Sep 23, 2024 at 04:58:34PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/9/23 16:15, Johannes Thumshirn 写道:
> > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > NOCOW writes do not generate stripe_extent entries in the RAID stripe
> > tree, as the RAID stripe-tree feature initially was designed with a
> > zoned filesystem in mind and on a zoned filesystem, we do not allow NOCOW
> > writes. But the RAID stripe-tree feature is independent from the zoned
> > feature, so we must also allow NOCOW writes for zoned filesystems.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Sorry I'm going to repeat myself again, I still believe if we insert an
> RST entry at falloc() time, it will be more consistent with the non-RST
> code.
> 
> Yes, I known preallocated space will not need any read nor search RST
> entry, and we just fill the page cache with zero at read time.
> 
> But the point of proper (not just dummy) RST entry for the whole
> preallocated space is, we do not need to touch the RST entry anymore for
> NOCOW/PREALLOCATED write at all.
> 
> This makes the RST NOCOW/PREALLOC writes behavior to align with the
> non-RST code, which doesn't update any extent item, but only modify the
> file extent for PREALLOC writes.

I see what you're getting at here, but it creates a huge amount of problems
later down the line.

I prealloc an extent, I map that logical extent to a physical extent and then I
insert a RST entry for that mapping.  Now I rip out one of my disks, and now I
have to update RST entries for extents I'm not going to rewrite because they're
prealloc.

RST is a logical->physical mapping.  We do not need to update or insert anything
until we create that logical->physical mapping.  Keeping the rules consistent
across the different layers will make it easier to reason about and easier to
maintain.  Adding an index at endio time for NOCOW makes sense, we now have
created a thing on disk that we need to have a mapping for.  The same goes for
prealloc, adding an entry at prealloc time doesn't make logical sense as we
haven't yet instantiated that space on disk.  Thanks,

Josef

