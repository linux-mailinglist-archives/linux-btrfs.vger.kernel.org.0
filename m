Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2B15B0B7E
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 19:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiIGR34 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIGR3x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 13:29:53 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9F82A949
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 10:29:52 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id m9so8585627qvv.7
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 10:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Dbd1iJCP+wKIkjs/rXIG+AAYcVLBZFkF/eQX+mk+0sM=;
        b=Vigq4idLafRKdGB5O1jNDCZG9TvouzP3XuEcsvidDkQMA2B+92wQOPA02/ZpAZsOrk
         navZVd/Fubb8V5y1zKX5eBlTJs3hHWdEfysltMWaPCfFpRfKOBZEgoXoHcokOY384Y81
         b8QDSNYjQ24HdVYE7uC3guJcaJNZcXLFSq1fZx6nSrFm7/xCoOHBKHguaaw8QLxvo1qj
         bddIUajSjL6YYhSx1SBRLOmKORZ5Z1/AvEn4UY1iO+AIRQiyMYTWy7XTWpVgnRGoGKz4
         uQvWWnyJGgHwZYMSFex1xtvirZyHKP3q8lVhsCD05mpsl0d2ye8pvSyoO93pzkGsVn1a
         8v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Dbd1iJCP+wKIkjs/rXIG+AAYcVLBZFkF/eQX+mk+0sM=;
        b=YncbVFZ7ox/ngr/NVqrw3spfnsRf/dL+gLGa/aEKAy/kI79QRA7H4IufCcGv4APutz
         RZUUFMmu8UO5vCJacXOgFVKpKPliw1R7phEYXRlQyVS+sKURNywYZKrVp+WYYAOJUwWs
         Of5Lo4BualNHepf+qLUtGBjXkdqQ6uixKoEYglK5ErAZiZSRtLFDstmE4pGk4zP0HC4W
         lazoMU8DziE3AVBj3mssCysBZsQzRaGaAONZ7zoPEj2zOQHapSefeaKJYnjNAQD2n7AJ
         NZjluvfyIKAlsbXbBQX7/bUXYli5qcL1VU0gE6L3Vg9XGr3hV8wRQZRlJ0932QvSOjCt
         qdZA==
X-Gm-Message-State: ACgBeo1/NDcE4+euHLN1kqjcTbNRO3kldc+540ECRBahSTnuV4Cxc+f5
        NrXmHxCoG+0pXgQxGcElePprVAlZQWfoxu5p
X-Google-Smtp-Source: AA6agR7LYorI3ZFWHQ1cqU1vXBs3NzKs7mogjOWjY3B0cw7+vdY1NhhgimqDQruyXJn08xhMup/p8g==
X-Received: by 2002:ad4:5947:0:b0:499:5c62:964c with SMTP id eo7-20020ad45947000000b004995c62964cmr4002902qvb.87.1662571791608;
        Wed, 07 Sep 2022 10:29:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t2-20020a37ea02000000b006bbc09af9f5sm14675039qkj.101.2022.09.07.10.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:29:50 -0700 (PDT)
Date:   Wed, 7 Sep 2022 13:29:49 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't update the block group item if used bytes
 are the same
Message-ID: <YxjVDY7jIH3Vv/il@localhost.localdomain>
References: <64e4434370badd801a79a782613c405830475dde.1657521468.git.wqu@suse.com>
 <YxirXjl1Ur3VV3B6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxirXjl1Ur3VV3B6@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 07, 2022 at 10:31:58AM -0400, Josef Bacik wrote:
> On Mon, Jul 11, 2022 at 02:37:52PM +0800, Qu Wenruo wrote:
> > When committing a transaction, we will update block group items for all
> > dirty block groups.
> > 
> > But in fact, dirty block groups don't always need to update their block
> > group items.
> > It's pretty common to have a metadata block group which experienced
> > several CoW operations, but still have the same amount of used bytes.
> > 
> > In that case, we may unnecessarily CoW a tree block doing nothing.
> > 
> > This patch will introduce btrfs_block_group::commit_used member to
> > remember the last used bytes, and use that new member to skip
> > unnecessary block group item update.
> > 
> > This would be more common for large fs, which metadata block group can
> > be as large as 1GiB, containing at most 64K metadata items.
> > 
> > In that case, if CoW added and the deleted one metadata item near the end
> > of the block group, then it's completely possible we don't need to touch
> > the block group item at all.
> > 
> > I don't have any benchmark to prove this, but this should not cause any
> > hurt either.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> I've been seeing random btrfs check failures on our overnight testing since this
> patch was merged.  I can't blame it directly yet, I've mostly seen it on
> TEST_DEV, and once while running generic/648.  I'm running it in a loop now to
> reproduce and then fix it.
> 
> We can start updating block groups before we're in the critical section, so we
> can update block_group->bytes_used while we're updating the block group item in
> a different thread.  So if we set the block_group item to some value of
> bytes_used, then update it in another thread, and then set ->commit_used to the
> new value we'll fail to update the block group item with the correct value
> later.
> 
> We need to wrap this bit in the block_group->lock to avoid this particular
> problem.  Once I reproduce and validate the fix I'll send that, but I wanted to
> reply in case that takes longer than I expect.  Thanks,

Ok this is in fact the problem, this fixup made the problem go away.  Thanks,

Josef

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6e7bb1c0352d..1e2773b120d4 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2694,10 +2694,16 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
+	u64 used;
 
 	/* No change in used bytes, can safely skip it. */
-	if (cache->commit_used == cache->used)
+	spin_lock(&cache->lock);
+	used = cache->used;
+	if (cache->commit_used == used) {
+		spin_unlock(&cache->lock);
 		return 0;
+	}
+	spin_unlock(&cache->lock);
 
 	key.objectid = cache->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
@@ -2712,13 +2718,14 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	btrfs_set_stack_block_group_used(&bgi, cache->used);
+
+	btrfs_set_stack_block_group_used(&bgi, used);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
 						   cache->global_root_id);
 	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
 	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
-	cache->commit_used = cache->used;
+	cache->commit_used = used;
 fail:
 	btrfs_release_path(path);
 	return ret;
