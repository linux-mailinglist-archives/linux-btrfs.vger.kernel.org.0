Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A1F294D95
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442417AbgJUNcg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 09:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441714AbgJUNcg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 09:32:36 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC486C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:32:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m9so2040826qth.7
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JSzxH96pQ6taHYDcei+miTNZFPu+pnZ0We/AEEN3wwE=;
        b=jilbDlMMQx6lPEtp/X8c5pdm+mNPT9Gelpm2nnRc9Y2vnpCeIsqAPRgIq5ayZvvExW
         plga4X14ZDUkYAOe/uy1U2urORJKtJ+EYM8mxba+5tV5NaTJybRJyzdfFYxgWwNnqQua
         j4JXTItJsev+Snx+PoTKVetLzjGuEllqszdwFeSIeHyv2Cah7OlsAk+VJ/u0bSKemhmS
         KLHCyhxm1C/J7RoYN0Y4bLD5hj1+C+IerO6Xi5EIuf40SqtWjgIF5sjxFLq1VvGvxDHd
         udhXm0vUn7BsioE00PwL/k6ZcT6hczH8EFwi43ORPk0QKqGJoKJ2A7pVMb6vz9+li9Fi
         6Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSzxH96pQ6taHYDcei+miTNZFPu+pnZ0We/AEEN3wwE=;
        b=kLgoplT4VsVDpHkAkPZSmCsTL5e2Rg0ic1BL8aSf134KUf0ZScIWW3V0giyICT3ipa
         ApTWYTB0+IBChdrA3HQhbZF7QG6xwpL5K6+VBAX2I1B6bf9nqvV5KIt1nKfSt+QRI0y0
         PD+MhAh8o2pI0+M8GHWcxVHLTjZQJWbh/NMs5C2dvcfRSD3aENcXVG1iAFy9GOe3vNIJ
         qWFO/2Av3B1iNPlZ2Wb84yZ3cwOZcjYH7mQnSveEOhH+d3vXNeMe17BStKYDXQhTdjAY
         uzpZ85aTCQTGnVijbuszjtAtjxPP5HSCdWX4SIWcrfx5H6i01EVJ7+Js4+VWbcUN/BCv
         CZfQ==
X-Gm-Message-State: AOAM530KQspkttAu5oJe7NjbcmrKgJoc1J2De1rXfmfmeZcANjCvEYen
        CKY4+CYHgi8OZ3RnUhFQHlwijQ0rzn9DQ405
X-Google-Smtp-Source: ABdhPJwtaxyAV9A8Y/DV/pbAuiBjTVnrCzmyBE7jrJaxYYiFZdBKCLTkeEcnMExwbVZfjGb62QPrxQ==
X-Received: by 2002:ac8:4684:: with SMTP id g4mr3233011qto.140.1603287152694;
        Wed, 21 Oct 2020 06:32:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f187sm1277002qke.60.2020.10.21.06.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 06:32:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: account for new extents being deleted in total_bytes_pinned
Date:   Wed, 21 Oct 2020 09:32:26 -0400
Message-Id: <8cd75852f509d4db3e10b08606a26c6ff7451747.1603286785.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603286785.git.josef@toxicpanda.com>
References: <cover.1603286785.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My recent set of patches to reduce lock contention on the extent root by
running delayed refs resulted in a regression in generic/371.  This test
fallocate()'s the fs until it's full, deletes all the files, and then
tries to fallocate() until full again.

Before my delayed refs patches we would run all of the delayed refs
during flushing, and then would commit the transaction because we had
plenty of pinned space to recover in order to allocate.  However my
patches made it so we weren't running the delayed refs as aggressively,
which meant that we appeared to have less pinned space when we were
deciding to commit the transaction.

We use the space_info->total_bytes_pinned to approximate how much space
we have pinned.  It's approximate because if we remove a reference to an
extent we may free it, but there may be more references to it than we
know of at that point, but we account it as pinned at the creation time,
and then it's properly accounted when the delayed ref runs.

