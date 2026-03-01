Return-Path: <linux-btrfs+bounces-22125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GElsGSb0o2mvSwUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22125-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 09:09:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77D1CECCB
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 09:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B06B300F136
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2026 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AE533032A;
	Sun,  1 Mar 2026 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCMXtbGq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0F15539A
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2026 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772352539; cv=none; b=YXksPo1TA9+XGfjcOZ34ppkMOKvMryiMRDHgXgPBB1c5fz9SQX9xJo8f7kX4bjDLMXPLKs6EDJIU+MrOKvUKRDEPdsww+jmM28pM++rqEK7HTGu4cuY9Et7SCArqYgdR7v8HD6jYx1sr2LJMKYiQiaOOVlTVFPkO4QJ90urkt6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772352539; c=relaxed/simple;
	bh=7iOYDwCgKMgH1ttBNtFMfrgKVvwATVLXflWE6ATV4fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ju+c5DJ2GqXavUxIjIJe6TlfbtR7xjw7lNXyGovahyBShJslkzXyUCbauorfXBboa7ce0xovTNo27YINcUkFzFbmp6QXDGH2dGrGRqUNP9Qui6Pjy1GvoI+vDFhk4jP4gZQV1clqlY4WLdAizf8mGI1XYWBX2VzcUmh7OjxgT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCMXtbGq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3562e858da5so1467365a91.2
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2026 00:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772352537; x=1772957337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khxUoYDm3JEEBakTGGDixS5AmQe5irgmRZaJ0irTmec=;
        b=WCMXtbGqYAeUJqxM38/+LXBqhrPmn0wZlO0i5H/ew60TIjYG2i9h6p/jZLegO88Ady
         t0gIUzC+wOmyIrD42hJ70jpAI/0Ss3SP9KEYc95zH8olI+YUMb+Wc+FuIB7SPfV0rKIX
         29bPVB8YeAwDlOyb7zJLaiHgSuyz9xL10C0DIJDLVSn5Nbx0jrk0iin3374J8KA9XOzE
         tV9uUptL5YjP3uWgQqqgPDDlZ8Hqy/1rp8kj8A6Rs2JHVoXHiQ0heOc6Af5NOE/Hk9u7
         bzLWk/50xGDyPmqRLSVD88Xdbvm4AAQXCRLp+Rb4+uInkqGqF17spMLSjBkFU7x4Nw7n
         be5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772352537; x=1772957337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khxUoYDm3JEEBakTGGDixS5AmQe5irgmRZaJ0irTmec=;
        b=GAkIngqoJEBJIF7WK25XFrbt9Obn9vqIfb5eYfyQWNwncGg/8jVTJPFMlKj25lIqRh
         M2KkA0FOzBNqzV1fPpPjlAcSHOBHevXJj8UiF/DXog/9raEpfoZ/m0Vpwt9ngTtrxPO5
         WjNqr7dpYrDK4tky5y7TqLQzEszUVB3DiuIkGokZgr5TSecOH8fGlYfgJgzHAtrPLkTq
         i5rNE0FuKJEHPyySyNnq3VtTyMYeP7Q3qK0eLSOEMKpKnT1yROff/JrfuMPQ00gqxCXQ
         uc+btet/H7SnsA1oFCWUhQvSyd5D2Vw9Zccj6voPpAWYSkOSRRsN/ye9fYTe7rhyny/1
         FLyw==
X-Gm-Message-State: AOJu0YxR7LGCVV8JUMLCkxotlYXRqmW9oDVYKPIYBgfU7fogsvSJOMqT
	ZwXxTgU3JdM/Reaq1xpcdx6C4sgnJNJKGq1lomZnfFD7hRPhGkz+QxkK
