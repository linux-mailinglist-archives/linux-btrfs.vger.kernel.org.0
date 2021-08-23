Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228273F5137
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhHWTYI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhHWTYF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:24:05 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA08C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:22 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c19so3902768qte.7
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPb0H7JzwTjjClcrSxiCdWbNjpJlwJ237JM1twecaGM=;
        b=d0zbV9K108WofXmP4WHSvKN0J+ofKcbOg1sn2LPfu0njOzerAWlPNjC7ZtX5aUPiid
         2ywq4vKGQ5xT9QIR0jfJ9MQik5n5pk7xiAFFIQYc1rOuo+AOK7j5Smjbf4u+ktTpHW/H
         3Aph+cmlI+RfUyW7LBOwOclbIsOk/U3bt7Mp/UCDRZNyvZK3KGdLkEw+KHplhvmuL/jV
         F5j1n8/Te/bScEii78WJwQUz0Gd8twEi+Xnk9ZVPuzo85I8JyXIv+r2KhkCiQODOIGP7
         KrfC9tMxvmSMkn/puuekWW0Li7zfAva+5Teqq/mSATghn5xaMyww0glUY4yi11FxMOq9
         qWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPb0H7JzwTjjClcrSxiCdWbNjpJlwJ237JM1twecaGM=;
        b=eLXOSyfC6w3xzbAEXJmttnBHQ228D0yhZ0GpNauGwlsOpATJ6VhEeUDGwPjmMxBP6A
         c99+D4K9kA0XE07+3X8IC4GbnHa9LC95QCTZGz88gXcpTbnJq4a8FhWUX6Urf06WOTBj
         n+l/3Fk0UiQOrSldn344LfXFS0XcEUxBbjV3oxy20D1bzMQCJ8i118pW5jV3rFObNY3J
         q+IkirxAMbmtR4+7FYWK7npD5nqGrOTlfNdIPMsfBy1IKbgmKkypzi/Rq5sGR0rYabpR
         ifTGCJ2lI6eJObAG4f4yCR+mlPgjm44lF7PC523LH0UDPiyuDUj2fjjFB0UYvCTtiGsR
         ViNA==
X-Gm-Message-State: AOAM530/bnkgt0y3XBlHGvODHmDUs+1AC2GNq46p5rSycfnZtkO22rMG
        ZwLW+j67ZxAAMqtRcmlTxjpxXgbcWm57Bw==
X-Google-Smtp-Source: ABdhPJxsN+ZS2hHj30m5s/r6dRbr+Fwb+nek9mHDu4v6HHeMrUZUi5/m2xUZ1K5Q+gkyBiklhhOijw==
X-Received: by 2002:a05:622a:591:: with SMTP id c17mr2684481qtb.319.1629746601173;
        Mon, 23 Aug 2021 12:23:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 62sm7214273qtg.58.2021.08.23.12.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:23:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 4/9] btrfs-progs: check: propagate extent item errors in lowmem mode
Date:   Mon, 23 Aug 2021 15:23:08 -0400
Message-Id: <6ae6b4aa924329001685e8717c7db77ca33f805e.1629746415.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629746415.git.josef@toxicpanda.com>
References: <cover.1629746415.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test 044 was failing with lowmem because it was not bubbling up the
error to the user.  This is because we try to allow repair the
opportunity to clear the error, however if repair isn't set we simply do
not add the temporary error to the main error return variable.  Fix this
by adding the tmp_err to err before moving on to the next item.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 507873ce..cb8e3ab8 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4381,6 +4381,7 @@ next:
 		goto next;
 	}
 
+	err |= tmp_err;
 	ptr_offset += btrfs_extent_inline_ref_size(type);
 	goto next;
 
-- 
2.26.3

