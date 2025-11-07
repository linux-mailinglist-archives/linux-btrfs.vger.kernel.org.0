Return-Path: <linux-btrfs+bounces-18796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD9C3FB53
	for <lists+linux-btrfs@lfdr.de>; Fri, 07 Nov 2025 12:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9003AAFC2
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Nov 2025 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B3E320CD5;
	Fri,  7 Nov 2025 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ajvI27Ie"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CFA320A1F
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514508; cv=none; b=KxruKgPF25mSG+BHRVoE5jOoJ0MSbwQc1NOjEr6SYv2f22Sr6f0k9CtgqzV14iYfKkyOJrPccEBk9A5QZETXBIavQV8WeeEcZr4K/cyOiX07jWlBrwhU1NjM1CAXFTzInSRtT6hQxJmsSt5baXbBkyf/8qxaDhMu7ZqaG0e1X3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514508; c=relaxed/simple;
	bh=Nut/8u41rWJMGfGJjVtFCTIkrnksUP+ilg/nzhhn7VI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojI7WE8RvnTcdFNOkIy/RxrYXAaF5Id7hiGr+3jALGqrWIla5KOtz84dHxPJH2Rk7iTScWJzlOx0lFECeiTVdYvih+8wn4buTXnXHf9P+rDCEjPoGR1RGoBbIHbYwxJabv3S89vV4g8aoVvPa4hFBmLMYYKLEcRu2DHTEVk05VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ajvI27Ie; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47758595eecso3046735e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Nov 2025 03:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762514504; x=1763119304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nut/8u41rWJMGfGJjVtFCTIkrnksUP+ilg/nzhhn7VI=;
        b=ajvI27Ie+xYvoFVvxz9B26tBVmaZm1sjBgBUb2r4j67djfwyWHXX3EcEjAsS8m6GF+
         nwS+s8s8ntB/Lgu98e1PSXoo4RHzlnKZjsU0Up97QIH2ZiR21Jfeqt0CUR5LcWmFtx+3
         GTP46smwlnHlDzOSQVg3heX4F6diPJhszzoOQe1VknT6CBV2HO2GmBBKG0pjB2Gdm8Wi
         1hefi9J8xj0fzdFKcgtIGwEecojQtrxIjMClgM62n/t5pDiLO6uXGRZFzA818a3mg2Hc
         LayZkHNPCAHYfkJjM7aDExI0jcPtP2D41RkuPU362Wq+qVb+jmboY2/KlNX4eTgvAf04
         loRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514504; x=1763119304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nut/8u41rWJMGfGJjVtFCTIkrnksUP+ilg/nzhhn7VI=;
        b=ccKQaQGsyzA5W8XwmmAh7ZfyqMOYGCP7oD6+PcvgDHGV/fvuthb8MA/Jeewk1xAszD
         spPv5uF81QTeKtmyW1sf7xaGBaeMZGUTbrM9Jn1L1v5dEgEbVWeoqumyvCa3HClnDU9w
         +aGe+yvYu9Axr7St5A22pLFIkaXb2hUoQsx/MafUwhW06z6Ywy5AbRiqQP72He9saCKG
         Wml41ILf36XTExilRBvQE1EgoAkRE4um1YUQ/XjYcYW7XfKQQbIUJ7Qb9DsjwpqTUNL9
         AYrmvCY97sNS6fAdbb2cZQnDiDrwt9xxSoGhh+HGn+EIq0pSyOu6UUwvlRzOr/UykHwf
         6RCg==
X-Forwarded-Encrypted: i=1; AJvYcCVBEWRPsoYlu7ml4yIzU6olE+e4z1gWnSjBijn4GeMx7Rn1C6xtwoYYJ/yb68yzoA2ciMiQhmT6nIc0Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwrSYnGjoJmjt+8flbDKYUHdZFrve6D4io2zYme0Cr99PXeYQ+
	VZ01yNjZJAVpmlib4RPvyftrY64/GtjVIlcjdnQgj8Sje1ftOBY6hNgr3rklSm0EYsLBkn11GI4
	YoUrZ6vGTcoraN5VB5YhvEk2qI4w4/7lZRQW9Zqrrxg==
