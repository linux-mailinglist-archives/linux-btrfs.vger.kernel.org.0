Return-Path: <linux-btrfs+bounces-10725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F17A017CA
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2025 03:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1233A35EF
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2025 02:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FBB61FCE;
	Sun,  5 Jan 2025 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LWbrlMwP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LWbrlMwP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16E3200CB;
	Sun,  5 Jan 2025 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736042490; cv=none; b=Sd/dxZ9iw3ttwMA423O3uJq8nkzzPa0rN5ZqCZB9zENDZuMxjrNTps9DUyfoFyeam+VFXpfYZtt79RfWaUrCqnJ2/AT9rrB9Mq7AB2KISjjLuVBd2goC925YWyMuuZR6QzxJDqEXUfZFK9sTdNsVRs+g2KVj8rwnZ5FRN+RNpYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736042490; c=relaxed/simple;
	bh=mYNFHpQduswhlF8L2G5avj9ZUG7TUwfwL7OO2gWBp8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8M0GLQyRqOFpBhhFG+n1pZ7JEuvzdU+YwhXKh9earGKHCP048lKZn6RD5MuiEZ1muejFOK0NwTKuvNsEmHw/5Q/PBv7tbrRsnurbPU6otaZlc6wwXsFo7zi53F4hsrNJRZ2XcCkJ7w94ThIUzeIQWa+Pp5Yh4XcxU9/JxJ+Uiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LWbrlMwP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LWbrlMwP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AEB11F365;
	Sun,  5 Jan 2025 02:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736042484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0QmsxuVknufvUBnqqY/3eApyHc9wcBzqX1Xo0b3QPaA=;
	b=LWbrlMwPWhHNFEzsweyxQJg4uwUSu2KvwDrrCVUwpYMzGQFi0T88ZTUbPKgiCd7uBBckmW
	ZsJBAPsDd5M1VU5vxQ5VoJkRzTcQspzbBmSuZsYS3u+aqG3JWl5auEtEDfR0FB/Jz1TWhx
	lE+LqPQ6hN7siaSYscTO58qhdWTTWyE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736042484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0QmsxuVknufvUBnqqY/3eApyHc9wcBzqX1Xo0b3QPaA=;
	b=LWbrlMwPWhHNFEzsweyxQJg4uwUSu2KvwDrrCVUwpYMzGQFi0T88ZTUbPKgiCd7uBBckmW
	ZsJBAPsDd5M1VU5vxQ5VoJkRzTcQspzbBmSuZsYS3u+aqG3JWl5auEtEDfR0FB/Jz1TWhx
	lE+LqPQ6hN7siaSYscTO58qhdWTTWyE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D33613A30;
	Sun,  5 Jan 2025 02:01:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZJT5NvLneWeuVQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 05 Jan 2025 02:01:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: [PATCH] btrfs/326: update _fixed_by_kernel_commit
Date: Sun,  5 Jan 2025 12:31:01 +1030
Message-ID: <74d9b2816beb6ef245718331ebcbc1a7cdab5919.1736042456.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The original fix is already in the upstream, meanwhile a new but much
harder to hit bug is also exposed by this test case.

Add a new _fixed_by_kernel_commit for that bug, and special thanks to
Christian for pointing out the fix.

Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/326 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/326 b/tests/btrfs/326
index 528fee5e5685..1fc4db06b811 100755
--- a/tests/btrfs/326
+++ b/tests/btrfs/326
@@ -10,9 +10,14 @@
 . ./common/preamble
 _begin_fstest auto quick mount remount
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 951a3f59d268 \
 	"btrfs: fix mount failure due to remount races"
 
+# Another rare bug exposed by this test case where mnt_list list corruption or
+# extra kernel warning on MNT_ONRB flag is triggered.
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"fs: kill MNT_ONRB"
+
 _cleanup()
 {
 	cd /
-- 
2.47.1


