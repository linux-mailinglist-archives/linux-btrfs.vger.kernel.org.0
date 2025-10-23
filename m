Return-Path: <linux-btrfs+bounces-18200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E785C02480
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1673A89BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD68286897;
	Thu, 23 Oct 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNC2UC/I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133B28507E
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235218; cv=none; b=mKNs5k822Nw09bpm++jrn9EROYfvlY7s8mYpQnLyzUTIIeim6WxNM98INC5T1Pgzhf++WM1uMa/6A75DIRie5en1/o6/G9zgWj0OnDaXCph0XYHOZ+CwtgtoNod1V2g5C+X5fNf9bSFwUXm/SVqKvnudtqNuj5efjtyN8ozKCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235218; c=relaxed/simple;
	bh=kqFVucjWjqdKvMX8+t/RclOSBFTO+lAYuZobKWAgKLs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvmG5bgG7KL/PPvWzsMmJK4xlR9HcG8FwFDZ4ubjruor/q+qvSApSKSfcprT1pFrBoFPTPE7y9xukAuL2MNPtSjlL4AzZo8gnjb7jwtgB2LqpGRCpu/7OP47ymtk24ndH+2alAXGpMHNhZW70WGMQUuTYwsX66HgV/Cfrew8GQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNC2UC/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C764C4CEFD
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235217;
	bh=kqFVucjWjqdKvMX8+t/RclOSBFTO+lAYuZobKWAgKLs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XNC2UC/IRb2qh785kvH/poDru2nJQe3WOV3WVX50svkxlRzu9KGEaKSMROW2v5uc3
	 E+pkJExI9yqAgdOFZiRLvWjWyvD/DODlFG925+FLgapG6HxqeH5vqy/hijf45TLn1v
	 03Xor4bD1XvhNwn5olRjEjrq8q/ze9PuA3AziHOjTHz4gr+eOJx3QRoe+OmHgFAMyz
	 kvs73YzsATUCbk4kXZ5urN0fThwzfZJeiVCeH2/WX/LrSem5Fz96TUpGDC52FuNS0Q
	 HPMAUM41GQeQ2Fx5gp7jTJx8L4zExMy1c8spy+elLoDmz7hkOUQd1ofgY1ZaynOklv
	 kH1Cnb39IsnEw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 13/28] btrfs: process ticket outside global reserve critical section
Date: Thu, 23 Oct 2025 16:59:46 +0100
Message-ID: <8f59d39f6175f41f9259df3bc518b6397ba17a46.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In steal_from_global_rsv() there's no need to process the ticket inside
the critical section of the global reserve. Move the ticket processing to
happen after the critical section. This helps reduce contention on the
global reserve's spinlock.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 62e1ba7f09c0..957477e5f01f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1062,13 +1062,14 @@ static bool steal_from_global_rsv(struct btrfs_space_info *space_info,
 		return false;
 	}
 	global_rsv->reserved -= ticket->bytes;
+	if (global_rsv->reserved < global_rsv->size)
+		global_rsv->full = false;
+	spin_unlock(&global_rsv->lock);
+
 	remove_ticket(space_info, ticket);
 	ticket->bytes = 0;
 	wake_up(&ticket->wait);
 	space_info->tickets_id++;
-	if (global_rsv->reserved < global_rsv->size)
-		global_rsv->full = false;
-	spin_unlock(&global_rsv->lock);
 
 	return true;
 }
-- 
2.47.2


