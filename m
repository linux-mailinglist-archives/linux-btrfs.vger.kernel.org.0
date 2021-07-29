Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919F33DADA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 22:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhG2Uc2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 16:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhG2Uc1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 16:32:27 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA04C061765
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 13:32:22 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c18so7298426qke.2
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 13:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ArEg3wJQ2YWHtg3x+wWhG47C5LGq2xFDaJ6mvWtADyc=;
        b=UIQyLDPDk1pikacmIcGUHAf1LDS290OCduL5o8uBcXYrykM3c55hQl77OclYmjHXzS
         HV8m65RZIJs5jaCxSO3zrkTJC4btuCawroBd2HuMwcViNDH2OPSynnMXSemxIe9210bQ
         r6r5ZUa89Ror1+WWAkJH4X2PqIVI9wqVKh37nsftvfwT/IuhiVYVm1CL9elTXwH3I+Mk
         tByGCjLZrIAMay2k8MjNhqLbCOvH+p3Vq/nLsrqtlZpaQTuOR3wl/oE6pzUX6fKXbJSE
         OFKMnPz9oz06iGK3NGzRS27pXtMx3mqaA3dMg+vsgMSBpBJdP5/0tL2pTr+Af/tySiEj
         +gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ArEg3wJQ2YWHtg3x+wWhG47C5LGq2xFDaJ6mvWtADyc=;
        b=ZyOtio1dCFl0XQJMdH5Ne2x/0HcM3NjkFMNRqLVcAV5+fLRuMWO5tLOjjjpSltqMXe
         Qp9YTQ7O4o6uooPc8xCogEGOTbG0+RpxHCfO7kehUr5SCgVTH65AR/9wDvm6D35g0Ppz
         4lN5CM5eG7kf52yn5HvZcJib8H7ACmlA0B0s7NcEZJh+yA1jioMhyTzVzQtwk1dUZCtY
         /E0T+QrmDo0gUc84Zb9X8MiWcnqZNi+hlZwtSW+Zcw54LHhzp++xuW48X51N7fWBeMh3
         PsGfyiQkpkfuZzN7FRfwnH02b1xkjQbn7tmLEm7Sjby8TlkmtA6ms/ZYZCEIo4SZCttr
         GrZg==
X-Gm-Message-State: AOAM533//zOzxvBPzu8JCxwikOE15iIiwXBdxmgkFdz9QZpTA1WqlEVb
        SeqwwR3DhY46FPXJ1qjszYAntw==
X-Google-Smtp-Source: ABdhPJwc0eU8F64LAtZFo0M4lUJtfo7eQCcIW/Wf2PQzqFfNfXCuRwMUNJgUKB74oDCMI3UTydsoCw==
X-Received: by 2002:ae9:f006:: with SMTP id l6mr6885862qkg.420.1627590741665;
        Thu, 29 Jul 2021 13:32:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i123sm2361117qkf.60.2021.07.29.13.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 13:32:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: remove results .dmesg on each run
Date:   Thu, 29 Jul 2021 16:32:20 -0400
Message-Id: <d6f40b516a57f9f899e67fad39088e0ddbe087db.1627590729.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I recently added dmesg files to my nightly fstests summary page and
noticed I was getting .dmesg files from runs that happened previously.
This is because we don't remove the .dmesg file in the results directory
when we go to run the test, so fstests results would show a test having
failed with dmesg errors when it actually hadn't failed.  Fix this by
removing the .dmesg file when we are going to run a test.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check | 1 +
 1 file changed, 1 insertion(+)

diff --git a/check b/check
index bb7e030c..2021cb21 100755
--- a/check
+++ b/check
@@ -809,6 +809,7 @@ function run_section()
 
 		# really going to try and run this one
 		rm -f $seqres.out.bad
+		rm -f $seqres.dmesg
 
 		# check if we really should run it
 		_expunge_test $seqnum
-- 
2.26.3

