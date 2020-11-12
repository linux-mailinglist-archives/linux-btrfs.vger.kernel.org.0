Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5952B0FF0
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgKLVTW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKLVTW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:22 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B65C0617A6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:22 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id j31so5208948qtb.8
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=13zH8V+C/OQfy/w8HyrelbF9UST4aQjMA33rjw0iJvg=;
        b=WNiw1A7ybgaCaShrTnY/R8jEi1ZouDaWYsWZsvwJ5wrorMKHdo23v2DbCW6pIf54Fq
         ALIZnRMJpBqZ45mfGMswvEfFsKnqOyEtCNzfsmgBZWkh4nbIxBGT1PI3MJReG1VCBJwd
         1mlS7NmenAyCoxWtcKpnwRLBEiK1qqGiHA3LgzRj9k84XWV9RnpFN7kvXbNV/5fO9fUM
         dSjDlBpCtZsd5/JKsNWq03gYr2dz+xN4tfpKr94utI496rZyMMqbhp0M3Lp8ERntwEx6
         NzjFJsB/ahCaR1zTtHGjZUnK22Q7ZMidC+TOvcz74Hxy0FM7U3uDqkyFK3DSPgd0HvTe
         sLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13zH8V+C/OQfy/w8HyrelbF9UST4aQjMA33rjw0iJvg=;
        b=bsr/UbcP4XCc279LqNtPOX0cvdQsYw0YaYWEqJaKn3QvRQ+Hu2MwAvGkCDOIO53tei
         Aec6R/bZGXDF2GINrUNwDiKV/2PSbM8Q0br26ym5enuOKhOUjtANbabpl67yeuHVQXwk
         xy2+nghFJ9uWWlaUuKewfHewPAuCTldFcUndXIFW/6iMiFqhKXDbqiTp/yYrWHo0X7oj
         9Gv4eDWOhbOZ6g45q6MJ8BGDz2hGHNao5nIzmBht8j+LF0jdt67BlFy5OUocY2m1KHxN
         TV0/zw8B3oVkk00XuCj2mkklMAHLvASqyvoQjwcQfF3REpOtcXgcdhU/G7OYkGFnNtpX
         3eNA==
X-Gm-Message-State: AOAM533OX2O30PDKxpGzzYhhW2zAsW4/hzaMO3xKQE2Az3nZcXstNler
        YzzZWk2mxzH2czJNqjdUj7MNp8382HTc6A==
X-Google-Smtp-Source: ABdhPJwid/CkwnGYo/Pj/SYKOHahdCIp48i/mD6rT4GFLqgPj57p6Hgs5NnRzxWNZzQEfCSVYfmskA==
X-Received: by 2002:a05:622a:55:: with SMTP id y21mr1173550qtw.383.1605215961169;
        Thu, 12 Nov 2020 13:19:21 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a7sm5498257qth.41.2020.11.12.13.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/42] btrfs: return an error from btrfs_record_root_in_trans
Date:   Thu, 12 Nov 2020 16:18:32 -0500
Message-Id: <90ee61400ed090852cf267dac6bddb7caa84c8a8.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can create a reloc root when we record the root in the trans, which
can fail for all sorts of different reasons.  Propagate this error up
the chain of callers.  Future patches will fix the callers of
btrfs_record_root_in_trans() to handle the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b671ea4d80e1..9cb379facf7a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -403,6 +403,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 			       int force)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret = 0;
 
 	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 	    root->last_trans < trans->transid) || force) {
@@ -451,11 +452,11 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 		 * lock.  smp_wmb() makes sure that all the writes above are
 		 * done before we pop in the zero below
 		 */
-		btrfs_init_reloc_root(trans, root);
+		ret = btrfs_init_reloc_root(trans, root);
 		smp_mb__before_atomic();
 		clear_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
 	}
-	return 0;
+	return ret;
 }
 
 
-- 
2.26.2

