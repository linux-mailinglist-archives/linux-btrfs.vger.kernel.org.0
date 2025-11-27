Return-Path: <linux-btrfs+bounces-19373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DA7C8D1FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 08:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A263B1A83
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 07:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4AB3203BC;
	Thu, 27 Nov 2025 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tdDUR0Ve";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tdDUR0Ve"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140413203A0
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228822; cv=none; b=UYEB2wKv+ienDv59/0xRwmCt3vxsbgVOLV/d9Mvm5yt+QWIpq6LT8j14pveaSQyh8zUxwA1xKt+mCWN/mkEvLLUXlla2KsyEqZbBpSzX7PIiOllDvbKNiOjkUs66yzrHWSVK+o1slTex+EqO1N6YBsoqwMMEkasgxC75vatQ1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228822; c=relaxed/simple;
	bh=AlS7Ld/DzCvq7OFplFaluh6R+WphrhuxY8oXZDLIZBk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUkqXWWt5Xhc+YXuNhWQd/z0ARwVnW4zbXXtktjPD08XgZgnDHP3oS6e/myqcpUCABez6xQpkJmkT4HhBhySL3Dz20Mw3vs/4QH66OQJqxpxxQfjBLdXZqhJbuQ/a3RCkW2ghuyon4Z9UTbeIVjiKcxr0ibf4UPBSvnyG/jb+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tdDUR0Ve; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tdDUR0Ve; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 130895BCE8
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764228818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoGtsfZaSTQTCg60WNqfwBDQ4Znhe22iSIMvrMt60Hg=;
	b=tdDUR0VeB6v/U1MNtWQ33cprCpuEDIVJXEsSMm72nbHkKYf65D6AiowN10h3WFYwAC7VEt
	iYveT9l1JQxWkkrcfH6xYmYibr5hGdDb4xoLLEel3TozoqsML53B6p2EF7Zk4/zRnCaaMb
	lYdTKgSTuBJgeKBy+zGX8/P8KMs2OVg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tdDUR0Ve
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764228818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoGtsfZaSTQTCg60WNqfwBDQ4Znhe22iSIMvrMt60Hg=;
	b=tdDUR0VeB6v/U1MNtWQ33cprCpuEDIVJXEsSMm72nbHkKYf65D6AiowN10h3WFYwAC7VEt
	iYveT9l1JQxWkkrcfH6xYmYibr5hGdDb4xoLLEel3TozoqsML53B6p2EF7Zk4/zRnCaaMb
	lYdTKgSTuBJgeKBy+zGX8/P8KMs2OVg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52B1C3EA65
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CI3nBdH+J2nlcgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs-progs: misc-tests: check if free space tree is enabled after mount
Date: Thu, 27 Nov 2025 18:03:16 +1030
Message-ID: <8cd5e7a6497b3f590496ee23e00eeae914ae1980.1764228560.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764228560.git.wqu@suse.com>
References: <cover.1764228560.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 130895BCE8

For bs < ps cases, a mount will always enable free-space-tree due to the
limitation of v1 space cache.

Test case misc/057 will lead to false failure if the page size is larger
than the default 4K sector size.

Add an extra check on free-space-tree after fs population, and skip the
test case if so.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/057-btrfstune-free-space-tree/test.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
index 8d9a858ddc2f..8f6bcb8fc5b7 100755
--- a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
+++ b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
@@ -17,6 +17,14 @@ run_check_mount_test_dev
 populate_fs
 run_check_umount_test_dev
 
+# Check if the fs has free space tree already. Currently bs < ps mount
+# will always enable free-space-tree (no support for v1 free space cache)
+if run_check_stdout "$TOP/btrfs" inspect-internal dump-super "$TEST_DEV" |\
+	grep -q "FREE_SPACE_TREE"; then
+	_not_run "free-space-tree is always enabled for page size $(getconf PAGESIZE)"
+fi
+
 run_check $SUDO_HELPER "$TOP/btrfstune" --convert-to-free-space-tree "$TEST_DEV"
 
+
 run_check "$TOP/btrfs" check "$TEST_DEV"
-- 
2.52.0


