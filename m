Return-Path: <linux-btrfs+bounces-21458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BsXwLijBhml1QgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21458-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 05:35:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3FC104EB3
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 05:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 247AF3018C09
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Feb 2026 04:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6982D7DD1;
	Sat,  7 Feb 2026 04:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DcoJRwz/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DcoJRwz/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC72BE657
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 04:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438944; cv=none; b=RYUMt8KHyNGhWIVpfqvSQ3QTohkIeAqMk7KJr9T48eFLQsJx+Fr22AKxNLoc60+KeUerqkWh+mkpP75BPJMbLFJ2W7IMDghCNRClEXpMUXCVfFJZ1DiMjbqWbmXm6CfwY1IFMV0AXD92MvTANjm4uScsx66k34mmdxypTn1dSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438944; c=relaxed/simple;
	bh=HAWrRRNryCnBR1QVFH39aNpxKZfVCxqJdFDy0gzXQtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwZURBJ2cEobzVJQQKr/OsKjYGPi/U+YFhUTPDlYQRtPCpQLBi/QWK4tl+Hj3l/SFONRbtucsvJqVhj3YHL/jyY28Rt9zAsS2PYejCImvBU/nvM93LDYXpMWLcO/g7aB+8VrJeWlg/91GFOP0INABMSvY1VR2+GG4cT/ZVBFHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DcoJRwz/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DcoJRwz/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20DB83E6CD;
	Sat,  7 Feb 2026 04:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770438942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1yHClctTzv367wW03OQKcVlDjfI0sotwdQk6C+RKPgg=;
	b=DcoJRwz/ejULz+GTIm9f1822sfsXMVcnruUnYhy8Ou7lfCpbSno7L23nOEPUwGTutlZcpH
	mkqznhzpQc/QjJUPi7Ufc7Paky3k/25ScVsVCEDaEp5FarEWWDe4tILmi/GErQBmdMYcFs
	Ij/NC26K6T406hBa84Kt3wHPRsq840k=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770438942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1yHClctTzv367wW03OQKcVlDjfI0sotwdQk6C+RKPgg=;
	b=DcoJRwz/ejULz+GTIm9f1822sfsXMVcnruUnYhy8Ou7lfCpbSno7L23nOEPUwGTutlZcpH
	mkqznhzpQc/QjJUPi7Ufc7Paky3k/25ScVsVCEDaEp5FarEWWDe4tILmi/GErQBmdMYcFs
	Ij/NC26K6T406hBa84Kt3wHPRsq840k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 100EC3EA63;
	Sat,  7 Feb 2026 04:35:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RDZ2MBzBhmm0LQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 07 Feb 2026 04:35:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Anton Mitterer <calestyo@scientia.org>
Subject: [PATCH] btrfs-progs: docs: add a note for clear_cache mount option
Date: Sat,  7 Feb 2026 15:05:22 +1030
Message-ID: <bac89ac52147344ab6244beef8c0085552a3aacb.1770438921.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21458-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[scientia.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 2B3FC104EB3
X-Rspamd-Action: no action

There is a report that "clear_cache,space_cache=v2" mount option didn't
rebuild the free space tree.

It turns out that the reporter was relying on the fstab to do the mount,
and the fstab has specified "ro" mount option. This prevents btrfs to
enter btrfs_start_pre_rw_mount() thus no free space tree rebuilding.

Add such note to avoid future confusion.

Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Link: https://lore.kernel.org/linux-btrfs/f094ddbb70cabd2e329615269519b1844f786629.camel@scientia.org/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/ch-mount-options.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ch-mount-options.rst b/Documentation/ch-mount-options.rst
index 60f8570e9d1a..8f65b8311e7e 100644
--- a/Documentation/ch-mount-options.rst
+++ b/Documentation/ch-mount-options.rst
@@ -73,6 +73,7 @@ barrier, nobarrier
 clear_cache
         Force clearing and rebuilding of the free space cache if something
         has gone wrong.
+        This option only takes effect on the first read-write mount.
 
         For free space cache *v1*, this only clears (and, unless *nospace_cache* is
         used, rebuilds) the free space cache for block groups that are modified while
-- 
2.52.0


