Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FA85B0BD8
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIGRyI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 13:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiIGRyI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 13:54:08 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64455B2492
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 10:54:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id h27so11063939qkk.9
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 10:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=crsgd12kREDdn4Z5CkQitLdcfYNnDp5ExCJttsFTe6k=;
        b=2ErPJwCX+rMbrZSatsDnWhtUSmQvlTSASo3PEsIFBrcyQXZIKBcdGGc568+XposyoI
         7ZK6Aig77VkmVF2YVzQNKb2OT2BVp77cp0KsjohYGgPYm5nW+vEabEGe5eyd6zT3jcDo
         8zsmxtqjymARBDYTjcRFcN9jXyqZy22NK58/S5U7ILgxxuua80nPNutDIO2bYcB9MFGL
         1Au00coPsYik4JTafK8FKi2fixLupS3+TdFZmp+dfs+bi8u1BrgTYouG4+gMogzt+Ckw
         EsDaxqBZaVmQU1tt9VMmkYohE/DWKBoTtezqu0SgHG5J9OGGdajXyfycG1/d2R01J4yr
         GoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=crsgd12kREDdn4Z5CkQitLdcfYNnDp5ExCJttsFTe6k=;
        b=dTXqWoCiU3xs/qNQaI0BQ9EBPueP/5Cxr7Gs9ua2EmiPWbdcbg15HpkbKE3trrAMTW
         u9X2W4AwsbDf5IMS+gdEHgKAflvi2N8LvMp0WaOnXNYv7GZQ4ZI05v4vUXefQbWa7Ch7
         ItjmGwD9NEoxclmbKa5oXLKQMflRKGqmu9QSlHYsIsw52D8FKopchvww/YVGpwpigae6
         orQwfAkLz0z4Kpma2SJJBaPO7Le0cOH4Dmr2NzLEMyS1Xer35jjwU83wPORi8ZbM1C0q
         0enEsKbpWMUqmMJTxVW8kQZUCNLDgQPqHX1XhAv9cq8Y6+Cj8UlF+IGiaqxq0Sl/u2Vi
         Qvpg==
X-Gm-Message-State: ACgBeo0JHVbbIZGpnITkintZIBnlxOpedoFqWePIzmdnKfIZQJUSQ72Z
        TkYm3gFbcpXLE1EmLuwlOJ+8DQ==
X-Google-Smtp-Source: AA6agR4TctpuYni4248jRQkhzrm1mMLjp3gL4Iz3UzzJvaigtRN3Bu7t2yYY+5JZ1peZFLqxKsq//g==
X-Received: by 2002:a05:620a:2453:b0:6c5:8569:771e with SMTP id h19-20020a05620a245300b006c58569771emr3419894qkn.45.1662573246392;
        Wed, 07 Sep 2022 10:54:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n15-20020a05620a294f00b006b942f4ffe3sm15723871qkp.18.2022.09.07.10.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:54:05 -0700 (PDT)
Date:   Wed, 7 Sep 2022 13:54:04 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/17] btrfs: move repair_io_failure to volumes.c
Message-ID: <YxjavEPSjFK/BqoN@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-4-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:02AM +0300, Christoph Hellwig wrote:
> repair_io_failure ties directly into all the glory low-level details of
> mapping a bio with a logic address to the actual physical location.
> Move it right below btrfs_submit_bio to keep all the related logic
> together.
> 
> Also move btrfs_repair_eb_io_failure to its caller in disk-io.c now that
> repair_io_failure is available in a header.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
