Return-Path: <linux-btrfs+bounces-8152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6278A97DB73
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Sep 2024 04:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A721C20FA4
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Sep 2024 02:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C3C20DF4;
	Sat, 21 Sep 2024 02:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WWMZKMtL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WWMZKMtL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB91717BA6
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726885617; cv=none; b=SjHuZ62Iir3oLgHsboQaLN1mX9CysnJnmFyl1W7SUPl5W2/SOiWqg+BwxDzvx2ja+l+oJgVcbwNgj1G24poZwxWeSzdF9Q/aWtXY+XYhv/C6NQXyqlANWqDfZmsia2LPJKdTZnwjPVpJHpbycUBJ+ZCEfrud6TtllWIB8oX3BXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726885617; c=relaxed/simple;
	bh=qHQVY//wC96T7OumadZ0sxAjDlsxBrSWTAETqFdadyk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uvp9eIOEffdesPIrnpzPqk7q3uWY/1nBv62tfKnL7bA0uBVW86oLsNNdHWQG199DiX93SVerGiUNP4AjB6InGEi5NahtyjOzAxBa8GLxPZw300NucykR6ZW4v4ghxkgIz6zRgYdfKcRvog/Jy7m1ecqQ/dYYENcIA8QhwzRB7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WWMZKMtL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WWMZKMtL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1738D33A81
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726885613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mivLDb6MXTtw/S6LgmAqVIxjrhBpSYRVUKQQEDoegB8=;
	b=WWMZKMtLut7QFa2+Pezbi/c3APRwGtaDfQihcwZMyU3q4UwYXzJe7TvwMwQfvWvmrQJoT3
	/TEo0n5gtaXNFhhOf3R89Bpuvb9/2In0/vpayQ79sE2lyM+rqpcwjlg8zq6yAXsT7qyfNB
	yFVeKgphJtOcEOXS08vKBDPWRCSlTyA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WWMZKMtL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726885613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mivLDb6MXTtw/S6LgmAqVIxjrhBpSYRVUKQQEDoegB8=;
	b=WWMZKMtLut7QFa2+Pezbi/c3APRwGtaDfQihcwZMyU3q4UwYXzJe7TvwMwQfvWvmrQJoT3
	/TEo0n5gtaXNFhhOf3R89Bpuvb9/2In0/vpayQ79sE2lyM+rqpcwjlg8zq6yAXsT7qyfNB
	yFVeKgphJtOcEOXS08vKBDPWRCSlTyA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FC6613882
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gFoHBewu7malAQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: libbtrfsutil/python: reuse existing README.md for long description
Date: Sat, 21 Sep 2024 11:56:26 +0930
Message-ID: <0ca0915fe097761d0120a487b7179d056bbf93f5.1726885304.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1726885304.git.wqu@suse.com>
References: <cover.1726885304.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1738D33A81
X-Spam-Score: -3.00
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[99.97%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.19)[-0.967];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Instead of copying the file during custom build commands, just use a
soft link to re-use the existing README.d from libbtrfsutil.

Issue: #310
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 libbtrfsutil/python/README.md | 1 +
 libbtrfsutil/python/setup.py  | 2 ++
 2 files changed, 3 insertions(+)
 create mode 120000 libbtrfsutil/python/README.md

diff --git a/libbtrfsutil/python/README.md b/libbtrfsutil/python/README.md
new file mode 120000
index 000000000000..32d46ee883b5
--- /dev/null
+++ b/libbtrfsutil/python/README.md
@@ -0,0 +1 @@
+../README.md
\ No newline at end of file
diff --git a/libbtrfsutil/python/setup.py b/libbtrfsutil/python/setup.py
index 8b377b9fa1b6..5e3bcf088699 100755
--- a/libbtrfsutil/python/setup.py
+++ b/libbtrfsutil/python/setup.py
@@ -106,6 +106,8 @@ setup(
     #version=get_version(),
     version='6.11',
     description='Library for managing Btrfs filesystems',
+    long_description=open('README.md').read(),
+    long_description_content_type='text/markdown',
     url='https://github.com/kdave/btrfs-progs',
     license='LGPLv2+',
     cmdclass={'build_ext': my_build_ext},
-- 
2.46.1


