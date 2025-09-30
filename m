Return-Path: <linux-btrfs+bounces-17292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD80CBACF85
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 15:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2565116989A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3FD303C91;
	Tue, 30 Sep 2025 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="gSa7+eeb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265E25393C;
	Tue, 30 Sep 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237523; cv=none; b=FBJZ5YEuRjQYj9hZFg14s3IPTOM98hu1Bzhy9kqEd/U42jhch3jbTJipEeJ43lFcWl1WMbnQbkGBiGqWJLU/cx+/rfWw21b636FayxfPKu5rnBUkDYUZm2MHWpW0CbZZxjIoDvR96VLGRuzRDfbz553nIib7DGZaq459RHIgFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237523; c=relaxed/simple;
	bh=iZgo79S9RETlp39HGuZwOXuvcEwZqWJEmA52SjFhFdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d0FBKFQXJZQNRRDWhl4n3e05T4Mnq1jNucTlOIoJU3u7sEfX7mH6D1bzXLBgZAbn664JMKzEwpKVze94cVRjO/6AVJdEO1jMgXzYbbU3EcSyuWoGsyIagXvUJqT72ZmcJnBeBfx9vygCrNDA7++D0wiV12hnpIJYOl4oymaUGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=gSa7+eeb; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cbdZY3xBqz9ypq;
	Tue, 30 Sep 2025 15:05:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759237509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=miidrzx73cvjGxCxUtDH7sYsW5FLtJACNy8tOg2okns=;
	b=gSa7+eebP1u9LV7qEXWZeoCZmudPuyNxogNbRk7WdyyL2AQUflIgzPOUbF2lpHv+P/fIez
	2Arjw9b3NMNXlGKUzcMUu3LLc3Hpux2phOtXmSyLejbBO/5HSomDB/x4rGuEDSwrg96C0l
	yZHQuZXPoB9KafKeV18qicUh15c8bF9YFDKgqwKEVx2I8M9G9lt1RgOmRBj9DCqQ3GsQ4t
	Gqm6WRi0TMgUrtEu330h2G4qhlvqIyXClG5t2RoHnla7cKq9IRKPm/WgQDEfPUNDv2Fj6O
	zNq48DwWaNHeSHy2RTTYvggT03I2g0f7DkZRlXE1Evyiuq6NT/rTlM9FIVmbxg==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	fdmanana@suse.com,
	wqu@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH] fs: btrfs: prevent a double kfree on delayed-ref
Date: Tue, 30 Sep 2025 15:04:52 +0200
Message-ID: <20250930130452.297576-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the previous code it was possible to incur into a double kfree()
scenario when calling 'add_delayed_ref_head'. This could happen if the
record was reported to already exist in the
'btrfs_qgroup_trace_extent_nolock' call, but then there was an error
later on 'add_delayed_ref_head'. In this case, since
'add_delayed_ref_head' returned an error, the caller went to free the
record. Since 'add_delayed_ref_head' couldn't set this kfree'd pointer
to NULL, then kfree() would have acted on a non-NULL 'record' object
which was pointing to memory already freed by the callee.

The problem comes from the fact that the responsibility to kfree the
object is on both the caller and the callee at the same time. Hence, the
fix for this is to shift the ownership of the 'qrecord' object out of
the 'add_delayed_ref_head'. That is, we will never attempt to kfree()
the given object inside of this function, and will expect the caller to
act on the 'qrecord' object on its own. The only exception where the
'qrecord' object cannot be kfree'd is if it was inserted into the
tracing logic, for which we already have the 'qrecord_inserted_ret'
boolean to account for this. Hence, the caller has to kfree the object
only if 'add_delayed_ref_head' reports not to have inserted it on the
tracing logic.

As a side-effect of the above, we must guarantee that
'qrecord_inserted_ret' is properly initialized at the start of the
function, not at the end, and then set when an actual insert
happens. This way we avoid 'qrecord_inserted_ret' having an invalid
value on an early exit.

The documentation from the 'add_delayed_ref_head' has also been updated
to reflect on the exact ownership of the 'qrecord' object.

Fixes: 6ef8fbce0104 ("btrfs: fix missing error handling when adding delayed ref with qgroups enabled")
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/delayed-ref.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 481802efaa14..bc61e0eacc69 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -798,10 +798,14 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 }
 
 /*
- * helper function to actually insert a head node into the rbtree.
+ * Helper function to actually insert a head node into the rbtree.
  * this does all the dirty work in terms of maintaining the correct
  * overall modification count.
  *
+ * The caller is responsible for calling kfree() on @qrecord. More specifically,
+ * if this function reports that it did not insert it as noted in
+ * @qrecord_inserted_ret, then it's safe to call kfree() on it.
+ *
  * Returns an error pointer in case of an error.
  */
 static noinline struct btrfs_delayed_ref_head *
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
+		WARN_ON(!qrecord_inserted_ret);
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
+		 * 'add_delayed_ref_head' has _not_ inserted it for
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


