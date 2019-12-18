Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24421123C4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 02:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfLRBRO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 20:17:14 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:34633 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfLRBRO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 20:17:14 -0500
Received: by mail-wm1-f48.google.com with SMTP id f4so3451419wmj.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 17:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MhtSujQSJZgMPHVatBk3J2mQn0+E9z/9uvsb3DpULyE=;
        b=fI/tnuXIb/muGOebbyDnhqC6AT1K0PBEAnNNIzfyGfwI1nnp9pBVPLTzXAIoFg2xg/
         gKlV6F62p3qihXUbnl8aSwwpJUE1P8EA3cXbMm1equvr8Z7NXjH0Q/+Y1eEamFa4ixgO
         OvM7xbHNP/Mf6UyLsNQ1w7FVxiZnHKJbVGKik9fZebofvd8WBqFRnRvMjQWzyUfh3uIQ
         FB8qgpAZkz2eUytZk7SY6ndE20YfI97iRaapLtuSPbQDwTBLP7/dW19Thrl21IjYhw0e
         uHqc9LqHkA0fX4UI88/pnTlysEAPaadrIQPOuB7+hgRg+5m0dSBNhbePidCLHAPJQ58/
         cmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MhtSujQSJZgMPHVatBk3J2mQn0+E9z/9uvsb3DpULyE=;
        b=o3I/wX0ek1dnRbGnoOt4KiEZXkZU/kAX0+AaL+sCGotEIIalPLEq3HsU+aksWKhZyk
         N+xPuUd+L+4XZCnUgZEEZFKfvNd7quZIYKHyy52pKntWUqaG8wLEK4vd9/Rywwf9RAC6
         6ieEco9ckTY8Ys3l75daKDFqkG1ubdN0Arg24Rn1NZZNjG8h2zjF/CpMnAs/AF691FMH
         eSClk414IHQZVV9OJPCgAgKdVbwXPRb42KtJUUEoS30B3QYwUhmIvqG5LBVXlSBV8jEk
         4u5rlqRch92RqjKFwU9fV13wKpu6SmeMRavyDYD2cAtb9p51EUtm3Xqx+9JOBBjiR8nc
         ptmw==
X-Gm-Message-State: APjAAAWfNodoPfTVLEJPatMvpO0uMfX+m7Zk1e+kOQ9oZ0MA4Fgl8dEd
        ops281e4IzUZTSCkk1hO0cvKW3GZ
X-Google-Smtp-Source: APXvYqyLJR4fEbVyJY2U+LZTltH3uZmrH1f3hHKK0RFvXRRWGDaENsR8l83VKmVl71MLyGmFnynmeg==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr69683wma.134.1576631832163;
        Tue, 17 Dec 2019 17:17:12 -0800 (PST)
Received: from hephaestus.suse.de ([179.185.209.78])
        by smtp.gmail.com with ESMTPSA id g25sm4782854wmh.3.2019.12.17.17.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 17:17:10 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: [btrfs-progs PATCHv2 2/4] tests: mkfs: 017: Use check_dm_target_support helper
Date:   Tue, 17 Dec 2019 22:19:23 -0300
Message-Id: <20191218011925.19428-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191218011925.19428-1-marcos.souza.org@gmail.com>
References: <20191218011925.19428-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

If dm-thin or dm-linear are not supported, let's skip the test altogether
instead of throwing an error.

Issue: #192

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 .../017-small-backing-size-thin-provision-device/test.sh         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/mkfs-tests/017-small-backing-size-thin-provision-device/test.sh b/tests/mkfs-tests/017-small-backing-size-thin-provision-device/test.sh
index 32640ce5..91851945 100755
--- a/tests/mkfs-tests/017-small-backing-size-thin-provision-device/test.sh
+++ b/tests/mkfs-tests/017-small-backing-size-thin-provision-device/test.sh
@@ -7,6 +7,7 @@ source "$TEST_TOP/common"
 check_prereq mkfs.btrfs
 check_global_prereq udevadm
 check_global_prereq dmsetup
+check_dm_target_support linear thin
 
 setup_root_helper
 prepare_test_dev
-- 
2.23.0

