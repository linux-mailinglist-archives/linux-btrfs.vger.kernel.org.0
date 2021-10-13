Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54B942B688
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 08:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhJMGO5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 02:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhJMGO5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 02:14:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A27CC061749
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 23:12:54 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g14so1547923pfm.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 23:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1H1JJFKjz05y5oj0p755Wd9Nps08CHOHEplJ5Y1g+2w=;
        b=FnlM9CdvccmU4HmqmwsZQ6mwcBwOhpuSMmvAcPJz12hGrzMLx0wE72HESKXT/FSdf4
         7+542Lua7V4TbazDGNap5DO9Pfw7c/uG+qyBy3qJkapOn+6ER85tMNMzt8DzCatnHQL8
         8qEBnbzhJGY53T8EWVA6JlX/GqGluU0pFlO7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1H1JJFKjz05y5oj0p755Wd9Nps08CHOHEplJ5Y1g+2w=;
        b=EQFXEi8LAkxSM5D2eSKNJvJVBRZHdobJqDjDjUlimPrpWpzVv2qJWpi30CVmcG7NCS
         yxzoeqsH8V2FCFjQHaCEuUQBv4aWlV7WOf+pdtd/YLuAQRZubxkF4koU6kMOnxGDm0NC
         T1KY4TV1e4up4tkf5yDiiIxaP5+48p/oqSDzL/sroNMlqPbBLAxSkeieAVTOoofscVx6
         NFXIvU0MFvdgc7Ye1GnsJrEfNhk4vVmTyQkyHV5/h35Sg+B9yFugTTLX6FHgPoWSag7D
         Ootvu/2DADxmeZOO755IN6tXYiplEWGarBAb+MEGfewRxmc8a0ItT2hqBKVomNOil8tZ
         WbRg==
X-Gm-Message-State: AOAM530P21oktMCQQTjc9E3Ydp+AZw7nJkePPbRJHTDjDxF0pj4n0B6S
        JbTGorsat3Bg84DQE8nJUJd0FA==
X-Google-Smtp-Source: ABdhPJyo2VCUKF6kjMdrI9PCDmpBjFpUCoF94Pv9htxPPsmjtX3akcms7YpvLn8ozHxuI/GsrlutsQ==
X-Received: by 2002:aa7:91c2:0:b0:44c:a5a4:43d4 with SMTP id z2-20020aa791c2000000b0044ca5a443d4mr35433093pfa.20.1634105573663;
        Tue, 12 Oct 2021 23:12:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z124sm12774767pfb.108.2021.10.12.23.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:12:53 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:12:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 04/29] md: use bdev_nr_sectors instead of open coding it
Message-ID: <202110122311.B43459E21@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:17AM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I think it might make sense, as you suggest earlier, to add a "bytes"
helper. This is the first user in the series needing:

	bdev_nr_sectors(...bdev) << SECTOR_SHIFT

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
