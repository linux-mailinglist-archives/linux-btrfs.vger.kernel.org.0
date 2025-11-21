Return-Path: <linux-btrfs+bounces-19247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64479C7A6E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 16:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D63DB353DF1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 15:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9F635029D;
	Fri, 21 Nov 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Ax+4Vrmi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94A34E762
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737176; cv=none; b=ZDbc24yAGWsST7KIwdE2hQXl/NfNod37PFTZgOJuoK0+Ve+uYQqG3QB040DpvFyUhVK92h2GOTx1eeqEkl56oVaD67m8F2kjts2m5lIgQHEaf6GDJ4qqaI36SKAZcOub+Mp+0a9IMIGzBKfvPtuBLMpCLjFF/6OPtzx71lsy//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737176; c=relaxed/simple;
	bh=L+f0G7Oomgz5yckHb7le2uXGj2RtO0yZMfjIVVkg7z0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txQKzlLycBlfAD4lcHEwtwNhI5C9/gNFTX1AwTaRxOFPovsl6xlwAWqA6Ys9PFAWd7v5FyYHelc9IbzM9ldwU8o5qctGAsi/D2stihUUOD61GvTubyYyI8+OTvhwkJH9fP/x1HZYbBhACv0ehQVtSiITkeMgalRS07JX4+XaZnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Ax+4Vrmi; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8823e39c581so30590216d6.3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 06:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1763737172; x=1764341972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvPfBIUFxyZInOPsjxKZUjAmh88OntZZrCF3in8OnFk=;
        b=Ax+4VrmiFQoZalyH40v1V3RWdAcQhM+b8vXrlMJYAvv968wTEgBgJSrjYSWkpTHLMw
         VAk3NBa06uio7iVDYvn/1yV26nKo3rhrE+V90dnBm5Er+hx0bLTQ2XydhwFZbA2lUaN4
         fxlFum2xlMvWBiBZ21Tb6gZ8cUb7Gga2S7NlCClyX0rhID0eT/j35sJS84sX7VJg2HXG
         328vszVDKW9YRbBIErc13SlV/FP4eScz6HzF0Lxk3pi69NK6bqnNCmmvhm6hGmc59g91
         j574Zsk07G+Fw8IAVvMVnmmev6JnrgFZmGyXKYgykIREqtDUgd6ct120shr6NrzvTs+J
         l8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763737172; x=1764341972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FvPfBIUFxyZInOPsjxKZUjAmh88OntZZrCF3in8OnFk=;
        b=Itz/m5Z9tAyKDFqsRk1dztqfumyBpEIuTwhcxXKJGQyGp6aPV2VQw62GmzTGP2klD1
         p0X2VGkDoWBGqsRp1dn5Y9wPT57oLNoP97DkLEKYUz38T+5cYwLch9Qd7xM9AiYSC4q2
         rex/A+ZscaLUoJb9Gla/4SKRsTS3wixGKgdSEiZybfLg0zz8/MLNIPykqHX7yY61uaeX
         h0B+lfDERIE7Lf4K4TgzHJAIiFXuDkk5NXwMT4wA+pPkPo4V6YZzYvgdq5QjytGn4PZp
         12JmPK0yoS/EnQwB9KN3IZtxtZYmnSZlP+KG6c9cY+CmOKRmJqsJa8I6gOa62amDWoA3
         U2uw==
X-Gm-Message-State: AOJu0YwqvUsacHBV7GXVEVUgGctyXAIlZ60CLrvXsivjT4Oje77g13a9
	t7HJWQuAnEqLeQj6/18mWdn93fFp7K8tk8MN2Lnfsk4LQIUdaqOs8xu+bv/NOYzeeSfB66V156q
	YU68kU+nEkA==
