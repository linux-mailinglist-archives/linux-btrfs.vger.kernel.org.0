Return-Path: <linux-btrfs+bounces-18583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59083C2CD44
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 16:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B8044F518D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 15:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF8E313E29;
	Mon,  3 Nov 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DqhkjNNA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB942EF67F
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183906; cv=none; b=EtDPxJyX32oaS8uj0JZT5Bqq5g4C0FDUKRBEeNH3EoNlZQXOYymMwMMDNHof+SMsBEtPmtcZW22nkjHksuUeZFYmlzto940Os8+EtqCsWZ3k/0R9cpMYO6sS3IXrw0gbjo09URngqwliDseLRhpM1AbEWlKNEy8PYTOVtefPkTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183906; c=relaxed/simple;
	bh=wXqRBILaE55JdL+E9B9wbUTmWAfxB6SrR/EgtwrIOKk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SbXWXAMUmSzUeTtR9TbM+oe8L57XTU06hgy0nVsGahfDl+MtfP1/Ya67CYEgS6TEHmYIsPBfJZHKBYOW+bG/6baTPRnlHudpdqC6iK6F/7OUh4yIUGg5ZAGa5qG69/bZUxomZ3yCMmxZP85sV2kPQjkjO1D5SZWeIKqv2wewnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DqhkjNNA; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-9483ece8d4aso69689239f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Nov 2025 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762183903; x=1762788703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3hgVPxvqQKN83gQ2kvBZd5VQbXv1Ml6JmbzYW4vBlk=;
        b=DqhkjNNARmUumWmAELJ8kG6aFkYpyL/osO+/82gX7guXvoQcO3WYgmnk0LRFkp+G1V
         CtkXa974DGFYOe/ezzuhTCW6iAJwZWTsanKUwVfoFS59vuiRDWIQDY10V6l7ZQux9wHh
         T8qeG2ikGlRb4C8bY23BPled/bsUr2+ZA5kK81m42ZkGrZE/dmbAht7VsbdLJkMIfULU
         dUFftII2zAGIBfkcb+R2MlRwe6+R8mSFgzCDULDdLOIszUwyF38q749EsAIM9vTW2nPL
         Uj9tH21ZIMuXrJTCqSKmPgrmYF7cJf8ZmJz0FzcKrMrRnxCASka4eQNhOo4SdFQYHUtq
         i62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183903; x=1762788703;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3hgVPxvqQKN83gQ2kvBZd5VQbXv1Ml6JmbzYW4vBlk=;
        b=Xjvmrk23nz0OgL4UrjEfQBoSa6iZDCUxTxMS7kQyZbTLHWODT0tgGXosrnEJr4sfth
         +CMuvfeA5H4HDD62FIZSm8b2OfBtlCwzyw7wNbWpa4qrn/WtVOSNNY9evihAFozrdCna
         N08BVOwOHm4ZoLR3/ujS6JyvBP/4hoZF1EWqIu5SwoIJR7cpRj5izRXwtSDXHDODCe6i
         Mhc4OKLtv/UteCBOfKh1DJDjz1YXc3CR0UiSfpSZCl7U/bwZqPTg//ENECr13rCpdJAm
         TmD7afHGSShiv/1qGv38kRP3MI+MnKyQMKUQQBRZpW7UMC+eyS9RT9o2NhDdnZ4kSV8H
         To9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVC7tg3XY5ooBGsWWj2vpCvXXvUPsq81s8apjT9tLnl2+9uLiz6zrRciX7kSSVk/N73ybE8MHJzUacyIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy10VORZ1hslPUlao7uNHhh/C0QGNlbqA3kfClH7MqGlP7JSYk
	ZXN6FaA8x0wcw3bkgqikFIkxv9gwgr5ZBpY+d4XmMrmDalSFhjsbOoH5Kn8f28mVPes=
X-Gm-Gg: ASbGnctHoz0OT4utmV5w9QmHLTnDgzE74vmQVCwWfHeF+y0gsmHFPiA+8jgBamRrKGc
	LJEvA+fJNrzjB7ZESfPbsBcT9tRIuycRtOUl6hqbi1oO4TEsR+HPD6XMHJG6zlkWPrMU6+CNZPm
	0+HiANByUEMizRF16p3yX9su5eYLHcCSEgubXTmph2FJL5hP29dRfxISobvoNsAAN/BtrmWrgiu
	xXKjdD7Gcy1e7I+MrCQ6ufKrcpjXbFRr6Pd78ICUDjc0BQ8wTH/yyHE+UU2lD2G8Xl9Pz9t+ijm
	ynxKcR7isM6fCmenva8oBc1ZibMqEYbnC67zAjW6HxbVRd/o9n56itrYOlYHirfMuFAwFNv7QLo
	2eMTtBVIDGFOMjgj22PSuqJ6Q5TNHnMVJmiAq/jG/6mLU4j0ILzGnRGoFSUzfVuVFUxoVqPitMD
	fStw==
X-Google-Smtp-Source: AGHT+IFTIBxUfn46sYZ6hbUJrbv86bqFQPF02qtQJk8t7o8hAHovGW6C2GZKwz2eeRA4AwfjgvTr9g==
X-Received: by 2002:a05:6e02:3110:b0:431:d093:758d with SMTP id e9e14a558f8ab-4330d1f5a08mr177643355ab.22.1762183903343;
        Mon, 03 Nov 2025 07:31:43 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335b5a92dsm2754945ab.28.2025.11.03.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:31:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Miklos Szeredi <miklos@szeredi.hu>, Ming Lei <ming.lei@redhat.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251031203430.3886957-1-csander@purestorage.com>
References: <20251031203430.3886957-1-csander@purestorage.com>
Subject: Re: [PATCH v4 0/3] io_uring/uring_cmd: avoid double indirect call
 in task work dispatch
Message-Id: <176218390170.6648.16490159252453601596.b4-ty@kernel.dk>
Date: Mon, 03 Nov 2025 08:31:41 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 31 Oct 2025 14:34:27 -0600, Caleb Sander Mateos wrote:
> Define uring_cmd implementation callback functions to have the
> io_req_tw_func_t signature to avoid the additional indirect call and
> save 8 bytes in struct io_uring_cmd.
> 
> v4:
> - Rebase on "io_uring: unify task_work cancelation checks"
> - Small cleanup in io_fallback_req_func()
> - Avoid intermediate variables where IO_URING_CMD_TASK_WORK_ISSUE_FLAG
>   is only used once (Christoph)
> 
> [...]

Applied, thanks!

[1/3] io_uring: only call io_should_terminate_tw() once for ctx
      commit: 4531d165ee39edb315b42a4a43e29339fa068e51
[2/3] io_uring: add wrapper type for io_req_tw_func_t arg
      commit: c33e779aba6804778c1440192a8033a145ba588d
[3/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
      commit: 20fb3d05a34b55c8ec28ec3d3555e70c5bc0c72d

Best regards,
-- 
Jens Axboe




