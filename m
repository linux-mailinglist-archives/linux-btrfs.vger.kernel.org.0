Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580FA7AF3D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 21:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbjIZTIe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 15:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbjIZTId (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 15:08:33 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E6092
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:08:26 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77407e21d3cso598581085a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695755305; x=1696360105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLOwfeR5xU0JkWgHppZTnSrmVCHvBFEdyXxtN5C1UH8=;
        b=bZmk+AP2eSauXIYhG8vwx4LArdvrL38NBdJ+3u+JYibXZIa/+UQA42sJP8A6CDfuKT
         QSc4rNyCtmIYURAN6pY4wj1WyYcC+2YlsHfOtDezTx46Bf7QPyzMMzpb8oAg7PfjCh2d
         nbwdOIYILFcicI96HMt1AnXNOmOD9t2GpmeP+aPle/OKl2LldTymq8mlFeFOzvRMLIJz
         DaS6oDdL7uKWtfsjosnrUTfn26G3Q1vmMW7nXc5Gz0PVratgJkDt0Vdjl0CR1f/qlWaH
         z2QXah+C1n42OyuR4ezZaWhYye2d/r6yVe1bMPn95MDlkBxKMHcxa9f+qFIX+bx7M6Sg
         EKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695755305; x=1696360105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLOwfeR5xU0JkWgHppZTnSrmVCHvBFEdyXxtN5C1UH8=;
        b=FvDmAxPvFp/62vNcA+ZgTTaTBn+H3BWLxbvKUThHUtnKBqcdoXn1I4rA5MKn226JKN
         iUo9IRu1QpZ9SWxrP8nYK64xHMhxiq644zNdJ1F3dbtjEYBDqs4IS1yEjMXRMlY56MNS
         PMVQBY+kv3UeLTboaSblB/pcCmSxYO4yI2vHXqcZHnlIi3IrKeSiyJ4ypw8mwztvPmVq
         nMbXqhCvInC4uaefnbWqClFm+SEY8RNLyGkXbczpe+49LCyXE7wPl0ItcJM/q+G9VJsM
         /nXow2/JiWJ0re1buD+Cibtq3N8sJjPFGQBChdHLDZzkhQ8MKIvYwrSme4gJk7K/e3In
         ov3Q==
X-Gm-Message-State: AOJu0YzixROinHpsaQ4zjMJ0AxEe/krgh9WhNMiTbb65YkOpiMiKBmcG
        OWgC4sDuUSs6e/pFnTggNwTe6w==
X-Google-Smtp-Source: AGHT+IFfGkB9uJl9KKXPORqHqZ2V8U6AqL+BWNgp8UfNl741E2mQpaQcAbLBJHORevhlHWovOPS7Fg==
X-Received: by 2002:a05:620a:1a0d:b0:774:13e:71cd with SMTP id bk13-20020a05620a1a0d00b00774013e71cdmr13153634qkb.56.1695755305347;
        Tue, 26 Sep 2023 12:08:25 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x25-20020ae9f819000000b0076f12fcb0easm2199560qkh.2.2023.09.26.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 12:08:24 -0700 (PDT)
Date:   Tue, 26 Sep 2023 15:08:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Filipe Manana <fdmanana@suse.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [kdave-btrfs-devel:dev/guilherme/temp-fsid-v4] [btrfs]
 6c9131ed0d: stress-ng.sync-file.ops_per_sec -44.2% regression
Message-ID: <20230926190824.GA407285@perftesting>
References: <202309261552.a03eeb4c-oliver.sang@intel.com>
 <ZRMqjzDP/G+MKL5R@debian0.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRMqjzDP/G+MKL5R@debian0.Home>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 26, 2023 at 08:01:35PM +0100, Filipe Manana wrote:
> On Tue, Sep 26, 2023 at 03:34:59PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -44.2% regression of stress-ng.sync-file.ops_per_sec on:
> > 
> > 
> > commit: 6c9131ed0d644324adeeaccd2feeef8d04950b2d ("btrfs: always reserve space for delayed refs when starting transaction")
> > https://github.com/kdave/btrfs-devel.git dev/guilherme/temp-fsid-v4
> 
> David, can you remove this patch from misc-next/for-next in the meanwhile?
> 
> Starting to reserve space in advance for delayed refs is causing the slowdown,
> and I can reproduce it with the stress-ng test reported below.
> 
> By avoiding refilling the delayed block reserve I can recover about 60% of the
> lost performance, but that increases the chance in extreme scenarios of exhausting
> the global reserve and reaching a dead end -ENOSPC while committing transactions.
> It has happened rarely, both upstream and on SLE kernels.
> 
> At the moment I don't see how to keep both the upfront reservation of space for
> delayed refs and the refill of the delayed refs reserve without the performance
> impact on a test like that stress-ng test.

It's ok to eat a performance regression for correctness.  I think if you can
reduce the pain that's good, but going slower is better than not going at all.

Long term I have plans to make this better, stress-ng hilights the problem here
quite nicely.  The more pressure we have on the enospc machinery the more likely
we're going to do tickets and hit arbitrary waits.

What I want to do is take away the strict "we're over the limit, you now must
flush and wait" behavior and instead have something more akin to what MM does,
simply allow overcommit to occur, add the usage to a per-cpu counter everywhere
to avoid the spin lock contention, and then switch to the normal "ticket and
wait" system once we exceed certain thresholds.

Basically I want ENOSPC to not do anything until we're down to no chunk space
left and we're within 80% full in the available metadata block group.  This will
drastically improve performance, but is a larger project.

Until then trading performance for correctness is simply what we have to do.
Thanks,

Josef
