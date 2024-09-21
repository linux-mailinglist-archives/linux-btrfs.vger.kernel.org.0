Return-Path: <linux-btrfs+bounces-8150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C61997DB71
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Sep 2024 04:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5241C2139D
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Sep 2024 02:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B8C18028;
	Sat, 21 Sep 2024 02:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gZfV3X4y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gZfV3X4y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6423201
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726885614; cv=none; b=cfsf9ZoqRGPiTve9nR2Pu27VVPrEJO0V5U7sZsNlDIqqHZtZx6jCd6IKvg8R/kLbD0S+KfX7vVu233UOAPnU2Pff5OPY7gcJMlaty7GbrlXxPjVMo18ON91uZbfKdvvOpBtcWunNabus3VH8Aey0EvH1khkbQ3xJbrMUr+/jZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726885614; c=relaxed/simple;
	bh=VvzKM96OOWVdKfYvs1f65ccpMQHYEOg2Tnb2jjRKAKA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JE7qJAhVLoLyY7Omx9VdXGUC/VAfkTQrWBDuCvjPsrIJY1y5rpM4p9dA/cJRl/l4TPWpQJ4ztCM+q6WwI6KEOTtJm3SzjUXoiBxw6Zup5gmz5GlwV4g4V6Q8DLDU21cAdVvL4sdFri8crtXDsQaXbp0DBlvognwmdTtNI5qw4/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gZfV3X4y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gZfV3X4y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 941E61FCEC
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726885610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5W8/S3rzvCh9xzfwbXC9GNObKffN/NrUwizjrDHfqoc=;
	b=gZfV3X4yFpDqnGqtUA6hofUDnXWDEa1L9a3xi/EkatZ9POE/a9PDuGkCxn4hsq8JUPiE19
	SB1Z4rs0XETO5UbFU2bEQ/zwulx/QSouqTCo8ABUjuh16OzdIIxdP0OPyeNUdrVJFyQ6FJ
	cMuLF8rorUGOt7zCFdm2BfOus0r1gKA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726885610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5W8/S3rzvCh9xzfwbXC9GNObKffN/NrUwizjrDHfqoc=;
	b=gZfV3X4yFpDqnGqtUA6hofUDnXWDEa1L9a3xi/EkatZ9POE/a9PDuGkCxn4hsq8JUPiE19
	SB1Z4rs0XETO5UbFU2bEQ/zwulx/QSouqTCo8ABUjuh16OzdIIxdP0OPyeNUdrVJFyQ6FJ
	cMuLF8rorUGOt7zCFdm2BfOus0r1gKA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D173E13882
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KEvCJOku7malAQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: libbtrfsutil/python: use MANIFEST.in for headers
Date: Sat, 21 Sep 2024 11:56:24 +0930
Message-ID: <668010409411af3c06e2b6dda62f31fd9e54304d.1726885304.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1726885304.git.wqu@suse.com>
References: <cover.1726885304.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.74
X-Spamd-Result: default: False [-2.74 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.14)[-0.705];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
Currently with python3.12, the python bindding will always result the
following warning:

    [PY]     libbtrfsutil
/usr/lib/python3.12/site-packages/setuptools/_distutils/extension.py:134: UserWarning: Unknown Extension options: 'headers'
  warnings.warn(msg)

[CAUSE]
In the setup.py which specifies the files to be included into the package,
we use setuptools::Extension to specify the file lists and include paths.

But there is no handling of Extension::headers member, thus resulting the
above warning.

[FIX]
According to the docs of setuptools, MANIFEST.in is the file controlling
what files should be included.
So instead of the non-supported headers, use MANIFEST.in to include the
needed headers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 libbtrfsutil/python/MANIFEST.in | 1 +
 libbtrfsutil/python/setup.py    | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)
 create mode 100644 libbtrfsutil/python/MANIFEST.in

diff --git a/libbtrfsutil/python/MANIFEST.in b/libbtrfsutil/python/MANIFEST.in
new file mode 100644
index 000000000000..b613db8ea918
--- /dev/null
+++ b/libbtrfsutil/python/MANIFEST.in
@@ -0,0 +1 @@
+include btrfsutilpy.h
diff --git a/libbtrfsutil/python/setup.py b/libbtrfsutil/python/setup.py
index e0ffb7c52c5b..79c0b48dee7d 100755
--- a/libbtrfsutil/python/setup.py
+++ b/libbtrfsutil/python/setup.py
@@ -97,9 +97,6 @@ module = Extension(
         'qgroup.c',
         'subvolume.c',
     ],
-    headers=[
-        'btrfsutilpy.h'
-    ],
     include_dirs=['..'],
     library_dirs=['../..'],
     libraries=['btrfsutil'],
-- 
2.46.1


