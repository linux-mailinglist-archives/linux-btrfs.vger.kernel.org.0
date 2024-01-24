Return-Path: <linux-btrfs+bounces-1740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B8A83B2A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 20:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8FC1F21E02
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 19:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED54C133421;
	Wed, 24 Jan 2024 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="hGXFpEUc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342957E760
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126315; cv=none; b=aOhEqNBtGQYXvP8wH5aKSLH7LoaUOQELJ+UXZhsa+bSYjLyraHrekt3pC7NNKLDoPAOIKKg+TOagz91cJ1gjj/5mL8/Rw/QbW+/O1F0PLSBXa7jilUxTSbTpOTY1G7/ad+qQyiKvth/YE6ceAP7up5iHXZyOjx9ZXn8DFvN1my0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126315; c=relaxed/simple;
	bh=M1byJika2MYDhtNDM9RbkLNvGqbmvv6JoWe2+AOZMgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0LLTSrmZQotAZKqFz5KXAQ9ffO/AzplfSW8dT+Y48z5V8FymavIGyNi6PM8fsxUu1Ic/Lz1u5I0W0gzNEbpE/zueQ8nMKmWv2an2j7gD4Lor0JztLKXhbCX/lJs/28s9F+31DBiZUOwVhQsbmA1rRc6zSyGFZ8+RNyDZn71pAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=hGXFpEUc; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc223f3dd5eso4947675276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 11:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706126312; x=1706731112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+z3lTPRbpE2uORgJqQqSu0SYo99VB9iUB6MfecDT+MQ=;
        b=hGXFpEUc4qGltNhytybdCa+uWYM0G+LFTKEFL2x1Y9yTPk0qfjmA1Ss/sV+eUram2m
         rtGJyWVny42o/qyB8+puy1dltR3EljSIrGsNeZ0Ob4ystGe4o0iwqkh7umiIR1Hl/JD2
         KckxCZcb0OIcE7hy6ge7zIXlQMftDTiEDcMkFtTBbqG3JueDtoT9fQj2Rl36d9Diznom
         qqhTpacDohBmfSdMqiDTXfIILTV2tbcqECYpZ6MR4NjLE7xSvnTTsdx77vi/hTfeEGeh
         EBq2ZONVQjqJbld4EYu9o2GaRP0OvjtVtA8I92nMdaZXgDvVwdnRP7P9CLE7i0jChwNK
         E5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706126312; x=1706731112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+z3lTPRbpE2uORgJqQqSu0SYo99VB9iUB6MfecDT+MQ=;
        b=mY/1yZFd1O4Ghx4cavfUg8tvDR3sjzikfyDyGkcoYjrd9DfsEbJEdCYjQcD1zIt6gW
         tXXRmVaJ36zMetbe1LGK2hBd77IWsGhTJoXs04i8w1fQkI+Nnqed3uCVapSPvF0P/31i
         5mAv5sGnPX6kNGl8JpaA1EaBj6rcq0aVS+sRyVoGn6FCy938vtnXMBthDjnLFYXohnmH
         vPro2UMW2L9lfbeYxLOTnB+pxc8CJBwIHobgg6NkdQ1HGU2BK95Rkgy9p14PdR04a9gz
         OeBXbocdhS426lRTi0+5COhTVfcxcCYXU/yMOcDtfBVnlRwCa4zMmgTJgVDo/8a56LzU
         6s0w==
X-Gm-Message-State: AOJu0YwNpAkys0dmZ3eGdq6daS3L3bsQrIHgzIK3b2QmEzxTNGfMTnTE
	Nyt9kXMcb90YqFlWXWj5Ido5j1opJi4G5zFiunDYSw6dPIrLRFOM25qoiQZrPjw/GH0AZhLm3ER
	4
X-Google-Smtp-Source: AGHT+IFucnFymyToqTCAbTKFJv1htf/U+STWwR8DjaaCBoqkJW7+lRpiLAcJTrGVP+4clpKCRkG+cg==
X-Received: by 2002:a25:5386:0:b0:dc2:41de:b744 with SMTP id h128-20020a255386000000b00dc241deb744mr1257084ybb.32.1706126312101;
        Wed, 24 Jan 2024 11:58:32 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a5-20020a25ae05000000b00d7745e2bb19sm3016234ybj.29.2024.01.24.11.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:58:31 -0800 (PST)
Date: Wed, 24 Jan 2024 14:58:31 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Neal Gompa <neal@gompa.dev>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 00/52] btrfs: add fscrypt support
Message-ID: <20240124195831.GA1212739@perftesting>
References: <cover.1706116485.git.josef@toxicpanda.com>
 <CAEg-Je8E9HMZKeSxPY35qjTsq0rZNx3fSq1Rzi-fD+U+3oOZWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je8E9HMZKeSxPY35qjTsq0rZNx3fSq1Rzi-fD+U+3oOZWA@mail.gmail.com>

On Wed, Jan 24, 2024 at 02:18:40PM -0500, Neal Gompa wrote:
> On Wed, Jan 24, 2024 at 12:19 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > Hello,
> >
> > This is based on
> >
> > https://github.com/btrfs/linux.git for-next
> >
> > which has the recent pull from the fscrypt tree.
> >
> > I've reworked a lot of this to incorporate Eric's suggestions.  There are a few
> > more patches because of bugs I've found in testing, and I've disabled a few
> > features, namely RAID5/6 and send, as they will require more work to support
> > with encryption and that can be done after the core work is merged.
> >
> > Thanks,
> >
> > Josef
> >
> > v4->v5:
> > - Addressed all the comments from Eric and then reworked the rest of the code to
> >   handle the various changes.
> > - Fixed read repair.
> > - Fixed log replay.
> > - Disabled send for encrypted file systems.
> > - Disabled turning on encryption on RAID5/6 file systems.
> >
> 
> As long as we get these features back soon after this is merged, I'm
> fine with this. It's important from the Fedora perspective to at least
> have the ability to do blind replication, so I hope it follows shortly
> after.

Yup the send/receive stuff is mostly done, it's just the incremental part that's
broken.  I have a plan for it, but it's an additional 10-20 patches and this
series is already a monster.  I don't plan on enabling it for normal users until
send support is landed as well.  Thanks,

Josef

