Return-Path: <linux-btrfs+bounces-1693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D651983AF8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7C81F27334
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906B885C44;
	Wed, 24 Jan 2024 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WDkSf+zF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C3082D7B
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116774; cv=none; b=BEBmVt6qOqqUCcl48lxdBdBgFHCk02VReSahrXasUnF521TVOosfIwrf6/7nD7IZDP1Hl1WXnP2tiG1uXw/v4Soe0dWXjsHunSYtcONM2LD2YVUAM6TTFLmuzk/F2J2IVoDyhVqc5HNAWkbe3MrGH54RECLoAkvGHSZ52vZ0zCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116774; c=relaxed/simple;
	bh=IzZbnNi2HvSrxNI5el6QIj8D5vc83fohl+628NeiNos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZcCOcPPtnmHQHt/r+rd+Y+3oRRNfrqp2kAo4RSuC/0UB5lWdiJL7OICfntPUVYob/gEc1axLzHTGUVJMP5fDAR/iK02Rsm4Ie3bxhyfFQrB78aYy4B9bChqTzam0raPSNhm66/cgl0yHuHB0oieWREJqRa7pMZDhvYaxHlfjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=WDkSf+zF; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso3588738276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116772; x=1706721572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNcc1gRUx/9vClORZZm5lvfIUxidIgjQfVOu+2PLHfg=;
        b=WDkSf+zF8u1GYZtxYi1numd1YChdI1WehuPouqzjkoDpjO2I4oBM95QN2bNgxMsJ3i
         NhN9KjoA4yTItAi1+vaW1s87brUhyqBw7EWDx1+stJk0D7xA2+zb6s/bcmFZQA/iryDL
         /Ffo6OSfEYgCfdSH4gWbFbEgMyKSAjv1QEg1sLSzkGo0bqpMlGXZeFbzrudcHo8fVN1d
         UaTjrL3BN/qJCA3piYST/AX2PrUoPPQ7abkgXX21oP2t6Z/IpdXe12Y7MoRIS3a7NQAa
         9mPfdeReY2EN9GrXNHZHNnBkGNlqgvNWOmpYxow1iSHgDEv/OijwPBqHm22XbQ1ARsZC
         zNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116772; x=1706721572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNcc1gRUx/9vClORZZm5lvfIUxidIgjQfVOu+2PLHfg=;
        b=JyXhDKsBcpLbeRT8SZLk1xOyZ0Nc/+bDfJFoZ9agUl2jNAJQY+tkw/r3d5W1sdFiai
         FzO65fnSULnVmpE75HuyTj9MaWE5zs2UFOyZULvzlzrfh4Cn7LjRxuQDlOF+DCp02BAb
         ibknOX9ZL55ds59ay+rFJTFEFblHxrUwwYUFw0IP61YiKaH8DNp1LSDYEZ0bsDlJxr1A
         I9I+ELp873sjml9RjpkcBj5VJTO6l1G8btt22BPbVpK1jpZcIpj9qRVsnSqsxTex1Bx6
         96wpFPfy1bHergHO1vygrw+eRNQ98saN1IK5FQIFPGGq+pd4kIEcZeSBKi3mf8O1ixrF
         pxBw==
X-Gm-Message-State: AOJu0YwhazosYYUmzHRfmI1LtgwcHcD9WhyXxF6ZX/2VR3RN0nn7KP9g
	j8v+FLxzT4s5TVPh5mK4Ir2o9LyPzYvbMfetHTqpq/5AKZYcoPRPt1JjXQ09UGU0wyDRRP/Ra+x
	B
X-Google-Smtp-Source: AGHT+IEYRstLN/qS9tb/xBT/C23PpWQcoFuq4vGqD/W4TM5fMtNOxoJOjQ6Wmx6ay1kZafFDjLaYpA==
X-Received: by 2002:a05:6902:1351:b0:dc6:8b4:7388 with SMTP id g17-20020a056902135100b00dc608b47388mr427152ybu.35.1706116772363;
        Wed, 24 Jan 2024 09:19:32 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z13-20020a25664d000000b00dc278dca7cfsm2848813ybm.8.2024.01.24.09.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:32 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v5 11/52] btrfs: disable verity on encrypted inodes
Date: Wed, 24 Jan 2024 12:18:33 -0500
Message-ID: <f4f34a604fa16b8b91a4db0c6f3bca3beca22ab3.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Right now there isn't a way to encrypt things that aren't either
filenames in directories or data on blocks on disk with extent
encryption, so for now, disable verity usage with encryption on btrfs.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/verity.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 66e2270b0dae..352b2644b4af 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -588,6 +588,9 @@ static int btrfs_begin_enable_verity(struct file *filp)
 
 	ASSERT(inode_is_locked(file_inode(filp)));
 
+	if (IS_ENCRYPTED(&inode->vfs_inode))
+		return -EOPNOTSUPP;
+
 	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags))
 		return -EBUSY;
 
-- 
2.43.0


