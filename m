Return-Path: <linux-btrfs+bounces-5310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 913BD8D13F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 07:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457691F23752
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 05:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483514DA0F;
	Tue, 28 May 2024 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S3CLV+aV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f8C7JTAx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A264CB2B
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874459; cv=none; b=WDGNEMUhUTejc3KAom5xeq7MC/q6mUs1WlvylpZeWCj0somdtVYFokArczW4H65GTh7PAD49kUVzkAsamTa1RvrjjIKviGbeYlA0SgRl3tPCdLk5+QHcbP8Nmjfa3gbaIT/gInC+o8+oogvICNx4gP3yI3Wj7zG5ep/6RMnYZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874459; c=relaxed/simple;
	bh=Ww6MS2mW1taFaROmhOKPMk9Nn1c1wC2CsYuDHGRGcoc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryLlY+ZxgmGZKCVaT5JBRfVD+7rG2GhKh1r2NNEvz5Sqsn/JLFpEMOiDH0YM7K4SS+uFQYAjZWpvQQNEkHwF07y5ZGoNX/G9xpzoz7D7aTymu5rXdG051uPD704rYKEMrAKadIR5dGOpHjEQLU2Uv9Uc1fwVYrjB+hCwUpVsjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S3CLV+aV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f8C7JTAx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27FE622576
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716874454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+jKJEd0zW/pkXaH7aUWF0hxffUb+dZxQUSdaoAY9lw=;
	b=S3CLV+aVOhoauqdNRocS5SBKyqHquQjdIzZPFwf+dQE27eVOxu0jMSecVHA5LLvJgXgMIU
	PbQRGM46sZGn/QBUpS/op7UK6rDLEw89DKSnqCq/O8+6l+R2ECUwKTYzaNyBn55QT7JcGr
	HPBbAA2By6KgqqPha4fuCc3uuPaJ+ds=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=f8C7JTAx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716874453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+jKJEd0zW/pkXaH7aUWF0hxffUb+dZxQUSdaoAY9lw=;
	b=f8C7JTAxkxu9yutpB/n07T7Vd2kG1cuXkXns+m5NcPwVQey9YTinprIocPy83MyoTv8mIA
	6lLeAhJgtH2+qUKXdOzQb/+P4k8GhkeTr24pgZlhWQX+z4MX8GWJriu7tw3nKUE7OddLJo
	V2mdgE8HLoGHDCmVBsSN2OROYE04J98=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34BE113A55
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:34:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wK5kNtNsVWYpdAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:34:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: cleanup recursive include of the same header
Date: Tue, 28 May 2024 15:03:47 +0930
Message-ID: <ee22eaba04729cf6452ed1223c5187e617cfa4c1.1716874214.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716874214.git.wqu@suse.com>
References: <cover.1716874214.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 27FE622576
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[]

We have several headers that are including themselves, triggering clangd
warnings.

Just remove such unnecessary include.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h | 1 -
 fs/btrfs/extent_map.h  | 1 -
 fs/btrfs/fs.h          | 1 -
 fs/btrfs/locking.h     | 1 -
 fs/btrfs/lru_cache.h   | 1 -
 5 files changed, 5 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 97ce56a60672..08828e1ea1f7 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -19,7 +19,6 @@
 #include <uapi/linux/btrfs_tree.h>
 #include <trace/events/btrfs.h>
 #include "block-rsv.h"
-#include "btrfs_inode.h"
 #include "extent_map.h"
 #include "extent_io.h"
 #include "extent-io-tree.h"
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 2bcf7149b44c..d3d1e5b7528d 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -9,7 +9,6 @@
 #include <linux/list.h>
 #include <linux/refcount.h>
 #include "misc.h"
-#include "extent_map.h"
 #include "compression.h"
 
 struct btrfs_inode;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 89f0650631cd..e6b1903f6c32 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -29,7 +29,6 @@
 #include "extent-io-tree.h"
 #include "async-thread.h"
 #include "block-rsv.h"
-#include "fs.h"
 
 struct inode;
 struct super_block;
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 1bc8e6738879..3c15c75e0582 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -11,7 +11,6 @@
 #include <linux/lockdep.h>
 #include <linux/percpu_counter.h>
 #include "extent_io.h"
-#include "locking.h"
 
 struct extent_buffer;
 struct btrfs_path;
diff --git a/fs/btrfs/lru_cache.h b/fs/btrfs/lru_cache.h
index e32906ab6faa..07f1bb1c6aa3 100644
--- a/fs/btrfs/lru_cache.h
+++ b/fs/btrfs/lru_cache.h
@@ -6,7 +6,6 @@
 #include <linux/types.h>
 #include <linux/maple_tree.h>
 #include <linux/list.h>
-#include "lru_cache.h"
 
 /*
  * A cache entry. This is meant to be embedded in a structure of a user of
-- 
2.45.1


