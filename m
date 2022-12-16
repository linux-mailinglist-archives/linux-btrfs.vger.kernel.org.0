Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3189264F560
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Dec 2022 00:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLPX4H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 18:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLPX4G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 18:56:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714E3240BD
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 15:56:04 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oBx-1ojAuB29eH-00wnNZ; Sat, 17
 Dec 2022 00:55:59 +0100
Message-ID: <6e0313f1-fb8d-808a-3489-9bee83990bea@gmx.com>
Date:   Sat, 17 Dec 2022 07:55:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/8] Fixup uninitialized warnings and enable extra checks
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1671221596.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <cover.1671221596.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DnfDCsiy2PNuG+feCf+7+7knzvevRAnRACYZma0vflKlqunRcXY
 Q9eGtz0eQDslZinE8PDF/R490EJfFZtutNqFy6st0GK3HiUWJHWlv87tnDa8jAC7KM2KFGa
 LbXxrsjOOfp3W9msb8VFR5+e98EuE3XjnunNAGcPdluiy6Dl9CKa8ylv4NAGc20V/3zuvjI
 vaGWA2oQKTL4VxbtUVmbA==
UI-OutboundReport: notjunk:1;M01:P0:vKf39LrZP0k=;naKqkdBxeikk0wThfkPnFrt6i1i
 fizJdXO4D5U/bV1lNQHPe6t6y8rlFH2YTXkQv99R3vdKgopMtYjIRW6Kj2jWiT+H4YhWG3j4+
 OMb4WpddTqGSdowduRbqJy32u2KySBSC4EMJYT9iiDuyzKkGzfo+UieOYrPrYwBkglK0joSzy
 omYQTlXFj0zsz5rCGY+sB7qdStGsnV23LrVc0sAZC3GDe9oXnKU3IvlQoK4Wde5rryWmLlcA/
 qP4nD+MNsVWzHWBMtI8uDIVWpJQo34cb0UGJczFihkd5Y53eZsF+rlIOBwBhflqjdVPlBrrqv
 z5Z/CwFOt0ki/1ke0jVOBncCl6iBGhZuH10DdNPSpj5WmXZL068Rc5c41NewYf4cvfiDdaxDi
 zC/AZlRe56PtlmenuaQaQ72c+s1JktlS93X9ROZkxX8ak3yjQPtYn00DAMsOIVXJks8ZY/NFS
 yP0g9ogCLptA5pLbnhBXptUWlsL6wpTPRs7qrWZeCSItRI5Mhqlq3Z+/vpydDvxPnSNaW50JT
 hYhJfKjqbariXC+Mpu2TFmzdPugs9Hn73jccmXRymGkGM8DouQkO+g9b8ew8C04Z/tBM11UQC
 VKc+3C+BEzSe8IYUpGMkRU/j8lIInDPeoqWdwn3aOdakFbTic86l16VASk/qWZ2eB/S0CpdMm
 w4mq6cbr2DwgBPLQWj3EszoCvCOy4Wpx5vahl+KeguMx2vJLmI8oQ9cpg7WEnvvIETcKhGJ9d
 KeJq6u3+ZKT0KSwvK9i4gsLqwqhfHruNtIgFpfq+w/UlBcxe/jk2f88cjLBsb77V4jXoM7usA
 ogY4bbycqQ024aUdspR4aZA126s0fu56CxWvKMoJCOTbAh24TYQTcQWZWunVGJrtt5ptsp8Vy
 3tVfj0S2MafaZszc8ASh3D0JkSnbSp52Ya/OcWIi0cj8ZT2UOPuJHCmen3L530Gf3cAfVhO0c
 YyTlRbv95XsEAkffwWl7bONGSz8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/17 04:15, Josef Bacik wrote:
> Hello,
> 
> We had been failing the raid56 related scrub tests on our overnight tests since
> November.  Initially I asked Qu to look into these as I didn't have time to dig
> in, and he was unable to reproduce.  I assumed it was some oddity in my setup,
> so I ignored it.  However recently I got a report that I regressed some of these
> tests with an unrelated change.  When debugging it I found it was because of an
> uninitialized return value, which would have been caught by more modern gcc's
> with -Wmaybe-uninitialized.

Any clue which patch is fixing the raid0/raid1 scrub failures?

As locally, I found my aarch64/x86_64 VMs are all reporting scrub errors 
for all profiles, including RAID0/RAID1.
(The failure happens after patch "btrfs: do not check header generation 
in btrfs_clean_tree_block").

I didn't notice any of the patches touching the scrub path, or is there 
some hidden paths involved?

Thanks,
Qu

> 
> In order to avoid these sort of problems in the future lets fix up all the false
> positivies that this warning brings, and then enable the option for btrfs so we
> can avoid this style of failure in the future.  Thanks,
> 
> Josef
> 
> Josef Bacik (8):
>    btrfs: fix uninit warning in run_one_async_start
>    btrfs: fix uninit warning in btrfs_cleanup_ordered_extents
>    btrfs: fix uninit warning from get_inode_gen usage
>    btrfs: fix uninit warning in btrfs_update_block_group
>    btrfs: fix uninit warning in __set_extent_bit and convert_extent_bit
>    btrfs: extract out zone cache usage into it's own helper
>    btrfs: fix uninit warning in btrfs_sb_log_location
>    btrfs: turn on -Wmaybe-uninitialized
> 
>   fs/btrfs/Makefile         |  1 +
>   fs/btrfs/block-group.c    |  2 +-
>   fs/btrfs/disk-io.c        |  2 +-
>   fs/btrfs/extent-io-tree.c |  8 ++---
>   fs/btrfs/inode.c          |  2 +-
>   fs/btrfs/send.c           |  8 ++---
>   fs/btrfs/zoned.c          | 75 ++++++++++++++++++++++++---------------
>   7 files changed, 57 insertions(+), 41 deletions(-)
> 
