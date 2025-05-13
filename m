Return-Path: <linux-btrfs+bounces-13957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5107AB4D48
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 09:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548CA1B42B2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A021F1317;
	Tue, 13 May 2025 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VDTVRmJG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09441F2BA4
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122469; cv=none; b=rN37rTcRiHp1Vx2io0hPZO3nY5yweXLT55XiOmecelIJ5hqiYzds3nAXJGQH5iJsF2EKnTe4pjfId7GWlUpjJS/GOq+QNTctpyUp2eD0Zn1VV2f4PgDEc7J/UUNYyZ5BdTw5rzNM9hBymllbLMW0wxQWbjG3YDeayzhsdCqgQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122469; c=relaxed/simple;
	bh=lyRfNDhswOi4Yx7bXFxE7jpPtXhTwqpYmInsHsmesps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJSD1xUIQxTQ6Md2Qf0TDrsHKcSRvgD1T2SydeRiIBFS4QYqkMn6B16x9JEhwsGUL4XQfVxyVHD4vYdQb7TbywfdxKAcD0ZjRvkPs7hIH4j985I9dGPy8OfKMcIgJ04U4VNukySHs4PuhbBe0iiUJnknbt+Me9djq2W9Cz6zCqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VDTVRmJG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fbee929e56so10015515a12.0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 00:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747122465; x=1747727265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ReY23kqyYqDXwSGM+/O64zyxDeM/BGz27G0SRXM3ZKc=;
        b=VDTVRmJGyOItyrnpZ4vj7V1d5zOAXPP4pal07+kMxkhvDnZ6SqmkSGhwzXlQEUCKuy
         TbIh6pPI209M++IXX0pHIXIIax6MrMZY6gkHa2pyYxZd1BUqf2X0PRvj9mZJp7cqBpW+
         C31ZIAESGcL8DUG+PsTIHKk75kP135iW5EA10NIy14R+AMR7HSlD5bDdfM0FBoO6CIvD
         23cWz9RmxuOAGFmuLIYPi+i6oO9kV34JI4toaQIPeD4x3R27iCvXE0OJcBGW4Z5nMwIt
         GGtcQYbnBiZXyLjy1SVt+iPJzOT2ILrCNvw8UU4tHhUNwfB0Z8PaNRt8YkE9vrXJfYc9
         UtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747122465; x=1747727265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReY23kqyYqDXwSGM+/O64zyxDeM/BGz27G0SRXM3ZKc=;
        b=Y/lcohldQOERTqfiUPLEQ/sH1+kPVQh3Bmej+f5owRKszkT0dNzc5NY8ah1FyFffz2
         zChgKL2wJchan97BgdtOc1ABoIwjpRLMVadkKdNxAbq4S70ccS+VgfP39OmtKj8nZc9t
         +QuNUQvwm/gLkRdPAHUqE10vcfAga/5d0abmJHtUElt166ryPWOWI+wXJB02Ag0T+vqB
         DHM3/VDBWtEnDGaW6z0Xwm+A6J3I4QaqV/lXOu6hEZzZjxqc5D6a1rs5849rwWAh3oe/
         s7iC5u0zdm82Qtt4N7p0T1xGGfR8rHTkVtRuvKtknemR3QkuLycxD+QTRQK2US65vZLC
         /siw==
X-Forwarded-Encrypted: i=1; AJvYcCUQbJN1hWaai/AxflCU+3Q2Mn8f0bxyH9REegIweiQd6+Kzy2uh7DlnKSzZ0jKz9HYRD+48My8F/hunJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwgiDEzKGtCyFjy3xLlGMRLSQpcUvfVVLQj3I/ALcxo3LoJwBn
	VHGQt8AZekDUbqTudtXwSE3zWKuqNcJCdAcVHLPcy8oSqh+mtOMJcfOH+orgp77jTs4M1wirO6+
	vTjjQGjdNkd6dVDSHI5y0Rsq1Y887ZrJC/P6pVA==
X-Gm-Gg: ASbGncsfdChPbljHW3yFrgBV9FScyK6yEDp8rD3EDP9j5RjfKLsFrBu1gSmvgBRROxm
	Abg07NxE3tWBZGDD6t67C3UDsUXFh34C6j1kL1GgjjRo/Gr5XCUSS05Nz4fXlmbSg6eKjMFtiL7
	a5152BtqyvtTSmWLazG6bWLIUei1/KwOE=
