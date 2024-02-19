Return-Path: <linux-btrfs+bounces-2491-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A7C85A1AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09D71F22D0A
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADDC2C1AA;
	Mon, 19 Feb 2024 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c+tENkvr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c+tENkvr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252C2C18E
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341208; cv=none; b=PmbVuZy7DdU+BIMC4dQ5l0Q1+uo++BLRzs8IBKCchTnXE3ObkNvSjqm5l8SY6Jg0xfhMiNX+5IaMZt04BxURuFd5VmH20YVp/zs8FcpMjhuWc+Mt1nGeb4CPwG5n+v6N5jbaz+33FrLf1GWFHNSjXiPcQiBuSnGiZnWTpiECGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341208; c=relaxed/simple;
	bh=SiiQLWI+uVonLmlXhTP7H6oHOCxAFJ3dnmeFvjlyV8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWI9+QXzdGEmQchWsNku3vf6FrKBBwRaWONPdXDpL02kooOLDWei6B1fKcVh11etLS9ItJa5hVuDqvgAxNpHIa289gutU6eq6rwWRowK8XWOR0D9Be6yqc/8a4092p3HjgIKJLKggX0ubdjjsIAmToRRXF9DsewP2Otbh8zDqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c+tENkvr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c+tENkvr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 18B8022300;
	Mon, 19 Feb 2024 11:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708341205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxiKKdf1NYV8KrvHaSVaQjfWqcRvIdNjJGXAx33fgtk=;
	b=c+tENkvrkgdMekG8BdOAcsg0j5ot7WRkMkLbRCTqV/c66PsJq1dZ+TwsaChKUhZ8BYl5zD
	ukGao4l0hdf+i4QasZ307xINGseR9g1dEe6QcZXy11u3HfHRpyfZ8xMsqTuF19C8VTB4XC
	EihNziiWnGZK1BL62cwLTP8yQ0Fo4SM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708341205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxiKKdf1NYV8KrvHaSVaQjfWqcRvIdNjJGXAx33fgtk=;
	b=c+tENkvrkgdMekG8BdOAcsg0j5ot7WRkMkLbRCTqV/c66PsJq1dZ+TwsaChKUhZ8BYl5zD
	ukGao4l0hdf+i4QasZ307xINGseR9g1dEe6QcZXy11u3HfHRpyfZ8xMsqTuF19C8VTB4XC
	EihNziiWnGZK1BL62cwLTP8yQ0Fo4SM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 11EC2139C6;
	Mon, 19 Feb 2024 11:13:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Ft5dBNU302WCZgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 19 Feb 2024 11:13:25 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/10] btrfs: open code btrfs_backref_iter_free()
Date: Mon, 19 Feb 2024 12:12:49 +0100
Message-ID: <5dd7da97f6874bdd4d99ae277821d16aaa3a0fa5.1708339010.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708339010.git.dsterba@suse.com>
References: <cover.1708339010.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[20.42%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

The helper is trivial and used only once, open code it. It's safe to
remove the 'if', the pointer is validated in build_backref_tree().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.h    | 8 --------
 fs/btrfs/relocation.c | 3 ++-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 523e594ac753..493ea47db426 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -283,14 +283,6 @@ struct btrfs_backref_iter {
 
 struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info);
 
-static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *iter)
-{
-	if (!iter)
-		return;
-	btrfs_free_path(iter->path);
-	kfree(iter);
-}
-
 static inline struct extent_buffer *btrfs_backref_get_eb(
 		struct btrfs_backref_iter *iter)
 {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2fca67f2b39b..f96f267fb4aa 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -523,7 +523,8 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 	if (handle_useless_nodes(rc, node))
 		node = NULL;
 out:
-	btrfs_backref_iter_free(iter);
+	btrfs_free_path(iter->path);
+	kfree(iter);
 	btrfs_free_path(path);
 	if (err) {
 		btrfs_backref_error_cleanup(cache, node);
-- 
2.42.1


