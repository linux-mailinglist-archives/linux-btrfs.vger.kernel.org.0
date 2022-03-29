Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D34EB457
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbiC2T7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 15:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbiC2T7K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 15:59:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C28BF58
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 12:57:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e5so18610655pls.4
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 12:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yIT4p7ShXHLUNOjV8CvgepES5xgtr9srlJOvqbKocNI=;
        b=kjeNyVLDw5gfpGN6mw79/GvJcQUnO9h4KG7JQXWW7+lMBvuE7+gpRGnoM9tHv09Qv9
         t2l3lEwvIoLb/JEa5uMXY2LTipPPBIBgtR+UiX4uOtoeAnzCROOS0e5tya/scJYnCTPL
         e0d8gYrRvsICGZMjGtanaku1+tmyy4ceY3YSr1RnDFPNKD3Rh2+0TbZgzAWAHGw/TlDM
         1bMrL0m33jyeKj8iwYCHUoMtOroc3r1Uc0pYHtQulZjZRKzFNdrssTorQDj4I/z7kPVD
         ZqSmsB62Lv0WoghLr31QWyoOFI513dDOm68umOnNz8WCRUC4fIPgqQf3K1FUKyqD6qeW
         x0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yIT4p7ShXHLUNOjV8CvgepES5xgtr9srlJOvqbKocNI=;
        b=kJDxvjK7+ukxPnBGErPrpBrUSnwowpjN4/3ngbUgm+Mr9RXld9UQFvUlMkD4r1ctwK
         KajMxlurV2j6kKFdw2apvLQv6hmW6brkV7oWKp9yTBmR9pOVCTgwivzcdVhCSiOKWGvO
         bIZYgoBs3sSoM5Q6+qqzpKUJAMSaU9GBTOqk2ht8+ksX4BzGoe+jJTXVi62NUE1tQa84
         aILt2Zo6ZLrT7WaJlqvCjVad3HxySzUqiijzbg2pitVFqON916Yare4O5EQ0b3qBWMGf
         eI+Nwc7xchVP+XaPv5NeDaCJzkO9Ymd7No5HcZ88p1TVWAd3NkL6UiC0JHHN9KsaDxWw
         6/9w==
X-Gm-Message-State: AOAM530GrjjyqTKYmDIqfAPG5D7eQxQeH7GbzRshFF2JVWbUnqbw1qmU
        alh4MW7O1uOw51kB4YQ+cR5LiA==
X-Google-Smtp-Source: ABdhPJxXbNP+DG2LiBZF6CN5/bbP5jCUmTbPtiuDEPEq6c1AqNZk16Ydy4+mvxb/OeMYAKyvPv7t1A==
X-Received: by 2002:a17:902:e0ca:b0:156:24d4:23e7 with SMTP id e10-20020a170902e0ca00b0015624d423e7mr6462076pla.13.1648583845945;
        Tue, 29 Mar 2022 12:57:25 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:421])
        by smtp.gmail.com with ESMTPSA id u15-20020a056a00098f00b004faa58d44eesm21890847pfg.145.2022.03.29.12.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 12:57:25 -0700 (PDT)
Date:   Tue, 29 Mar 2022 12:57:23 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, clm@fb.com, jbacik@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.17 12/21] btrfs: don't advance offset for
 compressed bios in btrfs_csum_one_bio()
Message-ID: <YkNko1BcsyDt2QUS@relinquished.localdomain>
References: <20220328194157.1585642-1-sashal@kernel.org>
 <20220328194157.1585642-12-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328194157.1585642-12-sashal@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 28, 2022 at 03:41:47PM -0400, Sasha Levin wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> [ Upstream commit e331f6b19f8adde2307588bb325ae5de78617c20 ]
> 
> btrfs_csum_one_bio() loops over each filesystem block in the bio while
> keeping a cursor of its current logical position in the file in order to
> look up the ordered extent to add the checksums to. However, this
> doesn't make much sense for compressed extents, as a sector on disk does
> not correspond to a sector of decompressed file data. It happens to work
> because:
> 
> 1) the compressed bio always covers one ordered extent
> 2) the size of the bio is always less than the size of the ordered
>    extent
> 
> However, the second point will not always be true for encoded writes.
> 
> Let's add a boolean parameter to btrfs_csum_one_bio() to indicate that
> it can assume that the bio only covers one ordered extent. Since we're
> already changing the signature, let's get rid of the contig parameter
> and make it implied by the offset parameter, similar to the change we
> recently made to btrfs_lookup_bio_sums(). Additionally, let's rename
> nr_sectors to blockcount to make it clear that it's the number of
> filesystem blocks, not the number of 512-byte sectors.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/btrfs/compression.c |  2 +-
>  fs/btrfs/ctree.h       |  2 +-
>  fs/btrfs/file-item.c   | 37 +++++++++++++++++--------------------
>  fs/btrfs/inode.c       |  8 ++++----
>  4 files changed, 23 insertions(+), 26 deletions(-)

Hi, Sasha,

This patch doesn't fix a real bug, so it should be dropped from both
5.16 and 5.17.

Thanks!
