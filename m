Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4547A5066
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjIRRE7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 13:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjIRREf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 13:04:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33C3192
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 10:04:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 563702001F;
        Mon, 18 Sep 2023 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695056646;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cAzf71QvEYKSJEGcWDHFC6e+SPkSmPkG8pZx+Eus1bQ=;
        b=Z37TzTnpcDi7EDsInyNAyzmp7B8Aijg8deNgDF1SstYRBS8uVaZcqtZaVGbzNsaWor270l
        FOanUSWsNE3GvqfpCka1Ok6Pvy9npUGj1RKOTgBgHZ0OG8547WD7uQOOcMz8JmhOUcAsEz
        DD8myBkN3yl5gIsGTiecrosl5UA4Rok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695056646;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cAzf71QvEYKSJEGcWDHFC6e+SPkSmPkG8pZx+Eus1bQ=;
        b=JO5KDTl3C2NrPxwxWIG7mGG2g6dNlzQru7MTq9haCGwRwXrBLz+r/20dvFPMBhQ1NKh5cD
        lzXfUeUvgDEgJKBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24F771358A;
        Mon, 18 Sep 2023 17:04:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ESlpCAaDCGWjDQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Sep 2023 17:04:06 +0000
Date:   Mon, 18 Sep 2023 18:57:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Dan Carpenter <dan.carpenter@linaro.org>,
        wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: extent_io: do extra check for extent buffer
 read write functions
Message-ID: <20230918165730.GK2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b07914e7-137c-4549-97cb-2a0c3e757a04@moroto.mountain>
 <20230915190047.GH2747@twin.jikos.cz>
 <fd5920d6-f56d-443a-8b03-4dc34d488b62@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd5920d6-f56d-443a-8b03-4dc34d488b62@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 16, 2023 at 06:41:12AM +0930, Qu Wenruo wrote:
> 
> 
> On 2023/9/16 04:30, David Sterba wrote:
> > On Fri, Sep 15, 2023 at 10:10:13AM +0300, Dan Carpenter wrote:
> >> Hello Qu Wenruo,
> >>
> >> The patch f98b6215d7d1: "btrfs: extent_io: do extra check for extent
> >> buffer read write functions" from Aug 19, 2020 (linux-next), leads to
> >> the following Smatch static checker warning:
> >>
> >> fs/btrfs/print-tree.c:186 print_uuid_item() error: uninitialized symbol 'subvol_id'.
> >> fs/btrfs/tests/extent-io-tests.c:338 check_eb_bitmap() error: uninitialized symbol 'has'.
> >> fs/btrfs/tests/extent-io-tests.c:353 check_eb_bitmap() error: uninitialized symbol 'has'.
> >> fs/btrfs/uuid-tree.c:203 btrfs_uuid_tree_remove() error: uninitialized symbol 'read_subid'.
> >> fs/btrfs/uuid-tree.c:353 btrfs_uuid_tree_iterate() error: uninitialized symbol 'subid_le'.
> >> fs/btrfs/uuid-tree.c:72 btrfs_uuid_tree_lookup() error: uninitialized symbol 'data'.
> >> fs/btrfs/volumes.c:7415 btrfs_dev_stats_value() error: uninitialized symbol 'val'.
> >>
> >> fs/btrfs/extent_io.c
> >>    4096  void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
> >>    4097                          unsigned long start, unsigned long len)
> >>    4098  {
> >>    4099          void *eb_addr = btrfs_get_eb_addr(eb);
> >>    4100
> >>    4101          if (check_eb_range(eb, start, len))
> >>    4102                  return;
> >>                          ^^^^^^^
> >>
> >> Originally this used to memset dstv to zero but now it just returns.
> >> I can easily just mark that error path as impossible.  These days
> >> everyone with a brain zeros their stack variables anyway so it shouldn't
> >> affect anyone who doesn't deserve it.
> >
> > Thanks, this explains the other errors reported on linux-next with
> > possibly uninitialized variables.
> 
> Mind me to fix those uninitialized variables?
> Or should I just revert to the old behavior?

I'd like to keep the branch in for-next so please fix the warnings. Also
please s/continuous/contiguous/. We can then continue the discussion
regarding the allocator behaviour.
