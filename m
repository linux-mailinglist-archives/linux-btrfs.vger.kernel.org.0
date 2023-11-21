Return-Path: <linux-btrfs+bounces-213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B207F2358
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 02:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610B1B219CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 01:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8578111AB;
	Tue, 21 Nov 2023 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jTdlMGwV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC4A85
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 17:57:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 185191F8A3;
	Tue, 21 Nov 2023 01:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700531839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NdUqa63JGQbfzx7zRNohrTvWtHXUtF5vANvT/phjAGs=;
	b=jTdlMGwVfoQnxVGP6cYWXQ1s3bb9PrPveAY/dSBgtqH7Z1KRWngOB1UMjr3Mv/PyapHJOW
	hvXifWJTyZMCCR8QpeoEafoAwco/1msRL1xPEiXWqmRfCQFc/4CFL7O6cRqLwPvKJZ2B1P
	dBbTiemlsUAKc3WqH3GCtKk+jQqKaN0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 154732C142;
	Tue, 21 Nov 2023 01:57:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 0AF16DA86C; Tue, 21 Nov 2023 02:50:10 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	jirislaby@kernel.org
Subject: [PATCH 0/5] Remove some unused struct members
Date: Tue, 21 Nov 2023 02:50:10 +0100
Message-ID: <cover.1700531088.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [22.95 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-1.05)[87.74%]
X-Spam-Score: 22.95
X-Rspamd-Queue-Id: 185191F8A3

Jiri Slaby wrote a tool to find unused struct members [1]. There are
some interesting fossils. Comparing that to my hacky coccinelle scripts,
it did a much better job.

[1] https://github.com/jirislaby/clang-struct

David Sterba (5):
  btrfs: scrub: remove unused scrub_ctx::sectors_per_bio
  btrfs: remove unused btrfs_ordered_extent::outstanding_isize
  btrfs: raid56: remove unused btrfs_plug_cb::work
  btrfs: remove unused definition of tree_entry in extent-io-tree.c
  btrfs: remove unused btrfs_root::type

 fs/btrfs/ctree.h          | 2 --
 fs/btrfs/extent-io-tree.c | 6 ------
 fs/btrfs/ordered-data.h   | 7 -------
 fs/btrfs/raid56.c         | 1 -
 fs/btrfs/scrub.c          | 1 -
 5 files changed, 17 deletions(-)

-- 
2.42.1


