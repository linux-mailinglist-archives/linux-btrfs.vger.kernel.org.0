Return-Path: <linux-btrfs+bounces-18349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CECC0BA60
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 03:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA75218A1803
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 02:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CE32C21F6;
	Mon, 27 Oct 2025 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="M5rop7MM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12E29C321
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530592; cv=none; b=TuZtgWQRagRKLRlVlxFflw9oq0NE4fuQBtajtKolm7o18Sg76QOZki0scdepvRVpRYmoJZxClYRU5zyfFqeMBLKW3kWbU2qx7rHJG7BW+g8zjka1VdlbzyPF4j1QTElopFTqLDZ7nmb/MeRCGFL9rOY3RG4jpnO8aEd4YisPm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530592; c=relaxed/simple;
	bh=8EGXy5b1kSFodiuuzawK6wvaYbLLM08GPPPMMQ8zI7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWJhob3clh2MoHOefUXIiQWlJvvR3/er9GjmE7FILJljqqIQqhnq1jWdlKDpTXfysrZQ/uZfHb9jQL/lJhrKsPGWzqbsvaCEistpHenK9dT/afF8dxIIHJiSAujTwaW8fhMoUERsLsYfHyHNLQMQYAy58+lSA6rnvNSutpF++Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=M5rop7MM; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-b6d5f323fbcso71897166b.1
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761530587; x=1762135387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCh4WemE9mdSnciEK2Wq3FeBaRoVhjwvxKmTI6eKr9I=;
        b=M5rop7MMq5hk2TzNK10RdeSGsBICc4P8G5UR62QY+Go8EUicxYUbV7yKF0Ewknd+3C
         VMkIwFI1srO6yQ4Ecb1XkU2abPONncSeLRtmJT8NcicRp0s6TAqVFGOmmjiI80dxMLvx
         ypX5+L0JchNz6mqkvEnQFM3y7iFrzfC6kLU8lHWge50XHc/Cx/DyHlrT0SYKY/92Crtk
         vNMwJsdtLabuDa29cKqFsQ3e7mWCg9OiYqVG9SbRUMKUp0C1qda9+m1hHKoVy+v1tJmn
         qDkL3sZXTEpf+AM9krAsrF/gZSQplLkX+52qJDh/hHFmMWJrolJMYt+tgOIqGoYwJ/Wy
         n21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761530587; x=1762135387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCh4WemE9mdSnciEK2Wq3FeBaRoVhjwvxKmTI6eKr9I=;
        b=XejGHK10ICJPBZ6YBW9lP0zy03fDY8Tvx6cvH8gowNs/03uqRsK0dLzMtm6+HwwZJl
         ZIB5VcAox6WuY8HkGCWo/RO8FPY8OVceMekU+KRt5B3UpV1/NnJdBr/yyhfCUPIK3j5P
         yZIrlPBUHHvr8DhEjzMbhk4IDqrflswqcysOG6kEicAzMg/hVmu1Z56wYFAgGxOR6FoM
         rVBbbsL7Udy+LxzDa+zPp+OQyMZyZy0MhCY40J6mlHE23U+D3nq00HcpdFNhS6HoI786
         +91TbgJfiuQ75TvmoZMVqPA9gRfmAT1MppkrW4GLNF79Qy6sRsEEhRLl+6ReP0nrR1ju
         GKBA==
X-Forwarded-Encrypted: i=1; AJvYcCXG0Xyyf0Ts7wE/Xa3a4f77YLZ9uN2pF61eoONlU/9/bPnpIeBQedJ495rG7OgDp/CwrmgagN9YAk1Dmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj3pC6e9SAv7U36N9ObjYAQKiIB7xSkwMJV73joJYkj8xE7zJ2
	jOy95bhfl0z8q9nkos9KNqLkbKkvZo6REo+gyz0M/oTncfpHpoiAHurCj1KR+Z9bWb9S/Pq/ttX
	3fI/oY5g8vEewqL5ohMOF5tDiKnICou+Gy6oH
X-Gm-Gg: ASbGncs0bMYlbUr0NL51yXk19wCM62T9/Q3Jl5yHamHfMfs3Y1aWmohr7K5g+K0N+kf
	vD5F8PeshbNhsnslJFTMKJME0pWyJgSaAjQZ0YQe5OXEkiwFEZGBV2yfQVGgiKeFOqpg9pOz9BT
	E+DJYczM+DiTbn8TBDOikvXIvFxvAdE+0f2nYD8n8h3pxF55aZ8iyzx1tmh2R0N3Adfs8oUPTwM
	Zd7o63bpiwwtCX6JBl2nkEkDsGNCB4aHa7XPuGfN0IqvpitqiGAaNJz1wjUFUiNg2D9CTsufKmt
	iskQppxGkiI6uq21GlaPtAPRcIWctCOYHRrkJqjZTkTMzKA925ES2a0mDzXv+bxZlKBnI3/HC/Q
	ZMszpnmsZimyDMu2NQpNuV/RhaY8n6Yk=
X-Google-Smtp-Source: AGHT+IE4hiP03f6lofOOS2+HxUXFo5vKINW/jUKRpaO25HyrXJmcC0Z82zfs5/zGzfiuKTm+aQhmKlmbZdW6
X-Received: by 2002:a17:907:c24:b0:b38:7f08:8478 with SMTP id a640c23a62f3a-b6c72716445mr1473292866b.0.1761530586723;
        Sun, 26 Oct 2025 19:03:06 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b6d85418ef1sm55541366b.47.2025.10.26.19.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 19:03:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 46DBB3402DD;
	Sun, 26 Oct 2025 20:03:05 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3C232E46586; Sun, 26 Oct 2025 20:03:05 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/4] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Sun, 26 Oct 2025 20:02:58 -0600
Message-ID: <20251027020302.822544-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define uring_cmd implementation callback functions to have the
io_req_tw_func_t signature to avoid the additional indirect call and
save 8 bytes in struct io_uring_cmd. Additionally avoid the
io_should_terminate_tw() computation in callbacks that don't need it.

v3:
- Hide io_kiocb from uring_cmd implementations
- Label the 8 reserved bytes in struct io_uring_cmd (Ming)

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (4):
  io_uring: expose io_should_terminate_tw()
  io_uring/uring_cmd: call io_should_terminate_tw() when needed
  io_uring: add wrapper type for io_req_tw_func_t arg
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  4 +++-
 drivers/block/ublk_drv.c       | 15 +++++++++------
 drivers/nvme/host/ioctl.c      |  5 +++--
 fs/btrfs/ioctl.c               |  4 +++-
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring.h       | 14 ++++++++++++++
 include/linux/io_uring/cmd.h   | 29 +++++++++++++++++++----------
 include/linux/io_uring_types.h |  7 +++++--
 io_uring/futex.c               | 16 +++++++++-------
 io_uring/io_uring.c            | 21 ++++++++++++---------
 io_uring/io_uring.h            | 17 ++---------------
 io_uring/msg_ring.c            |  3 ++-
 io_uring/notif.c               |  5 +++--
 io_uring/poll.c                | 11 ++++++-----
 io_uring/poll.h                |  2 +-
 io_uring/rw.c                  |  5 +++--
 io_uring/rw.h                  |  2 +-
 io_uring/timeout.c             | 18 +++++++++++-------
 io_uring/uring_cmd.c           | 17 ++---------------
 io_uring/waitid.c              |  7 ++++---
 20 files changed, 116 insertions(+), 93 deletions(-)

-- 
2.45.2


