Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC7E7236E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 07:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjFFFhD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 01:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFFFhB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 01:37:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B141F1AD
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 22:37:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b038064d97so51185355ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jun 2023 22:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=slowstart.org; s=google; t=1686029819; x=1688621819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+KVA8d2QzjjtOm41L/n6eTGzIQ0QopCkCyI/fnIOaI=;
        b=eKajPzfcAnTwX0beRBEneGsd94AEoe4RtQkuSjc1EePM5llGeEgPReG/3EmGEa47dR
         XqQP990+jiPL0jRYIsl5jyG7+n+vteeFGkq0YPvjmK2SREtFsse4DBOGDZmR7id+6Kz6
         yNe3iee7zXGHDwmRHr1ItIoDgOjWOuV7oGTArhgJz9MoAMnN0TkQRlFNuWKqqyogfz/m
         ek6B6Fjh2fa+iUjjgMrvquwQCCZqaZWs49M1TdKlQo0u8eO9Iw+ZckPY3fEBW9iWzuxP
         eb//5Qr7NsmjgoWnx3Eh7OKk2pHd4Ae7jM82sDTKytQsttQEg+87nDcGSHbfFSCXecvh
         dMvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1686029819; x=1688621819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+KVA8d2QzjjtOm41L/n6eTGzIQ0QopCkCyI/fnIOaI=;
        b=0pIEX0v6Wsc375sYB7ofCtthJ+WCnrCFP3N04lnDfMHBH3zoJvnkNRiBf5SwAC3XZs
         stBpZDm5BkdAgo/gk9NiYVsWWV1OUalEyh3t9AO17UBDX0fO8KEtOjN6hYZK6FfmOVRh
         hmW7nVzTfDK2GpE46/2yhWRW7tJqNz/zdUxtYzymNxN1PeJiOjfnF31BllBF9VncCGSb
         ynD6jiUNg/WcHGKrxQrhVbsL1Rc97HkyDXocb0XEDhUHWr3YZAa1PJs4kIxOgHiZmGVv
         wZV4uwpGHlE6269/Xcz2/viV97TdhxhcnwmXGl12uqOYbpB1ULk9gkWTgOrPqXak69Ex
         Os9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686029819; x=1688621819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t+KVA8d2QzjjtOm41L/n6eTGzIQ0QopCkCyI/fnIOaI=;
        b=eVXOiZMo+iIjuy3dMVtoCVs5+/k+xeCms71JzRJIDpvC/oycxL6oNhDLgDHk7NBF1I
         FNogQ6HmOu5BXsAspA6ZAJygbvpLo8TulJRgRchRhd5nZkrn68BasiZuPRtmncOjySZq
         7kHa2UgnemZReh6AnV+k+ONooU4Kls6Q9PoDecCa3XvJ3nJCUD08l27LtXMLEKk34yl8
         +54fU/fuzWOEplGFTi6dgjI55AhydXQ6zzzrGftIVgfM1fVAuwe7KsPeTviZBjrZS0E8
         eFjyyHHCRIt9TwuTnOoj7DJI4p/S3p6bqXfVPoL8AcS6gWEiegATa9aq9VRDWUzS4SNB
         8ihQ==
X-Gm-Message-State: AC+VfDwlZDSYfhqkfv9je3qkgRn+aljyQuc8MkQHPDRXxZCCUrYpVWTI
        1NNHFQoIFPp6veGcyNY+Tjr5ksohOUlX92oWPoUy4KdOn0dY7g7Pm1LeGqVRerbh22kyDgsxX+8
        0Fgaja9j2IsTM6KrlZPtd73OrfVHpQW+buHO4iCOwS3lkvHmhFvYl7HE0h/mX7JZZsh/mlXt0nu
        vgnb2aNhsE2xCz
X-Google-Smtp-Source: ACHHUZ5bNCa6zgqXpINtNlMi0jzc7iqaM9NQBeIhDpCezvbIKVfcuXd9EF9zIS2PJFcaoJ1mLubn5Q==
X-Received: by 2002:a17:902:9887:b0:1a9:80a0:47ef with SMTP id s7-20020a170902988700b001a980a047efmr7963910plp.20.1686029819452;
        Mon, 05 Jun 2023 22:36:59 -0700 (PDT)
Received: from naota-xeon.wdc.com (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b001b06f7f5333sm7521853plg.1.2023.06.05.22.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:36:58 -0700 (PDT)
Sender: Naohiro Aota <naohiro@slowstart.org>
From:   Naohiro Aota <naota@elisp.net>
X-Google-Original-From: Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/4] btrfs: delete unused BGs while reclaiming BGs
Date:   Tue,  6 Jun 2023 14:36:33 +0900
Message-Id: <06288ff9c090a5bfe76e0a2080eb1fbd640cdd62.1686028197.git.naohiro.aota@wdc.com>
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

The reclaiming process only starts after the FS volumes are allocated to a
certain level (75% by default). Thus, the list of reclaiming target block
groups can build up so huge at the time the reclaim process kicks in. On a
test run, there were over 1000 BGs in the reclaim list.

As the reclaim involves rewriting the data, it takes really long time to
reclaim the BGs. While the reclaim is running, btrfs_delete_unused_bgs()
won't proceed because the reclaim side is holding
fs_info->reclaim_bgs_lock. As a result, we will have a large number of unused
BGs kept in the unused list. On my test run, I got 1057 unused BGs.

Since deleting a block group is relatively easy and fast work, we can call
btrfs_delete_unused_bgs() while it reclaims BGs, to avoid building up
unused BGs.

Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 618ba7670e66..c5547da0f6eb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1824,10 +1824,24 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 
 next:
 		btrfs_put_block_group(bg);
+
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
+		/*
+		 * Reclaiming all the BGs in the list can take really long.
+		 * Prioritize cleanning up unused BGs.
+		 */
+		btrfs_delete_unused_bgs(fs_info);
+		/*
+		 * If we are interrupted by a balance, we can just bail out. The
+		 * cleaner thread call me again if necessary.
+		 */
+		if (!mutex_trylock(&fs_info->reclaim_bgs_lock))
+			goto end;
 		spin_lock(&fs_info->unused_bgs_lock);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
+end:
 	btrfs_exclop_finish(fs_info);
 	sb_end_write(fs_info->sb);
 }
-- 
2.40.1

