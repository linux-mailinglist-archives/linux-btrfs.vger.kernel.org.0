Return-Path: <linux-btrfs+bounces-1462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132D82E841
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 04:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704501C22A92
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 03:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA43E79F0;
	Tue, 16 Jan 2024 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r44OAZJH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r44OAZJH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D7748F
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABE631FB62
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705375910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaVQxeV8O3UzZJYOFLLR/sgpKSsapQQLaFDebN4wTGs=;
	b=r44OAZJHugY3DR2uI18kgc/NqexWCRHYbrgbGZ2NPa47QBeTC9BnKmGswD5+LiaNGXhKo+
	7mOvKXNs3KneJNB1Uf38mJ6guK04C4xpWr5fuivq/N3G+O8/3oLb4TIv/DJy6G+7wv16pw
	H+JyGem5FoQ072hQYoV7kexHtDx2HRA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705375910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaVQxeV8O3UzZJYOFLLR/sgpKSsapQQLaFDebN4wTGs=;
	b=r44OAZJHugY3DR2uI18kgc/NqexWCRHYbrgbGZ2NPa47QBeTC9BnKmGswD5+LiaNGXhKo+
	7mOvKXNs3KneJNB1Uf38mJ6guK04C4xpWr5fuivq/N3G+O8/3oLb4TIv/DJy6G+7wv16pw
	H+JyGem5FoQ072hQYoV7kexHtDx2HRA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5B97132FA
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SI+aJKX4pWUKOgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: tests: enable strict chunk alignment check
Date: Tue, 16 Jan 2024 14:01:26 +1030
Message-ID: <34710605e3e80a3bd808c1c69bb878bab501c467.1705375819.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705375819.git.wqu@suse.com>
References: <cover.1705375819.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=r44OAZJH
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: ABE631FB62
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

The strict check is enabled for both check_image() and
convert_test_do_convert() to detect chunk alignment related problems.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common         | 2 ++
 tests/common.convert | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/common b/tests/common
index 771acaa339e8..1f880adead6d 100644
--- a/tests/common
+++ b/tests/common
@@ -441,6 +441,7 @@ check_image()
 
 	image=$1
 	echo "testing image $(basename $image)" >> "$RESULTS"
+	export BTRFS_PROGS_DEBUG_STRICT_CHUNK_ALIGNMENT=y
 	run_mustfail_stdout "btrfs check should have detected corruption"	\
 		"$TOP/btrfs" check "$image" &> "$tmp_output"
 
@@ -449,6 +450,7 @@ check_image()
 
 	run_check "$TOP/btrfs" check --repair --force "$image"
 	run_check_stdout "$TOP/btrfs" check "$image" &> "$tmp_output"
+	unset BTRFS_PROGS_DEBUG_STRICT_CHUNK_ALIGNMENT
 
 	# Also make sure no subpage related warnings for the repaired image
 	check_test_results "$tmp_output" "$testname"
diff --git a/tests/common.convert b/tests/common.convert
index 9b498ef29f1f..7d1d333895fa 100644
--- a/tests/common.convert
+++ b/tests/common.convert
@@ -147,9 +147,11 @@ convert_test_acl() {
 # $1: features, argument of -O, can be empty
 # $2: nodesize, argument of -N, can be empty
 convert_test_do_convert() {
+	export BTRFS_PROGS_DEBUG_STRICT_CHUNK_ALIGNMENT=y
 	run_check "$TOP/btrfs-convert" ${1:+-O "$1"} ${2:+-N "$2"} "$TEST_DEV"
 	run_check "$TOP/btrfs" check "$TEST_DEV"
 	run_check "$TOP/btrfs" inspect-internal dump-super -Ffa "$TEST_DEV"
+	unset BTRFS_PROGS_DEBUG_STRICT_CHUNK_ALIGNMENT
 }
 
 # post conversion check, verify file permissions.
-- 
2.43.0


