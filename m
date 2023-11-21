Return-Path: <linux-btrfs+bounces-216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603C17F235B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 02:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F51B21B2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 01:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA5113AF9;
	Tue, 21 Nov 2023 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PMWQj0h+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FE8CA
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 17:57:26 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 32355218DF;
	Tue, 21 Nov 2023 01:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700531845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osNqrE/mCfQ9y+9mkqMFAegzqlJcuJs8U1a0YDmiuMA=;
	b=PMWQj0h+JTRt88eZAekI59xf9jpXxBdq9DQ3r2ueSLQbqJA70wz2wuFPwOgG8gYwSoexkY
	X3q1ZD0LY8YyBOI/lDxagvAoZ31OwJzh9Ya2uCHrDGCfwlO6OWA7yyx74AKKewqiuDSCzx
	C1kKgY0jjFLveqT3StVKBanwx0exwLk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 231652C142;
	Tue, 21 Nov 2023 01:57:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 77843DA86C; Tue, 21 Nov 2023 02:50:17 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: raid56: remove unused btrfs_plug_cb::work
Date: Tue, 21 Nov 2023 02:50:17 +0100
Message-ID: <c1789aa00d9518787789d6e847b69f5ef20a7f6d.1700531088.git.dsterba@suse.com>
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
X-Spamd-Bar: ++++++++++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [25.00 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
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
X-Spam-Score: 25.00
X-Rspamd-Queue-Id: 32355218DF

The raid56 changes in 6.2 reworked the IO path to RMW, commit
93723095b5d5 ("btrfs: raid56: switch write path to rmw_rbio()") in
particular removed the last use of the work member so it can be removed
as well. This was found by tool https://github.com/jirislaby/clang-struct .

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/raid56.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 3e014b9370a3..90f12c0e88a1 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1549,7 +1549,6 @@ struct btrfs_plug_cb {
 	struct blk_plug_cb cb;
 	struct btrfs_fs_info *info;
 	struct list_head rbio_list;
-	struct work_struct work;
 };
 
 /*
-- 
2.42.1


