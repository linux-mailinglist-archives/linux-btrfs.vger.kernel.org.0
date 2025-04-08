Return-Path: <linux-btrfs+bounces-12872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C113A80F7B
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09C116A297
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142F822171B;
	Tue,  8 Apr 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNhlUEse"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D71A314B
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124988; cv=none; b=ZOlyUIKKNUVe0i52GD8y5a3drjgTDdnFue0CozVlFC8YZbNJJcirICLcKrSH5dTT92iP17WjRsSyaKlIzmul7Z7S3jmlMqWnmcUBkYxu4xtqlvGi1+PKFezfM50V5miz/qhbO/LaBqelzOEpdLy7TKB5hYcqjJkr1vHYQS7TGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124988; c=relaxed/simple;
	bh=mOsmmDmJJ7Rm2Cx5R251eBr7GPWDpdp2W0PAkKcJYng=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=OIifmXxNsCE72DKZalA5BXdUU8y40pa183bwlEyF4EaNFjHJlIETjg0OT8YJQjSizXwFoo+rCieIAoX4qxhA7d+GniD6Q/WFrbBrin1Sp3+Ugc5EPhrgYut7cligB5oLK3kOwP8omnCZ5PP/tDXSIl3Lv833/9dd2m9vjb1Mw1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNhlUEse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C4AC4CEE5
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744124987;
	bh=mOsmmDmJJ7Rm2Cx5R251eBr7GPWDpdp2W0PAkKcJYng=;
	h=From:To:Subject:Date:From;
	b=YNhlUEse4Uc5D9mn1zsVudd3usZronq1sPSwd+aKzSsoEw4Kze2OtPltnswsrZFas
	 Y63JcteJrXusehkTnNevsQS4VWB+2dTeYjlRiHsakPehzc4VPChkAxQCP1CGCot6zC
	 rvnKDX0V42sPhCjuajHeNbMFrVV6xrwnZ1BMVF8hjj90dC1ca/eU8/Sq2FL7pFttE6
	 uiQ/+6OdS9/+iLpRUdGXePJj0bYmcawsBiFQnukyDQVQP6BOLlNiQ5e7tb8feyyYTk
	 b2jcGwQ7RD3g3q4uOAOlfYHry8jqbsMq2sLVOzqB+3p+HYZMkRccqre1m9F1H8j2+B
	 PN3UWnsLlPWIw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: rename a few tracepoints and remove unused ones
Date: Tue,  8 Apr 2025 16:09:42 +0100
Message-Id: <cover.1744124799.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A couple trivial changes related to tracepoints.
Details in the change logs.

Filipe Manana (2):
  btrfs: tracepoints: add btrfs prefix to names where it's missing
  btrfs: tracepoints: remove no longer used tracepoints for eb locking

 fs/btrfs/extent-tree.c       |  6 +++---
 fs/btrfs/qgroup.c            | 20 ++++++++++----------
 include/trace/events/btrfs.h | 22 +++++++++-------------
 3 files changed, 22 insertions(+), 26 deletions(-)

-- 
2.45.2