The way we account for pinned space is if the
delayed_ref_head->total_ref_mod is < 0, because that is clearly a
free'ing option.  However there is another case, and that is where
->total_ref_mod == 0 && ->must_insert_reserved == 1.

When we allocate a new extent, we have ->total_ref_mod == 1 and we have
->must_insert_reserved == 1.  This is used to indicate that it is a
brand new extent and will need to have its extent entry added before we
modify any references on the delayed ref head.  But if we subsequently
remove that extent reference, our ->total_ref_mod will be 0, and that
space will be pinned and freed.  Accounting for this case properly
allows for generic/371 to pass with my delayed refs patches applied.

It's important to note that this problem exists without my delayed refs
patches, it just was uncovered by them.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c |  7 +++++++
 fs/btrfs/extent-tree.c | 34 ++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 1edb0095f08d..33247f2d0c27 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -732,6 +732,9 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 	 * 2. We were negative and went to 0 or positive, so no longer can say
 	 *    that the space would be pinned, decrement our counter from the
 	 *    total_bytes_pinned counter.
+	 * 3. We are now at 0 and have ->must_insert_reserved set, which means
+	 *    this was a new allocation and then we dropped it, and thus must
+	 *    add our space to the total_bytes_pinned counter.
 	 */
 	if (existing->total_ref_mod < 0 && old_ref_mod >= 0)
 		btrfs_mod_total_bytes_pinned(fs_info, flags,
@@ -739,6 +742,10 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 	else if (existing->total_ref_mod >= 0 && old_ref_mod < 0)
 		btrfs_mod_total_bytes_pinned(fs_info, flags,
 					     -existing->num_bytes);
+	else if (existing->total_ref_mod == 0 &&
+		 existing->must_insert_reserved)
+		btrfs_mod_total_bytes_pinned(fs_info, flags,
+					     existing->num_bytes);
 
 	spin_unlock(&existing->lock);
 }
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5d97f5f3c85d..98a431c0cd7e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1755,23 +1755,29 @@ void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 {
 	int nr_items = 1;	/* Dropping this ref head update. */
 
-	if (head->total_ref_mod < 0) {
+	/*
+	 * We had csum deletions accounted for in our delayed refs rsv, we need
+	 * to drop the csum leaves for this update from our delayed_refs_rsv.
+	 */
+	if (head->total_ref_mod < 0 && head->is_data) {
+		spin_lock(&delayed_refs->lock);
+		delayed_refs->pending_csums -= head->num_bytes;
+		spin_unlock(&delayed_refs->lock);
+		nr_items += btrfs_csum_bytes_to_leaves(fs_info,
+						       head->num_bytes);
+	}
+
+	/*
+	 * We were dropping refs, or had a new ref and dropped it, and thus must
+	 * adjust down our total_bytes_pinned, the space may or may not have
+	 * been pinned and so is accounted for properly in the pinned space by
+	 * now.
+	 */
+	if (head->total_ref_mod < 0 ||
+	    (head->total_ref_mod == 0 && head->must_insert_reserved)) {
 		u64 flags = btrfs_ref_head_to_space_flags(head);
 		btrfs_mod_total_bytes_pinned(fs_info, flags,
 					     -head->num_bytes);
-
-		/*
-		 * We had csum deletions accounted for in our delayed refs rsv,
-		 * we need to drop the csum leaves for this update from our
-		 * delayed_refs_rsv.
-		 */
-		if (head->is_data) {
-			spin_lock(&delayed_refs->lock);
-			delayed_refs->pending_csums -= head->num_bytes;
-			spin_unlock(&delayed_refs->lock);
-			nr_items += btrfs_csum_bytes_to_leaves(fs_info,
-				head->num_bytes);
-		}
 	}
 
 	btrfs_delayed_refs_rsv_release(fs_info, nr_items);
-- 
2.26.2

