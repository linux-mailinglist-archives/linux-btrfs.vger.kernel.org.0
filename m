Return-Path: <linux-btrfs+bounces-12187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0681A5BF67
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 12:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C91E175F45
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2857254AE5;
	Tue, 11 Mar 2025 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="unUYzyFL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD75253F3B
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693321; cv=none; b=stzZ43VJSOzxgXMhzzI5dkTb5SgH8k0lxtTGUX9QNmkb6V9IdHkm4gaZOqKiDI6H8bd92H2atWQjZEy7ni0whIMYx2snrMoYgk9acSe7VsvyfJWvduOhcQjKiJZy7CydjpvQG+VCxjUl7GdDPln6Bks0uyiv4ECU1HoWlJaUii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693321; c=relaxed/simple;
	bh=K8h1Ag3DTU1iuA899SLvbmD6xwY/+vHzivqVPw6SPEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8ZEwP8lYcNGmex0n+Qs7OabUuwOsX0UWMTBZpQX+nEaDlJYGTyFemVBwCiWoJ4q7kOAgpIRqI1MxWhSYiU/Dyx8SvFmh9CabjsI+lg5nFWuK0Y58BQtH7Vh4IfQTdaqMWMTHjjm5rpvLxZyUrsrX6qwUF5asqjVUb9rOsGMpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=unUYzyFL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fea47bcb51so11210281a91.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741693319; x=1742298119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MA/dse0ICF/ii1I0pjbS4LieVE/QLWT9sr4+LkG47XY=;
        b=unUYzyFLfxsUKi65f6JV68/phAuaun5DAq4nRLNY3GBNX3VhPQIZwyL84Vp7whAP5n
         TIP433csQRbgPoelnoGfzMkjGM9YXWV6DDm4bFL3z+O/yc5aeMM9VtWE1mpY11Dkysx2
         Evc04+/GbuuZNuRxGWEAE9I71R5uLyiJiSL55/ofVfceLJWfa9p2q2tuw8hRoV7tT1QD
         hE1jL3/n2Vx0Yl1Cf7b5I/BrBvB2xjERMli8EXwnL/939fRyYY8GQAVwSDSi63XuTd7X
         LVT5wqm5aERC1V2yvvdvviJJvmigOjqj/N4xhW+tIR0FtCNgzmIj2dEZy7zd+4snJZeo
         ilQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741693319; x=1742298119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MA/dse0ICF/ii1I0pjbS4LieVE/QLWT9sr4+LkG47XY=;
        b=oY8EG3CvSIw9t+fRBwJvz0O4x1jYjavJMXNmTmVYxi7kfn+mmHd7EyVc7T/ZgBl13u
         yxgxtyMAtLCcXu4ga9ch24c+/YKw049D/lIYhAop3wM6P5l6joiQvQUJaUz5UPu+XQU6
         WmqIZYZ5Zvgzd4OFSmNDE3SLFonR7K0G8ztqa4iiOMUKlpUPKc7in6GtxrkoYdXkzs16
         Mu0nJfuh2vfJ6RYKf3MF0DspHJA/jtBvzp+wROhHX5lX7f595xYwqk3psIaJMgaCyvoS
         irBYK8/t8f2XOmGWsk0b4+UDORRhrVOvk4UCMXAwM1pEQo9g5u82WTv1YZJ7kyyEv9Tu
         hesw==
X-Forwarded-Encrypted: i=1; AJvYcCUEmD+v1SXTUPyfqIffPIr00Z9DbBSafDaNlQ8Dnm+V+0pKIkGk43Hmq4zQSttUnFcinV0sfHFW3Mi8fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6CPznsKfAB07rFgOuwqEALXWXeDMXteRKnDqsUzADOPvm7sG
	bgR2ZO8joFZzYMG2AiPGNda65S17pAOOaX4Q+8vtSfjtvTxLhhsN6pZM/uNZYOE=
X-Gm-Gg: ASbGncsa8KVMTslamAnifwboQwI5P/b6NwtF8s5pKIBMGZXpUxYmBxpfujUWufQd82X
	xlDxGX0oeH4LtdhYqv9NI9rFYGLFFPsvxHeXcNnxIjR2XQupIdhEY5XqlpfY1htPnQrHncecwmt
	RcUFc/wnAxD7a3cfprZXbRdfB8qXTllEBP9WplQV017QIoAImLz+i2uR37hNYSm9b6cdj92xeyO
	h+YxOgDSOYh5Qurzi9ssClo4mUjgDVdoSxssSOF/7xoCeV9DV+Y2nv3F9uOuK+3jsBEvjdvqYF8
	nBIjCeti9VfbAW8Lm0w4RlBgdR0YNXfnYoW3DjtY2LfoIJ+FA3Vx1onoNj33H9BGtgSYVQDGYan
	e50ci
X-Google-Smtp-Source: AGHT+IFzE9A1jtPzwbrU7Qxi5WrE/iLJ1gwUE4+oXkgzZWgtb2kVGpHneIlCN7fSLf3qIQvdqoqg9w==
X-Received: by 2002:a17:90b:3147:b0:2ff:58a4:9db5 with SMTP id 98e67ed59e1d1-2ff7cf480e9mr24563107a91.30.1741693319056;
        Tue, 11 Mar 2025 04:41:59 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff8cfsm11647817a91.37.2025.03.11.04.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 04:41:58 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 0/2] introduce io_uring_cmd_import_fixed_vec
Date: Tue, 11 Mar 2025 11:40:40 +0000
Message-ID: <20250311114053.216359-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patche series introduce io_uring_cmd_import_vec. With this function,
Multiple fixed buffer could be used in uring cmd. It's vectored version
for io_uring_cmd_import_fixed(). Also this patch series includes a usage
for new api for encoded read in btrfs by using uring cmd.

Sidong Yang (2):
  io_uring: cmd: introduce io_uring_cmd_import_fixed_vec
  btrfs: ioctl: use registered buffer for IORING_URING_CMD_FIXED

 fs/btrfs/ioctl.c             | 26 +++++++++++++++++++++-----
 include/linux/io_uring/cmd.h | 14 ++++++++++++++
 io_uring/uring_cmd.c         | 29 +++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 5 deletions(-)

---

Recently, I've found that io_import_reg_vec() was added for io-uring. I think
it could be used for io-uring cmd. I've tested for btrfs encoded read and it
works. But it seems that there is no performance improvements and I'll keep
find why.

If there is no need to use fixed buffer for btrfs, I think it's good to use
for nvme.

2.43.0


