Return-Path: <linux-btrfs+bounces-15699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E5BB132E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 04:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D091757FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 02:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7D61DE2AD;
	Mon, 28 Jul 2025 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3yU8bar"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569931DB125
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753668450; cv=none; b=PectAo5rDydRz8hBcKlVDokmgHta5xwYI0hNuTx/pC2h4C8A3VfnzHGKGPuhhgbwxiBiH+jpsioToodvb/TozqAtydXueEqSkD5OG5XgluGQTflfs+CZiYJ3wE1n4N4nFAVekh79TXcj0OebMW7F9rTXt6sn6+hXm2exz88RUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753668450; c=relaxed/simple;
	bh=9kghIzkq6u3VJSK5Z1b1lMmbqF4uB86q50dPs8GtYH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NaXBLt7j7X2Y5XStHZj6TC6ClWrCw42TnvGTu3ChyjIZu0eTQ/iw4q6vFqvJheKk9ifXgtVYhS6c142DTyn1sPoJiKzDDoImKlMoIU+nuiWMFzB52RXXZLVR/2fh1nvt5ryFK3CxGAbZHYsF24P4269dCvJNCWFGJhyGPRO4yTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3yU8bar; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2403ca0313aso1901635ad.0
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Jul 2025 19:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753668448; x=1754273248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlrrqQpErghdgAEdnSIhwLH/XNGpvO5D9hEozXHXvQw=;
        b=b3yU8barArBY4HsJ0OpIXg/HONTePNYSqXUGHgcc5EwdKfDJuEU0Sbc/cHl/VoxvQd
         eI4iuEgyh+96uTGnNDNVVChkw/jJkxYEFcWyhFYDL7Kp09imbqETTCriroUZ4XHGx91e
         3bVtbT2tlb0ku+EAoD/3ljEN3FuZZytpUB1JpR7fB6l9BcN8LFO4fJY30yVMpikN0NHJ
         ntWz5Pyl2fHoq059W2ZY/YhQG7JP7zkm2XjPpJlNVdWLDRd+SqIfV350G6jbTCmllcVo
         6A0Hi58wRlxQgoi9vStYEMQbOvobVIXxYyCfTL/g+AL+pxdoVqvCLgEFu+3Y7XAn8rFF
         X2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753668448; x=1754273248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlrrqQpErghdgAEdnSIhwLH/XNGpvO5D9hEozXHXvQw=;
        b=MUiWDDk7ohYIK3lZIb55V4SS24y8MUZYzMRS8QmyhYSXmFiiAoD8x9jwxYLC9AA6vY
         qosR7NLRh5iFQ7emb3WykRtzS0KHdm86w6HAqVZk3YdAmml5kBjOnH7V6DVCHQjfObW7
         pnTGZ6H+Zj842/mraYfhPB1pL3NVLSTiOfF//+d5MIiHHgsCer3GuL2yKj/OrTco9vDR
         d7P1aJQPewe7qBPN7KGsanRqcs6dMlvnbzWdmorsw2zcQHf2cBWNttnidi1jEomLQLAB
         bZUfRiFHcHU9r/5nErSFuv9O2fjd8W1gSMPS2/dWUOH2mRxNqOwlLD29v2Y+q2oo5AN4
         ZEcg==
X-Forwarded-Encrypted: i=1; AJvYcCVHK0Ly6nPVQSWddzzUhfCCpZlx0rI0DuHGLKe/6pi57B6utW3RMUqeKaOqoOA4AT3uLFPYHxuWD+CcQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5BjeqnW3AdP0eFih7MJgvg51rmWkwDQQNWm7fk8J1NYuRJVF
	KuzQsF9GIB89fO5DARSnbwODf6cNchK26+R8rJaFooeczAAgNLG1XRfG
X-Gm-Gg: ASbGncuPwo+roETCV4MrTaDqP8f6siB+IjrXAlae7wRk34a2Daq+By+F5J5BKTDME30
	WwnA3wRSzuPKzNxDqeXZnyeDh6eb3dhSBi0u5jLc3lD2GFovd7A49lwxTr2p7SKYPEuBmNkRrOA
	bSlKGhlbaWNEoXdfrUQksXDE/59NNxnXXTyzjbM0so4cfinqHvrIiW2PcNaeytdAH/VvLgkAZWA
	2Wq16Kr/DAezCjtxtF70ftt42gF7kheDxLwB/38Ifj0AAUBo2KsrP7BdQwvO9GejpRV6nGRAKKb
	834meFgor/F69JgR6X4hJ5gxKCWxGbdfUjA7RNr7EZEOZNnlmQ5AdeV/XD2MYL1a0elNHt97abr
	v2WXgTLSeoAn9Mc3M395+arS4BLWwgYI7bRbf0Qq6u664TvJkx4ZLGxSB4qfdFw==
X-Google-Smtp-Source: AGHT+IHi03G7/CO8+aG0EHAtV4hbhNg/2bQ1eifxn4ZjLU/4D5aIBlOV4uIshfK7WJnbqv2YUEMjLg==
X-Received: by 2002:a17:902:fc47:b0:234:ed31:fca7 with SMTP id d9443c01a7336-23fb311ca96mr138147435ad.48.1753668448430;
        Sun, 27 Jul 2025 19:07:28 -0700 (PDT)
Received: from fedora (120-51-71-230.tokyo.ap.gmo-isp.jp. [120.51.71.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2403e60b76fsm1707715ad.144.2025.07.27.19.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 19:07:28 -0700 (PDT)
From: sawara04.o@gmail.com
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	brauner@kernel.org
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: restore mount option info messages during mount
Date: Mon, 28 Jul 2025 11:07:18 +0900
Message-ID: <20250728020719.37318-1-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyoji Ogasawara <sawara04.o@gmail.com>

After the fsconfig migration, mount option info messages are no longer
displayed during mount operations because btrfs_emit_options() is only
called during remount, not during initial mount.

Fix this by calling btrfs_emit_options() in btrfs_fill_super() after
open_ctree() succeeds. Additionally, prevent log duplication by ensuring
btrfs_check_options() handles validation with warn-level and err-level
messages, while btrfs_emit_options() provides info-level messages.

Fixes: eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")
Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 fs/btrfs/super.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a0c65adce1ab..de4e01abc599 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -88,6 +88,9 @@ struct btrfs_fs_context {
 	refcount_t refs;
 };
 
+static void btrfs_emit_options(struct btrfs_fs_info *info,
+			       struct btrfs_fs_context *old);
+
 enum {
 	Opt_acl,
 	Opt_clear_cache,
@@ -689,12 +692,9 @@ bool btrfs_check_options(const struct btrfs_fs_info *info,
 
 	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
 		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
-			btrfs_info(info, "disk space caching is enabled");
 			btrfs_warn(info,
 "space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2");
 		}
-		if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
-			btrfs_info(info, "using free-space-tree");
 	}
 
 	return ret;
@@ -971,6 +971,8 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
+	btrfs_emit_options(fs_info, NULL);
+
 	inode = btrfs_iget(BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
@@ -1428,7 +1430,6 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 {
 	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
 	btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
-	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
 	btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
 	btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
 	btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");
-- 
2.50.1


