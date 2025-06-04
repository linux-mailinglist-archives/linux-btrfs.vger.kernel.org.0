Return-Path: <linux-btrfs+bounces-14441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF829ACD84C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 09:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C4F3A133F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369722FAF4;
	Wed,  4 Jun 2025 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ueP5b2vI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ueP5b2vI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2961EB19B
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749021159; cv=none; b=iaZL4aT5XkdL/INTJwmQLcGjHzw+OllJIWAprNVANuEk98k+vutB20PvFU8J1rO/ZfQQKsVUzRo4KTB/HoJkYSayfDh50UvAHozV3iiD5pDu67pDYn6IUo7tnWkjoM6a6/vPG1LoNT7j3Gv75+vMaUbLab6ye4V5ZNua/fKwXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749021159; c=relaxed/simple;
	bh=ghIvR2VtvAFOA7y39Q29TggYaXHWuTnzmDvRfkrxBR4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DSA4iKNdvIQW1nkcX0SNu6rU/mQag4Gk8j6yKaLFRdLPzVffzjQeZTaHzRKDysJebh5iARKwS2KRLc0QLK+Pv1qfVlXQLf7uX5P9UqYrOJYcSd1OEX3we+lwp2JkAiAk2xqq9AHrzURzSu/S6qYQFow4+F/+Mov772cCOyBFtb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ueP5b2vI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ueP5b2vI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 898B121C05;
	Wed,  4 Jun 2025 07:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749021028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XiklBR6pbiVgjF5l72UEtq3tyU+2+IFHDP2NgBwmmeE=;
	b=ueP5b2vI1l1BdMPw0Xmt2u8cwD4MVfKq50VWfyt632QXdw80NrE6QZJVVnLhRSOh1mTtLX
	a7QD8UMtdnNZGOYIlQaKZ0nFgC62qZ8HlkulFS970tSdG47ChjzvISE2SdP+fB3vvxTikc
	sxtQzTP9pqGQHz9sfhSZhZWpyk9DbCw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749021028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XiklBR6pbiVgjF5l72UEtq3tyU+2+IFHDP2NgBwmmeE=;
	b=ueP5b2vI1l1BdMPw0Xmt2u8cwD4MVfKq50VWfyt632QXdw80NrE6QZJVVnLhRSOh1mTtLX
	a7QD8UMtdnNZGOYIlQaKZ0nFgC62qZ8HlkulFS970tSdG47ChjzvISE2SdP+fB3vvxTikc
	sxtQzTP9pqGQHz9sfhSZhZWpyk9DbCw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FE3C1369A;
	Wed,  4 Jun 2025 07:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +33nFGPxP2iSYQAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 04 Jun 2025 07:10:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] fstests: generic/730: exclude btrfs for now
Date: Wed,  4 Jun 2025 16:40:24 +0930
Message-ID: <20250604071024.231586-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

The test case always fail for btrfs:

  generic/730       - output mismatch (see /home/adam/xfstests-dev/results//generic/730.out.bad)
    --- tests/generic/730.out	2024-04-25 18:13:45.203549435 +0930
    +++ /home/adam/xfstests-dev/results//generic/730.out.bad	2025-06-04 15:10:39.062430952 +0930
    @@ -1,2 +1 @@
     QA output created by 730
    -cat: -: Input/output error
    ...

The root reason is that, btrfs doesn't implement its blk_holder_ops when
opening a block device.
Thus when the underlying block device is marked dead, btrfs is never
going to know thus no way to shutdown (nor btrfs has a way to shutdown
either).

I'm trying to improve the situation, but until then just exlucde btrfs
from the test case for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Update the root reason
  It's not the sb->s_op->shutdown, that is only for single device
  fs (through fs_bdev_mark_dead()).
  For a multi-devices fs, it should provide a blk_holder_ops when
  opening the block device.
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