X-Gm-Gg: ASbGnctc/+G+V/4gbQ3FwEGxXuvzLg05j/5Ty72XbUeacgecjAEOblQBZaBn935KrkY
	wBDGNaDUyZP0nhvOPpEqnhAyJ4+gkk6QSV+RhU40Ii9K78OslGHUJIt7jaY2dYVkm+K1vxCNr9A
	AWkv2y2WQwdi8BNHmJ8/lqcGS8cXAliWhzBB+CY7iVM3mURoHCH88ET5gK4b1LJWY5NnqmMQyhd
	62/J/f3E3bSPiC05VnWOB9HMy24nhgfAB6t6q5haEPwNkcjNuV8uihY7hRkmiqZvbm0G3mKRiXB
	iBeHlL+rxgIyGp4RRYWcVzDnqy4wG1xCUA6mF+XlZLS0A1lRfGkiHYODFA==
X-Google-Smtp-Source: AGHT+IGZThT1DCgxzCjULd/gFhrHhe6ZbEa2WyrOCWaRvs0GyHZGB1AD3GbVRasQb9sJmg+qZRV7oWcDZ9Eau82BFwQ=
X-Received: by 2002:a05:600c:c490:b0:477:4345:7c5c with SMTP id
 5b1f17b1804b1-4776bcdb5d7mr18966155e9.38.1762514504217; Fri, 07 Nov 2025
 03:21:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <58baf1fc6d077aacc5db3b2bf42677fc3fbbb6a8.1762503411.git.wqu@suse.com>
 <20251107103804.GX13846@twin.jikos.cz>
In-Reply-To: <20251107103804.GX13846@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 7 Nov 2025 12:21:32 +0100
X-Gm-Features: AWmQ_bmH2KwG63P_skZec-tY6OLOicRI23lSOyZqHMmQsPogFfXffvBpivbazw8
Message-ID: <CAPjX3Fc17vpMoy3A+KysCC+D0H-dJBHu+vmnnEnHEng4JHNqfQ@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: use guard for btrfs_folio_state::lock
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 at 11:41, David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Nov 07, 2025 at 06:47:03PM +1030, Qu Wenruo wrote:
> > Most call sites are fine for a simple guard(), some call sites need
> > scoped_guard().
> >
> > For the scoped_guard() usage, it increase one indent for the code,
> > personally speaking I like the extra indent to make the critical section
> > more obvious, but I also understand not all call site can afford the
> > extra indent.
> >
> > Thankfully for subpage cases, it's completely fine.
> >
> > Overall this makes code much shorter, and we can return without
> > bothering manually unlocking, saving several temporary variables.
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> > Reason for RFC:
> > We're still not yet determined if we should brace the new auto-cleanup
> > scheme.
> >
> > Now I'm completely on the boat of the scoped based auto-cleanup, even
> > for the subpage code where the lock is already super straightforward.
> > For more complex cases the benefit will be more obvious.
> >
> > So far the only disadvantage is my old mindset, but I believe time will
> > get it fixed.
>
> I still don't like the guarded locks but maybe I can get used to it as
> well. I don't think it' s mindset but rather years of pattern
> recognition and learned quick code skimming that will be hurt, this can
> get fixed by practice.
>
> In your patch serving as an example I see potential problem with the use
> of the pattern "guard() until the end of the function". Adding more code
> after the guard will automatically add it to the locked section, with
> explicit unlock it would be clear where's the boundary.
>
> The scoped_lock() is closer to that pattern. What could happen is
> switching from guard to scoped guard once code needs to be appended
> outside of the locked section. This brings the unnecessary indentation
> and future merge conflicts.

Or eventually refactoring into helper. But yeah, it is different to
what we're all used to for years.

