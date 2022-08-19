Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3156599FAE
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351096AbiHSQGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351462AbiHSQFw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 12:05:52 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B6510D584
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 08:55:19 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id y18so3636131qtv.5
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=GyRPd5nG+xnRgIh+ou2tvunNtRE6kLGKCAeo5YUvoog=;
        b=4KG1Laqihtn4oYKmErovBDlR3ZfAOaSeQJLLBtYfKT940DfxY4ZTj6mKAUUCt1MXvd
         wk+LD7c4fqslB0aax7R8pECKuRru3w9Y6RDuLKusrKUDX73GGkxZEiP9Ea/6A19XDrDS
         PMEKLW/uNP3UYYSAdqx/YZqvDNBeWHSWkRL5LVzWestfbBMmaWre7I+xwDWkhU3gDTsP
         +iZMNgLDc4nHHO9Zsw1612sdTKFapQGRlhVSL21cUdlkeCkcWxuaF0PqMd2Rmiw87453
         UynZk40wRHIKg63lBu8xu4i7QvtG833xHaNWJAtpI4rGvNbZcU/9ctRwuF2mQ2IoZAxd
         Akrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GyRPd5nG+xnRgIh+ou2tvunNtRE6kLGKCAeo5YUvoog=;
        b=fM9CD104+Zi5R0Rje6M5ZrRi0/Bjm2JjgKISazxc85/BfQVvVbqU4SKZfU2Yu0/Dov
         IN+Cu+wKaLwRKAWSJTVuqEPjX2IQlj48BomMuj++t0XTo0aXYfXRzsZ/d/8NeZbYll6F
         FvQ1c2N1s72VgRjpvbd5sI8j+bGBn/NAXwnhAz9cGriBTcO6BDvTEH8z9wEv9tYxX+Px
         /uNyiLNeFRqmeCB4iL/b26XO3lTPL5mDJAdA4o6hRzFP86ZJqa3vLQIbUPneG16fRuvZ
         0RLvaQLDzteC3wo6rDgw+b5s1H7h9Ag+dYiX94U5NrLfKxS3+Mgh36CRhSZUtbAcpjeo
         I2NA==
X-Gm-Message-State: ACgBeo3FhDGc8FjmLLI8NyDxRjOs1hdJfAn/AjSIQ3HOtKT/uXTZo96k
        uBHz5nWOvDOX3PdbxgKf+tia1Q==
X-Google-Smtp-Source: AA6agR4n7BxbqsEdeKo8Yom4RKthfiLylZS4i4zRD0tp2JE05MGat4k929Uuo8AmZ4b5ch/aJ5XKkw==
X-Received: by 2002:a05:622a:647:b0:344:6015:63ee with SMTP id a7-20020a05622a064700b00344601563eemr7096627qtb.346.1660924517110;
        Fri, 19 Aug 2022 08:55:17 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d22-20020ac86696000000b00342e86b3bdasm3242782qtp.12.2022.08.19.08.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 08:55:16 -0700 (PDT)
Date:   Fri, 19 Aug 2022 11:55:15 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Dylan Yudaken <dylany@fb.com>, Jens Axboe <axboe@kernel.dk>,
        agruenba@redhat.com
Subject: Re: [PATCH] btrfs: handle DIO read faults properly
Message-ID: <Yv+yY1A0msNqHG76@localhost.localdomain>
References: <552156d49d65ab7d635554b697252fdbfb8f93b0.1660251962.git.josef@toxicpanda.com>
 <20220812090208.GA2373742@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812090208.GA2373742@falcondesktop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 12, 2022 at 10:02:08AM +0100, Filipe Manana wrote:
> On Thu, Aug 11, 2022 at 05:06:11PM -0400, Josef Bacik wrote:
> > Dylan reported a problem where he had an io_uring test that was returning
> > short DIO reads with ee5b46a353af ("btrfs: increase direct io read size
> > limit to 256 sectors") applied.  This turned out to be a red herring,
> > this simply increases the size of the reads we'll attempt to do in one
> > go.  The root of the problem is that because we're now trying to read in
> > more into our buffer, we're more likely to hit a page fault while trying
> > to read into the buffer.
> > 
> > Because we pass IOMAP_DIO_PARTIAL into iomap if we get an -EFAULT we'll
> > simply return 0, expecting that we'll do the fault and then try again.
> > However since we're only checking for a ret > 0 || ret == -EFAULT we
> > return a short read.
> 
> I find this explanation to be terse. There's a lot of non-obvious details missing.
> 

Turns out there was some weirdness with the reproducer, and this isn't actually
the problem.

The real problem is that we would submit part of the IO since we got a fault,
and because we are async we'd get the short read.  I've sent a different patch
with the actual explanation for what was happening and a proper fix for this
particular regression.  Thanks,

Josef
