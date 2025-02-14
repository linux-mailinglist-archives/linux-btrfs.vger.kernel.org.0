Return-Path: <linux-btrfs+bounces-11463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89A4A35B7C
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 11:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB6E3ADFC1
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5192580D7;
	Fri, 14 Feb 2025 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="onm5R3LH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98642222B1
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528631; cv=none; b=PrPxrGyxxOYlCp2OyE31RUlFu8WpijFqXpDI1lemtBFLCj9J/jblxYvfFgLP+ik98h/7oVup/UYyy2HGSidu/e+1ETulgVrbikrtEHiI0W3dxpchIdTLEuYkjUK2opwRbnlb13N059ytKsCtJ55C/bmdIKzT4IKCCLyilHC4vZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528631; c=relaxed/simple;
	bh=9RQS/Q+BQ+zkMywqKbHhzDQBNF5U+Nw+FBkjeg50hPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKJmzehRUGUT7lNmdlugnmxYP22mbE0H+zNX3YXAyuQ7e99cgS53orAFMVsetnpnPXLr/psKoFFotKPGYUOBuvLEKOoNJ29Zb1hS9iMIAOzeaSRcxF/bY57OEmW2WZ65fJUMmg42cVKy1ilx+1QuVnZHYEBA3T2wooSiPddJo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=onm5R3LH; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:ab99:0:640:1ad4:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 28AE460BA4;
	Fri, 14 Feb 2025 13:23:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bNOpKs9Ola60-QJOPRQYz;
	Fri, 14 Feb 2025 13:23:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1739528618; bh=psgHTYyFHYGnhO92/C41EJnxvIEFeKRrptVpoOy2PCg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=onm5R3LH7cTRFhBXoHX7YCjI955Jjb61UxrrGEp7XfpJFx6tOq4x8SOpVGeuLeJ4T
	 9jdaFchirNZ7/4qytUsf9k4FVEsYBU3RY90P3K+dQYcDYSySfKmlmWjhn0/opqNarV
	 A88fLOq3gaXkt9ISy4YQfbJYhhSTuqgCw9WDIlzc=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] btrfs: cleanup ktime_t usage
Date: Fri, 14 Feb 2025 13:23:23 +0300
Message-ID: <20250214102323.3882919-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'update_commit_stats()' and 'btrfs_commit_transaction()', do
not assume that 'ktime_t' is a scalar type which may be implicitly
converted to (unsigned) 64-bit value but use 'ktime_sub()' and
'ktime_to_ns()' helpers where appropriate. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/btrfs/transaction.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index aca83a98b75a..452320ce3516 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2151,7 +2151,7 @@ static void add_pending_snapshot(struct btrfs_trans_handle *trans)
 	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
 }
 
-static void update_commit_stats(struct btrfs_fs_info *fs_info, ktime_t interval)
+static void update_commit_stats(struct btrfs_fs_info *fs_info, u64 interval)
 {
 	fs_info->commit_stats.commit_count++;
 	fs_info->commit_stats.last_commit_dur = interval;
@@ -2301,7 +2301,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * Get the time spent on the work done by the commit thread and not
 	 * the time spent waiting on a previous commit
 	 */
-	start_time = ktime_get_ns();
+	start_time = ktime_get();
 
 	extwriter_counter_dec(cur_trans, trans->type);
 
@@ -2568,7 +2568,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	trace_btrfs_transaction_commit(fs_info);
 
-	interval = ktime_get_ns() - start_time;
+	interval = ktime_sub(ktime_get(), start_time);
 
 	btrfs_scrub_continue(fs_info);
 
@@ -2577,7 +2577,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	kmem_cache_free(btrfs_trans_handle_cachep, trans);
 
-	update_commit_stats(fs_info, interval);
+	update_commit_stats(fs_info, ktime_to_ns(interval));
 
 	return ret;
 
-- 
2.48.1


