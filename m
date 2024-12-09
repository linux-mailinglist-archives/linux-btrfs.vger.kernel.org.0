Return-Path: <linux-btrfs+bounces-10166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F134E9E980B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 15:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4579628264F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76951A2390;
	Mon,  9 Dec 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zi1x6O2t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EC233123
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752878; cv=none; b=BSQv0Dn4T+6+tlu5EtNU+CgvO07KzHrfkghTxUCZsWZyv/r7ct287RTuNlovf/Z3BUML92voqdtfwf8FoKcEHVZJRy5T9b2F90Pv+Qtu4/2rUPrEzj8N91xGCCLkdH+1tyRp9L4ccM1q+A8crMeViim3W6nKOF/dk1eB5qxer/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752878; c=relaxed/simple;
	bh=Rt7SNqpSK5otYMO3g62WW/m1LrKTk8lFvF120At1Aas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw2rF3IGUGj2SFuhOx4/V1u7CiutQMURI4xAuaQylNnbkRkWt/4a3yb7bs6eNqh80GrrEB/wtgZk+q2K1JRIvjtpVtyqbJ0JGyfVCmjSWTPikyYgJxx4bDmHvbQXQPfCHp38xENgZJP/ZQtFzJ8EPAE5Fc3yy6DDvH1sTK4bL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zi1x6O2t; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b678da9310so376374085a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2024 06:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1733752876; x=1734357676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=06ZzJA9bBbWnf4miy+mGRtIB0p5Xg60KTQy1nH8a1gU=;
        b=zi1x6O2t4pXff4BpqPY2hxV/1HPcsyuEKHK3AWX98YudNH6eF1aI5VA3LQLPoX54C8
         EY5+CJbk7Voff2jFELg8N9zUGbiaTAFAkpCbsRTvzaS80jJfHroFck3tEq5EEtsO+Gon
         F8x9MwpkRXokwBbhWfn+y7EMXCU5zn6yUZU4MtNlpjgqDAUcKQVmKTn+4KyP8vQmuMy6
         TORWicC5ers4UHgblFI9H4FP/F3jDwr39nrhWDODrxxRq76KHjZYpwNqF8J97tOXKHZg
         dstsMMtNNzzCFtGs8clpZ4kUFwcfq9AvZWfIhzRILhf7zAispp15vAvdCJeCqFzcI7Ov
         8YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752876; x=1734357676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06ZzJA9bBbWnf4miy+mGRtIB0p5Xg60KTQy1nH8a1gU=;
        b=IoI2CDYz0GRqouTpuq9Cftt/KByZNrD6jw1b9lXgJvMS1b7UmRSgJqpABOC4hZAVth
         Azew/nzSu9Y95H3FBjsQ7qSC8dsZTgIQZfVEbrUcPsDatgNXxIKwk3oquHR2jPD3TVI9
         vHFvcJ6+Kov7X75mp3UcCzmeXJ5eSDUc28wpUQaYfptmPlGHNVd6RzBWGqtFp0dbZVof
         Ay30/B2SREqxgAMWVunlIBiuqpYlyUE0oFYZ3MoZZophjGPwpEe7RLVBiQJEoMDhHK2n
         IP5h3LDDtrt3ePh/e1O9aUzPMtaMStOiZe7ps0FG8Bs9lRJtMtQi+vsqMxoK+PxWWlD+
         I9DA==
X-Gm-Message-State: AOJu0Yw56kSeQ+Tv/NPSjZ5usnLCbaDIsNvSE6ZXGsa1uECFelB7wkZc
	LWWDotZaX5Wql8T2lnZJQk2LO+Ju/l9ZvuthzCrTeLPNlWM1htU1XKzbajTKXg0=
X-Gm-Gg: ASbGnctjvJZ3CpELjV0Wesc7J6RY2TnerOX4KZVQoPAwZyGVkOWFZwQRw3nBxZsn5Tb
	ooEUje9EFf/KHmMTC9Sab6z6FLcfTawKZC1hLvCt/aqCtHxZDldq3Jg1augBdW604SEhF55dQWy
	f7r3V+uf3oOsKKiqgKnHC2f1OeTFCaFV5tOstui3wrEVCWMtQ7WK7yJwNYwpygY4SsI6IF3h5qn
	a/Vses/K6XffkR/6cVU9lGB+7i/p6hFxYp5qJmyPw9pmEh+MMsufPD3uwmE6jrksnW+1LUxr66o
	FPxAjLqCL7g=
X-Google-Smtp-Source: AGHT+IEj4ZbBm6KZ9Pau8M9aBu9JrSFZIfh3c/694dBzU8IZlz/mjt5coz2ZClDPxqneeaEsGMDObA==
X-Received: by 2002:a05:620a:468a:b0:7b1:45be:2e87 with SMTP id af79cd13be357-7b6dce17f9emr64591685a.18.1733752875829;
        Mon, 09 Dec 2024 06:01:15 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6c3a04e31sm266801785a.128.2024.12.09.06.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:01:15 -0800 (PST)
Date: Mon, 9 Dec 2024 09:01:14 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/10] btrfs: backref cache cleanups
Message-ID: <20241209140114.GB2840216@perftesting>
References: <cover.1727970062.git.josef@toxicpanda.com>
 <20241206193854.GL31418@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206193854.GL31418@twin.jikos.cz>

On Fri, Dec 06, 2024 at 08:38:54PM +0100, David Sterba wrote:
> On Thu, Oct 03, 2024 at 11:43:02AM -0400, Josef Bacik wrote:
> > Hello,
> > 
> > This is the followup to the relocation fix that I sent out earlier.  This series
> > cleans up a lot of the complicated things that exist in backref cache because we
> > were keeping track of changes to the file system during relocation.  Now that we
> > do not do this we can simplify a lot of the code and make it easier to
> > understand.  I've tested this with the horror show of a relocation test I was
> > using to trigger the original problem.  I'm running fstests now via the CI, but
> > this seems solid.  Hopefully this makes the relocation code a bit easier to
> > understand.  Thanks,
> > 
> > Josef
> > 
> > Josef Bacik (10):
> >   btrfs: convert BUG_ON in btrfs_reloc_cow_block to proper error
> >     handling
> >   btrfs: remove the changed list for backref cache
> >   btrfs: add a comment for new_bytenr in bacref_cache_node
> >   btrfs: cleanup select_reloc_root
> >   btrfs: remove clone_backref_node
> >   btrfs: don't build backref tree for cowonly blocks
> >   btrfs: do not handle non-shareable roots in backref cache
> >   btrfs: simplify btrfs_backref_release_cache
> >   btrfs: remove the ->lowest and ->leaves members from backref cache
> >   btrfs: remove detached list from btrfs_backref_cache
> 
> The patches have been in misc-next as I've been expecting an update. We
> want the cleanups so I've applied the series to for-next. I've removed
> th ASSERT(0) callls, we need proper macros/functions in case you really
> want to see something fail during development. As the errors are EUCLEAN
> they'll bubble up eventually with some noisy message so I hope we're not
> losing much.

Sorry Dave, I let this one fall through the cracks, thanks for picking it up for
me.

As for replacing ASSERT(0) I agree this is a blunt tool.  Maybe we could have a
macro that we put around EUCLEAN, at least in these cases where it also
indicates we might have broken something?  Something like

#ifdef CONFIG_BTRFS_DEBUG
#define BTRRFS_EUCLEAN ({ WARN_ON(1); -EUCLEAN; })
#else
#define BTRFS_EUCLEAN -EUCLEAN
#endif

And then we can just use BTRFS_EUCLEAN to replace the ASSERT(0) calls.  Thanks,

Josef

