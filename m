Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF83264BF1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 23:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiLMWI4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 17:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiLMWIx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 17:08:53 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD31C12AD2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 14:08:52 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id j16so1093903qtv.4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 14:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSbx8ctPQMwpxNLyur1alWpTx1zMtf9cf6qLfIraA7E=;
        b=vXPxLwyalsuKzDHmtDFc4KMpbroaI3UXum4oYoeYI+W1Vhh4Hj4OOk83PbJr6FF6f2
         AocVfdyntlM+W8douStU2Z2EXlN3U6/WQfIMRteckeP4ySxrbfgyZ4FC5LP9y1rcVgbq
         YE8x2o9zT99DtmNmkul/T30MvjXMTV1ZHh3xKSubE+07F8QoHSf5cVXotMZdmmcXJyRk
         ZeixO/+ht05h+358NTwZ3nlGXZpcmgbV/50MFlR9S/XH5+lAUoJk4qJmtstVSvB4YZfJ
         KZHCwZ5bNUWXrOPcDVQqRTfdpx8qwRWXJ14mCOyLrd6ye+/WlyXrb1wxPVcm/rzL/3da
         12rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSbx8ctPQMwpxNLyur1alWpTx1zMtf9cf6qLfIraA7E=;
        b=jnG8sU/xUIVU273yFe16lCwMohda1SorgO/MgkN5KhYTAhBrJauKpgrXmcv055firO
         QwacFe2fm5+RjloyKUaxUJdrf+iM939GVyuS2RktklY8lN/qWq2dM6/6zy5C9kZjiATt
         7uJBosQcXVZs04PBDJNPImDEcYSzbo4/IvR7y8KogVGeW64We7rv1skLoMwgKxfh8YTX
         yneB/SSIPiF/McQhPiNkgAPIGpB2jJu6aI0mxDL+zQ9MgSA6ErIooirQffBQk85c5R6d
         vrnGAH1Un8y9Dch8iwulNnSCnrEjGa1pyAhfga4p/5A9k4Vl9AB3HXK+T5YLlFx3Ln2+
         hsOA==
X-Gm-Message-State: ANoB5plVPxJfvQEVj70ufxAzfx1HdgxEsEuok0ets5mfD/YX5rebxqTv
        NVlSKVHFG2e0dnpHboEXP6l9MA==
X-Google-Smtp-Source: AA0mqf5D2Jx4htLB3SEX7zvOBC2dOkykdgRQnxKFdFz9eG1oRu/1xCwatz6QyJLBXAYLpElMeX6yxg==
X-Received: by 2002:ac8:141a:0:b0:39c:da20:f7ac with SMTP id k26-20020ac8141a000000b0039cda20f7acmr26982235qtj.9.1670969331764;
        Tue, 13 Dec 2022 14:08:51 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id m3-20020a05620a24c300b006fc7302cf89sm8868436qkn.28.2022.12.13.14.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 14:08:51 -0800 (PST)
Date:   Tue, 13 Dec 2022 17:08:50 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PoC PATCH 00/11] btrfs: scrub: rework to get rid of the complex
 bio formshaping
