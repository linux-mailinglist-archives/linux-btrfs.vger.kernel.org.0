Return-Path: <linux-btrfs+bounces-5459-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F4E8FC016
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 01:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9C41F256D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 23:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A48214E2EF;
	Tue,  4 Jun 2024 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T1oT1Bfc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T1oT1Bfc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01014E2C0
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544658; cv=none; b=ZHXgCYU28IFmqVZXWF/qIUTchzXR9ve48xc7OGpIkb/LNhMtqTyiyowNafrxBKOhM3lJUE4QiCHh708dJnVU5dAE7T+M7FArnHGUeSlUldkPgjc+Ys9QrLxk3TQZ6P1Oyu5HpmYNYtI2+612gV/Ekgc8Wg8RzanteZY3X4kwbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544658; c=relaxed/simple;
	bh=AU0U8uXax637DNYZf5JFxjnMc97P0Q24tS0JZg5uh3A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6Pvtw0hxDEms+9tevnz5T3x6C+pk3HXSrnffdWzf466n0huPp2zzDzOu/w4k464cUHiyoUaPOoF/JCtVPs2uRrXhoIgRsLI+gQZimGM6xzY5YTzfihPbJkuOyf5hV+gYx0cBgwaC6PtnCrDHL2jN1rfWlBEt4xUCyjZ3R9xz+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T1oT1Bfc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T1oT1Bfc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 616411F45F
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 23:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717544654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4FFxuYc8HLx9kOGXiZRjId/uKkVlbQY7wVxt9GD5gM=;
	b=T1oT1BfcYMIPikCh2ehVHTVw4nkaEIiMB5PRewYO4ywuPhHsufIcbO8cvQdUHX6QvXOZLg
	JW3EQbvwWfBqyYjtu+39bUmrJ1/T4b5t/4PsY7FOf+MYqDjgzPfHfHCB25DRbAZ3+4DYgj
	ODhKq7+6AXYLkQj60UJQ3hZ01ag3TUA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717544654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4FFxuYc8HLx9kOGXiZRjId/uKkVlbQY7wVxt9GD5gM=;
	b=T1oT1BfcYMIPikCh2ehVHTVw4nkaEIiMB5PRewYO4ywuPhHsufIcbO8cvQdUHX6QvXOZLg
	JW3EQbvwWfBqyYjtu+39bUmrJ1/T4b5t/4PsY7FOf+MYqDjgzPfHfHCB25DRbAZ3+4DYgj
	ODhKq7+6AXYLkQj60UJQ3hZ01ag3TUA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E97E13A93
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 23:44:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SDa/CM2mX2bcJwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 23:44:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs-progs: fix misc/038 test cases
Date: Wed,  5 Jun 2024 09:13:44 +0930
Message-ID: <909e5e66fdbb40c9afe59175a0ed73741b8e22c8.1717544015.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1717544015.git.wqu@suse.com>
References: <cover.1717544015.git.wqu@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
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

Furthermore on the github CI, the kernel would commit 2 instead of 1
transaction, resulting the next slot never to match the current
generation/tree root.

The two bugs combined, resulting github CI always pass the test case,
meanwhile for my VM which does the expected one transaction, it would
always fail.

Fix it by:

- Use a proper "if [] then; fi" block to check the tree root bytenr
- Use the generation diff to calculate the expected backup root slot
- Log the full super block dump for debug usage

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../038-backup-root-corruption/test.sh           | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
index 9be0cee36239..28aa5baec91e 100755
--- a/tests/misc-tests/038-backup-root-corruption/test.sh
+++ b/tests/misc-tests/038-backup-root-corruption/test.sh
@@ -41,6 +41,9 @@ slot_num=$(echo $found | cut -f1 -d:)
 # To follow the dump-super output, where backup slot starts at 0.
 slot_num=$(($slot_num - 1))
 
+_log "Original superblock:"
+_log "$(dump_super)"
+
 # Save the backup slot info into the log
 _log "Backup slot $slot_num will be utilized"
 dump_super | run_check grep -A9 "backup $slot_num:"
@@ -56,9 +59,14 @@ run_check_mount_test_dev -o usebackuproot
 run_check_umount_test_dev
 
 main_root_ptr=$(dump_super | awk '/^root\t/{print $2}')
-
-# The next slot should be overwritten
-slot_num=$(( ($slot_num + 1) % 4 ))
+cur_gen=$(dump_super | grep ^generation | awk '{print $2}')
+# The slot to be used is based on how many transaction committed.
+slot_num=$(( ($slot_num + $cur_gen - $backup_gen) % 4 ))
 backup_new_root_ptr=$(dump_super | grep -A1 "backup $slot_num" | grep backup_tree_root | awk '{print $2}')
 
-[ "$main_root_ptr" -ne "$backup_new_root_ptr" ] || _fail "Backup 2 not overwritten"
+_log "After the backup usage:"
+_log "$(dump_super)"
+
+if [ "$main_root_ptr" -ne "$backup_new_root_ptr" ]; then
+	_fail "Backup ${slot_num} not overwritten"
+fi
-- 
2.45.2


