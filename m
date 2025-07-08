Return-Path: <linux-btrfs+bounces-15341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F63AFD846
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 22:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDFD3BF894
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 20:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F5223F422;
	Tue,  8 Jul 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cNWoQwlk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D45237180
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006143; cv=none; b=XbdsBrNLHSNsBOw7DJqJGZ/8h8vibYep5/nZkQyTHpF0mYn86PctdcRVgVdgoTjwYpWJ4J8376SZ3R5F/5+hWMscKjHj2Y2qSLqnwypO36URmnYn2J59b75kUzzl3yciTk+6C5wef9sV9QYK0ZE8NaIjoFKULEC8KSfGch3vKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006143; c=relaxed/simple;
	bh=fWIq9sK3skUEnIpI3xUtvubPOb/rfii7f039ze1TT+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8jc3J+g+elru2OuVZ5GoXPdo5UKQb7Td8Xw/gF0zbW59YVEPERkU9lYiUjb9+i0NcD+YW3Ig1vj71f6Jy542el8mvEh6Z1NtO5/TAHi/wXcRrO+bgE55FZ5z44w/cyNxL2Ov7CRkhnuhD/6UKp4EIsg9BFE0Qt/YUvsYN2zKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cNWoQwlk; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-31305ee3281so875003a91.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Jul 2025 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752006141; x=1752610941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SDF1rgr2LDiDKwzsYT4YdK9nApNfsPyUtMofnYvDcuw=;
        b=cNWoQwlkEhfyeMkPter0Hcdv6sdy7jeu2zpwfe8wKrgB0fCF5XOU56B7XUJXTWGNIr
         03ffD8/IXXuKve+hWrCXuNzLQNJfD668/Nn3Siak0g5JQnsjFHDWybE9V4nQzEetXiKZ
         uEUgFT6fZYzuoiJ2jZ0M1fVBoTI03fIm6rtIWn/4TxjOF2Xx3I7IkoiCZ5wccfftwqYH
         xYEr1Fej8toRhsMphi04XWGxWrDpM5yj85LJfkvZoeHjWttQrC85K6VMuevlfQ95lytb
         o9Nf718veuavtf3EgYOQnv5KfyS21PBi09BdIJPtjhR6Aih0gxX4Qq1wo9yjdt/xRNeb
         Rmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752006141; x=1752610941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDF1rgr2LDiDKwzsYT4YdK9nApNfsPyUtMofnYvDcuw=;
        b=nwHAmfORKkwAcXRpw8IRam1NuGiuuo3qey9VPPpliB7tnc8LuzoCH2Ry2vtYmR16NE
         eIt5lhb47Eul/TmoEfEyZFbI6eYg0Bc5tB+uYBUSEmTa6u8xg0dVX7Rp9i5PhrmzzWVo
         ++QdXSCDDNRjrgfrtV3FDENpisB0GHqSs3JX7/BdmO02YilK4rQo05Z6bhpLbJHEWmBv
         s8vhIC5OmjWUIzmX/Jcb2wE1tRGsP8Vx8/2P/mTZiB9+wjMQGTjR+NbDBOLFcRG7Is/h
         y2z6AbYj44/ywg+IVZWpILnWurPHcBMNSWmOsN8U2n6e2ZLa0mMiXCiTNkbWUqfjaJQg
         P72A==
X-Forwarded-Encrypted: i=1; AJvYcCULpPYpuEbZDMZtEMexxF9Hoz84qp5XyYvqmgwqb2CgBUXpWDrKt7TKMRXRCAnDmMQRjnaq+20D7SIw8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3dIeN/Z0OH4YSn96XodSLNwr4Omy8wj1wyFMFbR6YhLLYj1E
	kZxzIQujLkHwS9UE+HISw55BwK25hbqR5K4emHUApPj3wpD0ggpQSaQ7cjHmLD4aTi0ABkov3wL
	pftLpm9IcXdJ/SNm1INFmK3qxfRdlkEU9ygOcXRbp5YQaR1CG6wvr
