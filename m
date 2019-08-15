Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C198EEEA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 17:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfHOPAj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 11:00:39 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:40418 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733294AbfHOPAi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 11:00:38 -0400
Received: by mail-qk1-f169.google.com with SMTP id s145so2043616qke.7
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UaEGukx9ixcd+CnM/euQFVIEtOlr9mCxCXHDd3c8xhU=;
        b=Je8ib95sn4LXGZxmFPTJt0oqPXS+GOKAo8uFTuZu56bNDObJw+NOz22faXNM5ZJUJN
         t6P+uS0l21lEjUO4bxkV2wO+UZpqVM5qNWpLQUP011QviN1Cxiorjhhkv7fmHdFwcsHg
         8aGHc8ah4Ic3ri5uaIu6iXtAfcv/uAG/LpthaOD32l6MGqBoMDXmTyBGT0tKI2WjeWcq
         yrsYNQcmbA0GxBzUoheeoZx8xZw5SFN3k1PuLEN6n1361THt1u8xHki1V+l7W8BCsfjR
         JzkOc0GQvE3Z07TqBYvVUQzxqRUnPnAk5Ds9AyEGbnvLGrg+VeBk/wM2+Xox0UwOJkz9
         1Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UaEGukx9ixcd+CnM/euQFVIEtOlr9mCxCXHDd3c8xhU=;
        b=i85RUDWJlWWziIbvdPjWfHFMmapDo/bmchV5vJypJ5s3XV3z904JEYFAdsZOJOvdEj
         d11tWMuTT/27LZE8VoDVau2y8b/KCnFMyYaUW8JrS7lLHZL+XmFudq/NO2JimHtrcyoA
         wKm5nyr8m5elNXz2Sn7bPAl8lyxfPezLuWISz1tT+V2V0FlPf6ClqSIPksqO6oLPbsSK
         910hLtKglwu6Ys2g6FVYgcG2iNwADe/6kLOB90BGsoSojgqkRivl3Lkx2YeIy7uUhXaG
         iNu68QOB/XVt/MfoEMvjgmqnZMBnjraUK2Zqxx4s3QNHO/4QJjaA81j234n0wgJ6BtgK
         XhKQ==
X-Gm-Message-State: APjAAAW+zCKSamHL4LVyWVKySJAW0vSXGbzMJdW/+p8PpYjLS4W5VaVx
        NVl26frn80D8GvLzIUGT7366mQ==
X-Google-Smtp-Source: APXvYqwJg1NkLJST9ze7M0xg5dHeeovVLA2wqlM2RjI34QkEHGvWgbBNr1tdSm0rQyOa64lPOekYRg==
X-Received: by 2002:a37:8ac3:: with SMTP id m186mr4441122qkd.476.1565881236471;
        Thu, 15 Aug 2019 08:00:36 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h2sm1497506qto.81.2019.08.15.08.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 08:00:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/2] fstests: move generic/500 -> shared/001
Date:   Thu, 15 Aug 2019 11:00:32 -0400
Message-Id: <20190815150033.15996-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815150033.15996-1-josef@toxicpanda.com>
References: <20190815150033.15996-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that generic/500 is not for all file systems, move it to shared.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/group                       | 1 -
 tests/{generic/500 => shared/001}         | 0
 tests/{generic/500.out => shared/001.out} | 0
 tests/shared/group                        | 1 +
 4 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/{generic/500 => shared/001} (100%)
 rename tests/{generic/500.out => shared/001.out} (100%)

diff --git a/tests/generic/group b/tests/generic/group
index 2e4a6f79..72241abc 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -502,7 +502,6 @@
 497 auto quick swap collapse
 498 auto quick log
 499 auto quick rw collapse zero
-500 auto thin trim
 501 auto quick clone log
 502 auto quick log
 503 auto quick dax punch collapse zero
diff --git a/tests/generic/500 b/tests/shared/001
similarity index 100%
rename from tests/generic/500
rename to tests/shared/001
diff --git a/tests/generic/500.out b/tests/shared/001.out
similarity index 100%
rename from tests/generic/500.out
rename to tests/shared/001.out
diff --git a/tests/shared/group b/tests/shared/group
index a8b926d8..c081eb93 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -3,6 +3,7 @@
 # - do not start group names with a digit
 # - comment line before each group is "new" description
 #
+001 auto thin trim
 002 auto metadata quick log
 032 mkfs auto quick
 298 auto trim
-- 
2.21.0

