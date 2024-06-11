Return-Path: <linux-btrfs+bounces-5627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71DC903112
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 07:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFC71F29BA1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 05:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F63217085B;
	Tue, 11 Jun 2024 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gxqh9CWD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gxqh9CWD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11C716F8E4
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083325; cv=none; b=JOIJ2+CDW2MRl6SWYHXFJdxbVDmjaGqVod3Cvv2hHYeL6/tPENehMBj7l05NDj5/KfJkdenLiyxbTbPWodnuf1Nx7vZPSxuSW0NnPJhCNutg+bEbrlt5nObRMoHBj2Tby4Zu22J3w0Xaw3I8ypfLh/3LNTzWoaeDWm9kF8Mlu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083325; c=relaxed/simple;
	bh=6/wYRC5ydp/J9FwZIpwoyfFSeS4VmEmLBlDhD4ROnuM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FTbyHLKJtVPjOe2ZiR+CjNTb/sI2YPbnmsPgULhTzNrOUoT2WyuVavO9uYC7cpZNRKs8N8oFvABh8/sKf3uQ3ZEhlS0ko0W/DxO4MkUNKbyBeuaCQFjKYyl/2BeyO6sUELgu0rOuhoHT0hlijinoAwSbYjpLc8y/jeHi35DqozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gxqh9CWD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gxqh9CWD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9249D20461
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718083321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8+SGOirzB6nwFB7LwiNsBU21pe4Cs3KohQIPBNvV7y4=;
	b=gxqh9CWDp8fplIG6lw+lXrVVK2vxeUOE3OGhZ9rxhz4VkgJduEpWb5NFknHENq9Zyzbych
	1yVtxW/84sU6Qp6yG5c2216ybEwvEcafDcKXINmnqZN2PxX4GnutNSIFFLZ0RINoFTebwG
	M2wcp+aYfUXIWsEOvm4G10wbParSuBc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gxqh9CWD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718083321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8+SGOirzB6nwFB7LwiNsBU21pe4Cs3KohQIPBNvV7y4=;
	b=gxqh9CWDp8fplIG6lw+lXrVVK2vxeUOE3OGhZ9rxhz4VkgJduEpWb5NFknHENq9Zyzbych
	1yVtxW/84sU6Qp6yG5c2216ybEwvEcafDcKXINmnqZN2PxX4GnutNSIFFLZ0RINoFTebwG
	M2wcp+aYfUXIWsEOvm4G10wbParSuBc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F55913A51
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eRPAFPjeZ2Y6KAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: rescue= mount options enhancement to support interrupted csum conversion
Date: Tue, 11 Jun 2024 14:51:34 +0930
Message-ID: <cover.1718082585.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9249D20461
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.01

[REPO]
https://github.com/adam900710/linux/tree/rescue_changes

[BACKGROUND]
There is an adventurous user using btrfstune to convert a 32T btrfs
from crc32c to xxhash.

However for such huge fs, it takes too long time and the reporter
canceled the conversion.

This makes the reporter unable to mount the fs at all.

[CAUSE]
First of all, for a half converted fs, we will never allow RW mount, so
everything must be done in rescue mode.

There are several different stages of csum conversion, and at different
stage it requires different handling from kernel:

- Generationg new data csums
  At this stage only the super flags (CHANGING_DATA_CSUM flag) is
  preventing the kernel from mounting.

  Intrdoce "rescue=ignoresuperflags" to address this.

- Deleting old data cums
  The same super flags problem, with possible missing data csums.

  Despite the new "rescue=ignoresuperflags", end users will also need
  the existing "rescue=ignoredatacsums" mount option.

- Renaming the objectid of new data cums
  The new csums' objectid will be changed to the regular one.

  During this we can hit data csum mismatch.
  So the same "rescue=ignoresuperflags:ignoredatacsums" can handle it
  already.

- Rewriting metadata csums
  This part is done in-place (no COW), with a new super flags
  (CHANGING_META_CSUM).

  So here introduce a new "rescue=ignoremetacsums" to ignore the
  metadata checksum verification (and rely on the remaining sanity
  checks like tree-checkers).

The first 2 patches are just small cleanups, meanwhile the last two are
the new "rescue=" mount options to handle interrupted csum change.

Qu Wenruo (4):
  btrfs: remove unused Opt enums
  btrfs: output the unrecognized super flags as hex
  btrfs: introduce new "rescue=ignoremetacsums" mount option
  btrfs: introduce new "rescue=ignoresuperflags" mount option

 fs/btrfs/bio.c       |  2 +-
 fs/btrfs/disk-io.c   | 22 ++++++++++++++--------
 fs/btrfs/file-item.c |  2 +-
 fs/btrfs/fs.h        |  4 +++-
 fs/btrfs/messages.c  |  2 +-
 fs/btrfs/super.c     | 27 +++++++++++++++++++++++----
 fs/btrfs/zoned.c     |  2 +-
 7 files changed, 44 insertions(+), 17 deletions(-)

-- 
2.45.2


