Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED9357A86B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 22:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiGSUnw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 16:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbiGSUnv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 16:43:51 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4570F599E2
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 13:43:50 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h22so12001043qta.3
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rFkkXw9XN+9ggtct0nikkj5q/EjcacuL+ZFgBRhkyA4=;
        b=olSsC9t+K6sHDcsHfvTkvAp/Bg9XdYPVWlBimiHoGowiQ5JgIzcmXTm1FC5ZXxFVBf
         1BgBO4xAtupTSu85bDZc8ObSgOA/hVEYVf9M/i0nl5mvp/zFHq2wzZGQY+fI+1DrT/I8
         X8Sl1pHZ+7jAsvX51jfAToc+DBPu9k/Tr8yEeKQ3VCxa96OCI2xkqbq7Q5uL1mWQ4Tm6
         v33Vg3Sx05N8KH1eJHStu4fIHuSqZGl2r7IvTPMb+1EZsGsdOEHr+bI5zk2iFBln7ufz
         aUD5bnfrZ2d+4AgyJ8eqI0EUnQC0YoXx2q+Sp6oytSgJbeYwSvjswqPHxQn2s2d/W2yK
         8Pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rFkkXw9XN+9ggtct0nikkj5q/EjcacuL+ZFgBRhkyA4=;
        b=ATareOztudqzGyIqDNGevLHUB3DB/be7Rt5WA8N+WkfEOZyyccfj42oBoXXwmsfDzf
         hZ0PRlyBrCz/ZChy1Pp5KYocMTFXr/dM8h5aQjsv19nYz95rm3f2C/AotBjEh6hvznz+
         G41diEUFdLP/JNPZrrXFATjuDtZOEzbMAPmoSIw3U6ioWl4ylpHErV7fy2nvXui7tzu3
         DHkGRBcrzLaVfFphuJ++xjMVUcOq224Xfxa5iEWR1/TATpS3ztoACYCUXcdDjX1k23PO
         9gKIH0ea/d7LDqidjsplw8AKJcC4zz3z6qJdU+aVx1u7MyyFGlUcDYK8Vg1MBFulh8N9
         KlYA==
X-Gm-Message-State: AJIora8x9pGnHPJ7SGPhQlADbooB+fQXg9lo///1owAp32PnMCT2buSB
        aRFTIhFqVYUIdxmDgrEloP+Gjw==
X-Google-Smtp-Source: AGRyM1soOsq5Jd5Fd6rRIh6t6DFq8KwVduUZUcgOgGwZmbkGjomg08eB9V7UPJCjfUhAkwszZi+F/w==
X-Received: by 2002:ac8:7d4b:0:b0:31e:f6b4:3ec4 with SMTP id h11-20020ac87d4b000000b0031ef6b43ec4mr6481738qtb.343.1658263429154;
        Tue, 19 Jul 2022 13:43:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id de41-20020a05620a372900b006aefa015c05sm14395719qkb.25.2022.07.19.13.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:43:48 -0700 (PDT)
Date:   Tue, 19 Jul 2022 16:43:47 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/4] btrfs-progs: support for fs-verity fstests
Message-ID: <YtcXgwUJhXgX0Ygc@localhost.localdomain>
References: <cover.1658182042.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658182042.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 03:13:07PM -0700, Boris Burkov wrote:
> Adding fstests for fs-verity on btrfs needs some light support from
> btrfs-progs. Specifically, it needs additional device corruption
> features to test corruption detection, and it needs the RO COMPAT flag.
> 
> The first patch defines (u64)-1 as "UNSET_U64"
> The second patch adds corrupting arbitrary regions of item data with -I.
> The third patch adds corrupting holes and prealloc in extent data.
> The fourth patch includes BTRFS_FEATURE_RO_COMPAT_VERITY to ctree.h
> 

Validated this made the verity tests do the right thing, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
