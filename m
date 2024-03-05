Return-Path: <linux-btrfs+bounces-3027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E42F87272A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 19:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF28C283231
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 18:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2F624B59;
	Tue,  5 Mar 2024 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="O/zZO0Ck";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="O/zZO0Ck"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2CD1426F;
	Tue,  5 Mar 2024 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665174; cv=none; b=Pm/SGOgr/vBzsr1LbqL1WbROFxDWjGTxNPDZ/WT6aM3xq6WDbJWLWgYSCgy6Y4ucCHJZbU+I9T8r1MQSJgGiG7u1aqcPW9uTS/nCW3A0879eas3w2LXyX3VEPoM/1PP65bXPEba/xqFOYd8INSAGrBd3E5q2dsi/ovMypQSYFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665174; c=relaxed/simple;
	bh=eBrVNw/7RDH4IpC2Fh0sHri8bnCHqBFkU5ohnmhIpAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV2hOQfx86UDrDjMByrcFpJvKuukTH7aptCdCR2Ukpjlr9wGOaJf6eFWTnvs6idgg7stOSdxza734evNuyPV+Sz1u3FpyIeZv1RwMyKE4LStkC+PDvioJwRn0jgz2obI8fUXiH/XFhv1RqgSrPboFtu0ac+knX7/AjNGIgs4m18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=O/zZO0Ck; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=O/zZO0Ck; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 089C75BFEA;
	Tue,  5 Mar 2024 18:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4namxjqkGOrU39sN8Z00UgoTwnohx8omcDJ2Y7zZyX0=;
	b=O/zZO0Cku/aE+YnDXbHPX3Xh3qPfIgqjLyVpBvOIQ08mGql03zRcXsZu6w/cPMTojCGjhQ
	YsLBF2Q22ViA8AevlugGI9civPmRGnFWv1d62DQEiiU4LRGr4dg/YiqZaqCjYGdf65tG8Z
	ONw7NdnLU0MqAVhaXKZwPzUuQlUA3lU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4namxjqkGOrU39sN8Z00UgoTwnohx8omcDJ2Y7zZyX0=;
	b=O/zZO0Cku/aE+YnDXbHPX3Xh3qPfIgqjLyVpBvOIQ08mGql03zRcXsZu6w/cPMTojCGjhQ
	YsLBF2Q22ViA8AevlugGI9civPmRGnFWv1d62DQEiiU4LRGr4dg/YiqZaqCjYGdf65tG8Z
	ONw7NdnLU0MqAVhaXKZwPzUuQlUA3lU=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 02EAC13466;
	Tue,  5 Mar 2024 18:59:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Lxm0AI9r52VNBQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 05 Mar 2024 18:59:27 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs/291: remove image file after teardown
Date: Tue,  5 Mar 2024 19:52:22 +0100
Message-ID: <096e64b057469f65b6f2e36f5d96680235889273.1709664047.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1709664047.git.dsterba@suse.com>
References: <cover.1709664047.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="O/zZO0Ck"
X-Spamd-Result: default: False [4.66 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[56.49%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.66
X-Rspamd-Queue-Id: 089C75BFEA
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

From: Josef Bacik <josef@toxicpanda.com>

LVM doesn't like it when you remove the file out from underneath the
backing device.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/291 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/291 b/tests/btrfs/291
index c5947133239940..bfffb845fea740 100755
--- a/tests/btrfs/291
+++ b/tests/btrfs/291
@@ -20,9 +20,9 @@ _cleanup()
 {
 	cd /
 	_log_writes_cleanup &> /dev/null
-	rm -f $img
 	$LVM_PROG vgremove -f -y $vgname >>$seqres.full 2>&1
 	losetup -d $loop_dev >>$seqres.full 2>&1
+	rm -f $img
 	_restore_fsverity_signatures
 }
 
-- 
2.42.1


