Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A985B875C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 13:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiINLlq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 07:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiINLlp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 07:41:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9138E7B2BF
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 04:41:43 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso2074318wms.5
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UQ6ki4yX5kQtVY1QftaIadGFPpTJFOi0It8Nz6sT1sA=;
        b=q/oyayVc8gtEqunNB1xJ3/FfxrAeboEzVVJSS32eCQHH7YkWiqGgc4DvqOkB0BmKB4
         EGBb59YfleXrHU3uhnARoWo1nkO+5gVkRg434+fP58rkbQ+KyzSzFEdZMFr+gIQUNJxq
         vNaGHKI6gzmX6l03osdo1ByMaXvFnCpGisqVbAa62a/tMQq7SKC2J88arzMPMDjYF36K
         5xDreZXRw+mz8OAlu6KXnu1yjwXtnaapCWAG0NQxDQmrAHbEmFBM9EVDoD7eLf/StPtW
         PVPtrMfMkfxUHkfJjD5j7HiSoRmkXQ3yJjff0qqwea5vgyNr/Dz+Fg3Y5dDOdpUikG5Q
         wIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UQ6ki4yX5kQtVY1QftaIadGFPpTJFOi0It8Nz6sT1sA=;
        b=E7EyhLcAnCmnHpByz9yV3dPDcOWDmpLUfPsegCC303OkcgaA6X63jqANlRgxREhTel
         771x/jGVnl52g6iYSWDySKPYgVF+i63UQ0XO69PfQp8RqBaV3a3UcsRb+fZNFZOR1heI
         llSBwxIw7513RpEEI+9/5BEnia0cNWtE8k0DahSfD5p55dkE0IngmqN9K8Ss4m0sQIYw
         XQU7jEkWIj3xeajgs4v60845k2j1UFgGCX21ylyxbhxcR5I2QMIByE9KdTNODVepJOct
         Dhd97Y4MZs7quSin5C7d+iv8TWg85BQoAgr/Vpk1TfAaRsRFFQcajLQvuHGVZf51xu9Q
         iGtg==
X-Gm-Message-State: ACgBeo3JPzH4l4ZY+BF21kDlPJOAmkbf8qrPJVZ0hQMA4JZ6NAjdVrFi
        3J/53wHG+o3tZ9X8XiWr59sIYw==
X-Google-Smtp-Source: AA6agR5iucBxgT+lWuCgOcqjgv1Qz0MJiMgw6JKNQ8nsLCUf51/5QiLnwph6LP3BZLcxpH7lhwgthg==
X-Received: by 2002:a7b:c457:0:b0:3b4:689d:b408 with SMTP id l23-20020a7bc457000000b003b4689db408mr2835029wmi.22.1663155702145;
        Wed, 14 Sep 2022 04:41:42 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d5951000000b00228dc37ce2asm13229870wri.57.2022.09.14.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:41:41 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:41:40 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm: add PSI accounting around ->read_folio and
 ->readahead calls
Message-ID: <YyG99D196Hj0/GgZ@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-2-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 10, 2022 at 08:50:54AM +0200, Christoph Hellwig wrote:
> PSI tries to account for the cost of bringing back in pages discarded by
> the MM LRU management.  Currently the prime place for that is hooked into
> the bio submission path, which is a rather bad place:
> 
>  - it does not actually account I/O for non-block file systems, of which
>    we have many
>  - it adds overhead and a layering violation to the block layer
> 
> Add the accounting into the two places in the core MM code that read
> pages into an address space by calling into ->read_folio and ->readahead
> so that the entire file system operations are covered, to broaden
> the coverage and allow removing the accounting in the block layer going
> forward.
> 
> As psi_memstall_enter can deal with nested calls this will not lead to
> double accounting even while the bio annotations are still present.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This is much cleaner. With the fixlet Willy pointed out:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
