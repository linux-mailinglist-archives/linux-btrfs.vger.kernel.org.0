Return-Path: <linux-btrfs+bounces-3836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1AA895F57
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 00:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F351C231D2
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 22:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8EC15ECD3;
	Tue,  2 Apr 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j0dpbK6R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C05315ECC2
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095692; cv=none; b=bZgyFDFkn+RHFLv4Hush8O/zDljBBIZqAAP8Js3SpJlDjE64VCTTUeGD9fqL3vOBjjyId6dtd2DcnDUxZZKjJ7c96XncDKD35cOdDFRWUTGaACxiGFvac27YbCytqWFMxODaxKK+ZY6bpiybSEA1U0X+sUi1cfG0MmXUpcUxblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095692; c=relaxed/simple;
	bh=5RjL8I2QRD7HhDPJwAHsBSEXx1BXdgcSyL4p55lIUcs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Crsh0ZP+AAae6jN9GmbleZ/5gqY/ivVEc/rzYQ5hSd29BcqS+5K3nf7ls9bp2SWaSmDxLXFNZpiZpUy4sEPhhmMWbQAXaESebR6jEylmR8/WqyrJlJNmDOoHrQtUjQhWjKP4/f4YJxw1x179cLjx3q/lqU1cu6B/kXmej3mefUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j0dpbK6R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 413295C3FA
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712095689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eZ5svEWEtzMaa6FcvFfBpA1NZNfT9qxx6JvzO+Y9CM=;
	b=j0dpbK6RvzEnmnrJW/osCfoPe9+ZE059Gw3g66Vw+s3E0CvH1rCBwhgBFNXeHKbaz50ajk
	tXaV88PzUblDzemzJmGPHfCkb17wdwjEfPcI7fqwUSkrT8qf5pOLui6Arc+OWIfpjkXtmP
	/Ipilh3gxoaEeNGw6XHsKrLQf0ydDH8=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AEFE13A90
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AJG7A8iBDGYIdwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 22:08:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/5] btrfs-progs: tune: add the missing newline for --convert-from-block-group-tree
Date: Wed,  3 Apr 2024 08:37:36 +1030
Message-ID: <39cc5f46367eec2769ab2dc45c38e350001dfa0f.1712095635.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712095635.git.wqu@suse.com>
References: <cover.1712095635.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[41.92%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.20
X-Spam-Level: *
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


