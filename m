Return-Path: <linux-btrfs+bounces-232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 995287F2E43
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55252282AD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB3051C3C;
	Tue, 21 Nov 2023 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Cqj+KSO5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE130D45
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 05:27:22 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6E5841F8B8;
	Tue, 21 Nov 2023 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700573241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J1IaUBrW6onwAbRNIfkRQoFCNBoYdwpzo4KB6gTOOpg=;
	b=Cqj+KSO5AU1fOTlY/VFuo7PDptguXdbSkSpTwff6mlmB8GKUwCmczKY64ZyPKELv1JjHec
	s71EeHQ9gl2B3Kicu4IRVx/6ZsURbjrvCKBLX0ofJAHsQy4nod8L8f/ZInx9UBmFHYc6Qm
	p4th0mVgLoh/20N/wk+JC5ePoNlw3e0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 710572C146;
	Tue, 21 Nov 2023 13:27:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 4BA57DA86C; Tue, 21 Nov 2023 14:20:13 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] Reduce size of extent_io_tree, remove fs_info
Date: Tue, 21 Nov 2023 14:20:12 +0100
Message-ID: <cover.1700572232.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [24.99 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-0.01)[50.19%]
X-Spam-Score: 24.99
X-Rspamd-Queue-Id: 6E5841F8B8

We have the fs_info pointer in extent_io_tree for the trace points as
the inode is not always set. This is a bit wasteful and extent_io_tree
is also embedded in other structures. The tree owner can be used to
determine if the inode is expected to be non-NULL, otherwise we can
store the fs_info pointer.

I tried to do it in the cleanest way, union and access wrappers, it's
IMO worth the space savings:

- btrfs_inode		1104 -> 1088
- btrfs_device		 520 ->  512
- btrfs_root		1360 -> 1344
- btrfs_transaction	 456 ->  440
- btrfs_fs_info		3600 -> 3592
- reloc_control		1520 -> 1512

The btrfs_inode structure is getting closer to the 1024 size where it
would pack better in the slab pages.

David Sterba (5):
  btrfs: move lockdep class setting out of extent_io_tree_init
  btrfs: drop error message in extent_io_tree insert_state()
  btrfs: constify fs_info parameter in __btrfs_panic()
  btrfs: enhance extent_io_tree error reports
  btrfs: always set extent_io_tree::inode and drop fs_info

 fs/btrfs/extent-io-tree.c    | 113 ++++++++++++++++++++++-------------
 fs/btrfs/extent-io-tree.h    |  18 +++++-
 fs/btrfs/inode.c             |  14 +++++
 fs/btrfs/messages.c          |   2 +-
 fs/btrfs/messages.h          |   2 +-
 fs/btrfs/tests/btrfs-tests.c |   2 +-
 include/trace/events/btrfs.h |  45 +++++---------
 7 files changed, 118 insertions(+), 78 deletions(-)

-- 
2.42.1


