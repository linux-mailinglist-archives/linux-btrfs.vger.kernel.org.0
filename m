Return-Path: <linux-btrfs+bounces-18224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A961C03590
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 22:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDE164E5556
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE49F28FFE7;
	Thu, 23 Oct 2025 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="c6LhWJ8Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA923E25B
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250719; cv=none; b=oQeW4gdHN1p5eAA548KdupnvH10YGxOE865WXIHhQUIANOgrRpo+nlsAUPn8ZfOSFsJwFCnSXdCmgbbDcGfs+tFdTSSuD4/4/WiNyCuXMI3OqmEUqtlPwE5632vTw7s1ccMjcnhre/C70n2STdXwR/gIZUAHKOW/EaKFABk5jUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250719; c=relaxed/simple;
	bh=MNaW/Qmo6FwgmkLQqa0PKYjlcqHuOYgu3MksfCpQ4MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agqtS4nxQuot7ElMJ5EFk/2bH8m9y/nhE6EPvtyHszYFD8nwvse7YUzTkRvfuQjj5ev8HUMhmWy8YJNQpKabInso8bTlhEPoT6HI4lEazgdmAWYavzyY2K+wd56gXAGGtJWam+3MX8DmdLqpNc42+HJbaTXpjb+kth+W2nJxVxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=c6LhWJ8Q; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-b6d4eb89facso21001366b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761250715; x=1761855515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cz0mQMPnFRMldaxGN9MCesCYr4t4w4JLIICl6X3LGRg=;
        b=c6LhWJ8Qe9UcznFArqbRWsOQ9aHKKotymYnnEk+I6HYUpGXcm+p2Q2vFNGTC1ha5UQ
         fupBDOD2xiTRww3vIabFbLCqqbt4v5O1tIiXzBjoHxwH78uwRoe922w5TxFsmPy7hvhw
         dKZay05aUFU5O2LOS6SGthy/B8PVTPXCuNAmQFHrtEFPFHYA60KQ1x+jwTvg4erbQdmC
         hA6MNEQj7V2yDyDxNMCIZtUn7mSKYaJxRLtWVeHEP2b+aneeOx3KSRXu02fIQrsGe3py
         sNoCzGq2AQxv6+xL6Z9qNoS/fNiHmu8VP2agrf3Ty5hvJah7d+C0zZas1Yjd1cNdjCSN
         qgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250715; x=1761855515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cz0mQMPnFRMldaxGN9MCesCYr4t4w4JLIICl6X3LGRg=;
        b=jIrzzMUUc7akaG7tsF6l3bmGJlTwwwe5YJePogvu7Coq/PUYiWce3DCajppISPwHbs
         BJc+md5Y/38tzXGygkWdLvCcYwe+TuLaqMeTFgb+JOI0ngEhNlwxaCkAPagMSL3Zc6eR
         2/gSv8NuWCNKCgZWIsmPQulV5kaTzqbjTjGKzK3BieBsSlKj4MzR1B7ftXA4He4pxuIY
         IHxocCcI603BcIQBWoUPWhbMkJcZ+4K10nUwAy9Qgo2Cl/r4/vBcAg8AdgUYGbrSyRqJ
         xyvgGrhaj2/rarhHnvSLPOggL0rOAz6A2WFIdk5LAAdZInfBjxCuvrzceu6TDcNKclSa
         BzsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvmcqkHlJSiXsvJ8rTjMbHIuxJMbWDG1zO31y31/j0gh4YJcdxXapA0WCrC8/XMLLjK9orF0BFPgwhXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwByCt1t1GNFhVypIoCTvdKnCWkKb2fh6XRDDX/2BBcWHh8seV+
	GD/PQfDvfvhTFDszceZIMKtm9FYOMkmbcfpY6lspR+CE/x4uAYxHnXiKK3BhunBjtGvHE5D2gog
	WtTgGeSeet9x8ejJKxrPvsaLfPJab8vB2EX/YxJzb1Z0kkUoulizm
X-Gm-Gg: ASbGncvD7P4Nv+yIE7m5SweO1o1aztBJW/7pEeLpwWIUpvmFsAPz5xmHS143UaM7aWV
	pCE17XVxTJG0CMY0WStFYE8rZe3or+sdpMoixIOOF07Jj1cT4/nxoVQ5ot0iy5dwrGo7j3YIgKP
	O3oq0MUepi4kNmeHK8zkd2Pvv7mw/WBPTVQvKqFekZ+5B8SrFWhmw2F8WxSZgrcY3V6votuc5jx
	fy9yxfLlP5zbvj2HymELXfNQo1Ypinjx15vJyu5xVTAEv4BYivAVFnPW0iID0lYL4KBidUwRKhW
	ztn53ZTcKJ0QJUCc6DAwh3O4l/2ryEyCSTstL0ok6rI3HmP+obukSNj29roMWS+bIodZlyZ9KXZ
	Ls9QKKTDqLHs4Wyul
X-Google-Smtp-Source: AGHT+IHXhL/uv6eUeaN2ZVLtqNjngQKnmQcL5o8MgXl81NLPuCh85qOP68iyVWTyOMVTjHd4V9x4RLM8fwMs
X-Received: by 2002:a17:907:9803:b0:b2d:a873:37d with SMTP id a640c23a62f3a-b6c722312e2mr832720966b.0.1761250715011;
        Thu, 23 Oct 2025 13:18:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b6d5141d9dcsm15476066b.54.2025.10.23.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:18:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9317F340384;
	Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8CBBFE41B1D; Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
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
Subject: [PATCH v2 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Thu, 23 Oct 2025 14:18:27 -0600
Message-ID: <20251023201830.3109805-1-csander@purestorage.com>
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

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (3):
  io_uring: expose io_should_terminate_tw()
  io_uring/uring_cmd: call io_should_terminate_tw() when needed
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  4 +++-
 drivers/block/ublk_drv.c       | 15 +++++++++------
 drivers/nvme/host/ioctl.c      |  5 +++--
 fs/btrfs/ioctl.c               |  4 +++-
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring.h       | 14 ++++++++++++++
 include/linux/io_uring/cmd.h   | 23 +++++++++++++----------
 include/linux/io_uring_types.h |  1 -
 io_uring/io_uring.h            | 13 -------------
 io_uring/uring_cmd.c           | 17 ++---------------
 10 files changed, 51 insertions(+), 52 deletions(-)

-- 
2.45.2


