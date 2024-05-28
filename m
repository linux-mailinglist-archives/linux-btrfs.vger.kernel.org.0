Return-Path: <linux-btrfs+bounces-5314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035058D145D
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 08:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975F51F21F39
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2324753368;
	Tue, 28 May 2024 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqNEbIHE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161E58AB4
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877435; cv=none; b=tO0sN/F1n+EkfgPT6LqGFMXt8gAsksfnXHrPbdKK/qsiU/csZWvP1xkUODmqFKQJVUdaUVXGvjcdsMWQt+lYA3604nh6nTtd6TQBujqBq1f6+NTIupjLQ6cbc0SsWJMbK9qyZdrCzMh9YH8fEq7THFDUa5Oy4iC0UzZ1QSlflrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877435; c=relaxed/simple;
	bh=L94y9wZPWtq6f1KYot/Mjg15L2qp0aGxJFTCcchw9Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FMEBEsVqJe7VAPed9/UUek4bLm/uQYdRwnSKbNMRNgBoDZpxWH7jy1KSrvIRB+LYfIYc78oR6HGx52QJEBFlJ2YCt1wESKECJl0eIEzgdJWDIO17gveegThuk/S+ou+j4zeIlq6lt7ri6+Tdd8pkeo1/W2asT5MUItfuQ/+4PKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqNEbIHE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f4a52d2688so4050925ad.3
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2024 23:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716877433; x=1717482233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKS2Yzc+m2iZeWrB2/8OdHfYeS12n5AB4nziMpwt0O0=;
        b=CqNEbIHE6VcIhJ3GpfOJdEbGgMRtFAesDBHw4OdWrboejvUnkxfJw5XV9LX2M9pVs9
         luemaDu1wSHyXpucHxxz9BU9LgOQiDFN/YMvy+zNPbkwhvxUeFqQ3LuTyvLQbcheOIbZ
         SoEegzc1UkPE6E0be4d3GagWIyhAkgF4LGz+XwZCTtUlWudKVkNh12lrmkouERwPoAmg
         gVblWg19IMvkZmC1Tk0fll9U8uhw7WXDSWjkksSfKPYi5NPvE2L3OnhnhbIy4EMuhd1b
         loDqCfK/ukw5YkE66re2A6Yn7gvr3zpk9aEsKWRc/EeSRNOCPDWLKWHiEQpY4h+g/PMM
         CTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716877433; x=1717482233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKS2Yzc+m2iZeWrB2/8OdHfYeS12n5AB4nziMpwt0O0=;
        b=gJDGwlYJWjvLvpaJT65ivhVzJK0U9vIlzoxvXmcG6g1Rg4JBeA42SdL6Rmx6xRA4q4
         t/aRU2z/j2QmGu8BcrnyuXItTZApHYLzWKHBapinVQsAq/3pYCmSnWH6TgNpDerfkrjR
         oXlQD9FPMYCCFWxK307HKXx1xQbbDuHx7Z6ER1235aCr7k5WBPJrBFZe9ur+OIUU0/+N
         ze2zTDpOE4bsplVQ2vA/9GGg4qJw7Wx+Gx2AhgjH6G/Diy2Gz6lQXn0+2Qz44i7gbIMt
         CTDvMeGBvDQlEpr+La6Jvf5xL2PP3QeHi2JvosRBIiFwdHG3N/3V+P2lncYdrm3JrGcq
         zBSA==
X-Gm-Message-State: AOJu0YzB4mYuwBNmA1BEk5LNh13jougg6KGNZjNiCYrFEX31djqU0v4E
	rcJks6ZL28c6t1jMVj+t2Y58zPcvfYWq+NBhSggl4EtL/INttppgRGaRzfZi
X-Google-Smtp-Source: AGHT+IHXFgq9ncQOT/eotSXZXaphbDjUG6u/MXYQAb/QhgdWqqmE1wruaVs+MpKysCHv0MHMoEGQHA==
X-Received: by 2002:a17:903:238d:b0:1f3:35d9:6750 with SMTP id d9443c01a7336-1f4497df763mr120758755ad.51.1716877432800;
        Mon, 27 May 2024 23:23:52 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9a8db7sm72091675ad.222.2024.05.27.23.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 23:23:52 -0700 (PDT)
From: Junchao Sun <sunjunchao2870@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	Junchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] btrfs: qgroup: delete a todo about using kmem cache to alloc structure
Date: Tue, 28 May 2024 14:23:43 +0800
Message-Id: <20240528062343.795139-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generic slub works fine so far. And it's not necessary to create a
dedicated kmem cache and leave it unused if quotas are disabled.
So let's delete the todo line.

Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
---
 fs/btrfs/qgroup.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 706640be0ec2..7874c972029c 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -123,7 +123,6 @@ struct btrfs_inode;
 
 /*
  * Record a dirty extent, and info qgroup to update quota on it
- * TODO: Use kmem cache to alloc it.
  */
 struct btrfs_qgroup_extent_record {
 	struct rb_node node;
-- 
2.39.2


