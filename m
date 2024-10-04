Return-Path: <linux-btrfs+bounces-8535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D282698FD1D
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 07:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822381F23353
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 05:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9CE126C04;
	Fri,  4 Oct 2024 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eE8jGkQR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eE8jGkQR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9244AEF2
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728021154; cv=none; b=dYJ9OmfCBEOus9HkASh1Cmv2xkpAwVOrGBWTBFRjtswuBLtzPlOa4KwoUCHzZ7REI4yBYeQT83XhdtJj7jcZ1j0RcFqADfl3X/qWIWpeC7qlD7Wnpb3Mcc+rrXxg/WmIOkNCK7+8eiRZ5P4r10iiKnyX6KO9Glr/BtxtWiqg3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728021154; c=relaxed/simple;
	bh=EdXqjTzf6lMBcugrsimLxGiitVcVVLC7shrDQ+s5Khc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u18FtfKGScE9TBexfoOmeMaYeLKaFtS1iSTeRebzZRAlbV+eZ7NdUNZ3XiRV96o2+uVYmAdNqMN3LMv7VlehvuMwJeMwS0MEFObFPirTxOlrZyxVlGYlLQUiApQ3pUXBRhlQpgjWIqEB5KOlU2wDv0hgEXkQw4/ko9M6BOsFVks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eE8jGkQR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eE8jGkQR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A33A1FED3
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728021149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsCxd05pd6Ombj06JSHXJMTaFr2Gl6RF5s8GDg+BNmI=;
	b=eE8jGkQR8aFQJHL6DSAzdRKUdNEt69XcbFMThuHKjF7o4rdf2ZQJ8BaV5JTBtlMvPjxxbx
	U7XM162wntQfhLE57MZ1V21SleWKxGW8rwiav5f6OFFg/KKnL+WdIAb19m9/G6BHYh398w
	4B02r/3s7Ke6G4ciA6ZH5V1AEckn1ig=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728021149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsCxd05pd6Ombj06JSHXJMTaFr2Gl6RF5s8GDg+BNmI=;
	b=eE8jGkQR8aFQJHL6DSAzdRKUdNEt69XcbFMThuHKjF7o4rdf2ZQJ8BaV5JTBtlMvPjxxbx
	U7XM162wntQfhLE57MZ1V21SleWKxGW8rwiav5f6OFFg/KKnL+WdIAb19m9/G6BHYh398w
	4B02r/3s7Ke6G4ciA6ZH5V1AEckn1ig=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83C971376C
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:52:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AJdmEZyC/2ZrRAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2024 05:52:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: print-tree: use ARRAY_SIZE() to replace open-coded ones
Date: Fri,  4 Oct 2024 15:22:03 +0930
Message-ID: <ab1b8425469a6ccb386d7d2c05bdee72c9deb59b.1728020867.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728020867.git.wqu@suse.com>
References: <cover.1728020867.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

For compat_ro_flags_num and incompat_flags_num, just use ARRAY_SIZE().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index ab85432e2807..14f7dcdf0ee9 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1889,8 +1889,7 @@ static struct readable_flag_entry compat_ro_flags_array[] = {
 	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE_VALID),
 	DEF_COMPAT_RO_FLAG_ENTRY(BLOCK_GROUP_TREE),
 };
-static const int compat_ro_flags_num = sizeof(compat_ro_flags_array) /
-				       sizeof(struct readable_flag_entry);
+static const int compat_ro_flags_num = ARRAY_SIZE(compat_ro_flags_array);
 
 #define DEF_INCOMPAT_FLAG_ENTRY(bit_name)		\
 	{BTRFS_FEATURE_INCOMPAT_##bit_name, #bit_name}
@@ -1913,8 +1912,7 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(RAID_STRIPE_TREE),
 	DEF_INCOMPAT_FLAG_ENTRY(SIMPLE_QUOTA),
 };
-static const int incompat_flags_num = sizeof(incompat_flags_array) /
-				      sizeof(struct readable_flag_entry);
+static const int incompat_flags_num = ARRAY_SIZE(incompat_flags_array);
 
 #define DEF_HEADER_FLAG_ENTRY(bit_name)			\
 	{BTRFS_HEADER_FLAG_##bit_name, #bit_name}
-- 
2.46.2


