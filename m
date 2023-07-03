Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D18745CCB
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 15:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjGCNDs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 09:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGCNDr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 09:03:47 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B02DD
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 06:03:41 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 9F8EC9B6FD; Mon,  3 Jul 2023 14:03:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1688389418;
        bh=XgtT/P/HD8eGgD+OfkJEUeJJu+k/Og+8QaG0phAH2mU=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=eLjn3ZU56iz+ArAvptv3dsEQ0YWX7QEoyIothz7xR9/9RkPDyE0P2hcWqfdtOrYmu
         I76mDC2YKTahel37ZEV+tDSWdMJ70UN/FRbwXiaVKSSWb+guf9PArWM8uzkUCEpnSh
         wTYdB1gp7Kbg2eGjXxAHFdQdvkUftsLDKnrznX7d9r/MMYR2aBAIQL9d7yZLZRhLwJ
         M5bzZLodNcgzpZlK2qKUHw6Rw9n5SjrbpS63mxL+jiuOXXcQzFz+ICK6/38iZLLdwj
         nPL/Bnmbis75kJLZ6hKlJRCaa0+JcQIXk/Ns2oXgZTj1qqhtnnpCSb58oJe10dkigQ
         bPglbrcSyZpeg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 5BF5E9B6FD;
        Mon,  3 Jul 2023 13:58:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1688389118;
        bh=XgtT/P/HD8eGgD+OfkJEUeJJu+k/Og+8QaG0phAH2mU=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=c4a0FNCJav4d5MPhTUTsSnVb80llOZvLlq617w+2cBX2oVX31Z33vjCpTvrQF4jai
         cd2ojTyrIICdbeYd13x7LjBaAqne7AW8JYGwd4nDaH838Z4OX/j3kwCt5+vlRUNlNC
         t1WzwZtqZvLiSMLHGYi7whBm5d35y6U7UJSzA3xtH1SFMsm9WEmvIybSTPAcTWeX9i
         I9E/9Nxgz0Re5am0lmT0KfOHiRQGWlEPzBCCve2Fa3tVZm/SbgOQS+oWjONwpaVTET
         atxQLH/pySKyxf98+mutEX6PLX2UvCrtfDgYCiCPtmqXICLdQkERHN5QC+1GMY3Tmr
         Ag3I2DRsMilyQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 0D580341CA7;
        Mon,  3 Jul 2023 13:58:38 +0100 (BST)
