Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF24D3BFC
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 22:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbiCIVXI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 16:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbiCIVWy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 16:22:54 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5558498F40
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 13:21:55 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id w1so3051622qtj.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 13:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8z4bh4gbDZJdzH6VtYV/aGvhYlGDDjsjDsZaTYe3Vjw=;
        b=Z8HnMQsz/LWpppX6SWv+2JobFbDIuqvHU1mWrf0G5+PFIWseG/6SGTp56qbQX59uxy
         Tdyp0AOXeI8t+DPuQ03cKR3I+rUryvCqrMjOf0sXI3kPbqefTrpm2XAv23GQa1bTkGzc
         jryBrEKi1xvkDuBW74WBfCKH62myOLIPSuwora2rztbC/vqg5dUEwJQYTgbcDTrgcaF2
         /m65H5DtCg7I1FEhtPIpDbBnsi4wLl/hwiqAcPPqdvXx1lNMGMOPHJ7+mCocDJlsUx0x
         21vx9fO5O54ENODB4aXOhjBuX6lDAkASKUdXZbk2gY+AjVlfUZ02ZvFDrq8kc1+SDOrO
         H58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8z4bh4gbDZJdzH6VtYV/aGvhYlGDDjsjDsZaTYe3Vjw=;
        b=ztZmWOH5QkNq8cdh8Izs+pclcPhxba0kSnpPpr3BMC0bwpCipG2SLWrxKYHRwS/C+8
         K95KQod8/4LGzkwjPy34wQkjfFnu7fM3QGgtx0ULVSng4FwHpH8g3cUmxwN0qLW0cCHw
         sjv/LQ6gYU82InLerkXv+Q6/ufyOhxqOHYrX9mq1dqGRAMgy2OF1E09f0DTEmdTivZoD
         Pfnze6+6xmmemBWYSMO741rhMbyYIliicpBShwzBvSARXrfq4gTk/Hz+TCENqAXJhZy2
         FdIRwgiJFC1Urh9qp/tbtLJHHdG2HlkGNNgxXbGeO3g+Yga4YChhwhXry0khQjtfVbm5
         +xkw==
X-Gm-Message-State: AOAM530EbT0c+3kjGkW3t3cmkPL2bL0fQ6P/+jDrdf3bLeprQ7pF3431
        ODvwqzCtCMS+liS+yVPrcQKDXg==
X-Google-Smtp-Source: ABdhPJxD8Of1kufsq1zexFAmrjdJ8qmlZ2eB2LI9HWxMsBHKUgYP6riOI74wxUiM3IgxJxS7BuTJOg==
X-Received: by 2002:ac8:58cf:0:b0:2e0:6068:769b with SMTP id u15-20020ac858cf000000b002e06068769bmr1393328qta.461.1646860914294;
        Wed, 09 Mar 2022 13:21:54 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k8-20020a05620a138800b00679fc7566fcsm1378849qki.18.2022.03.09.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:21:53 -0800 (PST)
Date:   Wed, 9 Mar 2022 16:21:52 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 18/19] btrfs-progs: mkfs: create the global root's
Message-ID: <YikacPd0uY6uozOZ@localhost.localdomain>
References: <cover.1646690972.git.josef@toxicpanda.com>
 <7cadc40e9f8510b8df5679e15881f2c0de70363a.1646690972.git.josef@toxicpanda.com>
 <20220309183534.GZ12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309183534.GZ12643@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 09, 2022 at 07:35:34PM +0100, David Sterba wrote:
> On Mon, Mar 07, 2022 at 05:11:03PM -0500, Josef Bacik wrote:
> > Now that we have all of the supporting code, add the ability to create
> > all of the global roots for an extent tree v2 fs.  This will default to
> > nr_cpu's, but also allow the user to specify how many global roots they
> > would like.
> 
> Why is number of online cpus a good default? Or how a user should know
> what's a good number? It resembles the allocation groups on xfs that
> are set at mkfs time and once the filesystem is grown the size remains
> but the number explodes and becomes problematic if the the old/new sizes
> are disproportionate. We have more flexibility in btrfs with the resize
> so we could afford to set the intial number based rather on the device
> size and then a rebalance after resize can adjust that again. Maybe
> there's something in kernel taking care of that, I don't know.

Right now I have no idea what a good number is, so I'm defaulting to NR_CPUS.  I
*think* this is a good idea because generally we want to spread the locking
pain, so hopefully NR_CPU's is good enough for most people?

We allow setting your own number if a user does the benchmarking to find their
ideal global roots number (*cough*Zygo*cough*).  And it'll be easy enough to add
new global roots since we tie the block group to the global root at create time.
Thanks,

Josef
