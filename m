Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF65184FBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 20:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgCMT6R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 15:58:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35363 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMT6Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 15:58:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id d8so14742901qka.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9D37MvBCjnOmn6nMyU5tjpe1HBXgZ6T4/fbgokRWQxA=;
        b=W8hQObkHSvbv1b0OMFinzTbCuSmwZU+qLnyk4Fr/glMkWmkjyC2QerpRK6QspMv41R
         WzLxHj9Zf2QCBfc4NOQt5h4elHdsrN4tRHHRZJiHZpFJ7YrVCh8Uk2vIakZjasV23si7
         05ZIoMYd9aLvh5+wqXrpk4aoaegrJczuC9EBVbYHuI/H/HECzItWQo2o4uX9FovdQ+w8
         d1uXpdzEzPvFr38F6xV2eCm5urbUblqzYl8tMd77DykViaAUJX9CLeSstRNbjiISi7xB
         OTtIGySio4DgufXODpeW6iQa/s8dT9DlNKHeYAVtUYa3QERW+MhhzPzQAjs14/m2hrNr
         TECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9D37MvBCjnOmn6nMyU5tjpe1HBXgZ6T4/fbgokRWQxA=;
        b=Co8IAseXwcA+ocidoe0X4SMGfsbpPF3SiberhxE6lqubesevNoxhu8WfN50Gb4yT/n
         X+g+0F++Fu2E3txTS72JiicWsKGni+xMp22IDNmXIu9/ijwW2VorrkZJDW0mE7XZCC92
         sMIcGN2mNs2Z4tjvDelj+KUqnkTfZOne3r+xCetDzTKWB/sdvHICpEyPzDBbQvj3O7sl
         BE+GLc5snyPM6aWAzhqowBX+dPoDPfH79mxrIZV/g8cyrK/Ywf/1q3betvvXRzAHpEIS
         LkdKUfQvYaSStIcinGLVQUpv71CtUxsIqvrRLUJW3XWOCn5tGgSiYf9HXd46WLlEWLPM
         xZsQ==
X-Gm-Message-State: ANhLgQ1U8qVpyj/HDIhaHL7OtLXmEPzfPxyM33O1Vx+5Z8Wv7lyaSx5c
        ZN5KQIxZz70+q/ZYlHff7rlQaF7jW9pRLg==
X-Google-Smtp-Source: ADFU+vuHJZ1IRTcuWijg9NelFnwQOryZLxZwEsi5JWkGMuUybm9oSMn1pdYV/4V3Z98WSYfp1vudnQ==
X-Received: by 2002:a05:620a:132a:: with SMTP id p10mr14707078qkj.253.1584129495198;
        Fri, 13 Mar 2020 12:58:15 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d22sm10953043qte.93.2020.03.13.12.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:58:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] btrfs: allow us to use up to 90% of the global rsv for unlink
Date:   Fri, 13 Mar 2020 15:58:06 -0400
Message-Id: <20200313195809.141753-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195809.141753-1-josef@toxicpanda.com>
References: <20200313195809.141753-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We previously had a limit of stealing 50% of the global reserve for
unlink.  This was from a time when the global reserve was used for the
delayed refs as well.  However now those reservations are kept separate,
so the global reserve can be depleted much more to allow us to make
progress for space restoring operations like unlink.  Change the minimum
amount of space required to be left in the global reserve to 10%.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 268ccf3db48f..4759499b1b97 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -821,7 +821,7 @@ static bool steal_from_global_rsv(struct btrfs_fs_info *fs_info,
 		return false;
 
 	spin_lock(&global_rsv->lock);
-	min_bytes = div_factor(global_rsv->size, 5);
+	min_bytes = div_factor(global_rsv->size, 1);
 	if (global_rsv->reserved < min_bytes + ticket->bytes) {
 		spin_unlock(&global_rsv->lock);
 		return false;
-- 
2.24.1

