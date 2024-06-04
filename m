Return-Path: <linux-btrfs+bounces-5434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0FA8FAA5F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 08:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CCD289E06
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 06:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EA5136E2B;
	Tue,  4 Jun 2024 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="erBhpvPb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="erBhpvPb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0612913
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480825; cv=none; b=lxtwcYJrN91t0+GURQ3vAuGlhvlkpxW4qW7omP7XK+gcQV+UTTVC4PkhJeMG5B7Zcm/Qjr0AMdEho42lwOzU5ZPCzVCPatdN06g0FMrgjEuqXa1po/pJTBrNUilv/YE5eIduxhu6KSmzsyGnd4t79JGFrOUGUS+gW9BRfwngyDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480825; c=relaxed/simple;
	bh=X+uDLum0dloIEyXMVzwP+Ylm+qWsBc2sYT5qhIRzr+A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hHceylByZwY69HEt757g4V7Ohr2a3j1jyD0ifWhHksK1ZFhuByfCJ/E+ocObWVcc2sm37m6R0zPfHw+XuFNnnfLNuQQO7JgzQaOw2amtXxltQYBc1Tsrw4T6sg9OqGka8o/ge3M9c0vtO0IiL2qsR3p+IP5d/hwd+ydDLrjiE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=erBhpvPb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=erBhpvPb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BC7A21A12
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 06:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717480819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VrYK12Zo+8YpqVWkYzbvh2bimu2BXt3LxuhKK7hLpPk=;
	b=erBhpvPb2kN8KB8j4pCu5sZbmY8sIRab7qAL4CUWEbDQu4BEpw3v92i+ghO6yTONcql0Zt
	P7mPBGytxLzJGoaNakJDQCRvY3AC+uN1aY1QHKuHYMHUjdhtZQNN8WZsjJwb1BoBV2+xOw
	Oja69sYMmwd90CUe0CQfR6Qq0rcmRfw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717480819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VrYK12Zo+8YpqVWkYzbvh2bimu2BXt3LxuhKK7hLpPk=;
	b=erBhpvPb2kN8KB8j4pCu5sZbmY8sIRab7qAL4CUWEbDQu4BEpw3v92i+ghO6yTONcql0Zt
	P7mPBGytxLzJGoaNakJDQCRvY3AC+uN1aY1QHKuHYMHUjdhtZQNN8WZsjJwb1BoBV2+xOw
	Oja69sYMmwd90CUe0CQfR6Qq0rcmRfw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 442A313A93
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 06:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KRGLAHKtXma0ZwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 06:00:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix a check condition in misc/038
Date: Tue,  4 Jun 2024 15:30:00 +0930
Message-ID: <a49e6b43e3c140995567fea035017309b4bcd53c.1717480797.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.67
X-Spam-Level: 
X-Spamd-Result: default: False [-1.67 / 50.00];
	BAYES_HAM(-1.87)[94.25%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

The test case always fail in my VM, with the following error:

 $ sudo TEST=038\* make test-misc
    [TEST]   misc-tests.sh
    [TEST/misc]   038-backup-root-corruption
 Backup 2 not overwritten
 test failed for case 038-backup-root-corruption

After more debugging, the it turns out that there is nothing wrong
except the final check:

 [ "$main_root_ptr" -ne "$backup_new_root_ptr" ] || _fail "Backup 2 not overwritten"

The _fail() is only triggered if the previous check returns false, which
is completely the opposite.

In fact the "[ check ] || _fail" pattern is the worst thing in the bash
world, super easy to cause the opposite check condition.

Fix it by use a proper "if []; then fi" block, and since we're here also
update the error message to use the newest slot number instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/038-backup-root-corruption/test.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
index 9be0cee36239..0f97577849cc 100755
--- a/tests/misc-tests/038-backup-root-corruption/test.sh
+++ b/tests/misc-tests/038-backup-root-corruption/test.sh
@@ -61,4 +61,6 @@ main_root_ptr=$(dump_super | awk '/^root\t/{print $2}')
 slot_num=$(( ($slot_num + 1) % 4 ))
 backup_new_root_ptr=$(dump_super | grep -A1 "backup $slot_num" | grep backup_tree_root | awk '{print $2}')
 
-[ "$main_root_ptr" -ne "$backup_new_root_ptr" ] || _fail "Backup 2 not overwritten"
+if [ "$main_root_ptr" -ne "$backup_new_root_ptr" ]; then
+	_fail "Backup ${slot_num} not overwritten"
+fi
-- 
2.45.2


