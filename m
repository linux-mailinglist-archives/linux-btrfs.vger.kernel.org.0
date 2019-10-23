Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45169E15B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390545AbfJWJ0l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 05:26:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45688 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390400AbfJWJ0l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 05:26:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id y24so5850526plr.12
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 02:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KLgzw07hK/6DHhFe/1ASZIooUbfDyC8qr49XVgxyUA=;
        b=QH/JqKAT/aK3Ajs1Re5O6rgc6OwbXJV+0vZnK1H5Se9Dap7FDKxPEZJeihEGrCWADT
         0Sd8CBxWOoJRG/3G1YL0ccxXbk+xYVKrtAvainPP2Qt6uQ8T3s93eLxSKJkkgyPjW94D
         j5dshMupDEWnlde1pewEKloVpZW9UZFk3YPqw48sufotjoR9Ou95Sd+V2vY14cjrC6Jy
         01QTlKRVoVW7VJfT75NuNQ08+/exwdjecRut8Gz0SoC6Dga02Yk67g26vgnLL3TCxqOW
         9Xwo3Yk/EMu7kooVFbr6yXM8XWmW19WI+H13hMY2xgIyhW9Kf0TMiYD9t0bxfk77eyXE
         qwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KLgzw07hK/6DHhFe/1ASZIooUbfDyC8qr49XVgxyUA=;
        b=QSJHoQS8VTNX5WBl58MiV2CVSSM0hHZWHcpulswT3X42Ydty1gpUdSfYm3EfJzGnKc
         kOMxvjONAbJlZMn/AT70EunVTV8OdzVsjIgCyuglerOXO/UNzz+KQ2LcKKrtyVzAiEAc
         AEGP1UC+WMmggUeymbCUaFRQLf8aANRWDg9AJqS+oG+yf76BO0k5c5+K9bGYG9EnSKne
         wfp5SgHrekNzBYhSdNqrjKPF62XkVINore4zfWKvrUoIn/DssjVzYcEXmU9Y3L/gQjoq
         iBB4WFuQRXEpHt8ykXSme8lrlW3+4IgvQQX+dNeft7gRM+upOiPOLYXHttRA9M9EcgPS
         FYTA==
X-Gm-Message-State: APjAAAVku5ybF307FI32/lbnF665/RTVjR36TAYjvi4HO+PsTdkeiczR
        1+NlhetbRgZcMMXOki7VSrh6R8FZNJY=
X-Google-Smtp-Source: APXvYqw5TYwXef1aLtrC8kzuRzVmuYJLoEVTksAp/xB17zFQkJSgXdgwKk9FBO1SgB65KLjy6TMiFA==
X-Received: by 2002:a17:902:9a88:: with SMTP id w8mr8736562plp.129.1571822800319;
        Wed, 23 Oct 2019 02:26:40 -0700 (PDT)
Received: from cat-arch.lan (240.93.92.34.bc.googleusercontent.com. [34.92.93.240])
        by smtp.gmail.com with ESMTPSA id e7sm5385074pgr.25.2019.10.23.02.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:26:39 -0700 (PDT)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Damenly_Su@gmx.com
Subject: [PATCH] btrfs-progs: mkfs-tests/005: check global prereq for dmsetup
Date:   Wed, 23 Oct 2019 17:26:34 +0800
Message-Id: <20191023092634.20310-1-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

This test uses tool dmsetup so add the global prereq.

Link: https://github.com/kdave/btrfs-progs/issues/192
Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 tests/mkfs-tests/005-long-device-name-for-ssd/test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
index b7c76b1814a5..e7a1ac45267a 100755
--- a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
+++ b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
@@ -4,6 +4,7 @@
 source "$TEST_TOP/common"
 
 check_prereq mkfs.btrfs
+check_global_prereq dmsetup
 
 setup_root_helper
 prepare_test_dev
-- 
2.23.0

