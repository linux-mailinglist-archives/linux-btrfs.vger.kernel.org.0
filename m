Return-Path: <linux-btrfs+bounces-19503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E091CA239D
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 04:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D8503030D87
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 03:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794D13321D8;
	Thu,  4 Dec 2025 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G+IgCTjl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bcntkM5H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F8D33121F
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764817703; cv=none; b=DmH0r/xOVLGIG0aTEE/gxrafQAcC0H0anY4BO+eBMqNUtJnw+boL5y9wGx2xOB+mQNYesWxzlxd3l8rTKaUWf0da2qCzruBrrIV8uPw8+u4AgBYsumRDmuZHpiTsY9ZBv40baShMqja7SMB5tcbtumwqn8739ZTJn34otODtLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764817703; c=relaxed/simple;
	bh=8FDLaef74iIhwbKCoM0qRSNNAj06AJOf0giKCRoGtwQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uTqLOwWpEg8KnUtPXlFov/exv/1oEU81+UvX+ponp49Q1/p7MHYN3iRhpKWYiyn7O5tIcn+c0sjecHhfHtsf1yTIaXth7RHZIz2cgwyJbrhydPl53/lFWkNvSPtUvI1seC3AVmlA13/oE+Slhu0DO+o0Xqwoxl3Yn1Y15mqXWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G+IgCTjl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bcntkM5H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48C515BCC5
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 03:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764817698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AaNuIM45kygx0uLjltACfd/E01oKc+SkDqw+FRcwKL4=;
	b=G+IgCTjlmEZ/VYS/wWqQAhWN/H7l0Gd2mKhk4GDRBdQCx6yyLDBQSaCfX+aN6CPolaSUie
	TcfFNU85f+XmnGlqg56an1t6kjLBtgAdYEjtYg236kIy9VAipFmEUFiwy+NOSFIi6gD060
	Rx/5BsgDCdjtZJeyXWJ5hCIHoLRgiiY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bcntkM5H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764817697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AaNuIM45kygx0uLjltACfd/E01oKc+SkDqw+FRcwKL4=;
	b=bcntkM5HrE/yyk0bMlXwQyUB1rfWYn264qWMOhR6sfYLIXeGXUn2hWWt4ea81I7wmxKHTu
	DD2pQ6loTTHiYTN4+jqCJvQ35Zbpa2H6H5tKZanlQD57AvagKt5D+TOP9J6KZLUAx4KVkX
	xYUrpcYZSViGsWlFIbfDAwt1Y7DvZMo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81E7D3EA63
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 03:08:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5Ai4ECD7MGlpTwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 04 Dec 2025 03:08:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: ignore compile_commands.json
Date: Thu,  4 Dec 2025 13:37:54 +1030
Message-ID: <994e2077e4222ba4878f5dbb9fa13d03dfa986eb.1764817661.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 48C515BCC5
X-Spam-Flag: NO
X-Spam-Score: -3.01

Clangd is the most commonly used LSP server for C, and it needs
a `compile_commands.json` file to get all the compiler flags for each
C file, and such file is normally the root marker to detect the root
directory of the project.

So it's pretty common to just put that file at the project top
directory.

Furthermore projects like the Linux kernel has already added that file
into gitignore, we should also ignore that file.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 5fa3a73a6d39..7cbd83f79676 100644
--- a/.gitignore
+++ b/.gitignore
@@ -70,6 +70,7 @@
 /cscope.files
 /cscope.in.out
 /cscope.po.out
+/compile_commands.json
 .*
 !.editorconfig
 !.github
-- 
2.52.0


