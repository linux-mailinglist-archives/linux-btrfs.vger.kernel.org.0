Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA39A775F2E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 14:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjHIMfQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 08:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjHIMfP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 08:35:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19AD1FCC
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 05:35:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA4742186F;
        Wed,  9 Aug 2023 12:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691584513;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ucDeOYBIHDB0eSvyKTRPIdhrrBQ0YEtwQdGiEVdBZ60=;
        b=Y2QGp5dM0QYmyrrs8l+LOx9/di5meBVEJY1+p9hdTvMHTc8kGH00gsvT7VbhMI/w1SLJds
        F82CzHaan7CObaLwdDd4NdsA96xWl6zQuyRDmTNKhUMvg5Y1HqgvzKS4MBgjnNwI4hQaLK
        OfGctgayaFQGid3TrxEvrVcDGa1DEFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691584513;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ucDeOYBIHDB0eSvyKTRPIdhrrBQ0YEtwQdGiEVdBZ60=;
        b=lg56lEnFhWgd9wu/QJdkh4Q9x0AeHJQQXE7x4Z7F/9r+mBGgjlXmSQyVZ0q/bgrHdCAqLm
        zsv+IHaxb1lQwQAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F72E133B5;
        Wed,  9 Aug 2023 12:35:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id weACIgGI02QkcwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 12:35:13 +0000
Date:   Wed, 9 Aug 2023 14:35:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests/misc/058: reduce the space
 requirement and speed up the test
Message-ID: <ZNOIAAevFOADA3Zi@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <173e7faa9202a5d3438cd5bbdca765708f3bc729.1691477705.git.wqu@suse.com>
 <ZNOGCSts6w4tm9nI@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNOGCSts6w4tm9nI@twin.jikos.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 09, 2023 at 02:26:49PM +0200, David Sterba wrote:
> On Tue, Aug 08, 2023 at 02:55:21PM +0800, Qu Wenruo wrote:
> > [BUG]
> > When I was testing misc/058, the fs still has around 7GiB free space,
> > but during that test case, btrfs kernel module reports write failures
> > and even git commands failed inside that fs.
> > 
> > And obviously the test case failed.
> > 
> > [CAUSE]
> > It turns out that, the test case itself would require 6GiB (4 data
> > disks) + 1.5GiB x 2 (the two replace target), thus it requires 9 GiB
> > free space.
> > 
> > And obviously my partition is not that large and failed.
> 
> The file sizes were picked so the replace is not too fast, this again
> depends on the system. Please add more space for tests.
> 
> > [FIX]
> > In fact, we really don't need that much space at all.
> > 
> > Our objective is to test "btrfs device replace --enqueue" functionality,
> > there is not much need to wait for 1 second, we can just do the enqueue
> > immediately.
> 
> This depends on the system and the sleep might be needed if the first
> command does not start the first replace. The test is not testing just
> the --enqueue, but that two replaces can be enqueued on top each other.
> So we need the first one to start.
> 
> > So this patch would reduce the file size to a more sane (and rounded)
> > 2GiB, and do the enqueue immediately.
> 
> I'm not sure that the test would actually work as intended after the
> changes. The sleeps and dependency on system is fragile but we don't
> have anything better than to over allocate and provide enough time for
> the other commands to catch up.

The reduced test still reliably verifies the fix so I'll apply it.
Thanks.
