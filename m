Return-Path: <linux-btrfs+bounces-5063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1BA8C86FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 15:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F9B283ECA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A4553801;
	Fri, 17 May 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdSIb+b1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378F535A5
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951610; cv=none; b=ZzKzP5/ZWExhMEASD6vwmAz8znL7nCbpfOgAnoH1JRuW5b6YmDXXY1VGd+Twq2cgMJRnglHjv6hlArTMEVT6KahP07J2qNYJ1kQrHGrKPQovOHp1CupuDNL4+P9B/DYBn65wmo+tqtCPo1UopYlIcYcLaRzpSrH5JXlg104zw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951610; c=relaxed/simple;
	bh=u9VljdbDjbNMq0ci2OYSdq1Rh+YuZpGy+e9bm15yUeQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=iM8TGNQJL24ypPxvP42CdyQ8jp4wF2IOeFmkPSt/rW6GRcO9sbyVwc1MAvDwVaaFnoYpGS5e2dnO5odk+KgiyXMhyt3ch5S9BJXJY/rMlgUq/9ooEztj92aGHESHSBFutztxDtxaMsThY+SWU+pLAAEaNxEOwG1KPpqRcGQbl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdSIb+b1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF27C2BD10
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715951609;
	bh=u9VljdbDjbNMq0ci2OYSdq1Rh+YuZpGy+e9bm15yUeQ=;
	h=From:To:Subject:Date:From;
	b=mdSIb+b1ghcujP7HvA2P+BkRiSawTu1A/bHZbjuVgTPFSmeEalGq5X/qojNOdL0tc
	 +eQAi2A0wpQ1oLevqzjfHaHRizs3eDcLdBb4xGAL2t+zbm01HOnRKChWQFvM8gueT7
	 WWiZ51V3LOlTO+5HhVpzCEngfV/TC/13sNZ9CsRaqu45ObU762gkoAPMiMFmB8yUGY
	 Z33CDbT7DhsrkiktNMJdWDVmmKzjmme6ADS9teIS8G4hQUGEYESRCboiW7Q0chHYHZ
	 Hra8kfzvlr7Rc9M/9fMSo3WaoLWPYQEv3Ov58bGQRQF1DjKbfpgy9+pbMYnie5/ZFi
	 HlSyk0QWWkPJA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: avoid data races when accessing an inode's delayed_node
Date: Fri, 17 May 2024 14:13:23 +0100
Message-Id: <cover.1715951291.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We do have some data races when accessing an inode's delayed_node, namely
we use READ_ONCE() in a couple places while there's no pairing WRITE_ONCE()
anywhere, and in one place (btrfs_dirty_inode()) we neither user READ_ONCE()
nor take the lock that protects the delayed_node. So fix these and add
helpers to access and update an inode's delayed_node.

Filipe Manana (3):
  btrfs: always set an inode's delayed_inode with WRITE_ONCE()
  btrfs: use READ_ONCE() when accessing delayed_node at btrfs_dirty_node()
  btrfs: add and use helpers to get and set an inode's delayed_node

 fs/btrfs/btrfs_inode.h   | 12 ++++++++++++
 fs/btrfs/delayed-inode.c | 10 +++++-----
 fs/btrfs/inode.c         |  4 ++--
 3 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.43.0


