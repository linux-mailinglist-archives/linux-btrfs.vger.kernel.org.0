Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0C434BAA4
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 06:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhC1EVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 00:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhC1EVR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 00:21:17 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A7AC061762;
        Sat, 27 Mar 2021 21:21:17 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id u8so7117619qtq.12;
        Sat, 27 Mar 2021 21:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IUmy8TdHTWDgZfaERPbj0x2K8eavYxhsZdGg737lx4w=;
        b=q31OxssgvUpVW9DgawAOQ4GsZMRdrHuXMRePKNgQJ3VN2aaUB6UdNfqHT2QIVkwwQL
         t1ECEnDcYlAkTpMrJ/wefJBY4LqNH0CdU43f2mn4v7+GPTcA+0HjbPXEcdtBMjrLBkCK
         6+l0rWOK2D4GGQxBWFXlFOTH3pb1Z6nXwWFE2QgQCcOkSCbqWfSsvX4eLWOuDJwShF4Z
         N+6iM+9mazQQP7vSvqUuIfxyNPPRjvCMVxDNr6iPkYsFSop8S53PWdUPLLdhKUKHB1Y5
         HBIUmy6D1YvD7GUtjGt7lIhuihTxEXkJeyYVGKRBB8Cmunu66os3/o4bcGW2gXDQp8H1
         ErFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IUmy8TdHTWDgZfaERPbj0x2K8eavYxhsZdGg737lx4w=;
        b=GsIH7p/6ImEqV3/uVog/NPp0Ryoit/fTuiHu2aZs0rr/tqcY3JFvAP/+HnY/xTscp7
         P65soS/IbX/VG+zCuBGvwb2PUjekXUX+okBwEBPeTDIXg3a7Y/x5amd4E5n1eYw5rGkF
         rBxOm0W1tdGnSXU8YHERWYV9AHzoh4UscwOIj/NgIoB5YKjElZNBySjtAUWA39f4x6+z
         vRuvzVZtGnUiUdnlWPAJK3/MegN1nb/4xGtkBM939vczKTdmh/JWJMfDin3e0L2Y1N3l
         uV7Z5s2M5hSpnNeonIKmEdwsArVw3HP1K6PF/jctD5DvSj07Isi7VOIwVXaEeJDx8tt0
         IUTA==
X-Gm-Message-State: AOAM5309FRby5pai+BBcOYsSNV/e9AP+9HDxzsFBkmKQT8u2KO14CSrM
        XBCdW4W9T2V8UoAlGKOjUQA=
X-Google-Smtp-Source: ABdhPJySqiYqUreL0rBbvfR2AopSgYXVh58qX17IDRvRk9mvW7sWgcmkvIqiX97GUMP4ZhzLWhaK9g==
X-Received: by 2002:a05:622a:15d4:: with SMTP id d20mr12207970qty.85.1616905277037;
        Sat, 27 Mar 2021 21:21:17 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.118])
        by smtp.gmail.com with ESMTPSA id i6sm10092237qkf.96.2021.03.27.21.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:21:16 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] dev-replace.c: A typo fix
Date:   Sun, 28 Mar 2021 09:48:26 +0530
Message-Id: <e0d13ea5381aafd917eaad8382e79a1fbc62a45b.1616904353.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616904353.git.unixbhaskar@gmail.com>
References: <cover.1616904353.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

s/contans/contains/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/dev-replace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index d05f73530af7..d029be40ea6f 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -37,7 +37,7 @@
  * - Write duplication
  *
  *   All new writes will be written to both target and source devices, so even
- *   if replace gets canceled, sources device still contans up-to-date data.
+ *   if replace gets canceled, sources device still contains up-to-date data.
  *
  *   Location:		handle_ops_on_dev_replace() from __btrfs_map_block()
  *   Start:		btrfs_dev_replace_start()
--
2.26.2

