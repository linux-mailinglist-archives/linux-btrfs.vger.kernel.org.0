Return-Path: <linux-btrfs+bounces-12329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FD2A65206
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20943B6B9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A69240611;
	Mon, 17 Mar 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="gwSr+gjo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17F223FC5A
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219876; cv=none; b=ay91Zd49NzG20Mloc2Fh/EvaXYSaZi18aH+l56y4sGpMitz/hr0fY7aS/VDQzkuYnnaU5j/msdyqLKWUW7qmn2DMU8wmEmzPWAY0a7E1WkQy0tW9bLWKfMS2wanYE3pHRKfj98weYBrIc0sErhmZ7+Z799IVJNhKlGWIQthnfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219876; c=relaxed/simple;
	bh=wGoKlRovkcSIj/T7hxHTG3NpPue/tx6XfmWqTslw2qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kt5/alCBnEtLa4FYGx2AuniYFTzoC5GAo9C9MTMgI+gTWT56W58QKYSv3M3MVeFtnzunxap+azUWKBfUUqo3D7Hys5q3Cup3M+OTijpGQmnoSJxQwPAUHh45opZTEIwOcEP8QxN+VWbEXudjIFHAUP9CL3q7QNKwDJQfyntCNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=gwSr+gjo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso3279036a91.1
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742219874; x=1742824674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Bz/g5TokYhhZnry08jrr2seVYJeiHTnX0+tpRF1Wak=;
        b=gwSr+gjoSXt+8cIttEF9oJqRHXWdjxfkQhFXg5i/MbcF2cRdaciLBpSCQjZ8SoJy/T
         1YpfaJUywVuqZZEsijol1hsS9APsXLKEJgEruSGMoJXS9Rmyka3TpxG0Ww/QAEvI7dP/
         Vj1H2Eug9scKyawaWxm9RgTl2mWU94VsrXEnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742219874; x=1742824674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Bz/g5TokYhhZnry08jrr2seVYJeiHTnX0+tpRF1Wak=;
        b=ZXBMaE53ovJQ2VQmDPCNju5ENlJILzzfRKi02FTjOslznUwsF1CmCDWkbxJVvB/3Ix
         vrdq5JN7tEsxv7Uy+r9PUw8lMFYiYRnnooJyZo/9vx0P2ap3RywVIRHPLfif134dVNae
         sZSTRK7e07ni17caHdsAvH3Qx4pd7JI/Y2Rw6LmsmWZsOTXMVKvzJ226nyHuPfHD3f/G
         0Ce/lr4jCaQt4A7i5A3dtyjn+HFTu7/4TNiBKeRLp7xQWC1Y3ELMRM9hFJWNUjjJzwZJ
         SIFNNWRaknJU0StK1t+RMrn2dJPtVr41SDihT95ca/71zYeImVohPLXK8/wRw93+BDqI
         abGw==
X-Gm-Message-State: AOJu0YxVbQYAkGlP5WX6A4ciIHiOts+I/xP22qBMK4ZHl8sdniHM/HHu
	hEau6VCeTkubaYdPOVCKNxrdvTtpdAcc8B7pdI4Ecr7TY1WL1kOJKSc9pBP+za5mMogYt4FrNaV
	7
X-Gm-Gg: ASbGncuzinpc0WMEmCnbgA/sgMz0sdNdkoOr6LMVtxdrl0Qsj4mvAxaSVwBZt13hqjA
	g+xK2RcKIKQGuQ0vU85L/h4spnKENNV3vvDuISREviits+Sio5RSrWT/kwzqTmq1sESL4I2sR57
	5MTbtL+yUin6CYb7ftQpVjBotuX5jKX3za/KSRzNu4VcFQPsOYy6Fj37gkZpGXW+EtB3cwqbmB5
	k4J3d5I48/aEN0ycDWJzI2E84wn+tUZbeYuVRV//35GCj5TQSy1/RjJrll+1XF03eS15zcc7ZhP
	K4av2EovyI0QBxCBbN0xdDum7k1FLVLJt5QR4Z+4bYZq2f22tZ3BKgjUZiCLUpe2fdq8AO45T84
	zT/Te
X-Google-Smtp-Source: AGHT+IGjeD5qKqA+5dvmm+hH7T9m3tyf3Uwy0/XL7H36bYl9iyVycjQQb3s6qqGRky9DCPwWyGrndg==
X-Received: by 2002:a17:90b:2707:b0:2ee:c918:cd60 with SMTP id 98e67ed59e1d1-30151ca0e05mr15523148a91.20.1742219874094;
        Mon, 17 Mar 2025 06:57:54 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153b99508sm5993742a91.39.2025.03.17.06.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:57:53 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v4 0/5] introduce io_uring_cmd_import_fixed_vec
Date: Mon, 17 Mar 2025 13:57:37 +0000
Message-ID: <20250317135742.4331-1-sidong.yang@furiosa.ai>
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
for new api for encoded read/write in btrfs by using uring cmd.

There was approximately 10 percent of performance improvements through benchmark.
The benchmark code is in
https://github.com/SidongYang/btrfs-encoded-io-test/blob/main/main.c

./main -l
Elapsed time: 0.598997 seconds
./main -l -f
Elapsed time: 0.540332 seconds

Additionally, There is a commit that fixed a memory bug in btrfs uring encoded
read.

v2:
 - don't export iou_vc, use bvec for btrfs
 - use io_is_compat for checking compat
 - reduce allocation/free for import fixed vec

v3:
 - add iou_vec cache in io_uring_cmd and use it
 - also encoded write fixed supported

v4:
 - add a patch that introduce io_async_cmd
 - add a patch that fixes a bug in btrfs encoded read

Sidong Yang (5):
  io_uring/cmd: introduce io_async_cmd for hide io_uring_cmd_data
  io-uring/cmd: add iou_vec field for io_uring_cmd
  io-uring/cmd: introduce io_uring_cmd_import_fixed_vec
  btrfs: ioctl: introduce btrfs_uring_import_iovec()
  btrfs: ioctl: don't free iov when -EAGAIN in uring encoded read

 fs/btrfs/ioctl.c             | 35 ++++++++++++++++-----
 include/linux/io_uring/cmd.h | 14 +++++++++
 io_uring/io_uring.c          |  4 +--
 io_uring/opdef.c             |  3 +-
 io_uring/uring_cmd.c         | 60 +++++++++++++++++++++++++++++++-----
 io_uring/uring_cmd.h         | 10 ++++++
 6 files changed, 108 insertions(+), 18 deletions(-)

-- 
2.43.0


