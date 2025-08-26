Return-Path: <linux-btrfs+bounces-16414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D338B36ED5
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEB6462D1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54B37289E;
	Tue, 26 Aug 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="krFGrNjK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF71371E97
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222920; cv=none; b=fiCP4NxSfNLnCy/Cir/Noym1ZaleB5nj/tybhsMh1ahz+mfGvAcjNn665Yc3VB02XH9NG5Jb0nFzrOJADwIbkizuztl8UcuBjEnqjUo/Oe9RqTEb6iwe0sDUo5zF/V+DuQAy99ynH5UEoFXjZhCyBrli0koGGGp01533P2TNgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222920; c=relaxed/simple;
	bh=AyaIgaj6Jud8JERDUR0C4MqVOxuTwvj6iC1ttg70Qqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqfjwDMdWobjN5cvHrpxneIUnDSJt4npcEYVBZjzHPfdXGOFSu10pkplW/mNXOyNcLYucvqj1xQ3B1S4PsA2+JiyHh91Pz98VFKYz18a+cJLvuifCLHXQsPFOW2A76uCzn0LMVC/uct5mQtBjsqOusFzX6ZZ5bsABqiZyp8390A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=krFGrNjK; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71fab75fc97so49044947b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222918; x=1756827718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVq4Dudny0hs/Tg3SlCX7d6XKt3AfTMDJTBRxWNfvY0=;
        b=krFGrNjKM96R1p83X+oky4JLk2HFtPk+A8wMnnPefNfgzgmLK1KsUYQ05LdDwTjCGi
         ySQ/JOfyr+l8gXbljhhPr4cBIKcmh1lUOceV+UD2cCglX6KjOCO8AaDl97HLP1fjEdVk
         wO4BbBwfT9NSA6n4L8s0NzUjQuUEgV6Frr4SD8jLbIJ/gwj3olWfX4kY9ZvChT0zI5BA
         sNJeidPgJ4WdH7N21w3zUOmlh6a1Z7/v93WA8aRJK3LoXECzYR3SDknZYLp5rxGp9SPd
         srbz+OcP8CitgIZCu4CTJLaq01fG6al4BDbbBtXLv6ZIHmATERoVNeJLbRlpdosdGVD6
         7xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222918; x=1756827718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVq4Dudny0hs/Tg3SlCX7d6XKt3AfTMDJTBRxWNfvY0=;
        b=gPudqZxcVGEFrZqvCYB8qHMGVrYXq+qOgYGzw5d+/H5DUDCqKQ2upS6UOvYEMom5fy
         6E5wMsTgrO8MOId05nI9ZlVfYYmZ7mPosHFD3JAiz3fuYARw5KBkgjsPyd1awwtkm0jw
         NRAoZZ6li8yTzoyd6b/Lw1kbkRqib5Bl4K15rJPbjsiqhKcSa1BOcjX9SZiifGRcRfzj
         bj1ZdjBYD2kthkfVZSNg1vdor3DR3USknPBCmqYzv9BVKm12DWozhMH5/WQIjN95bZPs
         85rqkyE6hBzalbErz/svz4rtd4iV9nFmXpeBw1G/sTXlq20sBty3mIKw+NvuHezW0ZdD
         5csg==
X-Forwarded-Encrypted: i=1; AJvYcCWXJKd7uFeC/ixiBsj/CRL+kQau892JJJQbd6lNM67xK/jioS6aM1DHHpypg++YFfmEjlvXD+9azcxHKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ82Au+pCK0Fd7HwFhluD1oqqnQHDbDKxANEjn6+LCyFL3wWvz
	92CNHA+4dhysSnjrQ3tq2VFYDNqnd9jDVwHOrhoUoiWdZyaEbTCprQHtV++YvND+FDc=
X-Gm-Gg: ASbGncvlYsxntaODaAZi5f6YtRSfl7QbBwUVIt34kDLumZAxPM5rLmU5fLFMO1ANeIn
	X6gUAf5CP+DfvXS7ta/5lgl6vRWtP3jH8xCvfsRWhCuAPVq8zavuCs8miV5gNtkytwIscSTZ+dp
	5BVgHGHaIW9gZugCLWu2bnCFCR5rJirpzaOeZ+zuJELZEIFVGdigukyN9DpDnAA297mlIDlIue+
	ZCodN7XuGEKrxAfP/4CAdY1jXezxN+7XXjOmkgcKXkn/diiVimbnKysPZhmNw9s8jZeLqNCIqvD
	LrOFGPDu/FoKfR9yNy7VWT0VWLnZZeMLkuFc+qaGdzZ9PDovWW3enQeXYGZscjvLXlqg3u5er8u
	ABXRdSMqMjgYIWta0luIslUiGKc2WfKq8jq6Ev5/BACDE2+LmruAM4zxdO0aZ5tvPQKSaV9+cG3
	j9QEmp
X-Google-Smtp-Source: AGHT+IHLsg04WEluK1oVuZpp+6T+vzscvTqme64BMq5PmNGW6Hbr2OoPh7UrrVnEqIvcPfOFGZSMjw==
X-Received: by 2002:a05:690c:3507:b0:719:f7ed:3211 with SMTP id 00721157ae682-71fdc2b0312mr166349697b3.7.1756222917584;
        Tue, 26 Aug 2025 08:41:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17339fdsm25186297b3.21.2025.08.26.08.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 47/54] pnfs: use i_count refcount to determine if the inode is going away
Date: Tue, 26 Aug 2025 11:39:47 -0400
Message-ID: <1d54ccfdd1e49bdb270e1cf1f6482b809f037d73.1756222465.git.josef@toxicpanda.com>
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

Remove the I_FREEING and I_CLEAR check in PNFS and replace it with a
i_count reference check, which will indicate that the inode is going
away.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..e400e3334c75 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -317,7 +317,7 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 			WARN_ONCE(1, "NFS: BUG unfreed layout segments.\n");
 		pnfs_detach_layout_hdr(lo);
 		/* Notify pnfs_destroy_layout_final() that we're done */
-		if (inode->i_state & (I_FREEING | I_CLEAR))
+		if (icount_read(inode) == 0)
 			wake_up_var_locked(lo, &inode->i_lock);
 		spin_unlock(&inode->i_lock);
 		pnfs_free_layout_hdr(lo);
-- 
2.49.0


