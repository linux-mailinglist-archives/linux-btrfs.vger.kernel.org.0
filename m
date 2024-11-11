Return-Path: <linux-btrfs+bounces-9431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05439C425C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 17:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E326B259CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F40519F47E;
	Mon, 11 Nov 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KnqmP9dF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F94C66
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341321; cv=none; b=OiLi/KN6CuSOL3zs5kDkIt0t5avn86X7XbAMNk576NhtZ8e+7CgxQkD+r9vd76g5auJTpDXM+PBxginkvDCTgDvds19ECDXWdSCdE4XXXYqtpvQRmJs+YOOMr+B71rBSSnuxkrfEYL1GaWtkhBFue8dmcS5OTo0qwzZP/2VtcmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341321; c=relaxed/simple;
	bh=1GV+Ah4T1mLtm2EzfWz3lDp04gvlXwmJ1moROUW5axQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GkgpUCrpFCRHi+HOf8woFG9bGYBWo38N3qQYec215NH4GyHJhaRDXc4hT9MhHQ2x1ErWbfU5EqI+DUhfxn8nMhe9Bzm9rzzr4dkDKYMz0PRBhjOaPQpax70kFvtaKZCD94jdxBquxlcCbHAXK6CYXbj1lTrhEJYQEUvLB1TABj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KnqmP9dF; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5eba450531eso2732220eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 08:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731341319; x=1731946119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjIvuIA5jFnPZVv6BBzz9Ruzu+ShTEYVtSm7Cy9ZRdU=;
        b=KnqmP9dF0KwcTe7QhcU9GnQjbhUEDP2RHUITyFeRXO+1Ao1s4/qQP5OP/Zh+gk+dQS
         ytZRgMTcUJFnW9iwy7j2wlNNiQ2oSaNzBU5iciMGVJGkxmPvr3+EbWxXaQ2kOKpctrSY
         uifHNeOGh58NTPJiO3Bj13XMLZazeLSpjRdO000YV8aApdvASewys6saWFNvURiff+MV
         XrTj4qPBRNaqhfGIMAbDguJl/k12fjkTpbsxg0h8s/p6tLWjUZgH3jhBVcLdASuPqR48
         R9luU/X42swcQR96Yyl5hlFr6mVvCEfmK+ANng7ZJe5RPY5gyW4enpZENDfrYBiBYfze
         pxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731341319; x=1731946119;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjIvuIA5jFnPZVv6BBzz9Ruzu+ShTEYVtSm7Cy9ZRdU=;
        b=u6O/VxzFYxjdj9AAM6OJIyjffbLwBxgMLNQV5qiFI2RK9mqURsCsCof+Vlwk3ZS/Xh
         3D3ZRLQ1xq2YYGI5HferUdUGLTsEPS7epDlaCz2zUUJTgIqHI2coX0Gj975MP+hTA7jD
         h2f4VfhOtBSdYrwKJ+IvI2zJ8FpKFq9SpNuLsF18Zx8PFAn7NwFO9FA7wG1a1Sx7bkcP
         epnCRUaF/uOoOHOnc220saJzRR5ESzXl1y3hk6LXNg8NKKjQ2dTMYyATxlK9RDQiPmh8
         IIlEGcR9IYNntuaQWO91G/LzosfLjsEq12ELF2R6bWjVb2basQEJt1lGH+gULJJ50+6r
         lzYA==
X-Forwarded-Encrypted: i=1; AJvYcCXYDvadt8GgX1RIFSM+3STMZSFg8bfatB6JIFxaSscWrbeWhtXTnzkaLHRobiVgrb1s5+ujbaJ+3pX8qg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf3tGsi+FAiZs+kZQkqGcIpn8xUP82q4GyWJ5zfTd7zffx7EX0
	nOsIlbf0a9/vntGjoPYwYxXQ2sYxQKUidAM+mD6hdJFg3Ex5e7FxAHNaTJAWwqbGCvRLT1UtPuO
	Jgic=
X-Google-Smtp-Source: AGHT+IHowPnOpLP4uVZlFDR94j4qpHHkm2mIFNi1qV3APU2D+OxEY3YHnWivc90QIFlSWMME0Ao/pg==
X-Received: by 2002:a05:6820:1a4b:b0:5eb:5396:7896 with SMTP id 006d021491bc7-5ee569c2b90mr7934088eaf.4.1731341319056;
        Mon, 11 Nov 2024 08:08:39 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee4950f896sm1977187eaf.12.2024.11.11.08.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:08:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Damien Le Moal <damien.lemoal@wdc.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
In-Reply-To: <20241104062647.91160-2-hch@lst.de>
References: <20241104062647.91160-1-hch@lst.de>
 <20241104062647.91160-2-hch@lst.de>
Subject: Re: (subset) [PATCH 1/5] block: take chunk_sectors into account in
 bio_split_write_zeroes
Message-Id: <173134131795.1866988.12993346504282877702.b4-ty@kernel.dk>
Date: Mon, 11 Nov 2024 09:08:37 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 04 Nov 2024 07:26:29 +0100, Christoph Hellwig wrote:
> For zoned devices, write zeroes must be split at the zone boundary
> which is represented as chunk_sectors.  For other uses like the
> internally RAIDed NVMe devices it is probably at least useful.
> 
> Enhance get_max_io_size to know about write zeroes and use it in
> bio_split_write_zeroes.  Also add a comment about the seemingly
> nonsensical zero max_write_zeroes limit.
> 
> [...]

Applied, thanks!

[1/5] block: take chunk_sectors into account in bio_split_write_zeroes
      commit: 60dc5ea6bcfd078b71419640d49afa649acf9450
[2/5] block: fix bio_split_rw_at to take zone_write_granularity into account
      commit: 7ecd2cd4fae3e8410c0a6620f3a83dcdbb254f02
[3/5] block: lift bio_is_zone_append to bio.h
      commit: 0ef2b9e698dbf9ba78f67952a747f35eb7060470

Best regards,
-- 
Jens Axboe




