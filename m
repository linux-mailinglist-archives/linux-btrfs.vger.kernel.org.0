Return-Path: <linux-btrfs+bounces-5693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C388905FB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 02:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B10283FDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 00:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074E8F4E;
	Thu, 13 Jun 2024 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VHvwqRgk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VHvwqRgk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC70522E
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238239; cv=none; b=LPsqE6/acpOlDHrvT58YXk077mbmf8I1rl+qyXjNwCcYL2z6AwRF2w2Eb+ntT5zOgfy9Xc3AAPY5VSX/yubMOlausVBz+VlWbClGlBdtEqtRyeNMFsf1SZyAfCnNFVnKf/7XaNVFRcHPaogj0MzN1ExUDSvCF9vTm1aRmleLPWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238239; c=relaxed/simple;
	bh=CK9wyzaGIZJ/uZ1QepMOO4D/eiJTgBiFi2WvkW5NDx8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI9Jw4vXN/Tu+Dawp9Q1uj8NePeuEByotVWUpWfphmumxcOawDVviXd+zA62RDhlKtUEiKqLHeggiBcuY2E9nwQefSgz2/nCmWBIUirz/1RO4yOgzo17eYnut3jC2zRMoBeMvLAGYu3AWTNW/ZRRD+B0BYSkRAhwn2Xla4/oxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VHvwqRgk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VHvwqRgk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 558F75CA10
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718238235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XEpMLnWFv1AluBDKGiBCSm1uarJDsx3gEpA+TyD13o=;
	b=VHvwqRgkJi3pOZnsyw6qSmh7sYkUqgGxYdMhzRSMon1pbUIProp1jiSxRtXEtL3QoYLYfk
	lH5BYWvS0vA9LleF1neZK4VUM0+JFRUFpaW9WR8it9HII+cXfgQ8tAeT24TdnY3yMulAF9
	WLLgsaeVu3d4C3sUX9iU0kcCC3K1t8I=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VHvwqRgk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718238235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XEpMLnWFv1AluBDKGiBCSm1uarJDsx3gEpA+TyD13o=;
	b=VHvwqRgkJi3pOZnsyw6qSmh7sYkUqgGxYdMhzRSMon1pbUIProp1jiSxRtXEtL3QoYLYfk
	lH5BYWvS0vA9LleF1neZK4VUM0+JFRUFpaW9WR8it9HII+cXfgQ8tAeT24TdnY3yMulAF9
	WLLgsaeVu3d4C3sUX9iU0kcCC3K1t8I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 631B413A7F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WO1vOxk8amY9YQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: mkfs-tests: ensure regular builds won't enable rst feature
Date: Thu, 13 Jun 2024 09:53:25 +0930
Message-ID: <48ce67476f6674725c5e87e25373d8e86df0cb46.1718238120.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718238120.git.wqu@suse.com>
References: <cover.1718238120.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 558F75CA10
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Spam-Level: 

This test case will check the following behaivors:

- Regular zoned supported data/metadata profiles
  Should success

- RST with zoned feature
  Should fail for non-experimental builds

- zoned with data profiles that only RST supports
  Should fail for non-experimental builds.

  Meanwhile for experimental builds it should success and enable RST
  feature automatically (verified in mkfs/030)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common                                  |  7 ++++
 tests/mkfs-tests/033-zoned-reject-rst/test.sh | 34 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100755 tests/mkfs-tests/033-zoned-reject-rst/test.sh

diff --git a/tests/common b/tests/common
index e9456c1d96b8..12ec1ad92b85 100644
--- a/tests/common
+++ b/tests/common
@@ -392,6 +392,13 @@ check_experimental_build()
 	fi
 }
 
+check_regular_build()
+{
+	if _test_config "EXPERIMENTAL"; then
+		_not_run "This test requires non-experimental build"
+	fi
+}
+
 check_prereq()
 {
 	# Internal tools for testing, not shipped with the package
diff --git a/tests/mkfs-tests/033-zoned-reject-rst/test.sh b/tests/mkfs-tests/033-zoned-reject-rst/test.sh
new file mode 100755
index 000000000000..698551eccd59
--- /dev/null
+++ b/tests/mkfs-tests/033-zoned-reject-rst/test.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+# Verify mkfs for all currently supported profiles of zoned + raid-stripe-tree
+
+source "$TEST_TOP/common" || exit
+
+check_regular_build
+setup_root_helper
+setup_nullbdevs 4 128 4
+prepare_nullbdevs
+TEST_DEV=${nullb_devs[1]}
+
+profiles="dup raid1 raid1c3 raid1c4 raid10"
+
+# The existing supported profiles.
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d single -m single "${nullb_devs[@]}"
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d single -m DUP "${nullb_devs[@]}"
+
+# RST feature is rejected
+run_mustfail "RST feature created" \
+	$SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned,raid-stripe-tree -d single -m DUP "${nullb_devs[@]}"
+
+for dprofile in $profiles; do
+	# make sure extra data profiles won't enable RST for non-experimental build
+	run_mustfail "unsupported profile created" \
+		$SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d "$dprofile" -m DUP "${nullb_devs[@]}"
+done
+
+# The old unsupported profiles should fail no matter experimental build or not.
+run_mustfail "unsupported profile raid56 created" \
+	$SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d raid5 -m raid5 "${nullb_devs[@]}"
+run_mustfail "unsupported profile raid56 created" \
+	$SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d raid6 -m raid6 "${nullb_devs[@]}"
+
+cleanup_nullbdevs
-- 
2.45.2


