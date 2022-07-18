Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67A577D36
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiGRILd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 04:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiGRILc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 04:11:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F9DCE32
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 01:11:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACA6F68AFE; Mon, 18 Jul 2022 10:11:27 +0200 (CEST)
Date:   Mon, 18 Jul 2022 10:11:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, naohiro.aota@wdc.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: align max_zone_append_size to the sector size
Message-ID: <20220718081127.GA29070@lst.de>
References: <20220714091609.2892621-1-hch@lst.de> <20220714125247.GJ15169@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714125247.GJ15169@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 14, 2022 at 02:52:47PM +0200, David Sterba wrote:
> > Fixes: 385ea2aea011 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Folded to the patch, thanks.

Turns out this is still broken as I was misled by the fancy ALIGN
macro.  We need the incremental change below.  Do you want to fold
this in again or should I sent it as a separate patch:


diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 606cd4aab3902..fb335e87b2212 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -740,7 +740,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size =
-		ALIGN(max_zone_append_size, fs_info->sectorsize);
+		ALIGN_DOWN(max_zone_append_size, fs_info->sectorsize);
 	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 	if (fs_info->max_zone_append_size < fs_info->max_extent_size)
 		fs_info->max_extent_size = fs_info->max_zone_append_size;
