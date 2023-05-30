Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D719716CE7
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 20:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjE3Sy4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 14:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjE3Syy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 14:54:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6289111F
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 11:54:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C63E31F37F;
        Tue, 30 May 2023 18:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685472883;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZSpfXftG4yhU/r3JZOeCJzjDMR3/hY+gjZjuJ69hKIk=;
        b=FYVB8A2xHv0IXG9pV+duI+EFrixov0pFYHqNATe+f4YYX74O74CM4HnWOWyz0xLz6SH8cz
        toE2+kLh1wZMI30212m9VCWGxDf11U4vY/1QcNCioglzOmeTShx7PEEtPPPpni17MXJwc5
        CqUqDyYyL4fulIhNxTuo0V0Bpjz7Mas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685472883;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZSpfXftG4yhU/r3JZOeCJzjDMR3/hY+gjZjuJ69hKIk=;
        b=47n1XF2zAM+AhZrAT5mYehsGHv6JyTidoc2nnUjpagVsK7UOFCsHbG6TJVWrdBJQ1cIv/V
        +Lk51Gf+Ljwfd/AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 978A113597;
        Tue, 30 May 2023 18:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kpdZJHNGdmQneAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 18:54:43 +0000
Date:   Tue, 30 May 2023 20:48:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: don't split ordered_extents for zoned writes at I/O submission
 time
Message-ID: <20230530184832.GB32581@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230524150317.1767981-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524150317.1767981-1-hch@lst.de>
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

On Wed, May 24, 2023 at 05:03:03PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes the unconditional splitting of ordered extents for
> zoned writes at I/O submission time, and instead splits them only when
> actually needed in the I/O completion handler.
> 
> This something I've been wanting to do for a while as it is a lot more
> efficient, but it is also really needed to make the ordered_extent
> pointer in the btrfs_bio work for zoned file systems, which made it a bit
> more urgent.  This series also borrow two patches from the series that
> adds the ordered_extent pointer to the btrfs_bio.
> 
> Currently due to the submission time splitting, there is one extra lookup
> in both the ordered extent tree and inode extent tree for each bio
> submission, and extra ordered extent lookup in the bio completion
> handler, and two extent tree lookups per bio / split ordered extent in
> the ordered extent completion handler.  With this series this is reduced
> to a single inode extent tree lookup for the best case, with an extra
> inode extent tree and ordered extent lookup when a split actually needs
> to occur due to reordering inside an ordered_extent.
> 
> Diffstat:
>  bio.c          |   20 -----
>  bio.h          |   17 +++-
>  btrfs_inode.h  |    2 
>  extent_map.c   |  101 ++++++++++++++++++++++++++--
>  extent_map.h   |    6 -
>  file-item.c    |   15 +++-
>  fs.h           |    2 
>  inode.c        |  138 +++++++-------------------------------
>  ordered-data.c |  205 +++++++++++++++++++++++++++++++++++----------------------
>  ordered-data.h |   22 ++----
>  relocation.c   |    4 -
>  tree-log.c     |   12 +--
>  zoned.c        |   94 ++++++++++++++------------
>  zoned.h        |    6 -
>  14 files changed, 352 insertions(+), 292 deletions(-)

Added to misc-next, thanks. The left out patches and the adjustments are
commented under the patches. I haven't tested this much yet but overall
it's straightforward and is more relevant for zoned.
