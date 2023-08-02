Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4FA76D225
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 17:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjHBPgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjHBPgJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 11:36:09 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17182D7B
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 08:35:38 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58439daf39fso74360757b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1690990529; x=1691595329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ks5I/e5W3dyEgXAP1ywXlJ97w6735qiU5LcX9fBAbQU=;
        b=UHCgVbgAwUY6pZ1YuP1LDMszBc/7+3jeuYP9HYeZ4QCbJ4wrtStKN7wvuuD7ux3fwQ
         L89lLsHD/3oPf8D4nCojas5Z8tbF8hc5MHeX4138QX3/EI1OCJQoaNfrk4b/2XR2RwBl
         OObwo8Mnd3wVIB3Q8MkNaNpqPJX/CRr8KGyeadertFwwr8Guf/Oj9QYKp6ERPY8NmmM+
         C9OapmYuYeRqsD9RJJRn1FqeDUTmSReRKObQ4M66WV9S7fpv+mJuyFgEQm0Pd8r+WZ5R
         CIy1+LYvL9rvohBRT7eU8Evjse+jYz+FniaJzFPWs/JyXzJY3Apt94IbSzBE8NrP1QtG
         deAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690990529; x=1691595329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks5I/e5W3dyEgXAP1ywXlJ97w6735qiU5LcX9fBAbQU=;
        b=FH41ybM/w7b7T5ptsXRgCCqCj8Mw0UWrt9zK9Y9KEaIW75ROAKxUV93fFuvllZWKa2
         WUjzy4+SVvb4WuCUzieI4PVS6EfpBp/ssF4WvXziYPrMB7UBzKqHw9SEvy9WSGUjQElx
         /afCNthSFAt+ETv62lCCF/rgIOqKtdnJPZxdfUEBFynPRwjFc4FmdWNM1Jg7PDbJbPtK
         jaBxLAg1+Hu2si9/ylww1jaVPh5ptr7f+bOhMH81b3NzF2/qW/x/XFeBzjMi4rbPDZ+F
         Vtp1gGFfVzHFqURUyf8WL0kxddLTJ9aIe6XMb3D1ekDNHndrItUJ3xNqDxh8DoZybfnH
         +PNQ==
X-Gm-Message-State: ABy/qLbwCBq0nVuf1TSrg7OwMwZSFmYuYlLgChrw2lo5jubzRGEO0T5a
        /PyxApb1ljJzfGFFxcDWhod1Og==
X-Google-Smtp-Source: APBJJlHNbQyw0u0BRsUth5gaM0q5iJfofpwGsPFgIPEpcq86539OcoYrOvhE/ndZ7Z1fmoQEybLqVg==
X-Received: by 2002:a81:8a83:0:b0:579:e1ef:4145 with SMTP id a125-20020a818a83000000b00579e1ef4145mr16929414ywg.0.1690990528885;
        Wed, 02 Aug 2023 08:35:28 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q7-20020a817507000000b0057a93844c15sm4666800ywc.127.2023.08.02.08.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:35:28 -0700 (PDT)
Date:   Wed, 2 Aug 2023 11:35:27 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: small writeback fixes v2
Message-ID: <20230802153527.GA2118368@perftesting>
References: <20230724132701.816771-1-hch@lst.de>
 <20230727170622.GH17922@twin.jikos.cz>
 <20230801152911.GA12035@lst.de>
 <20230802124956.GA2070826@perftesting>
 <20230802151643.GA2229@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802151643.GA2229@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 02, 2023 at 05:16:43PM +0200, Christoph Hellwig wrote:
> On Wed, Aug 02, 2023 at 08:49:56AM -0400, Josef Bacik wrote:
> > I ran this through the CI
> 
> Thanks a lot!
> 
> > [ 3461.147888] assertion failed: block_group->io_ctl.inode == NULL, in
> > fs/btrfs/block-group.c:4256
> 
> Hmm, this looks so unrelated that it leaves me puzzled.  How confident
> are you that this is a new issue based on the overall test setup?
> 

This is the first I've seen this, so it could be new to for-next, your stuff, or
just simply haven't hit it in the ~20ish runs I've done with this new setup.
I'm going to go back and test these other ones with just for-next, but I wanted
to get the results to you in case they rang a bell or you wanted to debug
locally.

> > I also got an EBUSY trying to umount $SCRATCH_MNT with generic/475 with
> 
> > on an ARM machine with 64kib pagesize.  Though I'm pretty sure you're not to
> > blame for that last failure.  Thanks,
> 
> Yes, I've seen EBUSY in 475 quite regulary even without the changes,
> I think I also mentioned it in reply to the other 475-related discussion
> we had.  I tried to debug it for a while but didn't manage to get far.
> 

Yeah it definitely reproduces on for-next, I'm debugging this right now so don't
worry about this thing.  Thanks,

Josef
