Return-Path: <linux-btrfs+bounces-13015-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489D4A8906A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 02:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCFD3B0C8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 00:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2008E450F2;
	Tue, 15 Apr 2025 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9SW01Iu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF91361
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744676787; cv=none; b=MZjPLuz2Z3iNuIg99KbbdQs+D6zELmJfGXsPGVIYAtplJPA1Ixp4tsdVbwrTBIASuNi9y3ANPw+Wp7DwvXe7LybRU7pHi5REixC2tupGx+QDeavQITKHGzckLYHuzHBiLZ5HJsr7uK4e1MKPoGSl4iKNoa7u8EN7B9yuqNBVGCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744676787; c=relaxed/simple;
	bh=HGU7kSLa7/fuKrjY3YfkdJRzVm54grnThEWUJVuuOKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uS7sYQtIGLJ+PRMnCgLW+cOwL50LX8TXTTsra3PEDU3z/w5iDcbZxVnFsre9bn4qW21hu2h4FToNArO5npBlh5rTbKoAdz9kjrgykZSR9aVvwUF7ZPrWyUGgAtQrJxm7Nhh6woVwve5EUOMX9KZa5f7J4656RzroYeAqIEplg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9SW01Iu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af93cd64ef3so3409660a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 17:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744676785; x=1745281585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8NPSCx4hAPgh2TiEmtP3RHX+Hgcj2AD8/dBFc1x9Imk=;
        b=f9SW01Iup4SV5RZUN6U6Il7qXwvoW/EYE2qiy+0QsnVZMAHu3Bw7rtWeX7PwGVVPZn
         8+rteTYKfdxo1nkLztOOPRWaQxN5gFLedHnUGeLxOy/cuLdfYhMgi2VsMyg+NOtNsFWB
         XPIJOxY3EqE33nUiIZXet2X3NeAyXleXIf2lrU16vQXhfazXYSfkIHnrvblx20kWkWNA
         I4IDt+GfEICZAxuMtcNc8z5pnNhEr5j/o+5nQ+N3Yx7K++9IpgiUI+Qu64FpIxFBdxhv
         1gpgNKsg9wrJp+Iqsg2lmsZZJBYgbvkGaqI/5qLz4TFaFkipfjyQyQxludUldGwn36e0
         fAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744676785; x=1745281585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NPSCx4hAPgh2TiEmtP3RHX+Hgcj2AD8/dBFc1x9Imk=;
        b=ZsNez3cnRTMQ+7cf7G/S0whgFri/MRZmu3eIQ4g2TmYC05r2hV82v9OV8Gs3B3ZmzK
         nWKA2XRoXv7TW29GNAJvhfFTIaIQGmwf5uT1YJfW0lc56AeSR4fuCMDePbbSBpVL4WLn
         h7zlP59EmG7JmlTqQ/+xJdEaZTPUEMT07gkYOvORyxoGTlSPZfDRdbvJCf+Co09jumcG
         qmsd2yFHiJ1L1tiLHCBQXu6MnREGqQyVlFrrv0WB7/L+D+cPaEi+BxTYpr4yPtNVBb8v
         jW/xYzSENTXS8bGbj+e79pFBsZbTujQBThXbtj/5Ql8F8v6AX/ZeVGYn/tKdJAgIBQcY
         3ehg==
X-Forwarded-Encrypted: i=1; AJvYcCXIic2IrIN/Suw8iMTO4oj6zlQ65FxcdB9GjKfhFjUPXdR0Tps9KNwpnhEOBOH5+MEfX5o4we+AyhK+EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2IXBKR1VXDx1TDu8P56EUygrmHDwj/6nFdO4mEwzMBm3fz//n
	l2cZprRlsjdXN0R1L0e230sOHQMOmZF1Vnj6Ds7RAbAaP4U6Wzdf
X-Gm-Gg: ASbGncurQXNXvm9sTj3OeDUgzz7whGFnhe5CTYN0a4cN2+KmRE0K0bXXrUSWuvs4e6i
	E5Aase8EB9PVCZUs72qlcQ4b6pnTLiQEcDrJCO00LHXl3MRqucZFLp5ieFFQp5HyekvhdwBM9ji
	B57jtNkjSaqPVQ4Y7lVMkAVx/k6F0uFF3mEzipa8QlQoi+XObdnSPYZJlb0+4QexoXGCOda3prO
	c77DmobiS0STgLZo61jdxV1ceu0OJQAyxt7A6oMLJNf9xfomqDAQvsrf/LFjxyQdvsp6doZaVro
	9vkstkt7Su8fH31nym1p/DKkA9i0jNnk5b25gFyI52EQJe4Ub0kca362aiZHAIg=
X-Google-Smtp-Source: AGHT+IFC8CNuh7JkTnoczTI3EUIwG6CmOQaxP2goDqI58503VIX8MebUXe5Cs5s87c/x/uCH/HxarA==
X-Received: by 2002:a17:902:f64e:b0:220:ca08:8986 with SMTP id d9443c01a7336-22bea4adf58mr226470245ad.22.1744676785137;
        Mon, 14 Apr 2025 17:26:25 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:7c10:8b3f:325a:3aff:fedf:c895])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230fff3sm7169598b3a.125.2025.04.14.17.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 17:26:24 -0700 (PDT)
From: Dan Johnson <computerdruid@gmail.com>
X-Google-Original-From: Dan Johnson <ComputerDruid@gmail.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org,
	Dan Johnson <ComputerDruid@gmail.com>
Subject: [PATCH] btrfs: fix comment in reserved space warning
Date: Mon, 14 Apr 2025 17:25:52 -0700
Message-ID: <20250415002552.7208-1-ComputerDruid@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mkfs.btrfs up to v4.14 actually can leave a chunk inside the reserved
space when invoked with `-m single`, fixed by 997f9977c24397eb6980bb9
("mkfs: Prevent temporary system chunk to use space in reserved 1M
range") released with v4.15.

Signed-off-by: Dan Johnson <ComputerDruid@gmail.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4d5c5908300..28521015d01 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7989,7 +7989,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	}
 
 	/*
-	 * Very old mkfs.btrfs (before v4.1) will not respect the reserved
+	 * Very old mkfs.btrfs (before v4.15) will not respect the reserved
 	 * space. Although kernel can handle it without problem, better to warn
 	 * the users.
 	 */
-- 
2.49.0


