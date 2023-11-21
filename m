Return-Path: <linux-btrfs+bounces-217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CDF7F235C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 02:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C571F25F6C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 01:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1C14299;
	Tue, 21 Nov 2023 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NMwXeAeo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAD4C3
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 17:57:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 4FB941F8A8;
	Tue, 21 Nov 2023 01:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700531847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gs2I7pnqgoXWXtlsBkOXCnkxBfQxQb4kT2A4f9rLwLw=;
	b=NMwXeAeoa7L60h9vYiDxlhShcelsXSMnSBKi4armoOGFfyCehexiSnkpqc2qrYyvS7h6eI
	zb6ggijyVX2qCtS5o9f5XQ0aBt9crpxwJOk35lNZnKw/oH6ECiRJNsf+0UABc0Vi5Xld0F
	N+IIUkL8KOUlT8SGS3YQi3Wlhi/t4Ng=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 4FDF92C142;
	Tue, 21 Nov 2023 01:57:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id A0FDADA86C; Tue, 21 Nov 2023 02:50:19 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs: remove unused definition of tree_entry in extent-io-tree.c
Date: Tue, 21 Nov 2023 02:50:19 +0100
Message-ID: <d988ba8b1fd5f6f22bd4eeb64ea0d651aef5eef1.1700531088.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700531088.git.dsterba@suse.com>
References: <cover.1700531088.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [25.60 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 BAYES_SPAM(0.60)[76.47%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz]
X-Spam-Score: 25.60
X-Rspamd-Queue-Id: 4FB941F8A8

The declaration was temporarily moved in a4055213bf69 ("btrfs: unexport
all the temporary exports for extent-io-tree.c") and then should have
been removed in 6.0 in 071d19f5130f ("btrfs: remove struct tree_entry in
extent-io-tree.c") but was not.  This was found by tool
https://github.com/jirislaby/clang-struct .

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index ea149be28dff..76061245a46b 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -87,12 +87,6 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
  */
 static struct lock_class_key file_extent_tree_class;
 
-struct tree_entry {
-	u64 start;
-	u64 end;
-	struct rb_node rb_node;
-};
-
 void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 			 struct extent_io_tree *tree, unsigned int owner)
 {
-- 
2.42.1


