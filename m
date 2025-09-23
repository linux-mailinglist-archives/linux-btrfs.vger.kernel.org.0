Return-Path: <linux-btrfs+bounces-17106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64724B94874
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 08:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 312197B05F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 06:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B26A30F7FE;
	Tue, 23 Sep 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pQNuksgV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC230EF86
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608168; cv=none; b=mw1V9zj8VX9yOBYVfSA9QlYmxMvd9l45uRVLzB44AB66fzFxjNBbKj/ROCQvoBfiQFVCK+mLgBcuIvz2aM5kZM6xNwvM/ucX/sB0j12gM/a7HZRj/DbIhiMGcw6iW7JJCxH0bEDCS6uN22pzpH5s8tQabUTZFbrgFkclC8ZM5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608168; c=relaxed/simple;
	bh=hD3OyQ5pf25nKvDX44eZPgzgzaCMLNBDyqZl+ZVGAdQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hI8TJqUZsUINinJwPtkkgAKfXPIbTQwkdOvGDQ+d+0nenAIm5His+V9ttpZPPtwVEpcOsgvByadEoYhIV8rxWV3YaamJ9xnGXLj3us0bfTHSPcM2cr08Fs+aurffwt9iOJ6cqQl/FH2ffZxIHIGP1x+9Ndk0hUBLD65qH+ED8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pQNuksgV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f2a62e44dso2991170b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758608165; x=1759212965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqB+MBmWbGWhXPKkNDOEdyh6sNxW8IJTQY+jeJPWHj8=;
        b=pQNuksgV6XfvkPUrE68/laDXSvCRDVjQznG/iTdXDBXW3S7Xrj/2y16BfBMTSQx1pn
         bpKUEMbiebfFjhRo5j8VGy9vzfiJshHArWmV5/ESISGfTYDQu9ZSMz7NKg3vn9DSAuRE
         0WjV7EVgCvMeRT0CSla5eBAGrhEh9/StXm0+T9r3IIJJ9dIoffMduRGBLyeqULEuVtal
         WP0zUUABx6UeTAuxU5eMEZj9IxsWvrJrSDUKr93k3fogPGcopdMDaaTFozwE2ZrjBKmD
         9Yhq6ac61RWCylPbdyS/iRwhq+0mIKQfCzj0B2De49Oa0pe2dMVMr/6UUgVjnKW4cfOh
         fDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758608165; x=1759212965;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqB+MBmWbGWhXPKkNDOEdyh6sNxW8IJTQY+jeJPWHj8=;
        b=mpKUzMmlCw/PFDKEowVE9FSMrTe8YzKLWe+Ql4Mu25F52jBEUJwyhrAAuis+lvC/pf
         I16/3GyubxOGR1Dq460c+K2O+F6rf9cXWUlyLqMFnSd7okK/BthUS2RIE0IXrfjLeZIQ
         v5m+Clj8q0NJ0DlrqW7dYmwrMX0oa+zU3ZJGxL6c2cSuOBYadoKr1yPm35wA8/2s0GYN
         UjUeHWrfdsjmpkf16v4K1mWKMz8u4+cPE+5NoRvnoLEWKfaJrmEo2DCtck8ITkFfuhnM
         XKYsW3COapISb+feoUiPlRxyKOtjQbjMT8xq+rY16L1x/m3yK7TjDl5qkPjIts3lI4YA
         Js8g==
X-Forwarded-Encrypted: i=1; AJvYcCVHg/Suy1BlomTc9s9DuD7Rj54RhVqkNDXhQL19jlFRmXC6hiUvW7NHoYsfkcFKagyDCL/MTnaQq2sX6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5lug1qyYbV/cMbOqqisIlAx9W6EH9QlpcqIaF8CjXc1aAc7Y
	g1TI9eEn7MRk8NcA29g6ZG3VZSEUHdOM96pXiRKmnvgMZZCmoJeKeDw7BsmI90WAr0w=
X-Gm-Gg: ASbGncv2gwb7AJzPd7ursgXzYfO71y1XYIjzcjNYrUSyT7w2xsUadt4z42uV+4CxRPA
	RMVVIJ3GAAilK1INSTkMjvDYrEmSU7aRGx4ADcN+apDbA88LMQ+sDKNhxs8kkxTHzGMt2IC0TUC
	WZIWFQaeDKKElsoRKB1Qyrp8at05kWU65lm/V66zTug29oBwFWCwH7/DQHLhDRd4v/EcCTGy3PX
	MbZSgZ/+ZHEkxfbU/mDqKxRs1j3CDgjDW9BGVOIVSxB2uiIcczd0MTmVTFBoF1d6WoPOghn6PCk
	PhcMU6xSimMPFmKm84MooRUq3r++XStGJoM3pkxmkzoO7SfppRyHl6QpN8WgYdd7D0y8z0NcvF6
	tBaUHu2MxaYwqIZvYjw==
X-Google-Smtp-Source: AGHT+IHuGnb8PBfUENdPuGyGvLbbla7V1vgnkQ+GzlyH7sUUWYMzzRFQlMWMmSJwfIFZawKhZl2ScQ==
X-Received: by 2002:a05:6a00:4fd4:b0:77f:169d:7f62 with SMTP id d2e1a72fcca58-77f538ea09bmr2180704b3a.14.1758608165503;
        Mon, 22 Sep 2025 23:16:05 -0700 (PDT)
Received: from [127.0.0.1] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc24739fsm14285188b3a.28.2025.09.22.23.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 23:16:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
In-Reply-To: <20250922170234.2269956-1-csander@purestorage.com>
References: <20250922170234.2269956-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/cmd: drop unused res2 param from
 io_uring_cmd_done()
Message-Id: <175860816137.146699.7149828855280856823.b4-ty@kernel.dk>
Date: Tue, 23 Sep 2025 00:16:01 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 22 Sep 2025 11:02:31 -0600, Caleb Sander Mateos wrote:
> Commit 79525b51acc1 ("io_uring: fix nvme's 32b cqes on mixed cq") split
> out a separate io_uring_cmd_done32() helper for ->uring_cmd()
> implementations that return 32-byte CQEs. The res2 value passed to
> io_uring_cmd_done() is now unused because __io_uring_cmd_done() ignores
> it when is_cqe32 is passed as false. So drop the parameter from
> io_uring_cmd_done() to simplify the callers and clarify that it's not
> possible to return an extra value beyond the 32-bit CQE result.
> 
> [...]

Applied, thanks!

[1/1] io_uring/cmd: drop unused res2 param from io_uring_cmd_done()
      commit: ef9f603fd3d4b7937f2cdbce40e47df0a54b2a55

Best regards,
-- 
Jens Axboe




