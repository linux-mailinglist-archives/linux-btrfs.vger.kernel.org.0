Return-Path: <linux-btrfs+bounces-8350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE9798AFCC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 00:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E5E1F23E4D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 22:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BC7188A00;
	Mon, 30 Sep 2024 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un2jLKrc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64618892F
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735099; cv=none; b=co4CGPYKZbcXslQ5uioCdljzbEiUZkL3B6tKbD0dsAjcDjVsKx16xmOSQSIVZ23u3fwdiIkabUiUJJijUykupjeWZ7eBPxu/jLUD2iLycsIokznR42cj/HBIYzpV5vpsyc75PviwrRMnJ3Xle6n3i4GHjRE8hZc/lowl53Pa32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735099; c=relaxed/simple;
	bh=u1FA7v2e7b2K1uzTRWYsBuJLr+kYGYFo0YcEF/+j2zo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIfQWb8Xa1UjOFkuw7glkUoIMv3GI95WmVS31D9y8/2PtrkQ3IbJ8ocQEvelJCNk9Qp0oOdBdnZ4s1Ax6I7tu32eIjyLGeW27eH8M2CzAMQlmRfeOCB5LWUHxUib9bS7zUwpG6xt9sCxPJZtqVER7RIgrE+aPCSkOSTKvxVc+Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un2jLKrc; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-710f388621fso2845244a34.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727735096; x=1728339896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/CDP2SnJP0iT48iRyFdOSPxoC9+Ho2bYgr4fhg+u4I=;
        b=Un2jLKrc4nSW7SHfiGjnZMte7+kyYULDXRnXmjQ+dkMDTGOLMVwOuLUDWO9PA9yhCj
         lYfimhByI87ywOB1/95MboeA4fAFSmQ6M2hFM2xEHO1n1afHrvWxd67TMCZU2nhHAfTa
         wi7vj7Bj1g4hlBCX4OUezwcKWDPvsyWpeDb96I1kJeZDge4eoR3HNaL21AhG9fhKIFNK
         Qc5Yh9TbP3mMDmhK7WRmKCPqTHgJpNX10U+Pz1kTr+dNhAnIGdS3RZ32ppL1iuUUVkgD
         5m2IQNkpg/KVIY1YS/m8r8eXpHDnDgJ600NhBGFApyF6J2+/8r8LU9Zw/aCnzeElfPxg
         1d0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727735096; x=1728339896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/CDP2SnJP0iT48iRyFdOSPxoC9+Ho2bYgr4fhg+u4I=;
        b=Kvr5Y0RmX3LnG9DHjPIiQuXp3LCAObvTlcR3NpEXlza78LKPx2PVNSzr1AXSykxCnX
         ldm30vS8zT781+881mQUeJ6i+FhfSicv4NcDUrbMNeh0438A/l5l2aUiLVtq4lcgK8Nk
         XS688wVvz+UrY7XVqeyyJMJ+UfDfKdn6yBfS1KbPzhT9vi8VFr+XN6l31rKeMEFldI8d
         zoqPMNhNWRntv2jk7qqCODpUIv9rjr1pV4pJXQ6wnjY+BcukDYchujcp+QWeEBRuhiWG
         frY5Vmbkh6NM/If6hxGUsWPL+/TqO+j1PJqKj29+gT3kIHniFfsvi4e++YBRouYKIH2d
         k6FA==
X-Gm-Message-State: AOJu0YyH6IWpUo4DH9j+y/OvQ8bMwFjisX4FBNvULLWMZm1QGU2HesuY
	cOF3zkBxwGD0EN4qwAVf+oGLFza5t4mSGZKz6F5SNN5ucmT5kBOOPe54nbtZ
X-Google-Smtp-Source: AGHT+IGVOOPmLsaIJksF1GcLrK0V7DMNRGu4dSfLb4gwJp+IUTZwk+g38n6d7dByV+L5DhlH1kPSUA==
X-Received: by 2002:a05:6830:6009:b0:710:f200:eb55 with SMTP id 46e09a7af769-714fbe751a7mr9359257a34.1.1727735096326;
        Mon, 30 Sep 2024 15:24:56 -0700 (PDT)
Received: from localhost (fwdproxy-eag-116.fbsv.net. [2a03:2880:3ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-714fb6d3c3esm2598262a34.53.2024.09.30.15.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:24:55 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 2/2] btrfs-progs: check free space maps to block group
Date: Mon, 30 Sep 2024 15:23:12 -0700
Message-ID: <775807e6c1507c1ec4c32d993fb1cd3222fe3853.1727732460.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1727732460.git.loemra.dev@gmail.com>
References: <cover.1727732460.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that the block-group that is found matches the objectid and offset
of the free-space-info. Without this the check only verifies that there
is some block-group that exists with objectid >= free-space-info's
objectid.

To reiterate what I mentioned in the cover letter this will cause all
filesystems created with mkfs.btrfs to print this warning.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 common/clear-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/clear-cache.c b/common/clear-cache.c
index 6493866d..09ef5741 100644
--- a/common/clear-cache.c
+++ b/common/clear-cache.c
@@ -165,7 +165,8 @@ static int check_free_space_tree(struct btrfs_root *root)
 		}
 
 		bg = btrfs_lookup_first_block_group(fs_info, key.objectid);
-		if (!bg) {
+		if (!bg || key.objectid != bg->start ||
+		    key.offset != bg->length) {
 			fprintf(stderr,
 		"We have a space info key for a block group that doesn't exist\n");
 			ret = -EINVAL;
-- 
2.43.5


