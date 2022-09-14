Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371725B875F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 13:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiINLmI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 07:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiINLmH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 07:42:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47E67AC3A
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 04:42:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bo13so8741173wrb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 04:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ljBV21/rt7xHP9hdJuGiN1G45ZLlbidyAGuNrkqe6Lk=;
        b=htDGENuQtq43qhmWgK7QIRMzYBo6296bz8Vfw5UgOVKZ1mcdLlzO99Kys9b4mbzGYE
         4DpKNNyMMJeUEPUvTkivHDmudn9erl8Xl5QVjIrvZjxSjlkpNcWcrLq7NqMqezjBFJ59
         cwiC7FtsOZESPb+E3lPsrCe/6DfsuS/zqHVNiXDQ7oB6WYaRGsY8jEvQs5HGRNYErn91
         /bxE6hl6HRLgl4dbe/rxfCiM5GKxQEs8nbbVUkBRhr3Ns9712JwjQ393UNHnFDAx9LR6
         tJyFmwqQZf6iIlSL0WaJBKA0bHpRHYUuBlWUR/tm18RG6me+1gj2hyg/OH06AhyC8lq4
         0KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ljBV21/rt7xHP9hdJuGiN1G45ZLlbidyAGuNrkqe6Lk=;
        b=cqczCCr097OqLJPBDmllnLpyo4VKMLRKGfeszjBes/e1bfhI71gznbg44PIjNOdjtj
         R/+QCGYk5+wBN3x+RC8TOBUVKt8Tji8/1zJGGxVZJyBbHRw4ujO07mfrphvW8i8mmxV8
         KZoiwSqpK15mHKKC+D8qcL2ey8YH2tMZhAtlDa0TrL2bMSZrnds9Qgot2hGx+/S8FpuF
         ecxigoCpQaYh8p1FuUJ9T6IGMO2e8FIw1l19VYoqjYlFNi0fvkfiRQeeaVAevwB8oTBt
         4cGoHUqA/pL3mPxMY5P8IooxValm9p9suaAYhqF2VoOCg2fVnVVV4ck6xtz54UiywDPx
         LhDg==
X-Gm-Message-State: ACgBeo36b/smdt0Qi+QsC8lrHVsdCwO/SGGD2u1sHRgLvuf7sfS2L/vQ
        RweCuMWqagK0t0jcDnsy/hObpg==
X-Google-Smtp-Source: AA6agR6IfcvPiHVBT59W7/ls00SW+xc7QmxOy9km38ZHpiVJXWOLMisG8CvkNAYucyBoYWbKMvVNgQ==
X-Received: by 2002:adf:a28e:0:b0:22a:7428:3b04 with SMTP id s14-20020adfa28e000000b0022a74283b04mr10099863wra.75.1663155724464;
        Wed, 14 Sep 2022 04:42:04 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b003a2e92edeccsm5210267wms.46.2022.09.14.04.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:42:04 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:42:03 +0100
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
Subject: Re: [PATCH 2/5] sched/psi: export psi_memstall_{enter,leave}
Message-ID: <YyG+C+z1n8d1Alty@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-3-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 10, 2022 at 08:50:55AM +0200, Christoph Hellwig wrote:
> To properly account for all refaults from file system logic, file systems
> need to call psi_memstall_enter directly, so export it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
