Return-Path: <linux-btrfs+bounces-2036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4C2845F61
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10F11C22733
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01705127B78;
	Thu,  1 Feb 2024 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOYtxeDN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C684127B52;
	Thu,  1 Feb 2024 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810647; cv=none; b=kByOgInSCWrcPYc3Ca+4Qne8LuY9HrkY5ssTXjsGVel/KNwQ62ptkoZc7tO6BugYJHRriDsWqEjId11xjcala5LDSDjtVCELYCtr31r8PIbE8SK4LNRix7jDhIGRN0xUbJVXABrrRTVVE0hCKTU/U0ht8OKWuLa3QgUUPr3JfOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810647; c=relaxed/simple;
	bh=Wz6y+ZQr5WBAqiVasEs/iYYNIQoVGkfxyGzfE9Bfwk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F2RtxA+YCLqiE4Kibe2fs4E1G5C2s5mZ/42Sr8VHVYLuReVTL9rT869grY37T1hI7F89CXgCZ7IHQyU1YIsghNy/kwQ3kXqfuJ5ln9i1x1pBK0Uwmt3I4PbiITOparEj66NKm9PFr3uafStesUx/+RGyXKfUW0D+Tpn8g1tMn9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOYtxeDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FA7C433C7;
	Thu,  1 Feb 2024 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706810647;
	bh=Wz6y+ZQr5WBAqiVasEs/iYYNIQoVGkfxyGzfE9Bfwk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOYtxeDNXmsELrHJVXc/IZ1JouWelgud4zdSOfe5rAzgJY8WBlRXgdJnmFKDrYol/
	 ENwcT/UL9KYJwPabchFELuormotHzJk5a7JKLv6xlMurgZBZsNmcDlpRjY2yj52lLk
	 QjC1xMMpY+mP0MygHtrXEs9pdanoEXpGDcJ9INVL8l3a2RBFQlOM3bGpDlRDoi23Us
	 h8g5hgyXRqA8UWSmJwXoQqCzGUgAIh2RwdIKnKdq8A5OAy7C540T2yVaU2j5QAX01F
	 dkhaqPtog1dQ+J2fmqV0MTx5PC7h+oTS6aN01Pmmd2cjPVwl6f8E32iSERtPzpw7+E
	 Ddps4QVclFSRg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/4] btrfs/173: make the test work when mounting with nodatacow
Date: Thu,  1 Feb 2024 18:03:48 +0000
Message-Id: <0e243759cb9551eaac8b6f10f4dfbcbd5e880d56.1706810184.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706810184.git.fdmanana@suse.com>
References: <cover.1706810184.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs/173 fails when passing "-o nodatacow" to MOUNT_OPTIONS
because it assumes that when creating a file it does not have the
nodatacow flag set, which is obviously not true if the fs is mounted with
"-o nodatacow". To allow the test to run successfully with nodatacow,
just make sure it clears the nodatacow flag from the file if the fs was
mounted with "-o nodatacow".

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/173 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/btrfs/173 b/tests/btrfs/173
index 6e78a826..42af2d26 100755
--- a/tests/btrfs/173
+++ b/tests/btrfs/173
@@ -23,6 +23,11 @@ echo "COW file"
 # unset it after the swap file has been created.
 rm -f "$SCRATCH_MNT/swap"
 touch "$SCRATCH_MNT/swap"
+# Make sure we have a COW file if we were mounted with "-o nodatacow".
+if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "nodatacow"; then
+	_require_chattr C
+	$CHATTR_PROG -C "$SCRATCH_MNT/swap"
+fi
 chmod 0600 "$SCRATCH_MNT/swap"
 _pwrite_byte 0x61 0 $(($(_get_page_size) * 10)) "$SCRATCH_MNT/swap" >> $seqres.full
 $MKSWAP_PROG "$SCRATCH_MNT/swap" >> $seqres.full
-- 
2.40.1


