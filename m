Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2C42B764
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 08:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbhJMGf1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 02:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbhJMGfZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 02:35:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBEFC061762
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 23:33:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g5so1135231plg.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 23:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KN0hCxg4qCtDzIgJk5dwSpisgOtLaF48lTZLQMzdZGQ=;
        b=ZSgj9MSpSxiaNFjR5pl+MhsOPNs6TAo40lkstJ1+NMBhxL+4AoJC++ueHgXgDZsxkL
         A4rqeGya73qL9mbxIoCLhchn4/FA1cf285nRCQSnbarbdqSIQhxR7IZtW3h248WE8YVx
         CokTYsr+EOLC9mMcAUh/RiJhbXXJcMY50cpmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KN0hCxg4qCtDzIgJk5dwSpisgOtLaF48lTZLQMzdZGQ=;
        b=Y9gfQLZSdVUZXM0HgWWiYJxq+kgb0Xnq9N2bU2gyjHej4BswnUGn4dD8HsvLfM5B+a
         4v0Je56Ca/Goatt7kUj3cC/307WbSyoL+rAQ+gHIbAu6WUEoKMBf+aRnQ6mUnQP1Hxsx
         ODDnlRTvZ49Y/0cO5YdSJfBDFtBCmJSOe5aspeSfYbLHySNcTZs6PrgMrvq/0NgR6Zj8
         xHt01iTObMSVoFdhUhOfoxcluI7C/O4Y0ZXsx56kFh0DnyMzq9ghaHPEFV+tP7jYrF5i
         guNwetyI7g4CGVEbq13eT149lLGUETzCWE4+wixfMD9jOYBICZDSwTcIIhtdCCncNgb8
         aomw==
X-Gm-Message-State: AOAM530q67jE70ZsI60EUB15pdh8hAdjsqAlFTTHvndOIiTAVORScdxU
        Y6Y6KRjHfESqj6ijAlO4LzKfsQ==
X-Google-Smtp-Source: ABdhPJwSbdMnxpZNPs6DEcJzD+WCYFHCQcM73CXxNLIwDuWek8lOvAv7bQAbdyDz750VOQBh4gVb4A==
X-Received: by 2002:a17:902:e5d2:b0:13f:21c1:b44f with SMTP id u18-20020a170902e5d200b0013f21c1b44fmr23591611plf.30.1634106800893;
        Tue, 12 Oct 2021 23:33:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s8sm8887899pfh.186.2021.10.12.23.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:33:20 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:33:19 -0700
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
Subject: Re: [PATCH 28/29] reiserfs: use sb_bdev_nr_blocks
Message-ID: <202110122333.7CE920EB9@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-29-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-29-hch@lst.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:41AM +0200, Christoph Hellwig wrote:
> Use the sb_bdev_nr_blocks helper instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
