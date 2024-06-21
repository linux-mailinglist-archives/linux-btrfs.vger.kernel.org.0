Return-Path: <linux-btrfs+bounces-5864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65D0911A35
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 07:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58537283245
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 05:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C35912F5A1;
	Fri, 21 Jun 2024 05:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eOBq87YG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eOBq87YG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE2A47
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947044; cv=none; b=CMqHGO4UfNACmuqp9vnSBIsxhSm5PUf+Kt5EZPeJ+rO2xlFAWV2UTq69hXYDhHqlSShAqYlBwgSBeSgNEVLc5mg3rhxmBspaotxdZO1EEfVnZX6/sPgGRMf7YzaCbXwZsXZ9+dayz549GH/uoArsgCgEP0qkXENoVhMjz0yTJu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947044; c=relaxed/simple;
	bh=ycrtJLL4IICmxwVCqxkgfln6MkDtJsJbc8Nph+op2Gc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kO2eUKCbs0ngZUZAjzedEn71xg9xsAbuNue2n/5tnMG3RE5nZ510JYJRx67C+gI3doxN0XMgcG5twvFw2JjIUWLQiSfj0C0hyr90PDJg68Y4w3lAFSlVtDSm9DNLfgRJ0ztC3dtCXqlYKT8IdmDTE4iKlm7UWC1aOYZt8cXSNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eOBq87YG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eOBq87YG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB1451FB3B
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718947040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTxChFJpk0pIXnZORV+cGUkP80j6sNLhMF1bPOxN5rE=;
	b=eOBq87YGQgjw+Wajyi33s+nCnq9YW0LRlRdvlHPhUfW1tL4BtJEQ6Z2gzxWwHs+V/m2GmB
	HBj3cnqbnmnvEdoAOGIH3KNB0CXhnE0NsKJSwAMpHU8ZUCcVQYaFm2JG0fEnRbJW9jcoKJ
	iO+28lmro0XzZAof+/CN9DnCcC+XNQA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718947040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTxChFJpk0pIXnZORV+cGUkP80j6sNLhMF1bPOxN5rE=;
	b=eOBq87YGQgjw+Wajyi33s+nCnq9YW0LRlRdvlHPhUfW1tL4BtJEQ6Z2gzxWwHs+V/m2GmB
	HBj3cnqbnmnvEdoAOGIH3KNB0CXhnE0NsKJSwAMpHU8ZUCcVQYaFm2JG0fEnRbJW9jcoKJ
	iO+28lmro0XzZAof+/CN9DnCcC+XNQA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D15BA13ABD
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oCpuId8MdWavbAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs-progs: csum-change: add error handling for search old csums
Date: Fri, 21 Jun 2024 14:46:54 +0930
Message-ID: <6bb6f483287cd3c15cabfabfbb81cc5c0392be32.1718946934.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718946934.git.wqu@suse.com>
References: <cover.1718946934.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.968];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Inside delete_old_data_csums(), after calling btrfs_search_slot() there
is no error handling at all.

Fix it by doing a proper error detection and abort the current transaction.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index 0e7db20f5e6d..0f95cdb25533 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -395,6 +395,13 @@ static int delete_old_data_csums(struct btrfs_fs_info *fs_info)
 		int nr;
 
 		ret = btrfs_search_slot(trans, csum_root, &last_key, &path, -1, 1);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to search the last old csum item: %m");
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+		assert(ret > 0);
 
 		nr = btrfs_header_nritems(path.nodes[0]);
 		/* No item left (empty csum tree), exit. */
-- 
2.45.2


