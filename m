Return-Path: <linux-btrfs+bounces-16400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2056CB36EA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09FF8E460B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6176E34DCC3;
	Tue, 26 Aug 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EozQPsVp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9F0369342
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222899; cv=none; b=t7lXTNmOlD6hjMmitzTjrAQF0Cl5tSe5I04D4JQXL/fmdMGKsgkadr2t1xcfAS46RGr72yoa7eh2dZ7B3WGRsdT9ATXfJ23CgRUhBG/zHQrTVnnnWSA20QZ9Q/Q4lcNDXY9F9sHvjRf/lBE01wnmJ/2NtmvIyQeCRewd94sVHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222899; c=relaxed/simple;
	bh=BXlX6/e3FMWvwMNd0XczwC8NoieaU2IAVI9/xOw4ajQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQ0P3sSklzzZ1RoJZe1w7VbG0voIjcUneulcotI2G4HoziM5F+D8ugJLwPNNDFuODOyHmhIMfvIwSAXqayTS/l1WrT1Vvv7sxwpJw4tELef7rReh/qBtLoSgrhIDFqjj+6QfrYCh6PwdIpIUIOQk9TOi4aX4vvqJqKNsRhajQUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EozQPsVp; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60504788so47005597b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222897; x=1756827697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INSJnyvPg2WRednM7++OGWJKHeVt/LRMVDwrRwGwm+I=;
        b=EozQPsVpDqvP6qhtnb5+TIdQFia/oOY7o40GTMwU5MrnqGP+eQX2uDl1Clwz7TmnOA
         mLpIz43D06MCeQ9rmM53PGlsfxLfdtqkJm0DJk+faObSqnD5DGx4RlZ8/YVa4mfGD2ub
         XcZW1YnPpNpwK/oYEZtKHkQ8xNje8sduDljkT1iYM0T0tfytUgufU0sX+fbEu4j1M1NZ
         C1LbB28AeO440O8XQmCNpCt2ToOiM1H21LaF6TlNlj+Gykz8inKgwjG3nyN3r+JpLhPl
         pbqXZPFFnY5tI05E4Xbw7V2v7O6HA2gA4haIK231XNSyizV1CT2JuYPQ56Efy30YnNb4
         YvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222897; x=1756827697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INSJnyvPg2WRednM7++OGWJKHeVt/LRMVDwrRwGwm+I=;
        b=bSeotAanWHQh3kZ9CnUhLSr0ndAXl9OgZGymXknr45BnAn+rYwxSbLrsJ5l4lJi4Yk
         i7+lrqdqwW+vyz7JtRalTqFK37xd1GnV3yKSW7xeS6mm31onFIJz0uSK1oXW5S8MHIGn
         BaoX1wyhK4dnbhm7Wrmqual0XHWUp7exN3DL2E6PF5CiUgkjqyBZSnw9a7nE3Ma98fNd
         wjlhsYZd2Q3bD8XySlB0PuDRUKfv63yA77ayX3I0M8Its4VWTHxYDjAJ8KKZpONL78hL
         BeufuStlK5WKCqcipg5iJDHDa1IAII7vXhnHc7mwDQN8/fI/3MXefvvPqxnNwBSwf+If
         yKEg==
X-Forwarded-Encrypted: i=1; AJvYcCVUj6Ci4YdAu1JDLAxYjGixlVkYZp9wz+6OgqghXUtGl492t7pKlMkhufjoHqAzj8HklzkF+Ch+MdW65g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa75++/93WljZ9i2MKxiSKvYFEawWFhoB/DNFaQkQ6kpS69W3f
	SYGErGhIXdhVUWhdvlN1HsyI4zkWhwJw9F61tlzdYticK/UtGkP3CJKL+t0hxA18e+E=
X-Gm-Gg: ASbGncsJWGEELbjShs4297eQckkOJIrucD1KaSW5WatuK61Tsjp6mikfYSGM/wjulWn
	7V1jsSq/ua8bhXi8bFK4Tkm54iFPydbgne3mQTWfjIQtwL1Rq6y/O/Z5uO9yCbG+7XnmLBMcWIS
	LLEOznDKbc+yN90sD72GSm0UEvda2b15NwmkapOGM7mKN5dao3LvdVYjSJkqe7BnBKblBYRdLXO
	/jb7N+G8KZ0t17YUZeK/kYqCjv3hygXFshkBPM+Z6yoGN9cUtmDzrEBrl7hKgd6KNPj1w1DR13D
	PIYRncxn4VysAPAbRHZDed77ydFgwXHMLFXBzwP1ZDNm7emV+8Y/xnNuoQff5zOZ04+dD9W4WBZ
	J67o6VWDv9VsfelT3fzJE7oniVv6nQ9Z14oDeMFvHefofqDiRvW81wAxYz6Z5gA7bRICpLsPvlG
	dIHQhr
X-Google-Smtp-Source: AGHT+IH7pEeTz6Uz6BY9mq83w3WefooqttZ9snitZUIdAl5ESrBe4f30t0FX5yPTibQ5HgYDSnEUOw==
X-Received: by 2002:a05:690c:d1d:b0:710:f55f:7922 with SMTP id 00721157ae682-71fdc40106dmr156858857b3.34.1756222896947;
        Tue, 26 Aug 2025 08:41:36 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff170323esm25307497b3.3.2025.08.26.08.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 33/54] btrfs: don't check I_WILL_FREE|I_FREEING
Date: Tue, 26 Aug 2025 11:39:33 -0400
Message-ID: <af647029b7c50d887744808315c2640bae298337.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs has it's own per-root inode list for snapshot uses, and it has a
sanity check to make sure we're not overwriting a live inode when we add
one to the root's xarray. Change this to check the refcount to validate
it's not a live inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eb9496342346..69aab55648b9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3860,7 +3860,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!icount_read(&existing->vfs_inode));
 	}
 
 	return 0;
-- 
2.49.0


