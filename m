Return-Path: <linux-btrfs+bounces-4741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA4A8BBAD2
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2024 13:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD9C1F21F76
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2024 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC84C224CF;
	Sat,  4 May 2024 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6rSsirU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7AC1CF8F
	for <linux-btrfs@vger.kernel.org>; Sat,  4 May 2024 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714822729; cv=none; b=ceQ+Ge/PSEx1fFw0XNoxssYfA/5Yergmwu02+UwWis4/BTlPotswBhWLr+ZOa5i5ztPoy/PbKmdU3yRp0kSTksb+bcEU8AaxSYsQydZEUlOipeMIE0jFzbWcLrhLb9/S6TVDAmACUgTOKYRUrQyQt4KJH9psDV+Z4AaiUkjGZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714822729; c=relaxed/simple;
	bh=W7sFU/NBzY2gTAuU7v68tSUG7bpYXdqwLPRfBVRFeu8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PKUb2BeNCWKpMnellrM2Q9ug5y7q1omWTG8TLdv49diG8llykE14dlKCvz/B+yIsb/qgV3k/CFmOlQJQlW3YgQZ2CmIZoxX+Z+YS8C3aYqD3qqcpFOreESOvEUnza9P2nBOWFP3/FzNPcf5QiDP6knRHkPQ/7R/deWuN32tgujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X6rSsirU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b2119da94so3544605e9.0
        for <linux-btrfs@vger.kernel.org>; Sat, 04 May 2024 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714822725; x=1715427525; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MA9CnCgEcVb7taExL/ppkOG7f3FT7xMxv2EZ6jhbciU=;
        b=X6rSsirUKwf83GPK55ontntEXXPnWa/x1vcp1AJtyHn4Pfkfax6iSIoqDLYEoieufK
         GEf+aUIWNcD9ck4d17ceNTX5xLYzwPIR1Al3F+AUBVPQ+reFZCRPNwU9R0fA3KleF8Aw
         nc4kyu9sjzBr2JJKNghChAvi9+yTgu2ZazeRyWJG2krXuaw0WleVTb46Um2dWhu0O7bF
         g3vleF1Zq8MoJ4vJdLs7u70d0ovT2GJyCsHqZV3JmvIlkKZTc299H/svEg7rdK4/dSIF
         UR3eWD3llc2/SBgxbacPV4gcXrSp3GwCw0g/XFXeJePmwuKGntIz1FkFBGlKr7YQD9Zu
         yLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714822725; x=1715427525;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MA9CnCgEcVb7taExL/ppkOG7f3FT7xMxv2EZ6jhbciU=;
        b=rChi4ZW+LYEeKUM7gjA6uZSEhqxCtIZVm9qoZ9iHkR04Se35qAGOzhAXeCrLQlfu1T
         ZOCvgT1ot+sOvcQv5Ur2POEPSGQI4EsgdCt8okMGwzcTbmyjn29gXzjK3G+exyBZdSKo
         F53YpgIAyZo3voU5M/dy7WtZHK+dyEXrGDcN6XFPxnoL3qKsftDuH7VDp+YCwyR35apt
         nGC/5LswPQeu0Z/OMeQ+nVaBzsnPkXPFKz9QBk3nin9q5HH+xx9vPllfNFB9PkcUHVkm
         jYes1t54LS29tjrO7n9ijhKU4kISw6fsChOSgzL6wg0cwepZ/oIWUYCYMUQXP6+GUZqx
         Xsqw==
X-Forwarded-Encrypted: i=1; AJvYcCWZakyw3f7wAb8qSsGh9wHbQwTIZB24iRd1bpDr/pTtSUShWuZMAl4QUuegrGYB65EKYMQ/H9gIFLxNtj6TWlMFhcH3i/ZdnMXg4GA=
X-Gm-Message-State: AOJu0Ywqm1l7kItjzHU8XZlrpBH3P9t22MHD092GLZcIwwO4yXIWirtA
	xxnR5IQnlcjgSsG3diuPR6+rFGejILMakn1nNSKh33gr+idkwngOvIMh/QSjRtw=
X-Google-Smtp-Source: AGHT+IEkJ4fOtICM941w8eVuYTvSQvPKGtFpzVYQYzbWbR7QYJoZ1oKTpJnJ8jAyaUP+45cwLrsaFw==
X-Received: by 2002:a05:600c:4f07:b0:41d:d406:9416 with SMTP id l7-20020a05600c4f0700b0041dd4069416mr4117137wmq.34.1714822725029;
        Sat, 04 May 2024 04:38:45 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4988000000b0034cceee9051sm6018954wrq.105.2024.05.04.04.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 04:38:44 -0700 (PDT)
Date: Sat, 4 May 2024 14:38:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Boris Burkov <boris@bur.io>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: fix array index in qgroup_auto_inherit()
Message-ID: <a90a6d6b-64c7-4340-9b3d-7735d7f56037@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "i++" was accidentally left out so it just sets qgids[0] over and
over.

Fixes: 5343cd9364ea ("btrfs: qgroup: simple quota auto hierarchy for nested subvolumes")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Untested.

 fs/btrfs/qgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2ca6bbc1bcc9..1284e78fffce 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3121,7 +3121,7 @@ static int qgroup_auto_inherit(struct btrfs_fs_info *fs_info,
 	qgids = res->qgroups;
 
 	list_for_each_entry(qg_list, &inode_qg->groups, next_group)
-		qgids[i] = qg_list->group->qgroupid;
+		qgids[i++] = qg_list->group->qgroupid;
 
 	*inherit = res;
 	return 0;
-- 
2.43.0