X-Gm-Gg: ATEYQzyI9mKU5ev/1XVPeVne5sYvGQ3hDVTXKtPRw3mrP79NHt8SFhYFWEhH5lxd84c
	KhL8+Q3//whtxL711Bbufk4wwhitayr6yoftwsW8ianC5Im7tbWQcEXOUUhVkzmhRK7Blkfi0gB
	biJRbk1vcawwVtAe127FnQbalfej2S7s7jKqOIP9KKLTQnN1x3T8IjKFsWo7tv8b37gsghKCKV5
	xN3qNIgHTtOMY6Sbadqb9Na7rv382FUOVSx7RZql9ZBaktFp9PaojTz+pKjLv3kOEU3X7Lq21mM
	+Tj3YqueZWySA6f0G2/erw5HEqNOrnIXAI+aaXVouf2p2gGWqQqCx/FD5Wpctl4N2/psyPGid1o
	715x+6YZdg7vkV6T/xPq/DAwlZJwe3QJeOpN3BrUEPCjaDI2IH6RT5FbaUKK8EbSZbBwNxoNSbh
	odfMfB31fX7EgdzHSTGmJn5Bsf
X-Received: by 2002:a17:90b:5205:b0:356:22b5:704f with SMTP id 98e67ed59e1d1-35965c4fd27mr7748479a91.15.1772352537349;
        Sun, 01 Mar 2026 00:08:57 -0800 (PST)
Received: from archlinux ([103.208.68.234])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82dab1sm8336442a12.27.2026.03.01.00.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 00:08:57 -0800 (PST)
From: Adarsh Das <adarshdas950@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>,
	syzbot+6d30e046bbd449d3f6f1@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: don't add delayed refs to an aborted transaction
Date: Sun,  1 Mar 2026 13:38:47 +0530
Message-ID: <20260301080847.16153-1-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22125-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adarshdas950@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs,6d30e046bbd449d3f6f1];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B77D1CECCB
X-Rspamd-Action: no action

When a transaction aborts, cleanup_transaction() calls
btrfs_cleanup_one_transaction() which drains all pending delayed refs
via btrfs_destroy_delayed_refs().

But, btrfs_cleanup_one_transaction() then wakes up tasks waiting
on transaction_blocked_wait and sets the transaction state to
TRANS_STATE_UNBLOCKED. These woken tasks can then call btrfs_add_delayed_tree_ref(),
btrfs_add_delayed_data_ref(), or btrfs_add_delayed_extent_op() on the
already-aborted transaction, inserting new entries into the head_refs
xarray after it was just drained.

When btrfs_put_transaction() subsequently drops the refcount to zero, it
hits:

  WARN_ON(!xa_empty(&transaction->delayed_refs.head_refs));

This patch fixes this by checking TRANS_ABORTED() at the start of add_delayed_ref()
and btrfs_add_delayed_extent_op() before inserting into the xarray.
btrfs_abort_transaction() is called at the start of cleanup_transaction(),
before btrfs_destroy_delayed_refs(), so the aborted flag should always be set
before any wakeups occur.

Reported-by: syzbot+6d30e046bbd449d3f6f1@syzkaller.appspotmail.com
Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 fs/btrfs/delayed-ref.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 3766ff29fbbb..b994f9702c32 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -327,7 +327,7 @@ static int cmp_refs_node(const struct rb_node *new, const struct rb_node *exist)
 	return comp_refs(new_node, exist_node, true);
 }
 
-static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached *root,
+static struct btrfs_delayed_ref_node *tree_insert(struct rb_root_cached *root,
 		struct btrfs_delayed_ref_node *ins)
 {
 	struct rb_node *node = &ins->ref_node;
@@ -1025,6 +1025,10 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 	}
 
 	delayed_refs = &trans->transaction->delayed_refs;
+	if (TRANS_ABORTED(trans->transaction)) {
+		ret = -EIO;
+		goto free_head_ref;
+	}
 
 	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc_obj(*record, GFP_NOFS);
@@ -1153,6 +1157,10 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
+	if (TRANS_ABORTED(trans->transaction)) {
+		kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
+		return -EIO;
+	}
 
 	ret = xa_reserve(&delayed_refs->head_refs, index, GFP_NOFS);
 	if (ret) {
-- 
2.53.0


