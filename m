Return-Path: <linux-btrfs+bounces-5530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B725D9000D2
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 12:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAECB1C2278E
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6015B991;
	Fri,  7 Jun 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A01tmRVC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A01tmRVC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1D15D5C4
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756269; cv=none; b=AEYC+3kG9k845yUghi5J18u/LPpGGCdP81IscvQCZ+VwFJyoYbXGVtnUfcJ3Q05mQP/fpipAkXMQxuqKx89KDd/QUVM8Fg92t2Ern1j9jv/mVgVTCWfTRWApXUqEyn+jyHQ4ZAZQkT4lPorqqXVlGskAQSVkD3pbSt+dpECZDdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756269; c=relaxed/simple;
	bh=qG7PiUBwIAtJmyK30tazXFBgFhOOvnfZGr2LXmUaAkU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WwE4Viri1O7D6mFyYzinVxeNjXwMQKCXuhHn3CnEvZSsOXNMKKQU5r2XTALLAXtksUEpJKt+Q7MZDEN+ePqQwwJ4jm1UkzX4wS0T4Eu/qQripwcDBaVxnHTBorV4dEW+fZb6pweH4/kbHUb9JZhVYhFoK9loCBvkRCewq6+UXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A01tmRVC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A01tmRVC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C62D21B68
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 10:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717756265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8RoRO7EGzJuTrEpgvbh5DBVlpbll8S4HYvWeNrqu1nM=;
	b=A01tmRVCTbZq5u0F+tRyQHgeCydqRIMLpRInv4LrbYkPo4JusZJUknWG0YF3OQdo8ih6KD
	CiIETZjFbK+Ip+VmTIMwUXHNWq5TwgKSsERPz990PM6dWFMp4yP0LgCQiNO64Qe1HZXhOa
	JdamTkf0b3BaNpOUwEztTL22RNfTLiI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717756265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8RoRO7EGzJuTrEpgvbh5DBVlpbll8S4HYvWeNrqu1nM=;
	b=A01tmRVCTbZq5u0F+tRyQHgeCydqRIMLpRInv4LrbYkPo4JusZJUknWG0YF3OQdo8ih6KD
	CiIETZjFbK+Ip+VmTIMwUXHNWq5TwgKSsERPz990PM6dWFMp4yP0LgCQiNO64Qe1HZXhOa
	JdamTkf0b3BaNpOUwEztTL22RNfTLiI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 303C1133F3
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 10:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HlgtM2fhYmbtNQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 07 Jun 2024 10:31:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: do not use async discard for misc/004
Date: Fri,  7 Jun 2024 20:00:45 +0930
Message-ID: <5a292583be11ae383e79aaca0fa79be2141ef6ca.1717732459.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

[BUG]
There is a long long existing failure in my local VM that with any newer
kernel (6.x) the test case misc/004 would fail with ENOSPC during
balance:

    [TEST]   misc-tests.sh
    [TEST/misc]   004-shrink-fs
 failed: /home/adam/btrfs-progs/btrfs balance start -mconvert=single -sconvert=single -f /home/adam/btrfs-progs/tests/mnt
 test failed for case 004-shrink-fs
 make: *** [Makefile:547: test-misc] Error 1

[CAUSE]
With more testing, it turns out that just before the balance, the
filesystem still have several empty data block groups.

The reason is the new default discard=async behavior, as it also changes
the empty block groups to be async, this leave the empty block groups
there, resulting no extra space for the convert balance.

[FIX]
I do not understand why for loopback block devices we also enable
discard, but at least disable discard for the test case so that we can
ensure the empty block groups get cleaned up properly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/004-shrink-fs/test.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/misc-tests/004-shrink-fs/test.sh b/tests/misc-tests/004-shrink-fs/test.sh
index c7473649020e..4fb42a024b81 100755
--- a/tests/misc-tests/004-shrink-fs/test.sh
+++ b/tests/misc-tests/004-shrink-fs/test.sh
@@ -32,7 +32,9 @@ shrink_test()
 
 run_check truncate -s 20G "$IMAGE"
 run_check "$TOP/mkfs.btrfs" -f "$IMAGE"
-run_check $SUDO_HELPER mount "$IMAGE" "$TEST_MNT"
+# Disable the new default async discard, which makes empty block group cleanup
+# async.
+run_check $SUDO_HELPER mount -o nodiscard "$IMAGE" "$TEST_MNT"
 run_check $SUDO_HELPER chmod a+rw "$TEST_MNT"
 
 # Create 7 data block groups, each with a size of 1Gb.
-- 
2.45.2


