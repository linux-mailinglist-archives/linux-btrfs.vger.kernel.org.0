Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F6772A309
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 21:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjFITY5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjFITYy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 15:24:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A94A2D44
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 12:24:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A45E11FE12;
        Fri,  9 Jun 2023 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686338690;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5NYWdK6RzFsxMFRdbbRQBsH+7x5Y9o7eYRTfBw5uLfU=;
        b=xDWj+NjZE6jurO9wAkx2WGeSk4kzZLUx23Ei/4TXvu8dajXaquxfbMrKhwHtoRH2Tme2L3
        J5j9UIbWKQ+f8ojTzQ+O18b5kMM0XnNyiZYlLX9nUVOp9RE/2bzCpqj1rf8rT1HGuy2v0e
        C7OQwHqtx6YEX76xT254c0v8hqU7fDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686338690;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5NYWdK6RzFsxMFRdbbRQBsH+7x5Y9o7eYRTfBw5uLfU=;
        b=TIpmUL7PKSFe771LvlnwjEzAw7VItR3IidUxqA9Mv88RqFDYYA111o9eFtGfRWR+8eFUYO
        tPi4M2TK/nKbvmAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8F0CA2C141;
        Fri,  9 Jun 2023 19:24:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DD7BEDA85A; Fri,  9 Jun 2023 21:18:34 +0200 (CEST)
Date:   Fri, 9 Jun 2023 21:18:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: allocate dummy ordereded_sums objects for nocsum
 I/O on zoned file systems
Message-ID: <20230609191834.GE12828@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230608121410.275766-1-hch@lst.de>
 <20230608121410.275766-2-hch@lst.de>
 <20230608154015.GK28933@twin.jikos.cz>
 <20230609045516.GA31024@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609045516.GA31024@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 09, 2023 at 06:55:16AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 08, 2023 at 05:40:15PM +0200, David Sterba wrote:
> > This patch is still in the devlopment queue so I don't want to do a
> > separate fix. Please send an incremental update that cleanly applies to
> > the patch.
> > 
> > There's a minor conflict in context of btrfs_finish_ordered_zoned in
> > zoned.c which only sets up the fs_info, so trivial to fix but the new
> > helper btrfs_alloc_dummy_sum() uses bbio->ordered which is not available
> > at this time and was added in a different series ("btrfs: add an
> > ordered_extent pointer to struct btrfs_bio").
> > 
> > Due to that there may be a cascading change needed in other patches in
> > misc-next but that should be fixable, the logic of adding bbio::ordered
> > is clear.
> 
> Ok.  Here is a stash of patches:
> 
>  1) incremental diff
>  2) complete replacement for that commit with the incremental
>     diff included
> 
> And then new version of the two later patches affected by the squashing:
> 
>  3) btrfs: defer splitting of ordered extents until I/O completion
>  4) btrfs: add an ordered_extent pointer to struct btrfs_bio
> 
> A git tree with all this is also available here:
> 
>     git://git.infradead.org/users/hch/misc.git btrfs-zoned-fixes

Thanks. I used the patches in the mail, I can't pull from infradead
(it.infradead.org[0: ...]: errno=Connection refused) so I at least
compared the committed versions against the patches. Misc-next updated
and pushed but I haven't tested it yet.
