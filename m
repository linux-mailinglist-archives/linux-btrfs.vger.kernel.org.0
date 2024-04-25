Return-Path: <linux-btrfs+bounces-4551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367A88B2D64
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 01:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BB428307D
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Apr 2024 23:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F47B156242;
	Thu, 25 Apr 2024 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oT3WMa05";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oT3WMa05"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47045155A39
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714086047; cv=none; b=r7AxVTsGO56xq9pBLK2Fnnba5Q1fBJQHsGJ184xQmNCPEnVnWQ0hdrGe1PaGvf4iJ52lGDmmnsMkHfPmx81O8EZhkGpHyau8gvdWVE6vAfmlY2oW3zyz+/kY+REi8K3Ic2UOMuo41jw/YCD8goQtz53MLZxqaG8eh9KROW6/8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714086047; c=relaxed/simple;
	bh=/d+QrRjz9pfcZJA13IlKnumxuLKfupX0Mttd2y9VLE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y4TWZrz9uY53Ie+9xdls8do4g6xbWihploTsCACfyl7ZtxSZYCCxOzZGL4SXQcO9vjXgMJ8g+BSQuTqiQeDyMTLO9R79L2lxuoGmISXZumVnam6lvO0fbgi4LahzV3radOEb77SE2ZFP6hhkX5pp6M/tT/cBW2mlNkYjlW0Gpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oT3WMa05; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oT3WMa05; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F4E522671
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714086042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C8Bl2utuV+9CBgLCvK0hoO2OXa6uwH7AK12RQJN6Uww=;
	b=oT3WMa05e2ykN5e2kuixd7YJ0pfkFDRLzD6AANJ8cGnatJGP8j2qhxUGerV8e2feDEQNOc
	My8rdwwpECuVLtnXw5X9p+eYf7ofhXg86A4fDkdu2OASIl7tW/KlqH4vxCTiPZKup8JsD1
	5zevqdLtSA0dGjrJ/CmRvbsDpRXK/cA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714086042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C8Bl2utuV+9CBgLCvK0hoO2OXa6uwH7AK12RQJN6Uww=;
	b=oT3WMa05e2ykN5e2kuixd7YJ0pfkFDRLzD6AANJ8cGnatJGP8j2qhxUGerV8e2feDEQNOc
	My8rdwwpECuVLtnXw5X9p+eYf7ofhXg86A4fDkdu2OASIl7tW/KlqH4vxCTiPZKup8JsD1
	5zevqdLtSA0dGjrJ/CmRvbsDpRXK/cA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 688B213991
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 23:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kxM7BpngKmZXBQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 23:00:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix documentation build due to phony contents.rst
Date: Fri, 26 Apr 2024 08:30:22 +0930
Message-ID: <8018c8dd90b26bcf9bdf1d76d731022b85147be1.1714086020.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[BUG]
Since commit 8049446bb0ba ("btrfs-progs: docs: placeholder for
contents.rst file on older sphinx version"), on systems with much newer
sphinx-build, "make" would not work for Documentation directory:

 $ make clean-all && ./autogen.sh && ./configure --prefix=/usr/ && make -j12
 $ ls -alh Documentation/_build
 ls: cannot access 'Documentation/_build': No such file or directory

The sphinx-build has a much newer version:

 $ sphinx-build --version
 sphinx-build 7.2.6

[CAUSE]
On systems which doesn't need the workaround, the phony target of
contents.rst seems to cause a dependency loop:

 GNU Make 4.4.1
 Built for x86_64-pc-linux-gnu
 Copyright (C) 1988-2023 Free Software Foundation, Inc.
 License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>
 This is free software: you are free to change and redistribute it.
 There is NO WARRANTY, to the extent permitted by law.
 Reading makefiles...
 Reading makefile 'Makefile'...
 Updating makefiles....
  Considering target file 'Makefile'.
   Looking for an implicit rule for 'Makefile'.
    Trying pattern rule '%:' with stem 'Makefile'.
   Found implicit rule '%:' for 'Makefile'.
  Finished prerequisites of target file 'Makefile'.
  No need to remake target 'Makefile'.
 Updating goal targets....
 Considering target file 'contents.rst'.
  File 'contents.rst' does not exist.
 Finished prerequisites of target file 'contents.rst'.
 Must remake target 'contents.rst'.
 Makefile:35: update target 'contents.rst' due to: target is .PHONY
 if [ "$(sphinx-build --version | cut -d' ' -f2)" \< "1.7.7" ]; then \
 	touch contents.rst; \
 fi
 Putting child 0x64ee81960130 (contents.rst) PID 66833 on the chain.
 Live child 0x64ee81960130 (contents.rst) PID 66833
 Reaping winning child 0x64ee81960130 PID 66833
 Removing child 0x64ee81960130 PID 66833 from chain.
 Successfully remade target file 'contents.rst'.

All the default make doing is just try to generate contents.rst, but
since we have much newer version, we won't generate the file at all.

[FIX]
Instead of a phony target, just move the contents.rst generation into
man page target so that we won't cause loop target on contents.rst.

Fixes: 8049446bb0ba ("btrfs-progs: docs: placeholder for contents.rst file on older sphinx version")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/Makefile.in | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/Makefile.in b/Documentation/Makefile.in
index b4c09dcc255a..76e0cbbc242f 100644
--- a/Documentation/Makefile.in
+++ b/Documentation/Makefile.in
@@ -28,19 +28,16 @@ man5dir = $(mandir)/man5
 man8dir = $(mandir)/man8
 
 .PHONY: all man help
-.PHONY: contents.rst
+
+# Build manual pages by default
+all: man
 
 # Workaround for old sphinx that requires the contents.rst file
-contents.rst:
+man:
 	@if [ "$$(sphinx-build --version | cut -d' ' -f2)" \< "1.7.7" ]; then \
 		touch contents.rst; \
 	fi
 
-# Build manual pages by default
-
-all: man
-
-man:
 	$(QUIET_SPHINX)$(SPHINXBUILD) -M man "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
 
 help:
-- 
2.44.0


