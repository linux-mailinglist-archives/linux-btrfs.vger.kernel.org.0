Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8643576BE71
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 22:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHAUXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 16:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjHAUXJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 16:23:09 -0400
X-Greylist: delayed 497 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 13:23:08 PDT
Received: from box.sotapeli.fi (sotapeli.fi [IPv6:2001:41d0:302:2200::1c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1013A2683
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 13:23:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACEF87D91F;
        Tue,  1 Aug 2023 22:14:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sotapeli.fi; s=dkim;
        t=1690920887; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=mfcqpNZzkV2bjUXZjlqQ3DiUllMibxnn3UlgSe8064I=;
        b=nkMH3aBig2uGDccovLBBS0FRaE8v7g5Ad3KUT5M/BnZFPUzW2u2rncGekXw9JA30/1Hkvn
        ceuQM/QNoSpMxX4pL6nP96rWXmDezpzpwP9wk5bJTPqNcgZSKisPBYWHgwi6+GR7vVYlvS
        hlQqNNpj1QZS3T7WrSaDLYNgDlEUy8VKF9uA5nz3kOl5dfr9rln6bQ1E3Ora92qcygNXVi
        WCWIPlRJf/jreQ0xig2e5PrWcCA9K5T+CfUSVwUr90O0ykSoBHLALmIyqKOTnDFb66Hzky
        bC/gXPXxbusRm5sxhs1K6pKnKTFV2Zvz7XfnL/zu7WtzslANGmDlGesWhL0dhw==
Message-ID: <2d45a042-0c01-1026-1ced-0d8fdd026891@sotapeli.fi>
Date:   Tue, 1 Aug 2023 23:14:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] btrfs: scrub: improve the scrub performance
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1690542141.git.wqu@suse.com>
From:   Jani Partanen <jiipee@sotapeli.fi>
In-Reply-To: <cover.1690542141.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, I did some testing with 4 x 320GB HDD's. Meta raid1c4 and data 
raid 5.

Kernel  6.3.12

btrfs scrub start -B /dev/sdb

scrub done for 6691cb53-271b-4abd-b2ab-143c41027924
Scrub started:    Tue Aug  1 04:00:39 2023
Status:           finished
Duration:         2:37:35
Total to scrub:   149.58GiB
Rate:             16.20MiB/s
Error summary:    no errors found


Kernel 6.5.0-rc3

btrfs scrub start -B /dev/sdb

scrub done for 6691cb53-271b-4abd-b2ab-143c41027924
Scrub started:    Tue Aug  1 08:41:12 2023
Status:           finished
Duration:         1:31:03
Total to scrub:   299.16GiB
Rate:             56.08MiB/s
Error summary:    no errors found


So much better speed but Total to scrub reporting seems strange.

df -h /dev/sdb
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb        1,2T  599G  292G  68% /mnt


Looks like old did like 1/4 of total data what seems like right because 
I have 4 drives.

New did  about 1/2 of total data what seems wrong.

And if I do scrub against mount point:

btrfs scrub start -B /mnt/
scrub done for 6691cb53-271b-4abd-b2ab-143c41027924
Scrub started:    Tue Aug  1 11:03:56 2023
Status:           finished
Duration:         10:02:44
Total to scrub:   1.17TiB
Rate:             33.89MiB/s
Error summary:    no errors found


Then performance goes down to toilet and now Total to scrub reporting is 
like 2/1

btrfs version
btrfs-progs v6.3.3

Is it btrfs-progs issue with reporting? What about raid 5 scrub 
performance, why it is so bad?


About disks, they are old WD Blue drives what can do about 100MB/s 
read/write on average.


On 28/07/2023 14.14, Qu Wenruo wrote:
> [REPO]
> https://github.com/adam900710/linux/tree/scrub_testing
>
> [CHANGELOG]
> v1:
> - Rebased to latest misc-next
>
> - Rework the read IO grouping patch
>    David has found some crashes mostly related to scrub performance
>    fixes, meanwhile the original grouping patch has one extra flag,
>    SCRUB_FLAG_READ_SUBMITTED, to avoid double submitting.
>
>    But this flag can be avoided as we can easily avoid double submitting
>    just by properly checking the sctx->nr_stripe variable.
>
>    This reworked grouping read IO patch should be safer compared to the
>    initial version, with better code structure.
>
>    Unfortunately, the final performance is worse than the initial version
>    (2.2GiB/s vs 2.5GiB/s), but it should be less racy thus safer.
>
> - Re-order the patches
>    The first 3 patches are the main fixes, and I put safer patches first,
>    so even if David still found crash at certain patch, the remaining can
>    be dropped if needed.
>
> There is a huge scrub performance drop introduced by v6.4 kernel, that
> the scrub performance is only around 1/3 for large data extents.
>
> There are several causes:
>
> - Missing blk plug
>    This means read requests won't be merged by block layer, this can
>    hugely reduce the read performance.
>
> - Extra time spent on extent/csum tree search
>    This including extra path allocation/freeing and tree searchs.
>    This is especially obvious for large data extents, as previously we
>    only do one csum search per 512K, but now we do one csum search per
>    64K, an 8 times increase in csum tree search.
>
> - Less concurrency
>    Mostly due to the fact that we're doing submit-and-wait, thus much
>    lower queue depth, affecting things like NVME which benefits a lot
>    from high concurrency.
>
> The first 3 patches would greately improve the scrub read performance,
> but unfortunately it's still not as fast as the pre-6.4 kernels.
> (2.2GiB/s vs 3.0GiB/s), but still much better than 6.4 kernels (2.2GiB
> vs 1.0GiB/s).
>
> Qu Wenruo (5):
>    btrfs: scrub: avoid unnecessary extent tree search preparing stripes
>    btrfs: scrub: avoid unnecessary csum tree search preparing stripes
>    btrfs: scrub: fix grouping of read IO
>    btrfs: scrub: don't go ordered workqueue for dev-replace
>    btrfs: scrub: move write back of repaired sectors into
>      scrub_stripe_read_repair_worker()
>
>   fs/btrfs/file-item.c |  33 +++---
>   fs/btrfs/file-item.h |   6 +-
>   fs/btrfs/raid56.c    |   4 +-
>   fs/btrfs/scrub.c     | 234 ++++++++++++++++++++++++++-----------------
>   4 files changed, 169 insertions(+), 108 deletions(-)
>
