Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD9D54ADCE
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 11:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbiFNJ4K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239637AbiFNJ4J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 05:56:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926193AA7B
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 02:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36E8561715
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 09:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B14CC3411B;
        Tue, 14 Jun 2022 09:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655200566;
        bh=WgE2VOPqmSv5mlbYfnwjxxEWREQ4Nj4sVWHJGy1PbyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVn5KlWDR9iWiW9W6FBbvKtkzcfBKsTekLq3Sclj8jSbL1VmJSUwNM8Ol+Vp6ACqZ
         f5Ur0qeVB7oMF4qSseTuoPTTxo6UDBZPNW8EJDmiJ3Rr8cEQvoJiCW5luZPXRinUjU
         +PonfCohYpBEzPBdRegPN+9tn9l0XeQpKB2op+HlnWbYUzjxSuQZe3duDb7DuUIvXw
         6J4bkKtPx3OoYC3YifmXoL4n3foKRsqVfBZQ/DUcR0tj/huo6i1QcAn8RsaHs4a0wu
         UT4ErFG5FCuCEE/i7RHTHsUtiogw+Mos4/qyIjg6aRgjjbobme29rpYP/5UjKD3Kma
         CGwQp6sAQfyrA==
Date:   Tue, 14 Jun 2022 10:56:03 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] btrfs: fix deadlock with fsync and full sync
Message-ID: <20220614095603.GB3886393@falcondesktop>
References: <cover.1655147296.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1655147296.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 13, 2022 at 03:09:47PM -0400, Josef Bacik wrote:
> v1->v2:
> - Make btrfs_sync_file also use the new BTRFS_LOG_FORCE_COMMIT define.
> - Adjust the title of the second patch
> 
> --- Original email ---
> Hello,
> 
> We've hit a pretty convoluted deadlock in production that Omar tracked down with
> drgn.  I've described the deadlock in the second patch, but generally it's a
> lock inversion where we have an existing dependency of extent lock ->
> transaction, but in fsync in a few cases we can end up with transaction ->
> extent lock, and the expected hilarity ensues.  Thanks,
> 
> Josef
> 
> Josef Bacik (2):
>   btrfs: make the return value for log syncing consistent
>   btrfs: fix deadlock with fsync+fiemap+transaction commit
> 
>  fs/btrfs/file.c     | 69 ++++++++++++++++++++++++++++++++++-----------
>  fs/btrfs/tree-log.c | 18 ++++++------
>  fs/btrfs/tree-log.h |  3 ++
>  3 files changed, 65 insertions(+), 25 deletions(-)

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> 
> -- 
> 2.26.3
> 
