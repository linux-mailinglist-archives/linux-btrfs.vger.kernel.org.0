Return-Path: <linux-btrfs+bounces-10578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487DC9F6CA7
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305B27A01B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D57B1FA8C0;
	Wed, 18 Dec 2024 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QoHc5qPv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QoHc5qPv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A5142624;
	Wed, 18 Dec 2024 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544206; cv=none; b=o2U3vJgk9PYM6e/SRiDIz/Mjh9S8IewNEJ4Ag73/GKXgV2opqG/zqLI20O7jjRx2IyS9bQs7U9Sunvao6BE/Cr00+rOli+vaf9alXATjiJbZEBpK5yMw26uaYFtXT4esJEEBQ0lL0w1+iNSlt7lYbzk5TF2hvrfraq0Y5MMinFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544206; c=relaxed/simple;
	bh=YQx4Z4/oDjSgGJTj4GlGKkX92ruglvILk8kELpJBSD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjnjronVPsbUVYZIWNwT//QcRu1rSLHkwGbJDu7xltcCH2IDBcjFfFWkkoNoalbtwn3QAU6P7GQKzXWpo5K9T/GGDsZwFgTPvsTxfLwyrQ7LK206+WQzx9Unk/BslJBeobVoLdL442yje0KjgOFjBIaJC/ExW+MZsmaZ96l1ox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QoHc5qPv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QoHc5qPv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BC191F396;
	Wed, 18 Dec 2024 17:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734544202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gt/UHf/h9znMK4PhjQ6Z/aNZ+HiYnX8yVXDHqaTJOpY=;
	b=QoHc5qPvToUrgX5Zmd8R0GCdmCOr3nJQMG2RAQl4kJC9X1CXAKPkFyaShAIKkQRH60/dus
	2cYy4T0iYa90oZLaQHeuKSjPgbpkFhtPnD85eHo9Oa5Ay2MhWSysGDAKsS4MPF0hpgLMZg
	RECvaNFMRhX6njt0tJBcugLmuGzIEPw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QoHc5qPv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734544202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gt/UHf/h9znMK4PhjQ6Z/aNZ+HiYnX8yVXDHqaTJOpY=;
	b=QoHc5qPvToUrgX5Zmd8R0GCdmCOr3nJQMG2RAQl4kJC9X1CXAKPkFyaShAIKkQRH60/dus
	2cYy4T0iYa90oZLaQHeuKSjPgbpkFhtPnD85eHo9Oa5Ay2MhWSysGDAKsS4MPF0hpgLMZg
	RECvaNFMRhX6njt0tJBcugLmuGzIEPw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 747CA132EA;
	Wed, 18 Dec 2024 17:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GDhtHEoLY2ebYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 18 Dec 2024 17:50:02 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.13-rc4
Date: Wed, 18 Dec 2024 18:49:53 +0100
Message-ID: <cover.1734477842.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7BC191F396
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi,

a few more fixes. This is based on 6.13-rc1 as it needs
exported bio_is_zone_append() (commit 0ef2b9e698dbf9ba78f).

Please pull, thanks.

- tree-checker catches invalid number of inline extent references

- zoned mode fixes:
  - enhance zone append IO command so it also detects emulated writes
  - handle bio splitting at sectorsize boundary

- when deleting a snapshot, fix a condition for visiting nodes in reloc
  trees

----------------------------------------------------------------
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc3-tag

for you to fetch changes up to dfb92681a19e1d5172420baa242806414b3eff6f:

  btrfs: tree-checker: reject inline extent items with 0 ref count (2024-12-17 19:54:32 +0100)

----------------------------------------------------------------
Christoph Hellwig (2):
      btrfs: use bio_is_zone_append() in the completion handler
      btrfs: split bios to the fs sector size boundary

Josef Bacik (1):
      btrfs: fix improper generation check in snapshot delete

Qu Wenruo (1):
      btrfs: tree-checker: reject inline extent items with 0 ref count

 fs/btrfs/bio.c          | 16 +++++++++++-----
 fs/btrfs/ctree.h        | 19 +++++++++++++++++++
 fs/btrfs/extent-tree.c  |  6 +++---
 fs/btrfs/tree-checker.c | 27 ++++++++++++++++++++++++++-
 4 files changed, 59 insertions(+), 9 deletions(-)

