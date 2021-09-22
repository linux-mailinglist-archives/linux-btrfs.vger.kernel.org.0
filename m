Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531A04143BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhIVI3B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 04:29:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40892 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhIVI24 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 04:28:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D8C722278
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632299246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOgzyRdhd8wjL84tlRyNnGfWYPttkAE9M81BzX8L60o=;
        b=dvoSkwMP05oyodOOnPVVNuQGVIWveTW/ovvwq6nYKrz8Ol1LM9OwQc0utxNGx7Sm9YJGEs
        4z4dLwOriVt90dAfVeB+iat6+GbhbQYxrIiqCOhC95C9s7aaaiRMSL51sXCEqR7SrZFnSc
        VIGEl4DkAXB44Ivt01NYY76s4rcj/F4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CADD13D65
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 08:27:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EM5kA+3oSmEPDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 08:27:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/3] btrfs: add btrfs_bio::bioc pointer for further modification
Date:   Wed, 22 Sep 2021 16:27:04 +0800
Message-Id: <20210922082706.55650-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922082706.55650-1-wqu@suse.com>
References: <20210922082706.55650-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we use btrfs_io_context for dual purposes:

- As bio->private for mirror based bio submission
  For those profiles, we assign bio->private to btrfs_io_context and
  save the old private/endio, and utilize bioc::stripes_pending.

- As pure stripe maps for RAID56
  For RAID56, btrfs will assemble its own raid_bio for physical
  submission. In that case, btrfs_io_context only provides stripe
  mapping, thus no need to utilize things like
  end_io/private/stripes_pending.

To make future members modifications, here we do a small change, by
introducing btrfs_bio::bioc pointer.

This modification will increase memory usage for btrfs_bio by 8 bytes,
but reduces btrfs_io_context by 8 bytes.
Overall it's still a net increase as btrfs_bio will be created for each
stripe, while btrfs_io_context exists once for all those involved
stripes.

This memory usage will be reduced by later commits.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 7 +++----
 fs/btrfs/volumes.h | 3 ++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d7cc24ed9620..86ff268369ec 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6557,16 +6557,16 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 static inline void btrfs_end_bioc(struct btrfs_io_context *bioc, struct bio *bio)
 {
-	bio->bi_private = bioc->private;
 	bio->bi_end_io = bioc->end_io;
 	bio_endio(bio);
+	btrfs_bio(bio)->bioc = NULL;
 
 	btrfs_put_bioc(bioc);
 }
 
 static void btrfs_end_bio(struct bio *bio)
 {
-	struct btrfs_io_context *bioc = bio->bi_private;
+	struct btrfs_io_context *bioc = btrfs_bio(bio)->bioc;
 	int is_orig_bio = 0;
 
 	if (bio->bi_status) {
@@ -6624,7 +6624,7 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 
-	bio->bi_private = bioc;
+	btrfs_bio(bio)->bioc = bioc;
 	btrfs_bio(bio)->device = dev;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
@@ -6697,7 +6697,6 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 
 	total_devs = bioc->num_stripes;
 	bioc->orig_bio = first_bio;
-	bioc->private = first_bio->bi_private;
 	bioc->end_io = first_bio->bi_end_io;
 	bioc->fs_info = fs_info;
 	atomic_set(&bioc->stripes_pending, bioc->num_stripes);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 83075d6855db..384c483d2cef 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -311,6 +311,8 @@ struct btrfs_fs_devices {
 struct btrfs_bio {
 	unsigned int mirror_num;
 
+	struct btrfs_io_context *bioc;
+
 	/* @device is for stripe IO submission. */
 	struct btrfs_device *device;
 	u64 logical;
@@ -367,7 +369,6 @@ struct btrfs_io_context {
 	u64 map_type; /* get from map_lookup->type */
 	bio_end_io_t *end_io;
 	struct bio *orig_bio;
-	void *private;
 	atomic_t error;
 	int max_errors;
 	int num_stripes;
-- 
2.33.0

