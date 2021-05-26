Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A707391D75
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 19:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhEZRCy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 13:02:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:33252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233676AbhEZRCy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 13:02:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622048481;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IqUFJiR1BUxfxyHwAR4l2oZd55nyMn5ow/XJZiWvM1U=;
        b=OR2WIrNmO09FqgXt4g03FhUUxpxaqWrRo9qPw0HqiRg6Gkb/cXAjTet+yZK5XxxVgqk6qh
        rq3aeVMcRSANtORHprOdJJ8pWJdJxILGzW/agfAwAnLW6NIfd985Ul57JmqGFDtRFvnWuT
        O6eUBWoytbKUVLVG2sEi+BHeQee2JGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622048481;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IqUFJiR1BUxfxyHwAR4l2oZd55nyMn5ow/XJZiWvM1U=;
        b=sg1CfayORbLqaJ76nHlLSOWC1ROoHZR/qV9G3vhJ7PXCDTluYF9bZUoAsNENIidIE3tE19
        sX/vux0sqikFaiBA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0F6BAB71;
        Wed, 26 May 2021 17:01:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1A48DA70B; Wed, 26 May 2021 18:58:44 +0200 (CEST)
Date:   Wed, 26 May 2021 18:58:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 8/9] btrfs: simplify eb checksum verification in
 btrfs_validate_metadata_buffer
Message-ID: <20210526165844.GI7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621961965.git.dsterba@suse.com>
 <6828072ccda5d55b9d130f48b750455ea728781b.1621961965.git.dsterba@suse.com>
 <0b51e0c9-896a-4ee2-f965-eec7b57cbd39@gmx.com>
 <20210526163139.GG7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526163139.GG7604@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 26, 2021 at 06:31:39PM +0200, David Sterba wrote:
> > > +	header = page_address(eb->pages[0]) +
> > > +		 get_eb_offset_in_page(eb, offsetof(struct btrfs_leaf, header));
> > 
> > It takes me near a minute to figure why it's not just
> > "get_eb_offset_in_page(eb, 0)".
> > 
> > I'm not sure if we really need that explicit way to just get 0,
> > especially most of us (and even some advanced users) know that csum
> > comes at the very beginning of a tree block.
> > 
> > And the mention of btrfs_leave can sometimes be confusing, especially
> > when we could have tree nodes passed in.
> 
> Ah right, I wanted to use the offsetof for clarity but that it could be
> used with nodes makes it confusing again. What if it's replaced by
> 
> 	get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
> 
> This makes it clear that it's the checksum and from the experience we
> know it's at offset 0. I'd rather avoid magic constants and offsets but
> you're right that everybody knows that the checksum is at the beginning
> of btree block.

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -584,7 +584,7 @@ static int validate_extent_buffer(struct extent_buffer *eb)
        const u32 csum_size = fs_info->csum_size;
        u8 found_level;
        u8 result[BTRFS_CSUM_SIZE];
-       const struct btrfs_header *header;
+       const u8 *header_csum;
        int ret = 0;
 
        found_start = btrfs_header_bytenr(eb);
@@ -609,14 +609,14 @@ static int validate_extent_buffer(struct extent_buffer *eb)
        }
 
        csum_tree_block(eb, result);
-       header = page_address(eb->pages[0]) +
-                get_eb_offset_in_page(eb, offsetof(struct btrfs_leaf, header));
+       header_csum = page_address(eb->pages[0]) +
+               get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
 
-       if (memcmp(result, header->csum, csum_size) != 0) {
+       if (memcmp(result, header_csum, csum_size) != 0) {
                btrfs_warn_rl(fs_info,
        "checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FMT " level %d",
                              eb->start,
-                             CSUM_FMT_VALUE(csum_size, header->csum),
+                             CSUM_FMT_VALUE(csum_size, header_csum),
                              CSUM_FMT_VALUE(csum_size, result),
                              btrfs_header_level(eb));
                ret = -EUCLEAN;
