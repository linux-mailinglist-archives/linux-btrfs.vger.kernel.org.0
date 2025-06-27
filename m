Return-Path: <linux-btrfs+bounces-15050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A11E8AEB96D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 16:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DFA188F72B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564D82DBF72;
	Fri, 27 Jun 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jJgqt7T+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jJgqt7T+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57342DBF4E
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033039; cv=none; b=mTP/nzrO65f9DlfasxUJvE0taf/KAGYjrBgPntqzPx1PJs99xhZ7EsjCi6YpznuK8H76DheblnW5yRiCNIwVOcBFQCLRsFwZNAUOAX7lgpTTrq/or3mJp+By7LTBGuVUU2+jfivaYSWQsk8CLBgA+BE/2EX03pDRva6MIGHqXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033039; c=relaxed/simple;
	bh=/v4O8vqHm8spJ9jwGI7Rr0X0tZb7hvwOFjkl+lFmBbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0XYXnx6Dw4bbKciVkOHAaK0OtnJX9Q3CqsLAWxtDEY0YR4c4BPZ3OKzn+QUzwnxOma0i3o2nCUCY1vLNshjdo4PPopXC5gvD47Zn+zndFN3E2JgySMBbhSIkJpIovRdTC1ZdvORG29KThInkdE84VX0y74fdBhVF1ucYIu5AIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jJgqt7T+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jJgqt7T+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A9E621157;
	Fri, 27 Jun 2025 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751033034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=t9OjapWJJE+H2HZclqumeLJGZ/TKriBXlf9Z9s9r+NA=;
	b=jJgqt7T+WXcTegVbWvIelM3QTundXgdckvOR3BoXx2/PG416b+6ejWv20w8oR/yIG3F/PJ
	wsiJyNcaj+yz6rhOkC5Jqv6H2KZ07NoSyNB8LcKo7Fqif7e9PlkXR7T6g4rIhlHONhRVTz
	ws5taBDw6nkFsHlIGzv5S00sYmPSnB8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jJgqt7T+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751033034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=t9OjapWJJE+H2HZclqumeLJGZ/TKriBXlf9Z9s9r+NA=;
	b=jJgqt7T+WXcTegVbWvIelM3QTundXgdckvOR3BoXx2/PG416b+6ejWv20w8oR/yIG3F/PJ
	wsiJyNcaj+yz6rhOkC5Jqv6H2KZ07NoSyNB8LcKo7Fqif7e9PlkXR7T6g4rIhlHONhRVTz
	ws5taBDw6nkFsHlIGzv5S00sYmPSnB8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E72213786;
	Fri, 27 Jun 2025 14:03:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 37xcIsqkXmjsRwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 27 Jun 2025 14:03:54 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Set/get accessor cleanups
Date: Fri, 27 Jun 2025 16:03:49 +0200
Message-ID: <cover.1751032655.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9A9E621157
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01
X-Spam-Level: 

This patchset is first in a series to cleanup and optimize the
accessors, now removing code that's not needed anymore, explained with
references in the last patch.

Overall effects on .ko:

   text    data     bss     dec     hex filename
1463615  115665   16088 1595368  1857e8 pre/btrfs.ko
1456601  115665   16088 1588354  183c82 post/btrfs.ko

DELTA: -7014

And stack consumption:

__push_leaf_left                                   -32 (176 -> 144)
copy_for_split                                     -32 (144 -> 112)
fill_inode_item                                    -32 (80 -> 48)
btrfs_truncate_item                                -24 (152 -> 128)
btrfs_extend_item                                  -16 (104 -> 88)
btrfs_del_items                                    -16 (144 -> 128)
setup_items_for_insert                             -32 (144 -> 112)
__push_leaf_right                                  -24 (168 -> 144)

REMOVED (744):
        btrfs_get_token_32                          88
        btrfs_set_token_64                          96
        btrfs_get_token_64                          88
        btrfs_set_token_32                          96
        btrfs_get_token_16                          88
        btrfs_get_token_8                           88
        btrfs_set_token_16                          96
        btrfs_set_token_8                           96
        btrfs_init_map_token                         8

REMOVED/NEW DELTA:  -744
PRE/POST DELTA:     -952

David Sterba (4):
  btrfs: don't use token set/get accessors for btrfs_item members
  btrfs: don't use token set/get accessors in inode.c:fill_inode_item()
  btrfs: tree-log: don't use token set/get accessors in
    fill_inode_item()
  btrfs: accessors: delete token versions of set/get helpers

 fs/btrfs/accessors.c | 78 --------------------------------------------
 fs/btrfs/accessors.h | 37 ---------------------
 fs/btrfs/ctree.c     | 51 ++++++++++-------------------
 fs/btrfs/inode.c     | 50 ++++++++++++----------------
 fs/btrfs/tree-log.c  | 48 +++++++++++----------------
 5 files changed, 57 insertions(+), 207 deletions(-)

-- 
2.49.0


