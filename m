Return-Path: <linux-btrfs+bounces-7783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCDA969573
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2CC280A10
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6439820011E;
	Tue,  3 Sep 2024 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NMa+Tggf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NMa+Tggf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8E1DAC75
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348574; cv=none; b=ps01CHml6FQ/GnjYiveZPiAI/q7PnRTeSc2kStsoTTI14hUWRTW73FZvg7lafBbWMgYrBgYl/isAaOaTiSLIoZvjfLyjGo0CVJkY18yEXsAKvg7TKqOggxwaKzbTrq2RLyhs4hVTX8qYg8XqgVRYRXoXQZW+g3wEKrRxuHhm/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348574; c=relaxed/simple;
	bh=+Z7CH9mZp0NktwpUoLUfi2rmlUiwBwVGKPEGSTrk6TI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElSlHjQxLzP1URc+30Wv/3BODD7CknBnohwsA6sJT+4nclcwnPAEtlwHi3INOSNMbZ1h3bLX9uJ0mexA/ky7rVwte0FYcZ9ZMpDmFEmS03lNiX9k93IO4w1DtyTAiZHw1pZyWBNR+GuBl0uoEogJ4k5u7Yomtw4sWOIxrUyVmRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NMa+Tggf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NMa+Tggf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EAC71FCF0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725348570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZjnjnMKIDk8n6pMeBglt/owzdcB/3QiKV0j/LoUDSY=;
	b=NMa+Tggfk0vfqO2L8DjLMakrTlPmuF2xLo4v89qCubfA4DFdrjISs+SWvE35qCY5Ob/YDO
	E3E5JBYCIiXXiNIEHZ3jyxLRhtGE+AXz3Z03pryfuCjONRAZZ8qMVJN5ZLer8m0B8BqoRU
	GOrDCS53DZjnK2PFlS83bxIR1i432/M=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725348570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZjnjnMKIDk8n6pMeBglt/owzdcB/3QiKV0j/LoUDSY=;
	b=NMa+Tggfk0vfqO2L8DjLMakrTlPmuF2xLo4v89qCubfA4DFdrjISs+SWvE35qCY5Ob/YDO
	E3E5JBYCIiXXiNIEHZ3jyxLRhtGE+AXz3Z03pryfuCjONRAZZ8qMVJN5ZLer8m0B8BqoRU
	GOrDCS53DZjnK2PFlS83bxIR1i432/M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D55313A52
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cBZiCNm61mY2TwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 07:29:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: convert-tests: add a test case to verify large symbol link handling
Date: Tue,  3 Sep 2024 16:59:02 +0930
Message-ID: <715a310387bb3138bd0e41809e21bfef3825df1d.1725348299.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725348299.git.wqu@suse.com>
References: <cover.1725348299.git.wqu@suse.com>
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
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

The new test case will:

- Create a symbol which contains a 4095 bytes sized target on ext4

- Convert the ext4 to btrfs

- Make sure we can still read the symbol link
  For unpatched btrfs-convert, the resulted symbol link will be rejected
  by kernel and fail.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../027-large-symbol-link/test.sh             | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100755 tests/convert-tests/027-large-symbol-link/test.sh

diff --git a/tests/convert-tests/027-large-symbol-link/test.sh b/tests/convert-tests/027-large-symbol-link/test.sh
new file mode 100755
index 000000000000..85f7329a86d2
--- /dev/null
+++ b/tests/convert-tests/027-large-symbol-link/test.sh
@@ -0,0 +1,33 @@
+#!/bin/bash
+# Make sure btrfs-convert can handle a symbol link which is 4095 bytes large
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+setup_root_helper
+prepare_test_dev 1G
+check_global_prereq mkfs.ext4
+
+link_target=""
+
+# Soft link in btrfs can only have inlined data extent.
+# So here we create a symbol link whose target is 4095 bytes length.
+for ((i = 0; i < 4095; i++)); do
+	link_target+="b"
+done
+
+convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
+run_check $SUDO_HELPER ln -s "$link_target" "$TEST_MNT/symbol_link"
+run_check_umount_test_dev
+
+# For unpatched btrfs-convert, it will always append one byte to the
+# link target, causing above 4095 target to be 4096, exactly one sector,
+# resulting a regular file extent.
+convert_test_do_convert
+
+run_check_mount_test_dev
+# If the unpatched btrfs-convert created a regular extent, and the kernel is
+# newer enough, such readlink will be rejected by kernel.
+run_check $SUDO_HELPER readlink "$TEST_MNT/symbol_link"
+run_check_umount_test_dev
+
-- 
2.46.0


