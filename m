Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CD07127AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 15:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbjEZNf6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243408AbjEZNf5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 09:35:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FEBB2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 06:35:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB5AB6732A; Fri, 26 May 2023 15:35:51 +0200 (CEST)
Date:   Fri, 26 May 2023 15:35:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 13/21] btrfs: don't use btrfs_bio_ctrl for extent
 buffer writing
Message-ID: <20230526133551.GA8803@lst.de>
References: <20230503152441.1141019-1-hch@lst.de> <20230503152441.1141019-14-hch@lst.de> <20230523184541.GZ32559@twin.jikos.cz> <20230524055003.GB19255@lst.de> <20230526131549.GB14830@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526131549.GB14830@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 26, 2023 at 03:15:49PM +0200, David Sterba wrote:
> Until we know for sure I'd rather keep the call, so something like that
> (untested):

Yes.  I have something similar, but I didn't manage to get around to
testing either as I'm at a conference right now.

Comments below:

> +++ b/fs/btrfs/extent_io.c
> @@ -1833,6 +1833,8 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
>                         wbc->nr_to_write--;
>                 }
>                 __bio_add_page(&bbio->bio, p, eb->len, eb->start - page_offset(p));
> +               if (bio_ctrl->wbc)
> +                       wbc_account_cgroup_owner(bio_ctrl->wbc, p, len);

wbc is always non-NULL in write_one_eb, no need for a conditional
here or in the other branch.

> @@ -4090,9 +4094,15 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>         if (eb->fs_info->nodesize < PAGE_SIZE) {
>                 __bio_add_page(&bbio->bio, eb->pages[0], eb->len,
>                                eb->start - page_offset(eb->pages[0]));
> +               if (bio_ctrl->wbc)
> +                       wbc_account_cgroup_owner(bio_ctrl->wbc, eb->pages[0], len);

.. and the read side never has one.

For the write side we'll also need calls to bio_set_dev and wbc_init_bio.
I plan take care of all of this including testing over the weekend.
