Return-Path: <linux-btrfs+bounces-20520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E40D2070E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 18:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2601C307933C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345C2E9ECA;
	Wed, 14 Jan 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrAUTmzU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F32DC350
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410427; cv=none; b=teLN4rFNeEEsDDp9wfIxih8+l+aE5ia/Wx79Tj6JS/NR6Dgyw6b8PwlWttBVlBrKfKDoOoi9xLMSDGZdYrB2lNXVTg2r5viC4FbOK1kdoomgkQpzjUimW3mFhFANfQFQmfx9IvSr56pJAAwJtJTdidJ8jMaqLiJ15hj7eaRGYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410427; c=relaxed/simple;
	bh=TbzI/bD6DFrQZQgun/mAh3uK12x79cRdzpvs4SaNoVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nVbzO77vjecSUIvQDYAZxaJRM/w44+Z30PUWMs7TOtvGbnMOUaFe4DPNgBm5KNCfX6OCQ66TqliOJj+NbcMR+0PZ7nwsz+FKPyPZk0CqVIGYEGwoVSJ0BoH4tQ4CxlSn7eP7k4Y7KDko3i5QzD8lJ3+928seL9ZJSJPAgyv4aE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrAUTmzU; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7cfcb5b1e2fso8678a34.3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 09:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768410425; x=1769015225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QNhEaxSZLtZ583ZqqjEh4HtDQY1qITTRwZIloM+cVRI=;
        b=OrAUTmzUZShXdIL/Y/TPzXvsO5JqddwvJlR7o8tfhkl9jL7vRtusLUiiUYs/QxMIb9
         M7JOsmn1ho6uFNrueDZZIdw0R9+IS0R9oxq/FJ2coJZpJaYkkyAIIbUqbKG+IEBaLNV9
         M/WbrnS0Ce81EbWB0w9agHn80dtO6BFOrNrhZh7M7XRDHFdN1p3rqOuI+38GLo6b05GW
         jvNx0Uasq8EJq4NhLAfmPvSlh7nfob1Fes7gRklA6jP3nSg5Odh0gfcFC5POOt/mdRvG
         3AQsefV5dvDXacl9OVlsQ0GwVEurpIJ3Lx/PE1gXqY6Nvrdzty3ZPDDjbkr2mwVdx+DN
         HbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768410425; x=1769015225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNhEaxSZLtZ583ZqqjEh4HtDQY1qITTRwZIloM+cVRI=;
        b=Mkl5v5dbt5FO9bvVzkmpuRFNi6BucU5r7YPbUpPgkye34BcTufvh3icakxjMVg/m3+
         /ETpXm6f5IGqAAxRROcL9OhnuJMa1EpT2mnxFAtJYFs1ZBsjBPYhkXhSGK4YdX/vl1Xp
         uT4H2TiXrzVT3fgTHteS7LIzFL6kedfZOugKmxUVjx15O8hElq1LkxcKoSsc1ixgc+Ff
         4kejTZnird0zmaR4pYAdiheMZ/VQzPRKpaRx1Lzvci/eDV8CPWaQCRYwjoW/DVU31LdR
         mpDxTIkpKN4KlF5hz/MpFfBOFTnD7OKl/d9nhwWbyPyqlBgoLm3BTOANo50+OKsTAWw3
         i0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXidOF/zrpz336TwkyJayTmO6Xl66KCi6kcTDpkVbh/q2iPi8v4Q7yUHeohcIOqYkdImKTeBtS8Jd10iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOOmfUOn3g4DmR0T8JzGnDXm6oeDFXRm6wAhQ8g05xIBKLx6A
	5HYlXX1JIIHHUZpAYhbwfJrotSbo1apUzpgEIQH+5bqKpdM+JjvC4cji
X-Gm-Gg: AY/fxX775THQuENFP1Rx3mL9jc/bqwTovCeD+HVybjLn4xXMr2uy2mb8Je5WGJQUJXl
	zx6iol4VneJU2Y1pXUzqbCsa3EkiR5ylmYHcYRgf52wkoreYOMNGnSXVMA3wpFf/hqx3GGL5AVu
	gZkFMamHzc4YLAS4pQ18SMJBRA1mmENtHplrDZKrayFLA5o6zz3Yu/zgP0hW7Dm8TNWrcwIj6XW
	SC8/hz0kGosNoAEijvzql1+Pz2UIUcWej6MJvYHu9OsfxcVe+M8qVZEX1ytsQI0+I88YrhPxRRw
	nvZvSXm7NNMHSq1xCd2N47SPnKUINVzzezt3/h9rZJIF3h2lHP5mQbouMADHxpuW40Orf84eFeH
	uzF/StdBinXgnKMrJilFXjs8lnuezHK9B5NdyJbZSK87tDZsl9YDH7eCDiPTXxnyHy5mYSifSrf
	RqqGGjMwSjuEiSQ4fp6s5ihFEB89NvbDFl
X-Received: by 2002:a05:6808:1a07:b0:44d:a429:e816 with SMTP id 5614622812f47-45c71531796mr1770671b6e.53.1768410424692;
        Wed, 14 Jan 2026 09:07:04 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e288d5fsm11880164b6e.14.2026.01.14.09.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:07:04 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] btrfs: fail priority tickets in maybe_fail_all_tickets
Date: Wed, 14 Jan 2026 17:07:01 +0000
Message-Id: <20260114170701.6018-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Differential analysis reveals that while btrfs_try_granting_tickets
correctly iterates over both space_info->priority_tickets and
space_info->tickets, the maybe_fail_all_tickets function only processes
space_info->tickets.

In scenarios where the filesystem is aborted (BTRFS_FS_ERROR), we rely
on maybe_fail_all_tickets() to wake up all tasks waiting on reservations
and notify them of the error. Because priority tickets are currently
ignored, tasks waiting on them (typically high-priority flush workers)
will not be woken up, leading to permanent tasks hangs.

Fix this inconsistency by updating maybe_fail_all_tickets() to iterate
over both priority_tickets and tickets lists, ensuring all waiting tasks
are properly errored out during a filesystem abort.

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 fs/btrfs/space-info.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6babbe333741..09c76df8dbc8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1120,6 +1120,7 @@ static bool maybe_fail_all_tickets(struct btrfs_space_info *space_info)
 	struct reserve_ticket *ticket;
 	u64 tickets_id = space_info->tickets_id;
 	const int abort_error = BTRFS_FS_ERROR(fs_info);
+	struct list_head *head = &space_info->priority_tickets;
 
 	trace_btrfs_fail_all_tickets(fs_info, space_info);
 
@@ -1128,10 +1129,9 @@ static bool maybe_fail_all_tickets(struct btrfs_space_info *space_info)
 		__btrfs_dump_space_info(space_info);
 	}
 
-	while (!list_empty(&space_info->tickets) &&
-	       tickets_id == space_info->tickets_id) {
-		ticket = list_first_entry(&space_info->tickets,
-					  struct reserve_ticket, list);
+again:
+	while (!list_empty(head) && tickets_id == space_info->tickets_id) {
+		ticket = list_first_entry(head, struct reserve_ticket, list);
 		if (unlikely(abort_error)) {
 			remove_ticket(space_info, ticket, abort_error);
 		} else {
@@ -1153,6 +1153,12 @@ static bool maybe_fail_all_tickets(struct btrfs_space_info *space_info)
 			btrfs_try_granting_tickets(space_info);
 		}
 	}
+
+	if (head == &space_info->priority_tickets) {
+		head = &space_info->tickets;
+		goto again;
+	}
+
 	return (tickets_id != space_info->tickets_id);
 }
 
-- 
2.25.1


