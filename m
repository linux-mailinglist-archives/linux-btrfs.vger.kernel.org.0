Return-Path: <linux-btrfs+bounces-6963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A70494614E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 18:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0D71C220D2
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1413C914;
	Fri,  2 Aug 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="qR2NEQkg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3C273F9
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614435; cv=none; b=aUi0Erl5Zsr8w45ht0lrGvXR2iohYnwsOBqt/kcTR4MB8YADPNp9paL0/A4A2bkdB8lS8kIzTyWNxKMHaEwcPC2FomVxOykWZnb5X/mQEmFuCvmPIRBL6UOoGOzrM+F8CosRG4nm95Fnc+QIfmRNA40E4+eO+CmRuSEzA3i8mzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614435; c=relaxed/simple;
	bh=QRT4sxJi85jC2jTrXLEfh8EPr4XLtviWKdrgQtkLf58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rECzkcwB8beR0m36U1IBxCCkp33sHWH+rG+o7uTKSUw7n4U3EOFKxmfPQDi0HT9KDMA1JzSB/kUeBpRy/kUrwn+ZzjP0NQpaV/79fHBGLS06fG21bv11dHQRhMMcFa3ZmtWbQMQV5hsIAqQzzWG1UI8W2C1l6lZ275LbfKpmmpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=qR2NEQkg; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso6561079276.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2024 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722614433; x=1723219233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wyrl3nnrRvdjgbloB58BFDN8lJiQMSFcy90VdwUvTqQ=;
        b=qR2NEQkgeDPZ7iuU3WWmHvz/kbuK9zPIsUNsJjFH/uO5fSs6umkuRIeTEDkvfP5xgM
         jrwyDxXngwyc7v8RvS7NbR8r+Zh9gwgDCkoOY2ezzF4dvQ746vHNV9Yb4/s5BWHq+edR
         XZJ3XxG8ZEBMrlpzYj7njzBJ7gl3+oj990l/0rRFoGI845An6+rcKart3mbARh6d1hwI
         2QDWU8rYPszaV391E1tafoGTxdMH15hdAqFtN3FlRD0XQqJHv9jG69sAPoJIlA02vdoM
         ehCgYs7qVb5CsWHDn41T6Y3gZ6GyIMzyDeTrGb/9uBhTj239tKxyzI0TypcetPEyq2Oe
         pgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722614433; x=1723219233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wyrl3nnrRvdjgbloB58BFDN8lJiQMSFcy90VdwUvTqQ=;
        b=BPw/+epfShMsGqQZqyCwoIaTcZ1+Jq10DikGR+1vNVmHQjBpMzE6iaycotPpQYP1mf
         9fZHcWHxd9/fgpTqfJm6PIwss5A/72BxDg5c9Of+BdzhXjiXXgOkf2AxLOAk/sdgc2lB
         tlrLu+h5OuQBwsbprLd8jmFooAbHQtnYTkCUOoEwhNypVDVoIYVeRr1cA9uCs/54v4F0
         FZCu+egi8aeDLKk8A8YCua7qDm7pimKhrmxVBoPP7AJaBngtGSK9acfcB9M3GZKmUX3g
         QijDSADiw3fGQ4ACv2ox6vySZsU0GmvxBiaWeQAfjkfTM3E1GxsyDMErhS7jU1fOQxub
         4Wug==
X-Gm-Message-State: AOJu0YyJthR+3KaLDgzvvsHR+cHp5tRGYx15acl3RKL8cWzSRmXek83j
	MjJqe0HGlP+kzWQWUwFQT9ThnnCsPRTj5t8kX4d0Mz+ve30UTRu1Nl15ArAaxPg=
X-Google-Smtp-Source: AGHT+IEczCYKp7cWnXQrlE4HrfiHF5PcvRGyn2oWDKoBv9fxIq70ZqLewtoBPi7lx03SUV255uf9xA==
X-Received: by 2002:a05:6902:1249:b0:e0b:e47d:ccdc with SMTP id 3f1490d57ef6-e0be47dcf22mr3276843276.44.1722614432478;
        Fri, 02 Aug 2024 09:00:32 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be53044bbsm246101276.4.2024.08.02.09.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:00:32 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:00:31 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v9] btrfs: prefer to allocate larger folio for metadata
Message-ID: <20240802160031.GC6306@perftesting>
References: <ef421f88bfa5cf4fd1d4293a8f27cfc97d5d10e4.1722557590.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef421f88bfa5cf4fd1d4293a8f27cfc97d5d10e4.1722557590.git.wqu@suse.com>

On Fri, Aug 02, 2024 at 09:48:00AM +0930, Qu Wenruo wrote:
> Since btrfs metadata is always in fixed size (nodesize, determined at
> mkfs time, default to 16K), and btrfs has the full control of the folios
> (read is triggered internally, no read/readahead call backs), it's the
> best location to experimental larger folios inside btrfs.
> 
> To enable larger folios, the btrfs has to meet the following conditions:
> 
> - The extent buffer start is aligned to nodesize
>   This should be the common case for any btrfs in the last 5 years.
> 
> - The nodesize is larger than page size
> 
> - MM layer can fulfill our larger folio allocation
>   The larger folio will cover exactly the metadata size (nodesize).
> 
> If any of the condition is not met, we just fall back to page sized
> folio and go as usual.
> This means, we can have mixed orders for btrfs metadata.
> 
> Thus there are several new corner cases with the mixed orders:
> 
> 1) New filemap_add_folio() -EEXIST failure cases
>    For mixed order cases, filemap_add_folio() can return -EEXIST
>    meanwhile filemap_lock_folio() returns -ENOENT.
>    In this case where are 2 possible reasons:
>    * The folio get reclaimed between add and lock
>    * The larger folio conflicts with smaller ones in the range
> 
>    We have no way to distinguish them, so for larger folio case we
>    fall back to order 0 and retry, as that will rule out folio conflict
>    case.
> 
> 2) Existing folio size may be different than the one we allocated
>    This is after the existing eb checks.
> 
> 2.1) The existing folio is larger than the allocated one
>      Need to free all allocated folios, and use the existing larger
>      folio instead.
> 
> 2.2) The existing folio has the same size
>      Free the allocated one and reuse the page cache.
>      This is the existing path.
> 
> 2.3) The existing folio is smaller than the allocated one
>      Fall back to re-allocate order 0 folios instead.
> 
> Otherwise all the needed infrastructure is already here, we only need to
> try allocate larger folio as our first try in alloc_eb_folio_array().
> 
> For now, the higher order allocation is only a preferable attempt for
> debug build, before we had enough test coverage and push it to end
> users.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I think this is as close as we're going to get without testing it and finding
the sharp edges, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

