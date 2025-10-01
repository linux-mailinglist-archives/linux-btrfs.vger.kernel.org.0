Return-Path: <linux-btrfs+bounces-17316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ABDBB1729
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 20:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3503B6CFA
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5C2D3ECF;
	Wed,  1 Oct 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="cZqoNd7j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82A18A6CF;
	Wed,  1 Oct 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341924; cv=none; b=redPl8VnJYLT8x/o3Tj+6SoOjF2sNj5v19g7YS57MbdHKsEpsbkb+QmydaXeDGvYdsCah/0Uw7suIDiAZEZOiO6HDZ6cIP1GliM0g3bqsuGOGIjLCdFGCKgh5LO8zYK8eCMp1+2bYtrbz052pZPNBDfQefVTw2/xHCiZ7MLxv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341924; c=relaxed/simple;
	bh=wUkPGaDQWDhHcSvlXVaBWW6SqgMU44UCN4D0iIho4pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ijvWlUVSZ4Zi7xoR/WAkUqrFBURFb+4a+FKhFvr3LBWJC1nG8bI8UWkwbZzhRc8xEMUa+Z4S0cujeAontMdtxz/SLKyDnkOjFEee15HacUxMaiuStUj6A9uUuoPxd/lyAc+Bht5AA7saIPfW1fReBX5z9jtWV++WtgW7VYFmxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=cZqoNd7j; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4ccNBP1JMNzB0wT;
	Wed,  1 Oct 2025 20:05:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759341917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4mETxxP1dPH/0H0Aw6jbUUKU/8uElFJRClXqFRq6ntg=;
	b=cZqoNd7jTrYniX25unRV5KNPanvGLf9NbvmVEo3aQUGIBW/3TsQyO87znLcxRMewMvOUyz
	ddC9AaGEQ1UnhpfCfZVrhiHQl0iISEDwIC2DdhavENwH07mBGzLoEw/dOsOjKvVY4iJhXW
	7D0ffF13Sk7arU+M72VeaJmuwhYZQwPITjr9hs8zc+MnhP9p4oOZW5zAnQTI7dcoXFxdw8
	DC7+gVQU7HEAuy38KW5QpHi0c9mFxiK794U9WEsWnZulYTVk1Uj8l6EFaxIfq/U2RzAp75
	hQsKcbqdJbyffwi4XybFez8ktQA1+Mf9X7Q8PJkZOEfgj2SIewPaFhDx0ihKAQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::202 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	fdmanana@suse.com,
	wqu@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH v2] btrfs: prevent a double kfree on delayed-ref
Date: Wed,  1 Oct 2025 20:05:03 +0200
Message-ID: <20251001180503.1353226-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ccNBP1JMNzB0wT

In the previous code it was possible to incur into a double kfree()
scenario when calling add_delayed_ref_head(). This could happen if the
record was reported to already exist in the
btrfs_qgroup_trace_extent_nolock() call, but then there was an error
later on add_delayed_ref_head(). In this case, since
add_delayed_ref_head() returned an error, the caller went to free the
record. Since add_delayed_ref_head() couldn't set this kfree'd pointer
to NULL, then kfree() would have acted on a non-NULL 'record' object
which was pointing to memory already freed by the callee.

The problem comes from the fact that the responsibility to kfree the
object is on both the caller and the callee at the same time. Hence, the
fix for this is to shift the ownership of the 'qrecord' object out of
the add_delayed_ref_head(). That is, we will never attempt to kfree()
the given object inside of this function, and will expect the caller to
act on the 'qrecord' object on its own. The only exception where the
'qrecord' object cannot be kfree'd is if it was inserted into the
tracing logic, for which we already have the 'qrecord_inserted_ret'
boolean to account for this. Hence, the caller has to kfree the object
only if add_delayed_ref_head() reports not to have inserted it on the
tracing logic.

