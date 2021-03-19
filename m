Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A79342306
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 18:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhCSRKO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 13:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhCSRJr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC501C06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 10:09:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j25so6336270pfe.2
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GdErlcUum6ukHXaavX8gE9QuKb5HjH+zGzY/fvlkZ8=;
        b=f4gwOcZ5fJdQH/o5c1kDe/d+efk4huDeB1It25daYV+bJgFiJNWinLos7Nc9k3FuMi
         39gV4ZmxtAqorVTx8yywf7qhB3ubthXCD0sJmgprkZy43FI8BZx7KFM64Z8Fcfm8UMux
         SiA21olGasXPsRpxeMY3YFONUoKpTE1FLsxMjntxvPJG8bwbR+4Q25xECTb/9LLa0XAY
         j8ja7Da/FvOPV4RxwmE/bdtf5gBcUq8FI4UoGKi/97rkFobHftrBoyDVUqURrPhaV/di
         NhrlgKWtoiRM1RALs2kAx9K+xhAqu1OdVS0mV8Fu2uPBccMQXW3YRXFmvan6tzCFD9U+
         rvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GdErlcUum6ukHXaavX8gE9QuKb5HjH+zGzY/fvlkZ8=;
        b=Fs3hvkSKZ/MWotT3TSSDOP4hB58JDlh/EMZF4r6xjP42Sb3mwXzu27sJjioaMN1in0
         WyFYfIiGoTgj4XqoILaKpRstvG1oTC7LwNxOI6js3W1Sg0ufgrQduYrgqcoW1e01KF67
         XcPoryZVMB/90nY2dpWHicAIqrAuPcdRuD3g6uVtLj2DcqNQwx/0YTni2cG0psoNrw+z
         +SulOXliclkKHJcmGJFvE7AR5nuw5GQsuA/vGJwikTai9FSvjvzafmacef3zEq7CVQim
         IEFetxFLk17wPqIk95boBekwhidpPDyDzDFl8TYuIS569FQn+HilYZpblQgPQ06xY3Vv
         ZGVg==
X-Gm-Message-State: AOAM532M36GJ9WXbCGczezfMoOOMLjCIVthiMJllVJut7ahCRqYEjnkG
        94UGkIpSyfGkKjpHDGY/Nbr+af0uygacRg==
X-Google-Smtp-Source: ABdhPJzfx9v1wvtJv0SOr13oxlSYMEDZdI9y7DzvJTDYISf2UDQdc+41E7VjsDtjXyP35gnjN+E91g==
X-Received: by 2002:aa7:9910:0:b029:1f1:b41b:f95c with SMTP id z16-20020aa799100000b02901f1b41bf95cmr10027274pff.5.1616173787165;
        Fri, 19 Mar 2021 10:09:47 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id j188sm6254039pfd.64.2021.03.19.10.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:46 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: common: make sure that qgroup id is in range
Date:   Fri, 19 Mar 2021 17:09:35 +0000
Message-Id: <20210319170935.39691-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When user assign qgroup with qgroup id that is too big to exceeds
range and invade level value, and it works without any error. but
this action would be make undefined error. this code make sure that
qgroup id doesn't exceed range [0, 2^48-1]. and also checks qgroup
level that is in range [0, 2^16-1].

Signed-off-by: Sidong Yang <realwakka@gmail.com>
--
v2:
  Use btrfs_qgroup_level() for checking
v3:
  Add checks for qgroup level
---
 common/utils.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/common/utils.c b/common/utils.c
index 57e41432..69fa6096 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -708,6 +708,10 @@ u64 parse_size_from_string(const char *s)
 	return ret;
 }
 
+static bool valid_qgroup_level(u64 level) {
+	return !(level >> (sizeof(level) * 8 - BTRFS_QGROUP_LEVEL_SHIFT));
+}
+
 u64 parse_qgroupid(const char *p)
 {
 	char *s = strchr(p, '/');
@@ -727,15 +731,23 @@ u64 parse_qgroupid(const char *p)
 		id = strtoull(p, &ptr_parse_end, 10);
 		if (ptr_parse_end != ptr_src_end)
 			goto path;
+		if (btrfs_qgroup_level(id))
+			goto err;
 		return id;
 	}
 	level = strtoull(p, &ptr_parse_end, 10);
 	if (ptr_parse_end != s)
 		goto path;
 
+	if (!valid_qgroup_level(level))
+		goto err;
+
 	id = strtoull(s + 1, &ptr_parse_end, 10);
 	if (ptr_parse_end != ptr_src_end)
-		goto  path;
+		goto path;
+
+	if (btrfs_qgroup_level(id))
+		goto err;
 
 	return (level << BTRFS_QGROUP_LEVEL_SHIFT) | id;
 
-- 
2.25.1

