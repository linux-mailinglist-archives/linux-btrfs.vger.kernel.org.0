Return-Path: <linux-btrfs+bounces-10977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B36CA12E55
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 23:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F92C164D15
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 22:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADDF1DD0DC;
	Wed, 15 Jan 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZqgUCGtq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZqgUCGtq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F019CC2A
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980570; cv=none; b=OTgiXQm+yeUnG4hJVQlY+IV+zy/dBqo+/5GZLuWh3qBJhbI/bPw4ys94zVop9tHoY3Tl2SliXYYd4LgkNZWRcUGfB25mUEax5jgL22eTFPB3aC85XipONGJkpzqd/sEcv0DYLGllUSYukWMy0KbGvb3OMAiTCdsaVU7zJCcps7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980570; c=relaxed/simple;
	bh=MsESbac67sWqsn0+eECsAhsYrBfSfBtlEqLlFoLz9eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohNkBmRgU3Np+374AM5fMShbL0etjqkPDECsXpsJtNCOg/2zyX1ewHC9NpYcNd++OkuhzqMp0sA4vxHLaiFYxxQyYiZyUJsTEOq/KIq8F/jloAPMF7s6FeFKsf6OlK/M4nzvuLyJT7w2IRTyyvk2NNZ/NTzzGp88zTCqQnI6Kbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZqgUCGtq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZqgUCGtq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E8E51F37E;
	Wed, 15 Jan 2025 22:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736980564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5JyW5QAYsceuMosTfCLDctGJ5xMdYOSrTeqU+2Ro4N8=;
	b=ZqgUCGtqKdS+Myl7+26a8HYbUn6Ny3Gm9ICqdQzwFkYvoYZwit8zdO5JmzM9d2u+dsp4Uw
	g8nKTEd2aMyZlw5h+wLkDkT8AD5DMhJ3aG0Ea8hMsiakR5d4sqIboorGJc4Fv3oHpjrsfJ
	Vl4XYmCQm0IA7iHrhY6GLzzfNajrQLw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZqgUCGtq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736980564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5JyW5QAYsceuMosTfCLDctGJ5xMdYOSrTeqU+2Ro4N8=;
	b=ZqgUCGtqKdS+Myl7+26a8HYbUn6Ny3Gm9ICqdQzwFkYvoYZwit8zdO5JmzM9d2u+dsp4Uw
	g8nKTEd2aMyZlw5h+wLkDkT8AD5DMhJ3aG0Ea8hMsiakR5d4sqIboorGJc4Fv3oHpjrsfJ
	Vl4XYmCQm0IA7iHrhY6GLzzfNajrQLw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B145139CB;
	Wed, 15 Jan 2025 22:36:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qe1JB1M4iGcVAwAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 15 Jan 2025 22:36:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Vojtech Lacina <vlacina@suse.com>
Subject: [PATCH] btrfs-progs: doc: add a note on qgroup limit with inconsitent flag
Date: Thu, 16 Jan 2025 09:05:45 +1030
Message-ID: <65fec6abc4fb84a7122908138f8d7f10b808605d.1736980516.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E8E51F37E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Just like all qgroup functions, if qgroup is marked inconsistent, limit
will not work as expected.
In fact with recent kernels, limit and qgroup number updating will be
fully skipped if qgroup is already inconsistent.

Add one extra note on `btrfs qgroup limit` subcommand for it.

Reported-by: Vojtech Lacina <vlacina@suse.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1235765
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-qgroup.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/btrfs-qgroup.rst b/Documentation/btrfs-qgroup.rst
index b90cfbb5406b..0aeeb5029261 100644
--- a/Documentation/btrfs-qgroup.rst
+++ b/Documentation/btrfs-qgroup.rst
@@ -31,6 +31,11 @@ ownership. For example a fresh snapshot shares almost all the blocks with the
 original subvolume, new writes to either subvolume will raise towards the
 exclusive limit.
 
+.. note::
+   Qgroup limit only works when qgroup is in a consistent status.
+   If by some workload, qgroup is mark inconsistent, the limit will no longer
+   work until the inconsistent flag is cleared by a rescan.
+
 The qgroup identifiers conform to *level/id* where level 0 is reserved to the
 qgroups associated with subvolumes. Such qgroups are created automatically.
 
-- 
2.48.0


