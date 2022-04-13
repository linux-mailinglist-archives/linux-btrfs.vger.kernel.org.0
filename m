Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FCB4FFC0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 19:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiDMRGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 13:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiDMRGu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 13:06:50 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4368C2CC85
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 10:04:28 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id ay4so1800384qtb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 10:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1gkKYNxAVgG9gQQX5FWE9T2WbQK+aJhhHh5HXzZzRl0=;
        b=w7xeujgfc6/s+pVCpi43xdN2zXWIeywTE/PU23T0RGboo9GoIm6/P+ByoBFbtMwokO
         hBO/kTpUb56/t2K185wI2q1XoGlHXCtnvqiShhYhB8UqT2XISWI4fi9j6mEK0faYoK3n
         3NunNAxTbHnkno41uqBZCyd2OIJJwxTzJ6+EEg307hAM6M2KZXwgRHC7WVV1r1GW4uc3
         IR+RDjwxOA2VBEyGb9bKfayPM8Ved+RK/B4UT0iVhwoJP8aAsYReWGBwHGhLBcdx/LvX
         lqENvGyinLuINCzgw+n7ok/hGVfs1mEcsZYyuxSIe7FHdGugX6QTVAlzsY5i6uVceAku
         t/SA==
X-Gm-Message-State: AOAM531clWjgt2vXXyeg9Xs6wBjR/7vkUwfSca3aUKBTqBPFX9PkufAV
        8O5QwNQdg5Wd896l2Izk7a5N
X-Google-Smtp-Source: ABdhPJzk8Hsy6b4fFdojSz0Z/fwMjicI2vghSEfVW7+AE/QcDDdQw502GSidyJJNTGoVWuUmwvp37w==
X-Received: by 2002:ac8:5e4e:0:b0:2e2:2bad:47b1 with SMTP id i14-20020ac85e4e000000b002e22bad47b1mr7781053qtx.493.1649869467355;
        Wed, 13 Apr 2022 10:04:27 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id a23-20020a05620a103700b00699d49c511dsm16089900qkk.104.2022.04.13.10.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:04:26 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:04:25 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] block: turn bio_kmalloc into a simple kmalloc wrapper
Message-ID: <YlcCmW0CLAFXB8UQ@redhat.com>
References: <20220406061228.410163-1-hch@lst.de>
 <20220406061228.410163-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406061228.410163-5-hch@lst.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 06 2022 at  2:12P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Remove the magic autofree semantics and require the callers to explicitly
> call bio_init to initialize the bio.
> 
> This allows bio_free to catch accidental bio_put calls on bio_init()ed
> bios as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@kernel.org>
