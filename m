Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846FA5B1E76
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 15:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiIHNR2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 09:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiIHNRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 09:17:24 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C8AE72DC
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 06:17:22 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a10so12782897qkl.13
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Sep 2022 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=oxQEq8027M9nY2L1H0HBXrjozxnRg5z3HlNF2xYF5QI=;
        b=pgImwPaPsPcdlAK9Jn1qOGJH3W4TnC4TXB61NApD38QG5ImXWaHkL80ux41h68TkiZ
         mNVYdTvkv9PP3pI1mC4IlCVyv6SfxWHn9pRbVJ2E4ntY6TmHIcu2jWCsdSVhvnFhglTf
         R/Zqf4zIRJvWT9P6ZpaSeBoJ5YiE+ogpqOlbREUCWznqLOds1LkGjHoWZnYH7+cNR36J
         Kmu5LoVI03FW61c5u7EpQKoLAv8F6nKnpNqa7Eia/MowRLV3XD/hKr2xhkZqlgN78pIX
         iWWlOMyi3R9UFcZMEQVU5+/jE9iPwzX07E9Lx2YcMdFuokrUCO29Gg6PTVg2H3Hiypql
         tw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oxQEq8027M9nY2L1H0HBXrjozxnRg5z3HlNF2xYF5QI=;
        b=wz+DKtPR59W+8dLea+Q75oiXR/eI/lLjvzCvLfmqoNvWuMVg7DHTuAEaHlK7wsi1gs
         i+Ahnt8p4DfTI5FjZwXAMIlvOmUtiu7pD1PEGea+MggY722YeADXIoT7q/TP8tzlUFBJ
         tSJhVeXC+IgPn0UfARHLs0jPWklkZK6VFPXTrhuNJsjbelAtNqje5GXIUbA0reVAykZr
         TDqvU8sxSr+y8POH93WmKj4BXhlWoHC1jASYKJSmskeft1csajQ9Z7U7TIsLikwV3/Qd
         y+HLJVWhoHJ1AKFE6R+sJDQS/g3RGqThFMIjwXVPCHY6qunnEnAxoHW6PLD4SrRxhNhR
         Y4Uw==
X-Gm-Message-State: ACgBeo1Beflp4DIuLRTrtYR67Q8/SaAAOX1AVIW+bZowUmgGiTBa7ZKo
        1VCCHvXJeY35G5dmhtsey+oRc2Q3vAMZdw==
X-Google-Smtp-Source: AA6agR6Y/rECw/+vk6yLVHNYj3e7kWquZ8xWccr3cTZQlrm1gr83tNkMDpRcHrh/QJ3J9SCeHXO2Vg==
X-Received: by 2002:a05:620a:4305:b0:6be:74ee:f021 with SMTP id u5-20020a05620a430500b006be74eef021mr6362207qko.422.1662643040500;
        Thu, 08 Sep 2022 06:17:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v4-20020a05620a440400b006af1f0af045sm18413660qkp.107.2022.09.08.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:17:19 -0700 (PDT)
Date:   Thu, 8 Sep 2022 09:17:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: don't update the block group item if used
 bytes are the same
Message-ID: <YxnrXj7GqhPg7vRa@localhost.localdomain>
References: <bf157be545a0ad97897b33be983284a4f63a5e0f.1662618779.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf157be545a0ad97897b33be983284a4f63a5e0f.1662618779.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 08, 2022 at 02:33:48PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> 
> When committing a transaction, we will update block group items for all
> dirty block groups.
> 
> But in fact, dirty block groups don't always need to update their block
> group items.
> It's pretty common to have a metadata block group which experienced
> several CoW operations, but still have the same amount of used bytes.
> 
> In that case, we may unnecessarily CoW a tree block doing nothing.
> 
> [ENHANCEMENT]
> 
> This patch will introduce btrfs_block_group::commit_used member to
> remember the last used bytes, and use that new member to skip
> unnecessary block group item update.
> 
> This would be more common for large fs, which metadata block group can
> be as large as 1GiB, containing at most 64K metadata items.
> 
> In that case, if CoW added and the deleted one metadata item near the end
> of the block group, then it's completely possible we don't need to touch
> the block group item at all.
> 
> [BENCHMARK]
> 
> To properly benchmark how many block group items we skipped the update,
> I added some members into btrfs_tranaction to record how many times
> update_block_group_item() is called, and how many of them are skipped.
> 
> Then with a single line fio to trigger the workload on a newly created
> btrfs:
> 
>   fio --filename=$mnt/file --size=4G --rw=randrw --bs=32k --ioengine=libaio \
>       --direct=1 --iodepth=64 --runtime=120 --numjobs=4 --name=random_rw \
>       --fallocate=posix
> 
> Then I got 101 transaction committed during that fio command, and a
> total of 2062 update_block_group_item() calls, in which 1241 can be
> skipped.
> 
> This is already a good 60% got skipped.
> 
> The full analyse can be found here:
> https://docs.google.com/spreadsheets/d/e/2PACX-1vTbjhqqqxoebnQM_ZJzSM1rF7EY7I1IRbAzZjv19imcDHsVDA7qeA_-MzXxltFZ0kHBjxMA15s2CSH8/pubhtml
> 
> Furthermore, since I have per-trans accounting, it shows that initially
> we have a very low percentage of skipped block group item update.
> 
> This is expected since we're inserting a lot of new file extents
> initially, thus the metadata usage is going to increase.
> 
> But after the initial 3 transactions, all later transactions are have a
> very stable 40~80% skip rate, mostly proving the patch is working.
> 
> Although such high skip rate is not always a huge win, as for
> our later block group tree feature, we will have a much higher chance to
> have a block group item already COWed, thus can skip some COW work.
> 
> But still, skipping a full COW search on extent tree is always a good
> thing, especially when the benefit almost comes from thin-air.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> [Josef pinned down the race and provided a fix]
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Generally I like this change, any time we can avoid a tree search will be good.
I would like to see if this makes any difference timing wise.  Could you record
transaction commit times for this job with and without your change?  That would
likely show a difference.  In any case the code is fine

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
