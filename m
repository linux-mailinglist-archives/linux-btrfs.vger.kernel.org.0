Return-Path: <linux-btrfs+bounces-409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E52C7FBCEA
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 15:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815F1B21E7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5AD5B20E;
	Tue, 28 Nov 2023 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JWIwD9aZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F79D64
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 06:40:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso3458726f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 06:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701182437; x=1701787237; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzxEIZ1a0Bbur1zv6Y8NdUQtYhQOEvi3S02asmqf8qI=;
        b=JWIwD9aZZkbBaJM3PC2cCZ5x/2cg+A3QKgvSMCX9Td55/TVXtaEdZMXLYpCU4CijYD
         aIsOA78u0Bmp5qYLiQuuLue9jMVMRTjqLvCUnBvvMcU//v+2r5CRHid4rM/EWWb5jIWd
         BO5fmTcjVffX0hwbZU548zKVn5dsFoLIOSOgCvUQxC/Sz/KF/8XW8rzMCK4JJnmwSPIZ
         D9EJHRax5/Y1m1Tz/JHF92Gxxo/T7+xWfX4iA99QEspWSmN+rgfx4pmt5LbfPo27rlwa
         xYMS7DKPeGEmY614bUOnDb2AJ+7wVeMG2DQeJq0y7xr0CYzHzSTsxv8lmm+LDUSmWMp6
         o6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182437; x=1701787237;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzxEIZ1a0Bbur1zv6Y8NdUQtYhQOEvi3S02asmqf8qI=;
        b=LffoP5kcVGZBMgtLDCjnjDW3/KcyVxPTrtP1PDG3k15NBFXo4DRq8qtsImxw7chFKi
         hUOi8TLLZZMNyD6EgKfInqjRY9hDjAAXxx5/tJBut5qetVTqGxjEWC2cRwdQkN/zstZ6
         jEtlWsUV/kvBYklHrzDcDSKOa0v0INEL1v/+qs3O0m0CMHfLZdcy/wUcE+E1EbENEOuV
         qSV2jg/Vr6bhjgpg5f+j+yXUAjQnOVWhQHU2iD11ItHEohRnDGuyAnXZ68cWS+8cvgDo
         E4Adm+YisWNK64x1S69pZqly0dE16K6PmJ7uG5OMajKv1/RrQx1Y/39pYxGYzWt3F1hr
         7SgA==
X-Gm-Message-State: AOJu0Yy3KoEU/e2TWjYwoks2Wu0tfJv7zyTIqrlvDv/pP7If5vuSmaJk
	owP2MdKKMkzVaytJf0eF/vsOhg==
X-Google-Smtp-Source: AGHT+IENp0SUZKfT5lEo40Q/N3qpgq/dOSWXFTJPv+Mkdvm0u5FHqyqCm4RXLe2LodVsnCvM6YUt7g==
X-Received: by 2002:a5d:4843:0:b0:332:fa75:a8ed with SMTP id n3-20020a5d4843000000b00332fa75a8edmr5644553wrs.24.1701182436798;
        Tue, 28 Nov 2023 06:40:36 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b00332c6a52040sm15053018wrt.100.2023.11.28.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:40:36 -0800 (PST)
Date: Tue, 28 Nov 2023 17:40:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: return negative -EFAULT instead of positive
Message-ID: <00bb6e21-484b-47d6-82fa-85c787d71a86@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a typo here and the '-' character was accidentally left off.

Fixes: 2dc8b96809b2 ("btrfs: allow extent buffer helpers to skip cross-page handling")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f9b47f5d7e3d..62963bc6f61b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4085,7 +4085,7 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 
 	if (eb->addr) {
 		if (copy_to_user_nofault(dstv, eb->addr + start, len))
-			ret = EFAULT;
+			ret = -EFAULT;
 		return ret;
 	}
 
-- 
2.42.0


