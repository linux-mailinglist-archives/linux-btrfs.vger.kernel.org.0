Return-Path: <linux-btrfs+bounces-9613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D669C7B80
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 19:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66C328969B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 18:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161672040AF;
	Wed, 13 Nov 2024 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HrYh2Zfd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8631B200C90
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523610; cv=none; b=fE1+PZ1w8rPqVUV1RK3VlPL6OIoXTBcrwriao81kY+q77DYTftRVdgM11fwzLOkMfst1z+SrWd5Nw898PIlaSFieL6lZ7a7uHomtnAgZFm8/jFj/xVqyTCMNAg3xqXOsUpvMz2wxVtaXJaEO/Q4wcjpiRehdg7AADjKkfdvDApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523610; c=relaxed/simple;
	bh=bjjmahyNCuDcOLFnSRDq1hTf8a7Q4M0XE3GdCGOoN+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T/iwWDwH7R7pMG+04V/aMcHYPaK46RYZGGEu3dwydhFIwQH3FkVYgawMQYCTuT5IXKhNd/8O/QMcyH0vPYYyRKpQercO7Jrrv0hNNdo10DWTa6XX4vy9uVoxsU5kt5k4DRj9uGAu0hbY4MCkf5rBuA+Sj+Nw11X/h8Xfyjsr9tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HrYh2Zfd; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-28862804c9dso600456fac.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731523607; x=1732128407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y6LZQ+uMnK0S2LY6YW0GGjZ/J1h8Erndb3dSaVvNh8=;
        b=HrYh2Zfdu9OAmuzooQQRKHi1LLIPwilwqIlwCOffSRr2HAJ5H1VjWywPoLWDNJJ7ZX
         1s4ZBo1n/2k5Y/LFuUaSCQMtVrNi+Is4IU0juGMyT9reMN7h9Md6hvAG9nIM2ABwNszf
         cfMSN3iXbg5vqQ9DaopJFoBPTocTKybygj5lEJgnoJhj4znfFCR5HPWFUH2zC+7yzpKq
         GaKV4ZudhXkS/VZfrVb5SrcQh0j33JKVR40TYaZtLjXtSJoQv85QpJmyvJ1HYLlYnuJL
         92v6MaryJk2AC8GZTjWup8hs65V3O+ZAKtKbwR6lrsR0kPoMV6XcnIDvEKiY+RtVHrHd
         oFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523607; x=1732128407;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y6LZQ+uMnK0S2LY6YW0GGjZ/J1h8Erndb3dSaVvNh8=;
        b=VNVrURDQwnRcJ2VvGjbr0s2LQOSSCgAZVOwRdOPA2+SzQdw0BkGVVv2ZGBM+98DuTt
         O26JIew1pOWFWJQQs0qRi0CWhy1UUUN2eCR2YFE1Bs6wKOEmFJR/vAtALDzHXm2bsEI4
         vZ/ZsM4Ln9KOXbIkzmUnqDDg9XyO2j0YXJOquT94lvUhDD2XBWwgPC0SQv/4xv5rE0y6
         zQFmt001Ms6QwsJcYR5yv7P6Xh6IU3rfKQq1EgUDdLihsrTNK36iYI4REN2NFBcO7Atz
         rWzQVmCnrv23ebvBltgWo54IZR3/CQP9sQMqnJn0wxbyArvF5R7ExmTK7W0DTcfNIuxY
         jRzw==
X-Forwarded-Encrypted: i=1; AJvYcCV5koG8XubbiHd/x4H065MQV+/je564phFk+w0w8miLEf0bXxN7UC8PkHNOr8I1/iJ4qitwMZkg7+4mQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyN6Zhp3ktSFtwa73DW4ZBDIlB+SP/pisQeBgYE3msxpwx7FrF
	ZmjbIpdx8csgV56cBIZ46JnOHjgJjcr29aT91BxGl2kUwLSs9QwaQ1rPBB3Ym2E=
X-Google-Smtp-Source: AGHT+IElqrUcRF3HfiSejpBqxBPsTzd7rzIjNzdtYsCTXlXDVD2IYEpSiVKFvfLa6IZJOe2HhDecgw==
X-Received: by 2002:a05:6870:2b0f:b0:288:3915:db28 with SMTP id 586e51a60fabf-296069ed640mr386417fac.5.1731523607575;
        Wed, 13 Nov 2024 10:46:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e92afbcbsm1023381fac.40.2024.11.13.10.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:46:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Yi Zhang <yi.zhang@redhat.com>, 
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
In-Reply-To: <20241113084541.34315-2-hch@lst.de>
References: <20241113084541.34315-1-hch@lst.de>
 <20241113084541.34315-2-hch@lst.de>
Subject: Re: [PATCH 1/2] block: export blk_validate_limits
Message-Id: <173152360663.2243093.16019874347039852484.b4-ty@kernel.dk>
Date: Wed, 13 Nov 2024 11:46:46 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 13 Nov 2024 09:45:35 +0100, Christoph Hellwig wrote:
> While block drivers do the validation as part of committing them to the
> queue, users that use the limit outside of a block device context have
> to validate the limits and fill in the calculated values as well.
> 
> So far btrfs is the only user of queue limits without a block device,
> and it has gotten away with that more or less by accident.  But with
> commit 559218d43ec9 ("block: pre-calculate max_zone_append_sectors")
> this became fatal for setups that have small max zone append size,
> as it won't be limited now.
> 
> [...]

Applied, thanks!

[1/2] block: export blk_validate_limits
      commit: 470d2bc3a0bc19a849cc7478c02d3f5ecaa1233e
[2/2] btrfs: validate queue limits
      commit: e559ee022658c70bdc07c4846bf279f5a5abc494

Best regards,
-- 
Jens Axboe




