Return-Path: <linux-btrfs+bounces-233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3C57F2E45
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 444C7B21C45
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8251C3E;
	Tue, 21 Nov 2023 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qrLPMoRL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F198712C
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 05:27:26 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id AB5B421954;
	Tue, 21 Nov 2023 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700573245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzPlM9Vg9JYgyViPmfxp4oA376Du2jArVWPRTxBqavs=;
	b=qrLPMoRLwkQy/0rui30PcoCf5/Is4YTLqmXy7nhGNOWG1hzeQNRAqK3KhvziQVAP3y99q4
	mgpqXhKoFiK5nUMi2kcy2kOSO5uQ1x8Lher8PLcDStdMqiowqFVmPQTTSprusRf2JprW26
	8KVqRWMM2ty5xpgYegyvoxeZwu3uY24=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 9994A2C146;
	Tue, 21 Nov 2023 13:27:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id A363EDA86C; Tue, 21 Nov 2023 14:20:17 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs: drop error message in extent_io_tree insert_state()
Date: Tue, 21 Nov 2023 14:20:17 +0100
Message-ID: <fa0cdf857876ae1e86641813d0b0b95f20aa5314.1700572232.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700572232.git.dsterba@suse.com>
References: <cover.1700572232.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [25.00 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 BAYES_SPAM(0.00)[16.59%];
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
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz]
X-Spam-Score: 25.00
X-Rspamd-Queue-Id: AB5B421954

The helper insert_state errors are handled in all callers and reported
by extent_io_tree_panic so we don't need to do it twice.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 56be64e656da..887d9beb7b10 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -442,9 +442,6 @@ static struct extent_state *insert_state(struct extent_io_tree *tree,
 			}
 			node = &(*node)->rb_right;
 		} else {
-			btrfs_err(tree->fs_info,
-			       "found node %llu %llu on insert of %llu %llu",
-			       entry->start, entry->end, state->start, state->end);
 			return ERR_PTR(-EEXIST);
 		}
 	}
-- 
2.42.1


