Return-Path: <linux-btrfs+bounces-6554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6BC937091
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB8A281B6F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 22:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABA2146591;
	Thu, 18 Jul 2024 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pMj34eK/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pMj34eK/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520D1145FFF
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721340675; cv=none; b=Rh+1M+6wvVssGz0vmcJaHSF671W6U0JvBTKQQ1N0lJe+zzdfP4xc0hL1LL/TsS3aabwfIcjZ6rjHMLuGJa5P2pzo/tVbGgGWLFMcG+R+7Q0x9Kz3q4Ujnl0P6m91lrEXRmA30WdlZrTJ7dpu8kIIYVxhxSC4iRPRJKuaJSWbNh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721340675; c=relaxed/simple;
	bh=1Zz7eL23TR183MsHYUz24bI1nAG//d5VOFzMp/BmWjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q01H4RQRxDchFXdU1D57EltPqXBJ64kB8TphYcCNFv3lXLMZBX9fJKTmih9hOhqEXYYieuf8GgbyWgGyJY7M6MRw0PEUgN0ibbcGlTNHmKEqaX6+7odXiQGe/Mu/vtW/4Y2yTr86h5RQxagDZzEDPs2+4yem0CPDMCbZ+9icGxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pMj34eK/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pMj34eK/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68D1B21AC5
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721340671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hID4vMZY0qpx30RjnFp/D8y/1d+EJEWMFKqhKYPk4Q=;
	b=pMj34eK/qeXjssXrt9rBusHhHxsvoCW+FUkiInDpzQk428Vi0nyMqKu5+yHtxTJptTXadT
	W4mwopTtvFZbXi7zqa1tGwWXMEt/JZ/iuxbq39pbL7+3i4gZTsUCwJxaIC8a5M5Rlb4BUL
	U028d0y7QAZIVTW4LQ4pJiGWnKinY5A=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721340671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hID4vMZY0qpx30RjnFp/D8y/1d+EJEWMFKqhKYPk4Q=;
	b=pMj34eK/qeXjssXrt9rBusHhHxsvoCW+FUkiInDpzQk428Vi0nyMqKu5+yHtxTJptTXadT
	W4mwopTtvFZbXi7zqa1tGwWXMEt/JZ/iuxbq39pbL7+3i4gZTsUCwJxaIC8a5M5Rlb4BUL
	U028d0y7QAZIVTW4LQ4pJiGWnKinY5A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DCDF1379D
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YOkmEv6SmWZZFwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs-progs: tests: use feature output from "btrfs --version"
Date: Fri, 19 Jul 2024 07:40:44 +0930
Message-ID: <a920ac0e335cdc5998d6dee8d6a017253b3997ca.1721340621.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721340621.git.wqu@suse.com>
References: <cover.1721340621.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *

With the new feature matrix output in "btrfs --version" there is no need
to do the config.h hack to determine if we have certain feature.

This would provide a more reliable way to detect features.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/common b/tests/common
index e996b35af787..4800ef8e77c9 100644
--- a/tests/common
+++ b/tests/common
@@ -12,11 +12,7 @@ _test_config()
 {
 	local feature="$1"
 
-	if [ ! -f "$TOP/include/config.h" ]; then
-		echo "include/config.h not exists"
-		exit 1
-	fi
-	if grep -q "$feature.*1" "${TOP}/include/config.h"; then
+	if "$TOP/btrfs" --version | grep -q "+${feature}"; then
 		return 0
 	fi
 	return 1
-- 
2.45.2


