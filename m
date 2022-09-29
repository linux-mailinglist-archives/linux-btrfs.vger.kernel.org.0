Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41B5EF4F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiI2MJk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Sep 2022 08:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbiI2MJj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Sep 2022 08:09:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CE16459;
        Thu, 29 Sep 2022 05:09:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5D33621B5D;
        Thu, 29 Sep 2022 12:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664453376;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ea/4qVl20+XCJ10+De70avpbYiZgH7IfNIdGMrVYSik=;
        b=xFJbI7UldYocDcZWCwpLoMLVY4j8zmk1BhO3ojg78BktUMuDXS1+QI4fyHy1TW2FLvUWwN
        88ZfEWhF2Lh5rQYaFF0wSmXEADICTm5ZrrP518GlJq5zyBy4d9HwR47/CJTvoIIh54FlAL
        DHofe/FcCJXe78xlU2Xc/sEI6FHG9lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664453376;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ea/4qVl20+XCJ10+De70avpbYiZgH7IfNIdGMrVYSik=;
        b=OE6/4dZOcpUymA2GsNyfwxhp62N1uRdpOj04dmGqcf5mHZE6fqxOSLxdjd+onsoEi3o/Wn
        keiki0w/6kDFavDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DAC913A71;
        Thu, 29 Sep 2022 12:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xadJCgCLNWNgAgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Sep 2022 12:09:36 +0000
Date:   Thu, 29 Sep 2022 14:04:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: test active zone tracking
Message-ID: <20220929120400.GG13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1664419525.git.naohiro.aota@wdc.com>
 <7390d3a918ce574d5349d31ab26fed0ae79952a9.1664419525.git.naohiro.aota@wdc.com>
 <20220929060106.dy7enioljc3hi3lt@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929060106.dy7enioljc3hi3lt@zlang-mailbox>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 29, 2022 at 02:01:06PM +0800, Zorro Lang wrote:
> On Thu, Sep 29, 2022 at 01:19:25PM +0900, Naohiro Aota wrote:
> > A ZNS device limits the number of active zones, which is the number of
> > zones can be written at the same time. To deal with the limit, btrfs's
> > zoned mode tracks which zone (corresponds to a block group on the SINGLE
> > profile) is active, and finish a zone if necessary.
> > 
> > This test checks if the active zone tracking and the finishing of zones
> > works properly. First, it fills <number of max active zones> zones
> > mostly. And, run some data/metadata stress workload to force btrfs to use a
> > new zone.
> > 
> > This test fails on an older kernel (e.g, 5.18.2) like below.
> > 
> > btrfs/292
> > [failed, exit status 1]- output mismatch (see /host/btrfs/292.out.bad)
> >     --- tests/btrfs/292.out     2022-09-15 07:52:18.000000000 +0000
> >     +++ /host/btrfs/292.out.bad 2022-09-15 07:59:14.290967793 +0000
> >     @@ -1,2 +1,5 @@
> >      QA output created by 292
> >     -Silence is golden
> >     +stress_data_bgs failed
> >     +stress_data_bgs_2 failed
> >     +failed: '/bin/btrfs subvolume snapshot /mnt/scratch /mnt/scratch/snap825'
> >     +(see /host/btrfs/292.full for details)
> >     ...
> >     (Run 'diff -u /var/lib/xfstests/tests/btrfs/292.out /host/btrfs/292.out.bad'  to see the entire diff)
> > 
> > The failure is fixed with a series "btrfs: zoned: fix active zone tracking
> > issues" [1] (upstream commits from 65ea1b66482f ("block: add bdev_max_segments()
> > helper") to 2ce543f47843 ("btrfs: zoned: wait until zone is finished when
> > allocation didn't progress")).
> 
> If this's a regression test case for known fix, we'd better to use:
> _fixed_by_kernel_commit 65ea1b66482f block: add bdev_max_segments (patchset)

This is very misleading as the commit only adds a helper that's used in
later commits. If anything, the last commit in the series should be
mentioned.
