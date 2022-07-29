Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3C05849EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 04:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiG2Cuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 22:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiG2Cu1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 22:50:27 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C25166D57E
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 19:50:23 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 8E824463A35; Thu, 28 Jul 2022 22:50:22 -0400 (EDT)
Date:   Thu, 28 Jul 2022 22:50:22 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: misc-next/for-next: bad key order during log replay
Message-ID: <YuNK7vBkL7D9b+H7@hungrycats.org>
References: <Yt2kU0CEkX5DRFhN@hungrycats.org>
 <20220727194400.GZ13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727194400.GZ13489@twin.jikos.cz>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 27, 2022 at 09:44:00PM +0200, David Sterba wrote:
> On Sun, Jul 24, 2022 at 03:58:11PM -0400, Zygo Blaxell wrote:
> > Test case is running all of these at the same time in a loop:
> > 
> > 	- rename log tree test from
> > 	https://lore.kernel.org/linux-btrfs/YdDsAl0bx6DLZT+i@hungrycats.org/
> > 
> > 	- continuous metadata balances to keep delayed ref queue full
> > 
> > 	- 20x rsync writing to the filesystem to keep the page cache full
> > 
> > 	- crash the VM after 30 minutes uptime
> 
> Thanks for the detailed report, this should be fixed by
> https://lore.kernel.org/linux-btrfs/2afa2744e3ea3a2290ab683cac51907ef10f8582.1658332827.git.josef@toxicpanda.com/
> 
> and it's been added to misc-next a few days ago. It's a separate patch
> not merged with the one that possibly caused it.

Thanks.  I confirmed it fixes my test case with two test kernels:

	1. Monday's misc-next update (4f99f01f613b6 "btrfs: don't
	call btrfs_page_set_checked in finish_compressed_bio_read")
	which already includes this patch.

	2. The old for-next kernel from the bug report (ba37a9d53d71
	"Merge branch 'for-next-next-v5.19-20220721' into
	for-next-20220721") with this patch applied.

In both cases after 25 crash cycles there was no sign of the bug.
