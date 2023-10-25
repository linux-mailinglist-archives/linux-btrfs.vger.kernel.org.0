Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81A47D7674
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 23:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjJYVQE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 25 Oct 2023 17:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYVQD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 17:16:03 -0400
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B26E132
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 14:15:59 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by shin.romanrm.net (Postfix) with SMTP id 3261A3F37B;
        Wed, 25 Oct 2023 21:15:54 +0000 (UTC)
Date:   Thu, 26 Oct 2023 02:15:51 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Balance on 5-disk RAID1 put all data on 2 disks, leaving the
 rest empty
Message-ID: <20231026021551.55802873@nvm>
In-Reply-To: <16acffd1-9704-9681-c2d4-4f5b8280ade0@georgianit.com>
References: <erRZVkhSqirieFSNm0d1BF5BemFMyUSCjGKT73prpKS7KDydKhqAvNqA7Eham7bQXmmh0CCx0rep6EAKKi_0itDlOf94KZ1zRRZfip_My4M=@protonmail.com>
 <16acffd1-9704-9681-c2d4-4f5b8280ade0@georgianit.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 25 Oct 2023 17:08:08 -0400
Remi Gauvin <remi@georgianit.com> wrote:

> On 2023-10-25 4:29 p.m., Peter Wedder wrote:
> > Hello,
> >
> > I had a RAID1 array on top of 4x4TB drives. Recently I removed one 4TB drive and added two 16TB drives to it. After running a full, unfiltered balance on the array, I am left in a situation where all the 4TB drives are completely empty, and all the data and metadata is on the 16TB drives. Is this normal? I was expecting to have at least some data on the smaller drives.
> >
> 
> Yes, this is normal.  The BTRFS allocates space in drives with the the
> most available free space.  The idea is to balance the 'unallocated'
> space on each drive, so they can be filled evenly.  The 4TB drives will
> be used when the 16TB dives have less than 4TB unallocated.

Interesting question and resolution. I'd be surprised by that as well.

Now, a great chance to "btrfs dev delete" all three remaining 4TB drives and
unplug them for the time being, to save on noise, heat and power consumption!

-- 
With respect,
Roman
