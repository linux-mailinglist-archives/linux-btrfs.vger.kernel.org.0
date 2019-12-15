Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0466D11F99E
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2019 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfLORSi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Dec 2019 12:18:38 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:41054 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfLORSi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Dec 2019 12:18:38 -0500
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Dec 2019 12:18:37 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 47bWDq0KNLz9vf0n
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2019 17:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jGfdKxz_a0Bs for <linux-btrfs@vger.kernel.org>;
        Sun, 15 Dec 2019 11:12:42 -0600 (CST)
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com [209.85.161.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 47bWDp63Tkz9vbXt
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2019 11:12:42 -0600 (CST)
Received: by mail-yw1-f70.google.com with SMTP id o200so3883141ywd.22
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2019 09:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zhtlch/cxMxWFqhg5J9e0u6iluOrhN5n/YoxV6vgAHw=;
        b=RRHGLZR6ustuYdKO8l7flwqB2ODykJg3s+gUufn2+cnqJUZnf90AidnC7J4gEbgpjX
         P1FXQt/fPXkeCpSn89bNmVzDB1bJYNvDfzXXLkFOc67Cn2OYJPH42OebHzivAgyfU9NW
         dQshdiJOZ7y84P8wVoSCakfcvpFzG9AdOJW4ntI5wbe42CEF+euU6b+51Tmlh18Bum5f
         9brC8VxO0bXu2ACn2v8ONUsNSSXtm41LonLCI2RDtEWmvehExYrbOUXM0LbHIxG5nJkV
         aBNFqL15GltjxrbiRt8YVIjX0cld6OWCFUXdzn1Jr9VFXpjbSj8aVdjEyzZR+pzqPvDC
         nY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zhtlch/cxMxWFqhg5J9e0u6iluOrhN5n/YoxV6vgAHw=;
        b=jDinvovVb8mHhe3RDMIu4K6cvbcOqEiQaAXsGL7mOjdHg3kgrvXQx9w4Ckb5kZw6ht
         afo1Wn7VUWMl7IBs2vKnAI1X1mQdJV9kM0tPCIl3N8C3tINN6bx7eL48dU/E7s0zq6LT
         djmiEPZZYdxcPrI9GtEVey5lRb/87kTbU+9s/H5595LSqvpvxEehfz5BzEc7GzfgqU5g
         mxzTQirepAEV4RFkwr5keSa14iW7/8xoXttockWmW/SxMtTF06LsR1vewuz95FblJPpT
         /Q4Qq13KV6Sx+iBYFRbAFeO3rkAOCOb7in2uzJ8H7AFjdUMTkhXbv+5tqfIcRwNbAfSh
         r4oQ==
X-Gm-Message-State: APjAAAXfFs3F+ZRJpvX86JxSHj0QtP+Fzug2B7tfLXr/08C5O7NtZUmF
        Ulk2PjUVkEFivs2u0OBxLx5enlbbS84hoWss7Sjmabmyq+VSM0glQ7kK11j0dwj+bobH7StuGoL
        3GdChvD8hLNn8lgk1bAgjBrw4wws=
X-Received: by 2002:a0d:d5cf:: with SMTP id x198mr16663601ywd.80.1576429962334;
        Sun, 15 Dec 2019 09:12:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYCROf8cfDp7PKzWucgQEPd95CFFWqsUgOZcKkKLNUNNvfWa15pchhEHzFjQ4HKE5bYgnJVA==
X-Received: by 2002:a0d:d5cf:: with SMTP id x198mr16663586ywd.80.1576429962091;
        Sun, 15 Dec 2019 09:12:42 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id h68sm3256433ywe.21.2019.12.15.09.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 09:12:41 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: remove BUG_ON used as assertions
Date:   Sun, 15 Dec 2019 11:12:36 -0600
Message-Id: <20191215171237.27482-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

alloc_extent_state_atomic() allocates extents via GFP_ATOMIC flag
and cannot fail. There are multiple invocations of BUG_ON on the
return value to check for failure. The patch replaces certain
invocations of BUG_ON by returning the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/btrfs/extent_io.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index eb8bd0258360..e72e5a333e71 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -989,7 +989,10 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	node = tree_search_for_insert(tree, start, &p, &parent);
 	if (!node) {
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
 		err = insert_state(tree, prealloc, start, end,
 				   &p, &parent, &bits, changeset);
 		if (err)
@@ -1054,7 +1057,10 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		}
 
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
 		err = split_state(tree, state, prealloc, start);
 		if (err)
 			extent_io_tree_panic(tree, err);
@@ -1091,7 +1097,10 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			this_end = last_start - 1;
 
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
 
 		/*
 		 * Avoid to free 'prealloc' if it can be merged with
@@ -1121,7 +1130,10 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		}
 
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
 		err = split_state(tree, state, prealloc, end + 1);
 		if (err)
 			extent_io_tree_panic(tree, err);
-- 
2.20.1

