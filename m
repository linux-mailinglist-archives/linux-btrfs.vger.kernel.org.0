Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129C359132E
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 17:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiHLPj1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 11:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbiHLPj0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 11:39:26 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD1673306
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 08:39:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l5so1029996qtv.4
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 08:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ZsMeDokHCA4X/aowVd+OzkJ4RoyQKfA9jtYdzIgHbP8=;
        b=gxmdRRo3gtxz5Xa1G866rgb/kp01hr/JxfTGyqfOtgc3QJBWshQH8C8529nkjryEKS
         +FJXkHTmewFm1p9Xo35/ucIS+9tLEjj34a9MpCOvPijSqoBMO3h0vrLFDYOJZeHXwt9Q
         zpeprxZ3Xns40OY3eZQapZj5e/nooEoVobW9FuakEqmTAY786M+cLkxTeVFmqAB3+cn2
         3YUK+kMDKi2dCGQtfm360ZDH6A0bnmacSH5p2RpPCFNie8MZDzPDFIFYPBiRx+H/lkhP
         F7lR0zwj5F4/TENPOMTTpGVCHd1BYwSD3RnHwwJuLGaJyVBoZmvh0WuNzDg1YXQt7Coz
         H+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ZsMeDokHCA4X/aowVd+OzkJ4RoyQKfA9jtYdzIgHbP8=;
        b=UqVfoAZXZnajPzqu9xuhYlEqYROvEyEFKmHWbT7pjuDXgRpMMu/VTAPlGby1HR3kyw
         0j/RudJ8+ioCF5VhUmcGwWVphdAKo9lINBjGMtIzEdS27/PBtXK+kYZ0kNdNjmpz9SS1
         llGmihcz2xSAOoSlAlkpX5Oek6aDx+sn8pRMfuJfCb1Dvn6z7A2GvuvxBTulSM2pTElc
         nMaLPYP8IhTms16W0EVR/9QbuBhXqiDKDB5DNv7j2h7bfAF1zqEiXpjHdQRspeF+JATr
         gBjDNwioJUwV0/LtphcYU8SHGoC+PNLT/Y+KbAxr34LSCUeMZF+Oz+yRUm4A0csqqU7j
         R5sQ==
X-Gm-Message-State: ACgBeo18u9gMaRifcHi3fJT4TjZCty9zG2SvMUppNHTCGKei25XtlqkC
        624HzSaiL5W1hacbQ1q9nCKk3Q==
X-Google-Smtp-Source: AA6agR7dGvSxqAupGe/D/5/g/uS1QZShKuQ8Wgu7oKPIzg4Zy9NV8uvbJVueSq5A+ybCWPnKzodDeQ==
X-Received: by 2002:a05:622a:5a07:b0:343:4e03:d5a with SMTP id fy7-20020a05622a5a0700b003434e030d5amr3971890qtb.357.1660318764597;
        Fri, 12 Aug 2022 08:39:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t30-20020a37ea1e000000b006b953a7929csm2013521qkj.73.2022.08.12.08.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:39:24 -0700 (PDT)
Date:   Fri, 12 Aug 2022 11:39:23 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Dylan Yudaken <dylany@fb.com>, Jens Axboe <axboe@kernel.dk>,
        agruenba@redhat.com
Subject: Re: [PATCH] btrfs: handle DIO read faults properly
Message-ID: <YvZ0K53zVv21mNVs@localhost.localdomain>
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
> So, at __iomap_dio_rw() we have this:
> 
>     if (ret == -EFAULT && dio->size && (dio_flags & IOMAP_DIO_PARTIAL)) {
>         if (!(iocb->ki_flags & IOCB_NOWAIT))
>             wait_for_completion = true;
>         ret = 0;
>     }
> 
> And shortly after, in the same function, we have:
> 
>     if (!atomic_dec_and_test(&dio->ref)) {
>         if (!wait_for_completion)
>             return ERR_PTR(-EIOCBQUEUED);
> 
>         for (;;) {
>             set_current_state(TASK_UNINTERRUPTIBLE);
>             if (!READ_ONCE(dio->submit.waiter))
>                 break;
> 
>             blk_io_schedule();
>         }
>         __set_current_state(TASK_RUNNING);
>     }
> 
> If the short read happens with io_uring, it means the initial request had
> IOCB_NOWAIT set. With the IOCB_NOWAIT call to btrfs, we were able to satisfy
> part of the read, submit one or more bios, and then we got -EFAULT when trying
> to faultin a page from the iovector.
> 
> This makes the first if-statement set 'ret' to 0 and 'wait_for_completion'
> stays with a false value. Then later on, because 'wait_for_completion' is
> false, -EIOCBQUEUED is returned to btrfs, which returns it and propagates
> it back to io_uring.
> 
> Because the read was not entirely satisfied, io_uring fallbacks to a blocking
> context, i.e. IOCB_NOWAIT is not set. We get back to btrfs and __iomap_dio_rw(),
> we submit one or more bios for some parts of remaining range, but then we get
> -EFAULT again. Then in that first if statement at __iomap_dio_rw(), we set 'ret'
> to 0 and 'wait_for_completion' to true, since dio->size is > 0 (we have submitted
> one more bios, made some progress) and IOCB_NOWAIT is not set.
> 
> This results in 0 being returned to btrfs_direct_read(), which returns 0 back
> to btrfs_file_read_iter(). And there we call filemap_read() to try to read
> what's left using buffered IO, passing it a value of 0 for its 'already_read'
> argument. Then there we get some error, presumably a page fault again, and
> return it back to io_uring.
> 
> And that's how user space gets the partial read?
> I don't see how else it can happen, so I'd like you to confirm that and update the
> changelog with a lot more details how user space gets a partial read.
> 

Sure I'll include these details, I left them out because it's relatively
convoluted (as you found out) and really the important detail is we get a 0 back
because we tried to page fault and it got turned into 0 from -EFAULT.

> 
> > Fix this by checking for a 0 read from iomap as
> > well.  I've left the EFAULT case because it appears like we can still
> > get this in the case of a page fault from a direct read from an inline
> > extent.
> 
> The EFAULT case is not related to inline extents.
> When we find an inline extent, we always fallback to buffered IO.
> btrfs_iomap_begin() will return -ENOTBLK or -EAGAIN depending on NOWAIT, so
> btrfs_direct_read() will never get -EFAULT because of an inline extent.
> 
> To get -EFAULT it means we are trying to read a non-inline, non-compressed
> extent and then failed to faultin the very first page of the iovector, so in
> that first if-statement at __iomap_dio_rw(), 'ret' remains with the value
> of -EFAULT because dio->size is 0 (no progress made at all) and inline
> extents always start at file offset 0 (so no progress may have happened).
> 

Sorry I thought I saw IOMAP_INLINE for our inline stuff.  We can get it for
IOMAP_HOLE where we try to zero the buffer which can fault, and then we have a
dio->size == 0 && ret == -EFAULT and that'll get propagated up to us, so we need
to preserve the -EFAULT check.  I'll update the changelog with this as well.
Thanks,

Josef
