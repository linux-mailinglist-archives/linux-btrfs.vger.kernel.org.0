Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D084066642B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 20:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjAKT4X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 14:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjAKT4Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 14:56:16 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887DE183AA
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:56:02 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id t7so11321667qvv.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VMsZQp1MZ/6pUsG7zhnZBNt3DAUOfqt66+3lz7aNsV8=;
        b=yGGBJQDHnQFeFNg3VR8AW4o6Ofs3P5YERYEdszrU9UWnUBPLU6LJAdElHBTuAKvyHI
         tY+6fTLcNeFhSnJXDSQYqLYMHw7d1v581yoncxY/XpQFZ8vNQrsDKDirSfnnLEbGePv6
         ZCTSQGuDgcvfMrG3vaj75KoC8xqx0+DF3Te60VdCwfGFaC1455i0+12QNaWK4GYg+8o1
         gCrQK4qOxM2AUuFOal3nrn0SqVIQ3PdPA7c50+T+Ca7AP7gKazeH6kpKKN9YYGyJkdOT
         uZqK1DEw0K+14hytqP+uAhxrxhyiXK79E+haH7G21wx4dfhbN5EMIRDoMQusXqeif+3z
         VCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMsZQp1MZ/6pUsG7zhnZBNt3DAUOfqt66+3lz7aNsV8=;
        b=59yZs33pd2ySniN3x/oMI0JvykdAv0ssEalRm5Bl5x2BxOFOK+FKQv6pWkNtdLK8Vy
         3BN4UkEI/YVCzwo+OtdEs5RXHC1FhCZUGSDBIHNIpnWSAOBpxfjKrIM1yFV8VZj0GEvQ
         gwA7ArYMDYQwTYosHMG7ojZvTvF58spWkZsn2rlLysBWDt2FtB1nIZY+z2VhaCdogtfL
         X+p9Udu4j9RmncRxIATvzVUFppEG4CI77NFODQYUWQcNOwFKOuLniN+HXBHcoM2tDfGH
         tBqtlCS/GCGewZ44kNCdfRbEZos/6xyXhJQaXs5MnXiUfYtAzsBGwtuTVI+s8VynkWCh
         6UgQ==
X-Gm-Message-State: AFqh2koGDG67JagUROKsnCZ//MkC6gKRlGEFtMqWy2sCLVO2wRSaG2V7
        xWczpvIrsP0yVnalyeg5o7wVaS055cgs7NA+4rc=
X-Google-Smtp-Source: AMrXdXtutqZbJR28Aq4xaBT3kyLULw1pewe5CwEJbWeFpOLUdCGHaTbrBXsDE9KB5xN+r/proV55BA==
X-Received: by 2002:a05:6214:1706:b0:532:25be:6b94 with SMTP id db6-20020a056214170600b0053225be6b94mr4259652qvb.29.1673466961796;
        Wed, 11 Jan 2023 11:56:01 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h9-20020a05620a244900b006cf38fd659asm9622049qkn.103.2023.01.11.11.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 11:56:01 -0800 (PST)
Date:   Wed, 11 Jan 2023 14:56:00 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/8] btrfs: do not check header generation in
 btrfs_clean_tree_block
Message-ID: <Y78UULaPJ+V1GiEz@localhost.localdomain>
References: <cover.1670451918.git.josef@toxicpanda.com>
 <ef73c4c67028f9e7d770dca236367f1ea0b56b55.1670451918.git.josef@toxicpanda.com>
 <0507a942-2a82-f086-2be5-a9ac64e4c1d3@gmx.com>
 <6f22220e-f660-92d2-5241-fb9a353090ac@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f22220e-f660-92d2-5241-fb9a353090ac@gmx.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 17, 2022 at 10:10:24AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/12/16 13:32, Qu Wenruo wrote:
> > 
> > 
> > On 2022/12/8 06:28, Josef Bacik wrote:
> > > This check is from an era where we didn't have a per-extent buffer dirty
> > > flag, we just messed with the page bits.  All the places we call this
> > > function are when we have a transaction open, so just skip this check
> > > and rely on the dirty flag.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > This patch is failing a lot of test cases, mostly scrub related
> > (btrfs/072, btrfs/074).
> > 
> > Now we will report all kinds of errors during scrub.
> > Which seems weird, as scrub doesn't use the regular extent buffer
> > helpers at all...
> > 
> > Maybe it's related to the generation we got during the extent tree search?
> > As all the failures points to generation mismatch during scrub.
> 
> I got some extra digging, and it turns out that, if we unconditionally clear
> the EXTENT_BUFFER_DIRTY flags, we can miss some tree blocks writeback for
> commit root.
> 
> Here is some trace for one extent buffer:
> 
>     btrfs_init_new_buffer: eb 7110656 set generation 13
>     btrfs_clean_tree_block: eb 7110656 gen 13 dirty 0 running trans 13
>     __btrfs_cow_block: eb 7110656 set generation 13
> 
> Above 3 lines are where the eb 7110656 got created as a cowed tree block.
> 
>     update_ref_for_cow: root 1 buf 6930432 gen 12 cow 7110656 gen 13
> 
> The eb 7110656 is cowed from 6930432, and that's created at transid 13.
> 
>     update_ref_for_cow: root 1 buf 7110656 gen 13 cow 7192576 gen 14
> 
> But that eb 7110656 got CoWed again in transaction 14. Which means, eb
> 7110656 is no longer referred in transid 14, but is still referred in
> transid 13.
> 
>     btrfs_clean_tree_block: eb 7110656 gen 13 dirty 1 running trans 14
> 
> Here inside update_ref_for_cow(), we clear the dirty flag for eb 7110656.
> 

Ooooh well that's not good, we shouldn't be calling btrfs_clean_tree_block in
this case, that's the real bug.  I'll fix that and update the series.  Nice
catch, thanks!

Josef