Message-ID: <fda86f3c-528c-9cd6-6228-d0278a73f138@cobb.uk.net>
Date:   Mon, 3 Jul 2023 13:58:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH 00/14] btrfs: scrub: introduce SCRUB_LOGICAL flag
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1688368617.git.wqu@suse.com>
In-Reply-To: <cover.1688368617.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/07/2023 08:32, Qu Wenruo wrote:
> [CHANGELOG]
> RFC->v1:
> - Add RAID56 support
>   Which is the biggest advantage of the new scrub mode.
> 
> - More basic tests around various repair situations
> 
> [REPO]
> Please fetch from github repo:
> https://github.com/adam900710/linux/tree/scrub_logical
> 
> This is based on David's misc-next, but still has one extra regression
> fix which is not yet merged. ("btrfs: raid56: always verify the P/Q
> contents for scrub")
> 
> [BACKGROUND]
> Scrub originally works in a per-device basis, that means if we want to
> scrub the full fs, we would queue a scrub for each writeable device.
> 
> This is normally fine, but some behavior is not ideal like the
> following:
> 		X	X+16K	X+32K
>  Mirror 1	|XXXXXXX|       |
>  Mirror 2	|       |XXXXXXX|
> 
> When scrubbing mirror 1, we found [X, X+16K) has corruption, then we
> will try to read from mirror 2 and repair using the correct data.
> 
> This applies to range [X+16K, X+32K) of mirror 2, causing the good copy
> to be read twice, which may or may not be a big deal.
> 
> But the problem can easily go crazy for RAID56, as its repair requires
> the full stripe to be read out, so is its P/Q verification, e.g.:
> 
> 		X	X+16K	X+32K
>  Data stripe 1	|XXXXXXX|       |	|	|
>  Data stripe 2	|       |XXXXXXX|	|	|
>  Parity stripe	|       |	|XXXXXXX|	|
> 
> In above case, if we're scrubbing all mirrors, we would read the same
> contents again and again:
> 
> Scrub on mirror 1:
> - Read data stripe 1 for the initial read.
> - Read data stripes 1 + 2 + parity for the rebuild.
> 
> Scrub on mirror 2:
> - Read data stripe 2 for the initial read.
> - Read data stripes 1 + 2 + parity for the rebuild.
> 
> Scrub on Parity
> - Read data stripes 1 + 2 for the data stripes verification
> - Read data stripes 1 + 2 + parity for the data rebuild
>   This step is already improved by recent optimization to use cached
>   stripes.
> - Read the parity stripe for the final verification
> 
> So for data stripes, they are read *five* times, and *three* times for
> parity stripes.
> 
> [ENHANCEMENT]
> Instead of the existing per-device scrub, this patchset introduce a new
> flag, SCRUB_LOGICAL, to do logical address space based scrub.
> 
> Unlike per-device scrub, this new flag would make scrub a per-fs
> operation.
> 
> This allows us to scrub the different mirrors in one go, and avoid
> unnecessary read to repair the corruption.
> 
> This means, no matter what profile, they always read the same data just
> once.
> 
> This also makes user space handling much simpler, just one ioctl to
> scrub the full fs, without the current multi-thread scrub code.

I have a comment on terminology. If I understand correctly, this flag
changes scrub from an operation performed in parallel on all devices, to
one done sequentially, with less parallelism.

The original code scrubs every device at the same time. In very rough
terms, for a filesystem with more devices than copies, the duration for
a scrub with no errors is the time taken to read every block on the most
occupied device. Other disks will finish earlier.

In the same case, the new code will take the time taken to read one
block from every file (not just those on the most occupied disk). It is
not clear to me how much parallelism will occur in this case.

I am not saying it isn't worth doing, but that it may be best to explain
it in terms of parallel vs. sequential rather than physical vs. logical.
Certainly in making the user documentation, and scrub command line,
clear to the user and possibly even in the naming of the flag (e.g.
SCRUB_SEQUENTIAL instead of SCRUB_LOGICAL).

> 
> [TODO]
> - More testing
>   Currently only done functional tests, no stress tests yet.
> 
> - Better progs integration
>   In theory we can silently try SCRUB_LOGICAL first, if the kernel
>   doesn't support it, then fallback to the old multi-device scrub.

Maybe not if my understanding is correct. On filesystems with more disks
than copies the new code may take noticeably longer?

Or do I misunderstand?

Graham

> 
>   But for current testing, a dedicated option is still assigned for
>   scrub subcommand.
> 
>   And currently it only supports full report, no summary nor scrub file
>   support.
> 
> Qu Wenruo (14):
>   btrfs: raid56: remove unnecessary parameter for
>     raid56_parity_alloc_scrub_rbio()
>   btrfs: raid56: allow scrub operation to update both P and Q stripes
>   btrfs: raid56: allow caching P/Q stripes
>   btrfs: raid56: add the interfaces to submit recovery rbio
>   btrfs: add the ability to read P/Q stripes directly
>   btrfs: scrub: make scrub_ctx::stripes dynamically allocated
>   btrfs: scrub: introduce the skeleton for logical-scrub
>   btrfs: scrub: extract the common preparation before scrubbing a block
>     group
>   btrfs: scrub: implement the chunk iteration code for scrub_logical
>   btrfs: scrub: implement the basic extent iteration code
>   btrfs: scrub: implement the repair part of scrub logical
>   btrfs: scrub: add RAID56 support for queue_scrub_logical_stripes()
>   btrfs: scrub: introduce the RAID56 data recovery path for scrub
>     logical
>   btrfs: scrub: implement the RAID56 P/Q scrub code
> 
>  fs/btrfs/disk-io.c         |    1 +
>  fs/btrfs/fs.h              |   12 +
>  fs/btrfs/ioctl.c           |    6 +-
>  fs/btrfs/raid56.c          |  134 +++-
>  fs/btrfs/raid56.h          |   17 +-
>  fs/btrfs/scrub.c           | 1198 ++++++++++++++++++++++++++++++------
>  fs/btrfs/scrub.h           |    2 +
>  fs/btrfs/volumes.c         |   50 +-
>  fs/btrfs/volumes.h         |   16 +
>  include/uapi/linux/btrfs.h |   11 +-
>  10 files changed, 1206 insertions(+), 241 deletions(-)
> 

