Return-Path: <linux-btrfs+bounces-13658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B32AAA97E6
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 17:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D57189C33F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AAB264615;
	Mon,  5 May 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFMaN5l+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1625F795
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460200; cv=none; b=fegzi94P3QK3aBPdtlc3mkW3KudI08JhrTCu0puxerjIbtmqkUS8/rpktPEMqn/EhViMB97gj/TZ1zUV1mo2FKVLgABs8AkP6gvlvAXsGRDHT4QLjEcetXFLndLAHHfBL9FjFVXGoTlmsrtSxGFzOT15Hg4lYHz/hXB7CbpPDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460200; c=relaxed/simple;
	bh=/YPPTjyiu7GULx/rRiG0vFphbPfm8OmiyGcR0kcnrUQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=WsFMUFfmDv2UO613/TTKcsYAs/07ArFQNbZTjVyBZ6RGEEKqEvu8IsTxwGYPIUHMpMe7+lBP/R1mLzMI77G/HUfftIpclhu2S3dN8+d7AKw4Mdt72jKcQcsQyQK9Kjn+JqI/7biBuNzP5ARojBXqsU9JM1K0pgWd8agD/445Rsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFMaN5l+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAADC4CEEE
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746460200;
	bh=/YPPTjyiu7GULx/rRiG0vFphbPfm8OmiyGcR0kcnrUQ=;
	h=From:To:Subject:Date:From;
	b=eFMaN5l+qUgesAR9PmSyG+E+0oDaLONwtVbgBblXbOHO/M9CKRNgkOVHT5E8DPHHr
	 3FUEajfpNPTUm+T2MZ8+zOd9C1iyQWax9vUKkjRrcFvUBDBPVEGhpEQwjP/1MiWUbX
	 AWlT3JVyolKKrqV8e5oWVrMXb1h3KE1oNlXYdMFT9dzNnSwu3W1RKOA2mIgaeRaTbQ
	 yhFdGcTOeN5nk4kW2QLCL31vX9dvyuX6sV8lqgwtQq582PN9ETILIqcqbd3JvkKWeV
	 7A0WUYqi3bq0sEKgBZ/m8v6pOQHHyg3ot5StlwyGtHPecXAWrEfDYhewV11fRtqx+w
	 FUVUugiuXY1Rg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix an async discard infinite loop when disabling it
Date: Mon,  5 May 2025 16:49:54 +0100
Message-Id: <cover.1746460035.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Details in the change logs.

Filipe Manana (2):
  btrfs: fix discard worker infinite loop after disabling discard
  btrfs: use verbose assert at peek_discard_list()

 fs/btrfs/discard.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

-- 
2.47.2


