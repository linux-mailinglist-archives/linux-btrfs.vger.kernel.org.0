Return-Path: <linux-btrfs+bounces-5433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D331E8FAA0A
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 07:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2F284B1E
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 05:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A413DDA6;
	Tue,  4 Jun 2024 05:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nB2Q+JQh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nB2Q+JQh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604A13D2AB
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717479406; cv=none; b=W2uvK1nX+5iOy8GxAC4Xj6k6AyH62qcvlCTXVwR+PJa7/NNMOK+7J/ludEouCbjtcIR5si9mjnqUWfrdD1pnJ3R03dJpSfBovn9yWNfq4ngUTBT0dyeoSBJIk6pExQ3/bzo4uI7oFpjD5Fa+WvaQGiWWpQpMYlXh3VM36cFnrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717479406; c=relaxed/simple;
	bh=dNJiGyN5RQobsjC4r6xNYGrJR7bKW7XqNiVEaKCdZq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZZrMk2yF2bOnmVpMqJ166BFg/5ZYK+2KYXG++HuGkoqGJEVbCX6Whqzbg8wRS69o44hYEqDRbkyhyeZ5E3v7mv1Cg4mnUYioUerf9YImeJjzcgz4zufijMxM4s+h7oeyCBUBmqh+3YXCu9Kkb9r5FGfafPeWFLcP2KncsAu0pEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nB2Q+JQh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nB2Q+JQh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 480A0219B5
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 05:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717479401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8C78pXHCaXveaI3crtPzVP2tP54R0Uec0M/sggVngbk=;
	b=nB2Q+JQh228iAxb19Ambfi5L6WHoOmd9PPOZ5aGBwi0LpoAmKdmZd8jDzyrwFXNPexXeVS
	IcSdkx8wINPgI8TN3zoSvC+tnSTsE+8fF6oLKOWMCnQq10k4XtppA58gkVjWk2+eRfX9DN
	0iSVjEvDS6WvycdJtaOa9uMCNCBbD0g=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nB2Q+JQh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717479401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8C78pXHCaXveaI3crtPzVP2tP54R0Uec0M/sggVngbk=;
	b=nB2Q+JQh228iAxb19Ambfi5L6WHoOmd9PPOZ5aGBwi0LpoAmKdmZd8jDzyrwFXNPexXeVS
	IcSdkx8wINPgI8TN3zoSvC+tnSTsE+8fF6oLKOWMCnQq10k4XtppA58gkVjWk2+eRfX9DN
	0iSVjEvDS6WvycdJtaOa9uMCNCBbD0g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D9581398F
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 05:36:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 62mvCOinXmbiYAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 05:36:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: error out immediately if an unknown backref type is hit
Date: Tue,  4 Jun 2024 15:06:22 +0930
Message-ID: <a8cb7544a9369a309212cf648facc4cf51199616.1717479367.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.38 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.37)[76.87%];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -0.38
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 480A0219B5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

There is a bug report that for fuzzed image
bko-155621-bad-block-group-offset.raw, "btrfs check --mode=lowmem
--repair" would lead to a deadloop.

Unlike original mode, lowmem mode relies on the backref walk to properly
go through each root, but unfortunately inside __add_inline_refs() we
doesn't handle unknown backref types correctly, causing it never moving
forward thus deadloop.

Fix it by erroring out to prevent deadloop.

Issue: #788
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/backref.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/backref.c b/kernel-shared/backref.c
index 89ccf073fca7..f46f3267e144 100644
--- a/kernel-shared/backref.c
+++ b/kernel-shared/backref.c
@@ -650,7 +650,8 @@ static int __add_inline_refs(struct btrfs_fs_info *fs_info,
 			break;
 		}
 		default:
-			WARN_ON(1);
+			error("invalid backref type: %u", type);
+			ret = -EUCLEAN;
 		}
 		if (ret)
 			return ret;
-- 
2.45.2


