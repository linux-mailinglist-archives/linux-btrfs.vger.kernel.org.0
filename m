Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5318C4F06A4
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Apr 2022 01:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiDBXSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Apr 2022 19:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiDBXSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Apr 2022 19:18:06 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6DAE113E
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Apr 2022 16:16:13 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 710F72A3851; Sat,  2 Apr 2022 19:16:12 -0400 (EDT)
Date:   Sat, 2 Apr 2022 19:16:12 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Konstantinos Skarlatos <k.skarlatos@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Hugo Mills <hugo@carfax.org.uk>
Subject: Re: Adding a 4TB disk to a 2x4TB btrfs (data:single) filesystem and
 balancing takes extremely long (over a month). Filesystem has been deduped
 with bees
Message-ID: <YkjZPIZqsyS5+dZz@hungrycats.org>
References: <8a536fe1-68bd-4136-8cfb-bd410afc5fa1@gmail.com>
 <YkcIIFuxqj5l17Nu@hungrycats.org>
 <67609646-f896-4e69-5246-147a37ccf271@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67609646-f896-4e69-5246-147a37ccf271@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 02, 2022 at 09:27:00PM +0300, Konstantinos Skarlatos wrote:
> On 1/4/2022 5:11 μμ, Zygo Blaxell wrote:
> > As Hugo pointed out, it's not necessary to balance more than a few
> > block groups in this situation.  You have to ensure that the amount
> > of unallocated space on all the disks is large enough to contain one
> > mirror copy of the metadata.  For most users that means at most 0.5%
> > unallocated on each disk.  If you've already balanced 9% of the disk
> > then you've already done 18x more balancing than needed and you can
> > stop now.
> Thank you for your answer. I guess that this should be documented somehow in
> the wiki or the btrfs balance command or even better make a "btrfs
> balance-after-device-add" command that does the right thing because now it
> is very easy to assume that after adding a device one should wait for the
> complete
> balance to finish.

It would be a full-sized book to describe all the possible situations.
It's definitely not a solved problem on btrfs.

With knowledge of how the allocator algorithms work, we can develop
balance plans for specific situations.  In this case we can take a
short cut based on a special case, but every situation is different and
a balance plan has to be tailored for each case from first principles.
In some cases specialized software must be developed as the stock btrfs
balance algorithm cannot handle all cases.

e.g. in your case, if you intend to stay with these raid profiles,
then it's sufficient to balance 0.5%; however, if you want to move to
a striped data profile (e.g. raid0 or raid10) in the future, you are
better off doing a full balance now, as the stock balance code will
not be able to do a conversion to striped profiles if you allow the 5th
drive to fill now.  Full balance is recommended because it has the fewest
long-term surprises (but not zero!).

I'm on day 605 of balancing a 65TB filesystem--or day 30 of the 6th time
the balance has been restarted due to drive replacements.  The balances
don't have time to finish between drive replacements, so that filesystem
has been running balance continuously since it got larger than 33TB.
The stock btrfs balance algorithm can no longer make forward progress
with the current block group layout.  I've had to develop custom software
to continue growing the filesystem.
