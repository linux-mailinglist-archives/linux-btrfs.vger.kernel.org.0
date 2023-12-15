Return-Path: <linux-btrfs+bounces-979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE9814D3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 17:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48D9DB2319F
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5563EA6A;
	Fri, 15 Dec 2023 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FA80nYDk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E551141856
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e248b40c97so7828897b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 08:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1702658224; x=1703263024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YCSKI6lrv9s+nJpwdOtqxsTFmIiXkL+kN8zRH7D1LFo=;
        b=FA80nYDk5YxZ8fQmJ/r+g420FVPQ8Tk2rt8UQ/9rEakdXRosnWsqClbw8mjcK35Btq
         jxHDNzwaPLnxhM3hgLQoTxsLbZdQTW2He6FqjUXNyW+HZoP5DEMSgkU79iTqwiloVnWD
         X5HFctY7yIBf2LwUxcf6nx7h/ZbK6tiAHwuBrkgtxMREmAEZ1OrHcerSl+cmOm4lQi3a
         0dx8GiFzLbyrSryW0tuFjJ+97eUXARy1cPoI+XjjuEuBbupUli7kOElE/OD3I7rdcNIF
         jDgk1ibpRD5BUs1j/olSXran9MNgNrBC2DpLTbuAM1Yqty0ytwW2BaKLieBaYkcuRKxH
         E1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702658224; x=1703263024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCSKI6lrv9s+nJpwdOtqxsTFmIiXkL+kN8zRH7D1LFo=;
        b=LSRt75AmF+yQYJaVem/i4w3ZF6lLU2kznWssAwPJ7QbAKyapgu2GiiabK9nqpu4/2v
         PlY2yimfeemfA+Rqfp/IgApQzJvrVg87GeGgyK8Yiz7YuGLA2QPcVkLlAN5lChYdGpWW
         LvuSqLUsR4pUVIB75YlKPbZDzNMuMQk3ihp5R8n7W81lpAYxPz4u9X6e14P3cTZAJuBX
         dOikd2ixPBK2sOhpZolydPKJeHzGbgvDOMZI17pB+Xgh+6n+mCd6XYJXF89Q7IKHq56w
         OZtB59b3zrTm48WE64bxvGcCSLNqv4yP2egKKcSRlZHKDOl7E0R5F3vQLk8ViF97RYIJ
         K5Mw==
X-Gm-Message-State: AOJu0YzfVpGbi2M+LDFA5zWoPAehlMj/dBE98wiNMTuQGtuHqQHyEpl3
	9ISXyxbPB9Lip4iGd9jxzqXcU8mPX6afwUs8KP4=
X-Google-Smtp-Source: AGHT+IH9Rx5t5ON3hqO2h2do1LIkcDMVVsJiFGpr8znG5qJ9fI40SLakj2LQMBVoSXhmv1q0TJJ4Cw==
X-Received: by 2002:a0d:d58d:0:b0:5e4:740a:b5a8 with SMTP id x135-20020a0dd58d000000b005e4740ab5a8mr814392ywd.93.1702658224522;
        Fri, 15 Dec 2023 08:37:04 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p5-20020a0dff05000000b005d38b70b3easm6485814ywf.19.2023.12.15.08.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:37:03 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: handle existing eb in the radix tree properly
Date: Fri, 15 Dec 2023 11:36:59 -0500
Message-ID: <93ba6929e6ce070bd27bd80220bff7112793a3ca.1702658189.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix can be folded into "btrfs: refactor alloc_extent_buffer() to
allocate-then-attach method".

My previous fix simply fixed the panic, this fixes the memory leak that
I observed after fixing the panic.

When we have an existing extent buffer in the radix tree we'll goto out
to clean everything up, but we have a

if (ret < 0)
	return ERR_PTR(ret);

Even though we have the existing extent buffer.  We've looked this thing
up so have a reference on it so we leak that, but we're also returning
an error when we shouldn't be.  Fix this up by setting ret to 0 if we
get an error back from the radix tree insert.  With these two fixups I
can now get through btrfs/187 on subpage without anything blowing up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b42603098b6b..375fbec298bc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3731,6 +3731,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->buffer_lock);
 	radix_tree_preload_end();
 	if (ret == -EEXIST) {
+		ret = 0;
 		existing_eb = find_extent_buffer(fs_info, start);
 		if (existing_eb)
 			goto out;
-- 
2.43.0


