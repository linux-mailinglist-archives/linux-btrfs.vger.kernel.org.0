Return-Path: <linux-btrfs+bounces-8536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78A298FD1E
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 07:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03063B229F5
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 05:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8A2126BFE;
	Fri,  4 Oct 2024 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a2PioWma";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a2PioWma"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A869B4F5FB
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728021154; cv=none; b=ap178Gwdq5n8oidKrZmLK6RfGjNg+U6j+cDQvIyz/xG6WAaseSXOFF0e35c/sn4ypi41yw2zVm1tJ0OIMkb/2/qjKmHLtNiMJn91OeWc/1b7X1prMKJv0z1hLDbzXDcuZMMku5QXtZa2FDVAJTY7usJ89BOSYb14ItCb1yhmw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728021154; c=relaxed/simple;
	bh=+WsDuoJbh7R92yaCZNsxPo+DxSxibKqFbnn4ithx0AM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIx2arfsF1s6xkVdZguVyy0NIzh55yQ0fSty2GVW+nr0ebNc9rh4Z/FxTRIc2JWZ89AKN+MfDDj1Fj7MTEQ6qEacYYvZ3ttOMo3IIoZqbQPD40PRqr0NWl/ioUwJI+3hmd2qQNPj0yTPZaHa4t144MmP2v3/sYk1GZrbki6U6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a2PioWma; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a2PioWma; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 856271FED7
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728021150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXSk5UlUpqAQi9y6skPnxdVQggo5WZzQCOnRNvqwgls=;
	b=a2PioWmaDoFhmaQG9aKU7KrEvK5H6+yVCNcorOzL1596bLdAeF05GFS1n+pWoBGWAOeYxZ
	aKkkNdKBzJkLorSwk85U6EhcZ5+CyIlPpXJxw8Wg9CK6biiPscIPASghLWlSXiCH5EhTih
	NXEDSpGk1iudfBWr4amgRWZBIlIJmEk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728021150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXSk5UlUpqAQi9y6skPnxdVQggo5WZzQCOnRNvqwgls=;
	b=a2PioWmaDoFhmaQG9aKU7KrEvK5H6+yVCNcorOzL1596bLdAeF05GFS1n+pWoBGWAOeYxZ
	aKkkNdKBzJkLorSwk85U6EhcZ5+CyIlPpXJxw8Wg9CK6biiPscIPASghLWlSXiCH5EhTih
	NXEDSpGk1iudfBWr4amgRWZBIlIJmEk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE84A1376C
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:52:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KEG4H52C/2ZrRAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2024 05:52:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: print-tree: cleanup __print_readable_flag()
Date: Fri,  4 Oct 2024 15:22:04 +0930
Message-ID: <01d915834db71e870dc93d675ee16db3d14e527a.1728020867.git.wqu@suse.com>
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
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

This includes:

- Remove the "__" prefix
  Now the "__" is no longer recommended, and there is no function taking
  the "print_readable_flag" in the first place.

- Move the supported flags calculation into print_readable_flag()
  Since all callers are doing the same work before calling the function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 14f7dcdf0ee9..bbd625d9b1eb 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1933,13 +1933,17 @@ static struct readable_flag_entry super_flags_array[] = {
 };
 static const int super_flags_num = ARRAY_SIZE(super_flags_array);
 
-static void __print_readable_flag(u64 flag, struct readable_flag_entry *array,
-				  int array_size, u64 supported_flags)
+static void print_readable_flag(u64 flag, struct readable_flag_entry *array,
+				int array_size)
 {
 	int i;
 	int first = 1;
+	u64 supported_flags = 0;
 	struct readable_flag_entry *entry;
 
+	for (i = 0; i < array_size; i++)
+		supported_flags |= array[i].bit;
+
 	if (!flag)
 		return;
 
@@ -1966,33 +1970,20 @@ static void __print_readable_flag(u64 flag, struct readable_flag_entry *array,
 
 static void print_readable_compat_ro_flag(u64 flag)
 {
-	u64 print_flags = 0;
-
-	for (int i = 0; i < compat_ro_flags_num; i++)
-		print_flags |= compat_ro_flags_array[i].bit;
-	return __print_readable_flag(flag, compat_ro_flags_array,
-				     compat_ro_flags_num,
-				     print_flags);
+	return print_readable_flag(flag, compat_ro_flags_array,
+				   compat_ro_flags_num);
 }
 
 static void print_readable_incompat_flag(u64 flag)
 {
-	u64 print_flags = 0;
-
-	for (int i = 0; i < incompat_flags_num; i++)
-		print_flags |= incompat_flags_array[i].bit;
-	return __print_readable_flag(flag, incompat_flags_array,
-				     incompat_flags_num, print_flags);
+	return print_readable_flag(flag, incompat_flags_array,
+				   incompat_flags_num);
 }
 
 static void print_readable_super_flag(u64 flag)
 {
-	u64 print_flags = 0;
-
-	for (int i = 0; i < super_flags_num; i++)
-		print_flags |= super_flags_array[i].bit;
-	return __print_readable_flag(flag, super_flags_array,
-				     super_flags_num, print_flags);
+	return print_readable_flag(flag, super_flags_array,
+				   super_flags_num);
 }
 
 static void print_sys_chunk_array(struct btrfs_super_block *sb)
-- 
2.46.2


