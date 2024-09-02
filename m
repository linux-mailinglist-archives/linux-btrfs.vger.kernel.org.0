Return-Path: <linux-btrfs+bounces-7745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FB5968F03
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 23:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98DF1F2347C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 21:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30931CB52F;
	Mon,  2 Sep 2024 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I34JQPBk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3B1AB6C2;
	Mon,  2 Sep 2024 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310802; cv=none; b=KLiY2Qt+uLMCjAthPCxRXvy2dvsVN2izsi4nyzW9AR0Vs+eNPNjc32TKzEXzKHiDHtE0qFcX8cjahstcRMCR2Hdhbd/wUC5PjCXbNb/0ia7lSHQaBXGXjj5DS5BDieJksj+G1ZInYOhbjtzC2mnRGdqn5Q2WnrbMH31KVqh7CgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310802; c=relaxed/simple;
	bh=jtVPDlL69fasPswaGQl07C+4X4MgfXXfXKb8B2UMDtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocAgGfO3fsb1ELTTmMCZSDhAQcFJzd3hSD9dPjEKJ3XpRf6t2bGZqf/2usC+zjlAlft45no0+hCqrdsU6CwogV6T/18Fg/4el0sR38vTxhSE+hvfk20gAn9548SlNeADKubJbXSIWwkVB8+iOJJa82zrcpFEdpkqcd/nDIACwQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I34JQPBk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bbe809b06so26913955e9.1;
        Mon, 02 Sep 2024 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725310799; x=1725915599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KLomT+JOYe+3Bd9KrcDWYYSpigUrZ/r+BaH0p1DDjlc=;
        b=I34JQPBkSSsoaAoVEdOrIwPSTU/ryJTLluFSmSw8JNOr2CVVgAwG9uFco4rVI+EmHE
         rMapFhqu6Yd/cZHxw7m8/ZODr0uQExndDovG/5DRacJysrE0lWQW1WznwykEVmL3E2PK
         l73mCU14sUFShEdO/3F2UPgsN0ZIv92Z42/4GKpYyLB9/3wqqGnls9byqbz9GUKJzUC7
         p8aL4luLdsgbFaCIVP5NWZSgC7/WDjnwkyci60/XC9lu624eTTXheAFvLkS+nRrClkqz
         uW+vSaB4YgLq+Yr1zE6d/fDKx8z1JKmWiIEmVyzJchuZcHDH0W9k7fA7Nnetbu2Fk35d
         jgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725310799; x=1725915599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLomT+JOYe+3Bd9KrcDWYYSpigUrZ/r+BaH0p1DDjlc=;
        b=VuaTk9HudwWen2Wm7T4zs9exPGKx1a8GNy4F9S9t5uToPgFpCrGOYGCmWRcXmwVa0p
         Bigtye/T02dLlh+77NuEzcmOR35ejcAUtuvaLz/vfWS/2eq4qbwQPk5AiYqFlPIAZNjp
         R5qih5HWlcFnrCecKe+/skPTbrVOo7Uus/znan/BXec46/mufsfJbvJpYEopT+ZOLSNO
         FRvNw6e8xSY8DMl/4obc+T7u1eHcU4v8O0+zDcn8ypZdZJh5UAmLqPEdCd3zE2hS0snS
         Nf3uKj5OzbFsX2tRQ/h4bQ3+PYsQEtK49WGgeDDpPj/3fdJWvD8K4zT4PlVBhySgq4/r
         vSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV19QGHMQPho9ApsKxKrANJii93gotieWCmMeS2xxCpY3xzHZOxlA/9wyOIDfXDRN+Khyzk7oeuJyf0cWlq@vger.kernel.org, AJvYcCVWjV6618lpYfhvctxvfVQsMR6mrlF0OZQf8fr9ogN3XqqupM/xcClh1dF4sTLVVVL9g8ZwyvMZVR6YDQ==@vger.kernel.org, AJvYcCW0YJsKgqZ1/6/b2Hj+XGJ/IRNMTGD3ck4qv9yPWTK01yY9cNb7r42nzffznmn8gHLB++K8CPzsNoy/9mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSswwTTsv0eYAEhy+DOALTl2AYvUlWpGLIt+jOzPoE7OMN66EI
	rSCBWxJd23X0oXP6xhMQWd6pmjQC3EbOOZML6KZMMpQAXbay4toQ
X-Google-Smtp-Source: AGHT+IHJ9pBT9ytsk5tzNva8P095WxsjFs7tjWt4r2Bdp1wdA7GW5O8Hu0pL/1xrREBHGc1IX3+k9A==
X-Received: by 2002:a05:600c:1ca8:b0:426:6f17:531 with SMTP id 5b1f17b1804b1-42bb02edaf6mr113745395e9.13.1725310798523;
        Mon, 02 Sep 2024 13:59:58 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42c89dca8absm2913705e9.27.2024.09.02.13.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 13:59:58 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: Don't block suspend during fstrim
Date: Mon,  2 Sep 2024 22:56:09 +0200
Message-ID: <20240902205828.943155-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
* Use bio_discard_limit to calculate chunk size
* Makes use of the split chunks

v1: https://lore.kernel.org/lkml/20240902114303.922472-1-luca.stefani.ge1@gmail.com/
Original discussion: https://lore.kernel.org/lkml/20240822164908.4957-1-luca.stefani.ge1@gmail.com/

Luca Stefani (3):
  block: Export bio_discard_limit
  btrfs: Split remaining space to discard in chunks
  btrfs: Don't block system suspend during fstrim

 block/blk-lib.c        |  3 ++-
 fs/btrfs/extent-tree.c | 40 +++++++++++++++++++++++++++++++++-------
 include/linux/blkdev.h |  1 +
 3 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.46.0


