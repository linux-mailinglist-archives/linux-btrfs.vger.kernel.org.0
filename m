Return-Path: <linux-btrfs+bounces-16241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3931B306E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368A11D23239
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC85391930;
	Thu, 21 Aug 2025 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="DLDIi4rN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A8391934
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807679; cv=none; b=WCCtS+C34qutNREUS7T8GXgly5rzndBT7oAtbLXKK82Nwb+3ldALGvTfdfh1rUsw/iMV6WFb6MGv5fE87/evOgtz81KLMWyfz00APKunq/EUQYvm55bBy4wRa465le83cHSw9vkObBREz0z+2sYmiE2w150kjGHgXqMcpAwx8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807679; c=relaxed/simple;
	bh=EA31L9PrmSa4mzObQI8v1C5H7seTrIKkp2OpM8ds5og=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnpVe4j9Xfv+Ek73TxlpK912TCTaxtntTA/QwZXv7fLML+waqhV2EYl7idNVlwR1wXa2+ON0JHHmYIGD9g65i5fZrWwomagbfs+oLSHOnuEzdTa0RobbIKLQNTIU4sY9fK6PKy5zWAdQrb5lX4FTz45tji4HELMRK5HECynj3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=DLDIi4rN; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71e6eb6494eso13049967b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807676; x=1756412476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fttr/Czssr2JLi9HILzKnlPA1YaQWhLNKR3od2b6IE4=;
        b=DLDIi4rNpMnP1w8WKNEz/NrFJAeHEgel8tFkBrva3PMLG909BgURMeIh4kY0QtNR1I
         RYElGxvmvtWcV/B1Zes462eeQP2S4wgTYB/8c634lfV45uuFlrFiIziS6vYbE3Io1O/P
         FGJ1f8AqWxmlCuJAA9NzCtsJUtq4t8QL1clc+EQHh+kzDf697pXdeYbqo3mZuaVUNHDk
         3jW6EWYjAYWRzDjcZxTVWxev9woPX49iKbZBoGAAmAUtZuazuHnVRb/9UKfQ/PV9ROOm
         uP0jDdo2BKNi/1X9l8/0PvAtaOduAacBpF/JhOhDz8eowGs3fT5bUt8cK/ZwjICVyK1l
         oe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807676; x=1756412476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fttr/Czssr2JLi9HILzKnlPA1YaQWhLNKR3od2b6IE4=;
        b=QGney5rvWem9y9DAvlb882mB8P69F7ngZiSON76m3xwLymVSqJJxcHMM9ZSkR+9RU4
         fSpUwj0eGiK7+V1SbRe04ZAqZWfZVTV+utvrHm9XVA2ejJX7LDn7XGDQYEgUDxhgHEft
         8wKcT7czTF4I0PzX0zJZz6qoohM1m3Xd0jxYGP9RmvhYIwLBBFgSNYhwvwMSuFTl+VZn
         WlgnuvJqrvNdwR62TbxHvDIRjWPCPTpfnQuNc10MmCww3e6nQoMJnsDARCwDnPnitHhu
         5OtcGFBodOwsOgPCfdpT7rocrGoncGi388inLjJSdamd2Y8/C0weVwq8J8h6yeuqdJTI
         wpNw==
X-Forwarded-Encrypted: i=1; AJvYcCWCa/IBNnENQ1TySiJCxo+wNyBNx20DoSj2ZMr7114w50IQPqWJAzh9PQlqiUuR8+tX9TrJ56CsrZt/8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4z9/R8jOExvnRl8XqUztJSUgYawWmCutdpH3rMtOd4E9nERnD
	EvUR3qTVMxYU66wuYdmkAyOTgDvIm2QnYN+8oDzy3KnZ0/wD9qufKdRsQm41XMFrmdE=
X-Gm-Gg: ASbGncvhJSE+W5yMQ7haO+/8M/gdeDIp8hPOBWFHXFx3h3CW51PaJE9AHFDBlqOtpnW
	3yTw1Z5gqOWw3THjfWcEfjlBEVFPzBcsgbwIhIpghFd2vxD3uOyYcD7uuEwdy9apc1gepOuBpVp
	d5xptrI/3tcTrYE4wnsD9Gv+glEsEqKQiENGUcqNusNtOgnc540O8E2Lk3f2msWVdsUNPj3ZvM0
	+bQcf23Iy97wQYiY3CGeNISqz3QkTZIR2Hax9TlyJbV/Zc01XCTP9qyEM38j7I4c8rJPiD/GGJC
	68/kkno11BX+TwHb/ARUqNcFzc5L6P0jZ9KeW14qdmXgnCjsvSzKt2iGIOnU1g5i5U36w6mtQ2r
	6HS4NITEpVZ59se8tgMaux2O4SG5SDzsM01DEYhwZf7t+Pk12vYCt5/z7h04=
X-Google-Smtp-Source: AGHT+IGjxSgFZ9mWOECEHAMCC7m5i7vQzRMSl3lQEW4CVdSnSyB58BReHuV0rWkHihu4WR2jiQXucA==
X-Received: by 2002:a05:690c:968f:b0:71f:b944:1027 with SMTP id 00721157ae682-71fdc530cccmr6134537b3.48.1755807675427;
        Thu, 21 Aug 2025 13:21:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fae034dc0sm17871677b3.74.2025.08.21.13.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 39/50] xfs: remove I_FREEING check
Date: Thu, 21 Aug 2025 16:18:50 -0400
Message-ID: <1cc3d9429aa4aa8b5b54d5cd54f7aa27a1364b78.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can simply use the reference count to see if this inode is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_bmap_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 06ca11731e43..a32b5e9f0183 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -514,7 +514,7 @@ xfs_can_free_eofblocks(
 	 * Caller must either hold the exclusive io lock; or be inactivating
 	 * the inode, which guarantees there are no other users of the inode.
 	 */
-	if (!(VFS_I(ip)->i_state & I_FREEING))
+	if (refcount_read(&VFS_I(ip)->i_count))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	/* prealloc/delalloc exists only on regular files */
-- 
2.49.0


