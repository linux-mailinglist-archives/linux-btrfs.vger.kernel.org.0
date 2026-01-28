Return-Path: <linux-btrfs+bounces-21153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN5aJJO1eWk0ygEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21153-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 08:06:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2BF9D95D
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 08:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D1AA301373D
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CCA3254B1;
	Wed, 28 Jan 2026 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="oErt+IKS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976152E8B6B
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769584015; cv=none; b=hxrLBEF9Rqqr84fNSLTScURYLEtOp+uM5/CEnt1MCIRdcRUHLaAXs3GsRLguQ480Nns7u0hxyDjtqdkFxulflguOCiaMNJ5ti5Hre5Z2bIE69TVeL1Q3czDwaU4bvTEgFzlF/qIXuC7Uv5Iz5gRqqr65dUFJTL3LSojqj27qSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769584015; c=relaxed/simple;
	bh=3Lmd0wxgfz6hoLz04qHIDh2vz52fl9lg4z/wxV+WGkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=u+nmIAA2kxmPb1Un2wyS+gUp4A6cRzBhmHLzuvk1B7vBfupqDBKlznGcLIW2Xzb207yAbm3awzaOh5lECWy3wnwpJjj2yGybPJPSbjt1XY5LdvrZ8YQE2zYMIaXDqVjmoI0sFT/zHT4hNywCl1pR92Hl1HDQBszTilz2JC5hHdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=oErt+IKS; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-jinbaohong.. (unknown [10.17.211.178])
	by mail.synology.com (Postfix) with ESMTPA id 4f1Cxk4X0bzGCgmfL;
	Wed, 28 Jan 2026 15:06:50 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1769584010; bh=3Lmd0wxgfz6hoLz04qHIDh2vz52fl9lg4z/wxV+WGkc=;
	h=From:To:Cc:Subject:Date;
	b=oErt+IKSmlyUpL9ODsLhFN5wFVHBdttg+H9k4hxIEM4kr1CpG9DsQ9KcdheahvLBT
	 1MrCoWNq5/UF7f7U3NrcrTABVbxVmvFQrxUxC0HE9PchZQROeDZZTGvmVc12wk3buz
	 k4oXWoP5W44PG2nLgwjxIQyyZ9UKr2NITCJfwbHA=
From: jinbaohong <jinbaohong@synology.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org,
	dsterba@suse.com,
	jinbaohong <jinbaohong@synology.com>
Subject: [PATCH v4 0/4] btrfs: fix transaction commit blocking during trim of unallocated space
Date: Wed, 28 Jan 2026 07:06:37 +0000
Message-Id: <20260128070641.826722-1-jinbaohong@synology.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21153-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinbaohong@synology.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synology.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synology.com:mid,synology.com:dkim]
X-Rspamd-Queue-Id: EE2BF9D95D
X-Rspamd-Action: no action

When trimming unallocated space, btrfs_trim_fs() holds device_list_mutex
for the entire duration while iterating through all devices. On large
filesystems with significant unallocated space, this operation can take
minutes to hours.

This causes a problem because btrfs_run_dev_stats(), called during
transaction commit, also requires device_list_mutex. While trim is
running, all transaction commits are blocked waiting for the mutex.

This series fixes the mutex blocking issue by refactoring
btrfs_trim_free_extents() to process devices in bounded chunks and
release device_list_mutex between chunks.

Additionally, this series includes related fixes and improvements to
error handling in btrfs_trim_fs():
- Fix a bug where device failure stops the entire trim instead of
  continuing to remaining devices
- Preserve the first error rather than the last, as it's typically more
  useful for debugging
- Handle user interrupts (-ERESTARTSYS/-EINTR) properly by returning
  immediately without counting them as device failures

Patches:
  1. Fix the break vs continue bug in device trimming loop
  2. Preserve first error instead of last error
  3. Handle user interrupts properly
  4. Refactor to release device_list_mutex periodically during trim

Changes since v3:
- Split patch 1 into three separate patches (patches 1-3) for easier
  review:
  - Patch 1: The minimal bug fix (break -> continue)
  - Patch 2: Preserve first error behavior
  - Patch 3: Proper user interrupt handling
- Fix patch 4 to preserve first error (consistent with patch 2) instead
  of overwriting with last error

Changes since v2:
- Set dev_ret properly on user interrupt so callers get proper
notification
- Convert -EINTR from mutex operations to -ERESTARTSYS for consistent
handling
- Restructure btrfs_trim_free_extents() for better code clarity

Changes since v1:
- Add #define BTRFS_MAX_TRIM_LENGTH; remove maxlen parameter
- Move loop-scoped variables into proper scope
- Fix comment formatting per style guidelines
- Replace goto with direct return statements

jinbaohong (4):
  btrfs: continue trimming remaining devices on failure
  btrfs: preserve first error in btrfs_trim_fs
  btrfs: handle user interrupt properly in btrfs_trim_fs
  btrfs: fix transaction commit blocking during trim of unallocated
    space

 fs/btrfs/extent-tree.c | 174 +++++++++++++++++++++++++++++++++++------
 1 file changed, 152 insertions(+), 22 deletions(-)

-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

