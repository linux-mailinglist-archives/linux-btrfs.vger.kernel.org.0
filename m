Return-Path: <linux-btrfs+bounces-8248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605AB987058
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8FCB2632A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB92E1AD415;
	Thu, 26 Sep 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9a2M1A4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172991AD40B
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343214; cv=none; b=QiQYsb5JSSFFSwaHBckE2yqfyliupWhS4Lc7yPmX+b6tSUsnypEFfGkiDcqgXpTyxDpT6ssCZXiugt/P493U6TTbG07rNscNtwKB3Hka7o3rf9BxBBw/nWF/2QPEaB+6xSumIdKmYdIcSJI+913NxTlKC4/MgtPWyojCZZmeaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343214; c=relaxed/simple;
	bh=PmCuqlkBwRJ/CtJL/Pv/p+nK8Bv6KuEA5EBdVqLWoSI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SmBtbLfNM2iodMcmpRYIXvQHcjaSCqBMNyLC3kEF+23egF5mbJ0qb7NcB7ZLmfqKOez7opWhTDef0FqycSdmk2EkXcKpMmKMZ3NV70ySZKKx0VTbCLJYmF7RW7kOGdEPqjG6FYD37OJfm0oL3BkdW2Wqm0fuqFyg63qe4s/HfGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9a2M1A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7B2C4CEC9
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727343213;
	bh=PmCuqlkBwRJ/CtJL/Pv/p+nK8Bv6KuEA5EBdVqLWoSI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c9a2M1A4V69fjtbSSCX/HGBZsw72JNDNhkbdDSh1moB6gxe2VFigfrJWjAHyHjTiD
	 U6zvKd28frTwvKSwUOX1XXkPyZdTAUUtsfNx3QyO4PPF9vzNC9KilCimwS+3CCb1kb
	 POx7UUhUoT2BrlPGz7sbtnUPAuiXBYGyqlK21X/ZPBEXyvgAaaJZ9GfTXNhOOTe6f5
	 nKMMZhaa+k5ZhsBiNQ/jv7zbOZbuJZDHFOMqiXncDLClOBWrOMsKJf2OoF2Whfq4TB
	 OFC3cDFimOc6ylWSwC57s2qvZe17MthbR5ldLLnAVNSAxZsGIQV9MS3EraTySjTZNL
	 cuoAF1tsjWN7A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 8/8] btrfs: remove pointless initialization at btrfs_qgroup_trace_extent()
Date: Thu, 26 Sep 2024 10:33:22 +0100
Message-Id: <eb55764e8a278811cc10068f02a113ce95a7c498.1727342969.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727342969.git.fdmanana@suse.com>
References: <cover.1727342969.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The qgroup record was allocated with kzalloc(), so it's pointless to set
its old_roots member to NULL. Remove the assignment.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 6294f949417c..34bb72f32ec4 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2156,7 +2156,6 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	}
 
 	record->num_bytes = num_bytes;
-	record->old_roots = NULL;
 
 	ret = btrfs_qgroup_trace_extent_nolock(fs_info, delayed_refs, record, bytenr);
 	if (ret) {
-- 
2.43.0


