Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71DD590DD9
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 11:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiHLJCR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiHLJCQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 05:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8E3A98DB
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 02:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89E41613F9
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 09:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BBAC433D6;
        Fri, 12 Aug 2022 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660294934;
        bh=9SayaVB5nIAW5jIYByNCCAhAXb30TghILKA/CaduGW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cb+ud3VMVRSyBKIcsjZbzTN5ka+gebhy7LL796An8cavAPmx2eWzZiWldkQqs19hA
         QvqhcH+ObfcYPyO+wRmmwV86sGRiDucSFKl6rOfL0zSjNRUziNuxkoNVoE+fWOEHIN
         aHmkw89VyxyrE4oUhyyjHot4TAN8hbM5g2ZANdF1zTzjlLjjahFWfOGzBiR7oyu9Ie
         tguiefqLwm1z8doQbbHA9sjQvseazZ6F8ot7DUxPxvyKJZ4eOxgo3V0IHc0uEftGd9
         d1AxbWna6WvxbrIClIGMpTLgGGccXa7MXhRvV/hpJOKYSzhaxv2AtLVkLDfy1WUmHZ
         PEw2n9OnmwfCA==
Date:   Fri, 12 Aug 2022 10:02:08 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Dylan Yudaken <dylany@fb.com>, Jens Axboe <axboe@kernel.dk>,
        agruenba@redhat.com
Subject: Re: [PATCH] btrfs: handle DIO read faults properly
Message-ID: <20220812090208.GA2373742@falcondesktop>
References: <552156d49d65ab7d635554b697252fdbfb8f93b0.1660251962.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552156d49d65ab7d635554b697252fdbfb8f93b0.1660251962.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 11, 2022 at 05:06:11PM -0400, Josef Bacik wrote:
> Dylan reported a problem where he had an io_uring test that was returning
> short DIO reads with ee5b46a353af ("btrfs: increase direct io read size
> limit to 256 sectors") applied.  This turned out to be a red herring,
> this simply increases the size of the reads we'll attempt to do in one
> go.  The root of the problem is that because we're now trying to read in
> more into our buffer, we're more likely to hit a page fault while trying
> to read into the buffer.
> 
> Because we pass IOMAP_DIO_PARTIAL into iomap if we get an -EFAULT we'll
> simply return 0, expecting that we'll do the fault and then try again.
> However since we're only checking for a ret > 0 || ret == -EFAULT we
> return a short read.

I find this explanation to be terse. There's a lot of non-obvious details missing.

So, at __iomap_dio_rw() we have this:

    if (ret == -EFAULT && dio->size && (dio_flags & IOMAP_DIO_PARTIAL)) {
        if (!(iocb->ki_flags & IOCB_NOWAIT))
            wait_for_completion = true;
        ret = 0;
    }

And shortly after, in the same function, we have:

    if (!atomic_dec_and_test(&dio->ref)) {
        if (!wait_for_completion)
            return ERR_PTR(-EIOCBQUEUED);

        for (;;) {
            set_current_state(TASK_UNINTERRUPTIBLE);
            if (!READ_ONCE(dio->submit.waiter))
                break;

            blk_io_schedule();
        }
        __set_current_state(TASK_RUNNING);
    }

If the short read happens with io_uring, it means the initial request had
IOCB_NOWAIT set. With the IOCB_NOWAIT call to btrfs, we were able to satisfy
part of the read, submit one or more bios, and then we got -EFAULT when trying
to faultin a page from the iovector.

This makes the first if-statement set 'ret' to 0 and 'wait_for_completion'
stays with a false value. Then later on, because 'wait_for_completion' is
false, -EIOCBQUEUED is returned to btrfs, which returns it and propagates
it back to io_uring.

Because the read was not entirely satisfied, io_uring fallbacks to a blocking
context, i.e. IOCB_NOWAIT is not set. We get back to btrfs and __iomap_dio_rw(),
we submit one or more bios for some parts of remaining range, but then we get
-EFAULT again. Then in that first if statement at __iomap_dio_rw(), we set 'ret'
to 0 and 'wait_for_completion' to true, since dio->size is > 0 (we have submitted
one more bios, made some progress) and IOCB_NOWAIT is not set.

This results in 0 being returned to btrfs_direct_read(), which returns 0 back
to btrfs_file_read_iter(). And there we call filemap_read() to try to read
what's left using buffered IO, passing it a value of 0 for its 'already_read'
argument. Then there we get some error, presumably a page fault again, and
return it back to io_uring.

And that's how user space gets the partial read?
I don't see how else it can happen, so I'd like you to confirm that and update the
changelog with a lot more details how user space gets a partial read.


> Fix this by checking for a 0 read from iomap as
> well.  I've left the EFAULT case because it appears like we can still
> get this in the case of a page fault from a direct read from an inline
> extent.

The EFAULT case is not related to inline extents.
When we find an inline extent, we always fallback to buffered IO.
btrfs_iomap_begin() will return -ENOTBLK or -EAGAIN depending on NOWAIT, so
btrfs_direct_read() will never get -EFAULT because of an inline extent.

To get -EFAULT it means we are trying to read a non-inline, non-compressed
extent and then failed to faultin the very first page of the iovector, so in
that first if-statement at __iomap_dio_rw(), 'ret' remains with the value
of -EFAULT because dio->size is 0 (no progress made at all) and inline
extents always start at file offset 0 (so no progress may have happened).

I'm also seeing that gfs2 also doesn't retry if it gets 0 from iomap
(at gfs2_file_direct_read()), so adding Andreas to CC.

Thanks.

> 
> Jens tested this patch with their testcase and it fixed the problem.
> 
> Reported-by: Dylan Yudaken <dylany@fb.com>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index c9649b7b2f18..a61085ac59d6 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3776,7 +3776,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
>  	if (ret > 0)
>  		read = ret;
>  
> -	if (iov_iter_count(to) > 0 && (ret == -EFAULT || ret > 0)) {
> +	if (iov_iter_count(to) > 0 && (ret == -EFAULT || ret >= 0)) {
>  		const size_t left = iov_iter_count(to);
>  
>  		if (left == prev_left) {
> -- 
> 2.26.3
> 
