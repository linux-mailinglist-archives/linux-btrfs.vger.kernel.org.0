Return-Path: <linux-btrfs+bounces-14440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F71EACD7CF
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 08:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB6718975C4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CE92620E9;
	Wed,  4 Jun 2025 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P1b7yv/9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P1b7yv/9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC2224CC
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749018323; cv=none; b=C1LkglWsp4WK6dWI1BBurA05SdPSjjbJ2V6embe36mIdOTOKiYKcypIPoGFJyGufYmCgum6+SIh2Zj/IYZRUi4laWTmM+L3Y9E9btK/izNuzZzZlDSwqlFE5Y3SjqOnoYbhTE5RzQfo2WIviccj1rv1eC1Z1/SRnR6taYRqvMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749018323; c=relaxed/simple;
	bh=SBq8AxJshDFPOZexJMxxF0N4V1no1K6vr9+4C3cxPAM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WM9ZdjDDu/V7KhdH62rQCRqyZKsZJ/TDQ5rbCq8eaAQpdpmybTk36iT7iCQuJvBgEU6gDzxGMpwGoF9ihvaqfFVS+GL9hgzo0oKdICRefHpOj79pnvOICJhISermz7/BsDaloEyD+WndpxDIhPZZavXxCy5Wm89XEAH6fkzIzes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P1b7yv/9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P1b7yv/9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27CE91F44F;
	Wed,  4 Jun 2025 06:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749018313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FlAr65U7uo66MjwmXSpc7kPS4Uvwr2OrxfWfuPxAfJ8=;
	b=P1b7yv/9xRyfu6LU1htooeifU+Jdjyt4pGl1tQaZMYfYzs2cNU/Pz5187nk+lIbYORn652
	vX+ZRWdoMoahYl85Ys20z0Ym7we7iZ9HhYXTrHURUfoVoQRqV0TQu0ZeVNEbZ6BLwdWXLQ
	rBJT7oXelylFP5hC7Yv44Hu5gBa6L0s=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749018313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FlAr65U7uo66MjwmXSpc7kPS4Uvwr2OrxfWfuPxAfJ8=;
	b=P1b7yv/9xRyfu6LU1htooeifU+Jdjyt4pGl1tQaZMYfYzs2cNU/Pz5187nk+lIbYORn652
	vX+ZRWdoMoahYl85Ys20z0Ym7we7iZ9HhYXTrHURUfoVoQRqV0TQu0ZeVNEbZ6BLwdWXLQ
	rBJT7oXelylFP5hC7Yv44Hu5gBa6L0s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E24D13A63;
	Wed,  4 Jun 2025 06:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qGWqOMfmP2iMUwAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 04 Jun 2025 06:25:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: generic/730: exclude btrfs for now
Date: Wed,  4 Jun 2025 15:55:09 +0930
Message-ID: <20250604062509.227462-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

The test case always fail for btrfs:

  generic/730       - output mismatch (see /home/adam/xfstests-dev/results//generic/730.out.bad)
    --- tests/generic/730.out	2024-04-25 18:13:45.203549435 +0930
    +++ /home/adam/xfstests-dev/results//generic/730.out.bad	2025-06-04 15:10:39.062430952 +0930
    @@ -1,2 +1 @@
     QA output created by 730
    -cat: -: Input/output error
    ...

The root reasons are:

- Btrfs doesn't support shutdown callbacks

- The current shutdown callbacks are per-fs
  Meanwhile btrfs is a multi-device fs, it needs to know which block
  device is triggerring shutdown, and needs to do extra evaluation
  (e.g. can the remaining devices support RW operations) before
  triggering a full fs shutdown.

I'm trying to improve the situation, but until then just exlucde btrfs
from the test case for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/generic/730 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/730 b/tests/generic/730
index 6251980e..cae6489f 100755
--- a/tests/generic/730
+++ b/tests/generic/730
@@ -26,6 +26,10 @@ _require_test
 _require_block_device $TEST_DEV
 _require_scsi_debug
 
+if [ "$FSTYP" = "btrfs" ]; then
+	_notrun "btrfs doesn't support per-fs shutdown yet"
+fi
+
 size=$(_small_fs_size_mb 256)
 SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 $size`
 test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
-- 
2.49.0


