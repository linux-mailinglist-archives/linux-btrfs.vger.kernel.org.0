Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B3A5BE8D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Sep 2022 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiITOZi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 10:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiITOZO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 10:25:14 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E1A205F4
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 07:24:59 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p3so2342652iof.13
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=kNuOgpAqQ8sV4nxp51XLJgFTZcmbM6JC8PggK3tENzY=;
        b=vcwZfyi/GVEQh9PLiaZBaCfb3axRxqFoa5qooqIdBsrKT1H9uQ9yA9+FfFOl1fAXhn
         8vdYVWMazdyklD78k5EduRtORpnWn9dTaTpSB0M/bQlFPY+AdF4mSGlyz2Gl6AwxoUb0
         x5/nWtidvAfz9hRmJu6rSpODekRwAFi0LydR69xJNy1Dgd7lygGYTLPTtGyf7KKfYBL2
         EwoVb1n4BjLqmtGW/hi9uPhf9JOM3Gvs1zawSH4FWnfXt59kxshtETQ3XSTNM7nf9Gjw
         yVTI6+Cy6KcAUJGUHNyL9H+vpG2//dFzrd4RRFrywUxz7wRIoMx1e5Z1UFCCg3HFI/AI
         yO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kNuOgpAqQ8sV4nxp51XLJgFTZcmbM6JC8PggK3tENzY=;
        b=bq3ipRq4CEga0KST2CWFvL09SbLZHpWj3iR31eeQ2BOkKcIiFkcmOIlbZP3FCPCNnE
         bKGGmXik3gSdqb5kR+nEwhaKDFxFfIwAOKgWxaSLWVsFW+F1v3ujN7C5rIz8W0nsLQuI
         1nG8P23HjVF14Wr+2rDNS/8/RptFCpR6rFG9LQJmX+geN+JasuNjsqlN5upzNC1rDt8f
         iH0v8SBfDu5g7eDWAvfQkZX4otkxTJsvsK+4Lty8n8KHnoe6KRBN4iEEHXUo3KqKpKqP
         gTATVVGUolQikSzcQ//kEOxVCSyq56hvga2MRPh88Cm3CuRWyA+kOVgKFbLaPEg6HKNr
         BuOg==
X-Gm-Message-State: ACrzQf3+lT2ggn8WzGXX19Npg2+7XDRP12ekMGmrXTGPClReP0ejNI7K
        rfZuWScgFVxj4lWcyPZ3Mfz1uQ==
X-Google-Smtp-Source: AMsMyM6lLDHt5Deb231d56RrjImrVmLjcuUz4TFjco6WFvGiW1CQm6r2S1RJMyCkDqcGuD09M9QKYQ==
X-Received: by 2002:a02:c6d4:0:b0:35a:4ea3:4890 with SMTP id r20-20020a02c6d4000000b0035a4ea34890mr10491170jan.215.1663683899210;
        Tue, 20 Sep 2022 07:24:59 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f13-20020a02a10d000000b0035a9b0050easm5317jag.18.2022.09.20.07.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:24:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Suren Baghdasaryan <surenb@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Gao Xiang <xiang@kernel.org>, Chris Mason <clm@fb.com>,
        linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chao Yu <chao@kernel.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org
In-Reply-To: <20220915094200.139713-1-hch@lst.de>
References: <20220915094200.139713-1-hch@lst.de>
Subject: Re: improve pagecache PSI annotations v2
Message-Id: <166368389821.10447.12312122039024559092.b4-ty@kernel.dk>
Date:   Tue, 20 Sep 2022 08:24:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 15 Sep 2022 10:41:55 +0100, Christoph Hellwig wrote:
> currently the VM tries to abuse the block layer submission path for
> the page cache PSI annotations.  This series instead annotates the
> ->read_folio and ->readahead calls in the core VM code, and then
> only deals with the odd direct add_to_page_cache_lru calls manually.
> 
> Changes since v1:
>  - fix a logic error in ra_alloc_folio
>  - drop a unlikely()
>  - spell a comment in the weird way preferred by btrfs maintainers
> 
> [...]

Applied, thanks!

[1/5] mm: add PSI accounting around ->read_folio and ->readahead calls
      commit: 176042404ee6a96ba7e9054e1bda6220360a26ad
[2/5] sched/psi: export psi_memstall_{enter,leave}
      commit: 527eb453bbfe65e5a55a90edfb1f30b477e36b8c
[3/5] btrfs: add manual PSI accounting for compressed reads
      commit: 4088a47e78f95a5fea683cf67e0be006b13831fd
[4/5] erofs: add manual PSI accounting for the compressed address space
      commit: 99486c511f686c799bb4e60b79d79808bb9440f4
[5/5] block: remove PSI accounting from the bio layer
      commit: 118f3663fbc658e9ad6165e129076981c7b685c5

Best regards,
-- 
Jens Axboe


