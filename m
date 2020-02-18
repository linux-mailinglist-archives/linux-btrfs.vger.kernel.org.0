Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9CB1162825
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 15:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBRO3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 09:29:49 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:41860 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBRO3t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 09:29:49 -0500
Received: by mail-qk1-f170.google.com with SMTP id d11so19602721qko.8
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2020 06:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9GgDl7Uv0suH+DqLJarwivXGLHfuBrz191M6D9vpRs=;
        b=zObFk4cyFJ55d1z0uf7qZPTNZaNqm0DgmV+fQwe8ZfmkVPnKJtX7zHHaR/Dpt3bieI
         t6KEQgeeOpZcNAZf46lKIvxHBwj7TIZnYw6AMHhywgQnVfey5l+LQvy/AgqE7e8kiN4t
         +XJNZRYrQuTf52CzYYBkqY7Bi6Jy2q9V0cKOuS76js1XQ7TGNKyAMRMu+WpVTJRsofA5
         WX/FA2hdP1XS6Dk7owYtmTz8fpbuThpbwXZ+BdrC+uQ5xexqaEX5a7YQ0VOfpUonIgjn
         0ph0G0fCvauUobmRc5Pfnijft8+w5G16cX1OqXJGxcOOnOOuxtWlmNctIbYfVZRzX1FI
         Ytgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9GgDl7Uv0suH+DqLJarwivXGLHfuBrz191M6D9vpRs=;
        b=Xq4hdk5O15UTkFhdlLe6UhEF7yLQRtkcr/wISmsW8tQf3f3lLQby5pOOfJckPU+fHh
         1PxMP/9ooVZqWehQiLiK77WJpgEJ4EEMCj4W30tdae2xDUxk/KzALi0sf1Yb6XUtmhr2
         0ts94xJtnJRmYo1a7OTqRq3pZcKV4RfeVgKdS4ZRNHVjR7wEtIoDqwE+xIFxE9j7cF99
         K/A9Sid7r5uHZwBfGsNLJwERhEVGub/aOI2hj8WMtPgP7XInphtxJ13me/V8cX+qJi7q
         5WVwcb7NhqaSuyJhh14jK5rKgTocl4ikHzc/0XtUpPCQ4h+CPlM49OmsGJrQ7CZ32TMT
         Fo4w==
X-Gm-Message-State: APjAAAUc0euY1l7ghjoSCJhzIGJN1GWDoPrY7y4EI7RaD/M8zQGTxjNF
        hAZSXpvUEFmTbH2uV3I/OTEnx41exQU=
X-Google-Smtp-Source: APXvYqwy+ta/ZN2mjSLOWj5WG+8g5+rx1xV+ipNkM02ksbQBpTPv9dx1tSraXx80E9bJu1LyLBmjlw==
X-Received: by 2002:a37:a5cc:: with SMTP id o195mr18989387qke.25.1582036187196;
        Tue, 18 Feb 2020 06:29:47 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l19sm1941460qkl.3.2020.02.18.06.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 06:29:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: add perf to the list of test directories
Date:   Tue, 18 Feb 2020 09:29:45 -0500
Message-Id: <20200218142945.3719579-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed that despite having PERF_CONFIGNAME set I wasn't getting the
perf/ tests run when I used -g auto.  This is because it's not included
in the list of directories to look at.  Fix this so that perf tests get
run as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index 89f3358a..9e7b6134 100755
--- a/check
+++ b/check
@@ -44,7 +44,7 @@ timestamp=${TIMESTAMP:=false}
 
 rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.*
 
-SRC_GROUPS="generic shared"
+SRC_GROUPS="generic shared perf"
 export SRC_DIR="tests"
 
 usage()
-- 
2.24.1

