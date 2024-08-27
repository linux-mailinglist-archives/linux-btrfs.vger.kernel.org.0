Return-Path: <linux-btrfs+bounces-7552-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1121E960801
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 12:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2688283927
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53C619EED2;
	Tue, 27 Aug 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Q1gpPMLU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C12419E7D1
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756238; cv=none; b=Ko3S2meEs3SyZy3GZtuJkc61c8+BtzYrl2ZIRIewLUcjPBW0cruBS5/OPqI9PtL7/hA1hJe7HhN2UNe+q7GHwTFTUzsKwKOJcbzAbtrTNZKduJglF6zZPafl5TR7OIauFLeWk8Z6dUdRVvHkAl4qBybb+ZM3ca3O8/suJNtnLDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756238; c=relaxed/simple;
	bh=3bNKGwd9RWnHMlL/1JYZGOPc+GaINToWNWCXsBlaLtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1j66204ELOxgPpBYmNsMKprxfW29eollOXZHgKPMRg+a2rUuJkDlQIkiz9vAovOxtFISA2DQBYr4dffk1gGUt+fIeWuSxTkSBSouY2vDyf8RD13MkjF2T6j+bby+ik47Jj863fG1NK2NEFCo+P3ZKLjccJGZmWagXgnI+ofC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Q1gpPMLU; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-498d587c13bso1682589137.2
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 03:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724756236; x=1725361036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Llg302vaxfDfa27wca+FxzomcfXfjXgT3ROnw+p4h4=;
        b=Q1gpPMLU5AtzlTDN4l0jHf9bfTmZ7TH+jhv5v3c8ZA9opoJyn7eFtqLHqbszKN8ngd
         q+mBMajip2xBYOZq89dyEPHBVYb7ukZma+x6CapQkMC9oPy2y+P/bBQ4I+3AqBmKw1yD
         ChH5APuX9goszVWxsP2jq24a88s/rfn5e6RYxv7/3RxxkRuPtUboZDMqHYdaVaDtogrb
         wfOim5UGYqY8GU7cKQ1uvytgvOiqv76N9eY573yjFDPldti4cckuRmTS1LGCbP6zZlAw
         dIc0F2juom+cZGTLEgpe4EvuhbRgjzamUmxMuRY655mzv4D3IpO112CiIxtwsvBYVZZB
         /usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724756236; x=1725361036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Llg302vaxfDfa27wca+FxzomcfXfjXgT3ROnw+p4h4=;
        b=akrmazG1uNR3AH6eYhnkbkVRE62xa6EEjogRAfh6QRktWAregGj+JlL/cAeri9UF8t
         i79cuO3P36Rwn1oNVOWDWf0zbcy4wBB3/RedSmPLmsEXyUYhUaYrZBNa38wTvTDwoVDU
         TePC9d5bMlmY6QcogoZrKGaJXikh0U6AcVPj5W6fn8A2oKQwgUbF5T1vtbV1HlvFg/LQ
         EbhUztIkw9H/2e44YoI5UIAdAqZD/N2cS49QZ83kvDHP1VQHXJRRd12vf9yO6XRbFMl/
         don6jajplpo1GFg2cdiNUj7GXd7VOzRdKLl46fmW3XzK2Rm+a0Y7F0AnpgBjkwyCE5ML
         ZRuQ==
X-Gm-Message-State: AOJu0Yyuo+kdUiojtLiC4cRAebu4EHZ12ln/uucwTttw5sB74lQs1++N
	lmOjJ9O/KudzXb6983mI7jP/2O96DVzbS3HeHb1DpA3EFlRZ25qkCsxS232LnDqp63u/oWxhRDS
	c
X-Google-Smtp-Source: AGHT+IG5qXVlDcje/LstB7h0cOFYZBIZ7QUPaoBPxDgwKZ9eniuEYfPuB///+OYjqbdkNEA+ESFwQw==
X-Received: by 2002:a05:6102:d87:b0:493:e582:70ce with SMTP id ada2fe7eead31-498f45b000bmr10562128137.10.1724756236420;
        Tue, 27 Aug 2024 03:57:16 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f34233csm539435985a.35.2024.08.27.03.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 03:57:15 -0700 (PDT)
Date: Tue, 27 Aug 2024 06:57:14 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix uninitialized return value from
 btrfs_reclaim_sweep()
Message-ID: <20240827105714.GA2466167@perftesting>
References: <e6fea9cb64a7c98b4f83e2fd75de31a1475fce28.1724755223.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6fea9cb64a7c98b4f83e2fd75de31a1475fce28.1724755223.git.fdmanana@suse.com>

On Tue, Aug 27, 2024 at 11:41:19AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The return variable 'ret' at btrfs_reclaim_sweep() is never assigned if
> none of the space infos is reclaimable (for example if periodic reclaim
> is disabled, which is the default), so we return an undefined value.
> 
> This can be fixed my making btrfs_reclaim_sweep() not return any value
> as well as do_reclaim_sweep() because:
> 
> 1) do_reclaim_sweep() always returns 0, so we can make it return void;
> 
> 2) The only caller of btrfs_reclaim_sweep() (btrfs_reclaim_bgs()) doesn't
>    care about its return value, and in its context there's nothing to do
>    about any errors anyway.
> 
> Therefore return the return value from btrfs_reclaim_sweep() and
> do_reclaim_sweep().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

