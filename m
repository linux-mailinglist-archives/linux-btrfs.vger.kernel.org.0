Return-Path: <linux-btrfs+bounces-9160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8845A9AFA67
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 08:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD041C220E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 06:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A081B4F1A;
	Fri, 25 Oct 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlDPZpKF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA918E021;
	Fri, 25 Oct 2024 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839307; cv=none; b=qZFG+pDiEqqtFjMSQtM9pk165OyXftF786JCZsDSgEHc6PKs95xIxbyn/zlSg4EPZ1EQP0R9r93R2zcJSMerzOT25kievx4K0Em4jpVMP8OSgahfcR+TdqlHGIUFsMAMuqQlE14RSr4gjZCWzOPysvfhJmZdEkbyJGOy/oqVdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839307; c=relaxed/simple;
	bh=jA3CFuA3x4L/bUzgDVaaUlLH8qbSJsDE/6ojdx0J4J8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e47LfhvDl9xdbPGLgEdQifbxcdtMbSeA/jlZs2ABOfb3YDsA2FCX5v73uORCFk7RlqxEc7fvSE6h0kUZ3TubgPZJ8WAGWN1OuEpR+SO85MA5dVp+vo8s33wz2EMdfHB03DeOzUob2hqegSRc9UUC23BpCYsm/fQSFtVWdmTI2bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlDPZpKF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e467c3996so1271010b3a.2;
        Thu, 24 Oct 2024 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729839304; x=1730444104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iIdV5iwVq20z/W20gGMQnciIsjSDIAZeUm+9d3SjQ+c=;
        b=BlDPZpKFeItYMjLFwqGE+uEDmA6P+uC42t1hizzuGDatdBm9x+zGp/7j7twQmqtYa6
         1AclIQzDCqHQISY24J+so+3q3HVyxWBRRxt6ut45S2CvVEQMIEKuX6eRjltCnake2Mih
         ++s03vH6S7ZxW1sZH16vOVU5nfH3t/G4YEDCeY/KPqpKQhvPUEhq+/bJjkN113fUHDEV
         LFTQXb/eQy9ukgJ4RHiT2Ey5FNPR0RBWn2Uf/yPvyLKekOL9852riZhD25v1xdwnUs6V
         U3qL4Sxj2t6Edl2xRMcU1Txf4QZJjeE2TR/1Zk1+wiyFVIAaJsfV+sPUQIUeVl2TKtu8
         FKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729839304; x=1730444104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIdV5iwVq20z/W20gGMQnciIsjSDIAZeUm+9d3SjQ+c=;
        b=Ln9tQAcayEIxZX8Rd06ghD+sIyo1OdzwYre5zs0lXmWA4oq3mi0fAP7Gi+id77QhzL
         mto+m2cBFrSXmqlkEfuGPXeD/f8f2/0N9F3Qc7MqykrKTmIVYNMysrTxZIn2N1PNHY0z
         jWswgK9S1rf8nkBnL6+J6T3UeaDWd/QMA6B10D9jXhphYDLbfVrqJWMD9nZgRoJtQmej
         H0eme8W6qRvXnh2wQDVEWDhCR7mrPqjQWA0ITZNiZRtZm1t1kIPh2YN3GBADOavZz8re
         rdfVntVR6C3eqhvfj5IdUSRkUw6W7ww/bUdwyzN9Y+NdiEUmtX5imd5v1C2FkZVtW4dF
         9SEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg1PuybxYDe3ypzm3h4SipBIRbsdQpFiffalTOm1cZlRs5/jRQHBynlnYhGvg4rKiTOd31f6PEY/O+Y3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHVHoQkfzh92mpvxwJiwk5vWeHZnTQYQw9pnxsHxlLybmSSfJ
	PgNajkhBkrFn6KG+TTbWVmMhmwRWVmUKd12/wZ03Ot613ORg8GpSGW/FMi7ZZU4=
X-Google-Smtp-Source: AGHT+IEwjDP9OREyvswDxuchQ/u+tFl3HeJKsDifr5n7hKxZOVL9mbGwB1ESO352UmApwxRsTLhwHQ==
X-Received: by 2002:a05:6a00:3d43:b0:71e:7a19:7d64 with SMTP id d2e1a72fcca58-72045e254c7mr5510065b3a.5.1729839303357;
        Thu, 24 Oct 2024 23:55:03 -0700 (PDT)
Received: from VM-213-92-pri.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8685729sm464011a12.37.2024.10.24.23.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:55:02 -0700 (PDT)
From: iamhswang@gmail.com
X-Google-Original-From: haisuwang@tencent.com
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	wqu@suse.com,
	boris@bur.io,
	linux-kernel@vger.kernel.org,
	iamhswang@gmail.com,
	Haisu Wang <haisuwang@tencent.com>
Subject: [PATCH v2 0/2] btrfs: fix the length of reserved qgroup to free
Date: Fri, 25 Oct 2024 14:54:39 +0800
Message-ID: <20241025065448.3231672-1-haisuwang@tencent.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haisu Wang <haisuwang@tencent.com>

This patch set fixes the inconsistent region size of qgroup data.

The first patch ("btrfs: fix the length of reserved qgroup to free")
is enough to work together with the fix of CVE-2024-46733 to port
to all effected stable release branches.
The second patch is aim to make the reserved/alloced region more clear
to ease the error handling clean up. The start mark no longer advanced
in error handling, also the cur_alloc_size can represent the ram size
and dealloc area.

I am able to run fstest generic/475 for hundred times with quota enabled,
half of the tests modified by removing sleep time. About one tenth of
the tests are enter to the error handling process due to fail to reserve
extent. Though I didin't find a proper reproducer to enter all possible
error conditions to simulate alloc/checksum failure.

[CHANGELOG]
V2:
- Clear the alloc and error handling path and keep the start unchanged
- Patch ("btrfs: fix the length of reserved qgroup to free") unchanged
  to make CVE-2024-46733 related fix as simple as possible

V1:
Adjust the length of untouch region to free.
https://lore.kernel.org/linux-btrfs/20241008064849.1814829-1-haisuwang@tencent.com/T/#u

Haisu Wang (2):
  btrfs: fix the length of reserved qgroup to free
  btrfs: simplify regions mark and keep start unchanged in err handling

 fs/btrfs/inode.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

-- 
2.43.5


