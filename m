Return-Path: <linux-btrfs+bounces-10224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F207E9ECAE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 12:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F7E16A343
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B42211A0F;
	Wed, 11 Dec 2024 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx5Y/osj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27519204F8C;
	Wed, 11 Dec 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733915603; cv=none; b=RdJV5td+7SCndT/w1ZRhkF3ed9tJ89tymlh33B7akgXA0qdWglLdS9cHiZLQgFzHlp1VW9Jsv73wP6hs/bJsbYEZuTxk/XBhoehyYtDSM1KQ837zNqIws8biB25jLrqa1JJJJN7KKUBd1XcBVmkaBoTC67q25+BmhsWuvHJzGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733915603; c=relaxed/simple;
	bh=4N6LQgJh11lSxHdim/0/ul7ymwlw24sr/qAupFEyras=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cghl6L3vx61EHMxcf20lpAKBgDBsMRkwOyRQ0bGTlj8yl4Nr78OHF9FMk1Ap9mchoVDb8O4gK0MSLvL+sIp+IEfZwmIR01FiQattDJofz/SCqDnMfaYNddk0tix2Bq5liBnB7t5oBqosWrcQurYy2aHtFEi+CI/k3SJnfeEKUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bx5Y/osj; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7feffe7cdb7so1538731a12.1;
        Wed, 11 Dec 2024 03:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733915601; x=1734520401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXd2gNb8Bztuvj6W0FHn/jFR29VfNPKLfNjV2nHrTbA=;
        b=Bx5Y/osjdLpiu/3jxLFTCNHG9q4DtMjI91oVEwwdJtuThX7UPY+BOj1ePxGlSsvEmr
         eZgt0rOadfNjUYHFkH4WKaeFtayyBi0pY5kfWeB/96n+kAImU+u5HLRo5EPfQpcfRrud
         sMG2VAUjOmXZty5HluJ4Z8lBZHGQa+5GQy/cI9woMS+2FcUknG5dxfg/tVxjUjZq0iJF
         O1TkCvs+x12cTm0Z+yVqzf6UrLJWRIXkZU9dbEunppD20tk6sx1jVGU/TuqP1+jk7s8z
         9qLSeCOpzxfPo+Tytg7H+PWx7dDp/uboiXvHPJGr1vNqZaXRiBGWnA++pctmZt5sOzRu
         +Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733915601; x=1734520401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXd2gNb8Bztuvj6W0FHn/jFR29VfNPKLfNjV2nHrTbA=;
        b=inMdxS2oYjHIZ9jdZZL6tf8BK9XOD0siNEokkWjghKLyCs8ky6ocpP8PiiLw1t8esB
         8gcxgFORoPiOJqKeOf04rM865jYJ8VPpBbu3Rb+uhK5zFazPvLkQhadfQeCmCk26Xny7
         NCOa93V3KMW2cj+NwESxRwpATkxgHPmHo1lorxz1HxYHSiBIlwpeanRxg6jGN82GzBeG
         ITHiT0Hr8Pg23oJPSKHd4ea/U2ZrLbuFT3BJ+VJYJD+yglcfR54sD/1xuyn4p5U1EqIc
         RS5ZzY73q5451EvUfLmLBAVTn446Ut2ureowBC+XikiqAklyoqpVdZw6SVGw/bFbD/Gn
         TNUA==
X-Forwarded-Encrypted: i=1; AJvYcCUu871jfGi2R/VAeibj72HbmS0Avnbt+V6kT+bymPSkV65KLoZB3tRYmP8Rzkg5WTJfrQt3EkG5Mg7Xesc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5wdjzlKvk/J2TB4EcNf7eqsrf1U2BvfX76cb+EI19C2/KPzq
	/GaPfnJz+Uf5dRN/l0+rYZTinAJd0slE1bxMxJtJp2zPXEFwbzsbzs16xxcP4lU=
X-Gm-Gg: ASbGncu9YSer2u3YriPqUtPC0tdazw3T4zbGoylKUe/OEojESt3sXi6yWzYn/Y/MhG3
	fr8QKLGuVi7GV64fre3NWHTlM2rZmydeFcUacUEA3/M+DFCARdEX4lRFuczL4S1sCMBbRmVhtao
	UwjJMJMIdaah9jCWBkXAB2hEj82ecoAnEYQS06YcHMkAy62ya01SuC+zTStHYMMqfngA5Hr+skn
	9TlWsO9utMP9ytoocxr87i0orbF5wbTMS7Gv67bx0LMr6CspvjxTe69/iJ0KE9Fh42MvTWopE6D
	OJjvwjYOpaU=
