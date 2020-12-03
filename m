Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F92CDD5D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbgLCSYc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgLCSYb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:31 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8837CC061A55
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:12 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id b144so2964779qkc.13
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJCA1WFu34YlfNRq8jOTmY3WvoNsmIlp/39i55U+He4=;
        b=ajwR7Pd8j6JTRfLqCNbyHS6gh1WS1FDk8oUnGr8uiqrTPDvIPO3SWo3C3zBfn/hfgN
         83ruSFXrzSfUeRB49dSPUagWayZkh3QsP4LxRjThCihTglZdK8Qgqr+LCyj+i6E7adLN
         GSPAAMDeIHj/84dzBs8lW3HKpwuZvHeU7RnMmg9BBYu02PmcaCEkwy+g4LYxmEmj97cx
         08NyUJQdmh059nskKqn0PnUOJoU8CG3/BV5HvxjUv2VUVFL6DoGa8mcczAOjBWKEqH3v
         2Chq/fQn4cWsrNkWq0M0rKNLLT5xHNXXS+7B1r/+uHI63rsIo8t+vbYPM59NMFVRG7MC
         VMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJCA1WFu34YlfNRq8jOTmY3WvoNsmIlp/39i55U+He4=;
        b=F5WsHd5VlDqLPo78PMtZO4vyATWIimboB1twqePK5kIcPBf9qr04xUwqoOy5N73yDM
         s9xsrN05LykHNGB2Y99i72tVlIxfE7IOqrRpgAMh/6CSnYB6kxEGiG4N7hpVtkxb8Z5h
         SBTOhsxO7RO7ttM0eFdVABpdYxFa/jNrQX4TeCmhmtzsqUGgKg6b3pLJCsHsh3LgUSCd
         fAeYUYvsTfKu71dVNVpI5N8yu2DRi5tdoYI5W5zhkD/JAKedGY+ZT12txHLN696oolfR
         0U9AOSYoNN8RLRSq3MrjcXEytqxm8IG88+ssZINniPzaNqBs9oVbou4bVMgFxiY0uHyY
         QCiQ==
X-Gm-Message-State: AOAM533Hppo0KbY4q65r6Qd2egF+m/ebNSVTljXtPF/x86rLSJVRbPgB
        y7aTj5FGG3/toirDg8Lr3AlDEt7KHyKCj7Lx
X-Google-Smtp-Source: ABdhPJyEMtfFF8uX7t3PQkGaAbPK2sPzsphVRdTSP4qgbKwzzXzByosxFPXZMDtkalYKO/UGszkCJA==
X-Received: by 2002:a05:620a:12e9:: with SMTP id f9mr4182583qkl.86.1607019791518;
        Thu, 03 Dec 2020 10:23:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k46sm2135628qtb.93.2020.12.03.10.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 06/53] btrfs: noinline btrfs_should_cancel_balance
Date:   Thu,  3 Dec 2020 13:22:12 -0500
Message-Id: <4c788ce2fa56e8621079509c87221ac0d2d27c39.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was attempting to reproduce a problem that Zygo hit, but my error
injection wasn't firing for a few of the common calls to
btrfs_should_cancel_balance.  This is because the compiler decided to
inline it at these spots.  Keep this from happening by explicitly
noinline'ing the function so that error injection will always work.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2b30e39e922a..ce935139d87b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2617,7 +2617,7 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 /*
  * Allow error injection to test balance cancellation
  */
-int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
+noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
 {
 	return atomic_read(&fs_info->balance_cancel_req) ||
 		fatal_signal_pending(current);
-- 
2.26.2

