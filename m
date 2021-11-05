Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7314469F9
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhKEUso (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhKEUsm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:42 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2547C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:02 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id w9so3234082qtk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=u/M/Q4QHG8MY4NqRtxXE3pMvPpVP5i/CBa8oOhB4jaY=;
        b=QmMVaNZELbuFGuaf70vOSVMMC4Nj8ZpdVTula5DpagiVkS+iiPEUuxPg4M82Kb2FBu
         L48RT6FwyuD6swtlq27vJEInXMABThy4nk/faiIGf3X7ioU9Yo3ZJz5Z8d0SYvPt5KTW
         7od4sny2J8a8HbuAHsFfzPtKU8ielXB4WVJPB6MGu+tPhhBNZ41KW5I3H77d5YCSGmw2
         3HIfGVaEfCNM2rqyRzj4KjIzx4EtRt7HEPmJVurlQgIY/7en7p4JRr1SaNlhKJlrTNLJ
         kbQO6JhO/UHbZtzFsUbb95YEYIpn9hhGo4zoQgPLOK8vbgocBokloIHEYrfWVFrfmZdS
         s3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/M/Q4QHG8MY4NqRtxXE3pMvPpVP5i/CBa8oOhB4jaY=;
        b=apd+eNU5vPyiWOScl8ZdFZhbHxGE8LrKqFIFd0fsTiLmOSWiO3CuppyEtFaOkGq6/9
         IS/l0O5tblYZyLaOxHJT7KKV6RoY8hthl4TrSRFNb5cmxixZNOqWMrG3QfGDHc54k1Qs
         KTPdeCAaGOuL30MzQDiVdXX36K4OksA1v1Ag6JWt5aRYAwaDatM1hXTKvMVQrWyRbt0G
         KnBVf/sXWVoOeMZY755Gev1URRWNPqH+ZVI4udl6oZLGRNBTVCeJoEyGtGkUCXwSVFFg
         A9W/suzU/NcKzW+0HY/dVWwqM0vrF8EgrCgOHhYwKHBtmZL8I73BF9k8QTRx5xTHGikz
         5WtQ==
X-Gm-Message-State: AOAM531nC9BZ7GV7fkceFcpy+S12uEan6vJCdsmeXiUmc85mcTwN5ibj
        +7S9ekdZI8pKoKFeY9N/MKyjyLHz4IsK1g==
X-Google-Smtp-Source: ABdhPJyEfjclfytRBYu2fYLt+chIGX6eiEOF7itbDc+779W6xNpsKBOjcZPjoAxQtnsTTo7qHm87bg==
X-Received: by 2002:a05:622a:593:: with SMTP id c19mr65494889qtb.240.1636145161514;
        Fri, 05 Nov 2021 13:46:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v3sm4427268qtw.53.2021.11.05.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/25] btrfs: move comment in find_parent_nodes()
Date:   Fri,  5 Nov 2021 16:45:32 -0400
Message-Id: <1074b1a14b58f421ac7be6ff12192af991d2d7dc.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This comment was much closer to the related code when it was originally
added, but has slowly migrated north far from its ancestral lands.  Move
it back down with its people.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 53140f6ba78a..17766b7635f9 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1204,11 +1204,6 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	if (time_seq == BTRFS_SEQ_LAST)
 		path->skip_locking = 1;
 
-	/*
-	 * grab both a lock on the path and a lock on the delayed ref head.
-	 * We need both to get a consistent picture of how the refs look
-	 * at a specified point in time
-	 */
 again:
 	head = NULL;
 
@@ -1224,8 +1219,10 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	if (trans && time_seq != BTRFS_SEQ_LAST) {
 #endif
 		/*
-		 * look if there are updates for this ref queued and lock the
-		 * head
+		 * We have a specific time_seq we care about and trans which
+		 * means we have the path lock, we need to grab the ref head and
+		 * lock it so we have a consistent view of the refs at the given
+		 * time.
 		 */
 		delayed_refs = &trans->transaction->delayed_refs;
 		spin_lock(&delayed_refs->lock);
-- 
2.26.3

