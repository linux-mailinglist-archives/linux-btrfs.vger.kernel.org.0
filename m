Return-Path: <linux-btrfs+bounces-11405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44555A32CB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 18:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A827168CA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68319271838;
	Wed, 12 Feb 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqFf51az"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE5212B31;
	Wed, 12 Feb 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379740; cv=none; b=Qm/UXMU1dZ8Ojc+atA8on+WIufCWdlWq60TJoSK043e8NnXAA/7y+2xw4htvDoZQXakSfSpivZy+d4laoN7hKLCeFyN2gQ9eVjSqSbsnYA7ahuAM+C3NWjma7bzytqu8dEUonDWxjV7djxA+gkT2vr+Bt3TcfkbLOTeTDslDosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379740; c=relaxed/simple;
	bh=Wpsh4Ts1egTSW7ONd78SFEbizpWPMd2HbdycK3gy2bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KR8L6bovQdsGTiyBkWikjHgjAlljNLBcCzrmYVlIzjwyqYC1mTtr4pULzK0Y7FBFqy0r9gnt1DgZLr7/swvcOprr//NSCAP6QkqDrjTBPomgMFVXy5E3XGNL/8CV6JQ4rsy9zydsucC1iTNb1WPIss0c/T1Ytb0pah93i8uWWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqFf51az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17612C4CEE4;
	Wed, 12 Feb 2025 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739379740;
	bh=Wpsh4Ts1egTSW7ONd78SFEbizpWPMd2HbdycK3gy2bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqFf51azqHbXAVZ7ZkLAl9jLFOD8AL71efxg++FkP/S/VCkyAQFytQ2meMsPZXVYh
	 u8kLBPfVXd3aNl+EozP4QYeJHzdc2e8ZWllfwJ4RE6xJeTh0bz6zJwNQbjv3p9qaSE
	 xvDxd2JaBmt8Tzru8PsCaHxkHxlRImwruob9DXGYhY6cZBz4voZ96K8/xn1wshAnIz
	 LsNBJgECLczOb491/OtgcyHS4tS5SnE74rZjtEVkCK8QKfliEmGsQOnn47zJaUeSR1
	 VQmeClq33vgTMihSEnwR67GglpU1IKgNzfiOfwUqkhRlNvMhkOt1u52+Ltw0e3Wopu
	 l9Am78oDpcM/g==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/8] common/btrfs: add a _require_btrfs_no_nodatasum helper
Date: Wed, 12 Feb 2025 17:01:51 +0000
Message-ID: <09d16bf76cfe7317f584c2bbaeacb2ee810dcd99.1739379184.git.fdmanana@suse.com>
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

Add a _require_btrfs_no_nodatasum helper to skip a test if the nodatasum
mount option is give, as we do have several tests that fail, for several
reasons, when that mount option is passed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 5d69ddd8..a3b9c12f 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -134,6 +134,13 @@ _require_btrfs_no_nodatacow()
 	fi
 }
 
+_require_btrfs_no_nodatasum()
+{
+	if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "nodatasum"; then
+		_notrun "This test requires no nodatasum enabled"
+	fi
+}
+
 _require_btrfs_free_space_tree()
 {
 	_scratch_mkfs > /dev/null 2>&1
-- 
2.45.2