X-Google-Smtp-Source: AGHT+IG27FeHFUrtkrOmSIcbneg91q7/EazeD/inFbz5h9wju4uIjqhUU2ME6CBJPyV4vqH1oEADBw==
X-Received: by 2002:a17:90b:5204:b0:2ea:61de:38f7 with SMTP id 98e67ed59e1d1-2f12802ccd0mr4128611a91.29.1733915600780;
        Wed, 11 Dec 2024 03:13:20 -0800 (PST)
Received: from localhost ([206.237.119.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef98333313sm6404297a91.13.2024.12.11.03.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:13:20 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	wqu@suse.com,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] btrfs: fix an assertion failure related to squota feature.
Date: Wed, 11 Dec 2024 19:13:15 +0800
Message-Id: <20241211111315.65007-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the config CONFIG_BTRFS_ASSERT enabled, an assertion
failure occurs regarding the simple quota feature.

[    5.596534] assertion failed: btrfs_fs_incompat(fs_info, SIMPLE_QUOTA), in fs/btrfs/qgroup.c:365
[    5.597098] ------------[ cut here ]------------
[    5.597371] kernel BUG at fs/btrfs/qgroup.c:365!
[    5.597946] CPU: 1 UID: 0 PID: 268 Comm: mount Not tainted 6.13.0-rc2-00031-gf92f4749861b #146
[    5.598450] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    5.599008] RIP: 0010:btrfs_read_qgroup_config+0x74d/0x7a0
[    5.604303]  <TASK>
[    5.605230]  ? btrfs_read_qgroup_config+0x74d/0x7a0
[    5.605538]  ? exc_invalid_op+0x56/0x70
[    5.605775]  ? btrfs_read_qgroup_config+0x74d/0x7a0
[    5.606066]  ? asm_exc_invalid_op+0x1f/0x30
[    5.606441]  ? btrfs_read_qgroup_config+0x74d/0x7a0
[    5.606741]  ? btrfs_read_qgroup_config+0x74d/0x7a0
[    5.607038]  ? try_to_wake_up+0x317/0x760
[    5.607286]  open_ctree+0xd9c/0x1710
[    5.607509]  btrfs_get_tree+0x58a/0x7e0
[    5.608002]  vfs_get_tree+0x2e/0x100
[    5.608224]  fc_mount+0x16/0x60
[    5.608420]  btrfs_get_tree+0x2f8/0x7e0
[    5.608897]  vfs_get_tree+0x2e/0x100
[    5.609121]  path_mount+0x4c8/0xbc0
[    5.609538]  __x64_sys_mount+0x10d/0x150

The issue can be easily reproduced using the following reproduer:
root@q:linux# cat repro.sh
set -e

mkfs.btrfs -f /dev/sdb > /dev/null
mount /dev/sdb /mnt/btrfs
btrfs quota enable -s /mnt/btrfs
umount /mnt/btrfs
mount /dev/sdb /mnt/btrfs

The root cause of this issue is as follows:
When simple quota is enabled, the BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA
flag is set after btrfs_commit_transaction(), whereas the
BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE flag is set before btrfs_commit_transaction(),
which led to the first flag not being flushed to disk, and the second
flag is successfully flushed. Finally causes this assertion failure
after umount && mount again.

To resolve this issue, the BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA flag
is set immediately after setting the BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE.
This ensures that both flags are flushed to disk within the same
transaction.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/btrfs/qgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a6f92836c9b1..f9b214992212 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1121,6 +1121,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
 	if (simple) {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
+		btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
 		btrfs_set_qgroup_status_enable_gen(leaf, ptr, trans->transid);
 	} else {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
@@ -1254,8 +1255,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->qgroup_lock);
 	fs_info->quota_root = quota_root;
 	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
-	if (simple)
-		btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
 	spin_unlock(&fs_info->qgroup_lock);
 
 	/* Skip rescan for simple qgroups. */
-- 
2.39.5


