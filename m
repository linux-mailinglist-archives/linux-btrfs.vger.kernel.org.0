Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0784D8FD5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 23:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiCNWtS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 18:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiCNWtR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 18:49:17 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA802DF87
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 15:48:05 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id v2so5287711qtc.5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 15:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S7o2dSxhbK/V592hgD25KyPcTzLqcyz5/GiSQ174G04=;
        b=bGzpynH8nXOqpAyv3N19WF38eMepTCrRi+gtljFbfEMdvuMtddl8ADik/Vy/5aFgCR
         vgZ8uFtHRzPh5r092FDMGP1Fx22M4Gx+GvWKwz9Hp/Aq0MdbZam/k8NO++cFN2HAQMFe
         JCuhVXLRvqkfPiDRFfFUVggRGOxeMx8GpWfJ9NrifjYScYb6P/q/NsyReeYN3mMCG1pa
         gwX+FFs7IkNyC08gT8yxMBXj9l15Us4+TWj7qcWcImOcuqgI0Zkf2YhFPsc9vyej/qmp
         2ma6/rOq7kyZE/qXeyNiCSjrcgepjso9FldED5lvvFAmQ3MkwauAF2UKqx3PdrPVMO7+
         SxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S7o2dSxhbK/V592hgD25KyPcTzLqcyz5/GiSQ174G04=;
        b=ab9l8My4hZd61wgROB66Qfw5NYldvH6HJN6hKcM0bmsTLkrluJnncGAA5sSheoS5tN
         UYw+2S5Ed68t2QzRI12rkCk4PQ+L+4kpSQps8PyFIIbT+duYIR34cJ5nJhoS5ilvWvG5
         oONPFGEPS/KgLfsz0tdzGJgM1w7AOuSfK+JOL3EY9oF6UwNrxAe1lVqh+ur8CYrC4Sdj
         A17lQXcisYYs9uBoR3vpCWvROvxj7wP+u3odVzg1vNgTlhEGsWe08vUMDnPj0yYaOtpL
         lGq0PbI8QbsH1R8U+MCGKD/attaR5nSLSj61zJ7XTGwGn2ra61DlrrM+DHPgVEo3abOD
         NCrA==
X-Gm-Message-State: AOAM5318oU0ZpurA2e7qvbkdKC2tAT/tVjzu/fXmH122DjFBY2pOyG0h
        mHFuqBXdVOFtYqyw2HwUNJvivQ==
X-Google-Smtp-Source: ABdhPJyPgKQOCsTyvyRT7+YVf+0v7ENTVqgcTeeb7fdjkTe41vObtyXSnThFbhVLg3VFxxEtap2Okw==
X-Received: by 2002:a05:622a:1ba5:b0:2e1:a8b5:d772 with SMTP id bp37-20020a05622a1ba500b002e1a8b5d772mr19758809qtb.409.1647298084856;
        Mon, 14 Mar 2022 15:48:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o6-20020a05620a22c600b0067d247816eesm8352529qki.85.2022.03.14.15.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 15:48:04 -0700 (PDT)
Date:   Mon, 14 Mar 2022 18:48:03 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] fstests: delete the cross-vfsmount reflink tests
Message-ID: <Yi/GIxdFzfmzxdD2@localhost.localdomain>
References: <cover.1647015560.git.josef@toxicpanda.com>
 <3c6801168d8f7fd1bd2ae47f9a823d9c28a35422.1647015560.git.josef@toxicpanda.com>
 <20220314043724.GP661808@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314043724.GP661808@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 14, 2022 at 03:37:24PM +1100, Dave Chinner wrote:
> On Fri, Mar 11, 2022 at 11:20:53AM -0500, Josef Bacik wrote:
> > Cross vfsmount reflink's are now allowed, the patch is in linux-next and
> > will go to linus soon.  Remove these tests so nobody freaks out when
> > they start failing.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Shouldn't these tests be converted to test that cross-vfsmount
> reflinks now actually work?
> 
> i.e. it's all well and good to remove tests of behaviour we no
> longer enforce, but to then not test the new behaviour we allow is
> actually working properly....
>

Sure, I'll fix it up and run it through a night of our CI tests and then send
the updated patches.  Thanks,

Josef 
