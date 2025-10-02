Return-Path: <linux-btrfs+bounces-17328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02ABB22FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 02:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3973A7D52
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 00:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EFA125A9;
	Thu,  2 Oct 2025 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NugYr/BF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NugYr/BF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38618C26
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366656; cv=none; b=XuTfEYLeAdadduLOE2kDGUXmY5TLWY1ESeXHrda3HlsOvLnersa//rdth913XTLfILLsWO0D4LU7lfjkDK2avS6I1C6NIjjJU2TR0aozoUkYwsqvCWyowmwIIGwsWYuRNfxcFE6sRUQKENAx3f1GAmVOwwM0fdEqFsC16Y0TJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366656; c=relaxed/simple;
	bh=m6qiUU+G2iAHH4QVufvSwgItbj1QRI1A1XMyN00u4pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxQ14J/wvVyIAgxNemrMa8ni/jhNYg1RZPfClBTbxuFuiMc6gNY1jAI8/hH93JFN1iz4cVNEoRFWkEkzGI2ZUo6Kj1+jBLOKuaxsYp3Cj4+f+9TMGG+lmhSpukKPANIZJMI0ZQjQELZGQL7h2egFkPIvca+P/6zDtfr6SajYgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NugYr/BF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NugYr/BF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F0591F811;
	Thu,  2 Oct 2025 00:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759366636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIIV+He/oRX0hwlUob4amZmv3u0BtlhV/Fs0L7dO4WE=;
	b=NugYr/BF4G8ReSYm/14H0qQp2mdkBoFC0Hl3oVD0f4Z/8Ybz640RPmwcRp8wkb7dvi/SmS
	iwGBD/5E5rcRRkbCzyrjpLSDoKkYKFjsLT1NGJ4zdo/Msa4ocah5Rs2OFedCv57EF8ow83
	2gTz+OLxkudn0dEtEZK/E033kPWb3Bk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759366636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIIV+He/oRX0hwlUob4amZmv3u0BtlhV/Fs0L7dO4WE=;
	b=NugYr/BF4G8ReSYm/14H0qQp2mdkBoFC0Hl3oVD0f4Z/8Ybz640RPmwcRp8wkb7dvi/SmS
	iwGBD/5E5rcRRkbCzyrjpLSDoKkYKFjsLT1NGJ4zdo/Msa4ocah5Rs2OFedCv57EF8ow83
	2gTz+OLxkudn0dEtEZK/E033kPWb3Bk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C77513A42;
	Thu,  2 Oct 2025 00:57:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4DxmO+rN3WgxVgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 02 Oct 2025 00:57:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2 3/3] btrfs/26[67]: update the stale comments
Date: Thu,  2 Oct 2025 10:26:48 +0930
Message-ID: <20251002005648.47021-4-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251002005648.47021-1-wqu@suse.com>
References: <20251002005648.47021-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Test case btrfs/266 is verifying the buffered read repair on RAID1C3,
and btrfs/267 is verifying the direct IO read repair on RAID1C3.

However btrfs/267 is using incorrect comments, it says the test case is
verify buffered read repair, but it's not the case.

Fix those stale comments by explicitly mention buffered/direct IO for
each test case. (btrfs/266 for buffered, btrfs/267 for direct)

Reviewed-by: Zorro Lang <zlang@redhat.com>
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


