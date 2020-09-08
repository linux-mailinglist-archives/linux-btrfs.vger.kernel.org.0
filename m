Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0950F2613DC
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 17:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgIHPwy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730871AbgIHPwh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Sep 2020 11:52:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E445C0612FB
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 08:42:30 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p4so15733896qkf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Sep 2020 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ub+ai6wTBMm1hsBF5QjaKfqBZmTSAb3mMkHmjBwuXV0=;
        b=CFPjJ9FamcFky9IgoxXh1bCC/p3QfhMNAxcPZFapy2d24SFFrPIdlfg2zL6Opip6Nh
         L9kHGLUWSYOVnGClfvz9HQpFjo8oxHsHxft5yp2usklyG4c5b7hcfFDV2UYo/Qp2jBdC
         U6YJnzpARPyPWATelTf/XW2rdOxkXc9EDMQEDHEfwXMBxfzj44SsY//dwAJLgZNNZK5n
         sxkL7J/ut3O0jGbgxGG++OL3mGi+3u0IxdZsSObIwbgL6IU75mCPXj+h1zx51W9u1Xmk
         y3qQ5ejfH1I0Ninga+0u6UwJw5MXMCdEVUglyQpC1AVQal0WsvpdmsWRhjfTVZayY24a
         9UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ub+ai6wTBMm1hsBF5QjaKfqBZmTSAb3mMkHmjBwuXV0=;
        b=MP6h9Y0EvZ/gi4QQs7jZ61rtpR1QfCDfXEDjzulfVQ0SUXLoW61hRmfDBv+n3lImdt
         eHnKNQAtBD5U68l2W8p2VtFx6Rb47vMiv4zex2jepYE8J3+RwC4uk6ZgIeaxv10Ophl6
         qARx51Cx7+z7Cl+23DQRwm6C5Q56bcjKUXCSqlTG2W/ub2Jw/dQuePqVQeO11iBJ0c6/
         +EowLSBneD3p6qL1P2bOWWiGFfh2yAkVv9z+cAPTczYSDjDPczdCRzaQ+oxcHqNxJcHX
         5YlVTMYTZ9ndSgcnr9/gVA4Fp4WCDc45j7i59Cb40W1/LRFGLhFHjaTF0kVZOdbx4OBq
         a8RA==
X-Gm-Message-State: AOAM533o0unfnWDwjFUXxYNOwK2aGTUdPaW0/wb3DCXt3aWvNlFcLT/v
        wi4SHG69Q1XlvLJ8UM9rZ9NPntzRwnh0Ht4n
X-Google-Smtp-Source: ABdhPJwoG3atD+Y8lF3ICXBzgXrnXoV2cZXcZOqqPtnWua1P5o93bXKPkLAZisETCBl0GFS3r1qmgw==
X-Received: by 2002:a37:9a8e:: with SMTP id c136mr611976qke.211.1599579748076;
        Tue, 08 Sep 2020 08:42:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 134sm9269637qkj.53.2020.09.08.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:42:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: add a _require_scratch_mountopt helper
Date:   Tue,  8 Sep 2020 11:42:26 -0400
Message-Id: <125326dc030857fcfa7361ca72c2e19adfdb9c2f.1599579734.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I want to add a test that requires a new mount option, so add a helper
to safely _notrun if the kernel doesn't support the new mount option.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/rc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/rc b/common/rc
index aa5a7409..431855a7 100644
--- a/common/rc
+++ b/common/rc
@@ -3281,6 +3281,19 @@ _require_norecovery()
 	_scratch_unmount
 }
 
+# notrun if we can't mount scratch with the given mount option
+_require_scratch_mountopt()
+{
+	local option=$1
+
+	_require_scratch
+	_scratch_mkfs > /dev/null 2>&1
+
+	_try_scratch_mount "-o $option" > /dev/null 2>&1 || \
+		_notrun "$SCRATCH_DEV $FSTYP does not support -o $option"
+	_scratch_unmount
+}
+
 # Does this filesystem support metadata journaling?
 # We exclude ones here that don't; otherwise we assume that it does, so the
 # test will run, fail, and motivate someone to update this test for a new
-- 
2.26.2

