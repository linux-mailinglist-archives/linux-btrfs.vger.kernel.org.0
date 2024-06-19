Return-Path: <linux-btrfs+bounces-5806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A3D90E2B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 07:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17815284384
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 05:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7763B57C8E;
	Wed, 19 Jun 2024 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FJOXX2aP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FJOXX2aP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A954FAD
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775243; cv=none; b=QfExJwESKbytTuqSmJZOZfkSV7AagvDA60TxzXVU/XhEZu5l2kj+Y910b8+SIbCJlg/0GUjDh201m1uuxCYPVoZinWg0DpJjeeXOFutMMgWdWFSv8CMAzPXu65xASO5GnB75tMzLk8+gDfvMuNIvLcIHItuEGgJO3ntIACuBf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775243; c=relaxed/simple;
	bh=ycrtJLL4IICmxwVCqxkgfln6MkDtJsJbc8Nph+op2Gc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZCpaY2RUboljPYGVJHVLJHs/jPSDCVE7q5+M9B+12pDvun5CTxHFYloKNa8nopqNZbbXDZSI7OJNTKAnf6JeWMn5Kudk11raCqjYI4Yu4tH2KAjJEvZ1fEvELBfB7U64IrbaQmtUPj4D1Jq6xtvFni7wT9gBLevj3RXGYqRopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FJOXX2aP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FJOXX2aP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6250821A2A
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718775240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTxChFJpk0pIXnZORV+cGUkP80j6sNLhMF1bPOxN5rE=;
	b=FJOXX2aPyEhypWGJ1TYuOn5EEoZnmL0kId2eFIKDEHYp1W4uD+T3LTvYkzjrqTOR44rB0C
	G+ij8jqWrAGLt4NUTQnnuPy+S0VIZj2EIUUbfj1G+SwQtocL9KiS6waDI86q4KU3axKMzO
	cn8OHq6er5w9jGtYQwAlfgT+ya3JLdE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718775240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTxChFJpk0pIXnZORV+cGUkP80j6sNLhMF1bPOxN5rE=;
	b=FJOXX2aPyEhypWGJ1TYuOn5EEoZnmL0kId2eFIKDEHYp1W4uD+T3LTvYkzjrqTOR44rB0C
	G+ij8jqWrAGLt4NUTQnnuPy+S0VIZj2EIUUbfj1G+SwQtocL9KiS6waDI86q4KU3axKMzO
	cn8OHq6er5w9jGtYQwAlfgT+ya3JLdE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78CE813AAF
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:33:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uKPyC8dtcmYUaQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:33:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: csum-change: add error handling for search old csums
Date: Wed, 19 Jun 2024 15:03:37 +0930
Message-ID: <274dd5b77399abb5881916d466a6a010455a1565.1718775066.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718775066.git.wqu@suse.com>
References: <cover.1718775066.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.54
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.54 / 50.00];
	BAYES_HAM(-1.74)[93.39%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
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


