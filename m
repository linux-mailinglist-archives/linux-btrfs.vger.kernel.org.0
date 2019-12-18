Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A36123C4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 02:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLRBRK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 20:17:10 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:37334 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfLRBRK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 20:17:10 -0500
Received: by mail-wr1-f54.google.com with SMTP id w15so476968wru.4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 17:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ts3V2uNcT1HJ2RW3X7jt8z5wk8tgT+l/aX5KrUrZeGI=;
        b=YlGMzu5cm3Zbpphg2u7VZ3dRDnu/8OYnhygC4WmqjhBEFXJw7ijRA2FRSb0IrPiagX
         yhU0T7spmYKzX/bcetkVZPrwYbhghaWYo96/4aIn23bzCPcBf0995X7M1oWUmB6A8Irh
         8H0K1LJ5718UWGmHKJ1x3kYtu+YS+k+DXjCT2MagO8EUoiFadvSDvj9Cc5Rd/5hE0KrG
         z+v9S85OIriZfmvAvkAPSxG+QL0c509BwdGWZyyRz/3O1IC8vtcc2dvwSA66LL6SDrIZ
         fC2yCJLJjsSt1tyw/N3rSirfjprM0dEZxFxGIwNLjz6EBK/kaxgKh9f6Ya5LcdiU4Owl
         7FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ts3V2uNcT1HJ2RW3X7jt8z5wk8tgT+l/aX5KrUrZeGI=;
        b=alCBW2h0m5EKm35/wtLBide7f4g8Qan+Mwz9zYCh120zfdBsbHF/M7HSqGbhJSEDPk
         rpRJL5qt04WWOPiO3KqT3g0uIQ1yiFlHyHIHIgwN3ijMUBkcoKHv0h41f9O1zv9uDieA
         A81tKZq6LHygGTccqSf/Qj1LvgVntIREdwlVLPJLRurkJV9NE7iyWuWsGJktlNw/h3WZ
         y0rXljWqqrkTMTOSSLzCyiTuYBCnUyXxReWo5IUsxoNc889MNmevXFfXLA/HPYy+UVHC
         IX0v+CRBHZdvFKNlSw0bm/NKrblZCRTniR6FD4/OEqnHYj5CSwifpBNWcubg3pFEtns8
         /MAQ==
X-Gm-Message-State: APjAAAVu68rETvhlh94pSmNrwdcdB/mv4/J7kVJsVKZVH7HNLAJ+mawX
        wJUY6/WZdVSupQ4y6xeWcy4m3fZZ
X-Google-Smtp-Source: APXvYqybK9bpPhygy1GneIhCxL17N8YNbCYh7xlcm9gUm7zI+DVwCq5olfeChRBhGjTt4vToKLGGUA==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr759589wrq.129.1576631827925;
        Tue, 17 Dec 2019 17:17:07 -0800 (PST)
Received: from hephaestus.suse.de ([179.185.209.78])
        by smtp.gmail.com with ESMTPSA id g25sm4782854wmh.3.2019.12.17.17.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 17:17:07 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: [btrfs-progs PATCHv2 1/4] tests: common: Add check_dm_target_support helper
Date:   Tue, 17 Dec 2019 22:19:22 -0300
Message-Id: <20191218011925.19428-2-marcos.souza.org@gmail.com>
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

This function will be used later to test if dm-thin is supported.
Inspired by fstests.

Suggested-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Changes from v1:
 Removed the $SUDO_HELPER variable when executing modprobe and dmsetup (Qu
 Wenruo)

 tests/common | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/common b/tests/common
index ca098444..20ad7fd9 100644
--- a/tests/common
+++ b/tests/common
@@ -322,6 +322,19 @@ check_global_prereq()
 	fi
 }
 
+# check if the targets passed as arguments are available, and if not just skip
+# the test
+check_dm_target_support()
+{
+	for target in "$@"; do
+		modprobe dm-$target >/dev/null 2>&1
+		dmsetup targets 2>&1 | grep -q ^$target
+		if [ $? -ne 0 ]; then
+			_not_run "This test requires dm $target support."
+		fi
+	done
+}
+
 check_image()
 {
 	local image
-- 
2.23.0

