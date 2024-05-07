Return-Path: <linux-btrfs+bounces-4816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316A98BEB4D
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D021F21B48
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70AD16E863;
	Tue,  7 May 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="r97fVelp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD716DEC3
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105564; cv=none; b=Tg0A7vKYfXfV0AvsMllqNpJhKkTIHOiSSAl+74KyEtoP/zE9yZEbdDnMxLKk7dfbrMQExoH02lviJbWfix0SiAsHm0gmNuUwQiZUtvKR/Xwb4fSfM0BqPUIIPtuvo2K25KPB8TOgMF9ixD7EQVobAEnupzxv96jwAESgl4SU+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105564; c=relaxed/simple;
	bh=iZis5zLxnFWmVJZALoC+7zO5IX2YaZ7dSLc97xxGo5U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmfCiNKVEGI5qUxFlw0fcyTI1kUwx6O+3m9l7NVhu/ykNXUvdDo5zC0Rrndy5l9NLUoRWgLD7IazvbXX/8Otn/l5jEspPpIp6MiRre4VNblHEEo6jTkKr4TlyC8B7Y4V1aKRvFTf+5Q8HEmcYo4VkhJSkuul9qRqyn98mDY3xD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=r97fVelp; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61b68644ab4so32057657b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105561; x=1715710361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XciRHnXwG7+rxxPrjA/zpLK8DRFmxqEElJp0i9BkG5k=;
        b=r97fVelpyxF1/TkrBLPWNR7u486AFVUce45yEK/5UjuzCbDdn6tFbAI5EBXCMwOns3
         TmMQhdpULRjET0CH4TL1rtDjqLYWBQwXAHvSSORLe0BPVVYE6bFfWkSXgAkFmB0ILU/M
         DN/uCy0DarRkwauQDlDzgPo96RKs1eFF5yKjAQsFnzcdmai+Z7S/5J2aCjwz3DX3Nhz/
         vFwW1fJChnuPw7exW29oHXLgjSeGLqUQOJPQsPd5DqAqUt8KZoIH1S7LLAbvThKbVX8R
         HAir4m5tnZMYbtYq/c14Y9rBUF8xf7XuKciD/2geVmiYoUVvj+eYCecD67NgrAQUwFpu
         Z3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105561; x=1715710361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XciRHnXwG7+rxxPrjA/zpLK8DRFmxqEElJp0i9BkG5k=;
        b=ZPDf654S1+GaxpQw4OTpcd1nthmE4wKU8kn/jfJ2P6BkAMGnDCSI466zB9N4tvbKzX
         6/huOJgvZ6O/j0yAhbTgWpKHNmxdlpeUxkl38B71r+9egR3wWj1wBkOKraRoMNSh822r
         wxzzq8QjIS8Qk89RRpRJjC8HWrZUuHVyl3qlf2jdCqNIlOJGxzY4QN4D3ayqYyAguTNg
         9FgRmIQ0gwI3SkH/GnhGJjQ0JyAxFUGttxOg6FDc3uG8SscKZ/537rKZMsdanK0OrjdR
         qU0UiwVRRgfdk0mQVasZYiPZ/adSgZLdYBV+eM/GJ8qVBUafTt8h5IHxUNaJ+ympQqWy
         yOug==
X-Gm-Message-State: AOJu0YyQDumMsq3uCCNpb3oCB+pzKV7mQTou/dFVo+kNHwJquFwmC4JA
	o7fbX1FX/dToJu/gbXw/9ZadNaAytmXWuNWS+FaBN+a56XbPWzj2Z6nYBEDLJdFBxumf+anDCJd
	q
X-Google-Smtp-Source: AGHT+IHvjLosrAYrjZhjsbw5T0+PoNIPHqriSLdHmrPZ23zWq//ULPZk46VB85NodVA44NFlswBfEw==
X-Received: by 2002:a0d:df47:0:b0:61a:d6ce:487a with SMTP id 00721157ae682-62085c5de4dmr6046337b3.19.1715105561564;
        Tue, 07 May 2024 11:12:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g5-20020a0dc405000000b0061435846686sm2871810ywd.95.2024.05.07.11.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 14/15] btrfs: handle errors from btrfs_dec_ref properly
Date: Tue,  7 May 2024 14:12:15 -0400
Message-ID: <35e8920a5589c41f7fd7f951e5b88627dcc8801a.1715105406.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715105406.git.josef@toxicpanda.com>
References: <cover.1715105406.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In walk_up_proc() we BUG_ON(ret) from btrfs_dec_ref().  This is
incorrect, we have proper error handling here, return the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c6f8c31087a1..743f78322fed 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5813,7 +5813,10 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				ret = btrfs_dec_ref(trans, root, eb, 1);
 			else
 				ret = btrfs_dec_ref(trans, root, eb, 0);
-			BUG_ON(ret); /* -ENOMEM */
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
 			if (is_fstree(btrfs_root_id(root))) {
 				ret = btrfs_qgroup_trace_leaf_items(trans, eb);
 				if (ret) {
-- 
2.43.0


