Return-Path: <linux-btrfs+bounces-20639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA71D335FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 17:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B26A8300A997
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95288340DB1;
	Fri, 16 Jan 2026 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V56nInte"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD00202F65
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579381; cv=none; b=s6tH0BGioHx9awS2d2U2jtRPPQZ7vlZ32gWlBpjb0NHdjehlH8JyQ63KCFqLj6IafQwpUq3bB7e928+lqZqqsevRGoYtaRKg3qTimGpLrR5+c9A4/lc+LEauiM9y4S9Ajp07FoD/lN2wH8+K0eq87wemhgxOmejB6uC4fdUGvYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579381; c=relaxed/simple;
	bh=kpcLiQfohLKKEwCR+1DImqn0DcEFSGsC82ZNUVwc2ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABs9o6Sefv5RJ3Am5u9Tm6t8C0lhkwvN5amNtbOQzXbcuLHSVwc/Nb02/uKFEfugaLqrvvKRxag3fSPHbFPbbnnZU9KkwXmBrnaBG0Z/npjBmQ14ZShzQrnVp4X6RgDpiL4J8exlXL3tD5iqXNPFTFFC7nCVyC379W0JZ4xcdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V56nInte; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7cfd1086588so1367610a34.1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 08:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768579379; x=1769184179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0nqEVVndxyprWQvqqkhWD/cHaUoNQR8Bscbs9w/GDo=;
        b=V56nIntegNTh1bd3pSNvlKFUlbVJk3CnY8o+mzmqA/WQLoviyxAJyrRNkaRVF6+wWu
         +0VmJCXYjI6+NaSELXv1EV1CswHAIbdO5gxrXhizHutBWR86yxFK1WCo7XkAKu3n9HXD
         Q0DoAZ34ErCllIvvaq+rf8c8ONzv6prubsXNuzs1v1bFCki0brw2Whno6tXJ+8XOCkxJ
         W5pYh1cutUO4k6cSOVAr7D7C38sBM+6Hha8XQgXfOgQto9fYqAay53POWKnmx1gvhl87
         nmoDQQ3HljOPlZf+gjVnPxuCowsoSh0XVqJxmYIjgCBLfx59SeUMYHAmlw7eeH0xrKTg
         rOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768579379; x=1769184179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0nqEVVndxyprWQvqqkhWD/cHaUoNQR8Bscbs9w/GDo=;
        b=hCjufLMq4Iu3whAxa+k0CkvCdcR/S1Wa4bPTFZmoA3S6yNFQhYawIhb1JEbq1b52Ug
         lMvhSOhSN4/bPkcHLHePltFBfA8SIVsk/a/C+ILczcmuPsBsUMn1f30QpvFMwUxiQ48A
         LLF6YfiYaMaGQWWE18xDr0ydPJbXr4ZzyNRzlmeFe42JmozLkgog7686sf2/qIGP//+j
         oxNzdafAJ47JTbsGUxP9xJgpmDPKwAWDtLQOIDqSBaiSVdYtcOdhv5FLpM0A7zaeXPIV
         2IrnIDtbG3YnL2jxyRm8Yb0Dd2RkFmMFcEiqSIVD6fH2BS/k+M4ZWN4hMB2OsEnndEWu
         L06A==
X-Forwarded-Encrypted: i=1; AJvYcCUwx2Go6u3PlL0nG7MxLwXVs8MrLnSU/RTELcw71x5AM3tX8JscgJhTez8R6MPf4j7kMWX6o2TrbqjJHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3Yiaq2xYJOESa77GUPSEX66x/vapNn0eCYuPZRy9dljUl8ho
	VNmhWZPRsoswlbZiUO9PSFsYZ7Goih7s3vEGAzJHbIMUzMo8gf8YBrr1
X-Gm-Gg: AY/fxX5DzQjc/CPHW88QZt1cKJCABlX46hF4RdCiZhqZHv81ufPdAazhOYQDFcAGbvn
	lZDicWmckXBZU00UngyMcww+ApY+Hcho49lRXHJ48wZjXb10euEaUH/1EAjzrj/lTU8nmwFRUr+
	TgVNb4E/M3VMLq86amOiAsbZ4rIdD0pkx+lAPpNcA/U2R8NNB75VQghEHHd56YngUdHr+sOMtgz
	f2LwWDgaCuev741RuBUoYPEzcFPRGq63quzKVemoq1pJnruCxZt7ZqqLCmQrVMHIomS5ybkXLSc
	WiX2b4Ct6xTB5S0JyeCm+T6ZuK0ycPUY/iq4PffNnWRM9c3oqxCfgXoPWC5GBtJdNyXxspYkBaJ
	/0SzdjljfEqDjG1a+4DQBrmiwq4rbmxbF2Ov9ujTVTaLOFjpEX8/E3Lc2bCH3jpWPmSIT2CSLfv
	fDSyAMq2B8JPrv+wWJyfftX6rpRTK9XoDc35xhAfixPGk=
X-Received: by 2002:a05:6830:6d24:b0:7c7:62d0:b462 with SMTP id 46e09a7af769-7cfded4ede1mr1798204a34.6.1768579379204;
        Fri, 16 Jan 2026 08:02:59 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf28efefsm1880015a34.14.2026.01.16.08.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:02:58 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: boris@bur.io
Cc: clm@fb.com,
	dsterba@suse.com,
	jiashengjiangcool@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: remove unnecessary RCU protection in clear_incompat_bg_bits
Date: Fri, 16 Jan 2026 16:02:56 +0000
Message-Id: <20260116160256.19783-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260115224724.GB2118372@zen.localdomain>
References: <20260115224724.GB2118372@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function clear_incompat_bg_bits() currently uses
list_for_each_entry_rcu() to iterate over the fs_info->space_info list
without holding the RCU read lock.

When CONFIG_PROVE_RCU_LIST is enabled, this triggers a false positive
lockdep warning because the internal check inside the RCU iterator fails:

  WARNING: suspicious RCU usage
  -----------------------------
  fs/btrfs/block-group.c:1014 suspicious rcu_dereference_check() usage!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  1 lock held by ...:
   #0: ... (sb_internal_sem){.+.+}-{0:0}, at: start_transaction+0x...

As established in commit 728049050012 ("btrfs: kill the RCU protection
for fs_info->space_info"), the space_info list is stable (initialized
upon mount and destroyed during unmount). RCU protection is unnecessary.

Fix this by switching to the standard list_for_each_entry() iterator,
which silences the warning.

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 08b14449fabe..d2cb26f130eb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1011,7 +1011,7 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
 		struct list_head *head = &fs_info->space_info;
 		struct btrfs_space_info *sinfo;
 
-		list_for_each_entry_rcu(sinfo, head, list) {
+		list_for_each_entry(sinfo, head, list) {
 			down_read(&sinfo->groups_sem);
 			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID5]))
 				found_raid56 = true;
-- 
2.25.1


