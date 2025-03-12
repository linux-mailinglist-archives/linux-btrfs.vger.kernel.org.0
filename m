Return-Path: <linux-btrfs+bounces-12235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEE3A5DD71
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 14:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B75D1893B8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318B22459C3;
	Wed, 12 Mar 2025 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="o3NkZ7ex"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF3824291F
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784981; cv=none; b=gstxgcTKiyjgithcp3rpKBoZGHPwCZbwbkROzW8M3IIj2yt6jh3997eGFAMBlNQAbH38O+Psf0xrfufA5hVvuKw9sLgybZavpgNxKTFlO9tw9ddiWKWc97gPzIB4U8dOzK1MhTITggOPZjwHSo7His/GGaTMhyny05pZlHBv1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784981; c=relaxed/simple;
	bh=Vv8RYYNN32jkVSIlC3HEqjsVMtw6rjCGH2BUjDQtq4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZFnwGnmQA3h4EeyK6Rtcl5kQM738D3KMpjVfDW5U9WBtKhlffWI9IIV92fKv+9mCylqQJPRPXc4/SNOB+6tRqOf+Z6Ncw/7yCgrinx8oOxi5sVrzLNRJuO1PqgTvjpBQmWR1faePcONmniEsVypkvZKiX7AzH2Hhm4EH0qTTs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=o3NkZ7ex; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223959039f4so133104845ad.3
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741784979; x=1742389779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjzZK8IYtDnC7MfW99ZbF8PngYp+A/NXbbGv9fyWHAs=;
        b=o3NkZ7ex9okIONmJbBbPVyagkm2/DybIppMTlcDYqE1R7MxbQVxdEFheKsJvKguIvk
         FuXZ666QwzfbosnzS2v7m9LKjuCbCZXZtFuVYthZFMQXZL4vPp9wFkkSPfpMGOPyiEzD
         AUuosU4RmcImdlEcMNK3NE62Qcfxmk1Eexc/vtJqd/Klce7s7StREDACzlY8pDz7GNAm
         PShJYSK/93f45LjiaWyAqhXLxgM26hjDGgsL6yCX6T0owV9Y328/k2p4AMk4p27QZlxn
         +NvGztp6cLz3s02x+9FpJ51Asm1E66fECGwVeaH0EdKKfzp4TTqnx9v8ulBZGG4GB0V5
         v1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784979; x=1742389779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjzZK8IYtDnC7MfW99ZbF8PngYp+A/NXbbGv9fyWHAs=;
        b=F68KE5QYFBPJoivjFXysUnx8VgHp3+HzITPlya0x5xPxQgkD1AvF4qkxVFLZ+FUf/w
         HZJcIwRwvrTAk8jdSoaDBcYfPOZjVjejQTZtZOxpyf9YD2hVmp+SIgMqyjuxYBiwuBSt
         l5MFspbl8LhVWqINjh8iIZYGwZl/WooQMRG0YV1rakdWfl4tiz4wn8v/0Tdpb+6hrTDi
         BajWi+41Tu7nit50y1xvVCSHq3BjcykwbrcYOAu+fzj2u7HQwIq8pXmYDIjNPnkIoP8A
         h6vvj3adBDaFwwL8DPMVbNmBfsD630hJyMCk+4Yl6EpiPf43LVDkUBLJICgHJai96szh
         rw7g==
X-Forwarded-Encrypted: i=1; AJvYcCXidCu1QlWoosrIbjPlxAUtWGne4e1vWD5JK5BkZIGPzAC1VsytE6bzle9s7zkCULgTB1H4mDmVHhz4XA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAicZG0ccMJ6rA+aA2mYDYU6y26+GJEd1O4M7+KMYWvznPqegu
	GaWVLStdShGt2gWIgcySaTGZk/+eAmevbEgSwXC91xA82Vn7VD7VGtZUlOF/PTM=
X-Gm-Gg: ASbGnctccIj9I8fwCVgy281EeSDXY75xP+92Y1FeYJ7YaQkh9Gc4YsWlo9F16iMKRT5
	irtcn17TxX9UjgPL5P+DYP7bEDkUyGjmk6XOBqGl2I8W7VwSFMLpZg/cEKmJM19pWy1s524a92B
	hEBQbS5rZpTFYrBsDGQPMy0m6msP9c7kYn5RBwVgO7qOZZVzzfs8QzSUIctYg4ClynYn4DWmRCQ
	meu6+6Wno2MAvzKoCnmj5e3jGbq6YAwq5yMtwG01LipEKwSFx83ePo/du+AwIUgCmM1mdk0zBe2
	oa1zo89RRbyR0RVjMQlwl3v/HZCtPa4YJ+xuqRAdFEK1LD8VXICFoY+sxofMsiWYwhXusUSe71G
	4FRnR
X-Google-Smtp-Source: AGHT+IEw/moyxYqrtJLyuuYhHY0pdrsP5qeyzccAp7ltN9DQfF3V5SgWTYBCiqpn4Sv+xnF5QXan6A==
X-Received: by 2002:a05:6a21:648f:b0:1f5:70af:a32a with SMTP id adf61e73a8af0-1f570afa5a2mr24970418637.32.1741784979399;
        Wed, 12 Mar 2025 06:09:39 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af5053a85c2sm9432299a12.10.2025.03.12.06.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:09:39 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [RFC PATCH v2 0/2] introduce io_uring_cmd_import_fixed_vec
Date: Wed, 12 Mar 2025 13:09:20 +0000
Message-ID: <20250312130924.11402-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patche series introduce io_uring_cmd_import_vec. With this function,
Multiple fixed buffer could be used in uring cmd. It's vectored version
for io_uring_cmd_import_fixed(). Also this patch series includes a usage
for new api for encoded read in btrfs by using uring cmd.

v2:
 - don't export iou_vc, use bvec for btrfs
 - use io_is_compat for checking compat
 - reduce allocation/free for import fixed vec
 
Sidong Yang (2):
  io_uring: cmd: introduce io_uring_cmd_import_fixed_vec
  btrfs: ioctl: use registered buffer for IORING_URING_CMD_FIXED

 fs/btrfs/ioctl.c             | 27 ++++++++++++++++++++++-----
 include/linux/io_uring/cmd.h | 14 ++++++++++++++
 io_uring/uring_cmd.c         | 31 +++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)

--
2.43.0


