Return-Path: <linux-btrfs+bounces-3256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376B387AFF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 19:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691941C25F6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B8F83CCD;
	Wed, 13 Mar 2024 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQVqtA1v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A4782D8B
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350906; cv=none; b=eAb14YlekSbQcl6YVatUAjUxBHjuZTKTyFfL/D3HWVWm2BTh4Z7O4mq9WBLqgREPgvDcB1rKCZCsgHSQuqj3tuauga62E6ulPRmEt06hnzOjz3HPEowHANg+EqjPKHpR0BGKfbhZRlPUtuK4UCl7rQvYxweJr/2QiJx8W5wt4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350906; c=relaxed/simple;
	bh=/ioWMCF+2e6KqENBs1BYosnANX67w2UnD8onw3zjB8Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IwXx4nLmLZMz4bTOLRBW7FEH6m+iz8BlGlfvTB3xaLQ64Mxh+2lgJgnyknG9wKmtuBR4WVAy+VS92Q1wtjY9KhviI2ZR4TydcI+gtiTsiCzSuvetKs+2TpOk5uEXexFPLtAAFlHQ5TRoHuD3alxehVzCNJhty0o/jBla6f6y/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQVqtA1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F29C433F1
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710350906;
	bh=/ioWMCF+2e6KqENBs1BYosnANX67w2UnD8onw3zjB8Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hQVqtA1vPiE78lJdztyixyGBLBhP4UYgtpNNhEEH5Bz7X8b7UhFec6+s1c4EUsj+c
	 mhX/+X20LU3dn0CtZoQRg58ex3QRPBWQR07N+SMcTtgs/hWsiEHu234ELWwxSzlhyi
	 mFO0Sp08QDGVe0KK2pfui/KeK94IjGbeg8K2dspio8cb2c3gnMQg3b6DEdLR+a2Icz
	 j8f5/Th7A/82LGeJTQDA633s2aAqDhPOSEi6tODBnAhkVVPGVk+hMwSTuMb0t0vZmy
	 EMEDQlJRAxOVsImE6KnjavBdkqNAhdpFhu4SJ7jut7g7YDoG814uFICyZPuf+QGzJ3
	 PS90XwabJKYjg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: some minor fixes around extent maps
Date: Wed, 13 Mar 2024 17:28:18 +0000
Message-Id: <cover.1710350741.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710335452.git.fdmanana@suse.com>
References: <cover.1710335452.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some minor fixes around extent maps for unexpected error cases.
More details in the change logs.

V2: Added patch 4/4.

Filipe Manana (4):
  btrfs: fix extent map leak in unexpected scenario at unpin_extent_cache()
  btrfs: fix warning messages not printing interval at unpin_extent_range()
  btrfs: fix message not properly printing interval when adding extent map
  btrfs: use btrfs_warn() to log message at btrfs_add_extent_mapping()

 fs/btrfs/extent_map.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.43.0