X-Gm-Gg: ASbGncuNNO2IaUaEyZl7ZggDpTb5OD76UCwNMVR0zsDuszwvQ9i48rxLa/qXVJnaq2r
	cYitA3JaxJIYgFEn9lY/AJOdWnKqbORqNzAtJt9UZf6CQ9Zh1mta2PsrtncxJO9ldiUvAsNJxLv
	5ASSC18AlL5G+8zNtyKv/udqRPgdfhYp2CVJSUPU99RndRbrwHXWLsUut2RirfiH4hmuY5+G+dQ
	xmp0DGifNNV1uQzx2qHmJfTJLyazm8GNC6SCAursiQiP1XT2vJ+QmAj/aTP3+DHqrKN2F4NyCVM
	oMdpYKb04Xdnz1w0jEoopoy+31TbPmWkqyyIu7Un2AB4YDDkSwndvhs2PmiHekAr3fgxPz1FVdt
	cf8aMC3V2tqBY2W5bcEp6JHBuq7fAdBmR6z7BwpaK88rX6K02Ebqmoix9DAfC4Nle19EuM+W3/h
	FX9AVA3tD+Bi8/
X-Google-Smtp-Source: AGHT+IE3eNwvAcYE42afPEuDDeUpUlPJ1DeymhZ9wxb9tcwDo9HnW3QPvc77Ftsx+vgYZY29VxGH1A==
X-Received: by 2002:a05:6214:dca:b0:880:4ec0:417a with SMTP id 6a1803df08f44-8847c53662bmr37777986d6.55.1763737172039;
        Fri, 21 Nov 2025 06:59:32 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:f528:9f2f:44c:2c84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e575439sm39887956d6.47.2025.11.21.06.59.31
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:59:31 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: fix data race on transaction->state
Date: Fri, 21 Nov 2025 09:59:21 -0500
Message-ID: <7a9d970450cb1531d0a0da5d8e8615b06aba9137.1763736921.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763736921.git.josef@toxicpanda.com>
References: <cover.1763736921.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Debugging a hang with btrfs on QEMU I discovered a data race with
transaction->state. In wait_current_trans we do

wait_event(fs_info->transaction_wait,
	   cur_trans->state>=TRANS_STATE_UNBLOCKED ||
	   TRANS_ABORTED(cur_trans));

however we're doing this outside of the fs_info->trans_lock. This
generally isn't super problematic because we hit
wake_up(fs_info->transaction_wait) quite a bit, but it could lead to
latencies where we miss wakeups, or in the worst case (like the compiler
re-orders the load of the ->state outside of the wait_event loop) we
could hang completely.

Fix this by using a helper that takes the fs_info->trans_lock to do the
check safely.

I've added a lockdep_assert for the other helper to make sure nobody
uses that one without holding the lock.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 89ae0c7a610a..863e145a3c26 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -509,11 +509,25 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 
 static inline int is_transaction_blocked(struct btrfs_transaction *trans)
 {
+	lockdep_assert_held(&trans->fs_info->trans_lock);
+
 	return (trans->state >= TRANS_STATE_COMMIT_START &&
 		trans->state < TRANS_STATE_UNBLOCKED &&
 		!TRANS_ABORTED(trans));
 }
 
+/* Helper to check transaction state under lock for wait_event */
+static bool trans_unblocked(struct btrfs_transaction *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	bool ret;
+
+	spin_lock(&fs_info->trans_lock);
+	ret = trans->state >= TRANS_STATE_UNBLOCKED || TRANS_ABORTED(trans);
+	spin_unlock(&fs_info->trans_lock);
+	return ret;
+}
+
 /* wait for commit against the current transaction to become unblocked
  * when this is done, it is safe to start a new transaction, but the current
  * transaction might not be fully on disk.
@@ -529,9 +543,7 @@ static void wait_current_trans(struct btrfs_fs_info *fs_info)
 		spin_unlock(&fs_info->trans_lock);
 
 		btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_UNBLOCKED);
-		wait_event(fs_info->transaction_wait,
-			   cur_trans->state >= TRANS_STATE_UNBLOCKED ||
-			   TRANS_ABORTED(cur_trans));
+		wait_event(fs_info->transaction_wait, trans_unblocked(cur_trans));
 		btrfs_put_transaction(cur_trans);
 	} else {
 		spin_unlock(&fs_info->trans_lock);
-- 
2.51.1


