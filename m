Return-Path: <linux-btrfs+bounces-12240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9BEA5DEDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 15:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C089171202
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3824E019;
	Wed, 12 Mar 2025 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="Q5I2of1G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35524DFFD
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789444; cv=none; b=ZTfs3Cl8cmwULJEYpnHFwAXO7b2wFt/y3m+uY7tBS2VKTsz61CFXdrgBiXJ2Sz2nMHMUpFGDILPZ59eThC406rriU6dPgpB9lDVp9ubmbQyfWU9lsnUiEHMPUOqLAOauMRdykQpIeN7AcIXeH5Ne79Ezef2h5UFmIhjStpS33MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789444; c=relaxed/simple;
	bh=b5GNVKf0dUozoYT4vENKJWq/5eyWVDh3jS26Zidli60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWv6f6sKDLA+w+Dsuerwmpzn2qB6hpTSmKfnL56aWVVadeepOssxvodnSoJJhvJFNWQB5AHttQngweeY3aNmJsdJ3x3XI9EL4WL4RsgpiAN5HvqyLXJb2mIwALBv1KCh28AhqgyyfiKl7nqSDvvUnkyUnWDchz3PffEjdDdMr90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=Q5I2of1G; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22403cbb47fso131580245ad.0
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741789442; x=1742394242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85OatdnhR8vOMPUDmzQa+fglJ8ydwkYnTnhnCnWHZkY=;
        b=Q5I2of1GLTvXARl7P6XKgGPccFo7U0WQf/BRsVRbU94b53/9EDrWi383hq0fGRcObe
         YFzfhLn6eNdm6/aLctOk71Vof5aDfoyR1DhS47By6o8Lo+n4YphdujNWyA2i1Q0YxxQc
         zgz/KjB7EjNFpIEY4p6QGezHE08hTNRt1X5Hvj2q2SmOYST4HqpVC2u8ncq+ZqqwRDSc
         smNvIkQJ6ZQ55zVTv563pmidhDfaxrPWCs+i1rUx0+Ec+A4s82BYrsyuaOzlNVXA6Gg4
         RNwNuu88nLX2MmHOyIeuerjm4XJhuHJ68XzcKnZDxodrabTtSKtJuipji3xNXqwqyT1h
         W4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789442; x=1742394242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85OatdnhR8vOMPUDmzQa+fglJ8ydwkYnTnhnCnWHZkY=;
        b=g7jNkszqmPEgjLSPdf4MLOPuEmTB4SMkRnAvxQKfljxRfjo179WH5534WPsYg84Ge+
         0aXqdjNfs/+Y69ufUhuM2wk5chxfp6KwsKoYYeLnJH9R+LNjN8mzRBXhIcFEEc97mPmj
         EobCaB9k+sN7WkvlbecJSaoDLskUfIZitwUmYUhxy0s/ax2AJa7suWxyvjmncSigLJjY
         AccWxldyprrdD6P0gFTtqMrF3t0qkQCilUkwA2dDUER4AzbRmw8AzjQ9Jdsozi0v10hj
         XQQqpazWSenKgmNbvHyyrwHr/ucCocxYUh++bFBMNyVH7iNFY4zX4R2ywzWtgh2qSzGE
         OmJw==
X-Gm-Message-State: AOJu0Ywhq+3L3rPkuN8N2X+CrNcNRNDt2UWtsVloLASbgQAJh4euAICt
	EJP7k6hWmQWzfU1IFTXfMQVzTvbAAity/BI6eu/5sltctPQyRvOb4cvsAf9CMhc=
X-Gm-Gg: ASbGncuNPfOqGTXQE2P5rQtjBhe4HZjzS0jInBDPPAwjBNkjCv2QyIsxHN2RSJ/J+oh
	1q3u+Nc1o+8LnNXJxffX4XaSvwesTfnchLutAlrmo03cA9Sfow/SzowUotkydbLzY8GfSyGKEEe
	HxxGnox0y/IfchcP/83O8DYORujPuRgSjhYkn3bB+X7AH7ivTsHWqQbBWvJu0geOoU0NdVqSwnH
	bAOSr8ecQhBvE957A+nWeRcijXBziwZG994y4mXHM8VGQkQQ1qd0LZScvaqKy2iuXKfUHDjlP5t
	m83gJi7giys8DSL274fRYA4bc8ohDrFpQSaldzgTTqmrA3VMTpvxPq6uzYe0sJrP1pv7QhpTCgX
	789JZ
X-Google-Smtp-Source: AGHT+IE5Kw99rmsO+aGISXKk7+NkabJNBq8xp8xHITBkdCvmzgnas/3E8b+v2s7QvMJWwmkI1EknQQ==
X-Received: by 2002:a05:6a00:928b:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-736aaa22109mr32117339b3a.12.1741789442019;
        Wed, 12 Mar 2025 07:24:02 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cc972eabsm7413860b3a.144.2025.03.12.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:24:01 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v2 0/2] introduce io_uring_cmd_import_fixed_vec
Date: Wed, 12 Mar 2025 14:23:24 +0000
Message-ID: <20250312142326.11660-1-sidong.yang@furiosa.ai>
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

Sorry for mis-sending noisy mails.

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


