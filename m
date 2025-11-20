Return-Path: <linux-btrfs+bounces-19218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8389C7472D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 15:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0F334F8AE6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20533A01E;
	Thu, 20 Nov 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POyV9LrZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883371A9F86
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647261; cv=none; b=nwf5hUTg3Q6voEJpa76aRpmiTQzOFSSexJqVDKJ15tEbtpOoAO2gx05fK0myjQwZ6cJ0dNyf5nAZ9im+gyKXvPSDx1984ZN1MoMx5xRC2ulCt055LXZzNHl5+ssKMRWFMS6aa33x1wKnuwZJ8iEkYgi6UDXWt65mefLFCBn7gA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647261; c=relaxed/simple;
	bh=T8kjt5h+rS39H4FV8uAvrmpGGa5sdWCGj1nWS+jIc2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olRP+ScVUfF0+C1ZO1AiYs3LrKxgfMf5DRizOv3OOH1s7Qz4NLQf737Rp5xGn9k7yQxg880qLIfU4xC9u30vE4WYnTPUjosvrarxgBfYMTclv/IpB+SuJcRipu8ktESzBwoFcYlUr+3xxeG8ag/41PU3LeB0GK+691foNiZ3y5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POyV9LrZ; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297ea4c2933so770815ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 06:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763647260; x=1764252060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kXruGVXCZriDXFbUMDkXp3AVqyYWOqJgASR4exC8v1k=;
        b=POyV9LrZuMPUWcehpE3LcS5w1p887rGqrZCROzGn9v9sRntSza57CWZRwaphim/T8c
         QVSD7LwhneapgmDAaSbAS/BP578DtMrRzelDKQe1pN4PGyJv3sXpuvs0mqP69aIlygpf
         9NEmMMbLpngK6YcKW0w7SldeVTRVZvhUzwc9tP3lHhQ7scmHB4F03f9+V1cktzd7YlIh
         cOldil4vMGltEWGdMkY+QLJ26LTkcGN1bQVOvm1ndb6lLOU6ypcfyp20daQHeZUYFCnm
         W2dHGmb+uMnRU2aUtcwGPhPr8AWW8h5ZoIh3LcgM+sxB0ElD/J2o0wlfO4GPz8iLnTEp
         SScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763647260; x=1764252060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXruGVXCZriDXFbUMDkXp3AVqyYWOqJgASR4exC8v1k=;
        b=ktIw7SQm4iPX4Gh6bCTMM26F2C/nxyM8QpzjI8a3JZ+SQY6ApruanVD+qIihyBuXzI
         KEWiyGBkKkogwVurhBzrxH8aqe4Mx3rETAdQSOJZY4pfJTxBtcMr+gbxI0RdDRj3jORJ
         1/yUZyM8F7wPeAU4lpYXGAlbrXZdr7Dw/x0VUXery+RB+/HI1lBLwyf80rw7GeyJnxFe
         0JHzHmO9ijrzUlT1nZLDOlXewoJfll99GUH6U+ixdi24jZZub8X6bobDb5GSSgF9iTya
         eydgH1F6QNYbmmhUhuvjUpzYF7nwpo6A6YqBX8LIfnjX4gou/gfzvi3zgz3vkSLxkb1V
         UvQw==
X-Gm-Message-State: AOJu0YyBQjhNA/UFNlCFm2PIuEm0vjx+tyEzlriUzZ1Q+ZIBWLnG0Egf
	75t0G+QtGCro7vVWJRAGGXTqImMZLeMHk3aVar48RhH3+lWUO/eq9ny1RyVcBVGh
X-Gm-Gg: ASbGncvQ59RpTTcLYxFcTS1ZDie91nlvwjcdcxCVNe+jd0Bs6ugiONCkM7D9MuhF47F
	88uBNXbuZ5tkMOEiuK5JP63LO3Z3RnUwwRYvcGQnwL3SBaH8x0TIfLtEUQhG1FTXWlOx7AAXYU2
	c5sd4cIthlqtt6RPzLTGZkYrtSZ7AHCJJcknkNDQuDRSXT1xegxqW+wahjS0se0QSGAJUk7goYu
	RBwSyyVFgxDhdKR7JB4bnTzozhN4KED3SY54Di6myu5pSDZr4KAFYQIIRo1KqSaGo9SntiyAaCI
	H0whR/K2Ia3httWJTu3Bm5ORx7tHY/pIXCz1aFZIH8mKSQBRf1ynZDOATPLn+lPX0XvRiXdWhhI
	qo2PoVpAJqsc2lPkyzua216FEqnJD2PPiiYpimWutPsf4ndRK9MPyQAdQZxqeOzS58gZvmna5Px
	1uO0Gy60reBNNbBEzFabLpp8SOBEHdQb0=
X-Google-Smtp-Source: AGHT+IGGweDhQPSQZjJLlDGWsDsFg/Gg9DCe2zc44qQ83+SYeSpgHx5bBRp70k6JTdEp0YI7LCW9bQ==
X-Received: by 2002:a17:902:d58d:b0:297:f3a7:9305 with SMTP id d9443c01a7336-29b5eec92e5mr17783885ad.6.1763647259385;
        Thu, 20 Nov 2025 06:00:59 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a80csm28660985ad.35.2025.11.20.06.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:00:58 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 0/2] btrfs: drop premature generation setting in btrfs_init_new_buffer()
Date: Thu, 20 Nov 2025 21:57:02 +0800
Message-ID: <20251120140030.2770-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In btrfs_init_new_buffer(), we set the buffer's generation just for the check in
btrfs_clear_buffer_dirty(). So just pass NULL to skip the check and we don't need
to set the generation before erasing the buffer.

No functional change.

See commit messages for details.

Sun YangKai (2):
  btrfs: add comment for btrfs_clear_buffer_dirty
  btrfs: drop premature generation setting in btrfs_init_new_buffer()

 fs/btrfs/extent-tree.c |  6 ++----
 fs/btrfs/extent_io.c   | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.51.2


