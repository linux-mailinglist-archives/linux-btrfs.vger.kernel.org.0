Return-Path: <linux-btrfs+bounces-16947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC46B8747C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 00:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613057BBC22
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 22:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BE82FDC44;
	Thu, 18 Sep 2025 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ss2f6iEn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ss2f6iEn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376B2FE076
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758235447; cv=none; b=JKQHeo9bRs7L7TC4TDD6wtfNeFcSrd8kPPwUR9u97ygv0Dh59+rk/BAi6wOK/Mkur56zK1crIItRl5m1s/Kwkg7uoB58DrPafgd2xWAFrzj/IGdu7793aCO07g5hm7nlmlsmv3FOXq6x0R2CmUOM4T4zvnwJH04GAvAHahhGSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758235447; c=relaxed/simple;
	bh=Qx1dwysmCO+0HvnIjAlYgDoh7f+VWLt/ChhB+0WDd7g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJuqwCABafBsrpWQueAT2RV/l1IWHxHiyQlDtKwLPAqBVsdOvX21RIiF0Z+yhG4S3wi5D3og0LS4QERHLwVaJFcBqPposY63DvAm1O3gIJ6rW6CfYCc7A/ujpyQZO+asG2DFNTQomSfmu6St9+NqkdBM4mrTncGC5Tt7tArOm/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ss2f6iEn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ss2f6iEn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A14A01F443;
	Thu, 18 Sep 2025 22:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758235434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4JaQd1P/9sreHkhXSTPEZ3iqIzQCZtZ7hxUjV5INrY=;
	b=Ss2f6iEna6G3dhqcV41wb6c9j+veC8Z/ThQO7h7o2hS7faR16FzA6JM9ijwtTZd0M7+Dqn
	UCUpbbS4HfdQTWUsMX18gIu8I9O7gcW7PU0KuIA/GYe7sZsr2baVyKK0JrmapcknZqDsLC
	1LhQaBZ2siMFJEXjblzeoYkhR7D7xoQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758235434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4JaQd1P/9sreHkhXSTPEZ3iqIzQCZtZ7hxUjV5INrY=;
	b=Ss2f6iEna6G3dhqcV41wb6c9j+veC8Z/ThQO7h7o2hS7faR16FzA6JM9ijwtTZd0M7+Dqn
	UCUpbbS4HfdQTWUsMX18gIu8I9O7gcW7PU0KuIA/GYe7sZsr2baVyKK0JrmapcknZqDsLC
	1LhQaBZ2siMFJEXjblzeoYkhR7D7xoQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FE8713A39;
	Thu, 18 Sep 2025 22:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cBz7GCmLzGj4XAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 18 Sep 2025 22:43:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH 3/3] btrfs/26[67]: update the stale comments
Date: Fri, 19 Sep 2025 08:13:27 +0930
Message-ID: <20250918224327.12979-4-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250918224327.12979-1-wqu@suse.com>
References: <20250918224327.12979-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Test case btrfs/266 is verifying the buffered read repair on RAID1C3,
and btrfs/267 is verifying the direct IO read repair on RAID1C3.

However btrfs/267 is using incorrect comments, it says the test case is
verify buffered read repair, but it's not the case.

Fix those stale comments by explicitly mention buffered/direct IO for
each test case. (btrfs/266 for buffered, btrfs/267 for direct)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/266 | 4 ++--
 tests/btrfs/267 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/266 b/tests/btrfs/266
index 3490ecce..f8407c98 100755
--- a/tests/btrfs/266
+++ b/tests/btrfs/266
@@ -5,8 +5,8 @@
 #
 # FS QA Test 266
 #
-# Test that btrfs raid repair on a raid1c3 profile can repair interleaving
-# errors on all mirrors.
+# Test that btrfs buffered read repair on a raid1c3 profile can repair
+# interleaving errors on all mirrors.
 #
 
 . ./common/preamble
diff --git a/tests/btrfs/267 b/tests/btrfs/267
index 66e08d18..22c4aeaa 100755
--- a/tests/btrfs/267
+++ b/tests/btrfs/267
@@ -5,7 +5,7 @@
 #
 # FS QA Test 267
 #
-# Test that btrfs buffered read repair on a raid1c3 profile can repair
+# Test that btrfs direct IO read repair on a raid1c3 profile can repair
 # interleaving errors on all mirrors.
 #
 
-- 
2.51.0


