Return-Path: <linux-btrfs+bounces-20432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADC2D16D3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 07:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85FDC3035A87
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 06:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E880366DDF;
	Tue, 13 Jan 2026 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEo83fuw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8661431691A
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 06:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285515; cv=none; b=DNDKCcMeM4DEfaDvz0iF8W32/wBSjeXZ8vUKKdL7TzwKfzJi20AV6Y9drbG64Asvq1T4KH5Wr7ZwSzIiZsxSVdxmNjdemrzLJw7da1OhM6jquIppX/M8FyNIe/2mwxigXWeCWwephWsSlu/sezyu5UXrr9Tttx8TS7mHEbFhZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285515; c=relaxed/simple;
	bh=Vo6rx52ny6qB97nQsIUUJPIpPDQ1nTRPGlBg4gFFj3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDrX42lH4T79IR7apRkRmvGh46AtcRi2utT6N+dQx/LiTJ6jT46jlSDQ8FJF4dGUSBavJRoXTjsmdaatDXpsOuoGMWmcbLbr7a66S10ypeOn647ARR/mOWWzXsGPw1a+4ns0mZInM6zlVjgQnIGGW3/1HIQ5zkjgUNraTIHEUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEo83fuw; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34f62e71769so708761a91.0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 22:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768285514; x=1768890314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhx75LIydwY7x4rSLqE+Q7cORBYnx22smBjQUfKQthA=;
        b=mEo83fuwYRt96ayFndvOvKlc4DWooj1cCM7t8U/qFD2X6vTc/k6IHtRIH/rjWwaLMp
         N0f/JXTiTNr6G9BHWSnKFsPp/kcJwDITU3zNaQqp4jMNtuHeU/GAY1k6PcXAJciO/0JW
         eCfpEpxXHqD45VxLkxlNXQcEQyPpy7r23QjLT3uqEygAiSyBHFH4wAqIa0jPAdvzntHZ
         B1nZpU5Q1XkJUc8/+17/dWAgKe7rfluCsO7kRK0SdQkkvL8or/j1rP4l/tvsCSqNxW6+
         yhDD9+Y+Qzwma5TahptgwnpnUqq/sweC9A4k54e21eX0NuqcouKJg/CK+6H5JVOywcXx
         IWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768285514; x=1768890314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rhx75LIydwY7x4rSLqE+Q7cORBYnx22smBjQUfKQthA=;
        b=Eo+LQzh1JKoUk6KDNq1F7DB55cO2O2FGA8qTepjgftOEbzVUNjK8m7fmBNOkKWhu4Z
         PTnFhgslAm3Hx9zYZtCaNpkiy5MMClmVmIYQGdW3dcvNUu/3oEw7sfKUMmfnJTlZO/NS
         3MgsWFmLDAyP6BBuigJ003POPb0HSDFygJ8JchFeJV3b1j1C8aAMMH5xOAoBvdzF8QBv
         rWTZKtPMkfZlfmHcI5RIXosKrqoHHUlYlM8DxsGZ2CkLnN4fpHw2QD7Jy9rKaCeVP+9t
         W1vxo+ALH3wIGutIoS/7/sLXNL2fCALR6fCGR2qmkufo3WQRnG6c6DE+jDDpPMnj/pCB
         2VvQ==
X-Gm-Message-State: AOJu0Yzv0au6s+IVvyzq3MlTVpVZ9L7UaMLSwv59CG4q6RPWzGtxRjbp
	0IxVBlh7qYpBg6xgXRNb3JUurBvbrdBKLEZ6YkuT+UXgwvp6A9kNX6uaR0pZhBVZARjIkA==
X-Gm-Gg: AY/fxX4inVNXlTCIXOc7a+wG78Hc5rR0OQ4efkfDaHbF/aKPut3iChtaJl06/DhYb7t
	Cz4agV0iADKsGRvDojQF8KmfWmrxOapuerTejWnKstHko50Q45YwM+I8aCf1Yz6wIVUOTJ+Zhrs
	+lq6qSLE9J+6cDfRWRJVp1YE7tncTCy2G/pPYIA+avKSyn8PYMwTO/PyqU4mz4pdX+/IPv09Vix
	bHWhj/mVsz3Iy5sdUB4erhNJYcd19S+z3gtfQp5RCdxd+FgghDuGoJPxV9mXdwCISh+/eIj1G3v
	++8r+detINt4OSsShJPpN4gIQAwPH0n+RqqNDjh3wAEsZPQH+qtQcSiRLOmWtl7V89czcKhvYTv
	aO5SyUp+KWAuwWUFB9VbnQOElwcQtqUJOCgBuBvGAOrPpLIF+kuVENYCPogVCjGlBsXfgD/xOcx
	Y8U/IfQlpn5a2Za8RCLTQPFTS8YFeQP4U=
X-Google-Smtp-Source: AGHT+IEDaj0Vq6pjgcntl720Fkx6BJt6RHckkFC4jBDKGvRPUgNcQQ16lC5rs2zSOnASJeaInV1YYQ==
X-Received: by 2002:a17:90b:3c07:b0:349:87eb:dfbe with SMTP id 98e67ed59e1d1-34f68cd591cmr13488110a91.8.1768285513784;
        Mon, 12 Jan 2026 22:25:13 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-350fed231fcsm419971a91.5.2026.01.12.22.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 22:25:13 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v3 0/2] btrfs: fix periodic reclaim condition
Date: Tue, 13 Jan 2026 12:07:03 +0800
Message-ID: <20260113060935.21814-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series eliminates wasteful periodic reclaim operations that were occurring
when already failed to reclaim any new space, and includes several preparatory
cleanups.

Patch 1 fixes the core issue.
Patch 2 is a trival cleanup.

Changelog

v3:
- Fix the core issue with minimal changes, suggested by Boris Burkov <boris@bur.io>
- Drop some cleanups which might conflict with some other recent patches
  in mail list. I'll send them in a seperate serie.

Sun YangKai (2):
  btrfs: fix periodic reclaim condition
  btrfs: consolidate reclaim readiness checks in btrfs_should_reclaim()

 fs/btrfs/block-group.c | 18 +++++++++++-------
 fs/btrfs/space-info.c  | 21 ++++++++++++---------
 2 files changed, 23 insertions(+), 16 deletions(-)

-- 
2.52.0


