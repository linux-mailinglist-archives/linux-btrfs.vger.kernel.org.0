Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC2542B76A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 08:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbhJMGgO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 02:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhJMGgN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 02:36:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FF2C061570
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 23:34:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y4so1156455plb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 23:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6VbHD8PBwfaj43ljVUZZGyMj52YEmx4jfqAsGhf6+JQ=;
        b=AvobKbPMrQUDEUEp6fPFubcGItxc/wnKkqnDSAjF2JOJIzD6GaHgOkeTfLVH2dVkY7
         athTU5gaBp9pQ5+vN8pGXUoM6NXB9m94GmbcWoYtzrCupD5haSLJb51jgUAYN2bie92y
         Cw/fWMm7nAHe57gHGr8VcvjTAn4+/uHsWTDDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6VbHD8PBwfaj43ljVUZZGyMj52YEmx4jfqAsGhf6+JQ=;
        b=0vCriJvmo2Fm3kVHLWqaUa/XLCeg5fGRoJT87AEsz5mzmzK3bU8Y3lr6V76sXz/avS
         Uo7RdRS29y0C0e64mDRVmvjf9u67ze3OcUvj27Cxwg1yxTzLoUeaF3VeVeSBxnM+85RW
         1HNCfqFFRfaZYnh9A6oJmbWXrZ1k16WZCvDf4xUkg50QHkySg0SFSYlocCk7Itufad49
         ZEH6NKF89gIifd8t/9RHS5qqMkTA+yld7SBe6Wj1E/SqluGG4qkFl13FmJ6AakEHytLa
         BqdqCsoEqCJQ9HnLTv9OFUTk8HsQpLV7uXQ3IdyTzboxCP48lKxFjLm9bh2Z63T75JOK
         Vn5A==
X-Gm-Message-State: AOAM531QVOX4YBrYJe4RENsfI2u3yY1/4Eoet/L1GZ0pFKd2Ql/L9Aoi
        j+1xAMCkynt62MEF4G/8PGLZBw==
X-Google-Smtp-Source: ABdhPJyCtmPDTqSGxs9iwHCnitZ1F86E6zXvgsm3yviJEZQtBzg0xs5Q4LZVn9iTvPOonDA6xdZ1cg==
X-Received: by 2002:a17:902:f683:b0:13f:2fbe:498f with SMTP id l3-20020a170902f68300b0013f2fbe498fmr18917273plg.17.1634106850602;
        Tue, 12 Oct 2021 23:34:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t3sm13004045pfb.100.2021.10.12.23.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:34:10 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:34:09 -0700
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
Subject: Re: [PATCH 29/29] udf: use sb_bdev_nr_blocks
Message-ID: <202110122334.7A3E933D@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-30-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-30-hch@lst.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:42AM +0200, Christoph Hellwig wrote:
> Use the sb_bdev_nr_blocks helper instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
