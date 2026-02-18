Return-Path: <linux-btrfs+bounces-21739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEQJH+NrlWkzQwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21739-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 08:36:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DB4153B98
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 08:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84020301A90B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 07:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21CC2E11D2;
	Wed, 18 Feb 2026 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTwWSjrp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F36E38D
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771400154; cv=none; b=HXFrCnQ8ctZdkQQn/+P+W90ooN3DTUW/4JM6UXaQ/92nv9bmLT9H+Qw//ycN4VPSa77gkU0xSEerrVFYGhVQO1C+2T6ZJCOt00s5FMQjW4GcRh/NSsxmLqyJjK6wfuJ3r36ohorQi+pLQg9+4m83EB2hbUYbxySif7S5H4NhuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771400154; c=relaxed/simple;
	bh=ZqiyAarfZ9c5AIXXieSpT+WDVCKx/hTUaT4q7X2ZUf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbyUweK7+Or+te36Mp89/Ko8R4pyWquPtttk18OO67NWzff9wkkfsWswR1YPOS3Do4p9pHjk5lPCN91r2dUvGombA2+iLOrp8im2wWN1BI9veW9ER7tDpnix+3ABjUwwRDrZ/MC3BW2X4CQ4lZlvWcN+z52gv5Fl4k7fn+L5IPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTwWSjrp; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46392972257so3285961b6e.2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 23:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771400151; x=1772004951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8z/PylMAl/e6ccvGm3MpeK5HLTy0MvwuZNR7LPhbsGo=;
        b=JTwWSjrpZHUqBX1m25FsL2Tk3SeJqkZ3l0R+wZ12nUdYxFBXihP9h2qRFOCrB77pZR
         Fh4pB4WU794+I3Zk1iP7DQj44n9z1PkAxnmg2/OXn63q2hAHYnRad2Uj1Q9guVi+bDlF
         ZZeGvqlY+HmNxNyPacpEyXSmjoy54C1l8Zdf3bYO378wUj45lNwgn7dZC2h+vHKDtGBj
         HSohIs/F4igCdlmnkA4X3ECiGLpaYdu/wqyuktpwqRIwVc/XFodCLwvwhyxrT4t0s8Ka
         U1T3E0XtZ1hS8jbm+DxJnFtos7la3rX2A2YabybmhW+Yq9MSh5LbY06PNEjZdEUGrfti
         6PcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771400151; x=1772004951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z/PylMAl/e6ccvGm3MpeK5HLTy0MvwuZNR7LPhbsGo=;
        b=hqqPsH0ztI9VrZcLtpv6PEemnAvK5XZA4u48+plKOMMAEjQmrjAL97i2o/pUyLIhUc
         RFfTolXUuqlGMeigAEsmiTWuFq183eTx5/urGlONpaMiWK9plDDfWRfl3cz7UTk1HUgj
         UL1eQ7JiYAwN9Vw4rtqZBC2kfRN1LRq1cNuuJqWnvGZFJXFlHCn2g1aWIJgO5SqRKci3
         vAYtDzHPKTrCpJdjQbnt/2Eioy6OInguDZBshvhYiT6GbxdnYRrKIz7LZwL6kg1GWbF9
         lt2fGy1d5FzfpaAMtFct50aBfbBUTuDo2VSnSxcaGvJam9uTKo3uUp6eeqe4p4KVzY4k
         /bmw==
X-Gm-Message-State: AOJu0Yxs+KFQZBpIevLh1noyuDZStzPYWzaipCQyJiTCym/EwmeSiHRg
	6auakf5i9xF4HV1+cTM4i1EApqwu13i6KTAi/3Go90ZxQPzPg92oZM4LzCPJEWuU
X-Gm-Gg: AZuq6aI+pO1kZgfKqIrpht6mDtgBVl9e1nFsjxmDYifQxb5s9Wvj9nSWW/1cLeBxHlZ
	3W7SsQv/tQ65OaxKtCVl/HcGAr0BCsEYNZPM1tl+izHnDkoxXPGSu71NsyvRdJ6j9zJs0wBexe9
	CPE7GpzzL4GefNtGvJx6kp/dwdgF1OHxU4Phg6hd6I912I5CISvEHs0zk2lLTWuCbZLPneenjjd
	X2g1nonV5ElrQtoirbXnDRwOGS2BncBvK/r+cohi0eErsbF5JSr50W3qafESLh1NIPbT1cWtwQa
	ONq32QZU4T13M9k/tO+HdiN5T3lWDXbH6DrnHWrwXsL0C5M4t8zvVbFf2s96cD+CeQIZyHmH6eI
	jUZmzyVedwDLSiozr2xZJjcLLY90nC8CO+I0tGkbWL3TAQlXCXbIjkcsj3gSTsKKSXWjOC4vJKp
	tCMdJmRRy6CRUBHEbKc1FgGFSupOY58T7H3dwF
X-Received: by 2002:a05:6820:151c:b0:677:87ab:a78a with SMTP id 006d021491bc7-679a7470bddmr506323eaf.61.1771400151139;
        Tue, 17 Feb 2026 23:35:51 -0800 (PST)
Received: from gamma.attlocal.net ([2600:1700:5ae0:ae0:7bc1:6088:681:9c27])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67832657b04sm8877580eaf.16.2026.02.17.23.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 23:35:49 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Illia Bobyr <illia.bobyr@gmail.com>
Subject: [PATCH] btrfs-progs: balance: usage range filter not working
Date: Tue, 17 Feb 2026 23:33:24 -0800
Message-ID: <20260218073357.3897563-1-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21739-lists,linux-btrfs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illiabobyr@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24DB4153B98
X-Rspamd-Action: no action

When range support was added to the usage filter, a bug was
introduced, as `BTRFS_BALANCE_ARGS_USAGE` is set unconditionally, even
when `BTRFS_BALANCE_ARGS_USAGE_RANGE` is also set.

If `BTRFS_BALANCE_ARGS_USAGE` is set, `BTRFS_BALANCE_ARGS_USAGE_RANGE` is
ignored, see `fs/btrfs/volumes.c:should_balance_chunk()`.

Signed-off-by: Illia Bobyr <illia.bobyr@gmail.com>
---
 cmds/balance.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 25c5e..d6296 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -141,7 +141,6 @@ static int parse_filters(char *filters, struct btrfs_balance_args *args)
 				args->flags &= ~BTRFS_BALANCE_ARGS_USAGE_RANGE;
 				args->flags |= BTRFS_BALANCE_ARGS_USAGE;
 			}
-			args->flags |= BTRFS_BALANCE_ARGS_USAGE;
 		} else if (strcmp(this_char, "devid") == 0) {
 			if (!value || !*value) {
 				error("the devid filter requires an argument");
-- 
2.51.0


