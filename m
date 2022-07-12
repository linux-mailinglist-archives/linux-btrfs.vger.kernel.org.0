Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56286571D52
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiGLOwP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 10:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbiGLOwK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 10:52:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77A4BA398;
        Tue, 12 Jul 2022 07:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB9BAB819A6;
        Tue, 12 Jul 2022 14:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21205C3411C;
        Tue, 12 Jul 2022 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657637524;
        bh=DTpoBX/qQ/7h9wGaIdApkgpJtMwxfpNExs/uY3HT+eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MB1OfkHD4K3eXCbdYcA4zOtML5Ik3INgUnlWF6A6yimNWxN8YJXWsf0Or3V464FrL
         rieNoAyJ4sLNu4fT5t8PjdQVUbvv2uMk1z5nMt6CPFbFlLYUpWL4W0ofTCiWfhZj4n
         CC8szZrMuWSTUdW4Q+T87txQGI2KhjHEy/2eCgNoRvvERxowUzPpnSFn5iFet/uksp
         91SzKlHOmK4EYq5cSxULoAs21x3llm2EsTrYs2iVCd4QpJVelHIuInHrDMnOqhDnt7
         4yR9KJVfxhrURarcAuv8yfApXW/bdfdV2v8jV01MsiJahMB6CSx8QN0FaUnYZbvsaR
         EcUkGVlQCHxQQ==
Date:   Tue, 12 Jul 2022 15:52:01 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     bingjingc <bingjingc@synology.com>
Cc:     josef@toxicpanda.com, dsterba@suse.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        robbieko@synology.com, bxxxjxxg@gmail.com
Subject: Re: [PATCH v2 0/2] btrfs: send: fix sending link commands for
 existing file paths
Message-ID: <20220712145201.GA1074561@falcondesktop>
References: <20220712013632.7042-1-bingjingc@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712013632.7042-1-bingjingc@synology.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 12, 2022 at 09:36:30AM +0800, bingjingc wrote:
> From: BingJing Chang <bingjingc@synology.com>
> 
> There is a bug sending link commands for existing file paths. When we're
> processing an inode, we go over all references. All the new file paths are
> added to the "new_refs" list. And all the deleted file paths are added to
> the "deleted_refs" list. In the end, when we finish processing the inode,
> we iterate over all the items in the "new_refs" list and send link commands
> for those file paths. After that, we go over all the items in the
> "deleted_refs" list and send unlink commands for them. If there are
> duplicated file paths in both lists, we will try to create them before we
> remove them. Then the receiver gets an -EEXIST error when trying the link
> operations.
> 
> BingJing Chang (2):
>   btrfs: send: introduce recorded_ref_alloc and recorded_ref_free
>   btrfs: send: fix sending link commands for existing file paths
> 
>  fs/btrfs/send.c | 195 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 181 insertions(+), 14 deletions(-)

Looks good now, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Also, are you planning on submitting a test case for fstests too?

> 
> -- 
> 2.37.0
> 
