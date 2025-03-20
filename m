Return-Path: <linux-btrfs+bounces-12445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE3A69DBF
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 02:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B594E1894DC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 01:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946661D79B4;
	Thu, 20 Mar 2025 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="TK3PNrbc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4BB17991
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435279; cv=none; b=bJ+MjEmcQlmxbsM8VTO8gvtb3WxcdYV/R7dZGgyefqRfGV1zMauFgXOB4Y2qPImsCPjBfgNRoVMct36Jx/3SH4YgRnP5qFqVSyr7KLKx0/mVk4dO6qNl9NRxDSCJjkw2Gc2stPsVBwa3vi7X+InikuX4Cg2VTgSbdxuGCvq2KZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435279; c=relaxed/simple;
	bh=8vd93+qClvT7Jmn/2fjitb9N8zbtZJSVzHQ/sb/MSvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXHqjBzQ2h8jOmt4nj8BaVjyowXd2VKXJ6nNYA/naZvqqdpftvGsADDvaR58n/nWJJWdDO7soosI5OpM1fAkdcHeoV+38Djyt3KvUQHaBEwqIy1QOMZEj7wZlPBBwaV5wkeblRCVgAvMVM2QzJPz9vV22jK/5wcMwkOLYkO7rfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=TK3PNrbc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224100e9a5cso2971835ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 18:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742435278; x=1743040078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+9dN+i2AzDUfkPkdVFhgTMlxb4u3ArQIL7V+3H4EdIc=;
        b=TK3PNrbchWhUgvSI65oeS5fc4fFkbRpkO/Dn3pC9UIN81mP9SlyYHM8VhVky7V4XTL
         zEnJnKFxj568lbZKhNjUsbWaNLssmUxadLKEPhmWkZMuCgRlLmg4ZMqyE2HFy28LrXp3
         KfzhqBtwV8Rbb4oFIIN3VXy7f0sUqyIvKy8JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435278; x=1743040078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9dN+i2AzDUfkPkdVFhgTMlxb4u3ArQIL7V+3H4EdIc=;
        b=Cdzk5T5BE/wiEQ3W6IPsgzP0tk12MPKRFY/Zp3Ne3V87m1u5gqpahojVfm387PsaB1
         9oAABWx2e+5BXBc7bSAVPfWx/VvvDcsp9DaevLZJPv0NPNhwqZqmqlGBy/nexcz9sAJM
         MukO4ViQXuu2b6s5QqIoWKiFBlUt8yT0oRN0c56qR6vAiX7xmTj4MoFBQCyT5jqFxVyh
         WUGi205+suHHKde8OQxUI5kwb+YtN9E+BV8jHOnKL/eIoJz3dx6oIIKa4vA2ZasyqXKq
         rktB7jMTilUSeNmap5y0UJqB/xNoEbNE4QFGfG+MuPT+k/hbFUssGsFWze56Yhdo7Lo8
         tOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKX8niRbLiN3Z68da8kdk90ph4kmDh8H4hadYgJgtd2Qj2LlWmMAGhcyxUk5IT3GtRShtZDStF7A0IrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3j600CjyuKGMBYNjmj1ykZkllnSjIWwPL++DtWnWmz6Kh4SQe
	7DzNKeUcuXFILFk8bmwRZG6y1vAkDODKYWVh6FzH/qXNKO+uLUKdpfdMBeEFnMw=
X-Gm-Gg: ASbGnct1PPg3k95xPMZkOZD9lDnABRr79BG73w8wi2F+XUGCMp/vafbguW/+gFnYgUS
	LKavmm4h1HeJBpZYKmKR57x3GOe4yeYpxctIRYDzIQa7jae3CeDhgZykpbemw0D+wlo0eOaohVw
	X5xAq29dBirA+kzFBfx974RTcAuZ+d+0ljB51D9XTIGtIwW12oNqXCVGrHdYvHsirWiM9cL4LJp
	hDI3tYz2BIIWsC0CvQBt/jcSw6it8RzSCxWq7hDV/M0ApvUH5bPdW890Rq9OXb4OZHc7ImH3NgB
	AeXzicXJgnGgCIeT3ZOkHrWCxoTioZEqXJQVzdLo6Ch6oUy9ImxC3nhmJT1BuaZkPpRrOXgJqRS
	S
X-Google-Smtp-Source: AGHT+IEnL5zS2NVHMqd/Y2yTk6lYwUWXQfuMKAs4klVP0D5Ix1QzfZttlHpANYf8RWDNJxVQfzHybA==
X-Received: by 2002:a17:902:c944:b0:223:4d7e:e523 with SMTP id d9443c01a7336-2265ee93b4cmr19116065ad.50.1742435277699;
        Wed, 19 Mar 2025 18:47:57 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371152931bsm12453091b3a.3.2025.03.19.18.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 18:47:57 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:47:43 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>
Cc: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: (subset) [RFC PATCH v5 0/5] introduce
 io_uring_cmd_import_fixed_vec
Message-ID: <Z9tzvz_4IDzMUOFb@sidongui-MacBookPro.local>
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
 <174239798984.85082.13872425373891225169.b4-ty@kernel.dk>
 <f78c156e-8712-4239-b17f-d917be03226a@kernel.dk>
 <20250319170710.GK32661@suse.cz>
 <4ba22ceb-d910-4d2c-addb-dc8bcb6dfd91@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ba22ceb-d910-4d2c-addb-dc8bcb6dfd91@kernel.dk>

On Wed, Mar 19, 2025 at 11:10:07AM -0600, Jens Axboe wrote:
> On 3/19/25 11:07 AM, David Sterba wrote:
> > On Wed, Mar 19, 2025 at 09:27:37AM -0600, Jens Axboe wrote:
> >> On 3/19/25 9:26 AM, Jens Axboe wrote:
> >>>
> >>> On Wed, 19 Mar 2025 06:12:46 +0000, Sidong Yang wrote:
> >>>> This patche series introduce io_uring_cmd_import_vec. With this function,
> >>>> Multiple fixed buffer could be used in uring cmd. It's vectored version
> >>>> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
> >>>> for new api for encoded read/write in btrfs by using uring cmd.
> >>>>
> >>>> There was approximately 10 percent of performance improvements through benchmark.
> >>>> The benchmark code is in
> >>>> https://github.com/SidongYang/btrfs-encoded-io-test/blob/main/main.c
> >>>>
> >>>> [...]
> >>>
> >>> Applied, thanks!
> >>>
> >>> [1/5] io_uring: rename the data cmd cache
> >>>       commit: 575e7b0629d4bd485517c40ff20676180476f5f9
> >>> [2/5] io_uring/cmd: don't expose entire cmd async data
> >>>       commit: 5f14404bfa245a156915ee44c827edc56655b067
> >>> [3/5] io_uring/cmd: add iovec cache for commands
> >>>       commit: fe549edab6c3b7995b58450e31232566b383a249
> >>> [4/5] io_uring/cmd: introduce io_uring_cmd_import_fixed_vec
> >>>       commit: b24cb04c1e072ecd859a98b2e4258ca8fe8d2d4d
> >>
> >> 1-4 look pretty straight forward to me - I'll be happy to queue the
> >> btrfs one as well if the btrfs people are happy with it, just didn't
> >> want to assume anything here.
> > 
> > For 6.15 is too late so it makes more sense to take it through the btrfs
> > patches targetting 6.16.
> 
> No problem - Sidong, guessing you probably want to resend patch 5/5 once
> btrfs has a next branch based on 6.15-rc1 or later.

Thanks, I'll resend only patch 5/5 then.

Thanks,
Sidong
> 
> -- 
> Jens Axboe
> 

