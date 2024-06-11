Return-Path: <linux-btrfs+bounces-5628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B775A903113
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 07:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BA51F29951
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 05:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5E6171E4D;
	Tue, 11 Jun 2024 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZZDHIfuI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZZDHIfuI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CEC17083A
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083327; cv=none; b=m02E1h15+ESr+NlNeKzuXk+yt7At9w7oZr4W4GfDJ7qUXl7FYbhdND2sAQoWvSdgI4p18em3OVi4gmOZyW05XMGJULu4jY0lmI6mUzQIevzHnk0ECmu0BkK7qz2+YlHRm9lixuORAmesh/aHx+Cm9GHQLrmp9cJBS20zbQWcclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083327; c=relaxed/simple;
	bh=IAI6DM1kWeuwHE83BPXbJBruvB5XmBym1E2g4DgcKhU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjK7Qln7K4Hl8WdkUa8a1nngKFqE8yajjgmnO9jf2jnC7MCpX0jPgKce6QJRShsPfDj3eoTWqdn/8bct1Yk18+EKbgnYpkE1nbRGA49eSv5dkwvxBA4dacTqdcBtlVxGDAC26DxTwtx7D1QaSVGFgWJ60RT5h0/hDyHOSopfj/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZZDHIfuI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZZDHIfuI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 274FF20462
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718083323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5PKL0KSDIvJ8dBLyh/egV+E2FzZCEbBswxEVDFHFFM=;
	b=ZZDHIfuIfCwNXaOMU9ukffiT7khe6bpjGW4fqCtKxdv5jZgwI+VJxZhn1POJCrdw7HOoku
	QjBCCOwNLusQm2384sz3UWNOwOe8KK21DIA4uwNU8eQSvkdua+f8jS0OntEEYPQUjwh/Xj
	etDBUKX6mVC011g6ph6jndbyGymT7KI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZZDHIfuI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718083323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5PKL0KSDIvJ8dBLyh/egV+E2FzZCEbBswxEVDFHFFM=;
	b=ZZDHIfuIfCwNXaOMU9ukffiT7khe6bpjGW4fqCtKxdv5jZgwI+VJxZhn1POJCrdw7HOoku
	QjBCCOwNLusQm2384sz3UWNOwOe8KK21DIA4uwNU8eQSvkdua+f8jS0OntEEYPQUjwh/Xj
	etDBUKX6mVC011g6ph6jndbyGymT7KI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E0D013A51
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CIoMNPneZ2Y6KAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: remove unused Opt enums
Date: Tue, 11 Jun 2024 14:51:35 +0930
Message-ID: <f97d2899f6e701257b3304d553af79d39ea8e2f3.1718082585.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718082585.git.wqu@suse.com>
References: <cover.1718082585.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.77
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 274FF20462
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.77 / 50.00];
	BAYES_HAM(-2.76)[98.97%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

The following three Opt_* enums are not utilized at all:

- Opt_ignorebadroots
- Opt_ignoredatacsums
- Opt_rescue_all

All those handling are inside "rescue=" mount option groups, and there
is no corresponding token for them, so we can safely remove them.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 549ad700e49e..902423f2839c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -125,9 +125,6 @@ enum {
 	Opt_rescue,
 	Opt_usebackuproot,
 	Opt_nologreplay,
-	Opt_ignorebadroots,
-	Opt_ignoredatacsums,
-	Opt_rescue_all,
 
 	/* Debugging options */
 	Opt_enospc_debug,
-- 
2.45.2