As a side-effect of the above, we must guarantee that
'qrecord_inserted_ret' is properly initialized at the start of the
function, not at the end, and then set when an actual insert
happens. This way we avoid 'qrecord_inserted_ret' having an invalid
value on an early exit.

The documentation from the add_delayed_ref_head() has also been updated
to reflect on the exact ownership of the 'qrecord' object.

Fixes: 6ef8fbce0104 ("btrfs: fix missing error handling when adding delayed ref with qgroups enabled")
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---

Changes in v2:

- Change documentation to reflect that we are using an xarray instead of an
  rbtree.
- Change warning to assertion on qrecord_insert_ret.
- Fix function notation on comments.
- Fix commit message as suggested

 fs/btrfs/delayed-ref.c | 43 ++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 481802efaa14..f8fc26272f76 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -798,9 +798,13 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 }

 /*
- * helper function to actually insert a head node into the rbtree.
- * this does all the dirty work in terms of maintaining the correct
- * overall modification count.
+ * Helper function to actually insert a head node into the xarray. This does all
+ * the dirty work in terms of maintaining the correct overall modification
+ * count.
+ *
+ * The caller is responsible for calling kfree() on @qrecord. More specifically,
+ * if this function reports that it did not insert it as noted in
+ * @qrecord_inserted_ret, then it's safe to call kfree() on it.
  *
  * Returns an error pointer in case of an error.
  */
@@ -814,7 +818,14 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_head *existing;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	const unsigned long index = (head_ref->bytenr >> fs_info->sectorsize_bits);
-	bool qrecord_inserted = false;
+
+	/*
+	 * If 'qrecord_inserted_ret' is provided, then the first thing we need
+	 * to do is to initialize it to false just in case we have an exit
+	 * before trying to insert the record.
+	 */
+	if (qrecord_inserted_ret)
+		*qrecord_inserted_ret = false;

 	delayed_refs = &trans->transaction->delayed_refs;
 	lockdep_assert_held(&delayed_refs->lock);
@@ -833,6 +844,12 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,

 	/* Record qgroup extent info if provided */
 	if (qrecord) {
+		/*
+		 * Setting 'qrecord' but not 'qrecord_inserted_ret' will likely
+		 * result in a memory leakage.
+		 */
+		ASSERT(qrecord_inserted_ret != NULL);
+
 		int ret;

 		ret = btrfs_qgroup_trace_extent_nolock(fs_info, delayed_refs, qrecord,
@@ -840,12 +857,10 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		if (ret) {
 			/* Clean up if insertion fails or item exists. */
 			xa_release(&delayed_refs->dirty_extents, index);
-			/* Caller responsible for freeing qrecord on error. */
 			if (ret < 0)
 				return ERR_PTR(ret);
-			kfree(qrecord);
-		} else {
-			qrecord_inserted = true;
+		} else if (qrecord_inserted_ret) {
+			*qrecord_inserted_ret = true;
 		}
 	}

@@ -888,8 +903,6 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		delayed_refs->num_heads++;
 		delayed_refs->num_heads_ready++;
 	}
-	if (qrecord_inserted_ret)
-		*qrecord_inserted_ret = qrecord_inserted;

 	return head_ref;
 }
@@ -1049,6 +1062,14 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 		xa_release(&delayed_refs->head_refs, index);
 		spin_unlock(&delayed_refs->lock);
 		ret = PTR_ERR(new_head_ref);
+
+		/*
+		 * It's only safe to call kfree() on 'qrecord' if
+		 * add_delayed_ref_head() has _not_ inserted it for
+		 * tracing. Otherwise we need to handle this here.
+		 */
+		if (!qrecord_reserved || qrecord_inserted)
+			goto free_head_ref;
 		goto free_record;
 	}
 	head_ref = new_head_ref;
@@ -1071,6 +1092,8 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,

 	if (qrecord_inserted)
 		return btrfs_qgroup_trace_extent_post(trans, record, generic_ref->bytenr);
+
+	kfree(record);
 	return 0;

 free_record:
--
2.51.0