X-Google-Smtp-Source: AGHT+IE/HrH0/ELzuZXB8G7FdZ+Qc3VaT/6N6hID2bt4HYJYdNzD45xEgZopbRzLXl5zPQ2mkAuhFDC/718kCU3w5Mw=
X-Received: by 2002:a17:907:9445:b0:ad2:4fb7:6cd7 with SMTP id
 a640c23a62f3a-ad24fb76ef4mr840152666b.2.1747122465138; Tue, 13 May 2025
 00:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
 <20250512145939.GL9140@twin.jikos.cz> <CAPjX3Ff+XrWHJq_cBPUaK5memR3eMh-xpCeR7rk3uOa3yPE8Mg@mail.gmail.com>
 <20250512155256.GM9140@twin.jikos.cz> <20250512160909.GN9140@twin.jikos.cz>
 <CAPjX3Fdzs3K739Tpu4JGJO8MCjStp_ndNAjKjBq1weOH2Jcq1w@mail.gmail.com> <20250512203525.GY9140@twin.jikos.cz>
In-Reply-To: <20250512203525.GY9140@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 13 May 2025 09:47:34 +0200
X-Gm-Features: AX0GCFvEJk143_GFcFbqP2ZdfFjmux0ZXvlk2oOLgLFIaj1Tq2v6rgpdOAArI0w
Message-ID: <CAPjX3Fco9qHTb2y1FUwHkKgNJHdabZw2FQEK7Pj6rYg0C+uRvw@mail.gmail.com>
Subject: Re: [PATCH v5] btrfs: fix broken drop_caches on extent buffer folios
To: dsterba@suse.cz
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	fdmanana@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 22:35, David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, May 12, 2025 at 07:14:04PM +0200, Daniel Vacek wrote:
> > > Also this makes num_extent_folios() a bit dangerous when the eb->folios
> > > change in the loop, not what I expected when the __pure attribute was
> > > added. In case this introdues more subtle bugs we'll probably have to
> > > revert it.
> >
> > Yeah, the stack savings actually show the compiler does not cache the
> > value implicitly on it's own and rather it's being re-fetched from the
> > eb object each time.
> >
> > If I understand correctly, you may have rather wanted the const
> > function attribute and not the pure one. That could possibly work,
> > though I'm not sure how portable that is [1].
> > Pure means it has no side-effects, ie. it does not modify any memory
> > like global variables or the object given by a pointer argument (in a
> > sense the arg is struct foo const*).
> > It is described similarly to const attribute but: "However, the caller
> > may safely change the contents of the array between successive calls
> > to the function (doing so disables the optimization)." [2]
> > So any changes to the eb in the loop block effectively cancel the pure
> > effect. Which is what we see here.
>
> The __const would work and would be safe wrt changes to the eb->folios,
> but as said it also disables the optimization, effectively calling the
> function each time (and folio_order()).
>
> An idea:
>
>   for (int i = 0, max = num_extent_folios(); i < max; i++)

I guess the local variable was chosen as it's used twice in the function.

https://lore.kernel.org/linux-btrfs/CAPjX3FdHRgRU4u+n2=JsEWz-yDghJ6xVjoFQtLPgNupVgE0etA@mail.gmail.com/

> instead of the local variable. This still relies on valid eb->folios[0]
> in case there are mixed NULL and valid pointers but I guess this is
> either rare or completely wrong (in which case this could be verified by
> assertion).

I don't think there was a single example of mixed NULL and pointers.
At least not with eb->folios[0] being NULL, otherwise we would be
getting NULL deref crashes at that point before
https://lore.kernel.org/linux-btrfs/a17705cfccb9cb49d48c393fd0f46bdb4281b556.1745618308.git.boris@bur.io/
which is quite recent and I'm not sure it was needed. I'd say it can
result in quite some hidden bugs in this area. And since it was not
really needed before I'd drop this patch.

I understand that if the folios array is mixed, it's always with NULLs
at the end and valid pointers at the beginning. Eventually we could
loop backwards when cleaning up, but caching the loop count first also
works. So not a big deal in my opinion.

