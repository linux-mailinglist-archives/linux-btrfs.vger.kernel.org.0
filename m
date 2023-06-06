Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F54E7236E3
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 07:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjFFFhH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 01:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjFFFhF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 01:37:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2AE1B5
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 22:37:04 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso3320991b3a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jun 2023 22:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=slowstart.org; s=google; t=1686029823; x=1688621823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXKzwEXEdvAPRSAB3ExrTenXQvkL0l7z/jj4ezUDKfg=;
        b=DSPBYC3vZuqe/DD66MinjQ6Yi6qqc7Yr+EY8xywsmFrUxiK/ztwuxP/KXy+nuZLII2
         1OU/Z7+Yfl45nDgZ2Vk+biuDT68uxun/pMf6u2c3CVdbBg7Hy8SuLIzBjBpf7zZ1rk/J
         KFSx/N/XH6KLifREjfXsomOCtRf8it03pfLBUHOuhGXqemQc7M8JZqaZ0nC+3gGJaa09
         5TetfltJBUed4STAKupqX4itqP0Kcr+X/hskCXirnGerm93ZO1PBUWCdbwNzNdc8lPDn
         mGovM9UT+lFxc/psTr9ftRPw6fLEQW6dKnnXDmFyHpJ/KLI6XgBsB7eK8tiOSvQO76SE
         xMQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1686029823; x=1688621823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXKzwEXEdvAPRSAB3ExrTenXQvkL0l7z/jj4ezUDKfg=;
        b=CW1RYJW2cshp/qJGxTlxS6AlE10CSrIBMeqtYEKTjaUTJ4A2Y0aQLYrv3L0GR3RoSO
         o0XiZ3OTzZ+xU4i2lnC6urEpC0j2PknBmtbbpJ8ZmwGXIJpJxUOLEWVjFxq5saCCwBkW
         GEoXM6dN4aWQ9qwUzh4S9Cn28EEywvIRkX58MxNswUKNXUqHvKKYvx/0bOZgMyX4kdYm
         1dOj1/0ntw08s9fwTPPoVO4VEV8EscDx8uHT85FXCDeYdrx+TKFQ9QxlIyxqX1CM2qGM
         0315NAaIyrzQeMip/UzY/OBtD3lK6x9ZGmqHXxX+brFVm+lmoXHWo1/It2ZQ23jl98HF
         WfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686029823; x=1688621823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JXKzwEXEdvAPRSAB3ExrTenXQvkL0l7z/jj4ezUDKfg=;
        b=WyeQsQQyfDTt2wS/VNSJ2R2ZKFVXJ9LCJpodML4Kl9tyMowEuqW63nU7GTIfMVxcfs
         6WmG3zQANOobMoOasSbaSM0RpbFKbplFkdZjaxQvp9hReE2Q2InquqVkKRzeBRhffE7d
         CW1jDu0KzooaiY1DiW18QcKKPCjCiiXPv7gdA/jP0aYmMxxXymEabPpbqaQZj405dI1/
         ZrYdSOJMaMLvwWsmXpllxS0C7Av0wlWsoZf2PQNcTEdQ0d79rr+OL6bW0Zc9DTaY7aXc
         H70RV49cSt4IbvqsO3xvT4mXxOktyGNToSFVbI5mPHatMDp18FIFvSnpMARpzUSiSMGs
         cMQQ==
X-Gm-Message-State: AC+VfDxLE9Uf//HpjdWTLXXtQpLUpwX0vOdKpjKQzb9I+E9mPYrUe6x+
        1IS3hMvwa40G1xPQO9bIlVLeXtf6+HicuLgGhobXe7LIJe1AjBhq2U+UgwB8CbH998K3kV+aHP0
        SLv3rqCw4xkPU8RUSMBR/DcAlJojT8ME8TK3NNPPR5v9q3F/zTXnTbmyjZO/l6JMuccekvA7+R7
        Y1cS+AKjtyK9mr
X-Google-Smtp-Source: ACHHUZ6Y9ec2FSHqVrhOPajJK8g1fyjHZnN4ZygM4dzuEDuwUJ/+qUX02q+eOWFku4Bs1BDyWsLR/A==
X-Received: by 2002:a05:6a21:3718:b0:10e:96b5:45fa with SMTP id yl24-20020a056a21371800b0010e96b545famr805410pzb.43.1686029822967;
        Mon, 05 Jun 2023 22:37:02 -0700 (PDT)
Received: from naota-xeon.wdc.com (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b001b06f7f5333sm7521853plg.1.2023.06.05.22.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:37:02 -0700 (PDT)
Sender: Naohiro Aota <naohiro@slowstart.org>
From:   Naohiro Aota <naota@elisp.net>
X-Google-Original-From: Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/4] btrfs: bail out reclaim process if filesystem is read-only
Date:   Tue,  6 Jun 2023 14:36:35 +0900
Message-Id: <d0a60acec35353dd7ad535bdddec0907857f2dd6.1686028197.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686028197.git.naohiro.aota@wdc.com>
References: <cover.1686028197.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a filesystem is read-only, we cannot reclaim a block group as it
cannot rewrite the data. Just bail out in that case.

Note that it can drop BGs in this case. As we did sb_start_write(),
read-only filesystem means we got a fatal error and forced read-only. There
is no chance to reclaim them again.

Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d5bba02167be..db9bee071434 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1794,8 +1794,15 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		}
 		spin_unlock(&bg->lock);
 
-		/* Get out fast, in case we're unmounting the filesystem */
-		if (btrfs_fs_closing(fs_info)) {
+		/*
+		 * Get out fast, in case we're read-only or unmounting the
+		 * filesystem. It is OK to drop block groups from the list even
+		 * for the read-only case. As we did sb_start_write(), "mount -o
+		 * ro" won't happen and read-only FS means it is forced
+		 * read-only due to a fatal error. So, it never get back to
+		 * read-write to let us reclaime again.
+		 */
+		if (btrfs_need_cleaner_sleep(fs_info)) {
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
-- 
2.40.1

