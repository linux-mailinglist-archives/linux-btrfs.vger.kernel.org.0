Return-Path: <linux-btrfs+bounces-11409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB72A32CB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 18:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E0F3AB40B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169C6257AE5;
	Wed, 12 Feb 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llNpyxac"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863021148A;
	Wed, 12 Feb 2025 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379746; cv=none; b=LI07Y91hUfryAD4FaBKwA6lDGXelgwE+K1VQR4mPP6h/Rq67uS5tbJbuZsWbtwW85WK7/nzTIYIqYBx8urSa1m9B1sno6PDN6gIsnvfDRhMMtMJYtvf29buTQhjA3PZDfGk8cVXThHOPV5VyJgWEoLX8NHtxZ0PsI7o0vz7zxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379746; c=relaxed/simple;
	bh=mGFeUFm6CQXz1/fY13orhUrFgomB919ocYfDixHX0KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLIyrhQcb7BbMWjAmaIny0mfALKdLfkdHUftj1ZLgEopVAt51nD3W2cwKeGI6CymCHUTfZcowJgPKNUkrE5qoMyigxWxglYcniX8qJlSHEzKOpfkyRkyoDta3ydLeCMSdyvWElW0PqJQ/qVpCAfrTUfe9j6RFXfN7plpyTwzkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llNpyxac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E4AC4CEE2;
	Wed, 12 Feb 2025 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739379745;
	bh=mGFeUFm6CQXz1/fY13orhUrFgomB919ocYfDixHX0KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llNpyxacjUhbk6SjfDc7wLS8JI3eV/AmwEBao8RSl4BrzNBub01HIutk2lAA9XeJL
	 +4VrkrDZcXeNrR+Y8/lgyBSAcitqhN/pWVRNQEuvkWHTEaWNrYWVN2pFpAUpfR4trH
	 af6l/GReFydfqMsVsdphvdGBMJcLQmgRDiCZr4ZLnce9uB0d5LWdH4VkPOuyAHoJR4
	 9PWDUrH72zeOGogJKJ9hjm0rpBlUevWOQLLwax1FT7zZf0kS+Qa3CjC4ddJoULPJ3J
	 JROYog+9++8LVEDyNUi+MklHl/7IHq6tbsywuJ08LzYHJb/1yMrp4E/bIfKTnTxg2P
	 B9y6LuD+J0Twg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 7/8] btrfs/281: skip test when running with nodatasum mount option
Date: Wed, 12 Feb 2025 17:01:55 +0000
Message-ID: <39ba965d983d0344f605ff01744304ba579527af.1739379186.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1739379182.git.fdmanana@suse.com>
References: <cover.1739379182.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The test exercises compression and compression doesn't happen on inodes
with checksums disabled (nodatasum), making the test fail the expectations
if getting compressed extents. So skip the test if nodatasum is present.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/281 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/btrfs/281 b/tests/btrfs/281
index 855dd824..8fb7158a 100755
--- a/tests/btrfs/281
+++ b/tests/btrfs/281
@@ -25,6 +25,8 @@ _require_btrfs_send_version 2
 _require_xfs_io_command "fiemap"
 _require_fssum
 _require_btrfs_no_nodatacow
+# Compression can't happen with nodatasum, so skip the test.
+_require_btrfs_no_nodatasum
 
 _fixed_by_kernel_commit a11452a3709e \
 	"btrfs: send: avoid unaligned encoded writes when attempting to clone range"
-- 
2.45.2


