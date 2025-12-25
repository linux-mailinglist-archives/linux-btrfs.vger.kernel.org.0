Return-Path: <linux-btrfs+bounces-20005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4336CDE202
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 23:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EBF83001605
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 22:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CCD23D7EC;
	Thu, 25 Dec 2025 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FYCoxoAw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FYCoxoAw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085EB13D891
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Dec 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766700985; cv=none; b=hdJX9i8B5hQEFPBaazEFz3JI4PnTJeJgbcMjq4orQSeLjD7jEzw9yyMe/ojzyZqks4m9mMx6h5IoGGo231AXvohVyKv18VOIZKHOCtuO0Bf4HK1LCjjXBef38Ern8E+hOATespybqFsogEBPGhKwhM53huIJFV3wFwHguZNIyDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766700985; c=relaxed/simple;
	bh=zfrgzV0N1ipGvh0hsV5HhAOlArCHJ/nAtd905ZzxVOM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooS2cS6VOOn/4ZpbAR0xBWXRqrc+eeS4aP/mc8nu4/7E0gh4lSIpgRRjV07irzWlvQQujBzu6xajieg4gfL12Q4y+YnDmgf1tVrCgd1z589j8w0TsLHbEJpWuX/NqGbBZgGeQmFawBQ48bG16ZZ1f0WEcHoQMN5hAi9nsLlUyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FYCoxoAw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FYCoxoAw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 522A533704;
	Thu, 25 Dec 2025 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766700981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhavMdDuSC3y9SA//1Ku+Eu6ZGeu79XjDx9sD7pJhVU=;
	b=FYCoxoAwlWIIt9rppTasaUuzPsvGPoqSvYNPxZZANkFfs5/1UAI1/KRQOsa2zl1bD33KCn
	qOoBdM4KTti/IovxHwBoCeNx6WTXN2U2tX4NsJZYuuNct4peBwa6C0FtHHq9eWhAZquyvs
	Sg2y7jOZBfoM3/tk9dr9Lf9PpV5VRNk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766700981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhavMdDuSC3y9SA//1Ku+Eu6ZGeu79XjDx9sD7pJhVU=;
	b=FYCoxoAwlWIIt9rppTasaUuzPsvGPoqSvYNPxZZANkFfs5/1UAI1/KRQOsa2zl1bD33KCn
	qOoBdM4KTti/IovxHwBoCeNx6WTXN2U2tX4NsJZYuuNct4peBwa6C0FtHHq9eWhAZquyvs
	Sg2y7jOZBfoM3/tk9dr9Lf9PpV5VRNk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52F253EA65;
	Thu, 25 Dec 2025 22:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oBexBbS3TWlCSgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 25 Dec 2025 22:16:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH 1/2] fstests: btrfs/131: add explicit v1 space cache requirement
Date: Fri, 26 Dec 2025 08:45:52 +1030
Message-ID: <20251225221553.19254-2-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251225221553.19254-1-wqu@suse.com>
References: <20251225221553.19254-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.980];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]

The test case is utilizing v1 space cache, meanwhile v1 space cache
is already marked deprecated for a while since kernel commit
1e7bec1f7d65 ("btrfs: emit a warning about space cache v1 being
deprecated").

Furthermore quite some features are not compatible with v1 cache,
including the soon-to-be-default block-group-tree, and hardware
dependent zoned features.

Currently we reject those features for btrfs/131, but what we really
want is to only run the test case for supported features/kernels.
The current way to reject will not handle future kernels that completely
rejects v1 space cache.

Add a new helper, _require_btrfs_v1_cache() to do the check, which
checks the following criteria:

- "space_cache=v1" mount option is supported
  And to handle default v2 cache behavior, also add "clear_cache".
  If the kernel has completely dropped v1 cache support, such mount
  should fail.

- Check if FREE_SPACE_TREE feature exists after above mount
  For bs != ps cases, v2 cache is enforced to replace v1 cache, thus
  we need to double check to make sure above mount didn't result v2
  cache.

- Check if cache generation is correct
  If v1 cache is working, the cache_generation should be some valid
  value other than 0 nor (u64)-1.

And replace the existing checks on zoned and block-group-tree with the
new one.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/btrfs    | 25 +++++++++++++++++++++++++
 tests/btrfs/131 |  7 +------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 6a1095ff..c2d616aa 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -630,6 +630,31 @@ _btrfs_no_v1_cache_opt()
 	echo -n "-onospace_cache"
 }
 
+# v1 space cache is already deprecated and will be removed soon. Furthermore
+# the soon-to-be-default block-group-tree has dependency on v2 space cache, and
+# will reject v1 cache mount option.
+# Make sure v1 space cache is still supported for test cases still utilizing
+# v1 space cache.
+_require_btrfs_v1_cache()
+{
+	_scratch_mkfs &> /dev/null
+	_try_scratch_mount -o clear_cache,space_cache=v1 || _notrun "v1 space cache is not supported"
+	_scratch_unmount
+
+	# Make sure no FREE_SPACE_TREE enabled.
+	if $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV |\
+	   grep -q "FREE_SPACE_TREE"; then
+		_notrun "v1 space cache is not supported"
+	fi
+
+	# Make sure the cache generation is not 0 nor -1.
+	local cache_gen=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV |\
+			  grep "cache_generation" | $AWK_PROG '{ print $2 }' )
+	if [ "$cache_gen" -eq 0 -o $(( $test_num + 1 )) -eq 0 ]; then
+		_notrun "v1 space cache is not supported"
+	fi
+}
+
 # Require certain sectorsize support
 _require_btrfs_support_sectorsize()
 {
diff --git a/tests/btrfs/131 b/tests/btrfs/131
index b4756a5f..026d11e6 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -14,14 +14,9 @@ _begin_fstest auto quick
 _require_scratch
 _require_btrfs_command inspect-internal dump-super
 _require_btrfs_fs_feature free_space_tree
-# Zoned btrfs does not support space_cache(v1)
-_require_non_zoned_device "${SCRATCH_DEV}"
-# Block group tree does not support space_cache(v1)
-_require_btrfs_no_block_group_tree
+_require_btrfs_v1_cache
 
 _scratch_mkfs >/dev/null 2>&1
-[ "$(_get_page_size)" -gt "$(_scratch_btrfs_sectorsize)" ] && \
-	_notrun "cannot run with subpage sectorsize"
 
 mkfs_v1()
 {
-- 
2.51.2


