Return-Path: <linux-btrfs+bounces-6557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301779370AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88EA1F2154D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 22:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BDD145A18;
	Thu, 18 Jul 2024 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LWnbs9aD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Jr7XElzr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37DF1B86F2
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342025; cv=none; b=CDsLQMNP/6296NaS4uvI4FusfoMu5DAzb7L2s3409zNU+ksyOGDnllcvdhj3Mff87wksFnDxWuvp+nhshEgIuuTttye3IIvs+WK6UzCcirPrz0fsNj3HB4799S7l87VdeHpOg+6JKgXENg5UQdp9Vsl7Q/DkBGLYfDHCmCz4Kjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342025; c=relaxed/simple;
	bh=vH1vEgp67v3DdwGllt9TSQwSKZlG0tum+Tsqq95TD8Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EPPHbLK0nRhClToKUqasTeEe15B6JlogYYXucY3nEkwyNL0S/n2rQNuWqyAOFE2LkI5ZoEr2hip+yXvGUakOg9l3HMytWdA4Sp3HzbsiNbcJIEQ/TU/ZZcr+TAiwcolZRoO0JRd1ghFnzRSf8vjxWk32Cul7jo75BARDDNxGCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LWnbs9aD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Jr7XElzr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E68E721AF5
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721342022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sDNFpKAXNZ8I46W8Ku6W+uATl0xgrsgcHW456BBUGbA=;
	b=LWnbs9aD3kYhhCMODqItyOkegrG+oe/+1dTd0EKuh863jYjaP1+KgkrhGF3wmuudXEJTeX
	/g1DT1gatB/V6swxrrwrmH1GAr6c6iZKmytJ0k0bcH4jjwkRRewdqYX4Wah+OSQ62fzeYf
	+eZ4V+gWTlXg42Gkv7BqRhSbJNzCMl4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Jr7XElzr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721342021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sDNFpKAXNZ8I46W8Ku6W+uATl0xgrsgcHW456BBUGbA=;
	b=Jr7XElzrUNiaiE62axzpKWSvZPNUlH9dCXfpb8XaAyeLT9rzvWq/lMGNFegJHIUqqsCM02
	0HuMmV5ISgYIr6+C+mi9zHlI2YOVn12aEoQLGPxC7V6no8yUut+Tj3+YcynE+UgB/nPTwI
	SvCMijdiMObY5KJdXLPvUYmb1O7iNDM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1652B1379D
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OzF2MESYmWb9HAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs-progs: fix the filename sanitization of btrfs-image
Date: Fri, 19 Jul 2024 08:03:18 +0930
Message-ID: <cover.1721341885.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E68E721AF5
X-Spam-Flag: NO
X-Spam-Score: 0.49
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spamd-Bar: /

[CHANGELOG]
v2:
- Various grammar fixes in the command docs
- Use `_mktemp()` and `_log()` when possible
- Use a dedicated filename list, and grep to find an exact match for
  them.

There are several bugs in btrfs-image filename sanitization:

- Ensured kernel path resolution bug
  Since during path resolution btrfs uses hash to find the child inode,
  with garbage filled DIR_ITEMs, it's definitely unable to properly
  resolve the path.

  A warning is added to the man page by the first patch.

- Only the last item got properly sanitized
  All the remaining INODE_REF/DIR_INDEX/DIR_ITEM are not sanitized at
  all.

  This is fixed by the second patch.

- Sanitized filename contains non-ASCII chars
  This is fixed by the third patch.


Finally a new test case is introduced to verify the filename
sanitization behavior of btrfs-image.

Qu Wenruo (4):
  btrfs-progs: add warning for -s option of btrfs-image
  btrfs-progs: image: fix the bug that filename sanitization not working
  btrfs-progs: misc-tests: add a basic resume test using error injection
  btrfs-progs: misc-tests: add a test case for filename sanitization

 Documentation/btrfs-image.rst                 | 19 +++++---
 image/sanitize.c                              |  8 +++-
 tests/common                                  |  7 +++
 .../065-csum-conversion-inject/test.sh        | 45 +++++++++++++++++++
 tests/misc-tests/065-image-filename/test.sh   | 38 ++++++++++++++++
 5 files changed, 109 insertions(+), 8 deletions(-)
 create mode 100755 tests/misc-tests/065-csum-conversion-inject/test.sh
 create mode 100755 tests/misc-tests/065-image-filename/test.sh

--
2.45.2


