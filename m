Return-Path: <linux-btrfs+bounces-5782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6990C406
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 08:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DC01C2339F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21307175B;
	Tue, 18 Jun 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EM4r9zwJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EM4r9zwJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF21B813
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693479; cv=none; b=YoQABu6NZVwAHcdxZEsL3WZtMJz2gHGXoxxTulSPrN8IamTbAxFiyPqELBlWfHw7ABDr2vGA0+PE0C5ApCE9YJiR+cvHmlAylegbNuvuKpFhTbW/7ZhL3M33awtGjz7F8hybmA8TfOa5jEpBbeNwSau6ea75FxLclPM0Wq9/5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693479; c=relaxed/simple;
	bh=CNxnfNeXjv1PqwhvCh4O1l9b0GTx7x951s1SW7aE4nc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkZ4wYDq8QZ8sFBZjw3XCJu4iNhepEh0zYNz5JZHtN21t9qDqiDLLa3vWcnkmA0JkqwcF2hoZYeNsIxmpLEaDykroh5NDWVyFYYRHiyZg11G4NlNuWyrsDh9u62IjC/3O4Kw6VDvVMnlc9MS5I8gcHZlLq+UUNrcdjW7B2GzNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EM4r9zwJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EM4r9zwJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 319CD1FFD6
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718693475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3d6M1Vdj3qC5u8lGCo9YAS3/0rOdpREN/0QPqz02E0=;
	b=EM4r9zwJQv2hVwmqcaWyXTG7NEy42X3dWB+WrRr63PWGXdyBWYB0QoBwT3T4xPqvBj3HCw
	/UqIo732JTJaf7yGTXJGpYRaREWgccP6XXh9a+G2te+boSnGcUzqJsOpD+qCIiVxN5H7r7
	MrzMNlLA42SQfmiAHimFGoQRBzcleNQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718693475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3d6M1Vdj3qC5u8lGCo9YAS3/0rOdpREN/0QPqz02E0=;
	b=EM4r9zwJQv2hVwmqcaWyXTG7NEy42X3dWB+WrRr63PWGXdyBWYB0QoBwT3T4xPqvBj3HCw
	/UqIo732JTJaf7yGTXJGpYRaREWgccP6XXh9a+G2te+boSnGcUzqJsOpD+qCIiVxN5H7r7
	MrzMNlLA42SQfmiAHimFGoQRBzcleNQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 488B71369F
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wOk8AGIucWZ+ZQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:51:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: misc-tests: add a test case for basic csum conversion
Date: Tue, 18 Jun 2024 16:20:49 +0930
Message-ID: <5a92af80237ac06efc5223a9f42094d51404761b.1718693318.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718693318.git.wqu@suse.com>
References: <cover.1718693318.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.32
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.32 / 50.00];
	BAYES_HAM(-2.52)[97.84%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

The new test case would:

- Create a btrfs with crc32c csum
- Populate the fs
- Convert the fs to the following csums:
  * xxhash
  * blake2
  * sha256
  * crc32c

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../064-csum-conversion-basic/test.sh         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 tests/misc-tests/064-csum-conversion-basic/test.sh

diff --git a/tests/misc-tests/064-csum-conversion-basic/test.sh b/tests/misc-tests/064-csum-conversion-basic/test.sh
new file mode 100755
index 000000000000..2f8be0e9b324
--- /dev/null
+++ b/tests/misc-tests/064-csum-conversion-basic/test.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+#
+# Verify the csum conversion works as expected.
+#
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+check_experimental_build
+setup_root_helper
+prepare_test_dev
+
+convert_to_csum()
+{
+	local new_csum=$1
+
+	run_check "$TOP/btrfstune" --csum "$new_csum" "$TEST_DEV"
+	run_check "$TOP/btrfs" check --check-data-csum "$TEST_DEV"
+}
+
+run_check_mkfs_test_dev --csum crc32c
+
+# We only mount the fs once to populate its contents,
+# later one we would never mount the fs (to reduce the dependency on
+# kernel features).
+run_check_mount_test_dev
+populate_fs
+run_check_umount_test_dev
+
+convert_to_csum xxhash
+convert_to_csum blake2
+convert_to_csum sha256
+convert_to_csum crc32c
-- 
2.45.2


