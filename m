Return-Path: <linux-btrfs+bounces-20410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B835D13C69
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58861303093E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EF7361650;
	Mon, 12 Jan 2026 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb9ZozaZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A02E282B
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232445; cv=none; b=aTNVwaR/FuMhWvamdR41dl/KmNLCwBXsxdcjQLVXA/gMTTXtqT3Y5861L0GNSMUQYP+Ux5D3AUtGDsojS+bkUGnArF5fb2ViFM4SqOYFwrtXHY8UOaP+xsAc7f/k8gLM3e1WWi/dXSst9hRGhs3cwOmgW+cn/pQajnECzUj1y9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232445; c=relaxed/simple;
	bh=KXDBNYPs6o6+d58AfV6DwmytZgbc95aSZNdy7bL0lhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jO91jXH9n3TeJX9n2vZp70t/UuV4JYJFhIvSbfc+tRCMGNP28UecWIGytns0wZMIFN4VBCWA7Ol5tWapWyp8VTmHTHAZc0/3DbfmnxrKEuQNPdSOCVxkPT06gOYh8+Vs7aJPAU9bA546b3ZTh9HbulmkpWYUJ7ipIHYnDk6nhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb9ZozaZ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3e89d226c3aso6300876fac.2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 07:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768232443; x=1768837243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yE1TQIm91uYk1rly71VaN4veqRSHPeBF3rZ1SklWl0A=;
        b=Jb9ZozaZy8nW96ga9P3GRK8Ubi3hkicFeyaSDhn2QsB31S2QbrkAC7jRHyDiQsB41a
         sQj2oZYmHoI6b5LvCRbEqC0D+i5CD/GujrMbLH1aZ7e8FOHkxgQUCNbFel/MpbXR/NM0
         BzGwJh2zZFQhXjf8gWFuj+mvLCyV86gtkSQFMc1mTpH2WEaav4hHDFdV8PyE8PwER+LM
         /EmxJ7YOIT/MLfPc9QNvRumsBPW/J/J4+wkTp1B3zdl1dU5zOa1RJ8u1RZHei6xC6//O
         pyxy5T1LJdiXSgt4xD0vHP0wWp/6Zv+FqBYEWiNs71ggUl4qMcZ1G3lfObQtV/iYBgUB
         ALkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232443; x=1768837243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yE1TQIm91uYk1rly71VaN4veqRSHPeBF3rZ1SklWl0A=;
        b=sxYgf8bGmAY8Hx5NNG9sK0kkumP9PrgoT+rH6+zCXc3fFgBSXwn91Sy7RnntPPTcVh
         zNkInc5gQIsSFDdSAZadJBu7fkiYZt11Y2g8Q4i3yCQP6MrqsS+ScmunFhhJPCYE4qV/
         jAe7PnoGc7RX1JtS+sY5GfRzR4O7+6VtdGtvUkkSmOMfwWcADSqHzzSSnV2V+Z3vseju
         zquv6eGFIf+LgPxXqKTvMeok5fum3cz0jLvspQXLt2iV0NAayCe+pgk8z6nbcgQhZAqn
         ukvZVU3hGPfSD/omWsoHMaoiUqBq82bGilS/pfMdcoztJXCYXfb0CYHrQ1hbo4stV7z8
         mkYw==
X-Forwarded-Encrypted: i=1; AJvYcCURxlB5cOyD1Zfpc/ZEAb3umX/rKgyAAmWg8Ksrai2QA8Cuoq8oX7bfMQ2hNEMr3OMovpckgdg9dRgqEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNJ7v2YmiBK3GiQSkPBm5s4NTo7+glj55EIofOiKg4eFZAawx
	fFN4dmx3mFcG1mhO0hg21PDX7dKz4ijsfY2WdrzURdbuuk+w4yQZGZxE
X-Gm-Gg: AY/fxX6HJIWaAbIDqWnddxym0SzmhttAATmpnSNQXw87BdjBjDtKjkkk+A2TlsR3dc9
	XU+pg4qRF6mk2uK2IpK4ycX5x+gE2t2YGrTbILFWT53vmdcFYoLh9q19yA77SmRH7KKzArvPNXC
	tJJvsjTU7e4RJIbPHTNSoEmifm7t95Q68M4Lzj3rtpGzb5EYQCwxWb83QUi5RhqWz+4a9y2cN8J
	NPenkiWeu3Sbvtqco2mwEqxLtIYI3Nfygs0a3OqSTIwiu/GcGeHDw5fnWp8Qwn/X2IZqg6z9/qL
	Qa0LK58aftX/e8EJlHuH2DfbVZyDwphkW8XnXMnCa3V9J69L+JbR5bCcspmfSpvkT/l3xz9hb1K
	4tUO6ZlrOzYQhkHfHYpLMMC9zfO/VVywXDlHualVwxZ40THGV3vBZKSzoQ3zTxc+aAWbA+2UjaP
	j7fyp1jh0zz6Z8Y4C2I3QpK6dC8BoZVgep0PVAufDen48=
X-Google-Smtp-Source: AGHT+IE3iTYZiF9/gdz5+xlFIrbcHiCazX2ptLJ7lv/yoamUJcApstAyZmEQ2vt6NrrX7xjd0X4+nw==
X-Received: by 2002:a05:6820:4702:b0:65c:fe8b:53b9 with SMTP id 006d021491bc7-65f54f5e824mr6754811eaf.44.1768232443208;
        Mon, 12 Jan 2026 07:40:43 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa516150fsm12207861fac.20.2026.01.12.07.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:40:42 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] btrfs: zoned: remove redundant space_info lock and variable in do_allocation_zoned
Date: Mon, 12 Jan 2026 15:40:40 +0000
Message-Id: <20260112154040.35746-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_allocation_zoned, the code acquires space_info->lock followed by
block_group->lock. However, the critical section does not access or
modify any members of the space_info structure, making the lock
acquisition and the space_info local variable redundant.

This unnecessary locking also creates a potential circular wait deadlock
(AB-BA) risk. Other paths, such as background reclaim or space reporting,
could acquire block_group->lock and subsequently attempt to acquire
space_info->lock to update global counters.

This behavior diverges from other Zoned-specific paths like
__btrfs_add_free_space_zoned which only rely on block_group->lock.
Removing the acquisition of space_info->lock and its corresponding
definition in do_allocation_zoned eliminates the deadlock risk and
improves concurrency by reducing contention on the global space_info lock.

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 fs/btrfs/extent-tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e4cae34620d1..43d78056c274 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3839,7 +3839,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 			       struct btrfs_block_group **bg_ret)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_space_info *space_info = block_group->space_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 start = block_group->start;
 	u64 num_bytes = ffe_ctl->num_bytes;
@@ -3900,7 +3899,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		 */
 	}
 
-	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	spin_lock(&fs_info->treelog_bg_lock);
 	spin_lock(&fs_info->relocation_bg_lock);
@@ -4002,7 +4000,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	spin_unlock(&fs_info->relocation_bg_lock);
 	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
-	spin_unlock(&space_info->lock);
 	return ret;
 }
 
-- 
2.25.1


