Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C533776082
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 15:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjHINVC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 09:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjHINVB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 09:21:01 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAEAC1
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 06:21:00 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63d2b7d77bfso45485396d6.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Aug 2023 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691587259; x=1692192059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7a6pRWDrY2CebBnboHchWauE9PVfOO4nEYu8g2GZAJU=;
        b=qKZUkSVYBkqlmhoYCsHNwOOXetBcBjh7JTLng1VZCs1bJ0cGL3WWQ7T55DKnep6Jus
         PGlrh/LoOfN7gHK3ieBYTIT5JDnXudSgWxf0dQ0V61a8ds1OR87UrOmcDpZsRKphVMKa
         kPGYSTwfTsRDJiTOfo6O2wh5rhaLOCb4dIsYXJglgjPbw5CAdv/7nqU/t119pXzVQdwa
         RCpl4HewJilnZ4QDQbQ1Vho8ZHUFXqiBf3zPgt9rBtCFkrMPckPVcqvk7KoNkAYInrg6
         qe5TK8zhCMG6ckgUH1B/vOLvfvCg0rU9SE06aG4UnKKyqX+nLi/6Too/hHFnKUtGVwY4
         ehAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691587259; x=1692192059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a6pRWDrY2CebBnboHchWauE9PVfOO4nEYu8g2GZAJU=;
        b=ByzJcI1n9tzYtv1C70Z35+leM/qmSizB6DMrHrTqLeUyBoEJkhBJC0yHjjDOkmjKM2
         FLSmMYtxFxusLEUzIU5BK94FXmKIFiuESUmMDOQq8AqbQ9dBhFWVpppycB7tLXu9QNg9
         amwj1w+KrvlJPCnxELp/q5pvFh90MC1mm30EpTiDRoyIQnnthFHZCEfjA1U3zyAvAk26
         rWjja+aqkzfZyhhqnMpCUS4MtPOJOHiNiinK0k9sKMg9qrz8ApA27adHg+y0I/fKShio
         HXcvgxg+lSkZN9cp7SjzVzypx/t5Bt2UfIvxnGv0/JdI3Qbt6yEDHNCKp53tWz7ggU1c
         TvLg==
X-Gm-Message-State: AOJu0YzX7dygs7aXH0yExPpLDHSciy4SucJzxMpIZNE6k1rBKnD8yE9V
        M50TF/Q7b7Y3HNAjshRGJhBMBtEJ+JBKUkjv0t/++Q==
X-Google-Smtp-Source: AGHT+IHCbCdW/ZsgTEyTMo4hWJA3dJLP5uR78CgFtfKWdbIbGKdbgkbtVWcO/ixkoF+WeILzfO/HDg==
X-Received: by 2002:a05:6214:d0:b0:63d:281d:d9cd with SMTP id f16-20020a05621400d000b0063d281dd9cdmr2325512qvs.57.1691587259660;
        Wed, 09 Aug 2023 06:20:59 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n17-20020a0cdc91000000b006238b37fb05sm4474135qvk.119.2023.08.09.06.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:20:59 -0700 (PDT)
Date:   Wed, 9 Aug 2023 09:20:58 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests/misc/058: reduce the space
 requirement and speed up the test
Message-ID: <20230809132058.GF2515439@perftesting>
References: <173e7faa9202a5d3438cd5bbdca765708f3bc729.1691477705.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173e7faa9202a5d3438cd5bbdca765708f3bc729.1691477705.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 02:55:21PM +0800, Qu Wenruo wrote:
> [BUG]
> When I was testing misc/058, the fs still has around 7GiB free space,
> but during that test case, btrfs kernel module reports write failures
> and even git commands failed inside that fs.
> 
> And obviously the test case failed.
> 
> [CAUSE]
> It turns out that, the test case itself would require 6GiB (4 data
> disks) + 1.5GiB x 2 (the two replace target), thus it requires 9 GiB
> free space.
> 
> And obviously my partition is not that large and failed.
> 
> [FIX]
> In fact, we really don't need that much space at all.
> 
> Our objective is to test "btrfs device replace --enqueue" functionality,
> there is not much need to wait for 1 second, we can just do the enqueue
> immediately.
> 
> So this patch would reduce the file size to a more sane (and rounded)
> 2GiB, and do the enqueue immediately.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