Message-ID: <Y5j38sRW7mZlAmZk@localhost.localdomain>
References: <cover.1670314744.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1670314744.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 06, 2022 at 04:23:27PM +0800, Qu Wenruo wrote:
> This is a proof-of-concept patchset, thus don't merge.
> 
> This series is mostly a full rework of low level scrub code.
> 
> Although I implemented the full support for all profiles, only raid56
> code is partially cleaned up (which is already over 1K lines removed).
> The estimated full cleanup will be around 1~2K more lines removed
> eventually.
> 
> The series is sent out for feedback, as the full patchset can be very
> large (mostly to remove old codes).
> 
> [PROBLEMS OF SCRUB]
> 
> TL;DR
> The current scrub code is way too complex for future expansion.
> 
> Current scrub code has a complex system to manage its in-flight bios.
> 
> This behavior is designed to improve scrub performance, but has a lot of
> disadvantage too:
> 
> - Too many indirect calls/jumps
> 
>   To scrub one extent in a simple mirror (like SINGLE), the call chain
>   involves the following functions:
> 
>   /* Before entering scrub_simple_mirror() */
>   scrub_ctx()
>   |- INIT_WORK(&sbio->work, scrub_bio_end_io_worker);
> 
>   /* In scrub_simple_mirror() */
>   scrub_extent()
>   |- scrub_sectors()
>      |- scrub_add_sector_to_rd_bio()
>         |- sbio->bio->bi_end_io = scrub_bio_end_io;
> 
>   /* Now it jumps to the endio function */
> 
>   scrub_bio_end_io()
>   |- queue_work()
> 
>   /* Now it jumps to workqueue, which is setup in scrub_ctx() */
>   scrub_bio_end_io_worker()
>   |- scrub_block_complete()
>      |- scrub_handle_errored_block() /* For corruption case */
>      |  |- scrub_recheck_block()
>      |     |- scrub_repair_block_from_good_copy()
>      |- scrub_checksum()
>      |- scrub_write_block_to_dev_replace()
> 
>   The whole jumps/delayed calls are really a mess to read.
>   This makes me wonder if the original code is really designed for human
>   to read.
> 
> - Complex bio form-shaping
>   We have scrub_bio to manage the in-flight bios.
> 
>   It has at most 64 bios for one device scrub, and each bio can be as
>   large as 128K.
> 
>   This is definitely a big performance enhancement.
> 
>   But I'm not convinced that scrub performance should be the first thing
>   to consider.
> 
> - No usage of btrfs_submit_bio()
>   This means we're doing a lot of things which can already be handled by
>   btrfs_submit_bio().
> 
>   This means quite some duplicated code.
> 
> [ENHANCEMENT]
> 
> This patchset will introduce a new infrasturcture, scrub2_stripe.
> 
> The "scrub2" prefix is to avoid naming conflicts.
> 
> The overall idea is, we always do scrub in the unit of BTRFS_STRIPE_LEN,
> hence the "scrub2_stripe".
> 
> Furthermore, all work will done in a submit-and-wait fashion, reducing
> the delayed calls/jumps to minimal.
> 
> The new scrub entrance in scrub_simple_mirror() would looks like this:
> 
>   scrub_simple_mirror()
>   |  /* Find a stripe with at least one sector used */
>   |- scrub2_find_fill_first_stripe()
>   |
>   |  /* Submit a read for the whole 64KiB */
>   |- scrub2_read_and_wait_stripe()
>   |  |- btrfs_submit_bio()
>   |  |  /* do the verification for all sectors */
>   |  |- scrub2_verify_one_stripe()
>   |
>   |- scrub2_reapair_one_stripe()
>   |  |- scrub2_repair_from_mirror()
>   |     |  /* reuse the existing read path */
>   |     |- scrub2_read_and_wait_stripe()
>   |
>   |- scrub2_report_errors()
>   |
>   |  /*
>   |   * For dev-replace and regular scrub repair, the write range
>   |   * will be different.
>   |   * (replace will writeback all good sectors, repair only writes
>   |   *  back repaired sectors).
>   |   */
>   |- scrub2_writeback_sectors()
>   
> Everything is done in a submit-and-wait fashion.
> 
> Although this will reduce concurrency, the readability will be greatly
> improved.
> 
> Furthermore since we're already submitting read in 64KiB size, it's less
> IOPS intense, thus it's already doing optimization for read.
> 
> Even if the performance is not that good, it can be enhanced later by
> using scrub2_stripe_group to submit multiple stripes in one go (aka,
> enlarge the block size) to improve performance, without damaging
> readability.
> 
> [CURRENT FEATURES]
> 
> - Working scrub/replace for all profiles
>   Currently only non-raid56 is tested.
> 
> [TODO]
> 
> There are a lot of todos:
> 
> - Completely remove scrub_bio/scrub_block/scrub_sector
>   I estimate that would result further 1~2K lines removed.
> 
>   Unfortunately, thus huge cleanup will take way more patches than
>   usual.
> 
> - Add proper support for zoned devices
>   Currently zoned code is not touched, but existing zoned code relies on
>   scrub_bio.
>   Thus they won't work at all.
> 
> - Proper performance benchmarking

I looked through everything, I don't see any glaring problems.  I definitely
would like to see a decent comment at the top of scrub.c detailing the behavior,
similar to delalloc-space.c or space-info.c.

I do not love the scrub2 thing, but if the entire patchset ended with
s/scrub2/scrub/g then I suppose that would be ok.  Ditto for exporting functions
that aren't prefix'ed with btrfs_.  If you're going to eventually come through
and clean that up then by all means do this, I just would want to see it be
properly cleaned at the end.

I didn't pay too close attention to the code, the missing parts like zoned and
stuff are enough that I don't want to devote too much attention to code that is
likely to change between now and it's final form.  Your design makes sense, I
don't care about scrub performance in general, as long as it's not unusably slow
I'd happily trade performance for readability and better maintainability.  But I
definitely want the performance changes described, so we know what we're paying
for.  Thanks,

Josef
