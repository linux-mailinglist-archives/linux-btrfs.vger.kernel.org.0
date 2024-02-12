Return-Path: <linux-btrfs+bounces-2309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 956E1850CBC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 02:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13F51C22803
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 01:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B501841;
	Mon, 12 Feb 2024 01:35:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3AC10E5
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707701719; cv=none; b=b30rUB0RWbsSuw1hrU7G8Fi13KGqikSxqnjBfqh1FEQgNyTAv1d2tbA2S/T6sCbVQ+tN54wH74yjL4ot4hccHp18jK9l3NsVjlQA0y6CZ9fisKVNXhJTGytMprBw5gcmfPsqDX926pHBzedZEULb6YpoEKnEjX1sPkVEYK3caB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707701719; c=relaxed/simple;
	bh=vLov/lwy3plTsfy9GLWCezeRrF5YZdGCLLA89+llgJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aafjeaui1B96/8IyHjwPDmrQJGKMcdX/gMGRdxQQldyXGaMa+d9aNTom0z7XGxz/tO+n4bEeguoPR1yNUyWxA9hiEW0fkpV1FolMKpUUQRT2wx8tVvSsEeD95aCFsVDC4qMOMrJ46ZKL0sf3Lmz+fj6VJ7J9Y/yPyTM9m5Z8bgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68ca3ab3358so14599756d6.2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Feb 2024 17:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707701716; x=1708306516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4lCnr524+Z2awrdo3+gjkRrCRzSgWMcD2ocX3HLWag=;
        b=E+Mh2AOV9D3B/mAAsVf1RZ+P3nNmcAhe/O38ZZrEpyfWra2YBQdw48+GJ/sDLpODLj
         KUqYOAq3ipAlQGeKaE3JU0NatK61vf8nUXQLk/0tIiZvd5QnPJlGou03P78SBE3Ns6qM
         QH89BGgTVJZIr1fjSW8ORLDSIwHY9/rg5waaQ3FV2PJ8DSuYeB9/54ae/cO9VXD9J62Z
         VE50393WyhvSwkFHRuVONHQ9DLkwRU08Ft0C3BSi+6Z6r+KFBWlquKG+wjLlwICRGpAO
         MKKeVtdALUSuplp55NrSRn1JIpyrZEJ41ihiRqxVOitQgkx4kDXo4nytC3b8GYzpDlMN
         aStg==
X-Gm-Message-State: AOJu0YzuveoySB6D4a5zpGPlJWjGmdpBbqbdUX7u5GQwQ+nUO8Lg2G8I
	ncPyzip98beUGnQ9ko2dW2LIFkWzjwaD43jTxJ/SzvgTlJypEzj71V5mDR3Igd8=
X-Google-Smtp-Source: AGHT+IFxn3rWnB3i7MzNF6Y1kJIPn07tgcIWhvobDN19+gx1zz/N8kvgsydY0RKQcktSVY0tZVoMkQ==
X-Received: by 2002:a0c:e345:0:b0:68c:e740:5f61 with SMTP id a5-20020a0ce345000000b0068ce7405f61mr5043412qvm.57.1707701715709;
        Sun, 11 Feb 2024 17:35:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX50SqYUUcqUv+CwoiLz8Rc1E5Pk3VUMyjMDNdKSdjXmDCBLTXareqo3CXVUMYg+W11Ta24Yv8BAR8iqPl2bZQqpVFQKHVJ/rJkiU2xaAOCweg/08S4QsXIqBSD5gpK22g8WJDOBkmUPsoTnL4A7d8=
Received: from Belldandy-Slimbook.infra.opensuse.org ([32.220.181.243])
        by smtp.gmail.com with ESMTPSA id nz9-20020a0562143a8900b0068189a17598sm3176984qvb.72.2024.02.11.17.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 17:35:15 -0800 (PST)
From: Neal Gompa <neal@gompa.dev>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Davide Cavalca <davide@cavalca.name>,
	Neal Gompa <neal@gompa.dev>
Subject: [PATCH] btrfs: sysfs: Drop unnecessary double logical negation in acl_show()
Date: Sun, 11 Feb 2024 20:34:44 -0500
Message-ID: <20240212013449.1933655-1-neal@gompa.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IS_ENABLED() macro already guarantees the result will be a
suitable boolean return value ("1" for enabled, and "0" for disabled).

Thus, it seems that the "!!" used right before is unnecessary, since
it is a double negation.

Dropping it should not result in any functional changes.

Signed-off-by: Neal Gompa <neal@gompa.dev>
---
 fs/btrfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e6b51fb..c07a9f7 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -421,7 +421,7 @@ BTRFS_ATTR(static_feature, supported_sectorsizes,
 
 static ssize_t acl_show(struct kobject *kobj, struct kobj_attribute *a, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", !!IS_ENABLED(CONFIG_BTRFS_FS_POSIX_ACL));
+	return sysfs_emit(buf, "%d\n", IS_ENABLED(CONFIG_BTRFS_FS_POSIX_ACL));
 }
 BTRFS_ATTR(static_feature, acl, acl_show);
 
-- 
2.43.0


