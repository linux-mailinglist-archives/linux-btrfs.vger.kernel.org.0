Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959861AF641
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Apr 2020 04:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDSCJD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Apr 2020 22:09:03 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:33258 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgDSCJD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Apr 2020 22:09:03 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Apr 2020 22:09:03 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 494Y0v5jDZz9vLGg
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Apr 2020 01:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sXzfVqkvJh0A for <linux-btrfs@vger.kernel.org>;
        Sat, 18 Apr 2020 20:59:27 -0500 (CDT)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 494Y0v4gX4z9vLGb
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Apr 2020 20:59:27 -0500 (CDT)
Received: by mail-qv1-f69.google.com with SMTP id z14so6405960qvv.6
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Apr 2020 18:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HCfuU4zQnI9WCXY6MChIEAisAu9Dg1DyD5OyLd8lpYc=;
        b=jKF9s+D4Xw9nQXeOdQAsoViL4u27zSmj8Kjb7O1Y3EzSvQVIZ/H+mt0eBHZZJ9iTHH
         LVcgO9mKBaSme1yH8UceImOwq8EGLKBN24nmPtvEDxhPeHWCulzh8r7Sf6V2p8YlYHU9
         /EqvDNGPjxLEzRYqoF5DsBUI+moKivt+NmRVCW65rXn491MIbJNz0MNthccGLGf9hYU0
         TirscioFQaCNzXkthh2DM0Jeiuu0vSnau5mLcHY6+kdk9TBQbc5p9akE1pbaxQnIDjXA
         /otr2SPZ3lDy8h/JP5dsw9T65s38Ic6RT5iB3fplMBsaSUSFi9yhjRDA45/SA6ehe/zQ
         3w4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HCfuU4zQnI9WCXY6MChIEAisAu9Dg1DyD5OyLd8lpYc=;
        b=naoWoJMpQQWqMiNBl1fc6CiriiYGf1Om2fTxgWB1qvZeBcomYVU6MbTOkDNTPJiFoh
         sCPGrBqRrEpAmPBwNp/Cz99xAZH18t8SOTnXoggJiyph2bmzLZwdjy8VQVOPd2dckGzz
         ti1Q3OnECexS7LjxKZYv3d519S3jZv6ym3toXqhvi8n8M0NCIdQZj/I02x4+1Ri/Nh5a
         QYIHAErT0dL2P8IAWFYnK30mm26EuIfxwvZzIYbk4ew+UIjvuFVaahMtlihHHpVcvIN2
         KovxuzpJcIyEPvmbRwNXDHQ+elAf7BJmjMhmcudzFS872zXW5LkYOzfeUDmfCoAq8aPO
         vf6A==
X-Gm-Message-State: AGi0PuZhTdLXmCo65Syj9hE/udfg8dCLyx0UWNeKtJ3chFoPg2EdbVD8
        wl3ITaJnlwbAk3/WUbKNoNbtIzKOuoqIdRlnpOALzzO8cznAtBgtCKwtebB63JWEz1bsrwBZpJH
        1p1bKiSbjLZcaHkR3E9uGQuPL4vI=
X-Received: by 2002:ac8:5513:: with SMTP id j19mr10360618qtq.319.1587261566960;
        Sat, 18 Apr 2020 18:59:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypLgSkYtVsc/li5EASyRidgZ/WEugX1aTxdMnZBtEG2fLb6S8mwIxoHNoGFODlBr9i9KEvypGQ==
X-Received: by 2002:ac8:5513:: with SMTP id j19mr10360605qtq.319.1587261566568;
        Sat, 18 Apr 2020 18:59:26 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id c6sm19814298qka.58.2020.04.18.18.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 18:59:25 -0700 (PDT)
From:   wu000273@umn.edu
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] btrfs: fix a potential racy
Date:   Sat, 18 Apr 2020 20:59:07 -0500
Message-Id: <20200419015907.15503-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function reada_find_extent and reada_extent_put, kref_get(&zone->refcnt)
are not called in a lock context. Potential racy may happen. It's possible
that thread1 decreases the kref to 0, and thread2 increases the kref to 1,
then thread1 releases the pointer.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 fs/btrfs/reada.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 243a2e44526e..4b90d04f7a0a 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -361,13 +361,15 @@ static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_info,
 		zone = reada_find_zone(dev, logical, bbio);
 		if (!zone)
 			continue;
-
+		spin_lock(&fs_info->reada_lock);
 		re->zones[re->nzones++] = zone;
 		spin_lock(&zone->lock);
 		if (!zone->elems)
 			kref_get(&zone->refcnt);
+		spin_unlock(&fs_info->reada_lock);
 		++zone->elems;
 		spin_unlock(&zone->lock);
+
 		spin_lock(&fs_info->reada_lock);
 		kref_put(&zone->refcnt, reada_zone_release);
 		spin_unlock(&fs_info->reada_lock);
@@ -458,8 +460,11 @@ static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_info,
 	for (nzones = 0; nzones < re->nzones; ++nzones) {
 		struct reada_zone *zone;
 
+		spin_lock(&fs_info->reada_lock);
 		zone = re->zones[nzones];
 		kref_get(&zone->refcnt);
+		spin_unlock(&fs_info->reada_lock);
+
 		spin_lock(&zone->lock);
 		--zone->elems;
 		if (zone->elems == 0) {
@@ -502,9 +507,11 @@ static void reada_extent_put(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->reada_lock);
 
 	for (i = 0; i < re->nzones; ++i) {
+		spin_lock(&fs_info->reada_lock);
 		struct reada_zone *zone = re->zones[i];
-
 		kref_get(&zone->refcnt);
+		spin_unlock(&fs_info->reada_lock);
+
 		spin_lock(&zone->lock);
 		--zone->elems;
 		if (zone->elems == 0) {
-- 
2.17.1