X-Gm-Gg: ASbGncsxb5NWqxTaCFHzbydqg2Hk+X7JvT7qDrE+UMgW/x9g/0DrNFlKcmdi2GWXHZB
	TBNXSQN+SoCgZ+pTmQkOgQIQrF0wMSOLItuCy03yDKFvXOM8cfrj0rEWz4cQyjiI0xiMB5WJL6j
	a/wv5OSbWnZGgQjwFy9bb4WPMbyDnEWTeGavYZV/73V9hXfK9MaEbYIvmPonp5LZuLkyilokvBR
	u49cUUTxDR1fz4DiuKEYiFvOWf+lHKhUfLMSRKxp1K4HgYaGcC9iR4yJC/uWNi8z1VDjFf/UBHR
	XL4LYaYKS/LLIjcHFoc4hWnxWE0cR1dmeo3tfBsY
X-Google-Smtp-Source: AGHT+IHoIJWpWHBT9JBZ2YbKvDMX+Q5iSjfAfFY2liLspOsVKHb7+A7m5UOGr8XZRKQrP1u4boAOJURprZp7
X-Received: by 2002:a17:90b:3e44:b0:311:c939:c842 with SMTP id 98e67ed59e1d1-31aaccd7e36mr9233424a91.7.1752006141252;
        Tue, 08 Jul 2025 13:22:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-31c22f8be37sm50744a91.1.2025.07.08.13.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:22:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8B9623402B1;
	Tue,  8 Jul 2025 14:22:20 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8545BE41CDE; Tue,  8 Jul 2025 14:22:20 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Mark Harmstone <maharmstone@fb.com>,
	linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/4] io_uring/btrfs: remove struct io_uring_cmd_data
Date: Tue,  8 Jul 2025 14:22:08 -0600
Message-ID: <20250708202212.2851548-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs's ->uring_cmd() implementations are the only ones using io_uring_cmd_data
to store data that lasts for the lifetime of the uring_cmd. But all uring_cmds
have to pay the memory and CPU cost of initializing this field and freeing the
pointer if necessary when the uring_cmd ends. There is already a pdu field in
struct io_uring_cmd that ->uring_cmd() implementations can use for storage. The
only benefit of op_data seems to be that io_uring initializes it, so
->uring_cmd() can read it to tell if there was a previous call to ->uring_cmd().

Introduce a flag IORING_URING_CMD_REISSUE that ->uring_cmd() implementations can
use to tell if this is the first call to ->uring_cmd() or a reissue of the
uring_cmd. Switch btrfs to use the pdu storage for its btrfs_uring_encoded_data.
If IORING_URING_CMD_REISSUE is unset, allocate a new btrfs_uring_encoded_data.
If it's set, use the existing one in op_data. Free the btrfs_uring_encoded_data
in the btrfs layer instead of relying on io_uring to free op_data. Finally,
remove io_uring_cmd_data since it's now unused.

Caleb Sander Mateos (4):
  btrfs/ioctl: don't skip accounting in early ENOTTY return
  io_uring/cmd: introduce IORING_URING_CMD_REISSUE flag
  btrfs/ioctl: store btrfs_uring_encoded_data in io_btrfs_cmd
  io_uring/cmd: remove struct io_uring_cmd_data

 fs/btrfs/ioctl.c             | 41 +++++++++++++++++++++++++-----------
 include/linux/io_uring/cmd.h | 11 ++--------
 io_uring/uring_cmd.c         | 18 ++++++----------
 io_uring/uring_cmd.h         |  1 -
 4 files changed, 37 insertions(+), 34 deletions(-)

v2:
- Don't branch twice on -EAGAIN in io_uring_cmd() (Jens)
- Rebase on for-6.17/io_uring

-- 
2.45.2


