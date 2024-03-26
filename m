Return-Path: <linux-btrfs+bounces-3580-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A4E88B5FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 01:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FC41C34D08
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 00:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB50C23D7;
	Tue, 26 Mar 2024 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f5aqijCQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f5aqijCQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CF173
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412596; cv=none; b=Ivo5xrp4Gx51c11LKntbFQ6Jw6w30kfm6Y33a2iHJfXr6TLH5Jav1OM8vHTetIJ/9RJrJ+9tuV46f7LavgF0h8R8818Uo4ZbaVIBBU5d4vxfKkL/AASvTw8hv9gktZH6WzqfTDZukIFhylS52tDQEpMKWKBGwYHUjwssbhiKEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412596; c=relaxed/simple;
	bh=5RjL8I2QRD7HhDPJwAHsBSEXx1BXdgcSyL4p55lIUcs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9cV+Xb7/3eSOJYLGaySD9BYnVX6VCTLH8kTd3EKw9p2+K/CyF4GYGj+KiQLx0d/9o1p6nSPywQZaHyXpvE5QM3iu0AESI0GmIIFUrY7tHpf8U+VZDCz23PaaCSc25D8hTjSEiXIm9vh5idTRbrxN0Dcx0GrtFpM4zvsWPyhPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f5aqijCQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f5aqijCQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F1AB5CE28
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711412593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eZ5svEWEtzMaa6FcvFfBpA1NZNfT9qxx6JvzO+Y9CM=;
	b=f5aqijCQjI+z3aR38xw+YkMX6R0jzlLwNOl3O9+3/riwrFMAKZVFoOOD+fc+v5ylgTpyT7
	UV70nhLRjOc4v15aDKT0FUwOAHVFCbk8dmg14SA0GKF44w4veJklYoW+O0sRX7j3zqjpIy
	09D7jURCW265Mb7WUVgDyp20qY6T0PM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711412593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eZ5svEWEtzMaa6FcvFfBpA1NZNfT9qxx6JvzO+Y9CM=;
	b=f5aqijCQjI+z3aR38xw+YkMX6R0jzlLwNOl3O9+3/riwrFMAKZVFoOOD+fc+v5ylgTpyT7
	UV70nhLRjOc4v15aDKT0FUwOAHVFCbk8dmg14SA0GKF44w4veJklYoW+O0sRX7j3zqjpIy
	09D7jURCW265Mb7WUVgDyp20qY6T0PM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3320B13586
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KAPlNW8VAmbOJAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs-progs: tune: add the missing newline for --convert-from-block-group-tree
Date: Tue, 26 Mar 2024 10:52:42 +1030
Message-ID: <989f76ff228860f64742c7a6672c5f699fea0c18.1711412540.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711412540.git.wqu@suse.com>
References: <cover.1711412540.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=f5aqijCQ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.34 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.995];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.15)[95.92%]
X-Spam-Score: 1.34
X-Rspamd-Queue-Id: 0F1AB5CE28
X-Spam-Flag: NO

There is a missing newline for a successful
--convert-from-block-group-tree run, meanwhile
--convert-to-block-group-tree has the correct newline.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/convert-bgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tune/convert-bgt.c b/tune/convert-bgt.c
index dd3a8c750604..1263b147241e 100644
--- a/tune/convert-bgt.c
+++ b/tune/convert-bgt.c
@@ -270,7 +270,7 @@ iterate_bgs:
 		return ret;
 	}
 	pr_verbose(LOG_DEFAULT,
-		"Converted filesystem with block-group-tree to extent tree feature");
+		"Converted filesystem with block-group-tree to extent tree feature\n");
 	return 0;
 
 error:
-- 
2.44.0


