Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF71D33D4D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 14:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhCPN2F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 09:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbhCPN15 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 09:27:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC27C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 06:27:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s21so10626523pjq.1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 06:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y24lpCPKuUxxHav6y0dIpr2Q6089pBKRGgNtX2ltHPw=;
        b=JeCYrk0CmUl+rnQxheMPOakldWqoktuTilzua4DWwIo3TaNLddOtIBcSf+wYQWjY2Z
         FUiVfgYG0RmP5ophOT7KueXfPrBXG6hfhdWDD95yg3A/repHMEyUkrStn0V5Logt/Fof
         TqjE5ihWpx0DR/oGKpVlzJqjbZhzWGyASflsc5nBC6BPtDx1GT/5CoqzxaHnAdaaMgPX
         qJVvwn0psAt7XrdBCM63APggaQgxPoAbUQFacNLnc060r4YdkxNmjq0R/muz+NR1QpnE
         t8uwo5BAhcUsyYO7eqtUrxE+qp3Ss4HH230F04teybw/0H8BibULunRUD5t+YqUB2UTd
         D4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y24lpCPKuUxxHav6y0dIpr2Q6089pBKRGgNtX2ltHPw=;
        b=A7LqQey7Rpz1xfeyJY8HsQ8Ku8SBvdiZFcDGzNQeUljHJ1yUM1sVgEeCWHn061atOG
         ES9En4/V1K1FPeY1U9BuIUhMgzG74S0hZ9JmMSLjZH/bnvrEoKnPZhosjaME4It8wizE
         z3UNya/slNstlQVJ0IJhXlUjmkBaCv1aPoLqPFlP3pAWuQsxYGdJz8cg4eo+GTHtcA6B
         qJttxsp5EW4sE4nGkyAzSOD0FchsRz0TUgbHakxMRxLkPruB/5sjUlO14AsI0P0Xns+3
         aF2OxnhAVY+XDu6YtUGE8nzQrtBsw6XEL04vaPNoKq5bKdhBCbXCYYe3SRZNhNXzx6Dq
         N6Mw==
X-Gm-Message-State: AOAM532RL7ZfuuyYRBY/q5L98DBOavqldOtHsYIJgqVudxutluX/StCk
        9o4D4yy9D2s8opdCQ+LihVQy9crlFQPLyw==
X-Google-Smtp-Source: ABdhPJz81mdnlIvSznhjmLmoH6mP2Uu6Szz/QuHDzExi4YHI/BD2Z5iqBxwZ3pnli2Gw1DMytWyr+A==
X-Received: by 2002:a17:902:b908:b029:e6:3e0a:b3cc with SMTP id bf8-20020a170902b908b02900e63e0ab3ccmr17160335plb.68.1615901277013;
        Tue, 16 Mar 2021 06:27:57 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id gm9sm2961267pjb.13.2021.03.16.06.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 06:27:56 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: common: make sure that qgroup id is in range
Date:   Tue, 16 Mar 2021 13:27:46 +0000
Message-Id: <20210316132746.19979-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When user assign qgroup with qgroup id that is too big to exceeds
range and invade level value, and it works without any error. but
this action would be make undefined error. this code make sure that
qgroup id doesn't exceed range(0 ~ 2^48-1).

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
  Use btrfs_qgroup_level() for checking
---
 common/utils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/utils.c b/common/utils.c
index 57e41432..ba0bcb24 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -727,6 +727,8 @@ u64 parse_qgroupid(const char *p)
 		id = strtoull(p, &ptr_parse_end, 10);
 		if (ptr_parse_end != ptr_src_end)
 			goto path;
+		if (btrfs_qgroup_level(id))
+			goto err;
 		return id;
 	}
 	level = strtoull(p, &ptr_parse_end, 10);
@@ -734,6 +736,9 @@ u64 parse_qgroupid(const char *p)
 		goto path;
 
 	id = strtoull(s + 1, &ptr_parse_end, 10);
+	if (btrfs_qgroup_level(id))
+		goto err;
+
 	if (ptr_parse_end != ptr_src_end)
 		goto  path;
 
-- 
2.25.1

