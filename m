Return-Path: <linux-btrfs+bounces-5692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B247905FAF
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 02:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F39A1F227E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 00:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047168C09;
	Thu, 13 Jun 2024 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gMiQzblh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gMiQzblh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750DB79FE
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238237; cv=none; b=Ezun5Ed3tm0LpDMXajDeRO1HGD3SehSbMB62ys5C/GrWew6a5Lt8E2BCyy9Wg5bJ6r3nkciZL/OOyghuHuNIkrYDS+Kkx3UBjvu7klhyixT3V3xgbWR1BrcIabbjrw4R8z3jbC6TaKaLf9pj2bzr1N6hnP1fzvUI6oSZTt5VbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238237; c=relaxed/simple;
	bh=ku6w0AvipZ4TABTl6uySUTe0pn/hOYlQFNZ2i9n8opA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbuT5mKuIT/8TmUqdcf1Ub6RHJJu2cbYd3XYiy2g9lk9nBUqfW1oHEii5Bqs+WbYz/9wyi50G+2E1Z0yK06zN4fMlVYpqpiYN43h0nqE6Hjb60+gXrqgOQLWTt+9Nx2L//+S2rFZHuM4oxsnHB5BqEf759CAFGOeJ/mxlnxX4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gMiQzblh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gMiQzblh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 942E134B81
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718238233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MmSo04ZDBCoSogeO+jC4zCQT4382colhB2J8B2pDmcU=;
	b=gMiQzblhjc2gFmTj0KeIeCCOVzLA/OOx1mv6cMiSry5aboSzTwAoU4BH3NT1O5qrqXIkoC
	5xUWreCtsOqtJ3nSYNht+AkxDnVRMB2yofdkJAJ0GY/jTEkIsnKvo+aObDHqnfByhNxCoM
	HN+Xm+R2fDe820OSCUTrA7ETV8dRuC0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gMiQzblh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718238233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MmSo04ZDBCoSogeO+jC4zCQT4382colhB2J8B2pDmcU=;
	b=gMiQzblhjc2gFmTj0KeIeCCOVzLA/OOx1mv6cMiSry5aboSzTwAoU4BH3NT1O5qrqXIkoC
	5xUWreCtsOqtJ3nSYNht+AkxDnVRMB2yofdkJAJ0GY/jTEkIsnKvo+aObDHqnfByhNxCoM
	HN+Xm+R2fDe820OSCUTrA7ETV8dRuC0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2C9713A7F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MGtUFRg8amY9YQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs-progs: fsfeatures: move RST back to experimental
Date: Thu, 13 Jun 2024 09:53:24 +0930
Message-ID: <a2a0d4b0c4a04a51be560b0674ae6a87e42895e5.1718238120.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718238120.git.wqu@suse.com>
References: <cover.1718238120.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 942E134B81
X-Spam-Score: -5.01
X-Spam-Level: 
X-Spam-Flag: NO
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
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Currently raid-stripe-tree feature is still experimental as it requires
a BTRFS_DEBUG kernel to recognize it.

To avoid confusion move it back to experimental so regular users won't
incorrectly set it.

And since RST is no longer supported by default, also change the RST
profile detection so that for non-experimental build we won't enable RST
according to the data profiles.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c | 2 ++
 mkfs/main.c         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index c5e81629ccea..7aaddab6a192 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -222,6 +222,7 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "block group tree, more efficient block group tracking to reduce mount time"
 	},
+#if EXPERIMENTAL
 	{
 		.name		= "rst",
 		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE,
@@ -238,6 +239,7 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "raid stripe tree, enhanced file extent tracking"
 	},
+#endif
 	{
 		.name		= "squota",
 		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA,
diff --git a/mkfs/main.c b/mkfs/main.c
index 0b9d1d78663d..8d0924ea3b0b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1693,7 +1693,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		case BTRFS_BLOCK_GROUP_RAID1C4:
 		case BTRFS_BLOCK_GROUP_RAID0:
 		case BTRFS_BLOCK_GROUP_RAID10:
+#if EXPERIMENTAL
 			features.incompat_flags |= BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE;
+#endif
 			break;
 		default:
 			break;
-- 
2.45.2


