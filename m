Return-Path: <linux-btrfs+bounces-15632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA98B0D862
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 13:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E980AAA557B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 11:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39922E3B00;
	Tue, 22 Jul 2025 11:39:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BBF219A95
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184362; cv=none; b=PTMlEOPCoh6/dUGvdu9R/LyxzouxjvuTRH+257UOobQpWwMpew5QhvE8fQLC/e1NS6P1A53pMLIcsrE7MVVqNVAukucjbMLZbsOTT+veqex098udS0aXf3OE/99d4NuUwCKdGfaPW7pGyWmzYQ0YL+AC4MBaRLQi4QEFDLwpUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184362; c=relaxed/simple;
	bh=s5fPHaRHn1/jCujn2yUSPLybtqabVuw9FV8ck/jVMW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZMYb6rYoUP0Bq8WHC4NnnB8j4zCFMpG0iUFEf0+CxmqoLfjgo/XGmqzvHqBkXzbpAdZr3xqBZzapApAKkihVjkrsTcqwynSN7eE3FnG7VnGjxMMDUpJNdFCP2MaVplstB/0JH5IK356fWJvnvpLT7YbpyOCtSWJ0Xrdmalhq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-456108bf94bso38173565e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 04:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184359; x=1753789159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+TgFY0p/H1MRjkwaDi3EVgjl6/DeZ49/9Dzt9RF1tc=;
        b=XGB76X22Bs4fk2Hu88qJ4TrwLBzzvkxriui7idZFu84pJ4UxU46ibg4S3V2PdaeDBX
         EDDyJqpN/f4QsgjmSsd+0O2NvArX4OBtL/AiVfE/cTg2l2u9TNu7nldfvkmwqtxeWSYT
         oUPwq0utZXUv/CMkLs9NefZV94gZNKfq1OaQYCc53MmxfNkZJ1yqoSxGviJJ1djElJCx
         tSVe5wx7Yhkm8SGCwrTn3MzQRzeqtcF4khy0iHeZ/pnRGNYLAee4KUzVvbGkjAQWzibc
         bZXQY0jFr99W/jC++UGWwt+YscgF5U007IxOqZlbAWoO/Z7QcYfng1UA3uhtYVI7Xoe2
         zegQ==
X-Gm-Message-State: AOJu0YxHDkAZbuScHXXrm6B2aPXTZB/NEKfe8dKAElY/hbDS7LLhJCeB
	7Mm3I286BybYkeHLYlg9rjx+i7wp25/MEBkcgjp329cFuQhL4xv1zAq+MdgrhYs6
X-Gm-Gg: ASbGncvrbuwIWbiylg2oyMezqejUdiyo9REzRsepNoZDDQVUmz/zcX8qxaguqwQaGho
	J00A9FJHrqB9Ny935nTlDxxXXo9TpcG9o4RyLpkoABXHEwBL6xoB4XRN0kY28Wa+iNPQFTdhc28
	VGqUjaHWMTdzxu7se6n9j9A6fUcXKRoJjGd5Ef2/s6fLeiYnWiCwft6W/hYIJtavlCk2hmKtrxw
	nYfNMyYPuE9wbIovtCoEnzBhQ6rFpCnnL+htD6LUm0LbTYyMFPg0jgCzUiF1/V33BGHE/qQJEKt
	Q2lUqj0bw9D/kFSFaIY/aXO8L2siqhfEIEsfpPmPBZmib9m9pQngKkP/fDG08+d32gIWKQN2/9h
	QJFL5Cfweo9p0VjQ6abhj73zp7jd0IpvgpO2tuZ00ezhb4AIQMQ4LajZJthl8f66zYaH0DJvBky
	o9A0VfMMVGk5115ve6QOXL
X-Google-Smtp-Source: AGHT+IFZ1Y1SNOZG0iCSuhZpab3WLb924sk7Ut0ivdKKZd3qsCima7rksOZjGYI3Jcst8u2Q8DBU8w==
X-Received: by 2002:a5d:5d10:0:b0:3a4:c8c1:aed8 with SMTP id ffacd0b85a97d-3b60e53eae9mr22239890f8f.39.1753184358559;
        Tue, 22 Jul 2025 04:39:18 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f71c45003fa4d1e815666221.dip0.t-ipconnect.de. [2003:f6:f71c:4500:3fa4:d1e8:1566:6221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca24224sm13278255f8f.8.2025.07.22.04.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:39:18 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/2] btrfs: zoned: two small style improvements for zone finishing
Date: Tue, 22 Jul 2025 13:39:09 +0200
Message-ID: <20250722113912.16484-1-jth@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Two small improvements for zone finish calls. The frist one changes
btrfs_zone_finish_endio_workfn() to directly call do_zone_finish(), as most of
the work done in btrfs_zone_finish_endio() is not needed in this context.

The second one adds error propagation to btrfs_zone_finish_endio() so it's
caller btrfs_finish_one_ordered() can do error handling (in case the chunk map
block group lookup failes for some reason).

Changes to v2:
- Don't ASSERT() do_zone_finish()'s return value but set FS to r/o
Link to v2:
https://lore.kernel.org/linux-btrfs/20250722093915.13214-1-jth@kernel.org

Changes to v1:
- Remove stray bg->last_eb = NULL setting
- ASSERT() do_zone_finish() returns sucessfull
- Remove stray {}
- Remove ASSERT(!block_group) after if (!block_group)

Link to v1:
https://lore.kernel.org/linux-btrfs/20250721070216.701986-1-jth@kernel.org

Johannes Thumshirn (2):
  btrfs: directly call do_zone_finish() from
    btrfs_zone_finish_endio_workfn()
  btrfs: zoned: return error from btrfs_zone_finish_endio()

 fs/btrfs/inode.c |  7 ++++---
 fs/btrfs/zoned.c | 14 ++++++++++----
 fs/btrfs/zoned.h |  9 ++++++---
 3 files changed, 20 insertions(+), 10 deletions(-)

-- 
2.50.1


