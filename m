Return-Path: <linux-btrfs+bounces-3835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8D0895F58
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 00:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39F0B24AA4
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 22:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D215ECD0;
	Tue,  2 Apr 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hVe2zv0K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF3F15E802
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095692; cv=none; b=slFQn7ekdq695qOLtZmzAHwmWv3hAyljnjdEHHIEdTdbQwUUCbWADbyGahNJ3MfDntyREQraSDKEmNSDzi6CdB6FBYjRq97gEQ57NWEfJP308hkAFqZ3GggbsP7dwQEv7FUxl+FujGtb2w8BiqmScJigEW8C4wKCcWZ4ybWEFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095692; c=relaxed/simple;
	bh=G/FT9H7Pc3okQNQP78MmNoObPoyeBfiQzGNcl1+aDyc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=k0h8YMclmtPAnoTnQIVB12aqyxkZRS7z7+zIBp3svT4CIptyV3YKjuRZEGI9G8Z5Vq4ioQ3hjPSAW92Gu1wkbWLV4+Tt5QP7tQRqgTXIBBN4b61Mc+ifUXu0BYGGvD4qfp926SAxaj14ZYIkVrJmLbrBADkfM8SFGanqlNs5ZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hVe2zv0K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9BB934BC8
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712095687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IelFHF9Em8OE8Sb2BDv24L1H0cglMTN+dm5CE/fwFJA=;
	b=hVe2zv0KUYUmfJbQMjOJP+luJLCz2JTPiOsY0wtnUiymCf+QVM18TmT9N+Pj0lgYOXy1x5
	s/MDMecAoPsN/JW59UfGrDAkB7qga/tHs9oCS2pMVgbr+PymJxJd7pvJIZlEcdfCATCXEx
	1fYluaMmdb538OXB1Zu0kjv2z6t+9E4=
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DC84813A90
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oELBI8aBDGYIdwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 22:08:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs-progs: zoned devices support for bgt feature
Date: Wed,  3 Apr 2024 08:37:35 +1030
Message-ID: <cover.1712095635.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.77
X-Spamd-Result: default: False [1.77 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_SPAM_SHORT(0.87)[0.291];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Remove the header cleanup for tune/main.c
  That would cause compiling error as our expertimental features
  still rely on that header.

[REPO]
https://github.com/adam900710/btrfs-progs/tree/zoned_bgt

There is a bug report that, the following tool would fail on zone
devices:

- mkfs.btrfs -O block-group-tree
- btrfstune --convert-to-block-group-tree|--convert-from-block-group-tree

The mkfs failure is caused by zoned incompatible pwrite() calls for
block group tree metadata.

The btrfstune failure is caused by the incorrectly opened fd.


Before fixing both bugs, do one small cleanup, as my later check on the
test case output finds a missing newline for btrfstune.

Then fixes for each bug, and new test cases for each bug.

Qu Wenruo (5):
  btrfs-progs: tune: add the missing newline for
    --convert-from-block-group-tree
  btrfs-progs: mkfs: use proper zoned compatible write for bgt feature
  btrfs-progs: tune: properly open zoned devices for RW
  btrfs-progs: tests-mkfs: add test case for zoned block group tree
    feature
  btrfs-progs: tests-misc: add a test case to check zoned bgt conversion

 mkfs/common.c                                 |  4 +-
 .../063-btrfstune-zoned-bgt/test.sh           | 55 +++++++++++++++++++
 tests/mkfs-tests/031-zoned-bgt/test.sh        | 40 ++++++++++++++
 tune/convert-bgt.c                            |  2 +-
 tune/main.c                                   |  6 +-
 5 files changed, 103 insertions(+), 4 deletions(-)
 create mode 100755 tests/misc-tests/063-btrfstune-zoned-bgt/test.sh
 create mode 100755 tests/mkfs-tests/031-zoned-bgt/test.sh

--
2.44.0


