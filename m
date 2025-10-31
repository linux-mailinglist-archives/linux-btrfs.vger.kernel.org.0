Return-Path: <linux-btrfs+bounces-18479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78A9C26E78
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 21:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB291A26192
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 20:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5039329364;
	Fri, 31 Oct 2025 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dvQYnWoz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C873254AD
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942881; cv=none; b=bFVptaio0MZoVfjzR8lIU9Mch4HX5OtLE36t2L8UaEcdvbt0hWVgDAfAWT9/ALYXkacbHwdGKVL6BPSMq4T7TA7NE6E+MnptnJ9HfRnx8yiLQAorcCwHBTls1wQLi/SC0VmImnLQW8Tuj3Gv2Fv9KDs2bGYRdiBBsJX+LTC5T0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942881; c=relaxed/simple;
	bh=jvDE7lWJxH3JAXZ63PoEX/oK9PZRTBG5vt6245JF66Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HHizbTXk7CtIZXHEm6KYdV9EtoAx6ZK9jB9REV9j0hzJ8O40pr3zXJ72X+X7hborRhwwPNfXsuhjHU3r5U7NdSgTKenYgLvR4pGSH+laBPNXBxR5KSC81qiCzVCeHZ2Aw2k6sJXQedQf9DN9WLIAlY2luZWtCbSvFYRH6Y5jpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dvQYnWoz; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-592f2c3fd89so327955e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761942877; x=1762547677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JMKDvp/MIeXNCA/ceerlUqX0sUk5SPPyvwa4mIoYyc=;
        b=dvQYnWozKugEUNvqdhCr6mOWn03B72UNbtIqWXxtzXbQZh2FwocLAAA2fo4AQBP8nD
         gjuJ7hbba2arrHmEhlTtgj3pQKsPpu3BSnPyWnsK/iJ120VJETkxreb4co7cGyDFjZ1Q
         Romr/u0AGF19Syc7K43JIlSdWKtdIt1Ct4P5iyInbmy9uAp6cN0Z1/cei717ORVB3nVw
         DDaUMhf0SYo8HVPxmDmJPPtLOHXG4V63nGyRAWOsWj3w42NKDkkdBx63fvfLk7zXY9gU
         qtPQJcYjFgzu17DHVa4v45yxtBaGrPHVrXeKNpXiD88/aZ8e+7f8iLJHjYqmKVvQCbdk
         8keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761942877; x=1762547677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JMKDvp/MIeXNCA/ceerlUqX0sUk5SPPyvwa4mIoYyc=;
        b=PYXYA6ZSzxcSEiAQU1Qp8/HVAz8Wjre2K8z0nWZj4BjNrcWbLaX7wugYTZSpS2l2XE
         /SbZxJOywwImLGk/7ZDhmH+3iAUB6YoJ1SDu8enhT2gWNczF+56RYhFqw4XQ+eWwXcI5
         rPYQicvrDdW3LZkzUYmRkN3cfJ+GG8JpYFKEEs7iT4zLj11RHntyjVbgJKfqrz1333RS
         0X+5ZllDe9t9/I1QVoUvEm+m4M41l0r3+nZLp8tIa+/8kYtxnOszEplEuCxuhTELSDxC
         EiV0b1WyI14GKpPj8BlgU8A+ZrgXOWQO4P+XlL3UdEXeMJ1JsUFCrE2ryzV6LLbcE4ZJ
         64Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXUZDOa3Wi+OXRVVQFTi6DcC6kZxmblDZRmJSgQ5VhXbSZS0l31jds1c/dqdYVNRapFJ3Lkob+aZ4zw7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQzpHlA0u1MTEDRhKPeNQ/JO66GKeo4wbujcIBFgsvMkPYfPp
	3gDi3PSbcrWzL4XfnvUAGm1xmr/p+q/v4gqMGO+qXLp8bmloFRyKGRWgaYfIJjwP7qGSsW14nue
	ZeweAC1Rc5aaUpwRmBVDf6UILltr51zAKOUkb
X-Gm-Gg: ASbGncui63q+k57TieQ7Neo0JDUqekGZFyrsZU8w/L026QDdiUJ3HEnqsXr3yASZiJV
	/djs2F+w+KSkPH0SxDEE9T9R49Tel2euAUQtUj7wbCGf3K+/bQpsQ9zi52p2wzEESd1pOmWpEYg
	Fu3JThKXlkFpkuog+m8jMGAXTiCC+SIfy136BqEF6ivf1DkSTtitsP6QGSGmpkF5eAD130/jrST
	1+BnjNtrMo9/03dz08OEa5mUpA0rpwoFLWjWOAcJ4MI3zsqWaPTJwpHqtYdBaEyd+gd9W7dbSd+
	O3JXMks4t3n+zgXaCPsIgyyE7sCTlaX9RHK3H8c8d8nzP/fgl4W2iB8vYZ0slsONm9NlXE/E64c
	1MzFaik3OPVSdSJXz9iwv3mF+fM7duc4=
X-Google-Smtp-Source: AGHT+IHYGUnO7bV47O6a0JaarTqAfmI/2Y9l++bnlFY3ld+pOZSgy8vCnY+sYVKLt/9KYUiwgYpMC6aTC4ND
X-Received: by 2002:ac2:4c4f:0:b0:592:f7b4:e5fb with SMTP id 2adb3069b0e04-5941d4ff894mr969734e87.3.1761942876878;
        Fri, 31 Oct 2025 13:34:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5941f3a30cbsm287556e87.27.2025.10.31.13.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:34:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4EBCF3400FE;
	Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 465FEE41255; Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
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
Subject: [PATCH v4 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Fri, 31 Oct 2025 14:34:27 -0600
Message-ID: <20251031203430.3886957-1-csander@purestorage.com>
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
save 8 bytes in struct io_uring_cmd.

v4:
- Rebase on "io_uring: unify task_work cancelation checks"
- Small cleanup in io_fallback_req_func()
- Avoid intermediate variables where IO_URING_CMD_TASK_WORK_ISSUE_FLAG
  is only used once (Christoph)

v3:
- Hide io_kiocb from uring_cmd implementations
- Label the 8 reserved bytes in struct io_uring_cmd (Ming)

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (3):
  io_uring: only call io_should_terminate_tw() once for ctx
  io_uring: add wrapper type for io_req_tw_func_t arg
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  6 ++++--
 drivers/block/ublk_drv.c       | 18 ++++++++++--------
 drivers/nvme/host/ioctl.c      |  7 ++++---
 fs/btrfs/ioctl.c               |  5 +++--
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring/cmd.h   | 22 +++++++++++++---------
 include/linux/io_uring_types.h |  7 +++++--
 io_uring/futex.c               | 16 +++++++++-------
 io_uring/io_uring.c            | 26 ++++++++++++++------------
 io_uring/io_uring.h            |  4 ++--
 io_uring/msg_ring.c            |  3 ++-
 io_uring/notif.c               |  5 +++--
 io_uring/poll.c                | 11 ++++++-----
 io_uring/poll.h                |  2 +-
 io_uring/rw.c                  |  5 +++--
 io_uring/rw.h                  |  2 +-
 io_uring/timeout.c             | 18 +++++++++++-------
 io_uring/uring_cmd.c           | 17 ++---------------
 io_uring/waitid.c              |  7 ++++---
 19 files changed, 101 insertions(+), 87 deletions(-)

-- 
2.45.2


