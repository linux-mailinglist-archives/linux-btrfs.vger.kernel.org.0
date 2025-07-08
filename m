Return-Path: <linux-btrfs+bounces-15312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6599AFC369
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 08:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1ECF188550D
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255822370C;
	Tue,  8 Jul 2025 06:55:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D018521A447
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957714; cv=none; b=jYe1VFryDvVpHw4pQ+8689X/eH2+sDTBDvyVZUVTIp3aFLCYG1K3CxrXYZpjovyOfkvbJj1pRzehUuzHPqvZ0mweh1WxTQZESv8Tg9AMeOrsf4bm5hh0Z2UjI6hFk4YhlgfFCFt1l9GII5243qwRCN1sgKcc7lJdEuKasIJPlO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957714; c=relaxed/simple;
	bh=DTqmklTjusGMxnOmBjNjBTwzQBE4VDruqQ2uupjpmrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gXlTi2SQqrLuCTkFY2zoTDgYvzTLnhEUwuHBIIsNJQ2+xkiSTsa1QXK8B7HnwEPF/DIaJa6J4gBMzGzZFUObOPfLhTsRZ1Ddcb0g6PjSnllJR4rkRg3O5nuC5uiFijLpplZro0jBrE/oXnI4EKdS+TVfO94y+lbx90kdz9SYs1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so35725945e9.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Jul 2025 23:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751957711; x=1752562511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQP5PC8dW4A1BIgMZarrte+pFSFryYQ44JIhkai1D7w=;
        b=fvxjKuSgudpkCqiLOwHWE+k2ncQVzeItnA9dZFqIZLwIm25Iwe+0kqN4BpvtjoNMFy
         tN2/a18dok2neTPAF0p97esQNttUwfzP24ph++Il9lvszBgq7nirryPR+CLe7D5+zc11
         ZaOecFJDYbxHunIzotxPOgpokCYp557Gbb712EmvXMncXdh9SYkRPy8kDZQk9nfksBCQ
         oYWTh1YPW2SKreeiXfWYhnp86G6FoicsL68Pe0pQqHYTsE80VML9wj+J4EUvPXkYpP6b
         BEx3W9k0+DUWODQieGOR7evjiOJSzxWx54BaO8yn3XZ1Y2vYS8WbIB+XIASMvxF626Qm
         WlFg==
X-Gm-Message-State: AOJu0YwtzsLOwsiyU0jZhfKH6PVvsraqWSkvcItPt3uZ86qRi51VmAXR
	nV6MjPJZ5ziRukVUb4vj2Pye7ZcxfjCHrgcrdbOBOSJKoUuq1PjSyOlf9yrnB+2j
X-Gm-Gg: ASbGnctBBAmUYZucXbNRsyhiTTq85LbpsJUzjd3oin3/5UcTCtouu/pwGf97whN7nOP
	6CorbmPAfR32hJytH84EV6Syn4GJxpYKnfcpuyYvY23lUF4DcEwfNt6q32p6SUp/RozA35YWsz9
	QPRhNYK2Je0tphGgPaQwfh5XUJg4G5PmKQOLnsRsp6WpVVjopokIq0kz6QoMJl+I6+QRgpPQx0d
	6yqHB2UumfuRqdhePCZLWuklXcOobvAUO9l3jP2pGHCRwe2xzpevKorGzatzWbGd1ubZsn5+pAi
	YDpnXfY0kwc4TjPpFoFqaMv64hBc+COlj3Pb0CMGKrVYTc7Bx/gUXTnINX6QlHgpjBwNfOsbsi6
	/y72sJsRxUghigCxZ7C6eBnapLK6NW5ssqZklqsl6jKUfA1ai7g==
X-Google-Smtp-Source: AGHT+IEox0Obb9y6Vh2wcmUnMaDyCFkiFSoZV+0EkWUn7eZVAalxdEa+n5WGPS4eUYkKgyPQeeFq1w==
X-Received: by 2002:a05:600c:524e:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-454c64dc1d4mr67382715e9.15.1751957710787;
        Mon, 07 Jul 2025 23:55:10 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f71c45003fa4d1e815666221.dip0.t-ipconnect.de. [2003:f6:f71c:4500:3fa4:d1e8:1566:6221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d275fsm12745075e9.20.2025.07.07.23.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:55:10 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] btrfs: be less verbose on automatic bg reclaim
Date: Tue,  8 Jul 2025 08:55:01 +0200
Message-ID: <20250708065504.63525-1-jth@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

BTRFS filesystems with active automatic block-group reclaim (this
especially hits zoned file systems where automatic block-group reclaim is
used for garbage collection) do a lot of log spamming, because every
relocated block group is accompanied by three prints at info level.

The first patch removes the info message that is only present with
automatic block group reclaim, we have a tracepoint right next to it so
there's no need for the message at all.

The second patch introduces a `verbose` parameter for
`btrfs_relocate_chunk()` and `btrfs_relocate_block_group()` to control if
we want to add printks or not. Automatic reclaim calls into
`btrfs_relocate_chunk()` setting `verbose` to false while the user-space
triggered balance code path sets `verbose` to true retaining the old
behaviour. 

Johannes Thumshirn (2):
  btrfs: remove redundant auto reclaim log message
  btrfs: don't print relocation messages from auto reclaim

 fs/btrfs/block-group.c |  8 +-------
 fs/btrfs/relocation.c  | 12 ++++++++----
 fs/btrfs/relocation.h  |  3 ++-
 fs/btrfs/volumes.c     | 14 ++++++++------
 fs/btrfs/volumes.h     |  3 ++-
 5 files changed, 21 insertions(+), 19 deletions(-)

-- 
2.50.0


