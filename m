Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D8C777ABB
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 16:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjHJO3N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 10:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjHJO3M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 10:29:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AE8FA
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 07:29:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 575DA1F74D;
        Thu, 10 Aug 2023 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691677750;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NKY2R4KhuHnhlC8RSfsLGtkhBvKPZkuz0Wq7BELbNm0=;
        b=iZrjBhP8hL6ZTfNX5rAxW+wuCiTROo80BV8zfG8ELYIUwwmIUweSMqKSx1hjrrq1syY1fe
        KORdvZtKXAP2LrOWbWavyaFiPBUhCHgihpmU9YJwvWO30SKBzSjPnlKamRmPP1AmJ5EWaR
        JWlTZxdu3DlxxgS8fy3zUlgEqnM/ZQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691677750;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NKY2R4KhuHnhlC8RSfsLGtkhBvKPZkuz0Wq7BELbNm0=;
        b=3GyHSWJWqCWoZLnOfyYYNenAD//5FS4qd3GqmJRZP75N1bmjX6JlML2fOOiAvTfBWM5GJ+
        5IcIj58qoHiGKsAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 194CA138E0;
        Thu, 10 Aug 2023 14:29:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4YKHATb01GTkBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 14:29:10 +0000
Date:   Thu, 10 Aug 2023 16:22:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests/misc/058: reduce the space
 requirement and speed up the test
Message-ID: <20230810142245.GC2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <173e7faa9202a5d3438cd5bbdca765708f3bc729.1691477705.git.wqu@suse.com>
 <ZNOGCSts6w4tm9nI@twin.jikos.cz>
 <ZNOIAAevFOADA3Zi@twin.jikos.cz>
 <a52d535a-d2e7-48cf-a4b1-35d83e04027f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52d535a-d2e7-48cf-a4b1-35d83e04027f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 10, 2023 at 09:06:32AM +0800, Qu Wenruo wrote:
> On 2023/8/9 20:35, David Sterba wrote:
> > On Wed, Aug 09, 2023 at 02:26:49PM +0200, David Sterba wrote:
> >> On Tue, Aug 08, 2023 at 02:55:21PM +0800, Qu Wenruo wrote:
> >>> [BUG]
> >>> When I was testing misc/058, the fs still has around 7GiB free space,
> >>> but during that test case, btrfs kernel module reports write failures
> >>> and even git commands failed inside that fs.
> >>>
> >>> And obviously the test case failed.
> >>>
> >>> [CAUSE]
> >>> It turns out that, the test case itself would require 6GiB (4 data
> >>> disks) + 1.5GiB x 2 (the two replace target), thus it requires 9 GiB
> >>> free space.
> >>>
> >>> And obviously my partition is not that large and failed.
> >>
> >> The file sizes were picked so the replace is not too fast, this again
> >> depends on the system. Please add more space for tests.
> >>
> >>> [FIX]
> >>> In fact, we really don't need that much space at all.
> >>>
> >>> Our objective is to test "btrfs device replace --enqueue" functionality,
> >>> there is not much need to wait for 1 second, we can just do the enqueue
> >>> immediately.
> >>
> >> This depends on the system and the sleep might be needed if the first
> >> command does not start the first replace. The test is not testing just
> >> the --enqueue, but that two replaces can be enqueued on top each other.
> >> So we need the first one to start.
> >>
> >>> So this patch would reduce the file size to a more sane (and rounded)
> >>> 2GiB, and do the enqueue immediately.
> >>
> >> I'm not sure that the test would actually work as intended after the
> >> changes. The sleeps and dependency on system is fragile but we don't
> >> have anything better than to over allocate and provide enough time for
> >> the other commands to catch up.
> >
> > The reduced test still reliably verifies the fix so I'll apply it.
> > Thanks.
> 
> Despite the merge, I still want to discuss the principle behind the test
> cases.
> 
> Unlike fstests, we don't really have strong requirement on the disk
> sizes, thus most tests only go a 2GiB sparse file.
> 
> This leads to very loose disk size requirement, just like this case, we
> can easily go 6GiB (more accurate 9GiB) without any warning or checks in
> advance.
> 
> I believe the proper way to go in the future would be either:
> 
> - Add a proper size requirement check
>    Just like xfstests

For tests that require some minimum size eg. to create files the minimum
size would make sense and we can make them explicit in the tests but for
vast majority I think we can let it 2G.

Tests that work on multiple devices could make sure all the device sizes
will fit on the partition in advance. This can be done by the wrappers
so we would not need to change the tests.

> - Put more explicit recommends on the file sizes
>    We can recommend something like doing IO for 4sec, and only sleep for
>    1sec.

For tests that depend on timing, yes.

>    But unfortunate this is not future proof, as modern PCIE5 drives can
>    already go beyond 10GiB/s sequential writes.

Yeah, we'd need the tests scale to the the device throughput but either
it would have to be measured before the test (and depens on the system
load) or we'd have to guess the speed class by reading the device info,
which might not be obvious due to layering.

We can assume at least HDD based devices and SSD and scale the tests for
them. NVMe devices are too fast for some tests so we won't have the
coverage on them.

> Although for this particular case, I'm wondering if it's possible to do
> multiple enqueue calls? E.g:
> 
>    btrfs replace start --enqueue 2 $replace_dev1
>    btrfs replace start --enqueue 2 $replace_dev2
>    btrfs replace start --enqueue 2 $replace_dev1
> 
> If that's possible, I'd say it's better than any of the existing method.

Right this seems to be more reliable. I designed the test by following
the steps from the report, but the bug would be reproducibe by the above
sequence too.
