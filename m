Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8926A10E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 20:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBWTzA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 14:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBWTy7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 14:54:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341D755072
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 11:54:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 847715F7BC;
        Thu, 23 Feb 2023 19:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677182095;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4+1iFxiuHjmsAeTLpdC8qBYY06FZtL6VjMhOFrU9C4=;
        b=CYw+0adRtHXdbUiqy9yotPeWkiMhvKhm6riOK+nUTJFBNHLKisHnlLV4S6NK2tNr0JfriE
        8MNAVIofW4oeo4hlSx8B5FUT0mWFZ16hwBBxuAuudBzGMhYR4QDcl1VKh5XvZJ9jxwpk6m
        BX3d5DlbXE4ghG/OivQQAU3XryG9k/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677182095;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4+1iFxiuHjmsAeTLpdC8qBYY06FZtL6VjMhOFrU9C4=;
        b=tAlMEam3Rk0WKom7H9d3cG6Lacknqnj7yTW/2qjTVRvVzlh8U+NxTX+cUPbPCf/5zy4tOL
        5jtnx9e8jtFLS7BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C14E139B5;
        Thu, 23 Feb 2023 19:54:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T1yLEY/E92OVTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Feb 2023 19:54:55 +0000
Date:   Thu, 23 Feb 2023 20:48:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Filipe Manana <fdmanana@kernel.org>, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: fix dio continue after short write due to
 buffer page fault
Message-ID: <20230223194858.GX10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1677026757.git.boris@bur.io>
 <b064d09d94fb2a15ad72427962df400e37788d0c.1677026757.git.boris@bur.io>
 <CAL3q7H5rq9c2yXR6YqUCxoi1LQq-vTYAz0Eoxe1MxULsKKZ_bw@mail.gmail.com>
 <Y/YpF/CKp+/hUBVL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/YpF/CKp+/hUBVL@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 22, 2023 at 06:39:19AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 22, 2023 at 11:51:44AM +0000, Filipe Manana wrote:
> > >  ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
> > >  {
> > > -       struct btrfs_dio_data data;
> > > +       struct btrfs_dio_data data = { };
> > 
> > Btw, everywhere else we use the { 0 } style, so we should, ideally, be
> > consistent and use it here too.
> 
> The empty initializer is just a newer C feature that hasn't caught on
> everywhere yet.  It has the advantage of not creating a compile failure
> when a new first member gets added that can't be assigned to (or
> a sparse warning when it is a pointer).  It has not downsides over
> the 0 initializer and should be used everywhere eventually.

We almost did that namely due to gcc 4.9 producing incomplete
initialization with { 0 } but meanwhile the minimum version has been
increased to 5.1 [1] and we've settled on { 0 } as it's the most common
initiazlier.

[1] https://lore.kernel.org/linux-btrfs/20220208170044.GD12643@twin.jikos.cz/
