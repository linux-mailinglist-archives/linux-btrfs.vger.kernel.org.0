Return-Path: <linux-btrfs+bounces-14963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F56FAE92A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 01:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662CB3BAA8D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 23:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070CB2F3C0A;
	Wed, 25 Jun 2025 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AtBuBfwN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AtBuBfwN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3918C2F3624
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893644; cv=none; b=LYAHedfwIs4TRtkyxvIOGLfsNPk+KfJcdHvSqC7sdPOIFwUKfL7Zfwrz1fWjxbCqdDutb++dZZWrGpF88+G0Ekd8A312UWQX9eXyrwy/cNmj8juei6vu0vdZtwWufpmPhQsk0NGClPH+kBMzHWk+/u0PrLI7rGHvfcfQlNFSLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893644; c=relaxed/simple;
	bh=FbezXqHmvRkXm8c0a1yC09gQ9MAOPKwdaaVhBTylqi0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YuR/bBZ/h3aWMlOMhrk1FYfHsR3v5aQxqT1ByhwKKvAho5UrwdaZ3Pu9ier4rfY3piJZtnFclDuJvQzf3F9qytZr3iAIrGwbWlr6tp6MET9MAJsmhY8dp/RXDevolx2wv7i7sdmARW4k/7+ecM2euJMb1iPm02oObWF4gVtgPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AtBuBfwN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AtBuBfwN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 424341F460;
	Wed, 25 Jun 2025 23:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750893640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tk29JGE7sdQz5KRIrs3zcifYS9tbBeHLehEwSSYzD4c=;
	b=AtBuBfwNIypcrmR3uvFM4WfVbyOfe4HLEyDDY29d6wXPYRKCB7nE4XGCkjPtIG6I3slqoo
	GcY+KmbKaGm8fwO1cz5ml6or+1c3DbdcFcwFDIbTGhwTh2qDU33x34cyRyX10i6PGwgIS5
	mNPMR5n+GFQ+Qa2vRXpZSAIOHVrLb6U=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=AtBuBfwN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750893640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tk29JGE7sdQz5KRIrs3zcifYS9tbBeHLehEwSSYzD4c=;
	b=AtBuBfwNIypcrmR3uvFM4WfVbyOfe4HLEyDDY29d6wXPYRKCB7nE4XGCkjPtIG6I3slqoo
	GcY+KmbKaGm8fwO1cz5ml6or+1c3DbdcFcwFDIbTGhwTh2qDU33x34cyRyX10i6PGwgIS5
	mNPMR5n+GFQ+Qa2vRXpZSAIOHVrLb6U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 432A313485;
	Wed, 25 Jun 2025 23:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YuzrAUeEXGhhKAAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 25 Jun 2025 23:20:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] common/rc: add btrfs support for _small_fs_size_mb()
Date: Thu, 26 Jun 2025 08:50:21 +0930
Message-ID: <20250625232021.69787-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 424341F460
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

[FAILURE]
With the incoming shutdown ioctl and remove_bdev callback support, btrfs
is able to run the shutdown group.

However test case like generic/042 fails on btrfs:

generic/042 9s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//generic/042.out.bad)
    --- tests/generic/042.out	2022-05-11 11:25:30.763333331 +0930
    +++ /home/adam/xfstests/results//generic/042.out.bad	2025-06-26 08:43:56.078509452 +0930
    @@ -1,10 +1 @@
     QA output created by 042
    -falloc -k
    -wrote 65536/65536 bytes at offset 0
    -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -fpunch
    -wrote 65536/65536 bytes at offset 0
    -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    ...
    (Run 'diff -u /home/adam/xfstests/tests/generic/042.out /home/adam/xfstests/results//generic/042.out.bad'  to see the entire diff)
Ran: generic/042
Failures: generic/042
Failed 1 of 1 tests

[CAUSE]
The full output shows the reason directly:

  ERROR: '/mnt/scratch/042.img' is too small to make a usable filesystem
  ERROR: minimum size for each btrfs device is 114294784

And the helper _small_fs_size_mb() doesn't support btrfs, thus the small
25M file is not large enough to support a btrfs.

[FIX]
Fix the false alert by adding btrfs support in _small_fs_size_mb().

The btrfs minimal size is depending on the profiles even on a single
device, e.g. DUP data will cost extra space.

So here we go safe by using 512MiB as the minimal size for btrfs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/rc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/rc b/common/rc
index d8ee8328..2d8e7167 100644
--- a/common/rc
+++ b/common/rc
@@ -1195,6 +1195,11 @@ _small_fs_size_mb()
 		# it will change again. So just set it 128M.
 		fs_min_size=128
 		;;
+	btrfs)
+		# Minimal btrfs size depends on the profiles, for single device
+		# case, 512M should be enough.
+		fs_min_size=512
+		;;
 	esac
 	(( size < fs_min_size )) && size="$fs_min_size"
 
-- 
2.49.0


