Return-Path: <linux-btrfs+bounces-2978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D408386EAE6
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 22:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729B31F23573
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 21:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45B856B8A;
	Fri,  1 Mar 2024 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EfO40S4t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667D535DE
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327218; cv=none; b=mXYsh37/WC32O0Ns2yOepPD2j6B4DM4N17ZkWYIUSespGBYwjBniK8JDjhVrXjDGRZ3kelrB6Qf1+07NUZnaqybwvDuVJ/0qI4i20O10U5tjijwj/Z1lIiOSacGtbtct7a2AsWlC9oOs+3ED0Xq/g8ECf/fBwGXbE8PA2R7zNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327218; c=relaxed/simple;
	bh=mNde+gTsSkChbTdKjSLipqdY0qCAeMFPch7SH2PQ2EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVCJkUAsSUV0F8eCoDQYaj47d7TI+ic6J7sMFZ0eSWnvTtfGTHgB88I+UMj/bXAMUtTdZwEMOnZ6/ObuLY+lO6AiryKt6R3EqtvP0aU+Tk68cL29fXOdePRLL9jhz1Ij6LyW3hNsUyii08NszMOj0HwikcP0AyifiXVNLFia3mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EfO40S4t; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c19b7d9de7so1501608b6e.2
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Mar 2024 13:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1709327216; x=1709932016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXta0zViG17ecbh6Vju52MJfZdjTtx5UTdv4Waj/JhM=;
        b=EfO40S4tQ+177YvZi5vlqYxRXIgMm2nMqgpN4MhOIZnaupvFg8J627jggiUyDWduzV
         UfXAKv0lyNlliDOcAXjg0soTsh6Qx3+cjziAQWdu4a4jEf0q+TPWI5hyUidSB4vb2Jo5
         chR1rRkywdJVHo1xae7Hf4zv6vewcN7at1ltcq6E7juVMswIq7heV3JuFgV2ywONISk7
         mh8J0TQSg0i8X7KP7MXkOb9oNenGJ7QqJBH5j6T8cPaIzb2J2PoQuB06ltRFsaSJrWI9
         nlHJgxLMwTIbIL7GEsYcYnVpfTLbAJ6LHhdjjUTPZk1iQEnm3NqgfWqxb9a3JtA7UY6s
         T85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327216; x=1709932016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXta0zViG17ecbh6Vju52MJfZdjTtx5UTdv4Waj/JhM=;
        b=N2KvNkkPnQNXisTh5zS3jzfXzpUZa46ZSpGBgIQqD5nkNXJWWF1me4XtzAJ7lVdiS7
         SVAPXi1SY5CYN42XEp08XhmN18ZVe6wN36VHXySFfVp/Ilkw5EFYn3YS9qq1y7SxuWNO
         bNyPfJKkYjmT7XKStG4tRLCLRyEh9WpGGjN7BgJiWX6hIE5uKwJN/CZXnfrQYZDG4hSL
         Y8SmrYfNzM5hjaakXBQUDSjUfp6FBVGZJe6EJbQ8dY/fMN4n0BnknLXYqMyTOo4OHCfK
         IjCLBB7SllLbGK7sZx7MuwmAurgTk3ujB0N68aSQAaDaNuOgpa+jkL5tOH9vGa5cPoWA
         5dDQ==
X-Gm-Message-State: AOJu0YwDMkPi0oceYuH/mj6CNWTzmQyMUx5k4Xwb38rzapxwOuOwaRQ4
	dvziL3wX00bsoIznVoQc1YM1EOyD0HmBi+yt8Oa6W9zyHd5NCFgh2JrJW1u9/zdCb84jtDnuBMh
	8
X-Google-Smtp-Source: AGHT+IE45AlfBDPrp6W9Uj2oPC1q4IkfX9JV/9qp9nk6V+mi6XQvoDCF9RBrKengyzsVB9PcGCV9PQ==
X-Received: by 2002:a05:6808:7c1:b0:3be:d941:621b with SMTP id f1-20020a05680807c100b003bed941621bmr2794523oij.26.1709327216205;
        Fri, 01 Mar 2024 13:06:56 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a19-20020a05620a125300b00787b93d8df1sm1980770qkl.99.2024.03.01.13.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:06:55 -0800 (PST)
Date: Fri, 1 Mar 2024 16:06:54 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fiemap fix and optimization
Message-ID: <20240301210654.GA2112259@perftesting>
References: <cover.1709202499.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709202499.git.fdmanana@suse.com>

On Thu, Feb 29, 2024 at 11:56:20AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> One more fix for a regression introduced recently introduced to fiemap,
> which can actually have serious consequences, as explained in the change
> log of the first patch. The other is just a small optimization.
> More details in the change logs.
> 
> Filipe Manana (2):
>   btrfs: fix race when detecting delalloc ranges during fiemap
>   btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations
> 
>  fs/btrfs/extent_io.c | 253 +++++++++++++++++++++++++++++++------------
>  1 file changed, 184 insertions(+), 69 deletions(-)
> 

Man I just made a whole mess of this whole thing.  I didn't take into account
the cloned leaf buffer thing.  I really hate our reliance on the extent lock to
protect so much vood here, but in the end I don't think there's much we can do
about it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

