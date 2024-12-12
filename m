Return-Path: <linux-btrfs+bounces-10327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D00B9EFD73
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 21:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DC028BB36
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 20:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7945E1AC891;
	Thu, 12 Dec 2024 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXxKDEp9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4D6DDDC
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035391; cv=none; b=HRN07s6s3lh8P38A2gB9DqBhH3Rw/QIjrXH4uE6JXDeAldBZgbFc0zi3BWTNcWCcMXUXM/7Yh+8zPit2jxMZ5RpVuCTIWdPkiDxYrLpmG0LuG2uiuFoSCJrKkVWx19o7uI4iODeyovNkIdx8Apxlz3GaTTH3eySVA21UClBYasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035391; c=relaxed/simple;
	bh=6kz76Zb6k5UjSW3UVltyRJB7Lv/Wc+4IF2+elmvCXmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6xCIXRwXjZlf+ruMS+bV/QgpUmvJ+pranTSYKoZMo9ke16FKstvJLVP2nfLhCz4OZk7I3h0TvFbwFM6gz2LmvNMHWqpPjjaNlVmSNjpLif/U/Tr0xwPnx2+hU/BZzTwYRhnCGQ4owYrbG7AZ/Ds5Tjb58R5uN/W6t96sJ6aNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXxKDEp9; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844e394395aso24482039f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 12:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734035389; x=1734640189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSk2A8HTRq1K+siO3SH6WLbwA6vPxcOFFqpCEVi6cuk=;
        b=cXxKDEp9YHQc0nsLAE/HklJKxijAGDXX9KQeVFsWsbeTK7RLW/dfkMpIXIMiFBcD/U
         /XEZhkrYGzTicSASEeG010EscS/vbH/4BtCvLiZ1w/pAFvdRpj5t0ZnqBlsTV9sacIbK
         U2k2DbU5EwalEyDryAU9aKUFP2JViCdmVbs9hlWSClPIGjDbr9DZnfqTNIG6LyWtF/Pi
         9AHxPxLFV9vZdX7PCANXsr81BjVkAnRCqrL2YT3imbm6DIghDZHa8yfaCeF6EsezFHZl
         xEHmx8CZmy7jbHoEO8LlXfh7vFP1DjAw2rGecLNjXDZAHVpLMfRH3Cml+kUtVbnNdI9a
         6UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035389; x=1734640189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSk2A8HTRq1K+siO3SH6WLbwA6vPxcOFFqpCEVi6cuk=;
        b=lU3LBckLkjEsOo25ENWGWhtGtz+7Vux80LtITaNkr9gC6nJ3TLAZkOurdlzMXBodKU
         CDsTQoeuImD+FSpAuCuVK7olyt/RA+52XxKkAeW5NzjEcaozy2ficARZ351zS1nhJ2Qb
         FM03Dv+1Zqrh56Tk9QKvAKo4hVdbvx8HqlJcohTbodq5xFZ5OWbQlVamHUAJxxHHvOKT
         98j0Z2mXp2dquLbZvmAT0oRCzJq0BpNNnDfzHgqsggcMe7YUk2PfGkcJxfOZAlr+rIKe
         /HsuCvZ1oxUCo6WHQDK/icNhyi6L6LmE+tTfBbPsCKtYpf3NzRoGKvmj6xkkVzutcsv+
         zj2g==
X-Gm-Message-State: AOJu0Yw58gwRjrtiFylQnzJovomDSx1EKO7E2HOjRn1Xcf6nZ+OTi9KH
	MMp07zefercl8QugP/iuYdM+ddEnFIDAatQBBLkIBEdVua0fjOdo
X-Gm-Gg: ASbGncuMbZD6hiaQsinlgNOkx2VsV/hYWhMklDcD2ARGgo51EVMa2ZRjpnFkobkgomv
	/hVaBMxANc/wKVWmLS9J1szs1BuInybdHq6tkJ5xcqMylO8KI+qMocVdJH5Im1kyQcSw2IaqCqp
	XRZGcPiRL20Jf31FizjWbPDX/GJj7JpLjZcgDebK+fSJSPxkyA4PwfroTyT3SY2+uNwdFbdHSYN
	6vano24hlnydRjcLz9w5wbPr4gDnMZ4j1ctEm3gLJMf2VbwSB1Qr5I2W4J/cYcOBw==
X-Google-Smtp-Source: AGHT+IFXUBQFvf2ZT0XxOKcqG7fdqvzxOLmFn4yO6frmitNLMzWVpzLWlKVk8ZEWMplGxJTQyhIo5Q==
X-Received: by 2002:a05:6602:6416:b0:841:a678:de3f with SMTP id ca18e2360f4ac-844e8698247mr38097539f.0.1734035389332;
        Thu, 12 Dec 2024 12:29:49 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844e29b6103sm28642939f.29.2024.12.12.12.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:29:48 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: beckerlee3@gmail.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] reduce boilerplate code within btrfs
Date: Thu, 12 Dec 2024 14:29:36 -0600
Message-ID: <cover.1734033142.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733695544.git.beckerlee3@gmail.com>
References: <cover.1733695544.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this patch series is to reduce boilerplate code
within btrfs. To accomplish this rb_find_add_cached() was added
to linux/include/rbtree.h. Any replaceable functions were then 
replaced within btrfs.

Roger L. Beckermeyer III (6):
  rbtree: add rb_find_add_cached() to rbtree.h
  btrfs: update btrfs_add_block_group_cache() to use rb helpers
  btrfs: update prelim_ref_insert() to use rb helpers
  btrfs: update __btrfs_add_delayed_item() to use rb helpers
  btrfs: update btrfs_add_chunk_map() to use rb helpers
  btrfs: update tree_insert() to use rb helpers

 fs/btrfs/backref.c       | 71 ++++++++++++++++++++--------------------
 fs/btrfs/block-group.c   | 40 ++++++++++------------
 fs/btrfs/delayed-inode.c | 40 +++++++++-------------
 fs/btrfs/delayed-ref.c   | 39 +++++++++-------------
 fs/btrfs/volumes.c       | 39 ++++++++++------------
 include/linux/rbtree.h   | 37 +++++++++++++++++++++
 6 files changed, 140 insertions(+), 126 deletions(-)

-- 
2.45.2


