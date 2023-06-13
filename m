Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D75472D990
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 07:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbjFMFxL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 01:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbjFMFxK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 01:53:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295E9E7B
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 22:53:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b3be39e35dso20977305ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 22:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=slowstart.org; s=google; t=1686635587; x=1689227587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QovSxS0nJdC17IgGBXt6qXP1WTBApniRbnAd8XaKzGo=;
        b=dQp8fMs3yfWKW6+UsaIPNi/63p1tRBcNBWt18SUsPMTOrC6tCTcKkm7iLHVSCRwymg
         FfTlmfdDn4W5eWCWr4gPduyTkUCWmrDNSBpUvq6J4pKKuOz1UDTH/1sWh2nSy9IFgb1B
         5ALlEm/H4FFWK7t444HBfPdg/UdI76Rgj5Uiq0vu53kDvY7mIkAJveJcnveiigI8TPEs
         km6GL4H71/s7ci6o87aP/hF3kQ4FOs69snPt+rK0SeErm53ELWUDxL6ArWcuL0gT+HOn
         5JSExKpqjUAWaBuyNdR4UzmG8ylhchzKfQYaXNXhkZmjt4vQEfsmCEniymF+RamVmHmK
         Mlow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1686635587; x=1689227587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QovSxS0nJdC17IgGBXt6qXP1WTBApniRbnAd8XaKzGo=;
        b=qUx/28rL1diQqjFCLwLWFc4tLqzjuCikSlMsgB8EgdusnXabn7ztvHWBhpXK/jPLN5
         NtrwhoZJAE971MQsHaFFbCnbstNXwAtwlRVAkfadXxZ5k5RTzIEwI2XB5m8VUT4x0BLk
         pq3AUSCekPYvKIq/AXdseRDAJqWKqQ5BDy4Bo36/U7XK+tUQ+KHsakkPO2wLIxxfR9Al
         Zy1xunr+/xmt2q6/pdS8svYA8THEAiFuON0ka3TzjUB50d9zgaXtmgX8nYQMCFAfxfuC
         o22T811yZeqv6D84CgxWSUa7kBwThCSXcZnfTs1Q3LkTrDvkxB7IRwlRcKoYIeoSEV66
         Kvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686635587; x=1689227587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QovSxS0nJdC17IgGBXt6qXP1WTBApniRbnAd8XaKzGo=;
        b=STFT2COdHmjOZ2oHcM54lcW5o2wIEOAVvP9CfmYQp0n4o3KUrIft2b/B9cB3yQvUZf
         O2W438DQHFeJy9C0Ztz2BqJZqsMrtJi1nvIHs6vaSPhtvT+KW3cv6MrD3iPZ7EH0DlNf
         DuDaAgUSs08KQvvijgSXsZ9USdyTllyIz488Jwf+t57cd5S3BUuPW6+C1Wynr6K42Cuk
         W8VGGqrY5Vd5Luz+gU6ZZMIaZDFhJyf5LJv/IS1ApPYe1D0ChueaNTQNNFU5EKNhWIg5
         rhBQd1r1uFgCelU4s6POrJpwlUa5ky9Y30BUm+CCjApE2rdDgSh8gOjhHCzpAxngGRrY
         oK8w==
X-Gm-Message-State: AC+VfDw7+zuItwRFVzZ2utTPJ5hyPUCkiQo72Bp59FZbig5yfSvfmkjQ
        UI+kimMc4dczhiAQIJBtR2CphkRHAf3tRTsFun+cWg72
X-Google-Smtp-Source: ACHHUZ58yTZ3X2BQIdcrpHqBoYvAyJAbk87de6nyMk2Dut1RXOPYGlP5J94di8o5QY1Mxa6uuPXPYQ==
X-Received: by 2002:a17:903:22d0:b0:1b3:cdfc:3e28 with SMTP id y16-20020a17090322d000b001b3cdfc3e28mr6586701plg.23.1686635587429;
        Mon, 12 Jun 2023 22:53:07 -0700 (PDT)
Received: from localhost (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id jl1-20020a170903134100b001a245b49731sm7830982plb.128.2023.06.12.22.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 22:53:06 -0700 (PDT)
Sender: Naohiro Aota <naohiro@slowstart.org>
From:   Naohiro Aota <naota@elisp.net>
X-Google-Original-From: Naohiro Aota <naohiro.aota@wdc.com>
Date:   Tue, 13 Jun 2023 14:53:04 +0900
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Naohiro Aota <naota@elisp.net>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Message-ID: <jmbvm4co36av23vly5e45hhyeth42ebl5ulqc7uw5cc6qdu6bf@x7i66logd62j>
References: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
 <ZIf74wFg7NmvmQxn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIf74wFg7NmvmQxn@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 12, 2023 at 10:17:23PM -0700, Christoph Hellwig wrote:
> On Tue, Jun 13, 2023 at 12:10:29AM +0900, Naohiro Aota wrote:
> > This patch reverts the delalloc size to BTRFS_MAX_EXTENT_SIZE, as it does
> > not directly corresponds to the size of one extent. Instead, this patch
> > will limit the allocation size at cow_file_range() for the zoned mode.
> 
> Maybe I'm missing something, but that limitation also seems wrong or at
> least suboptimal.  There is absolutely no problem in creating a large
> allocation in cow_file_range.  btrfs_submit_bio will split it into max
> appens size chunks for I/O, and depending on if they got reordered or
> not we might even be able to record the entire big allocation as a
> single extent on disk.
> 

The issue corresponds to per-inode metadata reservation pool. For each
outstanding extent, it reserves 16 * node_size to insert the extent item
considering the worst case.

If we allocate one large extent, it releases the unnecessary bytes from the
pool as it thinks it will only do only one insertion. Then, that extent is
split again, and it inserts several extents. For that insertion, btrfs
consumes the reserved bytes from the per-inode pool, which is now ready
only for one extent. So, with a big filesystem and a large extent write
out, we can exhaust that pool and hit a WARN.

And, re-charging the pool on split time is impossible, I think... But,
things might change as we moved the split time.

Please check the original commit f7b12a62f008 ("btrfs: replace
BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size") and
btrfs_calculate_inode_block_rsv_file() for detail.
