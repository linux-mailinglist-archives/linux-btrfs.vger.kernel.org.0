Return-Path: <linux-btrfs+bounces-12717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A93A77A53
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 14:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEA916660F
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D2202989;
	Tue,  1 Apr 2025 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggz/MBoE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D31EFFB2
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509150; cv=none; b=fNLFZoVe7sbkaRZzm6DDHymB3SinTywatEaaK0CzTmoiK+TS+cCJcAvbY2la8ftROE5XqHOvTMh1xmQAwN5efvW/mlpg4hLE1X1fVaWO32kKU35/o+DaGHE/eiDJ0Lpfm6XnZ919ALsfXJ6Vz9Y5xhrHUQn/O1euc6TqK8yErZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509150; c=relaxed/simple;
	bh=wKrV/rjQAMyK3xvbSpuvOHKs9WF5avTGN3CcJqEXP44=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=dl5KRoblxNLWANCpCGKIqlHi5NYKEp5FaAGPHqnHa4G8Z9QzsHv6l0vwqsNNPsm0OtsAHm+G0f2lQzGbQpHWGOnH9LXx9QKfOYdR3mmtsiepiIEeMNTdR25Kyc4Uf3/BrdmuPKyoH+iLzciwsbisIt2dtRqwP8dHu0oi3FeMC98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggz/MBoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EE1C4CEE8
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 12:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743509149;
	bh=wKrV/rjQAMyK3xvbSpuvOHKs9WF5avTGN3CcJqEXP44=;
	h=From:To:Subject:Date:From;
	b=ggz/MBoEUlUc2Z/tUdxKbuCtsq5XFTMM+N5o0p9RUkhUZJwVt/efPqcmljzDR0PsW
	 YXsyc4169p2BKBnZXUPbR7B/zR9S9gjn/lkz4yzCjz5W77IgPGQXyBLnUKJodowLjE
	 SUbQMlINbISiJJ+/YyWgNrRWhqOHFUnCy6g9gWSg3+RRpRIli/WalOnMdtHTuZnHSS
	 1/G7vjPC+tMXQd7yy3zXkJZcmm1ckt841SsaRK7cQ7g2BEeaPPto5xDSlCdIS3Ag9C
	 G0qQWuEdweJlT0KslOlhDomA6sY8taeUBtJ9u06nySCW49I9BqqDbTbxVXPGUuy3Wl
	 xQE5Pa8A8hicg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: some trivial cleanups related to io trees
Date: Tue,  1 Apr 2025 13:05:43 +0100
Message-Id: <cover.1743508707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some simple cleanups related to io trees that are very trivial and were
initally part of a larger patchset. Details in the change logs.

Filipe Manana (3):
  btrfs: use clear_extent_bit() at try_release_extent_state()
  btrfs: use clear_extent_bits() at chunk_map_device_clear_bits()
  btrfs: simplify last record detection at test_range_bit_exists()

 fs/btrfs/extent-io-tree.c | 8 +++-----
 fs/btrfs/extent_io.c      | 2 +-
 fs/btrfs/volumes.c        | 7 +++----
 3 files changed, 7 insertions(+), 10 deletions(-)

-- 
2.45.2


