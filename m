Return-Path: <linux-btrfs+bounces-15795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D436B189E3
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 02:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC131C849F3
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 00:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C7B1CF96;
	Sat,  2 Aug 2025 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RT6bfets";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RT6bfets"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBBD13AC1
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754094404; cv=none; b=ibxHW7033ir9DaAQiw4uaAfv/TolcE6R6/TfBP1Z62Z8y24ppjNdtC5xUpxAi0kaiJvpHYIf5iVM5ykb4sH2Omlw1++wYsnb0KAvtSw5fc4byvu7YxfpI0IDD2UzwMLIqVF0hs3jDD3RrTHhQr5aHYTktJr+sswEMIDKQJecUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754094404; c=relaxed/simple;
	bh=dvlMLZQl5cveQdI1iVdIlCJyWsX5/nI8Qj4+5bwQrsA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qckpzqmJt90xco8LB8aSSIBi1elDXCljCG6RpCri0R4fnzScImZRY3oz5uWa2qj/S+gVtuQtiyurfEsvekYf2xdQteBsvii7PQrdhKNLLeNikCf2U/7Hvao+eb8UI8Z7w6YkudxceRAYc1YwqjaufGVI6du+56N3g5XAGsLyhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RT6bfets; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RT6bfets; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2151221A1C
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 00:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754094400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbIuOw1VEqiFuwziJIBdjwdz6w6d2/fKAAZ+fPPBdZw=;
	b=RT6bfets2C71V0XlNLRp+sBtAu8CyJ6KEhZUozedi8/OZB5KiDeR1Bt6ByuupOt+VF7nOF
	1qHhGAoCGl9yqhExir2aSrZW0/3JaHq2Cv0jhtZ+CwqxywbZHDrWxx6F0C7fZ34UZ/he0i
	lSp/x0U4xxpIs7U+qVq+l+RPsmV2tt8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RT6bfets
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754094400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbIuOw1VEqiFuwziJIBdjwdz6w6d2/fKAAZ+fPPBdZw=;
	b=RT6bfets2C71V0XlNLRp+sBtAu8CyJ6KEhZUozedi8/OZB5KiDeR1Bt6ByuupOt+VF7nOF
	1qHhGAoCGl9yqhExir2aSrZW0/3JaHq2Cv0jhtZ+CwqxywbZHDrWxx6F0C7fZ34UZ/he0i
	lSp/x0U4xxpIs7U+qVq+l+RPsmV2tt8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E44E133D1
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 00:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CLV7CD9bjWjnPAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 02 Aug 2025 00:26:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: fsck-tests: make the warning check more specific for 057
Date: Sat,  2 Aug 2025 09:56:19 +0930
Message-ID: <db091c4349afbb846ab54567288e8d167a728563.1754090561.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754090561.git.wqu@suse.com>
References: <cover.1754090561.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2151221A1C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

[BUG]
On older kernels without the fix ae4477f93756 ("btrfs: update
superblock's device bytes_used when dropping chunk"), the test case 057
will result super block device item to mismatch with the chunk one.

Normally this is not a big deal, but newer btrfs-progs will check for
such mismatch.
Although newer btrfs-progs won't report this as an error, the test case
fsck/057 will manually check for any warnings, and fail the test case:

  ====== RUN CHECK /home/runner/work/btrfs-progs/btrfs-progs/btrfs check /dev/loop1
  [1/8] checking log skipped (none written)
  [2/8] checking root items
  [3/8] checking extents
  WARNING: device 2's bytes_used was 503316480 in tree but 570425344 in superblock
  [4/8] checking free space tree
  [5/8] checking fs roots
  [6/8] checking only csums items (without verifying data)
  [7/8] checking root refs
  [8/8] checking quota groups skipped (not enabled on this FS)
  Opening filesystem to check...
  Checking filesystem on /dev/loop1
  UUID: efd3e3b9-2fac-4a6f-b378-34694dc2d446
  found 147456 bytes used, no error found
  total csum bytes: 0
  total tree bytes: 147456
  total fs tree bytes: 32768
  total extent tree bytes: 16384
  btree space waste bytes: 139992
  file data blocks allocated: 0
   referenced 0

That WARNING line will fail the test case, even if we didn't error out.

[CAUSE]
The test case itself is a test case for btrfs-progs commit 0dc8b8b6a414
("btrfs-progs: check: fix wrong total bytes check for seed device"),
which will report minor warning like the following:

  [2/7] checking extents
  WARNING: minor unaligned/mismatch device size detected
  WARNING: recommended to use 'btrfs rescue fix-device-size' to fix it

But in this particular case, 057 should only check for the related
wanrings, not something caused by the kernel.

[FIX]
Make the warning check in fsck/057 more specific, instead of "WARNING"
use "fix-device-size" as the keyword.

This is an unfortunate workaround for the CI kernels, which doesn't have
fast enough backport of upstream kernel fixes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/fsck-tests/057-seed-false-alerts/test.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/fsck-tests/057-seed-false-alerts/test.sh b/tests/fsck-tests/057-seed-false-alerts/test.sh
index edf160fab348..2d491e1fbaf5 100755
--- a/tests/fsck-tests/057-seed-false-alerts/test.sh
+++ b/tests/fsck-tests/057-seed-false-alerts/test.sh
@@ -35,13 +35,13 @@ sprouted_output=$(_mktemp btrfs-progs-sprouted-check-stdout.XXXXXX)
 run_check_stdout $SUDO_HELPER "$TOP/btrfs" check "$dev1" >> "$seed_output"
 run_check_stdout $SUDO_HELPER "$TOP/btrfs" check "$dev2" >> "$sprouted_output"
 
-# There should be no warning for both seed and sprouted fs
-if grep -q "WARNING" "$seed_output"; then
+# There should be no warning about the device size for both seed and sprouted fs
+if grep -q "fix-device-size" "$seed_output"; then
 	cleanup_loopdevs
 	rm -f -- "$seed_output" "$sprouted_output"
 	_fail "false alerts detected for seed fs"
 fi
-if grep -q "WARNING" "$sprouted_output"; then
+if grep -q "fix-device-size" "$sprouted_output"; then
 	cleanup_loopdevs
 	rm -f -- "$seed_output" "$sprouted_output"
 	_fail "false alerts detected for sprouted fs"
-- 
2.50.1


