Return-Path: <linux-btrfs+bounces-215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB40F7F235A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 02:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871522828B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 01:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB63134B6;
	Tue, 21 Nov 2023 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gr5j2fDq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC42985
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 17:57:24 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 0E7841F8AA;
	Tue, 21 Nov 2023 01:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700531843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxsxmOpJmxRphtA2PbUlQVM2CNmukx7GXN2sG9ysU1I=;
	b=Gr5j2fDq9ReaRXkq7K7lLl2RsxABY5bgKdw7/r8Yek89BFaknDBz1+HZmnJS2znxmYBylx
	rAAmvEOSM/ThKIJeF4ioPKtMUaO1v3BQvMshnl6R4XalNyU4HAyv02VeLVSWTGazCZeW+Z
	KlY6kp2lRGxHogWnrwBQsODkWr+UB/g=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 0EEF02C142;
	Tue, 21 Nov 2023 01:57:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 50CD6DA86C; Tue, 21 Nov 2023 02:50:15 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs: remove unused btrfs_ordered_extent::outstanding_isize
Date: Tue, 21 Nov 2023 02:50:15 +0100
Message-ID: <2610708f3b1112c91e6315db85cb200fdd72d9dd.1700531088.git.dsterba@suse.com>
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
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
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
	 MIME_TRACE(0.00)[0:+];
	 R_DKIM_NA(2.20)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-0.00)[34.38%]
X-Spam-Score: 25.00
X-Rspamd-Queue-Id: 0E7841F8AA

The whole isize code was deleted in 5.6 3f1c64ce0438 ("btrfs: delete the
ordered isize update code"), except the struct member.  This was found
by tool https://github.com/jirislaby/clang-struct .

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ordered-data.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 567a6d3d4712..127ef8bf0ffd 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -96,13 +96,6 @@ struct btrfs_ordered_extent {
 	/* number of bytes that still need writing */
 	u64 bytes_left;
 
-	/*
-	 * the end of the ordered extent which is behind it but
-	 * didn't update disk_i_size. Please see the comment of
-	 * btrfs_ordered_update_i_size();
-	 */
-	u64 outstanding_isize;
-
 	/*
 	 * If we get truncated we need to adjust the file extent we enter for
 	 * this ordered extent so that we do not expose stale data.
-- 
2.42.1


