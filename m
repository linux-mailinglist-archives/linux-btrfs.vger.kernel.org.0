Return-Path: <linux-btrfs+bounces-14174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C6BABFC78
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 19:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ABF8C7B01
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01173289E21;
	Wed, 21 May 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlJ99HeP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562D1E0E00
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849456; cv=none; b=gJAlaU9+9U54gDxgq2OwcGacV9y94RKbkMqddw4HRmdFw53KsXQVIaGzukTWRUwJVCrMhwYUi2fvQXVW/Y/fECzmX1S6o9am3fKiMLIK+iowzROw1ZdmIht5TEdpKD8S2eLCQzHTWUDyWf3SmBctdDpjSv9dhE+4w0+UT72K4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849456; c=relaxed/simple;
	bh=hhSigS+QRdS8fPX4nZkNjq7rmqKlUP13f+oBmaItfnc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RritUiRDPDqeLzs9HTk2IKKT56HxYoDQKmoneQrYqWRCrFoGKT75ZWwZoMXY5+Wd/O7pd1lZ58iMUPDuVUuL3vF0nLDjDiLgqlJC+dZNXKLB2rqsDOFtthVC4oq1ePQrpOUlxGJEFXdOifMf7zT3vgE/66bktY/ArPd54Nmbl20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlJ99HeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EC0C4CEEB
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 17:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747849455;
	bh=hhSigS+QRdS8fPX4nZkNjq7rmqKlUP13f+oBmaItfnc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mlJ99HePfpYVFF60g5CkIxjiv2evmEXfmkHV3oO8zmKP9DA+qd3rxWB0X17gQtMo0
	 OfTqC/twC7dww49VT88VNEVXK41ZE2Sm4e7fgU0hRn7sdOkmClu7UUjUenzDAL2ZSv
	 xycP077tchq5ZmwTQCgl2WOOkm8T2S0iyZol3y1UxBAa1mjgBhlAUrIrhoJkIRS81O
	 mCpkoW2EULS1ewjhN5HNUtfe+PW/QZo1kmSfWqNjngK3YngCwpBR0vsK4M+X0Vse+6
	 idCsC3CMbRY98lGnexJoaV36qoomnc5yW/ePofBNUwLFSXFY5a5S2Sobq9MFfPb0kF
	 q2tOiOtzgpq0g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: unfold transaction aborts when replaying log trees
Date: Wed, 21 May 2025 18:44:08 +0100
Message-Id: <3bbc085598e734155edeb5aaf1d656457b2cafc2.1747848779.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747848778.git.fdmanana@suse.com>
References: <cover.1747848778.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a single line doing a transaction abort in case either we got an
error from btrfs_get_fs_root() different from -ENOENT or we got an error
from btrfs_pin_extent_for_log_replay(), making it hard to figure out which
function call failed when looking at a transaction abort massages and
stack trace in dmesg. Change this to have an explicit transaction abort
for each one of the two cases.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 97e933113b82..c1c4b8327229 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7255,6 +7255,11 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 						   true);
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
+			if (ret != -ENOENT) {
+				btrfs_put_root(log);
+				btrfs_abort_transaction(trans, ret);
+				goto error;
+			}
 
 			/*
 			 * We didn't find the subvol, likely because it was
@@ -7267,8 +7272,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 * block from being modified, and we'll just bail for
 			 * each subsequent pass.
 			 */
-			if (ret == -ENOENT)
-				ret = btrfs_pin_extent_for_log_replay(trans, log->node);
+			ret = btrfs_pin_extent_for_log_replay(trans, log->node);
 			btrfs_put_root(log);
 
 			if (!ret)
-- 
2.47.2


