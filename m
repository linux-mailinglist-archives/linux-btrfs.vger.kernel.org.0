Return-Path: <linux-btrfs+bounces-6273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F34929B74
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 07:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A761F2160A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 05:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCDC101E2;
	Mon,  8 Jul 2024 05:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bHN/sYmQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bHN/sYmQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0F14A8F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720415686; cv=none; b=XwIHBzSaqitdlsmYxpeTDf2YLppW/ckSqE0qsR0OP3YqcGfcEDPN+38qZ3dSNvDABEfu54wqJq87wbWo50SqyAF39Y5Ii4zaXpyeXWXlsE8d3qmVXmwKCngd9rgi9VK3r/GFJ1wxOrmX/BbP9syp/YwcGPUwAmCdJdijGF2keDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720415686; c=relaxed/simple;
	bh=+xZk9Jeh0ny0/XZcmvsNVIzml6XsMudIriE4xvuObkQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT0zN2Zg4ABF7No5QIeSX+7SB3b2BrvUQNJs5yfgPhvJP/sMwOnCoC9dSK5GA88CsHyLI+DXFEbt36EKf82fjE7TN2Ms5w5X/02oZzhCu9OEyK1BKD6CzV7qgtpJMdao/inYxn34DyzJpK1Vj5JnsvNGFxNElGqgVq0iUTPoxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bHN/sYmQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bHN/sYmQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A55A219DE
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720415682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pEomUY7EA/AKConWTE1BA8iU5+YPujwJNjXr2qbA40U=;
	b=bHN/sYmQLG3vsAenTJdBDeEr5YU7+rMLTji9fB+YsJVQ8iPTp212Ts0Y2/qPeBUkcEJIyR
	RzOeU/HJTiNwIhdopjbG3GJG/EnQGCUJAIHZ991zqCjfJDV2SDZNolwbW6zuFWoQXm4eIu
	XLzZx2tVjVmPdtWLuUO860Eg3YSAjAw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720415682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pEomUY7EA/AKConWTE1BA8iU5+YPujwJNjXr2qbA40U=;
	b=bHN/sYmQLG3vsAenTJdBDeEr5YU7+rMLTji9fB+YsJVQ8iPTp212Ts0Y2/qPeBUkcEJIyR
	RzOeU/HJTiNwIhdopjbG3GJG/EnQGCUJAIHZ991zqCjfJDV2SDZNolwbW6zuFWoQXm4eIu
	XLzZx2tVjVmPdtWLuUO860Eg3YSAjAw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9E4A1396E
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oBN7HMF1i2YbZwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jul 2024 05:14:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: add warning for -s option of btrfs-image
Date: Mon,  8 Jul 2024 14:44:15 +0930
Message-ID: <8496042fa1f667dc3ff479170c60d57b1646266f.1720415116.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720415116.git.wqu@suse.com>
References: <cover.1720415116.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 50.00];
	BAYES_HAM(-1.86)[94.18%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.66
X-Spam-Level: 

The filename sanitization is not recommended as it introduces mismatches
between DIR_ITEM and INODE_REF.

Even hash confliction mode (double "-s" option) is not ensured to always
find a conflict, and when failed to find a conflict, a mismatch would
happen.

And when a mismatch happens, the kernel will not resolve the path
correctly since kernel uses the hash from DIR_ITEM to lookup the child
inode.

So add a warning into the "-s" option of btrfs-image.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-image.rst | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/btrfs-image.rst b/Documentation/btrfs-image.rst
index a63b0da273c5..febbf3877c82 100644
--- a/Documentation/btrfs-image.rst
+++ b/Documentation/btrfs-image.rst
@@ -37,13 +37,16 @@ OPTIONS
         file system will not be able to be mounted.
 
 -s
-        Sanitize the file names when generating the image. One -s means just
-        generate random garbage, which means that the directory indexes won't match up
-        since the hashes won't match with the garbage filenames. Using *-s* will
-        calculate a collision for the filename so that the hashes match, and if it
-        can't calculate a collision then it will just generate garbage.  The collision
-        calculator is very time and CPU intensive so only use it if you are having
-        problems with your file system tree and need to have it mostly working.
+	Sanitize the file names when generating the image.
+	Not recommended as this would introduce new hash mismatch, thus if your
+	problem involves subvolume tress, it can even mask the existing problems.
+
+	One *-s* means just generate random garbage, which means that the
+	directory hash won't match up its filenames.
+	Using two *-s* will calculate a collision for the filename so that the
+	hashes match, and if it can't calculate a collision then it will just
+	generate garbage.  The collision calculator is very time and CPU
+	intensive.
 
 -w
         Walk all the trees manually and copy any blocks that are referenced. Use this
-- 
2.45.2


