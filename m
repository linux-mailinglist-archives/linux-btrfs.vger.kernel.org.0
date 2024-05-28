Return-Path: <linux-btrfs+bounces-5309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168238D13F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 07:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68DF2848B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 05:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68C94D11B;
	Tue, 28 May 2024 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HxRmq567";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HxRmq567"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F41C6B8
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874458; cv=none; b=lEluyBvlEt3I0NDKegwbNkUMO5YBRuvN/EqB/a4P197npKzMCK/LvytA2OGdGrFWK+Evs35PwJ4vM0iI7lkQo4KfqL7/YfjXiGgD/BQvq802WIiuX4wysqyw/7p94PJQnG7mzlmIo4Y2JCclBt4IXC0STDM5ng6CXPAoUbeAw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874458; c=relaxed/simple;
	bh=H62UNhUr2ho2tGYnGoB9tHfr5LPu4BXJhA/8L2YQJYU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry7bsJ6Ju86GVisOS2BCpxVT8z4aw4L+yL67hOEfE/lIqBKVVR3UQcB3MN2t0wQjjtALarcD97yGNOmS1odKUJ2qr6Dm/D4gGOFjzJxF5vhl1jmqFyMi73G+42L+TpOK9VQen5+8Br4SfCytoOo8vjDAfkwDsJMonmCOnxSEdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HxRmq567; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HxRmq567; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8E2122577
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716874454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1o44RJwaTTXjliuIppS+DKbu3LMr1k6xJs7OqEK/RZY=;
	b=HxRmq567+D2Ev87JQGNF683uV9t4oqQPNkcaVex/ZUsoh+CNkkobc07ct8z5REBWUOCmhe
	p4F5I2VcFLVP+jWoC20y8Io5YLwxBipbiQwmpjudt1Js3+3yYgUm/5TchXixcMEXFpXKTl
	hmaUDOJTTheyRug+L8gUmUHjT0jtHKY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716874454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1o44RJwaTTXjliuIppS+DKbu3LMr1k6xJs7OqEK/RZY=;
	b=HxRmq567+D2Ev87JQGNF683uV9t4oqQPNkcaVex/ZUsoh+CNkkobc07ct8z5REBWUOCmhe
	p4F5I2VcFLVP+jWoC20y8Io5YLwxBipbiQwmpjudt1Js3+3yYgUm/5TchXixcMEXFpXKTl
	hmaUDOJTTheyRug+L8gUmUHjT0jtHKY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7D4013A83
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6LKpGtVsVWYpdAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:34:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: do not directly rwlock_types.h
Date: Tue, 28 May 2024 15:03:48 +0930
Message-ID: <1c461e2717312cb530377a519316a8c64cd13c09.1716874214.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716874214.git.wqu@suse.com>
References: <cover.1716874214.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[]

There is already an error inside that header:

 #if !defined(__LINUX_SPINLOCK_TYPES_H)
 # error "Do not include directly, include spinlock_types.h"
 #endif

Thankfully it never get triggered as some other headers have already
included spinlock_types.h.

However clangd would still do a proper warning on that if only
extent_map.h is opened.
Fix it by using spinlock_types.h instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index d3d1e5b7528d..5154a8f1d26c 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -4,7 +4,7 @@
 #define BTRFS_EXTENT_MAP_H
 
 #include <linux/compiler_types.h>
-#include <linux/rwlock_types.h>
+#include <linux/spinlock_types.h>
 #include <linux/rbtree.h>
 #include <linux/list.h>
 #include <linux/refcount.h>
-- 
2.45.1


