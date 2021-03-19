Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386D3342313
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 18:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCSRQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 13:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhCSRQI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 13:16:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D396CC06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 10:16:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x126so6355113pfc.13
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3VZyWO6Wh011TilkTY1fuFpT8cH8cfCNeaFx+CdWW2g=;
        b=tNCovXfuxLpnTpwaJw7FTziusSYENBT3+NH3S6+G0dB1ZsSgcjv7HnPtORCF7kpcE+
         cqKk55K0C/fOwZp8JmvAoHmqODzOUSbrch4W6FQeyzmbntT9G4xTFOe4N1+fk+u3n84u
         iD8cKjxNxXbKmJUwwdEFQ1ylUa64XwPk0zd6yz5edQaPwY1si8/xkEXgfUrqNEl8HPKE
         psghQorv9IsN37xZXKkQOheU+g4HKIY9Uh3P5HyMl9h2a6Z/f+0WM6ezrTjxgFjH6fP0
         NlgxWARyeOVPhVURcd7IVsNpzHdHarx3CvRO5LNHD/F+d0c6yc469aLhsUkSjS+08kFQ
         oMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3VZyWO6Wh011TilkTY1fuFpT8cH8cfCNeaFx+CdWW2g=;
        b=Af+NzQgvGlilDFqEBbBQxr1js3yHeohZJODIXRxnWIeaPY6A2pPRJoNOwhQ09RjK+r
         lHVmDVpRtjnzkQwxi3UW+2AN3Nds+s4sSb8c+kTCQSWX/WJIXrxpyN+VBnagyRhT7DKX
         C9OMaeG38iqhKI36ZvIcPVDpQx+3pAQLKpQhpQVlzdFniHjINu2sCEnm3G9uCfX3HRjs
         4Tny6Ls/zKc50WFE3V0Tibg+P/JggG9DnrA78RAhclKrWeieK79AvCiFgNhZWcz9+fq5
         6Eul5agCxGDB058fGQEsyLkgEAx5b72qU50IwAXSU8kKVa7mgrgZwElb5Apvc9kbTc7J
         JdkQ==
X-Gm-Message-State: AOAM533m9wEo8nPsX9gAXbL5VUfRBbKQ5qD5zS+vQBIn9gcdpEgTL+3P
        bovKmaF+EfzECnBhMgOxWBj7Jlv7iTdH1w==
X-Google-Smtp-Source: ABdhPJxjwWF2J6ls3apdG52j9pM/J+EZabKXqaxz338+JtfHyIPkhGopsb1bktkWqcuNBTqETBaxkA==
X-Received: by 2002:a63:141a:: with SMTP id u26mr12677121pgl.398.1616174167099;
        Fri, 19 Mar 2021 10:16:07 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id bj15sm5902460pjb.9.2021.03.19.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:16:06 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v3] btrfs-progs: common: make sure that qgroup id is in range
Date:   Fri, 19 Mar 2021 17:15:58 +0000
Message-Id: <20210319171558.1154-1-realwakka@gmail.com>
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
---
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

