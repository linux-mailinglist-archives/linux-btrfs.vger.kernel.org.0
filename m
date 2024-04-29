Return-Path: <linux-btrfs+bounces-4613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E1A8B59F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500D528CF85
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19EE75811;
	Mon, 29 Apr 2024 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XDLIbVig"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9996757E5
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397410; cv=none; b=uzY/bT4+4/7BdPwL8Fo5Wl2qfNBguyW+iPCyJA2hOF3LHYvJr6SFYrs1E7eQgeRyjevCfH3wy7Jr7vvz2SRtqFqRuTISTHOldlY7z/H14CfV5bzsM5QhuNWJm86xqLWyhs07NdVLq0dYTGiKSlI928JCbVL/qkRbHjkoh70IgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397410; c=relaxed/simple;
	bh=zoV9661pC/mzj2acwhd6/oXf5IOiZQXnPfw67Hhy384=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofF9+rtB4ZtfqjtFmHUAv2n5mw4llivrtfFN9VeK38xhVgQFpAtt1td51h1dzi7P5VYH1TNN/3QWYvkDVvJEyxrXdRlgcRJIpz5enp+Up9tgzNDkUnfzDwvIdnzwisJZn4nQ6iVYjrHuAgt1hoGnRTOJevZuOzKXqiT9BNwNgsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XDLIbVig; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c8641b41e7so754571b6e.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397408; x=1715002208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJjfXXCDeBwxlqZFPLDX4+ku/LlOc7au7TobqVnD3kM=;
        b=XDLIbVigC1U7oq19MZ5MXAMCYe2hCzPFQP6y05x8ZGAcf4g+aM3oW0O3iXM7dH9wN4
         jYmSHoLPZL7MSUAhJ7hRDFzKLD+x6p/AmB5oY5v93ScYZF3Gfj2S4F3qMzqE7JzVjocj
         zV7CMTjrx/+LVUg4HJZcW8LTcSlGMo2VG4d7T88rIodBOaco8o6rLxnB6CF4c5DoSi+c
         QB2maazJgu0B8P3Y5iBkFKF3cm0DMDrDxpOD8PnNGYi6bra/lloy1s1MJGeLQ8aCQtDy
         SiMrE+FkXWEgFJ9Zlw3u9fU0N5ERfELrtV4ysc5Q8uq4i7UdSYQt2PfGsaOJV1Eqx4EO
         BEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397408; x=1715002208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJjfXXCDeBwxlqZFPLDX4+ku/LlOc7au7TobqVnD3kM=;
        b=tk3fBbmZ2AQStXqUYosyjnFCVVAGbG2X7TeJSyI08itaJMKmoYEvfuzrKD8WI48NLZ
         TdcMktius8nyVKO2U3JQk0Q+7lJLo0WzAmRJn6NLtLydfkBC5C3sXoXOQatU0iTMN9F4
         mepsP7yebqfPio/7imRsY7u8Md00qxLfp5PLU4QyLfdAkVXmw36i30TH5wz8PegW2ELx
         Zsv0dkbkPUUsBiwGsCwxnMFaFQgkSPwRWLU0S948HwAwNXFrC0t5gx1pcWY/RrjqSG/U
         y1NwY8MaGuvZtjACw4bj9cY8rNcePMmWaiejcfxkZbfDodZEeh1RfvNEThwffb8Trlkf
         Jpig==
X-Gm-Message-State: AOJu0Ywmzdet1j5YOFoxrh23SzU78N95urtQ4gAaDoO0iPJCZlXDUdua
	hI5VuB6uYGmhOa3icnwdyDKi3crxBeg9f1UAIK1MxOtcSHz1ek/oBLZwJ12ofbqUZNAtwjLowKi
	O
X-Google-Smtp-Source: AGHT+IF7UffUAh6Z+hQw/XXsqHp9hmKjsJ6LoQtGCAm5hZlgIlacgDTxAYFfmAqlao5EhPUGGBzU8w==
X-Received: by 2002:a05:6808:2784:b0:3c7:4508:6dfd with SMTP id es4-20020a056808278400b003c745086dfdmr10399897oib.44.1714397407923;
        Mon, 29 Apr 2024 06:30:07 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id jy8-20020a0562142b4800b006a079a9adc4sm2030571qvb.40.2024.04.29.06.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:30:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 10/15] btrfs: handle errors from ref mods during UPDATE_BACKREF
Date: Mon, 29 Apr 2024 09:29:45 -0400
Message-ID: <a402c63cd6b452a7165363e90016067f6124b205.1714397223.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714397222.git.josef@toxicpanda.com>
References: <cover.1714397222.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have blanket BUG_ON(ret) after every one of these reference mod
attempts, which is just incorrect.  If we encounter any errors during
walk_down_tree() we will abort, so abort on any one of these failures.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index df3b6acc63cf..0dc333331219 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5418,11 +5418,20 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	if (!(wc->flags[level] & flag)) {
 		BUG_ON(!path->locks[level]);
 		ret = btrfs_inc_ref(trans, root, eb, 1);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		ret = btrfs_dec_ref(trans, root, eb, 0);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		ret = btrfs_set_disk_extent_flags(trans, eb, flag);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		wc->flags[level] |= flag;
 	}
 
-- 
2.43.0


