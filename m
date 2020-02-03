Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29D6151154
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgBCUuP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:15 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40262 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgBCUuP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:15 -0500
Received: by mail-qk1-f194.google.com with SMTP id b7so464242qkl.7
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tvdnCxP2qzDN2fH1vgdT3kTHfzo9HmvwH2IHfqMpIPU=;
        b=p2OOtqhQ8IGV/aeF02dj817tgPOzwoEu2htdkSTlnBhnVk33LQ+hlzxIP3uFATYvx4
         E3NY1pARRaFP0mNDkd7CKgkIimlvOtEolesOG9N1bRM6mIJsR5d2vjrZRmauyGQXN5WZ
         KBEss3CTG1AWY7XQEGzgTmtVK0q1x41LQ7lyvFnsoMeuIRKiXo6GDAUZreZQT48CJ8wT
         vvqNLDr1chCL4iuKqaRiXX3Oz0ZQhUiz3lG1pLXu1ZzP8sMFlMKIC6fk9oCcAcy9skxD
         /udAS1uIIIKMgPEm0Mia1KukO/vIUuHIaUEGe0rmpxnavsf/4613MMGtls718GzO4424
         zhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvdnCxP2qzDN2fH1vgdT3kTHfzo9HmvwH2IHfqMpIPU=;
        b=mtb3+NPtOh5lG151kH5SQdNTksf0M/4RrRw2164TqyrJjpDEiSZmavbAKpj1TYUKfG
         Wjn5luIxhKTngEp25anaTFPESKHfuJpiUHM+KivmcP2na4Pi4l0VcE9ZUYOwrgOFUP/u
         lHg4Z9ElCG1M3F6eQCt10o7bjdF99Xn4QfZzPsQfV8GUS+s53RiWj/pCMA8hSWJA/tR1
         pOtGWWxHa1Vlp6wPWqZmIQKFRQLY3K3uL8AcRSypHOYUETb8rxgXZo8tSPotvL2hU4Vr
         t6eikClVeQbYE2AnlgW1tPC+c2tGOY0TahnNYSdWAMR0aS+8BMR1Y/WRT6S7xNTFgPwt
         Y9zQ==
X-Gm-Message-State: APjAAAUQN9jssUDf9QwRGqz+8Lbta+8UN+z2apS5JhQFye5g0FK4iHbp
        cAq4XjoRrPLJzwBqO1RnEwIykWnSidoqVw==
X-Google-Smtp-Source: APXvYqzVmyBv3yi+nrJReaa/GYP4mwMj5YGHkb3YJblCR9zEZcPEEaPGkhS87W8mxWvVhkGNos1zrQ==
X-Received: by 2002:a37:27cc:: with SMTP id n195mr23315359qkn.428.1580763012226;
        Mon, 03 Feb 2020 12:50:12 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s1sm9575742qkm.84.2020.02.03.12.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/24] btrfs: check tickets after waiting on ordered extents
Date:   Mon,  3 Feb 2020 15:49:38 -0500
Message-Id: <20200203204951.517751-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Right now if the space is free'd up after the ordered extents complete
(which is likely since the reservations are held until they complete),
we would do extra delalloc flushing before we'd notice that we didn't
have any more tickets.  Fix this by moving the tickets check after our
wait_ordered_extents check.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a69e3d9057ff..955f59f4b1d0 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -378,14 +378,6 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	while ((delalloc_bytes || dio_bytes) && loops < 3) {
 		btrfs_start_delalloc_roots(fs_info, items);
 
-		spin_lock(&space_info->lock);
-		if (list_empty(&space_info->tickets) &&
-		    list_empty(&space_info->priority_tickets)) {
-			spin_unlock(&space_info->lock);
-			break;
-		}
-		spin_unlock(&space_info->lock);
-
 		loops++;
 		if (wait_ordered && !trans) {
 			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
@@ -394,6 +386,15 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 			if (time_left)
 				break;
 		}
+
+		spin_lock(&space_info->lock);
+		if (list_empty(&space_info->tickets) &&
+		    list_empty(&space_info->priority_tickets)) {
+			spin_unlock(&space_info->lock);
+			break;
+		}
+		spin_unlock(&space_info->lock);
+
 		delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
 		dio_bytes = percpu_counter_sum_positive(&fs_info->dio_bytes);
-- 
2.24.1

