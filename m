Return-Path: <linux-btrfs+bounces-7493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D44195F13D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 14:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E2C1C21C22
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 12:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD3616B385;
	Mon, 26 Aug 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff3sObNo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486142AAA;
	Mon, 26 Aug 2024 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674986; cv=none; b=eilPbYMdbVQM7tcJBcOUJFD1jIP7n5hrEpIV8heTss2s0ERtA2W3UM/CHYapvVM+5quYL/JGDYtNNrSgwYQmP3WN6BUtML4sw0rnssA/MjQPxmxxjMXxZ8LYw4tWR/DguEANmN1iseNe0S5lAGxPc/8hbL+nki2nqcFoYdVp3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674986; c=relaxed/simple;
	bh=2uik8ZQwWjYP/Pj2jKOGorp74fR5VaNDzCvNw0qm2Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b99YQNHyNh+kc1bDGGGH3ot/A/wXBZ+brk+mY9iDEnfUcWu+3XJI9LzlR2zvUNvAGT4hS9m5+FEfLjoeHuc0IW/Rq3g6Q2RQFL0AxzfKMwm+w8IOCaXGrYSE1hmPqKLLXl6tH/D0sIZL524aRqu3roC0guZbw5w2flyiUzkFIV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff3sObNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D1AC51404;
	Mon, 26 Aug 2024 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724674985;
	bh=2uik8ZQwWjYP/Pj2jKOGorp74fR5VaNDzCvNw0qm2Pw=;
	h=From:To:Cc:Subject:Date:From;
	b=Ff3sObNoxSA6XFqUKtzVUCE0F6CYu3IXbeKnYDlzlKfNBU0eAcclpZZajI/VO9d1m
	 Cu+k5NUI+sP/sz16PDPyWL4oFzxvpwknhiwuXrNf+LwA7KE5A/rG0oZArNbOUci9iq
	 DfwfbpYO+QIm+I9nsEK8W4mLcMpvsklORWn8alj39oEA2lOWfGYeefd3w0uTsrW5TM
	 KVOOzVFAJ+CHA61VkUM13PjezwToE7+hdsTF9tSmmRVJIeyW+5K7nazxKwtnqlt383
	 IYJt+tmgKRG6dXOT/IqgVr17+E+t7aZTA024XfJBfykYl1qwQ+LvsmUo76eqxk581O
	 YLD28QjYwkYhw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/319: add git commit ID
Date: Mon, 26 Aug 2024 13:22:57 +0100
Message-ID: <fbcd0be9cf4a58086074157ea8ddd3a85eab6650.1724674946.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The kernel patch was merged into Linus' tree, so update the 'xxxxxxxxxxxx'
stub with the respective git commit ID.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/319 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/319 b/tests/btrfs/319
index 2fe80185..975c1497 100755
--- a/tests/btrfs/319
+++ b/tests/btrfs/319
@@ -29,7 +29,7 @@ _require_cp_reflink
 _require_xfs_io_command "fiemap"
 _require_odirect
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 46a6e10a1ab1 \
 	"btrfs: send: allow cloning non-aligned extent if it ends at i_size"
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
-- 
2.43.0


