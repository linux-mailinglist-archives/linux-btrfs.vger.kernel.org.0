Return-Path: <linux-btrfs+bounces-13125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6960A9194C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE41F5A36CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 10:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9CC22D7BE;
	Thu, 17 Apr 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sN+V/Vsw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sN+V/Vsw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D6E22D4C3
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885606; cv=none; b=fc2EN0CYaXBwtE5pe4pDqggDUIgLAJVh2AdI0vACHvN7IsARb5ZLbQ4x4G4OOxleN2PfPA1zrtzV06v4IuHzAJh/fD891MS/++l/B+G3jLJzw6jnxfVvXuOFLnTwtIW0SgvSv3g/T4RrvhVuMk+df9ZrH8j5AfmPaDG+6mPCgvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885606; c=relaxed/simple;
	bh=JyIZr1G69z6qRwhCLx3EEzHoUwNK0vMjeTbbbJj1/K8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fn9acfcA0yvFxMpZmK5mOxg7B5CjHOQlEFRCWgu82M+p3yjrBSxcNeoOMpa8dG6lZKZsFeV3/fTStnz6H7E50aWTAyTacbH4fyuqpFx8QO6sLnc3MsrhiRWqBQDVYgi8o0WzZH4+T9nOn72lmWFGDLUNnjqdhU/S3Y3UaTcoxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sN+V/Vsw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sN+V/Vsw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74FA221184;
	Thu, 17 Apr 2025 10:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744885602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/oPCKMTG3oQnRXDkT5UNocb6P/55lLMfKiMFVJoUKIw=;
	b=sN+V/VswAOlt4c2bCvmf2pJ39NHSjS/3dn91EoGwSytu6oigOx2CwNG15jUJuey0iFliWX
	dLROm4hr2Ul+e9wD2SuUwRnr0ncn79JwUX2O3mDRKNoUdfDb/i3iEOXix99UbJzdmtxXCc
	+31oQiP834F002sLFnNmuLSSuTjIiDA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="sN+V/Vsw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744885602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/oPCKMTG3oQnRXDkT5UNocb6P/55lLMfKiMFVJoUKIw=;
	b=sN+V/VswAOlt4c2bCvmf2pJ39NHSjS/3dn91EoGwSytu6oigOx2CwNG15jUJuey0iFliWX
	dLROm4hr2Ul+e9wD2SuUwRnr0ncn79JwUX2O3mDRKNoUdfDb/i3iEOXix99UbJzdmtxXCc
	+31oQiP834F002sLFnNmuLSSuTjIiDA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 228E3137CF;
	Thu, 17 Apr 2025 10:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id roAdNGDXAGgRCgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 17 Apr 2025 10:26:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] fstests: btrfs/271: specify "-m raid1" to avoid false alerts
Date: Thu, 17 Apr 2025 19:56:23 +0930
Message-ID: <20250417102623.8638-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 74FA221184
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[FALSE FAILURE]
Test case btrfs/271 will failure like the following, if the MKFS_OPTIONS
has specified a metadata profile (either SINGLE or DUP):

  btrfs/271 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/271.out.bad)
      --- tests/btrfs/271.out	2022-11-07 09:59:11.256666666 +1030
      +++ /home/adam/xfstests/results//btrfs/271.out.bad	2025-04-17 19:49:00.129443427 +0930
      @@ -1,523 +1,9 @@
       QA output created by 271
       Allow global fail_make_request feature
       Step 1: writing with one failing mirror:
      -wrote 8192/8192 bytes at offset 0
      -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
      +fsync: Input/output error
       Step 2: verify that the data reads back fine:
      ...
      (Run 'diff -u /home/adam/xfstests/tests/btrfs/271.out /home/adam/xfstests/results//btrfs/271.out.bad'  to see the entire diff)
  Ran: btrfs/271
  Failures: btrfs/271
  Failed 1 of 1 tests

[CAUSE]
The test case relies on mkfs.btrfs to use RAID1 as default metadata
profile if multiple devices are provided.

This is no longer true if the run has specified certain profile in
MKFS_OPTIONS.

If "-m dup" or "-m single" is specified, the fs will flip read-only as
either profile can handle any missing or failed device super block
writeback.

[FIX]
Just specify both metadata (RAID1) and data (RAID1, already in the test
case) to avoid the false failure.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/271 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/271 b/tests/btrfs/271
index 2fc38e9c..7d5424f8 100755
--- a/tests/btrfs/271
+++ b/tests/btrfs/271
@@ -18,7 +18,7 @@ _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
 
 _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
-_scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
+_scratch_pool_mkfs "-m raid1 -d raid1 -b 1G" >> $seqres.full 2>&1
 
 _scratch_mount
 
-- 
2.47.1


