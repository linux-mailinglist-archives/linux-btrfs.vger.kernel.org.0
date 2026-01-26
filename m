Return-Path: <linux-btrfs+bounces-21054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNKBIKgnd2kUcwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21054-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 09:36:56 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2728586D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 09:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BD8030075E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93ED2701DA;
	Mon, 26 Jan 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="aQ93Lrwg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B601A3166
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416607; cv=none; b=QkKZm+0j9Ke89uUiirh6U91AyH/8KVdLc67YgzwLIu8mof6FiJ1nWEOBeRlF5ClcVuOIjpae/vOIS+reG8Ctd/KoALFhaWb6Bs8TFNN4zMyEaLxRjCjMLaODtxX1rbHf1H6ci6QpRys6Pfno8EL1QvrAUtKBoQ4EM9FrZNWNNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416607; c=relaxed/simple;
	bh=+MKKNutO8KRQIIdyX4vd+jMxhXAHPtNXEozK28Kgx5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tts1W95wXzHrzot2+EMS07LCnYN/fpjX6adBGusC4tJg538fK/9luHaqBJChYmbmV4R9oHR8J6Q6UmRyks0P+BzsyqpE/T1lWqyQmPPL1u6xuQRNTGmUd+VBOZY/zQYUDwV9zbXgxYih4Xylub7Kc1RUgCOsQuAgP+9lIoTzS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=aQ93Lrwg; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-jinbaohong.. (unknown [10.17.211.178])
	by mail.synology.com (Postfix) with ESMTPA id 4f022M2VMFzG9NvBQ;
	Mon, 26 Jan 2026 16:36:43 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1769416603; bh=+MKKNutO8KRQIIdyX4vd+jMxhXAHPtNXEozK28Kgx5Y=;
	h=From:To:Cc:Subject:Date;
	b=aQ93LrwgcN95AcgIFqf6qPHm/hgqHqWpGRoCp6XfTsm11cf9Wc4yxHhO8vtPzFuCO
	 TnyBDVt0PwDPlUYkzEiPaawBOb9Zr6f8JUtPWqE32sBQC/F5GyZQXWKbvHvzAfxi3N
	 OmqBvNsexka5epCwHdaHpCuckxw4tAOEjykG6dP8=
From: jinbaohong <jinbaohong@synology.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org,
	dsterba@suse.com,
	jinbaohong <jinbaohong@synology.com>
Subject: [PATCH v3 0/2] btrfs: fix transaction commit blocking during trim of unallocated space
Date: Mon, 26 Jan 2026 08:36:37 +0000
Message-Id: <20260126083639.602258-1-jinbaohong@synology.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21054-lists,linux-btrfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinbaohong@synology.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synology.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synology.com:mid,synology.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C2728586D
X-Rspamd-Action: no action

This patchset addresses two related issues in btrfs_trim_fs():

1. The first patch fixes incorrect error handling where device failures
   would abort the entire trim operation instead of continuing to the
   next device, and ensures user interrupts are handled consistently.

2. The second patch fixes a mutex blocking issue where long-running trim
   operations would block transaction commits for minutes to hours.

=== User Interrupt (-ERESTARTSYS or -EINTR) Behavior ===

- Stop scanning devices immediately
- Return -ERESTARTSYS to user
- Do NOT count interrupt as a device failure (dev_failed not incremented)
- Set dev_ret to -ERESTARTSYS (overwrites last device error)
- Accumulate partial trim amount before returning
- If devices failed before interrupt, warning is still printed

=== Changes since v2 ===
- [Patch 1] Set dev_ret to -ERESTARTSYS on user interrupt so error is
  properly returned to caller
- [Patch 1] Convert -EINTR from mutex_lock_interruptible() to -ERESTARTSYS
  for consistent interrupt handling
- [Patch 2] Refactor btrfs_trim_free_extents() for clearer control flow

=== Changes since v1 ===
- Add #define BTRFS_MAX_TRIM_LENGTH, remove maxlen parameter (Filipe)
- Move loop-only variables into loop scope (Filipe)
- Fix comment style: capitalization and punctuation (Filipe)
- Replace goto patterns with direct returns (Filipe)


jinbaohong (2):
  btrfs: continue trimming remaining devices on failure
  btrfs: fix transaction commit blocking during trim of unallocated
    space

 fs/btrfs/extent-tree.c | 164 +++++++++++++++++++++++++++++++++++------
 1 file changed, 143 insertions(+), 21 deletions(-)

-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

