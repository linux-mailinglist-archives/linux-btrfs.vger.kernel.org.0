Return-Path: <linux-btrfs+bounces-8139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A2797CFB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 03:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96AA28413F
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 01:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1ADB65C;
	Fri, 20 Sep 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nfOgfzvg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nfOgfzvg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB809B669
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726794026; cv=none; b=NFs05fTZAWNsVChpJyoqiRELDWF03OGEe29ru3T1kzRSufyCYMxVx2keiHjSUTYUy0Qon1V4whRKHSj2uK8QZrht9JcwP/AlkL1HWN0bySKnLhYXK+BYr60XX0NNATzp+/iGzYsHzGMeoE/BmvpQjR5o9bkRWas6Qy3xcYBS71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726794026; c=relaxed/simple;
	bh=eSrg69JOPWTm+DOcK6ZuhThBeIjIwxVxXrHcSqEblOc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aIEJuL6AEk2SxP+c4NayZH7F9fZDwp/II9DbY57x/sLdl4B3YMb596QtM2hleAOlnZpoyVNjmMYvVJgIBFCYk/5EIhwjjP74zW3OeA/u+xJARMstO3HMRTlrqe/O4sLH975EGp17RIjBapo7rAFRSRUZkTX9O65AWopAl0ACM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nfOgfzvg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nfOgfzvg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 253EF1F7EB
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 01:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726794022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=S1XDnHd9Od2phDICM3VDKiuPeTabGdtn697JsAIJI8M=;
	b=nfOgfzvgikTxdC5lqkDIyOu1djB4cFQ9T6zGcr1qdS/AvNKMlpqbJsMxDkK4Vyl1TpfyjS
	q1o0u6E+xcwu7/EqHBR9vpwzlSiMt8RBTGwpvJmHPqhQhT4F3E6FyBqBFCgoZ095AONP/l
	DoczWadcQIpl/ucADHuK4pgysDNWv1I=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726794022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=S1XDnHd9Od2phDICM3VDKiuPeTabGdtn697JsAIJI8M=;
	b=nfOgfzvgikTxdC5lqkDIyOu1djB4cFQ9T6zGcr1qdS/AvNKMlpqbJsMxDkK4Vyl1TpfyjS
	q1o0u6E+xcwu7/EqHBR9vpwzlSiMt8RBTGwpvJmHPqhQhT4F3E6FyBqBFCgoZ095AONP/l
	DoczWadcQIpl/ucADHuK4pgysDNWv1I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DF7E13974
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 01:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5Oz7AiXJ7GZ8cQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 01:00:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: libbtrfsutil: fix the CI build failure which requires manual intervention
Date: Fri, 20 Sep 2024 10:29:55 +0930
Message-ID: <d148df614aef86dd6244dad3e0726750a3176b34.1726793990.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-2.99)[99.94%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Currently the libbtrfsutil python binding requires `pypi-README.md` as a
temporary file to act as the longer description.

But it requires the build to be run twice to generate the temporary
file, preventing CI to properly build the package.

Fix it by removing the exception raising, after copy_readme().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 libbtrfsutil/python/setup.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/libbtrfsutil/python/setup.py b/libbtrfsutil/python/setup.py
index d4de81dbc1f2..fe9fdf8a52b5 100755
--- a/libbtrfsutil/python/setup.py
+++ b/libbtrfsutil/python/setup.py
@@ -69,10 +69,8 @@ void add_module_constants(PyObject *m)
 
 
 def read_readme():
-    # FIXME: hackish, needs to be run twice to work
     if not os.path.exists('pypi-README.md'):
         copy_readme()
-        raise Exception("Copied ../README.md to pypi-README.md, run again")
     with open('pypi-README.md', 'r') as f:
         desc = f.read()
     return desc
-- 
2.46.0


